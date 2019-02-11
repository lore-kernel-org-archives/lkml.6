Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4C0C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F20214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0bHFkfPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBJQNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:13:34 -0500
Received: from mail-eopbgr730043.outbound.protection.outlook.com ([40.107.73.43]:11296
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfBJQNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 11:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHsJemVvBAwxWJ/MMWq6+xGaia4yrcScBSUcztm41Es=;
 b=0bHFkfPV+qbS9y/iAgPeh5CetvUOQFT5nlcCNvJHqIHgaX6jdvYWQJTn7i0WakMn0tXjdsX98uiFTg0c7EO6KFjhFkCVvp9iw436/Ys4XGFBeTyjir+H1mP0EjcRrXWGHjhHHPCp0VJJgR3uJjuRyEpXUvaWl/31QfOiLev53wE=
Received: from BYAPR02CA0024.namprd02.prod.outlook.com (2603:10b6:a02:ee::37)
 by BN6PR02MB2643.namprd02.prod.outlook.com (2603:10b6:404:5c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Sun, 10 Feb
 2019 16:13:27 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BYAPR02CA0024.outlook.office365.com
 (2603:10b6:a02:ee::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Sun, 10 Feb 2019 16:13:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sun, 10 Feb 2019 16:13:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrjR-0003cx-RW; Sun, 10 Feb 2019 08:13:25 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrjM-0001tg-No; Sun, 10 Feb 2019 08:13:20 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1AGDF85016551;
        Sun, 10 Feb 2019 08:13:15 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gsrjG-0001sW-HX; Sun, 10 Feb 2019 08:13:15 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 0/3] Add Bitstream configuration support for ZynqMP  
Date:   Mon, 11 Feb 2019 21:43:35 +0530
Message-ID: <20190211161335.23463-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39850400004)(2980300002)(199004)(189003)(186003)(126002)(336012)(77096007)(476003)(2906002)(486006)(26005)(2616005)(426003)(36386004)(47776003)(7696005)(36756003)(51416003)(9786002)(81166006)(6666004)(478600001)(356004)(1076003)(8676002)(8936002)(50226002)(81156014)(4744005)(63266004)(305945005)(316002)(106002)(106466001)(16586007)(110136005)(48376002)(2201001)(50466002)(107986001)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2643;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT040;1:y7bvu/YvAQ0oUm0ygxzGgxduhW5WIHXgORbV8ByNKFmWJfKJqi1IdEkawjKHqaccdOnJ+4xthrIc1QVJ6cQXXKSaDwon6T6DhEWpIib+etiFlUGbjBHix23XNyhwGP0tcPhxrrYYJKy/EBRj/vlb3jyuMBKdtAAq4+jmgvyR1NE=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003431f5-355b-48b3-e10d-08d68f72b048
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN6PR02MB2643;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;3:c3bvP8I+kbBAV29vHMkEMHeiFqwVx4Nmyz/uVbECFyOJq6idu36eed0Wt95gdPYVnt7IrLWiu9TZbXY6J231XXLRh6AIhi88tE+7UrJwOJUVdLt5LQwiRv7hpvyqIi1lRZd8x0jqWt+803EWS2D1v5KjaatAyhAa8nkZgi31XRCdnUI+HI6MM2QvprrWUTryT0rBE3wJl9kKoUf7H8/fkrvESWA+YaH/O5qToZBkcK3w+JdWyzo2Ui5/UaiILS303o7trSPtK0nkD3P8AuEgZNZfD1vZSwO/2+dHjpWsileh4I2HSrhx5BvRupqWfzngz0CdcvCHCXH66o0aep10RZ84XvCEFvkYFDP9KM26mlISqr449ONYaoZeIdeBESG3;25:wsnwGF0TQ1PsbepsUZ6GcwT/Qtoqm1K6RMSduzmyXcfkt8cep0zUhnYDivu/PmQSvErpJtSH7WMtnN/CaE2jYugaiHPigLxM3v5uk3z4WSBHeZaWED6DGnVxmMBahpXovxbGUnR/5WW/kuvTAM0weYFqCWqxafjq6s+3x6P0OIhrI9UROV5S7vL9bjnvp3KdwHjvsmpQQznpKTyGFX6BQjv8PbyvgUDAwoytPwqcEykUgvaf6SqhULas4XfwHuvcqw78b9/bD5XzwZgmHQ2U8iFZmw0YubrIVJJHo5eG8wv+IDCdzJk5/cce44G/jdbU4wXEqYC+IxPcJ1Je9N5aYg==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2643:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;31:LJP2dPVs8OGOzjYQWLE6277Q4h57aXxQt2oDmkFy+WYS5aK5z3fCtp5FKMq4Q7z1FhgS+k4F+nUWwzVuH/n3hz+zUIoy86F9VqzB2019zPGKHd+7BILKmxfMt2npiZidtv+eF6m3oUaYE+C1kLEER8L4P4a0Tn7CfV2BAA/rhiDwyndktDZcvH+Ba+rgbdX6ABQGOr/BU58fUg3g0wHlOur6Cmd+MJlGkzemmui8q4c=;20:LjQ+kOaWsJD4MZiRsYXQPvmpybeGxd7e9oRmswPK8Xil4wKTNJHVHYzslcspuNqbWRR5m1qv/7fcrGeXdrNErMid5u5USxjAVBLGGXr+U/Go5HqG3UQRdrQeJj3SiRL1euxX5sr5s0CtXenG5nUeGeAI9i5KzTvKuwg89HKpeG8ou3Cx/gEoKNvN7X6ZwWhEa5xe2x93mdnKFiIT55bJEEzdpyaM5Jh/KQKz43PuxzTa7RKojQrkg7V7PKScOYyJtIIA1B0wdmZs1KgJzPAhTakWzo+lcFhXuVdcbdIhGLfQf8qOrVsK7R5eQ2ITwXY3e1IVhilSbZYTNvwVBHgHTjd7g4qM5wzjG68BxYLZlQ4Qdw7xtoqZS1neB8mC5deVV6wfC0TDE7ecRcMyTxKGP95z8lZqAS2h/imnHrt/lgkVVmIcFIyBVmQa2CJSMC+tV4dJQtJ142fU3mOEAqTELljr61CifkiFhfOgSdpB1tqeLm5wKXjwicwUgr8vtz89
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2643CA1EC99484042D93B7A8C26B0@BN6PR02MB2643.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;4:Ue5bKft1IRvNEzA5dJchzmR8NcINjjNtja5/Bg6IqOnm2aM3CQIyYEtT5Zv+ygzXWYi/tTFwg5H1+DEe3M6NQzYRzfubwP8XpgoB0jF17K5/cfuayVGSjIG88gsGSqCNcRAGdofglmDW9HCxbn4J0Lo5H7ROb3TgrrjWNqxX3QQfFt2Nc9tRp0m2aM6s5TN9TODef6bgWt5YqTkZIms4q3MLiV8izgesiV2x1g2DyQoO9s+ZfInGuIw8wW52dQ4Q9lxEDWdU3nIK9iUdT7Dc6df8wpxpxM3QC8BBgab/l+w=
X-Forefront-PRVS: 09443CAA7E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2643;23:Xf4XnU8iEDPQ4Wf4mpgTGcxPQXDYy+eBLMmEvfbFQ?=
 =?us-ascii?Q?8Prp+brBY0aKWek+F5Ar7hBwYXALf6R2FV9kkLYxynfov0GMZyty2lVYN7Qk?=
 =?us-ascii?Q?oR7ymxpw+syew3llC215In1HLv8qo9Ha8rSm1vQ09GFrhtOQz2nQ/3X+exhv?=
 =?us-ascii?Q?aJle8rkG6nKuUOtcorWelNBAneuqZuhUVtIx7D5978dtU3eASepnDWKhoO6c?=
 =?us-ascii?Q?WaHBRyu2NaJ/h1Nz8rwIOBd8VzkV/YVRhGdATEXLB2fAMF8qhvKAZ9kMq+nW?=
 =?us-ascii?Q?2FPZUMY/lxlzrFmfLuE+jFVeJ/3cJqTXk67aKRDhzr+Afd97rI8cql7mcYH4?=
 =?us-ascii?Q?UpDk6/v26W5nUq1/NB8JTkCyWFz/qxTij3Q+cH3iMM8fRczOAT4iWOEb7aUM?=
 =?us-ascii?Q?YdMWjjVT16z1MXlYcU2/+oqjvzVXydgj3k1ER+r1jeDxF2wFzclv2mReOz7j?=
 =?us-ascii?Q?s8Pkq9dJRbFmavGY1XEEYzAWc1U3qPDDLGs1CX2cqKN0FOnLuuWyNWA7nXuM?=
 =?us-ascii?Q?66nfHizufiND08xXnFQRgqvxH8X8Vtm+uZsAm2Krh89S1SaB9pi7CE8hUOpF?=
 =?us-ascii?Q?wqCuuZnYYIzj/qd1BW9e8CKUPH/v09VJVdRJN90TAb9BLB6RBC0XPRz9/at+?=
 =?us-ascii?Q?Ph4XEYvEHgBlDvjVgEFitDUNpY88eLPYnJoFiEnoMpGc8FL3m0U465b2pps8?=
 =?us-ascii?Q?LzXEO4JiUjF0ksGUJzCGeBtrzJGx2vm+oa6r9DGJBSpdAJaxbiUCkf/bRQyg?=
 =?us-ascii?Q?ZORNDINsRTP+5J9DwQFjDcQ6fXUBt8KLI6i1C0o0ymINXJNi7ZIoSkc2TwMW?=
 =?us-ascii?Q?JOlTW9tpGKdXd1AJFO44iOZ18OssIf8+p6zsLgfuytSCQRVAtBtoabBmERvE?=
 =?us-ascii?Q?wvhGIZVezfUfBbZCF+vAdBpbYrxzl7KzCtfbTeBKqfTkC0161f4wv/BNh8nY?=
 =?us-ascii?Q?aMJChrDEAL0pniPxo/in1j26JSDssFieDMUYVitVdtHfoM+g/VFy3XGXmzX5?=
 =?us-ascii?Q?76GUvZaKIlmXTCrxwrnKRPdwUPokL0ESBudYLVaPxTG9Bji/olK3uNIPjJ+m?=
 =?us-ascii?Q?hT3iKPfTg2fxgVZmxo7Z4lUzCUV?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qrbMF5afZBed73lvPQdCOLkSAaxhY/l8HFIUde6tzeh1OAt86MaHHWiOox1txVJsUb3uFurj2wfQ+D3nh1b99nTgWtxTjfH1BpA6IeUwteZivkl3w7V3dBQNKmyEcT3m60EmNYymvEy49xyE1nhyOQWOQjLvLh3seYQqUNJp6tq22E1TwolZNPo33dqLb9KYq8apVJwQ2RsCt+PiFEvM7JiWP7hG37PrlgsuU78sB8afxrHbuh6AUiYgQo+CHqQ2TQSzYDPPAjIZCueFbhi+RAzs047NLw2jYqOhE/FmRe4P5ntETxD4+PsvK8vmZiRFvaV0fWX6P1WL/Mxv6hInj1HrlP5TfjQAoUOoETyZ3U2Jm3nypwRbTYleWcZKo4gyqSedxe/B+CPzk1C5OlUj4hsWN/jEfQfkEGbaDrcFMgI=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;6:pN6Ovsb+k0q5IPtccuOdTlAMbbKbtQ4gmukDPzYNKJ6LmmK5CVhBkkTthEBu9qCYVZpszodhkfG/WQyvB3UsdKDvCHOsQA3J98Up+sUvAeFyhc4x6GFXSc5Mhh8IXDKJUin7TGLv9eTwDNgtMcTsbB3DMtgbv7lLAN+Oj+2Bu8r7L4QD3aC04lovn55siX3MZVeg4ame8vM/5fny2R5HXV+jaT3SL58gaf2wyaFMSfzuMEHCw9yLJvEFcUUINhPUI/oM7+pcQ2DZcZUzgGKMR0hvTbgHWiJEulDOSv3oTpVBnK3wC738+e83XbnrdapKHeiNTTYDHHAt3JJwr1cFC9VXs0TB7/KluNj4+xyYEIzNHjKE7YvjBbba1ath4rJ0gGkQNiFB4SzmapViV2CvO8O9vzzwCDmT4cYxQc4KflH8Rm06Av/mHdVxdyzkGrs1I0dZx0Kf0Y7jx+qtMZp3gA==;5:36lQZPl5jmGe+nKIfA9/ps1xloLz0IBeHyWsk12LHrvwIiRx57xUTGZkwV8sB3TBZ4KL1XbCX4L1PqT39qCEMRQ+pI2NeBMD8VVaxOUmKzfNFzf9BjcBUDlxenkG7pt5R+6rFOD0IJrJ4lH7WjSFyABsMRVNOimeciI8iruxJwGT6iTQVo0D4J4A1ztqFFMyDT5/LTt6+3xjP2TqrNJHqg==;7:mQWwi9yZGeoBGn63cCJ/WDpceSL6P0nd2Qxuy2wuSDf6ju6/XJ1qOaKb+C9PUWcTgw6BWNpKFm6hYkqYMD1B8llFadu/5phr4QPatItk+sgHvjUeezJPjm/WiqZyX2rO3oHb23I5+R78BJZ/mqEH6A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2019 16:13:26.4362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003431f5-355b-48b3-e10d-08d68f72b048
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt        |  13 ++
 drivers/firmware/xilinx/zynqmp.c                   |  46 ++++++
 drivers/fpga/Kconfig                               |   9 ++
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/zynqmp-fpga.c                         | 165 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  12 ++
 6 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.7.4

