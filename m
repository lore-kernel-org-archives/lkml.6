Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F157AC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983F220846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YL5cUAIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983F220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbeFTRl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:41:28 -0400
Received: from mail-dm3nam03on0043.outbound.protection.outlook.com ([104.47.41.43]:17024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754288AbeFTRlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL4iAhEb8WnCRtMCcMrTO8VhRxkUm3xnzqqZFS0wndE=;
 b=YL5cUAIrbwgsCwgr7fN6P9RY3m4qM3m5OYdTH8/EodV2K2bklQ/7cTd+SVOAiX4fxQxgQEUaN/4oRsF36E7EpRMEdbJd+SCbh9sttKKaeXbKnV1UL30XZhbU/3zKGTyPl1OkTX8tGyzu0lnaQwy703yNY34TWyno49LA6QagUak=
Received: from MWHPR0201CA0106.namprd02.prod.outlook.com
 (2603:10b6:301:75::47) by BY2PR02MB2149.namprd02.prod.outlook.com
 (2a01:111:e400:c506::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 20 Jun
 2018 17:40:58 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MWHPR0201CA0106.outlook.office365.com
 (2603:10b6:301:75::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.19 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6F-0002P4-W5; Wed, 20 Jun 2018 10:40:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6A-0004lu-Sc; Wed, 20 Jun 2018 10:40:50 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHefrx027141;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh61-0004hY-SM; Wed, 20 Jun 2018 10:40:41 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v9 04/10] firmware: xilinx: Add query data API
Date:   Wed, 20 Jun 2018 10:40:29 -0700
Message-ID: <1529516435-7315-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(63266004)(2906002)(11346002)(446003)(44832011)(336012)(426003)(8936002)(476003)(2616005)(126002)(486006)(106466001)(305945005)(478600001)(72206003)(36756003)(50466002)(48376002)(26005)(8676002)(77096007)(6666003)(6346003)(47776003)(186003)(81166006)(36386004)(81156014)(5660300001)(107886003)(59450400001)(356003)(9786002)(7696005)(51416003)(76176011)(39060400002)(7416002)(106002)(16586007)(50226002)(110136005)(2201001)(316002)(54906003)(4326008)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2149;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT062;1:YLSEQsgVF4sWdA7AmmIfGFz1pGbDw9dmUfvOxZpGQoBECILCeGsCyjqBMpmxLNDf431O9EsiGk6pl3XHuLLd9seo7jKolpR5GatDZNIGljzRGTQ2Kf3B2nAk4lStopeN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 241c6f00-a892-444c-8886-08d5d6d4fb0a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB2149;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;3:fe/hqochI3dCXn6cCBLR5HDaj9XPGKVuEPqV8FFZ1URgPhb2csyozoIOuR0JpvlbN/bE7mqLb7g2pIcb3Ob/RsbdF98VQFJNlavxt6sIsG1jgXLWVa91SuI/WfXTasnqOcGOXECWDGcEWjqJM36jOWUHae+3d6iszN7/Gg3my5riCN0qlhc4eE1qYzCBVDNRpd4qr1VjE/hbd+oJ1PTlk90BN26JsEnQLgjtY705LbB/8C4zsB11xJf1jjL1RYp8b5FPlkPgThMIz+FbT1hnJB/eoE4Px5fbEmHRKVnXmck9AzOrDJNX5lLdeB/Ttb0iMBinhHeSAwDcG+7JUdv5Eyq5Mr3E+ljSBYZGSwxII2c=;25:IGr247czqbOk334Hr2gy2IE4HyTrGhv86v5qP3DET+CQHA9fbJYQp6JCD2dBb7nxf87tkX2KCWHMkM5QtFhBx8GIVqNggSWGOitW4aNxYoFi1hwDDBlPmoqY8mv1+yGkDR2b8Sg1zHyZ70K8wWxjToIi8itEIykCSZrmCJAnQlNwo8J+//zq+QYZzQy6jB9h1hRySJ4L8TU4Qhwn+AZRnSvqxoZVfeeVYOgtWbzBnju6tgekGa2bZ9tl+vXlyZAVhtKPn0F2P4aI1XV0i0PcaJuo+vDExm8eRzLOeBEAhMKWMJ/FnWR7PS/qw42fsT96FVNs/9nDHe+iTU4iPJPkxg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2149:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;31:0w34eK3GQ3cWsBYoziZSxWf4TtmvTKXEYwwWchnOnHLDpHmQ+a1PQe0DhR2UN3D1sw8EFrYgOXjP4YocOxr4Ces6Q5By8hivdEqaVjoE3olfB5N2RmEHgxYXBvEyqtxoegUW3q1aXId7h6Ps31xaMpO+LyEjPT+4P1gLE6QiB6AJW1d4P71sKZgM1CtoKmcaYFkY1drskFPHZslr2BDbEXPFqV1Fag8OZv7kx2f5Dvo=;20:vemhAF5pw16poOvubDNMOiNPPzq/aIicPBtj+UpM+sTNBgwCb9NdCEC/5SKTO/tBazBWN08cNRa0uNS2DoR/WkPGWCkzWutvQh4aJ1bhPRK39DM03K7PQTPGWDmlryT7E9XRE94/Xv7UX3PFpXRywM5zBvkSIpn4ubbm8qhhcrcu6fmX7EGhO8z/F4UiAj8gsWcTvRdDkKjx5h7gl/CPGpOTvrtv1yLXH2N04EJuzyUim3NP3A3IGa/dc7/qjsT5IoCgFiOKR+Z+wihyj64uzKiuycIboKhqBnZAeUaa6u7oNGl5EqyhOZKLN0HNnK0dDW36WjjByFyNA1hjXgthyesCk31z4obPj6y8W+k5mGB9ZvOV6TQBphzxSZVqCcMg2A7kTOApCjDhNm2QjgF8rhHB8zKunREkZWxcSZjbBAjBYgP4Z3D0nfGfoKaFsMStDoabUe8j72L33nkvEhr6CUSSCXpNAEJf9non9ja0HFMWUqWVGcFDJNJeGUASgIHz
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB214902D80C8430DC9835C35AB8770@BY2PR02MB2149.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB2149;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2149;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;4:TpcJr+Rhr3CGDRGzifj4LOgqJmc0nCsMOon+r4+w1RDYG3fuNmjIFcXiSGSLibqNhlFnian6YqJ83yROQHq4ACdtE9YRRQaXZJUtQfpG2s0oNwgC6cJ1f4DmW/4YuX3qUBmVD8j7ZqfHEX/8OSyFceW1XfOqrvPOwGZvwhR3Xebqdd73sCc4wsZHbaHAH3LtbKKBt0gLNZN9EEgAIXzpyxznbGgXmDjQ4F/6njIDxAcepC7V3CJ/WITmrdYw4zihQkHp7ZSrdBi+sfz/mc40K5tgGdF3EBkOPmNY3LoOD07b3VMXneMUtV8yXgAjzvqZ
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB2149;23:drtMMv12vuCKMHcJjpLPYmGVxWIK0ywVOGurUm9jo?=
 =?us-ascii?Q?qV1iWcMPYx94hZnbckEefHEpxQXlAG4rU4Jp/xhuEuuAtufN5IZOlfw0pBar?=
 =?us-ascii?Q?Blu4LpqVsnQGGp8pjmgb4UnCsKZEAPD8F8oDZhhuV200c635GGdNV/BVo5WV?=
 =?us-ascii?Q?TMAFcTgrZEvSiFUhYRS+gyNr6UWaAtkzXJ0rJb8FcjSYnQyA/GikJVLn5hUM?=
 =?us-ascii?Q?s+fnuXUzeJLmg17awtcqUOAw0AXu1G9bF6ArhXl07PfH4iWDcss8Orx3TNEh?=
 =?us-ascii?Q?6fqKz8A2pbNRUEw23yUDNB/WNNzKZxEF9L9WVyW0d0VhgB11pCmagsnJuv12?=
 =?us-ascii?Q?Zm/oeAKJ+DQgz7XQKR2MdNGW8SRGyr0yNVAybvtUd1nOqBHkjvQIRjWcdkSz?=
 =?us-ascii?Q?N8YFKZ+gxY9hg+z7Q9X6RB+UeZ5H9cH3NDJXvaKUsF6J+E2bbJOGkyPoIZ/l?=
 =?us-ascii?Q?YWkmC5seYuJHk1N+mtemgX5wnN0thqztg8th/PvEmA+FTJtRSXaSmobO3Udl?=
 =?us-ascii?Q?jDgTvvYtb6dU8jcEIhOJji49X6M6SDrph86GthMSD6rImJxy26Qw0MFlFV+H?=
 =?us-ascii?Q?QsfTmcokTIjIBSftmVUhO2r+Rl/Qi0PoytjCALSyEBV/m8DJ55JZ5s2i/Odd?=
 =?us-ascii?Q?4yZEgyYI3t41irUkJaGEIsJAhTmXlbcdyakzWt/yhtDS/bMyAwZ5chpWEph7?=
 =?us-ascii?Q?N2a77umF5HtYjowfyoPd1bPxsLV7uGnPmc4VDqcnzzFQxhQJxgDEX28wZ7ST?=
 =?us-ascii?Q?8GxGPKoPlDTGZt4CYzEbAX/P1a4BGSMSJ895m4HvBV/fFhqOX3WsmZ0PRDJW?=
 =?us-ascii?Q?f1gXUSomSIIknKNTaJDBjIigPVWobsIlb6W/KTnD6DQf/QxaHTl2ApYWu8T9?=
 =?us-ascii?Q?jsGu6B1hKJgSLcdipH9f75P5GKcINDP+0wr+CxtzCNdIW3d35TDM7bS/PYJD?=
 =?us-ascii?Q?HXQoIPX71xri+Z67Y6VJ3nd+gkfi1zYacBgTFmJlXGCn7AXOkrC7s6JDHd44?=
 =?us-ascii?Q?BfgaibbGaNJz80NBXfxYeilmBjdXvXO/BcsVpkI31qI6muGPrRiU8H+VN4Q/?=
 =?us-ascii?Q?vshDZv+GaYbgHkli+BoMi8C3V8bPDmGWKg+TXUiAcU3hHy57CG+of3YAr9mb?=
 =?us-ascii?Q?9JBfGdINQ/7s3vuqDsM62niDc8Km8DD5bKxRNGLnlLRIAieeSEUTvRrkWQqH?=
 =?us-ascii?Q?mXVPcBfw+DUmYr1faoGb8K2LPzV9f8Y044ol7Vvt3eukSL7+6HjEuJYTwOHn?=
 =?us-ascii?Q?iinEqRyEY3zlkPyJz4kWAHhnqfRVkaxkm2HB8Wc2j4+B72ixF3fx1v28te+F?=
 =?us-ascii?Q?MsKzGf0m9TJjlb2cxW3LIw=3D?=
X-Microsoft-Antispam-Message-Info: n8CT8hDthZGYCRTh3Kk5LgcH0055j+yJ5uTuIHRhkJuBqfnp0LZasPB/x/Zn4rBmIdgvyh0sJuJyglMrh9g/zeS2KGy+PJZITBpQ97lMGw1qgdwuo4bnqQpporSUrJVsgpSiR/XOwVPapCWqczf3lAtnUhLxivhE/JgIOJcwe9XSboVBwpNx7AyOH7u8/csTOLPYc+nCZoLXq+zrHJ08VKeT0zZ3r5Sq/SMutqHIvlmfGrR57ubpwpxKPsKPHsRxaia+8czHT/TmoHs/HgS7pNZfNTJTkegTyTo15rHf4PdScEc7lds0ZgaUApxSJnb3a+TmmOv0soNQhqHDxY5QeQ==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;6:07W0KJgpjbr4rMekNsJjbDiyZU/u4XshTMay0vwxQjTu+1RKb+DKXI0OTb6j6kMojoOegt3mmigaJbYoGb1GS2xHc0qepfXc1LxRbRM+rI0V3suWqaTosF7oteG1059mdIR5Axq8s05YgSAAPGo64tjrK1bCvElAzfolttRiEBF5OOsQ+iCd/HAtk/jdSiBdUrKJi9juLq9IlfPR+xQMf4EbUTGYD6wOCtHbWA3zvVup+WoD8F7G75MQGTzxkdq/BgXQ+uuHw1RxiJ2GZx2+y0LASW8DfPACRx/h9SgLy/pRBZGwvro8yFxyIOACbCofDSWu9CQvChQXyDZ6tjwKjZXeVuFrtAwdoc1su3O+oFXMrpnZJ72Gf1ZlDbI5rH/q5pMTMnV5oMO2AZxhfW3SmRr1pZxXNJtMd2IGKmoW07zL1qfmVTgGRycCfwXBnr+kPLk9hUok5hBsqWOtzKshfQ==;5:rp3mpqFdYCiWLkEtb0BKxiHFqCuidkqwLYPSoPyv3sTiLqkxata5KVCHKLP+kxwPmCPi0dQtLmzvl6YCnkO4UbL65n5scfxnbDTWZspRYDivL8ElgwLOoeztZ9No/sMRIeclcwae0iJjSRLCP5Uqqmd5wgd9qk78rq80Q9guGCM=;24:3jK/PtP1770qpmdD4dQv8mgD+Wltqiugt4293MDDphcBggb7v0frNubKIAGzwvsuGoVEQ4L2Z6PhBqwS/lT5T9pIuAe+aU6TlG5mzBPMKIE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;7:nHhtAGRk2gg5wKf8E6om09Z2+zJqTZk7lyspXgtxrCOBH1Y6qOAjOxEAdtlFcpK0UL64Vb0sksUeRUo09RmstpiFHImIw6bK0HYZEpavjW21DHx+t1XfYu/25xNlTZaAFKl3Uyx1znNeQ8Aig0LZyYxIBpZ+ynda+HN72amRkG4DOTMHCuD3D7YQYZgGxVYMgJGcnR3ZGLedvxllJrQ4koADZEjamdEfCXEJJS2z2z1SOuxIwr3WpxPTgZ53CwBj
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:56.6287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 241c6f00-a892-444c-8886-08d5d6d4fb0a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware query data API to query platform
specific information(clocks, pins) from firmware.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 34c5ad5..86d9bb8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -260,9 +260,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_query_data() - Get query data from firmware
+ * @qdata:	Variable to the zynqmp_pm_query_data structure
+ * @out:	Returned output value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				   qdata.arg2, qdata.arg3, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
+	.query_data = zynqmp_pm_query_data,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2eec6e7..354385d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -35,6 +35,7 @@
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 };
 
 /* PMU-FW return status codes */
@@ -48,9 +49,28 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_query_id {
+	PM_QID_INVALID,
+};
+
+/**
+ * struct zynqmp_pm_query_data - PM query data structure
+ * @qid:	query ID
+ * @arg1:	Argument 1 of query data
+ * @arg2:	Argument 2 of query data
+ * @arg3:	Argument 3 of query data
+ */
+struct zynqmp_pm_query_data {
+	u32 qid;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

