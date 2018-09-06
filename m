Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C6DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3C82075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HBzBCfxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3C82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeIFNSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:18:16 -0400
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:45088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeIFNSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TeLUGflpmvgOrZXrxbTKTDlDK35+vat0NtwStprOG4=;
 b=HBzBCfxw6SCw98z3dLT9KUZ/G22RU44z3a4Je8a4Vav9dIeZWWc2vrK+6nY8024PfNW5mQ0vuRw05f2pQTGNzqEm56jwcdmTr1wJ3GBM+U8NyiHiKaY7BJbpX2GnEGuu6FQpw4XGFF4f4XfOCzZD18hDj6Ez3xL1IsppefaY2e4=
Received: from BN6PR02CA0073.namprd02.prod.outlook.com (2603:10b6:405:60::14)
 by DM2PR02MB510.namprd02.prod.outlook.com (2a01:111:e400:2422::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Thu, 6 Sep
 2018 08:43:50 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR02CA0073.outlook.office365.com
 (2603:10b6:405:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.15 via Frontend
 Transport; Thu, 6 Sep 2018 08:43:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Thu, 6 Sep 2018 08:43:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fxptE-0003tB-NB; Thu, 06 Sep 2018 01:43:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fxpt9-00033z-Jp; Thu, 06 Sep 2018 01:43:43 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fxpt5-0002z7-72; Thu, 06 Sep 2018 01:43:39 -0700
Subject: Re: [PATCH 1/1] axi-i2s: set period size register
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <alsa-devel@alsa-project.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
 <20180824160430.10222-2-luca@lucaceresoli.net>
 <b87937b6-da7c-76d7-5dd2-24909e648671@metafoo.de>
 <263e42b4-75a3-183c-894b-e485e387eccf@lucaceresoli.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <da2fd8d4-3439-8c8e-5933-f387af9fb097@xilinx.com>
Date:   Thu, 6 Sep 2018 10:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <263e42b4-75a3-183c-894b-e485e387eccf@lucaceresoli.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(4326008)(93886005)(26005)(77096007)(50466002)(2906002)(336012)(65826007)(305945005)(6346003)(230700001)(8676002)(47776003)(186003)(110136005)(36386004)(106002)(446003)(53546011)(54906003)(23676004)(58126008)(65956001)(9786002)(107886003)(65806001)(6246003)(106466001)(2616005)(2486003)(31696002)(63266004)(316002)(229853002)(356003)(64126003)(81166006)(81156014)(478600001)(76176011)(486006)(426003)(39060400002)(476003)(126002)(8936002)(6666003)(36756003)(5660300001)(31686004)(11346002)(44832011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB510;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT004;1:Pwdg/FrZWjX6MObT+0Mij8xgA0i0IhoCHJey3QEr7AqiGPQnBcs9DlHNglWUd7+jDejQFtEjqNZ9zE91Jr6aC4g5ZYaov6ATT1l5useigd6tEc7CsJXoDC/Ofig21tEw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d82048a-5ea0-49a5-c52e-08d613d4dde5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR02MB510;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB510;3:RvQ67BACcrRHv/vgQRrqRkJy+nenwJx1erCG7Mavb+KldHQCzQLkKMuJ9oA1d6RNSFY5sDrSobvLoUw9n7gIkheUW9pyzqycKCZ5sr7QHQHWOdyw++/3yiX39gxo2AlGmp6oSEc7z47pHI3zS1PvyJc5RMMNM/XIVTr8lTU3dLaDzgW26x3ITztm9Job5JdHSYprVW1wK5Rv9deIl9grALD7jm368srTF4INU4aTsaWTHAyr6u/t0+jerwjoIs+y/idF+Fjh9D8JtimR2kyP8OCoEOoyxysG5kkY0NzLDZe/nx8s4fhZ/TT/BLNwH2fMaYmm6irKJlxzF04qBkk8MyZtYZOxEPVAtZ1y4ze+ANc=;25:7xES25AbrlgFzFVdMdIw2NAzecu70S38LrffHysY2MSuKLvokVRixKMktlCZQ5QODVymsS5oGFGvXnPSWUBwI2wBKNGBZokT5GRE3L0nOkXXtEyky4Xi3sQY1QZ0Ia40JIPweUgd/60V+ragGEgUz7Vbbydz0OVWqWM0c4I1xcBW1m8Fc6WXPCYRhGbhq87cWl2ZeWsXk85+TAgyUUr5F8Fy8PbQ0c92XDXNbrur+YFIkSr+SzHTf7Su/B+aEs9zDr6gNWHDk2eM30VYBfZSSR6Olo+1vHpkR1elbAmzw/dfG9MtI9nV+2saxjdEyGPKNAwv8CooEh+4xrBqUtvRmQ==
X-MS-TrafficTypeDiagnostic: DM2PR02MB510:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB510;31:i9n/o76VAPvBYD2fEvsFgFHrkpHq4proL7ei1H3g5DodW3Az9PBQfafWgIEI2DVwiBeU7wxhfl5iKKn4QJ7WOKknP+ZlBCKGL+y0VolXzLMU7d18Ju1X9OGvhf2lbFo/zj9Me18H7/Cenk2wApW+fyqNusUshJVN2APgPAaOBXoj1dG8xfZyqLqFOxagwhfocWuFiSi8GYLE2nw8xxkniDDGKXIjyDrebct7FG+iysY=;20:xru2hm1y/nBBvNVDijsyuTZlpe9jfJfD2ZV3QRXkPoWFtu0s6BN/21ui0HVdezBnCcwGioa6M+2Q5B3LL9WHPeBAi4DUVemtpiQAQ2vhvdxC4iCSMojwBtohi1EzyMGkGEnkPt5VV9KkLi7g/Pmh2JXd/kRz73upwsgnW3FEuvgBN9nZCOrlN+n1agYcEyR+Oueq0iiWCJwSffDrTflC0Slv0Qe7AbtU+K8u3yqqDWQ7Qnf8RR3SNfU849A2GOrnhf7TFGlqzEc9LdeFZKhS1bXCVEMnmzUSuEVO4VzF8/4X3SNtLRcQcivfeMbvwDbIjVPu6zSVeTV41G87HsNHuQTT9tOEQ7dQhye6BdKnQRav+YgmRG1h3SsnGpZ3MueZZq02a/dQqghEifmcY9BNKVQ6f9phzeYEumsdtAXMf3lXVuZeNkb93PYJKfyD0DRsLoxe61lsbNzGdJENFcJq8YseGopu2hLFtO1O2vG7w6vnQYthHMLkMKA3aiH44Nq1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR02MB51007FDE39284E3AE43FDB0C6010@DM2PR02MB510.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM2PR02MB510;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB510;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB510;4:qWINQ8kf6O5k0VqclK8cCwLVbJLiRF9jT+8uLovaWesMde6GxOpTELqYEy9HmVtdZGiGhSbUKIWY7KXcZxXHfyYEw6JxYS+ttiDEpVANDVWARCO5QgHPbAXyUa/pJJHU8E8Zg3EROAEXYm8ykLlu5hWgqhbRNPQbpfkgkhcl+D1SRAadupqY3+xRtCW/HiIdOq4K7MPYtJ0NKT9tqctSMTRedqcEXm7Id2BZh4CTtECOcUXhbCxCs54cio4FqNWMId2+AlkqF0tOHABCcpVN5A==
X-Forefront-PRVS: 0787459938
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAyTUI1MTA7MjM6aS9lTmRsd2llSkd3SFVmRzM1SWxxZDZCOEVC?=
 =?utf-8?B?YlVsSHB5WmhSQ0lua1JoSDUzOFF3UWFNODhuNWlreEJ0aUxyQ0MxQUI0a0pC?=
 =?utf-8?B?ZW1RMllYSlFKSU1HN0EzSm93SVkyWkZOTXV5SktFTi94eGRIbEV1Wk9JY0Fo?=
 =?utf-8?B?VzRya2YzWm1jV0xKWTdEZXlXMmwzaEZYeGxmdXRWeFR4Y2pIYlZKRFA3Vnh6?=
 =?utf-8?B?Y1Mrc0U4V1ZzVzFhVWtaNnUvcUhaVys1cmp2L3AvSzNLMEJyc3ZSYXFDR0I1?=
 =?utf-8?B?Yk9PSytza1hNZGhUTTdHc3lqMkVNQUVPSjcvb1VSb2hITWNyNGFKY1Ftc2FH?=
 =?utf-8?B?bEdMRmxrV3N0Y0tFbS9VdXRiZVA0MGxCOUYzaFR0WGJnRXhBTlVibUMvdkV6?=
 =?utf-8?B?SVJra0gzZURuZXFzenZ0Q1BXSFNEQTJLRFA5bUo0emMxd0pOenNtbVVxQU1P?=
 =?utf-8?B?Yk12OWtuaWljYkE0eGhEWDJ1bld4aXpUSDY5eVA2RytMTEg0aDFyalErdHJj?=
 =?utf-8?B?dTlTNFRjR1ZGcEppeVNab3NoWVhrRVZOam93Sk9peDVrSVk0OUVNOHQ1N3BZ?=
 =?utf-8?B?d1JVRVhPU1hrZE9zZTlnVlJEQTVoU25KZ01PZjBkNnZma3hsWWhHMGs5Nm9O?=
 =?utf-8?B?aTZiVysvZHI1UGZjc0RlNm9WWTM2NHpQUkJqVEZQTXBxNnI2TXo0R3RXeERx?=
 =?utf-8?B?SFdNRTdscVhRR082U1dYZTl2S0ZoWnhVUUFLcWlQQlFid2RLUy9YTjJpb0VR?=
 =?utf-8?B?STBZZDJsWU5RcTNpMHhYYXFxQlp4dWdaNmtMeFJrREh1U0xtSE9EU01oMWl5?=
 =?utf-8?B?ZmNmU2UyNGkwSlVxQ2tobFM3NVY5Wng5eW5YLzFaVGlKbyt3ZWI0ZS8vSVNF?=
 =?utf-8?B?a3VRQmVURW51Rjh3WW9oV25HQnZKWWovcDUzbVJ2Z2ZYQkFrM3RHZXR1aWxp?=
 =?utf-8?B?MlVXTVFRRjMyTDhIMnNhdC9kSWFWZGJvQlQzakhobXF4aDNuNnVTUmV0Rm9H?=
 =?utf-8?B?dXVKMXk3MUdQSnI2c2NXQVY5YnpWaGhrRlZ6SGUvYkhieXFnalBIN3JxMlYr?=
 =?utf-8?B?Qk5KOGpEMVNlRVJwemZEb3N3aVpsWk8xT1pUVmZnOXdTNzgzRERveHp4Njl6?=
 =?utf-8?B?S2hYaWpaQlVtNVhqK0VOVW9vcEhJMm1OYjhPWXpWSEZpaXZXWHpxODZrVlJy?=
 =?utf-8?B?ZmUzdXAyVFhOS1VseFVoNEZsVDBPSEdlL0oyTHIxeFFKUUk4SmdQVW11aFdI?=
 =?utf-8?B?MjJidFpqYmppRnlqSmxuTHNodTN6QUVJMno1eVhZRzh2N3BRRXZvakNuWWdR?=
 =?utf-8?B?MXFLVVdsQmtLM0FuRE5Cd2NiQkIzNjhaNGxCblYxUHI3VDl6WFBlNWhpUEQ4?=
 =?utf-8?B?QytiY1VUWlQ2elZiTFd5WEd0YlZpSjJscy83ZEZIV3VPOGYrZlJiQ2s2VjN3?=
 =?utf-8?B?UzFiUDFIb0taSzZnYzlmWGpZd3VtV1NQTlhWMytubHJrV01PYVlOOFBleFky?=
 =?utf-8?B?Y2dBeTl3UWxTekRMakdTYitIWnRGdWEwMGczSzRrOWxYbXlJMXNnSmErYkxj?=
 =?utf-8?B?cWVOcUxJOTQwTU1OSUNrM09aYTdjSHByN3M5YXRWN0Z5MWxpejN1cWo2eFRr?=
 =?utf-8?B?RUxXTXlaM1RhNFZNakdSd3U1L1FERlZkUTZ0dGkwenp2MkFyL01kcTdmY2V2?=
 =?utf-8?B?REsvV1dOcGZ5V3o2SklROG9WRU9JUE12TUl1SWxpR3Q4RktOeXZUQ21KeWRL?=
 =?utf-8?B?ZWlsbDI5ZFNqZXFleHNpekZpdU9Ga0ZNR2RhM0NwV0c5VmUyWVdTZ2trN1Bk?=
 =?utf-8?B?RXpxb0M1L2p2MEpuNEd2MjZxdzduNWpOck55ejdROUJpUT09?=
X-Microsoft-Antispam-Message-Info: xtjLsJgLhMLUjvsjvY4RzCbmfT3GrGrCtMrbx7JRQqyWhMSwHQfaTD5PGKOWGQpgMcT6+WTR11mUHi8RfIyV+d4HXRuUdkNQUHcTxRNRt3BVeBuoOZuH+WQ4Q0FXhfE0/uzO4znYGqGXTrK6DedQX+HSeqm3wY1poL8aOROF+lcGWrh9GWknNTQ+Q4ETVPwg8psNrPqapmXtBkUiYc2iL/7NbNkAJXDd73xD96hqG0b7Sg8dcqkDs1RpS69ed+iiLGIIZOZXgdGeAmwUuxrBZzj88eN+rFp1kikd+C4a+PLSqjH28DGzULAiS5hsJO1zSiMRBOhVidQmwhKIw3f/6V6kv7RYI1FsddDIg/t/6Uk=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB510;6:TwcnQoajV29sLYslcEbk03MSfo827WYxxDNDGySyoZOlh5yP8ZaWvRM10yoekjbrAOAw7+V7TtxC+cRNJfkjAAVBHhMxwHQTsLjIQxGv0uu2i0Loyty/j8O1+J8aiFAPTwDEmdqOy95YShPht4fpNttij9FzHwqr8ePjJYSCTfNoKS3a4u6tShyV8bNlQf77oBlEFlWACbFQHc3+v0I7nTv6DH1I6F1Uoc40whfkgEcj3HaBoA9Mr4ejdm0FH2LgvGBnagxozwILQRZK1lQ25zrlv9N259RpTs+O1HQQisugG9kKyP5ryn2VDoOjwq2wb8IO80Asjh456xmphkwNHvyXxSWN8qTyGtIVN3my5sA+sSscWEx/VSZRlgC6WkGh/YmSm8jB0vpr7WMZs65N1PfZ8fZqJiZ46z+z5tYZ6TfDM9GDA3N8f+yvfaYnaf+xhoOwsxHPHtW5p6x5mG4JSQ==;5:UvGmvNfUysOHvD7Qjm28HR+6KWdpyqT40LewsKIGmMtdLiTbgs5rZeE7ebwuQSbXlrif3zGSffTSMvkcHEyGlwFmuuB9AmR2eln9QbgroNAfXO7oiQdEWh4nOt+hs4aQKbtX3Nrzuhh4qfSB5cwnttOfXVowHNLIGPQpVWNoSbg=;7:mERvxJHlgg9AaDw6HKHB+q0Gqgw5DuanKluTiJrC8EakVA3PHriVieUij9VcuXzOITC7zdhuZnZqpmBoYD/MKDGJ0oiRShADm+MFSQzWUQIQeCgvxKJfcObUQJXmbG4lH2u7YhOBlCadYQQUeB1ExkAAjvpGhjQnbu55QbukKZgxf0PJ55K5Sfl79wX2wWEijGF96gaFz+WQpJT99DVPPVTQ+BVjVczgRmKFwdMCPHIJ3WiftWcnMNb3FdZ7X2gt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 08:43:49.1633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d82048a-5ea0-49a5-c52e-08d613d4dde5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.8.2018 18:22, Luca Ceresoli wrote:
> Hi,
> 
> thanks for your feedback.
> 
> [Adding Michal Simek (Xilinx maintainer) in Cc]
> 
> On 27/08/2018 14:27, Lars-Peter Clausen wrote:
>> On 08/24/2018 06:04 PM, Luca Ceresoli wrote:
>>> The default value of the PERIOD_LEN register is 0 and results in
>>> axi-i2s keeping TLAST always asserted in its AXI Stream output.
>>>
>>> When the AXI Stream is sent to a Xilinx AXI-DMA, this results in the
>>> DMA generating an interrupt flood and ALSA produce a corrupted
>>> recording. This is because AXI-DMA raises an interrupt whenever TLAST
>>> is active.
>>>
>>> Fix by setting the PERIOD_LEN register as soon as the period is
>>> known. This way TLAST is emitted once per period, and the DMA raises
>>> interrupts correctly.
>>
>> The patch looks OK. But I'd prefer not to merge it if possible.
>>
>> We've done some early experiments with the Xilinx AXI-DMA, but it turned out
>> to be to unreliable and we've abandoned support for it. One of the more
>> critical issues was that you can't abort a DMA transfer. That means when
>> audio capture is stopped the DMA will halt, but not complete the current
>> transfer. Then when the next audio capture start the DMA will continue with
>> the previous transfer. The observed effect of this was that the system would
>> just crash randomly (Presumably due to memory corruption).
> 
> Strange. I have done many capture experiments with arecord and didn't
> run into such bad issues. I only have a much less serious problem
> (garbage or old samples in the first few buffers), but no crashes.
> 
> Michal, are you aware of these problems?

I have never played with i2c and axi dma. We wanted to use this solution
for ultra96 but we didn't finish it.
Also there is new i2s IP which is going to xilinx tree and it is more
recent but also I didn't test it but at least IP team/sw guys can look
at issues with it.

Thanks,
Michal
