Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09471C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A392C216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="OgBC0rS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A392C216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbeHCJS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:18:26 -0400
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:60424
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732559AbeHCJSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/TJOLCmC7rqZW5t/K+dxC6OLtCA06JCzXJGGsdE9Ts=;
 b=OgBC0rS4z/Y+JJ04JTLVu5Ak6++uw5uWCahclHCgewJ8+8rs5RA6U5oK+MFw5ztVCSEVtXUnp02x4NgFl5+MmsNtGJ1tpFNEOgN+pPQlEc02sx7nghg0TRZJG26UHyerr1LWzTV1GXAfkwBuOV5iM5Hv5xqhFdwAD/DtHyCZaVQ=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (10.168.147.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 07:23:21 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RESEND PATCH v5 1/3] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date:   Fri,  3 Aug 2018 09:23:06 +0200
Message-Id: <20180803072308.14962-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803072308.14962-1-peda@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (52.133.96.161) To
 HE1PR0201MB2460.eurprd02.prod.outlook.com (10.168.147.8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2243150b-766d-4ab1-a4e5-08d5f911ff30
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:lF6snlDLwc8uxIeAIWwiYjwYFS4IrAI4YiMwJYA+lDbVfRRdwgqbn9uk1Rn4qCmxQ2kzMPDBqEVTuxEdGZfQC6eqAmrXWbHgJrvAyahoqteA6oofzGpq3I3nHnVIbuo3MDe7fZCAfviqxDsYtWM9mNea5bU0FKGj3ROm7A1b+9Hwp/afR9hnFAWSm4asccuoWW1iSUYL7SjoLFZHYA+F83FSxhI/wCzsZMMU7eoQdBKicUv2q0EbCAozNMMbocNF;25:TQH2mrvXbP2UcHNhQGxVXgFiFBVyzXmntx7QeRfsvqI19Y+iQLlVaYPYE96QSodNWB0QGLxZSXcSptUeQWkEnlYfZKax5pR6psYtnAo55eLL1kMQVWdJBu+WDtMv8WFN9GayCMxvk8jUVYLDr+nW70Zsv7r+wTuc5GpqWl1DVnKBPfESRnyMjEvTI663sqxjqIplXwGu5tmrcDnqWtyLzRnot+MHQB/Fy0Y5d0NeMC/6IOcca4jLSbh7VIoRnYcaT7/whsp9t1koUzIsEA+uSJyh0Bn+HrYmdR58YEpXIM4+Khwi0BLTqV8eK64QhRUTfFv43LSipholP38c5lZUGg==;31:kHG3aimXxp3qz1b+FZLzhnCMth60o+xHqVSwRkluwELzqXBbIWUJvIs0io7Wq/wJPZL0HE/TXh9EunVwIpAdWn+2cT2sxeEoyKZORRwghlxEBigTObLwhYjleL4cnmUIknK/aeTDdtJN+rxmNQX8LeTChNzvq8cjakpwEvmxFCU+fnM0eGyVoKxXZ0Z0bbOBWHovEkNJkc6JK1refVjyDM2nFtRpMNg4RLptrp6kmiE=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24607DCB67FF719ACF3511EABC230@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:+0loYbIoF6LRtrvsJHQUjdidml/vbg2wxoyqKpJ3Rqf2N53zf5NKrSsvH7LDnys2jPyR3WRNEfkiHRRoMEnv29CASCq8LFBqltpYLfFO+4KKRxrB9EQsQxqsCgf5X5m89/jECggRB5BIArwSe0MJSVAcVZOQC/1z4cweeoVBQfwmd0vakiXx1Wwbq5oGDTe/Icgyc32q3mlGklnHuFFhJ5iC4mwYaUtobsLX3vlorYCAxezMzmt09ieLlUVdsZDotOEhFdwJNSGUCqHLjZNTRA==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(2616005)(476003)(16586007)(2361001)(478600001)(11346002)(14444005)(76176011)(51416003)(4326008)(486006)(47776003)(305945005)(52116002)(25786009)(217873002)(54906003)(66066001)(2351001)(446003)(956004)(105586002)(68736007)(36756003)(316002)(106356001)(74482002)(186003)(50226002)(6486002)(97736004)(8936002)(1076002)(386003)(6512007)(7736002)(8676002)(2906002)(3846002)(6116002)(16526019)(53936002)(6506007)(6666003)(50466002)(86362001)(26005)(81166006)(81156014)(6916009)(5660300001)(7416002)(48376002)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:On0gX28QAYTfjAiF7QN+0P4sZLeOwuQD8MEyWx4?=
 =?us-ascii?Q?UjyVw/D8EkSe0Gc5QcOgYANcR4z6kP6JISMK9x0A6z6uOHD8W/csSxGjn29Y?=
 =?us-ascii?Q?yJ+SN/tI2Ix1qnUFmAOqAvRQwFgTkhlgFu3g8Vc1C5Y8bsw6v19vnCR9U7nK?=
 =?us-ascii?Q?ixfGPYZz4r6u44HLtv/AtGaoZ3OqoKr5iTg92cKC+dAD8gNu1nxBNaHE28EA?=
 =?us-ascii?Q?y8/yah06K/KTYInchxuzklVc4xt8CHQ2VMHD8jeW8eTi3FvHGtPlL8ZsJMZN?=
 =?us-ascii?Q?dabLTaZzhyBP3A7B88OBRCt95Smy66y7ieadMo9T1fWylTeWwtJbWi44Y0NK?=
 =?us-ascii?Q?WtUAVoAxJBTsBpsxkjf7bNhdBkYYKVfxqKueqj2jVi21f3ESy7xUS3WPjli0?=
 =?us-ascii?Q?QL71Mb9N1JJWKu6Rytyxq8U4OK8R6YG6BQY9CyuQQKoOkkD1+ETjDwZ8bB1S?=
 =?us-ascii?Q?JiKhN4UxoUDR+X9qZ1ttIY368fjmPwto4pRzPo6cBtpRS1hbYaxLuuRdEP9l?=
 =?us-ascii?Q?A9np+NOy8fr3Oa7WcoNEA1eqtz8b+qPABih8nKK8ycMxo75ErdYCxhSJ9DRX?=
 =?us-ascii?Q?/ZkWepi5J84psiNecYwqRg6yqydCCXE2uoWy72dVymlKkoEYNuSVrnWbwow2?=
 =?us-ascii?Q?Se0chwpnYlE/X1T6DI3aUX078SOQQ2X5F4ZJYp9BxTWvFWIDLU6MW141YCI2?=
 =?us-ascii?Q?SWzHPIvFOHPAyrI43r91TJBCrnN98+u7i+20/JAYTGSyy0l9v1dOrjrg7qTi?=
 =?us-ascii?Q?IFScx4qmHBi1Krk+bfbrYu+ANHMv2kCdNbGBr8vBMkmPg/pRG3U4ktIMV5fv?=
 =?us-ascii?Q?ZKF58DSum5aXbrHbBHg/AY9NEUvkiDPx2bfg9WJL/tuWSfbaTGAS3T2g3qgh?=
 =?us-ascii?Q?joeKtOWZAkyu22McSSX9Xej/uRyRFsCTmvsDJ6kxnG2/nsu5PhH2i1xUnYRo?=
 =?us-ascii?Q?Rw8VtnUJa9In4CVAEleEpUQgvtaGjJX5Fwun0iBTGYzna0L87REiK0CJhNhN?=
 =?us-ascii?Q?qhSWCvovWqkkBv3phth4iF0AZz2ZEHHg/j+FY9pNY/QCay+ruGEtQuY/GRyx?=
 =?us-ascii?Q?pyJLbJxqXoT/+fhGog29NnfkrrP0wyVFqHSnIc6VGuGqD1VRs+vN8n6TT8hj?=
 =?us-ascii?Q?Z5oiI6GtK2aq06edy/g8nXrKslxib3peJ2D79O1oSxLdi4G5up+dbCySe+vB?=
 =?us-ascii?Q?EJjp2bCgqW2fTT1DMFoIn2yyxnEZa7rRI6DXJ1nE8OJ8VJHAceW+lk9Oxz2h?=
 =?us-ascii?Q?YGNeQ3sLxG7aNDtomefAZCkX9qbfTRPHvz2M6P4RCmIvWfqRBoy6ytIVxTub?=
 =?us-ascii?Q?FeiKdddXzOkClF6aLMoxMUKV6jX88VRkN3LvX+LyphoErPX8Wbi7t0nWlhAM?=
 =?us-ascii?Q?M+jN4vya+He7fKc7UQISvwWR0Mpw=3D?=
X-Microsoft-Antispam-Message-Info: x/+ghNQI7AK4Ckc7ybQwlm8uVshVmmFmaPHO0Im9G29siti6SNfZuDlWIb8VdVIoqMsLgzIM96mEf5cDR3TyXfJdUyb+wDDTd2Kq54ouEXchKdxCvNqTuATM09D+ruEu45TycgDiBf05OfthVVp5nIdiCozSccjkKNVRyUTQju2+ZUylykysRBTNbDMPdu10OmkT9m//IaQePKF2BBUjN8jr1s58GIlhjt7SpJZcX2UQxf4zMiJoWd2/E3ql0l/UHKf+Au7rTxHWCWmrImS9B2J8dtrccgdRDbf3JTSbZyCUacC5at2dPNdG/hb50qFwYykMBAerbTJh0e87jk+ubxxAF8/SXMmRAFhOzWa6hrQ=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:tm7JHRNpqxemzNtg8yPpjOY+uW1VxZR228GXI/nze8uU6WOOXf4vqV6N3Ig7eKjc8bW6ZS0vzJL7ngxwWJ9/lbZ1a9goCzFUlRIrgQBx8Ona1NAP7tzHQIRWUmMjQQXymV2KkHgyCD2c1AZeQd49BZbLxhWGy7qAmJlZYuwHQywUlAPJbpvn/BXx8awJXW4B9FFDdg2sa25TUscZQPQDSotNHJ+k7wvo3SpWPGhJXcf3ATJtSAIW2pSn3ItLHWwBWiHeUJZyzRhQph0+jpPsVf261BfQMm9AIkeCbekQ1auBle7MIUYrUuiFpkECxHLXLh2MH+xTaNvJDw4HwdYtJY5KiIFKd6bHgLs3fYBx1KYdP+oJ8qF3HCdNJ7xDwbwJkwruT+VhNt1nFNb2wny/W9Xr0cCldUXVNOjSkG8H5EX6Bhrj4eAA0zlIkF5CnAnxRPlOALLEFaxnzhHV9IwA9A==;5:qBRQ2dY43ci5hgQUn+EnkAz9WhVLNGgslz6aRazLNTDScI+5N247IHtP7XW6k9IkPXWTxpYPPnDK8+yVpLEbtds9D2979KH1RUa5Led4yTveHHVdeKsyUazXPpwkJnbZXWolaaRcvv16n63CATvzj1DAXNigCvSv3oQceowpElE=;7:x9fcgjYUH66iJTiNxiwnot3PLkgg/56Nz6tl2KvWErZN1WOsIB8PfPzI+chd4UAUdNJYS8EthNmngEYuf2yf1eDMU8GamVgPWgF5leZf0z/V/UYED4fsFogknpm5u7e84+0g/qeAaEDn57oabXORuQc8bC5ICX6NBvaoAgD9O5H57AOQ/e5gkWDyz2jLLDTMOcJu72aZBDeU3R9QiElJMwLOcSt5DkA8VKVi9TqWgAfSgY3v+pj27hIaKx59G3aD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 07:23:21.9556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2243150b-766d-4ab1-a4e5-08d5f911ff30
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start list of actual chips compatible with "lvds-encoder".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index fd39ad34c383..50220190c203 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,7 +22,13 @@ among others.
 
 Required properties:
 
-- compatible: Must be "lvds-encoder"
+- compatible: Must be one or more of the following
+  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
+  - "lvds-encoder" for a generic LVDS encoder device
+
+  When compatible with the generic version, nodes must list the
+  device-specific version corresponding to the device first
+  followed by the generic version.
 
 Required nodes:
 
-- 
2.11.0

