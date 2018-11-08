Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC04C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC06B20837
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IFMXD9ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC06B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeKHLu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:50:28 -0500
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:23606
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbeKHLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdV7vQlSeJsKJoPSOFpkdEjACFt4D8tIt2bRV8XUhGk=;
 b=IFMXD9ffG0uR2XUXgCb/CeZ5hdOzsBMhzm/M0CqkUneXDW1R2+FI43dqXnDchDCug1E0eISI//1W1dHGyQotrZwXpxkF92/6b41bKT2cI/BidRbxDNSIbBBF9MT6jV6XYPcWVRNw8TxzUFodBflwNm9uzwz9oVtj76alFuEfuIY=
Received: from SN1PR12CA0067.namprd12.prod.outlook.com (2603:10b6:802:20::38)
 by DM3PR12MB0746.namprd12.prod.outlook.com (2a01:111:e400:5984::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.23; Thu, 8 Nov
 2018 02:17:14 +0000
Received: from DM3NAM03FT050.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::203) by SN1PR12CA0067.outlook.office365.com
 (2603:10b6:802:20::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.20 via Frontend
 Transport; Thu, 8 Nov 2018 02:17:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux.ie; dkim=none (message not signed)
 header.d=none;linux.ie; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT050.mail.protection.outlook.com (10.152.82.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Thu, 8 Nov 2018 02:17:13 +0000
Received: from [10.237.40.91] (10.34.1.3) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server (TLS) id 14.3.389.1; Wed, 7 Nov
 2018 20:17:11 -0600
Subject: Re: [PATCH -next] drm/ttm: remove set but not used variable 'driver'
To:     YueHaibing <yuehaibing@huawei.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <1541643300-109641-1-git-send-email-yuehaibing@huawei.com>
From:   "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>
Message-ID: <b1283edd-0124-a6f4-fbd1-22707aecea9e@amd.com>
Date:   Thu, 8 Nov 2018 10:17:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541643300-109641-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(428003)(189003)(199004)(50466002)(14444005)(3846002)(6116002)(16576012)(58126008)(53936002)(305945005)(64126003)(67846002)(316002)(104016004)(68736007)(186003)(36756003)(16526019)(23676004)(76176011)(53546011)(2906002)(7736002)(6246003)(97736004)(26005)(77096007)(356004)(6666004)(229853002)(2486003)(65806001)(54906003)(31696002)(230700001)(86362001)(31686004)(47776003)(105586002)(106466001)(65956001)(8936002)(11346002)(110136005)(478600001)(4326008)(8676002)(81156014)(2616005)(446003)(5660300001)(126002)(336012)(72206003)(81166006)(476003)(65826007)(486006)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0746;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT050;1:kJLPrOg54YSrrPKnKrvu73dr2VjSWKUJVR94hvRieBtLGUQqlfUCSMOqvOw1ael9uxaqMqYGOaZ3OOFJwRC1RPp94nEv53S/UBxWl6rgQVdyMS/e5AvfSht7TuzHtsvR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 792d70ef-51e5-4b16-0ebd-08d645204c69
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR12MB0746;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;3:jfsYtx6uB8svG1pjZz8CAnJZ+eW+NbT+XumwQTSPdBO6x0g3MTuwkrv2dHMbbC5IXOhwcPSPiekLe6q9otaKp4MojY5GuSecx6WzXGgbu6dx84VPLcwO2RMnn70pwFwGw9Dx/Ij+EpT5h4OV2odnMTaCBwbs1tHbkLbqhW7b0IcrAOAxbcOlcGiH3OQJ1fjTC4SNY/g73Ll2/EnXl7jbVL7rH80sSNJ9haHqP3XYL8xyOuq9ce3HX6pycREXOzquPE7e5H5JYAF+yLjAD1g85GAbtzIQwu8MAAQ0kWdo1+wE8RrfaF1K5DSOEAlzqpmHSRBnwvkoBs9UkdP9BJYM5ScpIh8nU2/qhgrSUjmSpJA=;25:XynwneMtEOL1RNNOW6FN0tRMYsQ+buu39b3dMwN88PiIoNNnIv3BUZV4lU/vKvHMXvLmhgLewgOKuJ1j0L9PfZNiHSTL9Zw8yDJfESBuPHkDNFN6IXtYbrlCGmlD06LA/34sXVrS+t85+ItzAa8sFVaKxUsT3vj2qIWydtLNuryGS92CQKi85kk1QPhzkuBuYxtvYz3rOcwCxvB7xcN+jtxrtO8FavbmDJ0lO+89Wiw1q3cpKSrcZcz5TrXc0Qt8814JSkRaZEWp+NXYFGSzwTy6d2H4haOx/6zoasIrsJtZ6xFgs5sH0KO555kTXJJYhrUCv2xrep1wdwrzhw6Unw==
X-MS-TrafficTypeDiagnostic: DM3PR12MB0746:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;31:XEnwK470WcQC+WqTrs1YlKC8WcJMFKMhjzZEXA7npDwAcRvIXS4nHeFE2eUnHoJftNMJhZz4bWTkGZsAzY54RJ+l8oaeYw0wQEdF0ZqqSUqtxt2P0b5gy3nO4UZAdlIM7tgjOYY6Owcaox8tmDkF6BWOluWGPRL4QlGUhUmNX11xt/iJjhNhpCKJ2LbmCsEcZ6vYFutcGFTdcBxZs5x5wo6GC2gQl89+B3X+ytEwLc0=;20:1iWrpqH3ZTzXv3PfktOeOqV/KOPOM+l6o0x5C9siCzdcTaAlPXfdN9L4V8AZ7EioyYUEMmaVjDjC7ilP6oEgPj917Pv5pVP7GKaDChjwRNRsuXOHXdxFTRNA0dR+3is3DYswqkDZ4Dr18jRnbo4bNoRVrsdZ3zeezEcPmOyX3dzKVyVuqWhg/ZQ9sUez1SHV5PDi7qPkZwXGpGR/kH+O1NBBJ/UDOuktPZu9S3HGfHN7ATDNDuWcOHTj7ixsTO/KycZy4QZbioSfKTX6SLE2u+eVmc1FjKhMax2kNQVW5JjGPMneSNSopxGcncG7kzhKPuzG+xbWmiDMpLkNC4JybrV5mV93hsAOPUFPK4t0SLUNsRdADEgzG8nBuFlsC8a7KR/YPU/X2mVLyqvVQPpYzscy+tS1fpLN/MKa48dCo8yOA/7TyWd3yOx5gUQo0+rcRuDTBenMRlPUR7fwdX4fSQTxbkXX8/9lrvAUmhnI/HvJ0rLxWmZob1a4IY6uhRSS
X-Microsoft-Antispam-PRVS: <DM3PR12MB0746B432AB5D4EF0B5B944C4FFC50@DM3PR12MB0746.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM3PR12MB0746;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0746;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;4:Ia91bYSN6JEJEORSU5HzBqyJ9VGS9VSnSKYt7qdrpvGchuUrUxhwO2fZTUs2dhpgFJcGOIOlgZDWrKVBX3BkM+0OoxGU3/BlUF27uAIRJYzd26dEBuBqqgHDmATAFG+av09w5cNPv6xCRuqQb8PDMkJSdf61Ip64cycZjUQNTkEpKmJAmptCUZYvyg4p8cnSgroyeRcX6k9T1iTADTNv6EixJPNxn2EHsK8Tnrkyy3CkRGllgM95NoZwSwAy5o35ExZnUUC6Tn9eiF61wDDtOzyMCZUabOjSK/lwF57+XGezVs2DPDrCf3ZG5rHevQXn+TP3tv+Bssn2TN//tcOz8w==
X-Forefront-PRVS: 0850800A29
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjEyTUIwNzQ2OzIzOkQvYUdFVjczVnhNUTF1emJzWnhWMzhKM3RD?=
 =?utf-8?B?T1UzbmpFOU5zelI3ai9McUh5dmw3WGpYVk9wRXBnNW5TT2tMVENSSlFMaWRF?=
 =?utf-8?B?WTRZUlo1R1lzYmhDQzh1eGxTM2ZUclpXYk92emt2bzczbW1BTWpSdFd3U2xl?=
 =?utf-8?B?cHZTWjJHN1UydjJZNGpKd0EydWhNSFRlZGp2dUxHS3Rlako4elpZUUE2NHZV?=
 =?utf-8?B?U3dBNGdMd1loWlVCanR5bWRuRGhFWmdiOGkyaEkzbjNuWnJHYnZOM1p1ejJl?=
 =?utf-8?B?cDFMeVFka1VaMUNqNnNCVTdBU1BveSsxakR0TmJ5RVh4YU0rbEhBTERXVHo4?=
 =?utf-8?B?ZjR1WjFEbEVTNHllbWdxL1dJYTVZRWJpYWQvTEtUaDBiK3hldGQ0MkxoUE05?=
 =?utf-8?B?ZU5IR3RVU09yTVhMa1Q0aGxRbk5jaGRpUU16T0lhVGVJYnl5SGFxdTlrTW9x?=
 =?utf-8?B?NXlUMHEzT2IxeFB3dHN4UjZncWRRNGxJUmVyN0tqK0srQjlFSCtFN1N3dUpv?=
 =?utf-8?B?VWhVWTZuTXhuYzJNN3J0cllxQ29qdHNEZU5sSU94ZTg0b0RFMXZkY0M0VEpy?=
 =?utf-8?B?S1VweWJ4YUJoVysreFlkRTcvRGt3QW5Ucjd0MlBsYm1JdXBXQWRGa2RTVHpk?=
 =?utf-8?B?V1JpNzJHMXFGeGxKRTVMektBSlJHWEl2TnFBOEp6ZHZJenRZYU1yYVRsTmN1?=
 =?utf-8?B?UXpZODdCZGJCQm5ndUdIUjBEVlZ2cWx5Vm1CK3BiNEFyT0RxRGp2T041WXFt?=
 =?utf-8?B?UVg2UHR6cDU3NHVGc1l2T01ydEpDZnNXVi9nUDhQMFFXRFZ2QklFTjRJS3Fo?=
 =?utf-8?B?N1h6TGpkakdOOGJNQVdQYWRkQXBOUm9IQWZySXRralF3RzJLbmNvb1FSZ3R2?=
 =?utf-8?B?MkM4bnVSZ3BFcm13b0NkN0ZkbFc3Z2xQU0kxOHNDL0tEeU9qSDlnaDJUQ2Rx?=
 =?utf-8?B?ZkdiK25JOTFVZS9uNHIzbjluZ2tHb3FqUTVWNDVuaUJpQlFyajVWbFBxcDl4?=
 =?utf-8?B?K0xzcXBKN1hXakh4TzVPZW1wVjNZS2RWcDRFeTl4TUY0dmptclRPcG9EQ2hX?=
 =?utf-8?B?Ni9qY0tMeXcxdWFVbXpEZnJYeExlMU9ycmJHKy9TRThqTzNGMkNHckRPaGNo?=
 =?utf-8?B?NUF5MUlhc0JlaEFQWXNNVjR5NFZuV1d5V3ZkWGxaOTFoVERjWUxnaVNUSVlL?=
 =?utf-8?B?M3RGdWRSaDZ0eUhwVHUzSUd5dVlEY1N4TnA2M3FvWDFVUnFiTFlXYTZYV3lX?=
 =?utf-8?B?OTVXTTZ6ZEIyUUZpR2VEVFhSY0I1RlYzTzhkMDlGaUg1ZllZQVpVTnlwVzBI?=
 =?utf-8?B?cXQ5SXFLQkpmWEJZOStkZzZtL2dJYTNIWGNZVkhwVVU3eEtER3ZvdksvNmwv?=
 =?utf-8?B?bGhqTk1iOXlOMndLWHQ4OThvU2V2SkJVYVlIaUJzRlA4RmVJaDBUZStINjFR?=
 =?utf-8?B?aDh2WW9RMFBNQkZUcElqay9YNks3bGZmMzBUYVpzU2F2YktocVJYR1NGVHk2?=
 =?utf-8?B?UW5MVEFheDNMcEVXRkxKeXFGa3BmN0hHMEl3dHNGNjdsN2JDQ3dEK0I0SEFQ?=
 =?utf-8?B?VDN5S1JXMkhleElYelV5bGFIdFVrWTdQcFYrRVJRbGltQkZFandER2VOSzkz?=
 =?utf-8?B?Z3dGRnpPcTZiR3htZ0krV0R2Ry8xTFNDQ2VZRDFDYWpwMVlnMGdtTUlZTU5W?=
 =?utf-8?B?aWJYMElrNHFyVzJKbzd4d1BZUmU2NVliRHBIS2g2Smx6NkZqbkJEVFl4ODQv?=
 =?utf-8?B?c1Q2dkwyZ3BtSnBmWEUxTUhLVUVTRGlmVHE1cE0zRXNoUmt6ZUVtdTc1Q2RV?=
 =?utf-8?B?ZWRZaFd1MTJJclBxZ0Z4Z1p2U3krZGVUMDRoUTVxUzhock1XbGlrUEVPMzN4?=
 =?utf-8?B?V0didFBlWkNaY3RPRld0dzUrQlVFdlFZTHRnSWkyN21iWXFKeS8zYlFvWnA4?=
 =?utf-8?Q?qfYaEYxZB5aJNCf2ZGNwMFkfigM3oQ=3D?=
X-Microsoft-Antispam-Message-Info: 3/h+SZ6RtEXhEO8QYAvIPYFja1X3X8L9uZoJ+OCCmylthy70x6JzdciGf8E3fpDSJEalxaJYmdSrnbUzzkFomGvM80mHVlOhjWdJTnItwRFFf7mSj3x11dCdnSk31G6ZuTypHMYZ7Jw8NK35T2jx3rwBcCeew7lrvfl3qVUvegx0c7MTqx8XVN70C2JWJe+HE7GWhwHREFYfm1hrSfY6tUFRl0f5KA4sj2FlHD5JRSneVrQRoeS1lykV/TgRxqUqvB58poBkHiX4RgMLWd04n0WsG3Ai7mqiWYgly7xTPvNY0HO7VU91TeYjsEMdrHR236gZ9a+KrTcPXJGilpFZ2Pxp1M2TcHsBUrA2wfroNNg=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;6:Ai79sDUhZaaFb/1Rjj+6rMErfyrqbaC1yjM3dDkQZ4ME65tkqxolmxfLo4VwpJK2RDx++GJFAnqgYy+vxQS8k9K/mVV48oPXLXjruVjcj7YOfsNdlSi7Xk/6i4lcmR/Caf5btVzFMyjMe0QR1a6PDTz/a1paanLLQlpXJ7UzMOHueDojlL39axY1vGExcwFfhdKodtJc9dHNrwzfKmEhAdV3jXxNr6EAJkKK0/65so5GjOFlO+BS98hWwIesnIKJVsjYniz39KgVOasxV7auu0/WDmIb58JK46x12ALxzW2ublK7YnPova500MsgwMtwt33PbDjRWLevPzxc04G6G1AH4KyF9WvGvDk2UEMWHFzpBJQw357wfy3weqJe/w70Vk473OyAIQLP9BDOF9k7LvK0LZqx1lduS5r1FRAVRmZn3RpJ9wPMqpUjiwbE7JklGvsyirbdDVgNvJxihoDjxA==;5:YuvMzUkpk8kkQmz+sTQ/KmPjJ8ffvVSKhxLbTvBJAZ67xjVlRjEhKefngEGzRK7QZYC8Qx2uaMNlYruIg3qdqEBBHyMHIgvaYvYIUqoYszGZdvDqr9IVuPblg7Zzr9FCHQN6lD6RfWkfUYPsR2IGm7i4GWyuEbJMUC/uD6IlNmA=;7:xfBlWGPGsTrigb0KETnSiXARydlBbA6zQcAcA5YUfil8LBYSvstS3Hc2fvpDj8C9bztXP3QhXRobEXYk+GJzxNiwER8t2t6pN16bz2jTMGwM4zUWRJOrpm/B0QfRBWrjhXrFiMqBZTEIVbMObPPUAQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0746;20:5I6hBJguedb/d1pcd24W7wyP7GNtcBHG6BDdskk9qV3gTGm/fxi+xKuYb+a70w4uEQ0Djm/ZdIYiCp/95l6Ww9Dq2KMrol72l6ShuH/pgo1OdEfl73Uy6mr0ZXJIYuBEka7AuOjh2UdCTjDsjLyUG8ZQUxiA3KZhWw6Qbm0yTkFYgI3MAYoCo92rbAufDJbZ9xlgMo/1eonQQGUOpRh0FL2ly37w13noARtwWVG0SkHflqj5xxExG7pJqEOwlu2H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2018 02:17:13.9602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792d70ef-51e5-4b16-0ebd-08d645204c69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0746
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 10:15 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/ttm/ttm_execbuf_util.c: In function 'ttm_eu_fence_buffer_objects':
> drivers/gpu/drm/ttm/ttm_execbuf_util.c:190:24: warning:
>   variable 'driver' set but not used [-Wunused-but-set-variable]
>
> It not used any more after
> commit f2c24b83ae90 ("drm/ttm: flip the switch, and convert to dma_fence")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks.
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>

> ---
>   drivers/gpu/drm/ttm/ttm_execbuf_util.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> index e493edb..efa005a 100644
> --- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
> @@ -187,14 +187,12 @@ void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
>   	struct ttm_buffer_object *bo;
>   	struct ttm_bo_global *glob;
>   	struct ttm_bo_device *bdev;
> -	struct ttm_bo_driver *driver;
>   
>   	if (list_empty(list))
>   		return;
>   
>   	bo = list_first_entry(list, struct ttm_validate_buffer, head)->bo;
>   	bdev = bo->bdev;
> -	driver = bdev->driver;
>   	glob = bo->bdev->glob;
>   
>   	spin_lock(&glob->lru_lock);
>
>
>

