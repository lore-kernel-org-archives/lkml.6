Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF64C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E2E219DA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="oXgGLIZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E2E219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeGFHWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:22:49 -0400
Received: from mail-eopbgr690079.outbound.protection.outlook.com ([40.107.69.79]:61472
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753225AbeGFHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKM3ncUMyh3smaU21IA9M6YQ66ocHt71rYK5a1TobJ4=;
 b=oXgGLIZV3jYNU9o+fuk4j6qxYgup33MAwbQn9PoE7CWEIZCpHqmCfei/bJfIhMxiWvIYas4unPA0ZYtwlLbH9LpAJoSmxfDFoOyFrBZBRm5ZkXa9LSTjk/Rwpp53iDZPXFd0XuLpfLZPKlPgEPdiNCv88FxqxDs12JAZsJW0tqs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Fri, 6 Jul 2018 07:22:42 +0000
Date:   Fri, 6 Jul 2018 15:20:47 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Manjunath M B <Manjunath.MB@synopsys.com>
Subject: [PATCH v2 1/2] dt: bindings: Add bindings for SDHCI Synopsys DWC
 MSHC
Message-ID: <20180706152047.0b0a4944@xhacker.debian>
In-Reply-To: <20180706151930.78b3024b@xhacker.debian>
References: <20180706151930.78b3024b@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0193.jpnprd01.prod.outlook.com (2603:1096:403::23)
 To DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6948047b-3e11-4105-9c32-08d5e31144a5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:QEF6BHdDtVhGf6lhHLlQRwXDAKRbspDNXmF6PEpBHWXT5ly0aA1zMPMtoaTgEsErvlTzdMV312xzhl3s67ZEUS6i4h2hp4u8Dhj4mIB5nuGaEbdBgD5dBmAsnAxlwT5C25Z4EswpPdBV5OZeEGehZo5LnXVzGPOqkH4b0ltC3KNM2nYM7bKz7UbDFPJd1rpQrHx1q3+Cr6yxQ/pXNYr7K/hKMPmkVBmUgU+IuBXLtTLIPHOp6+FPly3rZggbBel1;25:jLmXLvJTMKR2gbXw/Agsx5ieW6CKjKVbF/1kpsILU25pk7H9NPzlpFCbC+E/F+aH0cdq1cjT8VueYC+F173nWfNiCKgCexqJw/pieXKIg0v1zEbBVqdx0rUhMyYMOeQfOB9dVJfyT2JfZYCxUZYRQBhp40FuJP0Op8xUaInRYQo/01FgltngIEfUsVu2S8Q+Sjqcbei7v2haPxKO665AtvL2hxLoK2Km1lD1hDzqzlYdxGY4EK2XN5EfeJJmS11IEmZ40xk+e+ltY9Szm3tOg/2+vvO+wISH9Wbmmsh6f6P99ls0DI88ittakJ0IXtVjSEVi43sZZk1Az6oWZG7SUw==;31:xkGJEr6nBrxaatiiDAv68M5LrTEZPK+PqVtNhoRipRD8ZzAQrC/1wELBoh4uorzux3rQsGceNfYW5MxwSKVZ9hNO9LGB91/PAtiJgMnlr98J8nUFPVeZZ35Va3LC+xHmmRaGKj6Jf/dQH0N5rTO4u2SdaVE0CraxG85YMxGXOKITWTal1c6Sj0nMljTrKR2kfGRTpd8YN7VndZUjxtVmwZOehxjncgj8jnV82cUZfWY=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:P46FuJEazZGGoxs9/r2NrlA/s9d8Y1DsMk+3+lVFTT7NolBxyuHBG1zdJk8bQ20eWPuHsYI27b49BWKO1WH2eItwD2+LZXTevDwftNpg7IZmp8gJDwSXPnvNs+YrAIinLx3fw0R+U5dysu5FHlc+g68vhf6pvOlWMpuxF9k3JIb0ReyR+f8RUq35ya7tThCgPRpqEMxSA8mDz4Qeh0mDgwlDUjfeWgnUmhDLQuFCKNykjoDkB3J/pEH/c3EYDDfHZDOVvklKIxOakN65CGC58JXu5ZD02eO9Ham+qL2DmcYDWAmjeaU4DiH8bF+b9RpVIglWCXcB8eooC1I9oRCK5oaeNJAHQzwZgGqeF00Ai09O/L7mRl2mJkCAJGCn0PVMbiHHThyk4BLTOlOdfpBfvm/lr3D26drv/0j1mo1ipe/6xdUet3yWaqnBUs+hjPFvTEK+4LI+inCJc19rxeKN5Zv20A6EtZEc67QdBex0FYt3/clXbU+MyYpFnk/bWLno;4:jUmDLKoZoKpATkMFRAiJPHq71ynfO8da1JYrK0+CIB2qgecbgwZqxqW1ts+Y5XceW5C+UgXp0VGmh/vuMRkIgEHL/LjefgKw0WRDEsiYjdPHmTwl4VXFYwayu5Uq3Ws7SsJCXUUK5KKVKBbBvJG52S5RPTDuyLVeXdpvqcRvooiAiMJXcuCiXivmIn+6V5Zi52SjKuuyyGedfxLoH+rXEFn0cgA0SeAbGLIGPP8h4QBoGzzyzgSnVp9niDb7xIAGi3UfCkzCaqtxbkT+iKZMjw==
X-Microsoft-Antispam-PRVS: <DM5PR03MB26366E2714F332F4534CEAC5ED470@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(199004)(189003)(7736002)(478600001)(230700001)(97736004)(47776003)(14444005)(66066001)(52116002)(6506007)(16526019)(186003)(386003)(26005)(86362001)(7696005)(54906003)(316002)(50466002)(72206003)(53936002)(9686003)(55016002)(33896004)(76176011)(110136005)(5660300001)(105586002)(8676002)(81156014)(8936002)(81166006)(1076002)(3846002)(50226002)(4326008)(6116002)(23726003)(25786009)(2906002)(7416002)(956004)(446003)(106356001)(305945005)(476003)(486006)(11346002)(68736007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:K7w4WnHGqCMDETjvwd/OF/0E2ne8tn7OEFgkAaNGV?=
 =?us-ascii?Q?8OLUL0Nyo54GpGiPCZxA+fZL/Qt3+JoEGgDvxcwaXoQJ84hNXx8vKJi9Ie1I?=
 =?us-ascii?Q?6VAODTBilcy6NtVU1zm6RtRLUAS02Ky70QeJE8Ojf1KrdouZpOgTC4VDqvfD?=
 =?us-ascii?Q?uoEy+mqPt6LEjcqxA9LhDpYkF5fFaE0swzqLD98Rqgjt4jx74nk8QyBfLLjl?=
 =?us-ascii?Q?Dho/gLlGe8y70Ils56kXeYbYBjKgoJsInD2FrdPFn3KFkHBiO4HTbXRNJukS?=
 =?us-ascii?Q?616tYgNM2fulqiKeo5bR8eLmXuIZ80Lp6tzvzfFOlgwwqmSsvorxkcJUaOEt?=
 =?us-ascii?Q?ueiIg7M4/7bkYuyHq5JOyXQceIR/2GZHRw9zne7nGPBkL1KTQ5VPOz863JOO?=
 =?us-ascii?Q?3e+7V+pQkGeFC5G+9tbduJJnR+PsfvsrgB7NBFJfghjbMb2MTJ7kKYjCyWVM?=
 =?us-ascii?Q?TdFz9b9fF9Myveds9e8qUD6Drcly0DU40eqgeNQGyC4Qz28mIhRNw4Z15Tv1?=
 =?us-ascii?Q?xMooDWHIREozFO99qhVqm+5BYLq0YF3+6+YOikg74XaOf8gE2mMIol9VE1gy?=
 =?us-ascii?Q?6wtK2aUJxdR8hvf/iPrJ9jn3EPRldliDY9gypwEqPPklts+cL14dXNFvF+bq?=
 =?us-ascii?Q?GmJVOJgXcDD4vbiHCmVWRSUGr6w3DNG1cQOjS0Gy/jwJL5CoXnVTQ1SREN8c?=
 =?us-ascii?Q?AvGhXJBPOQa+6+yJ8SWqWCmQSCneZlG8JUFAzOleAQjtWmQhBRnElZ289DjJ?=
 =?us-ascii?Q?MfaXSHMHB/FnpW+U1W3jk935iSFYBbkJNG05IfTr0t5NMLGuhrqVWT2UHUcX?=
 =?us-ascii?Q?eva465MC+FORJzxasGFZOZePjGds8i1+q/XNTpDoAM7e2k99rBas4SnP6Enx?=
 =?us-ascii?Q?n1gRFyK29mmwo4S5K9pykuBVC0yvO1LV88C/my5w6yW+yD0zGRidcstyZKO8?=
 =?us-ascii?Q?azndhW2qC90yGZ935W15VbWnwavC1/o5swx9ISwV0gjQm/z3CaHK0TxzpYAs?=
 =?us-ascii?Q?hKm9Vs5sUrU3XRighh0K1hTt01V1npRnMPFP20eeos3bMZ9AYg+Vc62yG9Gq?=
 =?us-ascii?Q?u5gfn8Bk2krQkG0oGJppG8ysRrmERkmN1AAsms1omc+IVMkehDj2woGTmCO5?=
 =?us-ascii?Q?Q/6dfnsCkUsxQvaTvv9dl1ps6eMF1cQhWe0EJedDZNZ0wUNDJrvmDeQ8B5Ky?=
 =?us-ascii?Q?GjRWMZsozKmR5rlce+dqvET6MpDIsZysPh5ylPSlsSX4nmrgzXvqo81jGwxe?=
 =?us-ascii?Q?DkgiMLRDTGqiOl55dM99n6SEjIWxgxE+1gz62Cd?=
X-Microsoft-Antispam-Message-Info: yjYq/CweYXy8ugPQnQ1bSQQJ8CTZcLAGKHBU4Rs5WrUHONT31Lhy0H93N7JuB/Op3zaRuYszkAFwRWKLNNsSTGSTotfYYUTkicXh18FtE5gKbpLISZtHN4mBwgZBhqDzs3uQmtn4xaCzCa2/GnL0OQywGfpmRvN62jE/jMNG2Xoc9b7JIgGgy0/4cMUmRBfxGX55cdw+ltGMnyxmi6C6qdlI5ewK8g/eBWCJFN8y7gatlx6/duhEuvOgRhC3C3kaZeXp2ju8JMcRzcc9E/VjHCaXf7bEyHZnLGUWYDiLBkqqXT024Vl+MlvwuzaXVzQdGlKcABVl+R+dSwcplo/CwvdJ3oyucsmvYFLwxUK9ZJo=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:Jou6fqfZ8HjqDkRwd08sPaGmc34h3mjL5sK8xEJqvJWxnj1G9h7V9bazX3GREJwcspUAWL3ReC1qYm5a5vVuZJEFgjp9RLTd5JpzHP+DBSekBpgEgTZINZaRYJB/urdMdPuq3z2jSgmclNnsCmyDocFUWxYI0Mgp37veNbIIG0JUqburPoX4hUXDMZyYA724cw0DU3Bls05wDvPCeLx+kVJ3dzfmZ/rJgANQm7GBe/CXyk7hVk6tO5Hu2s41WQsUqxUjvU11jYirN68kYk/EV8gAqr+U3txSQ1NtV0t43tFMJDPLGwkELm0J9A44tSs/f+W410eTMOXLcJ6JKvpbRFPFE2MmieeEg2HoeNVPv9hvRAnOhzK3nl8H57hawDM3d5s8Eo663+nr0Gljqqs+hJlfvCmDFNkJ9y2WWHMEdVMd6DL0gn8JCPM7uL3Zp1MIbZ/7D37xeqmp/CH8LPEE/Q==;5:ZeafyloDBZq4xZY69dlJOnCO3gTAoIlW/d/4hzi5K2MJ2yQ9gy5xI+L0MNvpRmIH61wK5V0Q7qYohXiIH1GHdVENeHtBm6HJrphGikyk2oAo70v0s0WJ4plR7Er14/g7KYKpXwhDzGPz5VFzokcCQv9zplK1iMb/LTnnkXRYTW8=;24:FZ/ICon8Q+JjzcaoE+oO87+Pkcs8OmqvFPdUG12VM6Z41EwtRd0dSPqikxvPm892+fLdsYEmzI5TqQskdZmTeN1WS4HaS4gAXKfxBfWJqh0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:4nDWZSDKbStJuZajoiSws6J2ks1jldr96Xmk9Ms3vDWNSDj2k7Cl51OS8xQzR+TLFUp4yJbPbVbW80Qsnq3WLG6b+nK3kJhQgAd8ODIjOQdCoDPpTd7lT2rghSUcHTTnaml1iZinT7jtARdefJMVPS4VotHZ1jU0lO7sOhYVOLmK0fVHsLgrT12qG0UGC5cmLfx1zMuduBmuxAmYMphTLpzhbmXhwkYcf1ezy3t/UTsNr5JDPgRygru8RL6wTJHD
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 07:22:42.2134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6948047b-3e11-4105-9c32-08d5e31144a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsys SDHCI compatible DesignWare Cores Mobile Storage Host
Controller can support eMMC/SD/SDIO. Add the bindings.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../bindings/mmc/sdhci-of-dwcmshc.txt         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
new file mode 100644
index 000000000000..ee4253b33be2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
@@ -0,0 +1,20 @@
+* Synopsys DesignWare Cores Mobile Storage Host Controller
+
+Required properties:
+- compatible: should be one of the following:
+    "snps,dwcmshc-sdhci"
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: Array of clocks required for SDHCI; requires at least one for
+    core clock.
+- clock-names: Array of names corresponding to clocks property; shall be
+    "core" for core clock and "bus" for optional bus clock.
+
+Example:
+	sdhci2: sdhci@aa0000 {
+		compatible = "snps,dwcmshc-sdhci";
+		reg = <0xaa0000 0x1000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&emmcclk>;
+		bus-width = <8>;
+	}
-- 
2.18.0

