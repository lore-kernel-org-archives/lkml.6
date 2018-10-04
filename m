Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C454C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE852087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CozvtzaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE852087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJEETl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:19:41 -0400
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:37281
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbeJEET1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rD8kb5Xy2+50FqmSCXWi+Kby8swKZ//QQUSJyBi0dM=;
 b=CozvtzaQ/3+yydNtc/MFDJ6WRHAk+5Y6qntCUVPRbVET9c9zOBTtUfSq/4HbSS3ICYduaRMBecbUS8N282vQm1QmwJRe03Xm0BcqnWXT6RGL1oBWVSh9ujJEOBHhu6UnZEf+dCn9paWbisOHlijWsxMg9YIT95gg8wMlhV6jPKc=
Received: from CY4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:903:117::12)
 by BL0PR02MB4753.namprd02.prod.outlook.com (2603:10b6:208:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.18; Thu, 4 Oct
 2018 21:24:05 +0000
Received: from SN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY4PR02CA0026.outlook.office365.com
 (2603:10b6:903:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Thu, 4 Oct 2018 21:24:04 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT041.mail.protection.outlook.com (10.152.72.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Thu, 4 Oct 2018 21:24:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6J-0003dX-T3; Thu, 04 Oct 2018 14:24:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g8B6E-0001wm-PJ; Thu, 04 Oct 2018 14:23:58 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94LNuAO016478;
        Thu, 4 Oct 2018 14:23:56 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g8B6C-0001w6-MO; Thu, 04 Oct 2018 14:23:56 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power domain driver
Date:   Thu, 4 Oct 2018 14:23:37 -0700
Message-ID: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(189003)(199004)(476003)(36386004)(305945005)(8936002)(81166006)(9786002)(72206003)(63266004)(50226002)(2906002)(966005)(54906003)(8676002)(478600001)(356003)(110136005)(14444005)(106466001)(39060400002)(107886003)(81156014)(4326008)(36756003)(486006)(6666003)(26005)(316002)(48376002)(126002)(186003)(50466002)(47776003)(44832011)(5660300001)(2201001)(51416003)(7416002)(426003)(6306002)(106002)(336012)(2616005)(16586007)(7696005)(77096007)(6346003)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4753;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT041;1:oUqtYpvz7nGeJlXOqJTL43c5ttpe3dS4EqvonMQTazUkZ2MF48amkOsP79Qv9Fgu6GzyDtXGNfvZJJ+7yK3HuVD0UovsVY2rO8j0V0HVk96Ifocre68JcB3afqht8Xz8
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 660ce83e-d059-44dd-a177-08d62a3fb637
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4753;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4753;3:fqtNzhpwokOzfO122DjJnDZfgpUiO09Nloul5RB5PxykVMPlUuqLXAsjiykk3yTPUvvmjXMw9a/GXtiznyrj27abUn4LpXhFpz+/Vt19Rs+2QwMIgp/d4wYJ+TGwE/wevkt5yatIM9dBtT78bkUXSSRYnq0NYgcqFAIlUwLuwH/fQ2DRz1/5UkV/R0iQHZVuB/wa3nL2XSKKRoevTkDgmLY3HkSFv1Yl18swkLGHKUZ0dS6SKs6HT3ycl9ZsyxTMZ07EfaivR7GtDEinrnUsZSROEEhX0cHR7EH9Ps0FvUqnQhHjNzaGTjkeqj2dlOQmV3ieGwn9NzjglVQxj2+KoWm1qCYJEtFzoGLKtd4C0WM=;25:yLSvhZxeoMCWPmc+xCSJblZ/SXfhfwLNMed8huXB5Saea7MKu7FBUINeDnlOpfK+KtqV3gDjgp1jrzuga6YTVFTSdEgB5BT4hzavHYxqP2QN4hZtciuGJ6yH+UHMkoj2hXpnHhWInrKHvFtskLpy+NxanyVjMkKUdpT7ZKJAP+iAXhCd9yGQY32mnpNKTgYLYvUeOkCAA6idY41s2/vS9kQvJB5+1gBBUmM6pvIA7gOxOuUAavcgst1wUrq3Uxgrn/0hOY2xPbBeVeajTe0MKBCj+LURMwvrZak/OB4CG11fooy3WQ3pxP9NWQtORVaMWC9edVNTOyoqM3DqJuzuHw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4753:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4753;31:ATZ6o8Cxng7svVuzeS1ZCx/fs4QTWfbdq8MUSoLU408rWjbVbCcMXkO72CaG3cFiHJZa+sQaANz1Rs/pkahkJH3fu9Ox1SqpKQ9FEHdAiNh2RFsOsWDVev7AlwzgKTp5AgpIud7Bn1IS2k/tVd8JcfhXcjqz5tlkPux98UsiiPDGIGCUoOFtWIiImJe7ihHrdc8T3h3dfygnRT6wh8DkA/P/YIM2xnC4iM7tHEZmk6o=;20:u8Z5bN1wK+o2dLrVGyzmof9E+OPNXIOMDantFh/vSJASJnuc0r4R666pr5ikS0ys7upSqkdZToq2anjKf1u553WKp4e2HdEo7lQ0rmRXKHd43KAAdRsy7uoUxa0Pg3Idpzg1nRNfLnVJKmCVWYI+dXLBck6HUqHAOEhXUCVUAnu544H7STxEfdM1AtOjKn7AlZmPcy98n4S64WEZTOiFlyjpggaqPxeppBQ8qsdcIJqBZDne9Sl3f1XvXyZX+ElkeH9IdDGXv7R5Pxl281569TYX2mg23cL9m3fnbPbQ4kmpvcVkCvYzrMG6x5ThEuHMdGt3Wd4y0AwTf6mfoPtXs3znKFhESrIykHl7IgCT5cyXrPf139ro3c5e9NYSsFdk1VJnE9r/uP4XNLIUbMWyNexghuDHBZSYorLwceFKCC195xpEBJHcWYL9d2nHiCkxcgVxm/Gx7YAhzMqJGsaDP0eeX2lrXq9PgTxYuXA6/SB7TWm6Z9m5tFVnxR7UXkbp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB47536233AFFA16FA3E7B8350B8EA0@BL0PR02MB4753.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991048);SRVR:BL0PR02MB4753;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4753;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4753;4:dbxG2D6s09+N3BwKdaL4UikNwGjHwqHKiCZIH28mx8kBaXFtHdtqauiYrRcK4CRunZTy/3YjgfmgrtchPEX5XXKtjfV6o3/cy9gMlop9yvp18lwNM83t33nIa/w+pP1HUJQpeogTWyuIIcsqJtW0YiSr/0duGSohDX+gRL2wsJt5npwnWGd90Ko1inQYUfNwZTRmMg93k/MVtc1AlVYz3tvpEc55BCqSA4IDoh3PdOwbp9YvGeGwmPnkeR/oh8lYsYxvd6p6qWYX4i8+86uDzNClg86FITPX6Cc6n09DkpIruKZ9oJBkT4ZI3tY2T/d/
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4753;23:xeJHAsl4gEU9NXbm9h/vJYGRgQfipNwChnVGeysyT?=
 =?us-ascii?Q?DVNGJTKdvntfJHA3OxUvubwaY7knKdZ90a9h1h7xFuxr99H54EA4OgGWxxgx?=
 =?us-ascii?Q?rLLet8q6FkXPFtTscTiY0vKZQIWbHSkrQLkAyjQU8LwSKKiMeNEpCsLYhve8?=
 =?us-ascii?Q?GhxawkLjDpy0EZT2l1AcxkZfU0ZpyM0IPJP5UZp5eupdrmITlwv9z0iwm+Zb?=
 =?us-ascii?Q?pWLK5bR3O6W5gAIPMyuhIc2IS+ENlq6UxMOC/L7NLbLgPUc0P0mkGwAYuCNw?=
 =?us-ascii?Q?/59q2tYcxc/n8HzFtc2KBKHf/VaUgh4L4PcQJzxJgzZBxfvfKcBtt5IBDKlW?=
 =?us-ascii?Q?e0o4UyXi5xEAurD7pE24/Yq2AkMC5NokYUqCWVkiN+T0QySpLfps2On+qdaj?=
 =?us-ascii?Q?JN6ambIxb0mFL67LnhIECIUgGgQiH8skyCpepdocYn47Xh1ISScPksO9pino?=
 =?us-ascii?Q?nQ7okOUjqXfKcJZNQOj4RL9bFD9bOUyC3+M16hkDJuVknBrZrxVwqizEhCvN?=
 =?us-ascii?Q?TFDNyA7Z5xMTvdVWhPfAFWhZOnd2385z303DFdH2UKCa7qndvYKf0LztzKu/?=
 =?us-ascii?Q?hCeUqbPWHPHfZSmmOzQR0OjfQT3lPAubU2bDUxK0ZjVPO3vOqHrrcEVschcD?=
 =?us-ascii?Q?VA1fjA3z8YBvfJqNYdMjj8fXC5JGsrB07E0Qfw1EdtJmeyZkITPYnc2kM+zj?=
 =?us-ascii?Q?CCvTSwfgMr2uew7vrMzJdLNFSOUuQoznRAacki/f9Yu+RRtlMl9KG/y9jwqW?=
 =?us-ascii?Q?jVbkZRk0ZoZMXm9biE2o/9JXscN3tUXLqsgw/nditwqtFAvlK7w5hzByr3lC?=
 =?us-ascii?Q?Bvyx/6GAjMt59h/7YOUgdyfKXVav4cLwQ1sA+mW9n7Irnf0N2jA1HdKG05Ah?=
 =?us-ascii?Q?08Nf5BNr5CZkzDVpDOMBa0v14ir3mD8F4p6fCe7XvAei1GC/ELYvNEFSNiUy?=
 =?us-ascii?Q?wNWX2rxZJMtg3n3bOmvamT3Awhre+OvLJDM5NyJufRktPJared2EWbd9aXNd?=
 =?us-ascii?Q?Hs0XOmWG1k8f7C8blFU7cA0QK2G1zhXnX4pn0Cx00P0NX0ad0yIHY/kMJFDj?=
 =?us-ascii?Q?kAAznl/r3oK3KTwfdLE9sblW2ehPFWShLndaj88OJBs9cmBDl7QVTUkuOmAE?=
 =?us-ascii?Q?ma2TEbnzcCF4INTImzqYf88yAL0WsjnEXa1rOrKiRukMDNZEHcAVf50xEBv7?=
 =?us-ascii?Q?fRNR7uyZTANA+3UzdCC9WyXMo264PFzj3P9L1Ie+RBmXoe8TzeBCUAlhe8Bs?=
 =?us-ascii?Q?o23yyWu7atAgW0S7j0c+Ohp8rsxMkKOz4YX0C98HGkU23lgKRPGg65eHyvF/?=
 =?us-ascii?Q?8nfprz67AgxQ1lWfvBlTro=3D?=
X-Microsoft-Antispam-Message-Info: rtOQo/5PK9WL93Jim4I8bjY/CWRwt5jDa2P1LNbwAzAzrzAhgK8Igr01eRQWv8UXERRUPBntZuU7JycaimYpxTpUbH6e4PojtVFik+vb3qYq1AavqGwNfZRh92X95DkKKLchWqFGZ58l4JEpXshZBZc8mfUGrCUbj5/Xe32oQhXWlYyxQsu+VDBvwcPlnQg9fvbH2OEe8b5TY9cQm7e9aKhavfxeyXuUnqa4xClmaqSdQcCpe10ehmCyAiV45+GcgIgQ73WQQU6yln6W7PUTG+ysyQCldpq526ap7c5RCXPa9V7y27c+cuzze4zmduh4aVkhK3x2jnGFcCDpW0fYEBnrB/qTaSuXdUVffapxvC0=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4753;6:l9FMqTlzCBwTGy+25kqHadT5nLIc9i401XEHF4KmWW7B3x4zVYQ+/wVVoFOUr89fFkMVjze7EH2X3n9ttmNrRc5zMDtckIrabO1DWxBKhZri+toGjsqRDj5mUNO0yVncwBJjQ7/yye/cRALSogTwyQyZZdi+wzoRALPs85sYTJFn1FnEKj4D99gWai9xO5foJkA6UIDEBfNVgyKnpXd1ODLQluxFR1RDRTN0zIzhCWfMLQln9THfFkveSzGzeuLnpOR7uJ4GLlBYU8oUKw8HN5xUjtFZaCCGByPHI34CQAmQHeG+dKLh8zNdP7rVNgcAdq3LC10TZgDUfGK8uX13AeKifVM5w0MCAebLy7ZjCvYj5vs9rOpolsvVrdWeFjQqy4ZzzWSVE0HKqZ5gCWJ1OBmu0ABCuN/s08/ZaXXVfWm+DJBReyWNsqYt0VclHEoeZnqEF5Qyw2v37zKaPbFuUg==;5:llFPnL0P+EqiUzbNGRQI3xBwM2IWnLpOx2U9YKpUP3vUQr1TqWN3/HDRtlGPj7ebvHoA5iFvDiy1TVlYyoXHLx/SNGACStR60RQ2XyFXT/fs/AApIiWpxD5pSjqd2CoXdqugIPhV2rMwKM9RBVeUKJnUy0+DKLEvX1A273Ad3nk=;7:b0h6HV7MIcghqatjbwflrZtIfYs9CIzG8nuCmMINE2YlXnoBoTxgUvtMD8bXVEL4WXh+K7P6Zj6d8R0W9Mf339HgWjdXYiXMSfegSGj9enstclr4hvFc1szfUqPuk2tvV8oXMX9AG2bmm0X5IAWmE3Zt/fZj4+gd1w0ABE/ThsUMRhFhl6TN0B4Z3Kf/FJnf2ZC1kxiZP+1uvJGnU1OINuxtmPoSglAVrkX8Ss+48mBsWKX9Xnsoe0zEwF8UiBkK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 21:24:04.3065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660ce83e-d059-44dd-a177-08d62a3fb637
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zynqmp power domain driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10555405/

v3:
 - Changed binding to have FW node as a power controller as suggested by Rob
 - Updated FW driver to register it as mfd child devices from firmware probe
 - Move bindings location as suggested

v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver name from zynqmp-genpd to zynqmp-power-controller
 - Updated device tree bindings to move power controller node under firmware node

Jolly Shah (1):
  drivers: soc: xilinx: Add ZynqMP power domain driver

Rajan Vaja (3):
  dt-bindings: power: Add ZynqMP power domain bindings
  firmware: xilinx: Add APIs to control node status/power
  firmware: xilinx: Add node IDs for zynqmp firmware

 .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 ++
 drivers/firmware/xilinx/Kconfig                    |   1 +
 drivers/firmware/xilinx/zynqmp.c                   |  73 ++++
 drivers/soc/xilinx/Kconfig                         |   9 +
 drivers/soc/xilinx/Makefile                        |   2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c             | 403 +++++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 ++
 include/linux/firmware/xlnx-zynqmp.h               |  98 +++++
 8 files changed, 659 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

-- 
2.7.4

