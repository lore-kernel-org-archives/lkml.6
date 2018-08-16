Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90600C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5673B20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5673B20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbeHPFv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:51:28 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:8185 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387873AbeHPFv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:51:28 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id BE/11-09223-AC7E47B5; Thu, 16 Aug 2018 02:56:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRWlGSWpSXmKPExsUS3ulwWPfk85J
  og/49Jhbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzbh0eRtzwR/linNLJ7M3MG6Q62Lk4hASWMsocWT7NpYuRk4gp0Ji7
  5GjbCA2r0CERN+eqYxdjBwcnAJmEq9XFYGYQgKmEhNWG4BUsAnoSDyauZ4JxGYRUJWYvO4lM4
  gtLBAo0dPcCDZRRCBI4vGjsywgq5gFdjNKfLhwgBlivKDEyZlPwIqYBSQkDr54wQxxgpbEuTW
  rGEFsCQF7ienvrzJD2PoSL79uZIKwDSW+z/rGAmGbSyy+MwPKtpa4/mEW2wRGoVlIVsxCsmIB
  I9MqRoukosz0jJLcxMwcXUMDA11DQyNdQ0tTIDbQS6zSTdRLLdUtTy0u0TXUSywv1iuuzE3OS
  dHLSy3ZxAiMEQYg2MF44VvyIUZJDiYlUV796uJoIb6k/JTKjMTijPii0pzU4kOMMhwcShK8as
  CYExIsSk1PrUjLzAFGK0xagoNHSYQ34xlQmre4IDG3ODMdInWK0ZLj09OeScwcq+5PAZJ/3k+
  dxCzEkpeflyolzisCMk8ApCGjNA9uHCyhXGKUlRLmZQQ6UIinILUoN7MEVf4VozgHo5Iw7zOQ
  tTyZeSVwW18BHcQEdFCySCHIQSWJCCmpBkZFFv4dd+Vf235kFd5XNbu5O+AeE+/S5qJ/C1sXi
  5due5BqutGFaZ/JIWGvhTeuO0/6afR3tovqg9+12Urnpq5xkG8t/30+5oY284RTp88yVRnYFI
  kwRgmvmOwsd5vxoEpRyYviucpetytKK4RTj/xuMLRa9+nLxg/PPP/JnjHZPidTRGLll5VKLMU
  ZiYZazEXFiQARDS/fIwMAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-8.tower-268.messagelabs.com!1534388168!5525239!3
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4216 invoked from network); 16 Aug 2018 02:56:09 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-8.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 16 Aug 2018 02:56:09 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 16 Aug 2018 04:56:08 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 73B875F7FB; Thu, 16 Aug 2018 11:56:07 +0900 (KST)
Message-ID: <e33eb7a560eec88e0bed211c570ef1087aceeb95.1534384964.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1534384964.git.Roy.Im@diasemi.com>
References: <cover.1534384964.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 16 Aug 2018 11:02:44 +0900
Subject: [PATCH V1 2/3] Documentation: devicetree: input: new binding for
 da7280
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>,
        <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 16.08.2018 00:48:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


from: Roy Im <roy.im.opensource@diasemi.com>

Add device tree binding information for DA7280 haptic driver.
Example bindings for DA7280 are added.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---

 .../devicetree/bindings/input/dlg,da7280.txt       |   91 ++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt

diff --git a/Documentation/devicetree/bindings/input/dlg,da7280.txt b/Documentation/devicetree/bindings/input/dlg,da7280.txt
new file mode 100644
index 0000000..759bcfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/dlg,da7280.txt
@@ -0,0 +1,91 @@
+Dialog Semiconductor DA7280 Haptics bindings
+
+Required properties:
+- compatible: Should be "dlg,da7280".
+- reg: Specifies the I2C slave address.
+
+- interrupt-parent : Specifies the phandle of the interrupt controller to
+  which the IRQs from DA7280 are delivered to.
+- interrupts: IRQ line info for DA7280.
+  (See Documentation/devicetree/bindings/interrupt-controller/
+   interrupts.txt for further information relating to interrupt properties)
+- dlg,vib-mode:
+  "LRA-MODE" - Linear Resonance Actuator mode.
+  "ERM-BAR" - Bar type Eccentric Rotating Mass mode.
+  "ERM-COIN" - Coin type Eccentric Rotating Mass mode.
+- dlg,play-mode: choose one in below five modes.
+  "DRO-MODE" - Direct register override mode.
+  "PWM-MODE" - PWM data source mode.
+	In this case, user is able to set duty to 0 ~ 0xffff(0% ~ 100%)
+  "RTWM-MODE" - Register triggered waveform memory mode.
+	In this case, when enable this mode the pattern assigned
+	to the PS_SEQ_ID will be played as much times as PS_SEQ_LOOP.
+  "ETWM-MODE" - Edge triggered waveform memory mode.
+	In this case, external GPI(N) control are required to enable/disable
+	and it needs to keep device enabled by sending magnitude (X > 0)
+	the pattern assigned to the GPI(N)_SEQUENCE_ID below.
+	For more details, please see the datasheet.
+- dlg,nom-microvolt: Nominal actuator voltage rating.
+- dlg,abs-max-microvolt: Absolute actuator maximum voltage rating.
+- dlg,imax-microamp: Actuator max current rating.
+- dlg,impd-micro-ohms: the impedance of the actuator in micro ohm,
+  as read from its datasheet.
+
+Optional properties:
+- pwms : phandle to the physical PWM(Pulse Width Modulation) device.
+  PWM properties should be named "pwms". And number of cell is different
+  for each pwm device.
+  (See Documentation/devicetree/bindings/pwm/pwm.txt
+   for further information relating to pwm properties)
+- dlg,ps-seq-id: the PS_SEQ_ID(pattern ID in waveform memory inside chip)
+  to play back when RTWM-MODE is enabled.
+- dlg,ps-seq-loop: the PS_SEQ_LOOP, Number of times the pre-stored sequence
+  pointed to	by PS_SEQ_ID or GPI(N)_SEQUENCE_ID is repeated.
+- dlg,gpiN-seq-id: the GPI(N)_SEQUENCE_ID, pattern to play
+  when gpi0 is triggered, 'N' must be 0~2.
+- dlg,gpiN-mode: the pattern mode which can select either
+  "Single-pattern" or "Multi-pattern", 'N' must be 0~2.
+- dlg,gpiN-polarity: gpiN polarity which can be chosen among "Rising-edge",
+  "Falling-edge" and "Both-edge", 'N' must be 0~2.
+  Haptic will work by this edge option in case of ETWM-MODE.
+
+- dlg,resonant-freq-hz: use in case of LRA-MODE, default 205Hz.
+  the freq range: 50Hz ~ 300Hz.
+  It will be set to 205Hz if the value is out of range.
+- dlg,bemf-sens-enable: Enable for internal loop computations.
+- dlg,freq-track-enable: Enable for resonant frequency tracking.
+- dlg,acc-enable: Enable for active acceleration.
+- dlg,rapid-stop-enable: Enable for rapid stop.
+- dlg,amp-pid-enable: Enable for the amplitude PID.
+- dlg,mem-array: use in case that memory registers should be updated,
+  Please fill the whole buffers(100 bytes) to avoid any error in driver.
+  For example,
+	dlg,mem-array = <
+		0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0A
+		...
+		0x71 0x72 0x73 0x74 0x75 0x76 0x77 0x78 0x79 0x7A
+		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+	>;
+
+For further information, see device datasheet.
+
+======
+
+Example:
+
+	haptics: da7280-haptics@4A {
+		compatible = "dlg,da7280";
+		reg = <0x4A>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		dlg,vib-mode = "LRA-MODE";
+		dlg,play-mode = "DRO-MODE";
+		dlg,nom-microvolt = <2000000>;
+		dlg,abs-max-microvolt = <2000000>;
+		dlg,imax-microamp = <170000>;
+		dlg,resonant-freq-hz = <180>;
+		dlg,impd-micro-ohms = <10500000>;
+		dlg,freq-track-enable;
+		dlg,rapid-stop-enable;
+	};
-- 
end-of-patch for PATCH V1

