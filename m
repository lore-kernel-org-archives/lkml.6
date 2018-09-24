Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0882ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626FE2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lULLH9v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626FE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeIXOfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:35:07 -0400
Received: from mail-he1eur01on0133.outbound.protection.outlook.com ([104.47.0.133]:4373
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbeIXOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3sY9LGvrOrMy80OvxckvZjXiF8Xoy2iB1GTLowJxlI=;
 b=lULLH9v2W+aL8Yvh8Z47y9vdO0N9h+h681MFE4+YiHU4MTrK86WpuEDJaNrvaeOeP+/HOHobTZTuUapoNC2K5p/Aotqpm4X6DEwLsskQdtjRcnBd0kwJyJaDNAO/Ve5eBcrMOED66ToLY+2dSw5V4iZ3vkpUQbv2s2hzJgLutrY=
Received: from DB6PR07CA0121.eurprd07.prod.outlook.com (2603:10a6:6:16::14) by
 DB6PR07MB4199.eurprd07.prod.outlook.com (2603:10a6:6:50::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.12; Mon, 24 Sep 2018 08:34:06 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by DB6PR07CA0121.outlook.office365.com
 (2603:10a6:6:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.13 via Frontend
 Transport; Mon, 24 Sep 2018 08:34:05 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1185.13 via Frontend Transport; Mon, 24 Sep 2018 08:34:05 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w8O8XKQl010535
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Sep 2018 11:33:20 +0300
Received: from [10.151.73.229] ([10.151.73.229])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w8O8XKwo010529;
        Mon, 24 Sep 2018 11:33:20 +0300
X-HPESVCS-Source-Ip: 10.151.73.229
Subject: Re: [PATCH] tools: Remove conflicting BITS_PER_LONG define
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
 <20180912190107.GA5502@redhat.com> <20180912192129.GB13738@kernel.org>
 <562288b4-aac6-182a-6f75-23d32dbdcad5@nokia.com>
 <20180919130318.GB3717@redhat.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <b9a95224-ece8-a23b-e759-48d3f89b3067@nokia.com>
Date:   Mon, 24 Sep 2018 10:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180919130318.GB3717@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(438002)(189003)(199004)(81156014)(81166006)(8676002)(305945005)(486006)(126002)(106466001)(36756003)(186003)(356003)(476003)(54906003)(26005)(86362001)(47776003)(6916009)(44832011)(64126003)(58126008)(8936002)(316002)(65826007)(31696002)(77096007)(2906002)(229853002)(230700001)(31686004)(106002)(478600001)(446003)(76176011)(26826003)(97736004)(6246003)(4326008)(93886005)(2486003)(14444005)(23676004)(22756006)(53936002)(11346002)(50466002)(65956001)(68736007)(336012)(2616005)(65806001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB4199;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT037;1:io1UQDo+w7ZR+47zbIXm6ZWMsIu7dDhDct52qT43NQsoZFu7bcH//ceyZMCHFE80YkKiAW3NCb5nGKZ9ZM/JdWh5b755IdG/gYAgOytJpAZAxwQARGW8J8wUvJhgPYef
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e789c34d-8bbd-4cb9-af95-08d621f87d54
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328);SRVR:DB6PR07MB4199;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4199;3:RpOa6wXjqH+I+Rbxuz1WWmtwFyn+44LX8PbF0awQcW3f2sO/NA/8gDiyaAfEvFLAWR9o89yzZ1EbVc1vRtJM6UZd9LXKJwYVjr7nHcff6qlfuB01O73g7OkEEu9+dWrT29Qg5keiDusig8wIKLMbNEo9fAKdWx7UwJTAVyUHbE81rImB/BleaPhVn0Oav2JJOewipFVIfMInqMy5EZmkcSZCkNES79PNWUyVTmm03MJkrH21o46v45TSHJUldmEegJRiLBn4uzFpAV0/FleBmEyaDJDR4iZ7OJAGbtJ4ry51GL8MyvNK/ODkkcTd0toD8+mCmGCOt53+ZzvvXqLHl4ZyEOWOE0Kw+6dseKWhZQk=;25:RbVdVfkvjuGx35qnuNtzn3ziXf4usFOuEC2Dawti9za2lS2UI6jOt8iccYEz5P/6wmBNso+NQ0QKaWmb/peTHVqBtqikA86WlhDloCzUHY/VF1LL3NOiRGk5LPeE5MIrrvh9vOUmuqr4R1nxeCXfNqws9TutboW6pOmDQTcs7DP+//ipCyrITwMoCvAwCVjBXgQf2ij/lgDQyIEN4I947eJnYUfDBRMxKx78b/nVv/0YG9MqiW7qHgRTaeOhjwkROgnn8mahmeuOTieIQoskgCNjrySFO/0lXu0PmCEthx65DmGIOnwKm3uCk/IXLTAHaW82SRtikOtJSH1rADZUyg==
X-MS-TrafficTypeDiagnostic: DB6PR07MB4199:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4199;31:HoNEkJ9+/a+n8+yRhypZ3fYoGJLOI2TUNHEII1t5+kxlSnOpeRKaSO92nA/aHruB0VUrukYUYDXb8AH3RUWdDXFJ4mOBJ9uUAMJA0gt0W+zzVLz6Evu00niCaQc2vhLuv84ge34/3JT+XnnkW/2SgxJbpBJ7hBT7ATmnsggkjQNshL1TUGhDcIkBWaTPpRdECjRWX7zwdNiOQGeXrGc/ml67IiXsQTrMnS1OMPjAzUI=;20:UNFZWzrnjaMKfY8wlGZUfOh8mMW4jkRIS+jCWjRnXbJ/TwMK/s5nJNU0z5qiFEKnf4aSkqV3h7+NCKvG7NPfdZy03AX/hBFDy531cJS2N1DJWbvFx3u+Cz4aYw7BoHGjkMgeOxQY/OYJPCSUtVFbYp2kHakT6qD0+5nVZRsM0O66HUxq6/F8S/O1YC/7eRcUIyDbiuN24cmYu2ZMYnjsB9rLYIpT5DgSDr8LZHpRe9KPg17sXjiVE5u+TQtokpZNMlxObyGhrcI9TeFRi2Q+KYvx2chU5HFuTEMKseWc5j8o0DTppduNIaRMFfyKNGgYeEEpCaEHQUxUiatXP6dgn0bRNC0s/Go5IcQZ8EJtY/krUWR7Ui5IRPOxRa1ZB17v3fFKku1af3IebOMy4ZtLGvcwbKGALv8/jUpsonyKk79MmirjOjvLl8tkfk9KHEghcMZfsIQNFEzTjSGHx0aHsgMCM8DF5QTJVfg9EU4/UhgCjRVyBm8XzUiyRx6Qs2QU5zHXxJW86W1DzEuiLkLZQa/IBP35d+xaz9eNfIFsz00Dn+gZk8gl4137g4EGBflttUJ1vN34Jndws70MLrOSJQGo4cGzgTDs4qGZfKIbB68=
X-Microsoft-Antispam-PRVS: <DB6PR07MB4199B3DCE1D8E7578BFAF7AE88170@DB6PR07MB4199.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(11241501184)(806099)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DB6PR07MB4199;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB4199;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4199;4:dtlZuG7Gu9dDRqg8PiO8CWiq8FgEwA4uYC7hGiuJVbJmT6nN5/lrGmDRyLnFQHLXm3fYI2M1lKcQqGJxFhts7lJmH1qoMSD5aZMkfTK2A/m0ndxnRGLo7JDtD3GNk+2yRFtrjOOfadlp0Q6wbjS8EbvRVsBLuOlFZGwe1ZDGoWVrK1MmXim6l+043SzEXRgLZIRhDj4EmUPn13WHkWBCO9P9iWxdV8p/Qe7mIWTiz26zyJLudhRZ9OuG5YIlzT6e94haiyox3io9ket6yq1v1w==
X-Forefront-PRVS: 0805EC9467
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3TUI0MTk5OzIzOk5rU2FzcGhuUEdJcU4vOWdpZjN6VnJiYUUw?=
 =?utf-8?B?Wk1RVVU5YlJ4aGJKK0UzenA3SHBRek9rZGpGemF5cXZFQ1oxV01kMGFITVhT?=
 =?utf-8?B?SWRxRWU2NmxhVkM3UlV2d0VSNy9VRy8vMklQUG5MSjN3U0pIQmdxMHpBNEdo?=
 =?utf-8?B?TXRTQ2g2SEV6WkRmdTBxdXZDYy9VdnZtTFpjRFUrd3BDR2ErbTUwQnFBU01Z?=
 =?utf-8?B?RVN6bmh1by9yZUhQUTk4QmZnL2YvZGtOanFyNzJVcWhDQ2NkQytvTU1SOE9p?=
 =?utf-8?B?YklmZDdxZ090dnY3SlJLNzYzZXUyZmdMQ0tzdzhUaWsxb1pkcWZGTTBwQ1hQ?=
 =?utf-8?B?RVdRM1Z6bFk4LzQ2aDNIcjFERHZNSDh0L0NWMnhMTG41VzFsdWtvY091WnZq?=
 =?utf-8?B?Zngva3Fkc3RLUWxScmJyU0RheHVxb0IwcktsZHByeFhMcVhCV3hxRHVMYjA3?=
 =?utf-8?B?UVBqeFo3dWYxNFIwbEoxV0xuT0xKL2h4di9JQ2EzV2k2K2pQdkRXU21Fc1Vu?=
 =?utf-8?B?emJyUnkxUTJvNFJzL1RVc1hHWGZWeG5DZkFPTiszdXhRNStTWmpoS201YTFE?=
 =?utf-8?B?UC9HcWpBNEhoMG9BempHNSthQzJvV3p4R2w3djJJU1BUWFByY1pVdXQ4VmUx?=
 =?utf-8?B?M1I2TkxNU1ovSUhhdklRWDdlZFZabXAxNG5VZVp5QzJiNHlmRWdMdDdvS08z?=
 =?utf-8?B?NjVqSHRTK1VLL3JacTRGS1pnYldVREc2TGprQjVJcktQd3ZBeTJQTmJNRjRv?=
 =?utf-8?B?U3Q4clM4anVXSWlZQ2VudDdHZlo3NUtFZU41bGQxMUZxcGh6Rk0xcjlMUlVT?=
 =?utf-8?B?Z1BPanZzWWwwbTNkcGNiZFZCdGhETTY4RHhVbmdkU1N6UFdabkNhWlU3aXYy?=
 =?utf-8?B?dmFIZml6TkZHUS9nbmdSclpRYjVlaGgvVVc2aEtGL1JVQjZybFZMMCs3UmtM?=
 =?utf-8?B?STFpSFBDTkM0NHoyTzc5cUlDOWttRHRPYmtUUWhyeFdNRHhRQmsvOS9TQVRJ?=
 =?utf-8?B?emc0ZmY0NEpRcVFIV2FUQW5CR1FMc05RYVNsVnpMeVczRFFhWU1iT2dqSlp5?=
 =?utf-8?B?T2Nld0p6S0JQUHlPb0VqbVpTZzBnMU9SOXFtV3kzK1YxdzE4NUtsVFpwTFpY?=
 =?utf-8?B?OWZXaHgvWnByR3lDY1hKTFIyNm1jK2RDdVE3UTRqaCtwRDJrOUxlT0VuWnRE?=
 =?utf-8?B?TzJiTmo2Ym9zMXRoZ1JuWmNVRndabWdxQ3dhdGROdVJkcmh5TklNMmo3MHBh?=
 =?utf-8?B?SkhsRHBrekp1K2xiWVhkU04wcTNBbUF5Y0g5TlZZYTlSN0ZUNTZyVUZveVlC?=
 =?utf-8?B?OXFla215SlVkMVVsbEVMQ0I4cWVxRUpZTzNIaEZURmZtSXB2bENvb1MzVldN?=
 =?utf-8?B?d0FUdG1LT29BTWlwc2czcUpteVNvNTVyVDV2bjR5QUhkdmFiTldOaHFCK0V6?=
 =?utf-8?B?ajYxOVdtUWRlb2tGaXRnSDhMNjQwcUZzcERXckkySGdQSFdqM2hjemR3T1Jq?=
 =?utf-8?B?UmJmaUNXVjN2a1NYdENCemdWZ0I4S0ZrWkhNOEoxMjlUU1lhTWdoU3BBckRq?=
 =?utf-8?B?SWN6bExsNExSMUlHMjZjWjd4V3hIQ3E2bjVzc1dhd2FYUEJNZDQya0VCQUlU?=
 =?utf-8?B?d25KK1VNdmtKd0hlUkRpUmhXNE9vYVMxcHphTGh6STQ5UVBHR3ZPVVc2WGM2?=
 =?utf-8?B?eENzajYzeWlJUXlIK3YyS3p0d2E0eXZkSldDU25ZZmJBanJUYk5XeFN6RUZ5?=
 =?utf-8?Q?jsbjlWiViHhXLIFx1Wrs3NFGOUY2MvyjpI7Cg=3D?=
X-Microsoft-Antispam-Message-Info: ONXwQjdsJg0MvTITVX7cf6vEH/A/1PCtrMSFrGoHzkqy+kWnFp/bKpoeiIoaRgg1xRpEpi7UolY31J1Wxa8kk7E8VaP/7dOnLb40mv6iFZBxSFH/mDTa73TcNJ6nN8hXId+LOAH9xpTOBK8FqOJIX8b1RyORK1YvT0l2Gwad1ztzEXI1DDgswDwhQf28qdv9rAWg05zoyqWokCHyj2aJbE/rRmRi+AsyDVsxknxawJaq5IwOhlpZb9mUsaFx57qeryySZLJOgHeJDttR4W1nIovpuEvSULmwDEOda68n/1A+/cOOOX4WctnMY81sLkxPx87b1qhZaXbbGHs9rsbZXp1a3jv2iIZnZS0/OQgLg0ujq/CVqirSV/e6kedPlDALBOmhD8EKN3b+N5EJeD0XKj2FcLe2Jthw1b5pr05KSh+H2M1SLx93BOXgEr6k6Hk8
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB4199;6:nLlb5OQ7v6iXbALKvmfQfKsnMDKfJ6Jga/hGM4duxqlKmkFCNNuwwqzUxIY8B5YqYnFIPOd/VoAImeAWX08rbcigU6suzm5fjfYfTmg8dcJ4VZyrJPjcVwGvut33JY7FTpPjCGVIjELFuCnWCGL0XAXQw+c3HxMqpr03mNnJ6FTAe2LocxE6rzNP4w8o0rPFc9F2x9UOV2VebbU2eOGM4nPQlVYecIDkD6IvbSjG1/kXsKJwRpSQusw6f13FT9jzUqO2yNSRV5H61TlsFZbilqYWpr2ox0XzocCdg8p9xOAxaL3NWuUUUpyJ1FW2V1FsRtfQm0w/0/ZBir3YNmSLWw5r4wMZ/o9QxXIvarhkvgZLbNyND1QQuzacdExC7/Wycm0QKOF/6dB2pycmjZawWBEhbM9lh+13HXj43cd7VBNOBH9IWWDbbmhWOFwaFh0k0zBEEw+i5gun9x1CXgNfcg==;5:y36i4sFQDt9bavvykHw4onzg8zOu9CAuPdPnBSMOxUu8P1gGStkQ/79knk4nJxzWMw0vIybR+VOVEby3f/MiNJIk8mTCgFKx7dBl859pci2UY0kRMfJKAxp/itWOfv7vGQtivU67RfNxQOnz/S8QdNiaOQPNO2EA2jrap9sp2kQ=;7:JqWu+ptCgYu834nFCQLLn2x5GovRaXhWYUNeKW1MXVwpGzYSTactk6sB9sojZTQns3n/csiltcn/pwjrxZyo1L/mcmWn5vrBxB3D9xiQQki2ygNMdnB3+5SeKHL1UV3i5tpUlSr8hOWpBeq5LMgoVb1JNfhVrXSOI7xEZnoW68bvylQX2v6rqTygS4p8rBf/fyk48UCjM+UTgFlQWxJRK59EjaWxVWt1BhLROu/fboZizNlDiDRj8SIsZlYCTr/B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 08:34:05.5780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e789c34d-8bbd-4cb9-af95-08d621f87d54
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo,

>>>> Em Wed, Sep 12, 2018 at 07:02:32PM +0200, Alexander Sverdlin escreveu:
>>>>>   CC       .../tools/objtool/builtin-check.o
>>>>>   ...
>>>>> In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
>>>>>                  from .../tools/include/asm-generic/bitops/__ffs.h:6,
>>>>>                  from .../tools/include/asm-generic/bitops.h:16,
>>>>>                  from .../tools/include/linux/bitops.h:35,
>>>>>                  from .../tools/include/linux/hashtable.h:13,
>>>>>                  from elf.h:24,
>>>>>                  from check.h:22,
>>>>>                  from builtin-check.c:30:
>>>>> .../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
>>>>>  #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)

[...]

finally I more or less know what happens here. In the actual Linux we have two files defining the
same define:

>> # 1 ".../tools/include/linux/bitops.h" 1

#ifndef BITS_PER_LONG
# define BITS_PER_LONG __WORDSIZE
#endif

>> # 6 ".../tools/include/asm-generic/bitsperlong.h" 2

#ifdef __SIZEOF_LONG__
#define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
#else
#define BITS_PER_LONG __WORDSIZE
#endif

So the two defines only work together if bitsperlong.h is included first.
In objtool both files are included and for most people bitsperlong.h is indeed
included first.

> I'll try and get one for building a x86_64 tools/perf,
> tools/lib/{api,bpf,traceevent} to see if I manage to reproduce the
> problem you're reporting.

One way to reproduce the reverted include order is to take a HOST compiler
built against old Linux headers, namely 2.6.30 and older.
This is because of the changes in asm/types.h.

It would be possible to put a guard into bitsperlong.h (#ifndef BITS_PER_LONG),
but it just doesn't look correct to me that we have two files defining the same
thing once quite simple, in the second case even more tricky.

-- 
Best regards,
Alexander Sverdlin.
