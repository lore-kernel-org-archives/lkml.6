Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B4EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E19720651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Kob7fTsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfANTXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:23:31 -0500
Received: from mail-eopbgr710073.outbound.protection.outlook.com ([40.107.71.73]:21984
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfANTX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X6QekqGsMnkoc6cdEvHA7j/RBlsWHiGZSm/nw4jj/E=;
 b=Kob7fTszTOsriqv2ZkliFwA7HfeE0JeopMG2aTpuilDrG3tn6IJ4JEIBGGjHgixAupwtp17ziHoaKVykTKvazvEWzC+I2QE0rCxutAxXSSzUI3mTZzRX7oPpCRp/qivSkG3VQfn674XFp0DCowP+rhUHFeUHnYmNIExUJRCRbuY=
Received: from BL0PR02CA0077.namprd02.prod.outlook.com (2603:10b6:208:51::18)
 by SN6PR02MB4335.namprd02.prod.outlook.com (2603:10b6:805:a4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.17; Mon, 14 Jan
 2019 19:23:26 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BL0PR02CA0077.outlook.office365.com
 (2603:10b6:208:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.14 via Frontend
 Transport; Mon, 14 Jan 2019 19:23:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 14 Jan 2019 19:23:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60825 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gj7pQ-0000zk-2F; Mon, 14 Jan 2019 11:23:20 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gj7pK-0006Hg-V3; Mon, 14 Jan 2019 11:23:15 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0EJN6wK023259;
        Mon, 14 Jan 2019 11:23:06 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gj7pB-0006DT-Rm; Mon, 14 Jan 2019 11:23:05 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v5 0/3] drivers: soc: xilinx: Add support for ZynqMP PM driver
Date:   Mon, 14 Jan 2019 11:22:55 -0800
Message-ID: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(376002)(136003)(396003)(2980300002)(199004)(189003)(5660300001)(39060400002)(50226002)(63266004)(106466001)(107886003)(8936002)(81156014)(81166006)(72206003)(4326008)(36756003)(8676002)(7416002)(47776003)(478600001)(36386004)(9786002)(476003)(2616005)(126002)(48376002)(50466002)(426003)(7696005)(106002)(44832011)(316002)(16586007)(305945005)(54906003)(2906002)(110136005)(486006)(356004)(6666004)(51416003)(4744005)(6346003)(2201001)(26005)(186003)(77096007)(336012)(107986001)(921003)(5001870100001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4335;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT059;1:w1U2MRmyUODwCLy2nFSWZqPGOAV8AfEdWnskIZMnDZ+fHsp387PoXKTg4Kywvuii8nKXCCH4ppx6RQSN9455IXz+HCly8TJCxC2t9vPHTtjqPkwfPgNgfF+WYBm8bcFe
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c313d21-91d4-4509-ad4a-08d67a55c15a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;3:bVVFTqtKzYfwT1Vr9OcwZk8ISJtO7m0rX9mHSVyxmIo3IrYDKwqI3Rjx9Z9wJmr+MdAlT8lc4S7xmueeQ7gfhrIKuYc07F1J8pvbpqiHHgP8AB2Z8VzgBxtFKJ3hIjuO0y7JIRAOQmWkeuJivQxLR4phCT2ZtC0zkKbL58IpId8yzT4a3BdgRXmK40OLAKF7xiKDC/GOS6j5aVaNiLnuxSVnZFqZrr2vaxjCo7nwm8ucZXg+XNt7GBWO9mxhV4aQ4gT/FlPKxbBnaPI8NWw5fSGcOzJi7rgHatKHrdJZB2b8HsrXb5BTl1v+N0/u2AhPavQtiMT0C/op9jggX9rRzujfTVw7vGYZ9xcy6PoUvwJuJjNVbc9m5RFzRmlFISbs;25:jEzSOU7rq7QvYdCK3a4usODuxhdnKa7cJPiPspBY1YmUGOwwQtFeo6JYI/fBeRC9NGqdHdQ5TCn0dRtzXaoFyTS075h1oiCrrQIBunlMyP5NJBHcClSixn4CorEzfdcpf/2ebqg5iAJz7qlO7FzPOFHrmFmkbezQ4FCTp/yWH/uk1QGnPu5y4vSSSfm7PhkSzwxGU3fRzLUijqjDifgxndcX/O5VngqOz88FPFekaKKW+87Cu8Vf7/1uDruwlBms0Mm/dBYMN9uw37xQ5wXZcnUek7LdgJ1m9W3eK15en1uZaDDi5Xwk9GEaRoeEzlk2beFCzI68N18OJ8h16OGfBA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4335:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;31:rQTtgl59eVy928jfpS20YK3Kew9aeevNV9DZKwvXeH1Xzc8Sy1Dj20lSOu0UoO6+nkRdh+WSS1vqCHJCGbYQA9hkx7Jnhzpem7Ca/puV6IYfNU4jQr9mF/J/Iy5VuQbDqWt9fmJ3RixxlrgPSMJUZ5f6Ax552tserrq/JOGjNUHlAAspWIi22m16Iy2UwIKmtlG2foLmf74IetSymjiLRBQiDeakqOIpfXyMO6LXe3A=;20:zPY9RIGBjapssDZNYPUQypUIG7ikVvzhL2WDlxKL5ovRB3HEfs6B9uQjDoKEvSoxvN933f9OVKQ48HqjRrT27B07u+e7IAjjB4B8qiR6kdX94L3IRWPdUiZSkBzF3OxCNBL41vKaw9WKfDdJuFn3DQUgsXDDEPyfE8ZWboKPrd8gPtKfpKQF3vB0XrZiRgLmhg629nZ2CVWGco75b1A5SdnYAT9ULDkeGJt7tDggh58qWNMlUjDnokPLp0uhd/fgxTXgg6SogIjmidBkCINTGyLBK9NlB5iR8wJZ0iPbL3n7y7maVfW43XvI+FHTpHB9NbOfxDA8BLS8jBoXomFG8zVlEB5Dq+i17NirDGKgdQ/QMFyyNw9FYIl1yrONpZkbHBB2f2MSUe9MH+n/8qf3NLEHXHAuQGKfJUu8OUg/tG66R64V3Cn3FazZZhmPPnJ0G3FLUyKFdTMwbF1M9Mq+7+UDtWdIhZynIiMTQ6XNeoi8+MNtiMs3E28ElZOJq8bs
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4335232D0C5ED2EBD2BFD1E4B8800@SN6PR02MB4335.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;4:YKRFdayIvmzDEbI42T9BIsLcPq8ZS9DMmNcf4RbfvhRxoSN8g0grf/5XFw2bZhsb8pSfUDMvK8dtWAq9bmB1E/Im6qrgOBdSy40H+sPXYZ7fLe5R1QYkp0hn+zOkT+jb+ZXNnUfA6LyVvJHRXbh6q+T19/ZT0DJU539q4Moh4ft/0RgSSTLhufKpdJkiu/3zk40gZSQsVmfSZB0gUMsPwyqlnGWKj3io5rcYDfIKVDkB8znd3RoKii8qpj+XJqohKuWLtmBeI7av/E0LDroKXECCLoUaTGQdQD24/OvKf+m4E8ET2i835ItVw7JVGwGp
X-Forefront-PRVS: 0917DFAC67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4335;23:jAX/mWerSJnZwyUZBIelKCWkmrMK5ZDEgbua2g6V4?=
 =?us-ascii?Q?/ZYQLocRLtoGeMk0bfF7ZzsnCIdK9hiDdgmvhXw4pnLoqyBf/e8Z0qmBlnH5?=
 =?us-ascii?Q?tfZraEg4eFS/GSYcyzqPqXqkapU82dWdu4/yLR9exvvlBskLle6NqLZCDgbs?=
 =?us-ascii?Q?zTmGEHo+njdEpx7xvLbfdoX8Ff9o0TYpIDoxeLy+MY3yLDo6BJkjK7gawi0z?=
 =?us-ascii?Q?hQyMYKpTcbzhQMuz7r8FWY5hc19/T0vuhy7Yg+KsosjnNontlrR7rGYbfksZ?=
 =?us-ascii?Q?nXcVmPRAJJWCMx49ZKhh9fYUhR1HHm1kLa6w0ud1ykvwaPgjDb1nA2rB+fJV?=
 =?us-ascii?Q?mjCEYlNPuaaN1UvpNvwrqqFcTrP8O94EYxdApxLHTePJ9B4S3GHwxztUFc4U?=
 =?us-ascii?Q?m18gtRVkMlx/nq+QM51WcoyPPj+dbg16MNjj3O7b9QcMSvelOB3jaEApxJMH?=
 =?us-ascii?Q?/r1yhoP+fcdeHWSh/pnpDObO4iT/gXiKK2H5FL1/XLKqLC3jVHeN1K03v0Ur?=
 =?us-ascii?Q?A37+WooiU/oIIGOLAWflYWGTFA933j7nuM+aE0JIxHXvTKZTm4cdWNGI2Dm7?=
 =?us-ascii?Q?cOcnYk4ctsCHmusjdlyoYjSHZWeXLeeJm7AiRKzEkS5Nz/CAJItFKLZlgeNM?=
 =?us-ascii?Q?1ZcV0TziJLw7gzjLlZKU+AHe7TZaXFtFJ1OoSvEU7sjdaJQap1RKGa9yxbub?=
 =?us-ascii?Q?BynjW86bryc3Hye1R21yolYyAyzdBU7VdfVX2jpU5/8ZAzmdTZqARHijr1eI?=
 =?us-ascii?Q?KdqptSabWECy/iG89X1DK4OyveuDTLp5CSuUD1pPz3C8IqApCBxCwn6anNEp?=
 =?us-ascii?Q?JtsPrLpgrJAptSjN8vlzJlMbmW32lTJT9iB8En5+A4hXXR5olTg7Gb2BE4ir?=
 =?us-ascii?Q?fmZ7EyUt7uJwLnbx8ixhgMR/AsTduEikiQ71u2uZ4kY+SnFncBZhEOdFBdQ4?=
 =?us-ascii?Q?KpSh1EIlSypfmbq0IuDBA3Ti1MNOHHVqZziDQM9Ank/HSagIcM4Rv8zoYYJm?=
 =?us-ascii?Q?jJU7IZSsrtwCZoLHNrIuK1U2UTbJeOwVStaSlH+F7wEoi8NTsXDsbFOVqzJL?=
 =?us-ascii?Q?KEVTG0lqhOiGsdnjKwsg7CVUy/P7oaPYtwuIR91qZAW5+XChdEuuRwuWs4Pf?=
 =?us-ascii?Q?gRtobQoNVUYzYqpE6xc7heG/17niOALpcYvCQTdnZfEic0GfqAZuRyXeCJEj?=
 =?us-ascii?Q?ly+BwecDm9ftO9kwmWlEMTei3hE2EaNpnZ+sMz5UoNtvzBC33Bpg5njtOX5C?=
 =?us-ascii?Q?9S4+rzmxQyuBgAQnlO72BwMmIUQmGyWOwiXL7TD30BytR5CGRCnnuifZt7Cm?=
 =?us-ascii?B?QT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: O89sw7Qdda7WdeV+SMb0bCZrXRRqVXnvJG5lVrE6SQT4keuym1nSAfZ6eLJ/5GP0iu6c3lmC0sg9vRGEWLi/x1YG7X+ZNqJBsQRGZeyY2stld5My34LZ4ELjaPFoHR/aPPD+K/xr/Rul3n43SnDMZpElF1vCIUNFyrNWJY+CTXpKZ2Np+lpkspVgQ/UQ0h1BTZ/54g1cmXxXsuXgdET0aSlK5YW6q3eCJD3vOKifCsFG7HSphP8xPAagehaAZ2jcykKqLcTN/Sk2QOx9hpLclsh7nenAAVizdA/vcuSv8XDM+WbA6lP7N9Lsmui4bl9J7Dc3Zl2cdjdZNa8vfaA3YBhvJ23B0ndOJFi+YtBkBNO+zcN1bDa+jyO52HJxuwDUouxrspaxQCfXYbzF8uptnQ2km/Pg1bmAK9vQYLK5qlU=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;6:fxWjq+Yne44vQSMb/NKowsJXxvSxgJNg/Z4DsigvdRgYMrNNLCHZu5lUluinLORPMsgfgwZ+YQB4CWFjpP6qm3TtPIEt933iSfTov/wWyEqmOadZwLTvKItjT/MRonvL/3GlHp4mWJDsYkSnAmi/Tk01nwuuGoIDZakJeutDQ8lk6dyKgqzoTCMKnMsSWA3aoKqtdLsPHPDwU+iLQ2IpfWvMg0AM3iUfZgwcuqpBqW+VMFmkIJf+vaJ5BGl96BhFiIPstgXM7c2kUetd24/R8E+k5Ei6M5om5gQBLwQzfkIyXhNduPR7GCY9VJr75dLrZPu07U7Hp+Fta0O+QXUclPzlSuNVfoHBvgT6LMSIVYFcYZwRn0RgfG82smaphIZ+6p3dIs7efxdJDeMJX+4Wit1bRQCBCRnpIWmZO+vgl5GzOYIkj7Ch8maUKkYTXQXo72HUXP2DSE6f1Fz9Q6PT1w==;5:UzBr2sQH+/S5kKhydI9MtRAPtUWfY1mNrk/ppnBPXaPF5iAjprpEQv8GyHlqJK/J1Y0uUGWFY1ksWwNABbpNFOgFgOwva3Kxf/mV9QdvRUC5dPG4BXZdKpcy4o5KNhUh1nDJnwIowq6rDMLA+Vue0ugjy86PNp2Y25dw7kfxHU0A+ZL+9Wa5rrPhaar5afZVggZkhSzqFURXuKtfBXNgQg==;7:NMc5Wsw81oXq8AwAGRIt99gbuuevASjK3F6v99OWtZrM4DiIhIGjtj2l3/sisMr1qprFTu5KkatJHz9tCAhVaAUCFZe7jzhNVpF1WNVCsKY9CR1yJ/W+9E6lLn+jXzUmIjA+l/Kk53/masmxiUlBkQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2019 19:23:20.9881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c313d21-91d4-4509-ad4a-08d67a55c15a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

v5:
 - Added Reviewed tag for dt bindings

v4:
 - Minor fixes to address v3 review comments
 
v3:
 - Updated DT bindings as per v2 review comments
 
v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver to use shared interrupt instead of mailbox

Rajan Vaja (3):
  dt-bindings: soc: Add ZynqMP PM bindings
  firmware: xilinx: Implement ZynqMP power management APIs
  drivers: soc: xilinx: Add ZynqMP PM driver

 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  25 +++
 drivers/firmware/xilinx/zynqmp.c                   |  29 ++++
 drivers/soc/xilinx/Kconfig                         |  11 ++
 drivers/soc/xilinx/Makefile                        |   1 +
 drivers/soc/xilinx/zynqmp_power.c                  | 178 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  20 +++
 6 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

-- 
2.7.4

