Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A64C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E0320892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xnoZyyxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E0320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLGKrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:47:49 -0500
Received: from mail-eopbgr730043.outbound.protection.outlook.com ([40.107.73.43]:31590
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbeLGKrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bREnReAjHnFU8bEFIDIT0G9DqjWD2DEi+v9iA267tx0=;
 b=xnoZyyxGqRwR5iD9+LQdkcNgKijQenlVHh9tr9mFKehObeJHA/Z4ckSGeLqkOFSi5eeTzlrgDdoYXUqV7t3SkcpohWLKH1klB/AgcLjFqYtakNFzbc7Ps/kK8pul0ggVj7mSOil7ACTb4nbY6gmxPLxBBvo1Ye7h38rbPjXaxig=
Received: from SN6PR02CA0023.namprd02.prod.outlook.com (2603:10b6:805:a2::36)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.21; Fri, 7 Dec
 2018 10:47:41 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN6PR02CA0023.outlook.office365.com
 (2603:10b6:805:a2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.19 via Frontend
 Transport; Fri, 7 Dec 2018 10:47:40 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Fri, 7 Dec 2018 10:47:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gVDfV-0001PM-DH; Fri, 07 Dec 2018 02:47:37 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gVDfQ-00021I-A2; Fri, 07 Dec 2018 02:47:32 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB7AlUfC021561;
        Fri, 7 Dec 2018 02:47:30 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gVDfO-00020q-4I; Fri, 07 Dec 2018 02:47:30 -0800
Subject: Re: [PATCH 2/7] microblaze: adjust the help to the real behavior
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Simek <monstr@monstr.eu>
CC:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
 <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu>
 <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>
 <c8283f39-2d68-f7f7-82ee-c0da75755e5b@monstr.eu>
 <CAK7LNAROT8u5P1c4cXnDZwxZ-9RDGX_n2Xrbfu0TaPG68-EGzQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2183c01a-7c3d-8af7-0ae9-23cd0e8c9779@xilinx.com>
Date:   Fri, 7 Dec 2018 11:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAROT8u5P1c4cXnDZwxZ-9RDGX_n2Xrbfu0TaPG68-EGzQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(136003)(376002)(2980300002)(189003)(199004)(476003)(77096007)(486006)(65956001)(47776003)(229853002)(65806001)(107886003)(64126003)(478600001)(6246003)(106002)(44832011)(76176011)(2486003)(186003)(31696002)(53546011)(81166006)(2616005)(6346003)(26005)(23676004)(446003)(11346002)(45080400002)(110136005)(356004)(4326008)(426003)(336012)(54906003)(126002)(31686004)(50466002)(9786002)(65826007)(93886005)(5660300001)(106466001)(58126008)(316002)(230700001)(2906002)(36756003)(305945005)(36386004)(63266004)(8936002)(8676002)(81156014)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT031;1:dIKOwS08NdgzYxL0cHRxJyG3nA5JdIOC3Hjg2TgNqa/ESYi70eea5CmtV3Drb7/Lztvtyh0R/sX/S8aWSdiDLMctcFDGEDSrBW1xZRBM2oJqx3lAUipF0nxdIsdWhtLE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 148ac8fd-cc9b-4f85-f4e4-08d65c3168c2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:4hidyds+IOaxqCfZgbucFa1+FRZr7cqLnshWbrRBCMYKKvFcbJWKFzx5oBQsirWJbNsUDvHggCXQVguCMGrVk6oqZQmvXkzHjc2LOYxC0oEkviL93Kj0KvCC33CphG5KH2JmAd0uQyhVRHwhELI81627/gGSSKqKSG2bhumARSCkDvK8TzAR2e/kCRUMUxcpFYBVxcJy0S3ckQXQOG0qGvEJK3a62zp+6FznAkRfniGab6KQE1tkCsBd+Ujn7THgy7WVhwHOIBZ5JUxjbBib8lF4B7My23oe3alcNsHKR8RjPsC1JJI5cWM3nfcBKzRsOjrqTvHzIY8LDlzToifrgvqBhNRruY+rVcXfcUCb//o=;25:v3usCEHmQBYizXDOmNj/wxPwVtLhXu/ztDbtlEK08kjTRAM+aehmcK/KFoQjGPtfSYrOJTg9upqAut0AiYSDDJ0PX0Zb8CEhd6No7CV4L4KXeR70szk4OE/YkkF+I8gT2c0m0PipIH1pAxsMmHti/oJDmK0rsjnsGHnPrdv0+M8aNQEfh6ta7YdLEGJFQH4QzKLej66b2psSeeEjcmhZeMMFJYNFr7+QXjeokMCGrZ3kP6b/zzwwTG4Yp7NOnyLoTse4hMe9M32HpzmB6vmpgqNl+1AVrvo+UeNiGJGF8SurYCAj0MtIb5ofhA+wxtt0fwvQnofRFaebdgR+2HUw0A==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:0bhD4BtULz+dNwOvhK+b65I0f0WCI+Y4cP2Dcd8Xs/HUWx0FBwErXC8g7clE1bBURXOPgCDRPYJeZUHXZqXO4Vj38h7oXmHW5vchz1TwAzr1kSa/0UMoyLwZccLM5BcOd3mxCTPfiwi5j7dyIzo8Xmk2J8QlNEOvg6O4ShJzUXw/xEmzIRz2n5xBdBV3x4NiW/WHBiX7oEcxJ2jro8Ixx1Mu7+rDzwRNqu6HsFLXQxY=;20:ye6bfLTqef6JfxWXxy0E3SBZ6GFcct5mDwX27eAVrRD005lrUlFeLLzy/FgBzTy8Cp7GxuabjRRaDY7uQnUQzHKvd81fAoADn/lk/eo2zmYmgbjcD6zE2rn73L7NXxubNOQsKKA14+bOz16q9BdclD490emrZrR4OEVgok+2/2J9phcfRJldxurIylGxhQ3MfmQksgvbrWy6BdOKjnPcoYeYOakIngN8zchm7WJIfvB/y2E+GePNHAwjW1EKXlT61SNKikv7N54lOGuLq5/uY0KIS9Zrs5KIP1meSfqFxeeMmu/KejL7jz++l6pGaHOSPlvetpAEMWyz+qMisEaR0DJoC9ziHVCOWGz19NNYXuXruoWSOVO8Nd0T60a/VxihLP+AzKMRE5OIW+fDuQW4r2x9BEHIfYRFfkauaGvMBtw9zCf3njiKAxNd2BW0tUX42+QOQpQph3cioIQm1ttfVmYZuwvdxRGT5D6RRyVj0XcC1xKtXA27JyE08uuPgmvK
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3510121371E12377579C2910C6AA0@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93004095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3510;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:m+d2E7utIYNkTF0ccjTWgVI36IMxDvShA8QcXtcG3DekhgcTsDj5VnFfNKwzhUngzMoO01hpI7Fo4YZe4n7V2axjFiXbYiyd8TjD7HPefj3TWLROj2I12AA+HODB7Bg60810D45rm0kr6+kB8KUGPHrC/LL05MLLlk9/2SjI7cOZyYOMnIsvZRX0kx5elljBWND0KbHKh3XGn+lACnCxczIdCNhV2MVPV7ZHBCL6s9acuHNYccinI8jZlF2zfOJRsJCtMmb/OG/h73nY9njKaQ==
X-Forefront-PRVS: 0879599414
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAyMDFNQjM1MTA7MjM6YXQxRGNNV0s0RWZjTVZHM0JUVGpDWU1z?=
 =?utf-8?B?SzFBb0pETlAwc3dOVVZzOUpQZTZtR3ZSZXlnZVhoZlEwYXN4eWNwZGRHMXpk?=
 =?utf-8?B?eC9hem8yZ0xWaUsyZGtDZ3lxUXJxd3lNQlZlUy9LUmp2R3hyNUF0Q1hrVVlB?=
 =?utf-8?B?ODdtSmdsdkhYeFljTFR4RE1QNUxJbEhHV3l2MHUxMDdwMEVwYm0rSmdFeTVl?=
 =?utf-8?B?cHFEcjBrVUFSZWdna1FIOFhqYTQ1Nm94K2laeGt0VWJja0Z4M2tUNXpabGlV?=
 =?utf-8?B?VHNwdHVBaUozWDloMVI3V3JYWi9SaHBsOXpTYXV3R2VDdFR3cEJjUG5FS1JM?=
 =?utf-8?B?MTNQV0VHUCt6RTdHWXZmR2dORk4xdVJLWXJ2M09ETmRjQms1bEVqbiswWE9h?=
 =?utf-8?B?UWxucFdMWFZJRnE2RG0wT1JaOWJ0Q2dDRXdkdTZCRDV3K2VJY09KRWN3QTVu?=
 =?utf-8?B?anp3SWFEK3pFM2pkYkd0RHdpb1BpUi9TUWwzUE1WazlvYUJKOWFTa0plN1U1?=
 =?utf-8?B?SnZCakxVSk56VExPaXljNDhrM0l1WlRwT3BVelVTYzAxN1FRMFQvQWFoL05n?=
 =?utf-8?B?c1QySTZyM20xRHNwQlVZVnF0eXZNbk9tNjF5bXltMWpNRHd2MTZxSkUydzJ1?=
 =?utf-8?B?bzNGWWU2d3ByUE5wbEk1U3czS1NNWmc3ZGpDNDZ4TXQzaUNlNXYwbkRHOGVi?=
 =?utf-8?B?TXNHUkNBc3Z0WnBWcVp2SlB4dHBaTFJZd3pvOG5tT1d3ZHlxMXBCdkIzait2?=
 =?utf-8?B?blBpdWNVVG1mUzhRckREYXhST3hocWtTSUxTZjFHcmkrdHhEelpFdXViN09L?=
 =?utf-8?B?Qlp0YkdpWGJIZElpd1FmTWpyWkdnNU1sUkpROHRXU3JRYVY5MXFYL3dZNW5M?=
 =?utf-8?B?em43OEpDNTBtNk1mbkhwZHA5M3pGMXBSNXFDL2pzeWhnZ2ZBNTZzcmlpY1Q1?=
 =?utf-8?B?ak1HaWg0M1dIWVdyQW1Obm43ZlBFRUh0WFZaN2tYQXVKZ3k2TUNoZ2tkZ1FG?=
 =?utf-8?B?SERhdGRiZHlYNGhrK0tDNDNQMCtCbDJRQkxXNDkyekVZVU9mR0Zjano0WmhT?=
 =?utf-8?B?Sk9CMzBRdFh3OGhnNStyNkxiUk1UNnpNY3ljTHIyMlMrbGtZU3ozYXJCZ1lY?=
 =?utf-8?B?UkhFY0VGbXhlRjV4bjNtWWZ3N0ZlL3RIQVFGRXpQWnRqdGI5eHhLNDZJcEd3?=
 =?utf-8?B?cDgvdEJldVF1eFVsUzd1SFM4eEdodGpLVHpNTG9Demk2d2RhZ1ZVd1FEbXdh?=
 =?utf-8?B?aHYwZzZlMzkwVktHSTRQdzVaQzlDMlBPUDRicFhDODc3MkJwOW5IeitpQWxH?=
 =?utf-8?B?NXU1NDlyS0RvMnVZUmZjTWFwZlUrM1lidkJmRGN0cWlSNStTRkFMWkRnUTlr?=
 =?utf-8?B?VS9CNE5FbU1aYXlOU3FKWXZ5dlh2b1pRK2ErQ2hWRmEyZVlZSGxGQ0JZbjlD?=
 =?utf-8?B?MzMvdjBMUWRJTWl4VzBMQ2xRdFhjc0hzRTVNcFo0bktHWGlUNmRrUjFVc0Fi?=
 =?utf-8?B?SHpabDlYdXRKZFZHNnNDVVR0YnMrRGJDR2VJSnQ5NEUrVzAramx1OFdSYWlQ?=
 =?utf-8?B?eTVwVTVmREJkQ05VdVpSMDBwRWtoVVlhUkpvODdYbCtHeFk0U21ZL3ZrQUdu?=
 =?utf-8?B?aVIwb0I4RTJxd1lNbmc5TE4vcDRnclkwOFV0ZDF6eGx5MkxFcFdJVU5POEZU?=
 =?utf-8?B?OXNUdEtwUUxSb1pqNWtEVzhPUVFud3M2MkhXMGY5QWZBYUhJMHVnenVOdVJO?=
 =?utf-8?B?aEtCUUJwWGZLV1JqY1Vyb1k1Z1BXckM0K0VlQjU3dElJYmFMMzhDWjlINjBW?=
 =?utf-8?Q?EKWtebirkqWmNEl?=
X-Microsoft-Antispam-Message-Info: CtXK0/qTqabPswnOi3NEOGt9rlgh9NwUwT7pD2eVh9WQEJfXWYKl5GV12TxiNmoPhSml2rtVdf2lxwYGmShmQWFD0ZgabI0CTZV/MNeuJEkdt4/I8wWc29DX2oQvrRPj0Xx1z6DnpzFBNyBzk70T1FI/D7MY6zoNehTJxY3uYRBT7wobVnJS+Epqr3QkvL3XU7feaO/dKZ9vmtgCzSV5h6gnRB1+wsue0aE4F9kqrpSB2DRpHgeSY8wpYES+O92mzaCF0vXbNMLkAQV3ouymHpePSdqkz/5YtzKWztzCrJcdnJIkoH9CeKMIydw2ddGdHNXX+zckA1b/NoOyCUEgISKdEvSUsypbsCwnAuLZ8nQ=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:pJKe14tJsMG+m7BusJ5G5YE/XDdS9xLy517qwSWwbp+kQ8L3eyhYvzI6sLVJvjjPcBf6byjYuU59pM3gtouApZoK/6tLbE44jOqoyUuG/YAN50YF+LVdoz6D8+vLZVLSEGLGtXPqeKcfM+7G2QsrVouyCxex5B3EXiSDfD2Xj2YUnDp3n75zRnX8UpiamAT2d+NKNh9Z1MTKlm2RWK7GXkOif4/1U57sUIkEfvN00MJfKcvioMdhIhV+wO8M7297CTzU4wRscC5V0j2LUHhslMgTPt9ERYnL69Ae4iITiqmPJ/7d+Wohuen03mDtaNS5MX/PKzTryp5AtoqqJ45tr8ivHb4+WtCU52SWVlCfne0pJrz88UFX67FFKRpbWzEi+DA4a7MbARoQa5QSXpmMenQrBHAafiTm0uJjRl4ot+mspE33picf7dwGnzPwiBdQBVlAvme4N5XgToP3Y9XO7w==;5:BG0xJOWjXaHxviDCNr32NdNB2ia3bHXTNn9ovjccKuP/PkpqDblzW65IkTkgRB7U/xkd5J6mbEyNfhyfRKStbmqwLAhAfXbKznFR4Fr7+XddD9iGXyuAEBSbxauCsOLbHjnTLQRTtXqSLB16z2/vbBVbjm5AOSQThU7y6cACXRE=;7:y+rxyDvxGKabp1dJs/rD1wGx77i4NQ5bptH9nTRYfrTHmQCDMPo1+0ookEQskF3qRJdV6eInSZ6Uli6MAK2tMb90HnTLikn6OR6okBNwj3rkJ1WDaLY0J748UwgS3PMp9Qi4Vlb8hfMykcx7Gon27w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2018 10:47:38.3856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148ac8fd-cc9b-4f85-f4e4-08d65c3168c2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 12. 18 11:21, Masahiro Yamada wrote:
> On Thu, Dec 6, 2018 at 9:54 PM Michal Simek <monstr@monstr.eu> wrote:
>>
>> On 06. 12. 18 6:27, Masahiro Yamada wrote:
>>> Hi Michal,
>>>
>>> On Thu, Dec 6, 2018 at 12:41 AM Michal Simek <monstr@monstr.eu> wrote:
>>>>
>>>> On 03. 12. 18 8:50, Masahiro Yamada wrote:
>>>>> "make ARCH=microblaze help" mentions simpleImage.<dt>.unstrip,
>>>>> but it never works because Makefile assumes "system.unstrip" is
>>>>> the name of DT.
>>>>>
>>>>> $ make ARCH=microblaze CROSS_COMPILE=microblaze-linux- simpleImage.system.unstrip
>>>>>   [ snip ]
>>>>> make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.unstrip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
>>>>> make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
>>>>> make: *** Waiting for unfinished jobs....
>>>>>
>>>>> Rip off the never-working target.
>>>>>
>>>>> In my understanding, simpleImage.<dt> works like a phony target that
>>>>> generates multiple images. Reflect the behavior to the help message.
>>>>>
>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>> ---
>>>>>
>>>>>  arch/microblaze/Makefile | 4 +---
>>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
>>>>> index 0823d29..97e1384 100644
>>>>> --- a/arch/microblaze/Makefile
>>>>> +++ b/arch/microblaze/Makefile
>>>>> @@ -89,9 +89,7 @@ define archhelp
>>>>>    echo '* linux.bin    - Create raw binary'
>>>>>    echo '  linux.bin.gz - Create compressed raw binary'
>>>>>    echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
>>>>> -  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
>>>>> -  echo '                   - stripped elf with fdt blob'
>>>>> -  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
>>>>> +  echo '  simpleImage.<dt> - Create images with $(arch)/boot/dts/<dt>.dts linked in'
>>>>>    echo '  *_defconfig      - Select default config from arch/microblaze/configs'
>>>>>    echo ''
>>>>>    echo '  Targets with <dt> embed a device tree blob inside the image'
>>>>>
>>>>
>>>> I understand what you are trying to say but I would still like to keep
>>>> information about unstrip file.
>>>> It is correct that it is not build target. It is just generated file and
>>>> message above was used for description what it is.
>>>> Definitely agree that this should be the part of targets but it should
>>>> be in description.
>>>> The same is for missing description for simpleImage.<dt>.strip and
>>>> simpleImage.<dt>.ub files.
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>
>>> If we want to be precise to the current behavior,
>>> we could describe more.
>>> (Is it too much?)
>>>
>>>
>>> Architecture specific targets (microblaze):
>>> * linux.bin    - Create raw binary
>>>   linux.bin.gz - Create compressed raw binary
>>>   linux.bin.ub - Create U-Boot wrapped raw binary
>>>   simpleImage.<dt> - Create the following images with
>>> arch/macroblaze/boot/dts/<dt>.dts linked in
>>
>> type - microblaze
>> maybe <dtb> here.
> 
> 
> I will keep <dt> as is.
> 
> I see more <dt> references a few lines below:
> 
> 
>   echo '  Targets with <dt> embed a device tree blob inside the image'
>   echo '  These targets support board with firmware that does not'
>   echo '  support passing a device tree directly. Replace <dt> with the'
>   echo '  name of a dts file from the arch/microblaze/boot/dts/ directory'
>   echo '  (minus the .dts extension).'
> 

ok. Not a problem.
M


