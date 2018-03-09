Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607055; cv=none;
        d=google.com; s=arc-20160816;
        b=QsN8rxIpRtRiZPHEFmorLwDqScelayrC5JKZX8MguBW8faIFCwzfoxQH0aiIGsvm1k
         y7UkBKcOpaalcwJgw+i/j1Yrg229nSTjna/GdRZWtxUoqHMgc0rSl824PUyz0H+K3Pfw
         Tv58tj7g/1KQHnw0ugit1IOCa1qTkfJKpAH3V/uxfAS4EC8SEoMvpadByS3WIsXBTV6w
         TE48+75VTeHOz/HUESEYtWBBirTX+z12YoioR/cz5zvRK3uuo2F7/TdpLaULc8HK4jKk
         nz9+niLZLsof7p83qUTJgo0BRdk8e84+IRUPoAG0w1Pt8SHcD92luFojD+HmxHMpVBkn
         PtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qpEYox52IfOO1r/zjGnj1eWI1ORkVK2L+qDQ0Z1/bM8=;
        b=bOYXBYbwFXN0+5EzkDHcnGoQ2EcRi1Xqq034Pg1lxzpeS8O9oA5HZKS+8V+VtkpRtw
         rW463jvv9XUuy+owhCsUjQwjechrX7p0mtYem7kBc/WdutjE7+J/NG48O9oCkIBbkLo5
         o28PK4+DtQ8BekpBODW1PL71pjyzw0C2xrHSa0VIlyD4zcSfDhCJMQNIbpdieesYIQ7m
         QnrH/bupFBmPwvCrSoXfdnJZdZ7FRT/b/w67y7PC3F9+yg1/bBw4eA9pw+I6VfAboKEz
         pb5qVpmd9rE1q3Ifj7hKmyGwGlUa6JgNDAzrYBUreQu2H2uSPs5cSU4KbFb8Z4KIz+Q2
         EBZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EM+F+jf4;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EM+F+jf4;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvjgwTc06zkB9A/imkbhoZVTdLvGlsxVeys5vXfVsUCb3IivNwlJq9fXzwGsdqEghktJbAdMw==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 24/25] dt-bindings: nvmem: imx-ocotp: update the binding to reflect data cells
Date: Fri,  9 Mar 2018 14:47:18 +0000
Message-Id: <20180309144719.29904-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472064199094898?=
X-GMAIL-MSGID: =?utf-8?q?1594472064199094898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dong Aisheng <aisheng.dong@nxp.com>

imx-ocotp is implemented based on nvmem which can have data cells
as child node. Update the binding doc to reflect it to be more easily
understood by users.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/imx-ocotp.txt        | 23 ++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index f162c72b4e36..729f6747813b 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -11,17 +11,32 @@ Required properties:
 	"fsl,imx6ul-ocotp" (i.MX6UL),
 	"fsl,imx7d-ocotp" (i.MX7D/S),
 	followed by "syscon".
+- #address-cells : Should be 1
+- #size-cells : Should be 1
 - reg: Should contain the register base and length.
 - clocks: Should contain a phandle pointing to the gated peripheral clock.
 
 Optional properties:
 - read-only: disable write access
 
-Example:
+Optional Child nodes:
+
+- Data cells of ocotp:
+  Detailed bindings are described in bindings/nvmem/nvmem.txt
 
+Example:
 	ocotp: ocotp@21bc000 {
-		compatible = "fsl,imx6q-ocotp", "syscon";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,imx6sx-ocotp", "syscon";
 		reg = <0x021bc000 0x4000>;
-		clocks = <&clks IMX6QDL_CLK_IIM>;
-		read-only;
+		clocks = <&clks IMX6SX_CLK_OCOTP>;
+
+		tempmon_calib: calib@38 {
+			reg = <0x38 4>;
+		};
+
+		tempmon_temp_grade: temp-grade@20 {
+			reg = <0x20 4>;
+		};
 	};
-- 
2.15.1
