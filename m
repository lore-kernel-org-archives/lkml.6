Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1FDC26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639FE2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rkGqEop4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfATRkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:40:20 -0500
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:6544
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfATRkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGwiChZSBt3VDOUuOnlru6ZyMEODZspcO1aaDfIMCvA=;
 b=rkGqEop4xncHHvMDnI/fcNXeOgW9NcNYq6QOBctznFt+9ShsZD+sa7kceWK2tLsBgXHChV8MLH30mF8gqsjcsdGQ7FQ6JgQjc3FAwKlrE3uyy4jnz9KwwsmJBbPq8VnQq0S2MUu18CGb1ZWCwNEtEOKN8KYLmeWIhnw4fwrrH8Y=
Received: from MWHPR0201CA0061.namprd02.prod.outlook.com
 (2603:10b6:301:73::38) by DM5PR0201MB3510.namprd02.prod.outlook.com
 (2603:10b6:4:77::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.31; Sun, 20 Jan
 2019 17:40:15 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR0201CA0061.outlook.office365.com
 (2603:10b6:301:73::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Sun, 20 Jan 2019 17:40:14 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:40:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57732 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4v-0001lB-Ob; Sun, 20 Jan 2019 09:40:13 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4q-0003AQ-Jb; Sun, 20 Jan 2019 09:40:08 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHe0wo022712;
        Sun, 20 Jan 2019 09:40:00 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4i-0002tH-88; Sun, 20 Jan 2019 09:40:00 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>,
        <robh+dt@kernel.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 5/6] dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
Date:   Mon, 21 Jan 2019 23:08:34 +0530
Message-ID: <20190121173835.21173-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121173835.21173-1-nava.manne@xilinx.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39850400004)(396003)(346002)(376002)(2980300002)(189003)(199004)(11346002)(446003)(1076003)(426003)(106466001)(336012)(47776003)(36386004)(50226002)(6666004)(8936002)(63266004)(478600001)(126002)(476003)(9786002)(2616005)(486006)(356004)(36756003)(81166006)(8676002)(81156014)(50466002)(2201001)(107886003)(16586007)(110136005)(48376002)(186003)(106002)(316002)(305945005)(26005)(77096007)(4326008)(6346003)(76176011)(14444005)(7696005)(51416003)(39060400002)(2906002)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT033;1:zmdII0Nx79G8fQRHBX8B25VUJpca4E3G5Uqh8JzJTJAIH8Q/74xql2kYOCPzp7xpEQ6/3eofwkfrGiWhLoKJ49Ive7VLLJ2IYMPRTVML7E+C5Fd5jwcWyqhsk30/RM9kycjYgVA5lFGKCSi9+4s8rJbfw/EGLLrsRJf7qnLbtpw=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79774b58-c8ca-4fab-cef0-08d67efe55c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:uEzeVTUsjcmB6glghAGlxqjz15mLDQp6kqsnc9t7dr19sjlD6prpvtM2ic/Gtt10/OvBT4U+GWN6VAOTNx3qtLow/lwmE80zwelVkKJSMqPZ20oBo+MBnPAMuoEyRf5h1q8Fd38cEDu59qjpPNq/b5RNtDGl6o4L5XaACbO3gU71bbYFledL6kMCsx6y2ed2aUtg7mghpJnkTerMo3lQ8KZKK/zuzcxuAO1erhi6OA6cVsPnBabo7J8Vsj9dI+WtZL/Mrx8wokfdCgUJhicigjJDhy54B1nAxd6c+z83kpHWg28uYopfFlR0tcPLrss9ednNjPzPojAp/dYL1jqmrhOdG7zvLM3TAFafkHj6KS80uiD9bYZfaYnI0GbxWq1V;25:IHHOfaHxhzUVAaPk8Zfbct7cCFDt8v2Plbza2+HNioFz29TApY7kAgLDzdAboP3+C6xGMy9ixg04XhMq/4hV2wQV8hY/5cHTNoMfzTsQlD/0UUBs6DP09I4XX/Amu/xWzplzALbFLCUOn/FL1/su6Bn/misnS2fy9HrP/Y086d1OS5jXllT5EK3jvEAzW7c3MKwSDN1CcQyXtjtTtRimrOEc5yvlRCDCTfBEmyeDxIUPSJuiEfC331r4bVMFQkyQmEWxXyFCqtaDStmzEX3CJdMbV9j2OUqnLEBnw/cHJGYtP/doc1BF07jNaWWM5ZdIjg5gyHIGYybM8O4m24fD+g==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:cuPmFc6RioTnqcZhOkstJkOx8VgdZ/Z2T4Xc3dIzFTkTUhJKNqaJmImZ2y6tX7wnvxOSw2YSkirhkLzueSSAFtSBQ3rkTpIpsj+Jo5IYqbuM0cef7FqAnJmB6K+joUl9cuNDCU4XK0PSM3Ci0RsMv+nrzEq49shhT7sGCZrmhaZJLcesZN2Z/KQOgKpM8DSZWklMQwEw3+uSy7JeIWXSMoizU+1f+qvPUFTTY8lE1EM=;20:BDuiNNi3hWuwjfwdKG9j7mbWpBkRfdY8d3UDf0s9b/L7h5kUtcmt6ekkY7RWJFcG668jN6M7HO/NG2GsEjROXC1Nh9LXNhi/usyRsve/oxTScz1CIa7OUSr62uXsg2YsqngOjbLtz/QXHbXy6MbxJ4pVfCYvZrpy2c2fzS2aDD6P3gE0gYt8YCe+DgZVJ+n+Gjempt25it1MfX+PBqogWxdYz7qm9xX6OPRBtC0VCCYYohdXd7jLDkDD7L5pY7o8L0seEwkCxuCCqOIqkzMX8DLlSNlgJKZ2aK91Hi1431UO739lmD3U08sjbK7n0guoEb6VzWDltGIkfbz4N4EN3LHF0+DNbg5ai4BglyOOguso7DjlfMR37/E9A5QsIHMtowkbx/A3eoFfaAFGtHxBlL5+Mvma8WUlWBz0+eaiDdMkc+WEAP6ht4S5funXGs1d1/GXisCOCTRD+kyhTvpLy2JEn0CRyAyzPbjPlIOBTB/ZCI7kosY3ZtOYCnc5HDqv
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35106EEC0BE3A440ADBA09E0C29E0@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:yVzTppwCIDhGkTISqTKeePNf+FdXNF2Ec7wKo3HWD4/l80TtrGCa+hrgTF8ojWQEgaNZYsw9x5TA1k3nBEuPaZn/gYAgtdZD+s26VJi6DTcql9v4xjGotanFkkryJU00t437HnuI8irH1m1ivslNrnztpc98X9HVyrJ+DV9rbaxbZVmfjBfwvecPjQyN8KUKIeUehlhS75M1hdPidaCKuRD8xwJRwcUoOWdUkBfBxFiOG6bRpPCxoMI+5UVbCzR3vLcFEy6ZX7jjrPl9ds8dblcNaOiEMZV9j82DgsY3RO5cq42c9quirzl+V4Mvu6+c
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3510;23:jgdFzJWDecPePTLB8lkKgrvGbr70cCH4fHIV5Re?=
 =?us-ascii?Q?5LMO23idBMyVCk6f0sV+MidNPeYV24yVh8Uajuor8STbGfnCaIxHSHCF1fYd?=
 =?us-ascii?Q?erhsW26FPyWJxd8GiKwqzs+LVCZgp1CjB0KlnaV364qxp3wd8y0CZepkGprW?=
 =?us-ascii?Q?/f3pQSyUGBO1co7AFFJReFhNGMcKvdvw3PGpMuogdr/6lKm54L+1aJ90hp45?=
 =?us-ascii?Q?0JbN4RM3hnez8NGmEqCX1fNrOzFNIYTkHOVRtfzfGZDgWUf42E8MAIyYyXI+?=
 =?us-ascii?Q?VSGk0VVlDPEiCXpFu7BJz7UHezNX9/48NuhKjgoGM2cujx++OBFKVRIIZEE1?=
 =?us-ascii?Q?OOkfGwfcQxswgUid3taAVPZzx+cqUshD0Oln6IomSeFRz6nLmkAWOxbC4Ckk?=
 =?us-ascii?Q?5g0p+VVpSZ2pH0gxEcWJgIl8AGO6CFCKDF7gHHCkMjnkje2kqzS1BRFt4q9y?=
 =?us-ascii?Q?sMbrzeNckhZW0GH/7rh4S3ISXnedWG8ii4NyvAyULD238pwHz3wXzlXl8pkm?=
 =?us-ascii?Q?8qihgHFG0sP2UeC+0yKfffHVJk1QdxT8a/ubPLjR8tyY0cNdqS9hbE3ib8vz?=
 =?us-ascii?Q?Uf+fj1YtS3Ck0RJmcJstLWkyODeYXt0o/iUBueWhz5E/AQe5iMTCc67IrGKb?=
 =?us-ascii?Q?Gh7rxulEtlUNloXwIvR6z8/FjCZ0EMT+Lor06IVp7hMfOg17qIRVHfY/rTrN?=
 =?us-ascii?Q?2PXyJsKSeo4sBkEn80AzWj6afoqOAbs+IhzZf9ctOKEpUGXZfP62uEnK2gq0?=
 =?us-ascii?Q?3aaUO1vrU/vZOJvV73MvgFaN1cHSit/ppsW4y7cYMf23RqMgmnN0RS7XFztD?=
 =?us-ascii?Q?BgtEBYdlKFVaI9Ltt+hNivb452VDO7Ql5Mwpxp+pW4DKt77Z9+dH2ta++otD?=
 =?us-ascii?Q?FxRo11oFS3u2UBUKu3yJlN3G5ZiZd+xuAG+kDYZU3LJjj70GvoiZPrV2YpQ1?=
 =?us-ascii?Q?4LXaD2BZ9DKkiE8jReOUEPSyBAE8v6+hThP3jpdkhCaABbHwvqEwlNcUTyrT?=
 =?us-ascii?Q?faR2S1vZwd5MXL4ZziSPPoc+ROqQgEWPutIzaR6uviNxw2N3zc9BJdZvG/Sl?=
 =?us-ascii?Q?5leEss8RFBJYUx+TL2zQD7i9ygJZDKuU9Nb3n0f0euT8eA+ZUtqcR3xujpdE?=
 =?us-ascii?Q?jf2pV6mM5ShwdZ/Y+tGSzaY6NT+Q7FFCfkPDeTwx3bPyiEdZ7ea6DjC23UDZ?=
 =?us-ascii?Q?nqLNnqzhXHX+SeTk=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lEljIJgD4CNCFCpzgmsabv7pvxgY2OdXKrKvCAy+wo+lxQkK6v3cyPvBjaR6YlpRFjBL0x63DMNNFGV2Bkmvo5Jw6omELu520Qifdf29TT76RxCSIwIFnY91OH8LoP7rV3LkiVvi4luJdTqGLEixUdxDksUwxZigRcmtephspvhjoRkfwkp/uVNx+rl7w5wMaGK8Ju/LC1xMUi6L6k21HhR6NYNoSfa0mnWekuyoxP3XmjuobDF1mJoPCOWeMx5gs8Y4t/uXzgdKb9PGP+idtR9KriMhFsYRHGmsFl1lX1buLXXVqrVSUFqrPCTQPOPoUqvqPC4UIIflXgpEcxJtmOg+kC6Yr9Rbdzn1MkghgFLsVSVgiy51bAq+uivBvt42oavE6HckDrFC4/Bfc3Rxuz1aqhE13aK0QTG977xD6+A=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:Ncb4q5F+SmjgEB/KUm+IZf4g44snlnb/TtH25XhyCeOrSo6bJIIrRwO9lSe2MmuibKex7kM2TBuKtMGsTS5DwXM4Xp3tbUcAGUv6H2ecdAiblbe4wQCafrHXWV+KYkNMz37M6Idcs70dMNkELe3HGvl5SBgRmNIDhISuQntzhq+cWl53DvM3KFLzFWMonrkGJcl9ss4PRHIcbrjUJARDYQzBBC13i8O894XT18MfnklQWQnv73Z6ikUUUG2aJ6ItLOz2tHnlZiMPIQEmJQIFjE7nxDGXMpFKgIetp2GkyW8m7rADfWJyN8pj6d9U5c9MjAZAhh8XRyO5vnHQYm2cOMux9gPFNcFN65vAlZlSSqyU1i3nb87/q+4y9QkjAnj5r+zDeJphZ5zzFgOgEiJVGf0KwClKQ9jMnw5WlkbZBFewDClUJ5smQtgZKi5QJ8v25vgAKovV0ZM7Wwo9H8R9Gw==;5:+e4cRy4uDGNtMXrKuOHUaG21Cr+CmzFKeQFJIWZNwTHJCfzMJ1j8zAyOdAdwFapU+aCt7epFsEltAh14zd5Q8w+TKddgqlmm0eI6z1TiqMx/ZnKra693IkvTYjB1tFRvXXXc4Irtxohps/3rfDyBk9D9UDubDtDx6MZHtEqSO3FQv4xaL/igOhFLeNm5Ub9RN0bnwNZN0IjZg5GVrMEj4Q==;7:cQ9lWpNH42Ehwfqci8jYz2BW6LqcvH2f0N6xNcesm0rUwgJvB34/KxuI4zo0WREmeZYtUAqP2vWmHi/lzxsXvFOLYjNAjYPy8opzURtvbSJMH/AKzQ+13b3G+zBgcDMbuGzWoDTlb7Mm83GceXC5fw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:40:14.1714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79774b58-c8ca-4fab-cef0-08d67efe55c0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Added nvmem node as child of FW. Since nvmem driver is a provider.
  
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
new file mode 100644
index 000000000000..2043c8284f8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
@@ -0,0 +1,47 @@
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+-------
+ Example
+-------
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		nvmem_firmware {
+			compatible = "xlnx,zynqmp-nvmem-fw";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			soc_revision: soc_revision {
+				reg = <0x0 0x4>;
+			};
+		};
+	};
+};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+	pcap {
+		...
+
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+
+		...
+	};
+
-- 
2.18.0

