Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F693C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111AE2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Njs3Cgga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeLTGxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:53:04 -0500
Received: from mail-eopbgr790059.outbound.protection.outlook.com ([40.107.79.59]:62379
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbeLTGxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6HfhhkMwsbu1mpQ50VBAQUhCpgb3CPrSEafnaaulSI=;
 b=Njs3Cgga6Y3JXPd5wywB6fF2PCTbDoAnCWX3t6FY3xQTsa+09R0TFgbKDKCPU17VCtdjTOw8seXu5DdDiQRjzHnCAuYiuiVs5LJTmEzDUA2AXTx7PAo9zaQYxifhhmhrHNU1iQMH7ahMppn3U6gJenc0pKYFS7hiVYdTOCDH07w=
Received: from BL0PR02CA0067.namprd02.prod.outlook.com (2603:10b6:207:3d::44)
 by DM6PR02MB5227.namprd02.prod.outlook.com (2603:10b6:5:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Thu, 20 Dec
 2018 06:52:58 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BL0PR02CA0067.outlook.office365.com
 (2603:10b6:207:3d::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Thu, 20 Dec 2018 06:52:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vanmierlo.com; dkim=none (message not signed)
 header.d=none;vanmierlo.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Thu, 20 Dec 2018 06:52:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gZsCV-0001Zr-PR; Wed, 19 Dec 2018 22:52:55 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gZsCQ-0002eP-Ln; Wed, 19 Dec 2018 22:52:50 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBK6qffD027733;
        Wed, 19 Dec 2018 22:52:41 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gZsCH-0002dV-GV; Wed, 19 Dec 2018 22:52:41 -0800
Subject: Re: [PATCH v2 0/4] serial: uartps: Driver updates
To:     Maarten Brock <m.brock@vanmierlo.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial-owner@vger.kernel.org>
References: <cover.1545135519.git.michal.simek@xilinx.com>
 <06bcd18cb2e0e81d3051ef6305139d40@vanmierlo.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <be121f63-fe03-8b50-54e5-24865d856e56@xilinx.com>
Date:   Thu, 20 Dec 2018 07:52:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <06bcd18cb2e0e81d3051ef6305139d40@vanmierlo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(189003)(199004)(9786002)(65826007)(106466001)(77096007)(26005)(76176011)(23676004)(47776003)(229853002)(2486003)(5660300001)(2906002)(186003)(65956001)(65806001)(316002)(6246003)(50466002)(4326008)(486006)(2616005)(356004)(6666004)(446003)(11346002)(44832011)(31696002)(36386004)(476003)(4001150100001)(126002)(966005)(336012)(426003)(54906003)(53546011)(106002)(478600001)(305945005)(230700001)(64126003)(8936002)(36756003)(31686004)(81166006)(6306002)(8676002)(110136005)(58126008)(63266004)(81156014)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5227;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:hxnFJl3CjMsIoOiP/1WmOYUcwEgcaGgdkDQutM8Z6s+73npHGep7fE2l4SHNnh/dJqspIjqgzfge7wzk4kSAdekkI8FPh6b70jLMdLSSVRh4rZXON1IouP09DgP5fOdx
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 999a4333-0fe7-4eff-53f4-08d66647c5ad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5227;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5227;3:JXQsVL5opVzzo1H3pbjTWetetuE5Yv8x6mv5SueifKDhW42RXLP6Z5fvsS7u+fc2rbOrq5E2vTTPqq5WxIk19CNRdg+FD3HjkrvdrI0RUlaJ+VJqHH0WoZtqRlmXV3U5lJ/yvQy0tK4UJjw95l84B5cskEz7Y+XA0LUAUxy2yvl6/0Xb2Dyr+9p1wrHccNEPjLS1IXhcbLPT5DPlwJbT3fBkGM6k9hZDwv+Q2HT6yPGvotgyzNqxN3Q+902g5yul46jOps+yEsiRfNi128Um/8ShZyotej4j8IaPiOxrHG22Yzac29LoCEq+MDVW2RbOymOAIM2rFHGnFvy2NmTfoF0H0064bheDt7u/l6/cTiA=;25:DJcwxfYuDg27oislp+QDbgO4biJwLp2tNz3bh8UJNfZfbjvfmVsweDFpBMV/PuSW7hw+wUfYvEZmmiy3lw5KbcJLRzPtYfGiqPHwr7v80w7kal0vAYazwwXpB8ocHkZe2rY2to7+jEZmSzM7Fl/UFe40LndxC3oRKcefkyDnnpuOwhQUhpwDUVaLj2xCydfncdh7oXemywxAcmkh/qsMXSFchpLxjxxdBLvj01jqbEbQKzmru2csk/o3ViCc4eafvz/omFvwCgRoEF/Gjl9x9Z7iSWHj8r+jlRp1KGjkmEvXxtlU6bNyhBUxG0jjBWtxKhY+gg6YrjtZHLYDbnWalQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5227:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5227;31:03Xh0hAvgaBKe60pvvoHlnKz63NfE7GTNutnip+n5CQqNgyuVPw8qyzs0OuzAFRp1m6A2681w/RjgpcvS25DYYfaryECW0zYMaBzmVQ/aDrU44tfIq6A5sHWD6pCxGs+qmIrpdJbRVWVsTeMtdp6G5ecqTqfz2lRLHi+krmskCxjwsFBaSZIRBjnSCVIjmUH9JNkRqWGVJzv4b6F2jk5i4QPVFTZH+BpXrdjnyAGCt8=;20:Veeok6KcNE5jNU9kNGpHleWkncf4KT0u+gs7Jd1aqCuUJEKT57f7A34RTvQ2QpAvwrMHNPkaQqiH/1Vxnopp6qKY6mFqJ3fIfJHrtnFcUA1Xiq3jDHNndH6lv20Q9iB0gRE94by4BKM/MDpet6MoXtmv8v5yOm6vZmpZ/NHbuITRJT2gVqPak4RUNtbuyy194bn18B/Qs9Wr2NzKj33aoqk1+U6QzOgPLE03UfCq5/iSqmZK+qEgSyYMOit77fkJikPy4+zRYBdDlKEtrLWLV9JtA8VCrU/4GzLyNpHl7IkpP32nl1iGeVhnN3VM4UQa8amFMtuhBUzagdDfXD/19Jr4sY08JB0Nb6Tk0QHCP2VcgBykkO1Z9x3bZ4ackXRxM2aKhcKOGM3ZwQqRhIlS7Mb037lCTNFZIijq5G28BWaXGFN3oNgmQwS8gFbRLG2otkqnG6tth4QnSKpp/kYfFmYhiGGMEUBABwe5KHJJqV/khs6HVOwpfcpJHPgupjor
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB522785D026F4D8A5E708DA5CC6BF0@DM6PR02MB5227.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93004095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB5227;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5227;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5227;4:x4BQBC5kTilTxMwEfAY5PvgqR4PrcA9K+5IEyrdEoJZm9PJz26EEaX1kAVxACMSR0FO9Pe+ZAw9RiULMayYJbMp79kmuysCqqA5Q01FjJrjUeEsE1yp4Zvjfxkehw+oWdyXDFrs1CRyopGhsqGZYk4ZZ5sVu4hfygc0DpoUyDKpPWm4W1ZnzXqrXUZeKbeh02SA0/tVU3Vuh33+lxTvL5xXUrtSxmD95LCm5bK0yLj9OE27pVHvNNcfZmrJeAlGNe0LxWNVrLVlRiLBtRlZgKw==
X-Forefront-PRVS: 0892FA9A88
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MjI3OzIzOnpkNy9TMWgwZGhwd3ZQZ2FTRHVKODgvcHlT?=
 =?utf-8?B?UG1rVDhBdXc5SkEybzlxMFJtc2NBbmowMWpZMVlaTG1jcDFPK3c4M3diamJ1?=
 =?utf-8?B?VWRWbDIrTUJHYzA5VEkrVDNtTi9xTGMvSExzNUE2UzQvR3hVQ3BSZ1Y0cXlm?=
 =?utf-8?B?SE85QzNDcWNCcWs0WFlhbXV1TWxTU3JIeWw4dHpLY2RwMDhkODFkY1JTS0p1?=
 =?utf-8?B?M3kyTGpDYXc5MG9pUkxUTWFMSHV5WVZmZnJER2VXd1BESktlbDVPaFh3bTd3?=
 =?utf-8?B?Q3d1bUl1WkRiTnkyTUMvNFk2cjNRUjlkZklLcW5XWjlhVkx4NUMvSWFWaUIr?=
 =?utf-8?B?MHh4bUpab2FrZGQ1K254eEVPcytJTERDMWR0L1RNbHBaaEhqVzVSdVJ2bGg1?=
 =?utf-8?B?NnJIQWdSdjFzTG5rMHYydzRZOEZrZmNFWHBxSWZlakJsK0tUc2E0cUpYNjhu?=
 =?utf-8?B?Q0JieVo2bTZOY0hRdmJIMTFraXFLY0RwaW0vZFIrdDVkY2d4K25xUlI0YTRK?=
 =?utf-8?B?U0ttcndDMS92T1U0emZoSzdzMnNraUlWY0FnVWRzSFMvQUlqQVd2WWF5OUVP?=
 =?utf-8?B?YXZ0aGliNlpDQjkyRnNjQkpqNnJvVlBsRkhRemlPUDlrdytvWjZxQ3M2TzQ4?=
 =?utf-8?B?Y1FkQ21kdmpKUk5uMnlWNEZBOVZ5b2hNOCtNVUFySkh3NDhFSTEycy9lQjRr?=
 =?utf-8?B?WE5yTlVoaVR0czM3Ry9GdWt3blhhWTg0cUNrWFVlS01KNHlJQStnQ2RqckxD?=
 =?utf-8?B?d2x2bnZMWGk2WE1YVkVDaXdNVjJwNDIzVTZuZENYMWlrbWE4M3V5V2ErTUU5?=
 =?utf-8?B?dzAxZGFjRVVBSWFoN0RDSEtWZkUyVlBmWG1oUGZwQU1NYU9OcEFuY2tNaFVn?=
 =?utf-8?B?TndwSitPZ3VXZGVWK2hqbnVTWUZHVHE1TjVzNzJjaGxuVXZMc042OHVqTnhD?=
 =?utf-8?B?dk5oTWxkMTBvMVRGbk10YTgrUU51Y2p1d1NKWERVUy9lVlRtNkhWWDlaNkV6?=
 =?utf-8?B?L2p5VFVDaE1LZmhPaEdCSEhJNXRKNnUxdjVrcnpTb0RsNWJmRkI3SEJlWG5D?=
 =?utf-8?B?ZHk0QTg1eUxDWFU1VU9SdVg0Ymkxdlo4QzBOaFl5OFFWaklENTZDWG96YkZL?=
 =?utf-8?B?RnFNb2hDODhCUTAyakhKNjRmUzN2dEd2V1RzQVJnek5oRHRERGVEanAzUWNB?=
 =?utf-8?B?c1ZEc2FGa2ZoTm8zMW5HZy8yYWcrK0pYaUY2QXRNZzZsRFNFL3BiTkF4ZFpO?=
 =?utf-8?B?SHJEMXRpM2tGM2NZNWNYd0FYOGV1SFJqenFCSit5OVgvU1BKbFpCTStXQTRF?=
 =?utf-8?B?bERMT1o2Q2pkNG1RNURvUnZ1TS9rcGFWQ0ZZM2d3bDR5QUYvZ0tQVHhWekZH?=
 =?utf-8?B?bU05cWhMcytGMFplM0MrU0VEeXdlTmZzT3laNVdOOGY5WllBNE9SaGdMWkpa?=
 =?utf-8?B?cjhZMFdsMDkvQ2x4RWZiQzYxVWNRUXNjYTJHWGwxS1dBY1ZZZjk2WVRnSDVl?=
 =?utf-8?B?SGtEZVJKOU1TamFFQ1VYVmRMNmwrc2U4akhzN2NGL3EwMmVEcytKMGEzdWZV?=
 =?utf-8?B?cGtZWk85RHIvVGNDWVBFbUF0ZEdxeVd6cUlKSEdGajkxWXpXYjNFZnpYQkhs?=
 =?utf-8?B?bjc0NmFvOTVPUjZrc0xXZjlMOXV0aklJSU5sNlo0MW9vNmJEYVBlMFFOejIx?=
 =?utf-8?B?bDVPNTZnVFYxNy9vNm9zS3o3cCtPdmpGRTVZSnFtbW5LNHRmU0d6cWJBQ2R2?=
 =?utf-8?B?YnpMdEdKUUM2ejNySlEyTEtldXJVa092RFM1Q083WHMyNVpTMmxKZGlSNDZa?=
 =?utf-8?Q?uvl8rADiul29q?=
X-Microsoft-Antispam-Message-Info: IrtdtMFgMKgzhO0K9P0CD9Z6XE8/o3DY+4QZ5cn+wvrUAWeOT1nxbd/i+VCPR2d0LfdAuSCn+aY7GXWvwN9qp7VuflLo7WaEYFEa8DDSk2wbIiYSt5hr9O80TGn9KHe+B9VPb7JZeIHA3bR0wPHLURw4x/dsvUJjoX4FX0B5MjvQM0m2P7ZcIkRzQ+6rt5eT+bHglP5dsUP4CHQgp91/64/qf62H5XB4FVJlewpa+BCT1RvSzf9F2Kj/nwbn2jwj1IpH9V5XcnUjjMDt9YP/u1jg1mhHoweIeL7EMAyGG+m51ZQ7ccz8/paRPIW29o9z
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5227;6:mbvWuSyYERsOyrlYOaVrMieosmNkDvh0Yj7UJ7OC7Jc8CYs6g+LadP1s2C6UjIxR7FlkBVSODJ5wF5GH7ppsl3xoRvwOwRLcE1iMqq+ZW3cAdM9vPi0EuGjT0nMrwpLR/NLYSinNQFTAw5PBkxzLDxFvq8BgVis1dsIYaCCNeEIYfNRQZUt/RTyVMBHwM9/zaX1BgZwg0CJgMP/NifRuQFgH4pmOYcXPTh2pqbMo6WoZzYdO9PhxbueQvLGVPPwRpxG+YnWUne/KE6n5iQ1cRtx3qfBm6ebgsv6XgtXeux/TkC7bskzoeavVzqtIp1kW+qOfCKM+7le3XNVD4eccFNLfZvW/1fUsWZB3LkoqbDICsNKvkkjB254KF0+x+aTHyOPTxTtZuqmOjmXZMStT/dNWVk6JNYA/JgqOqgYcPyhPYMSshaV712s9WO5djKh0Fvd1dZ1cYTC3r5+EV8A0VA==;5:ofZcoutTsVSARx0KmakVIu6T7EUeDA9oZvM41Aq1+u7ngSys59wmFmdKtE0wjMgZz6/faB7LfUjOWrtV7ld2Rj8yoHsr5+EsveyTClAg+NGFXh9vTJF5aLBteAuEzWmgc+teVCZc3NbYQjNq3EAy1jWWcx7CL9fAPqbzALtF+QU=;7:mxUCT1xh1fmuKu56o1zU7wdRk6X33DHeigxJcW8Gzn1gGqdWEZ1NVkzcuTRrgbZFHx1pw6bdi5qgoqjHC58tI1+hoPLyb4njMENCHalA2bJSZ5Vrc3DgvVTd1RaUjmcT/fEkukXml8o+2JhnyQa85Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2018 06:52:56.1717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999a4333-0fe7-4eff-53f4-08d66647c5ad
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 12. 18 19:40, Maarten Brock wrote:
> Hello Michal,
> 
> On 2018-12-18 13:18, Michal Simek wrote:
>> Hi,
>>
>> I am sending 4 patches in series to fix some issues we found.
>> Patches were sent separately but I have been asked to send them in
>> serial that's why I am also adding cover letter to explain this v2
>> version.
>>
>> Thanks,
>> Michal
> 
> I'm wondering why, when reading the linux-serial mailing list, I can
> only see this cover letter.
> Are you perhaps using a different To/Cc for the actual patches? And if
> so, is that on purpose?
> 

I have checked linux-serial mailing list and I see all of them there.
https://www.spinics.net/lists/linux-serial/

Individual here.
https://www.spinics.net/lists/linux-serial/msg32919.html
https://www.spinics.net/lists/linux-serial/msg32916.html
https://www.spinics.net/lists/linux-serial/msg32917.html
https://www.spinics.net/lists/linux-serial/msg32918.html

Also I see linux-serial@ in CC in all emails I have sent.

Thanks,
Michal

