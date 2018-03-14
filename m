Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELvmIVynvYKHUcCtcAc5tTApy0TbYHO3XL34K6RuwX0IOCWATxwICJDIpJzC4QhDlRnlCRdk
ARC-Seal: i=1; a=rsa-sha256; t=1521059028; cv=none;
        d=google.com; s=arc-20160816;
        b=TJmHhxqs/tgACmT3KxBmZIiRkwyCc50CCYY5N8b2xZIeI7o28gciZYQgRKDZGyFfaB
         x9GSeWk47wgXcPoMBVJSg/3q3LEkwoPdzdILg0vOKi1p+yv9NauXHfPQ1liz1tirt7KO
         CQZOOG+jvqydoh/9ZsWDLvIPXGHImv3yFNBIPLbtXS9k5h8zNPxVXPDKut0sc+3NtTtM
         Ig01z//rNS2RqhaQVM7RXKjcXndVIMeat6nhYQzm/S/iCLXPbwQ/2AZNOVkO4gUcqmsC
         WLtp/+WVnfOnCgtNW0lLmS5AW+J+t7TBi5iAJDVJqOmUhdKZcw3pAgAJAyLeAVuAQgUo
         wv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=jua0I/24ZmNeJXwrNteVPs9XrOhCXRK6CDl9F7YB1zQ=;
        b=U5Dt6eDRqS1NmTQBS/xJq3UgFj+gDOaN3l0BjMYWsifnbew6tltiYyY4Nz6ANqO8s3
         3qj2wF85BhFof6XSegiykycyJY8koFr0AIBi5YYv13wrKM5Pr1yatV6bOMw3lB5V57hg
         y2EkGzpXtae0Eh1Xzy5MzIxi/7UbG5QcP72yegWur3BWDtIDp6H2iPMdNeceIU7PpmOu
         nq4D9GpHPM3JkXxs+IWLjIN71J3Vp4Zz2a+T2EVzWeDFIK3sV2nLCAMLlrG/Txrnqk71
         /w4Zd446A0QMhWi15iHsSSYs443XXAxNwARv/MvNqJwj9+pc4Ajo+qcSapoVqEXO7bgj
         7WRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:36 +1100
Subject: [PATCH 07/13] staging: mt7621-eth: Document ralink/mediatek SoC
 ethernet binding
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105895593.22262.7124655301943448670.stgit@noble>
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594945992158002946?=
X-GMAIL-MSGID: =?utf-8?q?1594945992158002946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Crispin <blogic@openwrt.org>

Add possible dt binding for mediatek gigabit switches.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: NeilBrown <neil@brown.name>
---
 .../devicetree/bindings/net/mediatek-net-gsw.txt   |   48 ++++++++++++++++++++
 drivers/staging/mt7621-eth/TODO                    |    4 ++
 2 files changed, 52 insertions(+)
 create mode 100644 drivers/staging/mt7621-eth/Documentation/devicetree/bindings/net/mediatek-net-gsw.txt
 create mode 100644 drivers/staging/mt7621-eth/TODO

diff --git a/drivers/staging/mt7621-eth/Documentation/devicetree/bindings/net/mediatek-net-gsw.txt b/drivers/staging/mt7621-eth/Documentation/devicetree/bindings/net/mediatek-net-gsw.txt
new file mode 100644
index 000000000000..596b38552697
--- /dev/null
+++ b/drivers/staging/mt7621-eth/Documentation/devicetree/bindings/net/mediatek-net-gsw.txt
@@ -0,0 +1,48 @@
+Mediatek Gigabit Switch
+=======================
+
+The mediatek gigabit switch can be found on Mediatek SoCs.
+
+Required properties:
+- compatible: Should be "mediatek,mt7620-gsw", "mediatek,mt7621-gsw",
+  "mediatek,mt7623-gsw"
+- reg: Address and length of the register set for the device
+- interrupts: Should contain the gigabit switches interrupt
+
+
+Additional required properties for ARM based SoCs:
+- mediatek,reset-pin: phandle describing the reset GPIO
+- clocks: the clocks used by the switch
+- clock-names: the names of the clocks listed in the clocks property
+  these should be "trgpll", "esw", "gp2", "gp1"
+- mt7530-supply: the phandle of the regulator used to power the switch
+- mediatek,pctl-regmap: phandle to the port control regmap. this is used to
+  setup the drive current
+
+
+Optional properties:
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+
+Example:
+
+gsw: switch@1b100000 {
+	compatible = "mediatek,mt7623-gsw";
+	reg = <0 0x1b110000 0 0x300000>;
+
+	interrupt-parent = <&pio>;
+	interrupts = <168 IRQ_TYPE_EDGE_RISING>;
+
+	clocks = <&apmixedsys CLK_APMIXED_TRGPLL>,
+		 <&ethsys CLK_ETHSYS_ESW>,
+		 <&ethsys CLK_ETHSYS_GP2>,
+		 <&ethsys CLK_ETHSYS_GP1>;
+	clock-names = "trgpll", "esw", "gp2", "gp1";
+
+	mt7530-supply = <&mt6323_vpa_reg>;
+
+	mediatek,pctl-regmap = <&syscfg_pctl_a>;
+	mediatek,reset-pin = <&pio 15 0>;
+
+	status = "okay";
+};
diff --git a/drivers/staging/mt7621-eth/TODO b/drivers/staging/mt7621-eth/TODO
new file mode 100644
index 000000000000..5f269af0db5c
--- /dev/null
+++ b/drivers/staging/mt7621-eth/TODO
@@ -0,0 +1,4 @@
+
+- verify devicetree documentation is consistent with code
+
+Cc: NeilBrown <neil@brown.name>
