Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD3EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346EA214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346EA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christiedigital.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIQWhx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:37:53 -0400
Received: from mail-eopbgr710119.outbound.protection.outlook.com ([40.107.71.119]:51712
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbeIQWhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:37:53 -0400
Received: from SN6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:805:66::14)
 by BY2PR0801MB1653.namprd08.prod.outlook.com (2a01:111:e400:5337::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Mon, 17 Sep
 2018 17:09:34 +0000
Received: from CO1NAM03FT003.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::206) by SN6PR08CA0001.outlook.office365.com
 (2603:10b6:805:66::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 17:09:34 +0000
Authentication-Results: spf=temperror (sender IP is 216.94.43.129)
 smtp.mailfrom=christiedigital.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=temperror action=none
 header.from=christiedigital.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of christiedigital.com: DNS Timeout)
Received: from CKTEXCA01.cds.int (216.94.43.129) by
 CO1NAM03FT003.mail.protection.outlook.com (10.152.80.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256) id
 15.20.1164.13 via Frontend Transport; Mon, 17 Sep 2018 17:09:32 +0000
Received: from CKTEXMB01.cds.int ([192.168.200.203]) by CKTEXCA01.cds.int
 ([::1]) with mapi id 14.03.0361.001; Mon, 17 Sep 2018 13:09:31 -0400
From:   "Spruyt, Randy" <Randy.Spruyt@christiedigital.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>
Subject: getting a PHC reference in a kernel module?
Thread-Topic: getting a PHC reference in a kernel module?
Thread-Index: AdROqLCWc2o4t+I5RsWiT0kaznr5Lw==
Date:   Mon, 17 Sep 2018 17:09:30 +0000
Message-ID: <BC3A5CD34524E4468CEC38A99142631601AD93A8D3@cktexmb01.cds.int>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.200.142]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:216.94.43.129;IPV:NLI;CTRY:CA;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(189003)(199004)(97736004)(104016004)(4326008)(54906003)(7736002)(305945005)(8936002)(8746002)(2501003)(336012)(316002)(53936002)(2920100001)(55846006)(186003)(9686003)(53416004)(106466001)(26005)(7696005)(5640700003)(8676002)(3846002)(6116002)(77096007)(102836004)(478600001)(72206003)(63370400001)(86362001)(2351001)(23756003)(6916009)(81156014)(81166006)(5660300001)(33656002)(486006)(5310100001)(476003)(47776003)(50466002)(2906002)(2900100001)(126002)(356003)(63350400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR0801MB1653;H:CKTEXCA01.cds.int;FPR:;SPF:TempError;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT003;1:DePE6vEpoHtNSMqSgobipZRYUQZ6DwGT7vdy4Th9ukqIK7bXQDL34B/QzgcWwvqw5kFJKGzVSpSAFlt3xGxrxM/2S4LrgCXkbThRupHB/AabAZvjf0SM56RmbctVaqi7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b95f09dd-a90a-4163-cc6a-08d61cc05635
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0801MB1653;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0801MB1653;3:9d7dUOrjpTksX8Zz1YUGGetWohonpe2nyzQT5q2CggH4BJnx+kEOdRfFZzArXJniel0AEbk6JBGFnfhY0ssaBVXFY1qYG8XJB6nJNNy16/HUlaeDlsaNJoO6WPqRjaMD/+5e/DUNXR/6ALgIwwnQhqOknIULlRu9mhibu0PHJnbxrJYwuPzLekPwe/6PJZt+4PhWMDhpWVr4tT2MixQZbcyA1Kjd7zQbFg0Cmxyuj8GZCM+n9NZOxRJ8lwokbwpuvyJgC+GxA3P1ULTiZ22fvt6TT67QmJhv4U5JQ/5KUzFuzoKiO7POb+ia9f/Gi479OWjzXQlx4XPKHMhZilzCDfju5NRNkFv05coQC8ljSdM=;25:38MapvKvXBSHtBtsqCnzMPQHMZz1LnYI65uKKX0yetnTNbusQ29ckqbi2dMCiTQHsjQZ2OU+ghHN/fhDxH/IU5OjHMCRf4qkGp4oFfdmwX6NuVkUObVk18qa7yBN4QbDn0fmapQM8d6kPfypLVujbxMi5ArwgWfk2uVRhZgik2axdWfMmr4paQYiWR2aimgTKUN2Plx7rqczrUwi1XhjOid8gAokdDElXTz7zwihPKum3BcK4qScUCpJEbIMn4ZZt7x5dNd1SFLqrjps0uN56dkXxERgmdSfixCdMgqT8sfVYLNmfAI/iziGzQYpOUlg7dywOFeqT7WSUpkYl0BPIw==
X-MS-TrafficTypeDiagnostic: BY2PR0801MB1653:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0801MB1653;31:4q3mklB9/LJ5wcCYwqPQbOUUg/EfJxKFw/fvLttPQPf/TZdOh/rDJl2nkwzIjDrSgn6SEAQwH7IobXy7cFt1bq46SzIY4co1R8Gwt4RTLLpg2Q5cddWrpTuTfVtDcNOVVyPXUfjwx4gpbRMGIBY0nXVqnfUpBpmAO+DgIDf+Q4SaigFzYL2GQxvxGAY26P8Io0fFjEDU2x0YBeqk4wbpvImZ4Y1xn6x9bqTB7oel/rw=;20:YAOWo19rnlmSdmk/HcZB1SZ0eWnr6x0K7UQcITjLDaXVkkqtDo/wyA/noeoa0vDAp3PlBFeNgBHjJ7Kv/kD3SactgZgsaoGVK159d1dvOa4XMTCG4Wwnia8YPqXrPKJNzWLT9IoFGYfNlcKrO7lhnRjwMg+1dtVW3TkbfArPKYr2FrHu4amURdJpFFApOxHF1s+2IiGZPd0nTnHOVo4nO3RBytyPefCZe/qMsXB2sXxtU7yKrTosm+VQJwnNCWMJffoSfZU2BdYCrQmk6NlX8UpbjIsLYNOP+GIHTNlP5U90oLLulitQMbFSRyb9SdyC5Sb9Kbtdi9g0tHKjsdtC4U67WEf9r5Bk2t32fS9Sa6FdfLTIfrklanu1fQZ/pKGi1/nKh5BT7kWDwwK3ZowgwKz7SnDS47KTwIWSztouf28g6ZIHFW0P+JQGy3pJeEDF6ALQPLGVpMJtoMEfyKzJ2/owygsl11R04Qz7LkYWUZ0iJbyp05WxfMttbbHZW3Gi
X-Microsoft-Antispam-PRVS: <BY2PR0801MB1653AE6D01D3CC467FC44B05931E0@BY2PR0801MB1653.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:BY2PR0801MB1653;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0801MB1653;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0801MB1653;4:XkUNWoMYZsRCSJDAbZo6TORPtaBZZf6ESyhmX1jxUnGPKm5RByGuQAMHyj6gCgUm1qQ3p8hoPM+lXuT6ksEO3kJFJ+UBdbLuDsCaTIzCxwzxoS+whxYOfAjwXy3GrJXpSp4s8NX4dkdq+RYxCm/7C9cjeA/h4zizEjbp0W3WGYxKONN2OB1sxgZyiWZaR0Xy8od/t1xZiewrmLts/oPadH2VEcBUpZwQvv72MJRPYhrj3kDPfisN8MvARpmJV/SUyjuOIXO12Zh4sXT4FXIcBQ==
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BY2PR0801MB1653;23:FBTaAQsSuP9o3otolhFOi3Qn3Is0wUGduOatp?=
 =?iso-8859-1?Q?JBNXYzC7s1fk1PBeiNchGnoL/is7MDV7a0YC5IlG6x3Yn1rHUdmZbvVTnx?=
 =?iso-8859-1?Q?9OmEUQ+87hbMk7nUFnmyxBHNwz2qLcbLY87hvUHMcvlNvZf3sydyPHhnVx?=
 =?iso-8859-1?Q?1ZXReyVnyUmkUQ7kd4JR6pRDD8uxrAZ/g5ru7dwH7TPxrvoMvwtLvsyLt1?=
 =?iso-8859-1?Q?0PlQk2++6SoF2tpceS+PD8VhmWFi4IZ8SdedvBA1SaroBAW+rpkDqZEd+c?=
 =?iso-8859-1?Q?SGxM8ESmeGqSb81BEvGbaGUs2IFap7h6NPl3S61wll1aZDYsSKvS/PPX42?=
 =?iso-8859-1?Q?F6kzg1Po+okAjS6udyBs+MAkBWl26CzOizVNTMznaZv3MBP0Qkx7i3mcIc?=
 =?iso-8859-1?Q?gc+1FuCGBfupJbrmHZ6Hlt8T1LwiyvPdYkO50XI8/dBaARVV5nDQMETKO8?=
 =?iso-8859-1?Q?iM3z9osVZiwEpdpoqahAJSglKa8tXQtTOBPpY6DJJ4jeXfSChhApcYoVgl?=
 =?iso-8859-1?Q?rUDUsQxuRMDN00jAJC8ilqEasu6tYEFunC3ScG2CDDKyOHNhAvSoo4KjpQ?=
 =?iso-8859-1?Q?rRAgLQA1Y/g+nZiF320At0kmVSuLBBzR07dOs9McoyDru8hIC+LvmBh6vw?=
 =?iso-8859-1?Q?gck0xT4nlupctxelutoveDEZkZ/XUaeKSGGJTE0P2YoUGciFlmY7yUn3DH?=
 =?iso-8859-1?Q?u+8THrYPEIUN8Prh6uGSgYYEbmSydn3+Is3FLFYuaVsWG3tNu0/p8xDjR0?=
 =?iso-8859-1?Q?8z5zA9EyV8KGX98Kv1lHQiJN6bAPaox6DwsSGn3DFCz7BpxGfXpYnzN8MD?=
 =?iso-8859-1?Q?DvhQEt346IV+f3YWH5vRajQ1GcaKXoQUdFb/LXZhS2DFq9GG8YU6SZKHWz?=
 =?iso-8859-1?Q?Pacptlf1UopcFXqPk039yF9aLIfSnWI9bpFh5LueFtcO5pvW+9uq1UHkpG?=
 =?iso-8859-1?Q?+WVWYqoBMT3WX/28MGoA2SIa+82xEGXrLld8M4d02p136fKK2hP5ZgQ1Nx?=
 =?iso-8859-1?Q?DPy36Q74QOdjGp1FtIq9S6duW+Bz4X0X4jqwSH5CE7f0TxRQs9TJHZu8u7?=
 =?iso-8859-1?Q?Lr4YPyATVfVM4TRBTNnjG7l/Y1lDjMLVSWpPdDu6JHmPp8FEJxVnbiGU9k?=
 =?iso-8859-1?Q?FBMvaePinofMnaA6eHXO664Ou9etUUki0cTRzQbqfZfDOFE/nRcXAoBES5?=
 =?iso-8859-1?Q?aBPH+y/d4fCNszc6tNR1dgNll3Grcpd8luFOWYgyHYma8EjIfFjV2cD683?=
 =?iso-8859-1?Q?mTN+P0VJrDLOc6HO+wd6CELL6kEfoKzwBfaZZQhWNP7s3GyXHfnr7Nl5c1?=
 =?iso-8859-1?Q?SAsI=3D?=
X-Microsoft-Antispam-Message-Info: CsPoFw2336570QUmYVEOFciPm/0nGhXQ7XwUnJ59VdL62i3knH3OInzlHMWcGxrL6T/mASau6EpaOdq6XtDeRrSGBxAJjoa7tey65Z+76mTYTVgP0RXr4N13MYp1DwKteQ3B0qloFlT2+DeHTVlTqROCJUZfemZCvjvOsUtPUGCQkxnHEVMjZebjdUNkAVsauta2Zm9lTCCsSGpsPzbPPq4ipgiXFOshovWvIp0OxLG5A1LpDB+xfFOrzHAqZbQ4m3GYsnnH+d/uCWmLK3ZnWAtPFSsFz+I9YYBDXuy2kEcoJhWH3yK1kh2mf4oWw3mvThJw5InML7x4l2wGXxmd41U1aEwprbC6LR/5DBQWKsA=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0801MB1653;6:YrEcNG3x/nfh75fZDwo76i6EMZBgctGq8zSfx3+OaSbd5Zeh94a77N03Ux1Gl8cvftTFPbMafScl5pYLeeuvE0AvOyYzVGMSqj38XlNesX0Dug4fkOAaxpjE5f1t2SmAa7sWu5KxV0LqSNN2+/kcfpjg6/DZlUyMhbAiaAeJPJPIhC5hmQpzqOOXfKCcZvR20tB4q17/c5dkpfUbDnVxteU69ksaloTQzLrREhv123mecnJK8KpbrhYJNowWj6od3N1p9Xm9JG8UYBNIjz+Qf+XPDaJaTR5eLDbfZJdZkH/1pQGqis/8GHF3o2Dg4dcISJp2AvGN8R5KO5NnASNjflEe3qmhYAkcbMl1tfzIGKyqhd1Mr+Al/WKGbCHUOERs95GlXkrHrrBMd99Vu7uylDl0OyqlD2c4zztWXpQ0YX0V1B61rgoAagFfRlvR+0WtBGROMAgg3x+5Cw+w58EXAw==;5:f+K+cE9IeZag2/mZ6A3/o/6Pfq8Y0T9hJ7JiFM1eC2LuN4L5FyZV1XP42Myo+3TGAwn+a+9ZgNrUdAXYZxB4A4G21jfykx9oVpuH369ks0NVFq/OPslTiMwbz86rYKyoUguBQ8UQQJQZlOlpHHM2sEgnBr5MYci99te/s18gIow=;7:Psxxj5AOmdVQvJ2PqKs6ayUiiXzZ5R7K2XT2CWoHWaWZ58fw2QqqgLxCPX9lf5E+8ItKva25NsUa/gdMK3Zw2zK3k6h32p9jl5w+AbGh1jb/tgI5fKKFt0y9QiCQFJ2p6acC7zgbKK46N47VCrzu5cLNjnV9tK645ZYbAd1JC+IJgAVpo6XSQFJQXeEx/cg+LOSxvD7+AYVjRI+wGmHBXjisVaeZXRvCgecsxM6+ZHbkwBePmrUzpXayF300sJbE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: christiedigital.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 17:09:32.1887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95f09dd-a90a-4163-cc6a-08d61cc05635
X-MS-Exchange-CrossTenant-Id: df46f062-ad2c-4076-88e6-c675c789a0d8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=df46f062-ad2c-4076-88e6-c675c789a0d8;Ip=[216.94.43.129];Helo=[CKTEXCA01.cds.int]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0801MB1653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm new to kernel driver development, so I hope you bear with me on the question. 

I'd like to timestamp an IRQ event in a kernel module using a PTP synchronized clock (e.g. the PHC from eth0 = /dev/ptp0). E.g. a GPIO pin goes high, I'd like to keep track of when this happened as accurate as we can. One option is to use getnstimeofday() and have phc2sys synchronize /dev/ptp0 with the system  clock. 

This seems to work but I feel like there is a more direct way to just query the PHC clock e.g. using struct ptp_clock* and gettime64(). The question is how to get this pointer, find_driver()? Or something else? Perhaps this is not exposed for a reason?
 
If this is the wrong way to go about this, by all means, I'm open to suggestions.

