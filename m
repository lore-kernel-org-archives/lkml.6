Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDACC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DB520851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DB520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbeHWMnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:43:55 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:60399 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbeHWMny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:43:54 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 2B/46-18735-91B7E7B5; Thu, 23 Aug 2018 09:15:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRWlGSWpSXmKPExsUS3ulwWFeiui7
  aoHOOtcX8I+dYLQ4vesFocfPTN1aLy7vmsFksvX6RyaJ17xF2BzaPNfPWMHrsnHWX3WPTqk42
  j8+b5AJYolgz85LyKxJYM+4+f8NacE654vfFXrYGxluyXYxcHEICaxkl1rzcwdrFyAnkVEjs+
  H4FzOYViJC4dnkmG4jNKWAmcXD2BBaIGlOJ5l9XwWw2AR2JRzPXM4HYLAKqEl1/p4PZwgI+Es
  9OtzCC2CICQRKPH51lAVnGLLCbUeLDhQPMEAsEJU7OfAI2iFlAQuLgixfMEAu0JM6tWQXWLCF
  gLzH9/VVmCFtf4uXXjUwQtqHE91nfWCBsc4ne45vYIGxriesfZrFNYBSahWTFLCQrFjAyrWK0
  TCrKTM8oyU3MzNE1NDDQNTQ01jXWNTK01Eus0k3USy3VTU7NKylKBMrqJZYX6xVX5ibnpOjlp
  ZZsYgRGCgMQ7GBcNCf1EKMkB5OSKO9n/9poIb6k/JTKjMTijPii0pzU4kOMMhwcShK8PlV10U
  KCRanpqRVpmTnAmIVJS3DwKInwPqwESvMWFyTmFmemQ6ROMVpyfHraM4mZY9X9KUDyz/upk5i
  FWPLy81KlxHmtQOYJgDRklObBjYOllUuMslLCvIxABwrxFKQW5WaWoMq/YhTnYFQS5n0EspYn
  M68EbusroIOYgA5iZa4FOagkESEl1cC4ctbyOoc5sht2vvi8+JnDtWk3cpcJ6dY1eW4X5/5x6
  ATjz9ePZKO/un7ZdPCC2NVUTtdDPGftLARqDd7tl50r/4cn+/gMEYO0FT+v7TqnU3tM/i73tJ
  nzjRd8bHzf8PPPuQkPJzC6OKzI3TWvzJQllYfx5Fo9Tnvr3TGLe9bZrXa7Ma1E9Z6QnxJLcUa
  ioRZzUXEiAKVVKv4mAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-9.tower-229.messagelabs.com!1535015703!4525460!3
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24930 invoked from network); 23 Aug 2018 09:15:04 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-9.tower-229.messagelabs.com with AES128-SHA encrypted SMTP; 23 Aug 2018 09:15:04 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 23 Aug 2018 11:15:04 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 F10335F7FB; Thu, 23 Aug 2018 18:15:02 +0900 (KST)
Message-ID: <0d2a3c034a567d3a3ccd2e965f40e9af28f7e4d3.1534830272.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1534830272.git.Roy.Im@diasemi.com>
References: <cover.1534830272.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 21 Aug 2018 14:44:31 +0900
Subject: [PATCH V4 2/3] dt-bindings: input: Add document bindings for DA7280
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
X-KSE-Antivirus-Info: Clean, bases: 23.08.2018 07:55:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add device tree binding information for DA7280 haptic driver.
Example bindings for DA7280 are added.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v4: Fixed commit message, properties.

v3: Fixed subject format.

v2: No changes


 .../devicetree/bindings/input/dlg,da7280.txt       |  101 ++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt

diff --git a/Documentation/devicetree/bindings/input/dlg,da7280.txt b/Documentation/devicetree/bindings/input/dlg,da7280.txt
new file mode 100644
index 0000000..a61e9f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/dlg,da7280.txt
@@ -0,0 +1,101 @@
+Dialog Semiconductor DA7280 Haptics bindings
+
+Required properties:
+- compatible: Should be "dlg,da7280".
+- reg: Specifies the I2C slave address.
+
+- interrupt-parent : Specifies the phandle of the interrupt controller to
+  which the IRQs from DA7280 are delivered to.
+
+- dlg,vib-mode:
+  "LRA-MODE" - Linear Resonance Actuator mode.
+  "ERM-BAR" - Bar type Eccentric Rotating Mass mode.
+  "ERM-COIN" - Coin type Eccentric Rotating Mass mode.
+
+- dlg,op-mode: Haptic operation mode.
+  Possible values:
+	1 - Direct register override mode triggered by i2c(default),
+	2 - PWM data source mode setting duty to 0 - 0xffff(0% - 100%),
+	3 - Register triggered waveform memory mode, the pattern assigned
+	    to the PS_SEQ_ID played as much times as PS_SEQ_LOOP,
+	4 - Edge triggered waveform memory mode, external GPI(N) condtrol
+	    are required to enable/disable and it needs to keep
+	    device enabled by sending magnitude (X > 0),
+	    the pattern is assigned to the GPI(N)_SEQUENCE_ID below
+	    For more details, please see the datasheet.
+
+- dlg,nom-microvolt: Nominal actuator voltage rating.
+  Valid values: 0 - 6000000.
+- dlg,abs-max-microvolt: Absolute actuator maximum voltage rating.
+  Valid values: 0 - 6000000.
+- dlg,imax-microamp: Actuator max current rating.
+  Valid values: 0 - 252000.
+  Default: 130000.
+- dlg,impd-micro-ohms: the impedance of the actuator in micro ohm,
+  as read from its datasheet.
+  Valid values: 0 - 1500000000.
+
+Optional properties:
+- pwms : phandle to the physical PWM(Pulse Width Modulation) device.
+  PWM properties should be named "pwms". And number of cell is different
+  for each pwm device.
+  (See Documentation/devicetree/bindings/pwm/pwm.txt
+   for further information relating to pwm properties)
+
+- dlg,ps-seq-id: the PS_SEQ_ID(pattern ID in waveform memory inside chip)
+  to play back when RTWM-MODE is enabled.
+  Valid range: 0 - 15.
+- dlg,ps-seq-loop: the PS_SEQ_LOOP, Number of times the pre-stored sequence
+  pointed to by PS_SEQ_ID or GPI(N)_SEQUENCE_ID is repeated.
+  Valid range: 0 - 15.
+- dlg,gpiN-seq-id: the GPI(N)_SEQUENCE_ID, pattern to play
+  when gpi0 is triggered, 'N' must be 0 - 2.
+  Valid range: 0 - 15.
+- dlg,gpiN-mode: the pattern mode which can select either
+  "Single-pattern" or "Multi-pattern", 'N' must be 0 - 2.
+- dlg,gpiN-polarity: gpiN polarity which can be chosen among
+  "Rising-edge", "Falling-edge" and "Both-edge",
+  'N' must be 0 - 2
+  Haptic will work by this edge option in case of ETWM-MODE.
+
+- dlg,resonant-freq-hz: use in case of LRA-MODE.
+  the frequency range: 50 - 300.
+  Default: 205.
+
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
+	haptics: da7280-haptics@4a {
+		compatible = "dlg,da7280";
+		reg = <0x4a>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		dlg,vib-mode = "LRA-MODE";
+		dlg,op-mode = <1>;
+		dlg,nom-microvolt = <2000000>;
+		dlg,abs-max-microvolt = <2000000>;
+		dlg,imax-microamp = <170000>;
+		dlg,resonant-freq-hz = <180>;
+		dlg,impd-micro-ohms = <10500000>;
+		dlg,freq-track-enable;
+		dlg,rapid-stop-enable;
+	};
-- 
end-of-patch for PATCH V4

