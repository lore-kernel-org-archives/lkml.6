Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580D8C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051682146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JvRTqBMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051682146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeLFCoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:44:06 -0500
Received: from mail-eopbgr710088.outbound.protection.outlook.com ([40.107.71.88]:35968
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727794AbeLFCoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1aSRrAwn/AJK6zdbtUke9gd7SAm1FgeTZlgQGiUyjQ=;
 b=JvRTqBMOBOnX3LHmFfvZ7sfoxfIE0DuI488svoCRWfRKK9p/TuHkDyC7mduBK8Tg6xZDRslYtPijxuC+slXfoOTbMWF9qMXyBommYVCD1//9QQ/Iq0I+U6Wvro4MOuqu0Tlkp2vWEOcfprchYM4Q8oSEAG4XpjQzvfj/Pzkb03c=
Received: from MWHPR12CA0037.namprd12.prod.outlook.com (2603:10b6:301:2::23)
 by BYAPR12MB2629.namprd12.prod.outlook.com (2603:10b6:a03:69::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17; Thu, 6 Dec
 2018 02:43:58 +0000
Received: from BY2NAM03FT006.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::208) by MWHPR12CA0037.outlook.office365.com
 (2603:10b6:301:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17 via Frontend
 Transport; Thu, 6 Dec 2018 02:43:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 BY2NAM03FT006.mail.protection.outlook.com (10.152.84.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Thu, 6 Dec 2018 02:43:57 +0000
Received: from [10.237.40.91] (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Wed, 5 Dec
 2018 20:43:55 -0600
Subject: Re: [PATCH 2/2] drm/ttm: Use pr_debug for all output from
 ttm_bo_evict
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20181205165621.5805-1-michel@daenzer.net>
 <20181205165621.5805-2-michel@daenzer.net>
From:   "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>
Message-ID: <b0b57acb-7152-ab1a-855a-3de8c77fa425@amd.com>
Date:   Thu, 6 Dec 2018 10:43:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205165621.5805-2-michel@daenzer.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(428003)(199004)(189003)(14444005)(81156014)(81166006)(4326008)(97736004)(53936002)(476003)(126002)(6666004)(356004)(8676002)(2906002)(2616005)(105586002)(229853002)(47776003)(446003)(6246003)(66574009)(11346002)(65956001)(65806001)(53546011)(2870700001)(8936002)(86362001)(2486003)(23676004)(76176011)(31696002)(486006)(426003)(36756003)(77096007)(26005)(67846002)(16526019)(186003)(64126003)(106466001)(305945005)(7736002)(104016004)(65826007)(50466002)(336012)(3846002)(72206003)(31686004)(478600001)(54906003)(16576012)(316002)(58126008)(110136005)(5660300001)(68736007)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2629;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT006;1:aMqgStGJ0kUbXmr/vy+0qYF9xHj591ca173AcaLgDLUWIiCwzz6DIIBRxBMOBYVN6KcgKhfS+mgALS1RFnNlExptaaV6Ny9i4HqhzS6qSlT6PgopaJBmhtX7nzi0Bd/D
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7520267-835b-4e86-1d1c-08d65b24aba3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2629;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2629;3:oOjW7xXvld48mgWLjzFE/nzs56QpnfVkm+eaf6qrs4pGWoCx5F1dzzMxFTpPqd7bvsInFqy6MFaKEMGMh2xsvHXQeg9XXTV2G6Tll/SomLhxG3qenfgu8NQpDci13/YeqIb66k4GQLgtyH3lrXNslpG11j/CTGU9CGhtBVBN4MyhG1nvJ39a4S4p9f94Z2paocvishstjDCYlYyAVEhVey38P8wg2B1lNJ0IFXQ0n8kg/32U/Hn++9UYqlCWQFHx4SerMNHK5bD81RLfmUJlmGVpa6MhgCO1xx4a4N42SMPXR2+fVwk+nrEScc+gIXbekGyiXznfgTFUGSz7MW6Swsmw94ERPqlbUZnHtltCtUE=;25:IVOBbpPOHWYDJ9ZuEhfQBYRrELKL2n3/bvftigga6tkcSbLKVKgEGBOX60GPVWWLxeAGkClvSz7v2YDbLJ+x0bDf4PeFTKDQKlRlJm/RwMbtLKFmzGlYuXV2EImxpPwK2mDmCNDYWyEkBA1Tq84ntcxs8d72+ViInjZuZHXtWHUcq8x0pqSY1gj+m7djPmvknUYC2WOsOAs/sq4sb+oauA8JUB6PKxtlNrMHNryOBdBzglLxnciUfjCJpiiICertCnTYRy/ON+7fhMtf+bOenvQwRpohtQBtH/+rp+7ZNqjA619BY++yUgQWjGv0HXrMO58gNHWNEWoVxwqDkEvxxw==
X-MS-TrafficTypeDiagnostic: BYAPR12MB2629:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2629;31:gYSUSCOuIHgjgelM0iiHNJp50KOEi0z4NkiIaJdRNGyNjlHDm4M9ASq6zWPuGaxX9KkixzKojFuHdrvlrVlG3ZixUylIWKKBPDrH6/6YI0754kAW8lWui3dnn5KcTRRoRgHBC2So71xvE6QRLvj/nH1XbcPgDHUU3HggWvX6xEL2giCafkH2ye+5H3anYWqsiJEyZtrN/VGn8OHFAQkrcivOyQMGKwl8bsCtQSkySds=;20:zzwO4iBMos22BQIBHH+K6qcEPyCjDAMxUjDKv/VOhkpwA6ySjI615O2NQsM/ghyhppCC5AtNys1Y/7cvsMjvuogc0C6qxcLJBkqs5cQDNy4VdP64JDv2ghg2HTKpmVLL7ThZkeSYtSHGsCzy71MkHF425xod6RX/QCcwHrPWa8B318xocBL4XJXo6qT6+fw7qEvh/HPnFSqLNts3ne9YaSMCn9SF8sWz+cDAhr/LSYCmEMcqls/B1Me8OKVn0YV5xDkJlceNR58c83pWYqBZHsbafB8eOK+wyJD9H+Mqt7p6690UMcorMADzYG7jc0upCfGXmB3xj/SjOIZnL6TqTxo6SvNPTK5tAhHMPLHCvQpeNR2pc/YAihJ4X9PCFid68XkKY3JaflPbvS1Q0OaJv9VPFC3VpQ0MhnGKHzWk1BdEShW7xcNxY30zVs+r4grPCHD7NBcPReLE5WOJPKmFDPAknNMyR/y1jn9skeO9bbGEtARTR9XJpimlUdICze/y
X-Microsoft-Antispam-PRVS: <BYAPR12MB2629533D672DD43CDDA43785FFA90@BYAPR12MB2629.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93003095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR12MB2629;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2629;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2629;4:T8FOc/dZ8k/onWiXw578VrO7hqCdl+U1E1qNseA4gPUEUa7/qeBe6b1QsiIl/Ugq3pr/RPmsQF6ffVcncADUCZP5RN4PrRPFXi9u7zUL0EIr5GTurKo0XDlzwck5+sxuzliuoQmaF1gfUeZ5ksAE+x2iNFG3s+dZYGpMhdcQ1rX4gLarwtN3/f3IMsWzlqerADLh2SnLRvqd+vBhmYFr+QRr3tf3vzvE6KLTaLHXPRbiTT9x+jhI+HUW4lU1CPxiuTL3wDhJpeS+GHgsqPmAYQ==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjI5OzIzOnl5SHJEU3ZQcUFvajJuT3NmT1hwWmNPYlBT?=
 =?utf-8?B?dWh2Y1NjTnlXLzNkeVZvMkx2QkQ3V2lWODZrcmcrYkJnVll4cUNvZ1o5VHZ3?=
 =?utf-8?B?dXZ0Z3R0bGlqS0VxZTE0bWVlM1JnbFYvVXNKejNDVW9taG04Y0lDQ0VpMmNj?=
 =?utf-8?B?WTZncDJiQk8wNU10TmwwOXdmWldnRitvQjQ0VkVSRDBKK0hjNTJWR21rdDIy?=
 =?utf-8?B?d3NSbjd0UWZWUjFFdlZvNVVXMnIwUTgyc2FqSXFqZUtIS3AzTlhQMFlyZzNQ?=
 =?utf-8?B?dEV0SGROdjA2NmJIdHpCLzd5cEFRQURWNjgwbHR2QjhCU1I5cFBvL2UxbkxN?=
 =?utf-8?B?YWlmR1QrZUVHRC9KWDUrdE9ycTJ4RTNHZGc2Q0FOMGliUUE4N3BRQUNlL053?=
 =?utf-8?B?WlEwS3ZlZGZCejVlbXZQWDRxY2h6eFBoc1J0cVIweXdmMkNJK05ZZTZvSWhj?=
 =?utf-8?B?ZXo1K296RjY3VlZGWHo4czhYOXRhRjFua2ZQdTVaT0ZxVng1QUZDMVh3Q0x0?=
 =?utf-8?B?cDkxNC83UGpsc2Q2RmpqUDBFTzNlVWNZamhJNUF4U2xDVnNwdktObHBkZkZQ?=
 =?utf-8?B?RUZZdUkxK0pZMTZsZk9oaXpDMThoajBUS2RCcE1sN3ZSeEQzYjNtczlyanZq?=
 =?utf-8?B?TDhpWFZmaG5waXJwOWRCRVdFOVYwbGsyK1hzZW9IaitlYkxkeGN1alBXNlNJ?=
 =?utf-8?B?WS9NN09SeWl0THY2MzdGVGdwc1JsUkVpS1M1TCtmTkZ4THFDOXJvdkxGRlRn?=
 =?utf-8?B?UktGTHZTVHhIZzh3aTZsZGFjVjZzVjhzK2E2UGM0cGxsZ1hUdDJaTGY2WWdp?=
 =?utf-8?B?Mlo5SlZLdHd2N2VmUW1zZERXTmJjSXZqWWYrVUpSc09PODFOYWpVTTg2OVlm?=
 =?utf-8?B?OE9LZHY2RSs4K2NNK21ZVEh6RG05ekI5V0M5YkFtVGdkK1hRUUdYQmlVdm9x?=
 =?utf-8?B?M1lMejBXRHg3UjRadDROUWpnbEVYamlpcGxiWlBpQnZBMCtqMnZNY0RiNm1n?=
 =?utf-8?B?eGFtM2FLeGxPTEVuaDYwMWFFQ3ZESzBrNnVQelNOMWhvbkh0UTByWWVnZEZq?=
 =?utf-8?B?dTQ1elFGZk5zQnhQdkc1d21xY3p6V3U4UHVENWRidUsvUnRLN2toUXFwL1N2?=
 =?utf-8?B?YkdmbWZDcEhTaTRpNzhzT2lXaG9ycnRsSHFVbXFMOWJpZ05kbVFWNmYyMWh5?=
 =?utf-8?B?RVF0Y3kyUS9WSm9RMSt5TDVCQkRpUCtwR29CeTAyNGxPc3ZlWVMvM2NyekVv?=
 =?utf-8?B?cjBzSXFIQk92WWFQS2JncGw3RVVUeDVPajlJVndCLzZMSW0rS0s2a1U4OG9B?=
 =?utf-8?B?UnEzMGVZTVRsK2MvQ1FvMTZvY1dHaEh5VUpldkhrTVVGTWtBejJzU3NYQWwz?=
 =?utf-8?B?UlVYWTgrOFRxa2twTExHKzBaYzZuUkUreENUMWc5dGl3NW81UFdHSGF4OWNm?=
 =?utf-8?B?UlZEdTZDaE5tOElIVXJ4Q1JjT1BVM0lBZGpIbTZSM2lhVVFSOFRJUVZMOVJw?=
 =?utf-8?B?K3FtMkVOc3VoRHhHOWJZNE1XY1dlTzdFeEZ5V0t1OGZkM0RDVlRVaGFNSkxJ?=
 =?utf-8?B?K0pWU0Nyekw3SmdSckFoUjN3UnE5U3BLZEhKTHJEL2xHMmMrL2pQY0UzMVRo?=
 =?utf-8?B?clVtQitlRlloTEc5QmhLL3lhcy9oWStDdGhWZGp5eEJ2d1psYkZ2eUt4dWJi?=
 =?utf-8?B?MFg1RDN6ekxWOVFqTi9Wa296RG9QRjUrK3o4ZVRSN0hrazRxWnBHTlovQlpp?=
 =?utf-8?B?WS9TWU1sTWlGL21VUDhEN01zamNlUzRhVVR2NFNydGwyb2FRQnNlRUJ4THFO?=
 =?utf-8?B?ZEcwWUQvZHl2SFNRcXBPRDhUNXlZYjFTc2phVS9XblpFMVovRHlCY2xCazdD?=
 =?utf-8?B?SVRCWFVNdkwyOW4wMXdTVUNVMytVbkErRXdxRytWUjh5L1MybDZLdS9vQk0w?=
 =?utf-8?B?ZjFyRXZyVTFaQVR1UjFkeTVsVEFyTStMcmZnU0ZJZGdxNzZ0a29uaERvMFdS?=
 =?utf-8?Q?eWQPlN?=
X-Microsoft-Antispam-Message-Info: K65XTJ0pqsckneW5l9E9N9fUjHXPnrd6BVgwNttqMZDhMJkRxXo2Rf5luvrNVnviyfyWj/hH5PCQImNDh4roGLpgmyG8XcGF0r+rpg/FoQWyJw4d3i3yNrD/zqJGN/yRPDoTEWsRu0V0Er3QocoikFh3748hsZxUZQ1YssDWt7+SMQ3EMAiErqECp0eaPY0KQhTSXy9dUqelEbpZHp3fkIbOZCcmgWuvJxR74tBb+5SwH04oDI+jcDMdoCguoROXEWKs+CJzN0fFSImdYKsgJzLllzYrxDtlgJdJEEhYiDMUgsLEjo2oohxWnlObsYGweB6gTwsYbio+rxi7KQXMyVAEbA7E3c19Kp4olqCyb5Y=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2629;6:L0xZJLb491I0BOag3HCqgUbr8wr6qhIhrwLmdkAUoygR9CaqPENSkbk34QiffaBU6yWn4hF+aPxqw4Ak4G/DUaFRxey8Ccs+PCklHLOcWwqYIAjtkFkp/9Q2CstfEALpELIt/yw+INmckTPwcIUMLz9+i/2jNGACftgpKjYxuJBOCiGO8ad5AQv/kLcdYwTqR2XXZds2pnRp/rkp+GOPntUSfCU94RBh8gjQ3K1PFq1NiumwilWFQe1sJp+XpB5rc08VLFd2psX5RIKAJpYqzaH1Q3BcGaMr5/Ve2oXetdtey7xBP+dilLZUX7z3+PCr/IqCKogVweez6EYCItHDygEk6psqGcn48hnyE6sqPWLufVFgXokED0ahiBDVl9V4ZqGOBDX6hu0zAV7ZQAeH6Xbgu4Tcacs75wGNZIVxbqARWVWRf7RaMMEPPI4Glkeg1OqA0A7kAkdMhWfwS4IFng==;5:SUStkpNMMaWytXaXDGVit5Q+aoYGdPDv7pHqm9tGInPKqX9Fwe5jewQpx7TL7u5ztI8U5etnZZH8Sp8uxLeDixdan2PrSzUEhq+i0EUbWJtaCgN9v+RVwDq5/ePOzTyoiojde4Sm0Q861dD4tdf5ud1TmpubJOmPpOztUn2BAFw=;7:6yQyKAvlEozCD7kUWdiYBPXXhIG/G19B51eHEUa/JPvydkGFUtqJ54G+aLzHJmmtoaaTsZddYFEZaLImN2/BoD6P3zUMi+fkn53mm05rR5yVIZ9mPS46A8hAewOnq/H/JlmFUzSR/2FXmx/D9dYkxw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2629;20:vOpM8obx6qS2QDe1I5VMzVVmByJWk95BkQsK49c592PUAqtQfWFtx+qfdyXQCqyUEAF7+L1x1ddJMamRn9zWtE/ZNynAz/tIyRqEJBFNixJkiNsPgKCLXUAXNZ0awrD+79WECU13emPykrjEL0rIHxw/4QJfpcymUSp6mYY+r8npPITGCQm+Im279JCU/RUAD47WLiB9VSaSiRhIDTI6tHrDwZWFThFx66yhxd6At0lqHYDz5LoI+ExnMVdjDUvd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 02:43:57.4016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7520267-835b-4e86-1d1c-08d65b24aba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 12:56 AM, Michel Dänzer wrote:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> All the output is related, so it should all be printed the same way.
> Some of it was using pr_debug, but some of it appeared in dmesg by
> default. The caller should handle failure, so there's no need to spam
> dmesg with potentially quite a lot of output by default.
>
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Sounds reasonable, but personally prefer to show error when some
vital incident happens, e.g. no memory on eviction.

Regards,
Jerry

> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 39 ++++++++++++++++++------------------
>   1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index d87935bf8e30..5e9b9dd91629 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -77,38 +77,39 @@ static inline int ttm_mem_type_from_place(const struct ttm_place *place,
>   	return 0;
>   }
>   
> -static void ttm_mem_type_debug(struct ttm_bo_device *bdev, int mem_type)
> +static void ttm_mem_type_debug(struct ttm_bo_device *bdev, struct drm_printer *p,
> +			       int mem_type)
>   {
>   	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
> -	struct drm_printer p = drm_debug_printer(TTM_PFX);
>   
> -	pr_err("    has_type: %d\n", man->has_type);
> -	pr_err("    use_type: %d\n", man->use_type);
> -	pr_err("    flags: 0x%08X\n", man->flags);
> -	pr_err("    gpu_offset: 0x%08llX\n", man->gpu_offset);
> -	pr_err("    size: %llu\n", man->size);
> -	pr_err("    available_caching: 0x%08X\n", man->available_caching);
> -	pr_err("    default_caching: 0x%08X\n", man->default_caching);
> +	drm_printf(p, "    has_type: %d\n", man->has_type);
> +	drm_printf(p, "    use_type: %d\n", man->use_type);
> +	drm_printf(p, "    flags: 0x%08X\n", man->flags);
> +	drm_printf(p, "    gpu_offset: 0x%08llX\n", man->gpu_offset);
> +	drm_printf(p, "    size: %llu\n", man->size);
> +	drm_printf(p, "    available_caching: 0x%08X\n", man->available_caching);
> +	drm_printf(p, "    default_caching: 0x%08X\n", man->default_caching);
>   	if (mem_type != TTM_PL_SYSTEM)
> -		(*man->func->debug)(man, &p);
> +		(*man->func->debug)(man, p);
>   }
>   
>   static void ttm_bo_mem_space_debug(struct ttm_buffer_object *bo,
>   					struct ttm_placement *placement)
>   {
> +	struct drm_printer p = drm_debug_printer(TTM_PFX);
>   	int i, ret, mem_type;
>   
> -	pr_err("No space for %p (%lu pages, %luK, %luM)\n",
> -	       bo, bo->mem.num_pages, bo->mem.size >> 10,
> -	       bo->mem.size >> 20);
> +	drm_printf(&p, "No space for %p (%lu pages, %luK, %luM)\n",
> +		   bo, bo->mem.num_pages, bo->mem.size >> 10,
> +		   bo->mem.size >> 20);
>   	for (i = 0; i < placement->num_placement; i++) {
>   		ret = ttm_mem_type_from_place(&placement->placement[i],
>   						&mem_type);
>   		if (ret)
>   			return;
> -		pr_err("  placement[%d]=0x%08X (%d)\n",
> -		       i, placement->placement[i].flags, mem_type);
> -		ttm_mem_type_debug(bo->bdev, mem_type);
> +		drm_printf(&p, "  placement[%d]=0x%08X (%d)\n",
> +			   i, placement->placement[i].flags, mem_type);
> +		ttm_mem_type_debug(bo->bdev, &p, mem_type);
>   	}
>   }
>   
> @@ -728,8 +729,8 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
>   	ret = ttm_bo_mem_space(bo, &placement, &evict_mem, ctx);
>   	if (ret) {
>   		if (ret != -ERESTARTSYS) {
> -			pr_err("Failed to find memory space for buffer 0x%p eviction\n",
> -			       bo);
> +			pr_debug("Failed to find memory space for buffer 0x%p eviction\n",
> +				 bo);
>   			ttm_bo_mem_space_debug(bo, &placement);
>   		}
>   		goto out;
> @@ -738,7 +739,7 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
>   	ret = ttm_bo_handle_move_mem(bo, &evict_mem, true, ctx);
>   	if (unlikely(ret)) {
>   		if (ret != -ERESTARTSYS)
> -			pr_err("Buffer eviction failed\n");
> +			pr_debug("Buffer eviction failed\n");
>   		ttm_bo_mem_put(bo, &evict_mem);
>   		goto out;
>   	}

