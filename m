Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqchwRR/pzC1rxWGoEQRG9uv9ObFD7n+1MAFVnB6SrCRY/J9blZO0W2SCnbjA8Nw4SKOerS
ARC-Seal: i=1; a=rsa-sha256; t=1526937847; cv=none;
        d=google.com; s=arc-20160816;
        b=xWYCJorvOEKdv+72+ZJnDZLBbXuWG/DxEeGvLNacNsbSXAvDIAh8CNJNteDn3yKL7H
         AVgpA3/v6dKkd8kdjzbx/9oAOAMISYPmj5nsvyks7zRiDEwBiyt0sHme2+xeulvf7uZC
         NKO+5HiI/s9KC+Xd3DunNI0CGD/WXhi7vWlUfEGFgTnxlByZ+DU9tw3tOpn3jmL6Qc2n
         73TEdIBWwmOoPiJnkyqL1citInFqyjgXceSVnKbB4sQ1araxwpoY3N2eRLpIO+n+PxQp
         qhbYiemvgezCzU1uFS1zARf1V0OTTZ/0r8LI4mL0mQ3qi+F2W3TU4VZ3wC5+4f8vc90A
         UT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NfLV3jthL6RRVbsvIZhZzjAVmuBomJEPk0T63fTH7J8=;
        b=i+i6993QiKbPNGObOsmVVtUUQwZbqUD7pEs90sfkJycLAEB/wk5gqG+aAUsHI5vQzr
         nx52BLAJtyGmt2JtVloS+u7CkZbV/wlGcdl4wa0pGNrynAV4aY6eqTWcWHdWYGk3sZ1z
         GntT/LYeDQR6TwvBasQPVi/GQlxPMD6nlmdeJ4haa9WplJOjuI5Ppz2zh9yRuUL3SH+I
         +v81RR8pwZwZAhstWRlrDfCgJhPHXcr6qyfYB5DkPHDun8kf9wgK+2VDBIcWmp1sAUXW
         66mKS00B7BeMFnv6ppTIkPGCeXtdWxzYa6xqiGdqAVxtRzQToFP5VV9f0pI30ZOGrmR3
         K0vA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q7wxvIUH;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q7wxvIUH;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4.16 030/110] ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node
Date: Mon, 21 May 2018 23:11:27 +0200
Message-Id: <20180521210506.440063348@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110380295633221?=
X-GMAIL-MSGID: =?utf-8?q?1601110380295633221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

commit f43194c1447c9536efb0859c2f3f46f6bf2b9154 upstream.

Marvell PPv2.2 controller present on CP-110 need the extra "mg_core_clk"
clock to avoid system hangs when powering some network interfaces up.

This issue appeared after a recent clock rework on Armada 7K/8K platforms.

This commit adds the new clock and updates the documentation accordingly.

[gregory.clement: use the real first commit to fix and add the cc:stable
flag]
Fixes: e3af9f7c6ece ("RM64: dts: marvell: armada-cp110: Fix clock resources for various node")
Cc: <stable@vger.kernel.org>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/net/marvell-pp2.txt |    9 +++++----
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi         |    5 +++--
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/Documentation/devicetree/bindings/net/marvell-pp2.txt
+++ b/Documentation/devicetree/bindings/net/marvell-pp2.txt
@@ -21,9 +21,10 @@ Required properties:
 	- main controller clock (for both armada-375-pp2 and armada-7k-pp2)
 	- GOP clock (for both armada-375-pp2 and armada-7k-pp2)
 	- MG clock (only for armada-7k-pp2)
+	- MG Core clock (only for armada-7k-pp2)
 	- AXI clock (only for armada-7k-pp2)
-- clock-names: names of used clocks, must be "pp_clk", "gop_clk", "mg_clk"
-  and "axi_clk" (the 2 latter only for armada-7k-pp2).
+- clock-names: names of used clocks, must be "pp_clk", "gop_clk", "mg_clk",
+  "mg_core_clk" and "axi_clk" (the 3 latter only for armada-7k-pp2).
 
 The ethernet ports are represented by subnodes. At least one port is
 required.
@@ -80,8 +81,8 @@ cpm_ethernet: ethernet@0 {
 	compatible = "marvell,armada-7k-pp22";
 	reg = <0x0 0x100000>, <0x129000 0xb000>;
 	clocks = <&cpm_syscon0 1 3>, <&cpm_syscon0 1 9>,
-		 <&cpm_syscon0 1 5>, <&cpm_syscon0 1 18>;
-	clock-names = "pp_clk", "gop_clk", "gp_clk", "axi_clk";
+		 <&cpm_syscon0 1 5>, <&cpm_syscon0 1 6>, <&cpm_syscon0 1 18>;
+	clock-names = "pp_clk", "gop_clk", "mg_clk", "mg_core_clk", "axi_clk";
 
 	eth0: eth0 {
 		interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -40,9 +40,10 @@
 			compatible = "marvell,armada-7k-pp22";
 			reg = <0x0 0x100000>, <0x129000 0xb000>;
 			clocks = <&CP110_LABEL(clk) 1 3>, <&CP110_LABEL(clk) 1 9>,
-				 <&CP110_LABEL(clk) 1 5>, <&CP110_LABEL(clk) 1 18>;
+				 <&CP110_LABEL(clk) 1 5>, <&CP110_LABEL(clk) 1 6>,
+				 <&CP110_LABEL(clk) 1 18>;
 			clock-names = "pp_clk", "gop_clk",
-				      "mg_clk", "axi_clk";
+				      "mg_clk", "mg_core_clk", "axi_clk";
 			marvell,system-controller = <&CP110_LABEL(syscon0)>;
 			status = "disabled";
 			dma-coherent;
