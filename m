Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654EFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E8324899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="eQ64X/vF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TCfNU3o6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E8324899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeGCHEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52759 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754570AbeGCHEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 85EE621947;
        Tue,  3 Jul 2018 03:04:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Jul 2018 03:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6qVCw7E0oetDPTfUw
        s9GVMXyGTOvb/YYzziES5qsg74=; b=eQ64X/vFWcs5XX2Go3idKH7vBjs+chgpf
        eSXaOCYsq/rAGdC3hPxVors+Sx8gnDzvBHQLjhXNXsz6xann7ed4vFj0EPOva7Nh
        YkTBBDHmIlJk3lYjpYbMfEAtb/HFbMenOQhvxlHjlBtME98PHvyJVUrfIu/1dlWc
        lTKqbEK6HW2fV/B2yPwbH4VjSXCUQe1Wash2RNWHL0HK/j97ECRbYclT8sthqJYw
        9je9BKrhxJLDzfo3F6F7b04G8G02s7VG03ePbCk+QcSD5BOkX6YUttWYakJaDTwv
        dE01eYrBDL0srO4UUvzbWDDb3iJFYVU+T1uwSS/JMVdO3oV0AlrNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=6qVCw7E0oetDPTfUws9GVMXyGTOvb/YYzziES5qsg74=; b=TCfNU3o6
        zi8B8aHf7TMr5m16i7GiavkdEj+/uuY+61zitI/pxWUtK0ytRf+lnn49Y5OG4fn/
        KYbyZt2GWwsE781NsIj0El1fbLCHHOVZIGjOOISye0zsdIM8cgprb3/zekSU4Css
        K/AudIW4CwqiodiTOikOeYKgy03FxV70wFKfPYsptBybgAm35Bo8JaBkmrUU/5T+
        mVC54LKrN4zetD5eF1epNipKh6Oz1sP3ur7026rSXITgRxjwdazcU1353vbnuP1Y
        4TcAiIWVaLsitRSgohvN1FLigxolvwbGuyQmmjBHb+VjvD/ZRCFsdgZ/4WMYqq7M
        jSgV4hQCvy7c2Q==
X-ME-Proxy: <xmx:ByA7W3ymUgGUO5NTWj1rV4qq3xQcZIUx0apk9aYaRqChS9G5LYnIHQ>
    <xmx:ByA7WzbtCY4zocqhX8Mrj0lGiOgy_u4EZnrmB2PD9fj7auZElgQqgQ>
    <xmx:ByA7W-VCZTCvHjLNEua4jHIUJCmChL2s27wLmZaHYcYYmthHc-G5iQ>
    <xmx:ByA7W8HVNJlAnENqp83BILeOHsqkhaRf_MhbdX3H6FYBhvdZ3QAw2A>
    <xmx:ByA7WwBCHEJcorqeg2Gz_D50ZCKRoIwPQnf4ZDLEJ4srDtpG33Ywyw>
    <xmx:ByA7W03rc6iesvt9J7A0qOA1ddjOXVNfGHGpJXPthFFxq-5untOJog>
X-ME-Sender: <xms:ByA7WzIsqgObRLznVMxLTRSPtcr_TyrNNGffjs550fa61DcxdvKeIQ>
Received: from dave.bha-au.ibmmobiledemo.com (unknown [202.81.18.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id C19151032B;
        Tue,  3 Jul 2018 03:04:34 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/4] dts: misc: Add bindings documentation for bmc-misc-ctrl
Date:   Tue,  3 Jul 2018 17:04:10 +1000
Message-Id: <20180703070413.28756-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703070413.28756-1-andrew@aj.id.au>
References: <20180703070413.28756-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
new file mode 100644
index 000000000000..4661926030e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
@@ -0,0 +1,252 @@
+BMC Miscellaneous Control Interfaces
+====================================
+
+Baseboard Management Controllers (BMCs) often have an array of hardware
+features that need to be described but are awkward to sensibly expose.
+
+This bindings document provides a generic mechanism for describing such
+features, covering read-only (RO), read-modify-write (RMW) and
+write-1-set/write-1-clear (W1SC) semantics.
+
+All uses of bmc-misc-ctrl must be documented under Valid Uses below.
+
+The bindings are similar in nature to register-bit-led.
+
+Required Properties
+-------------------
+
+compatible: 	Must be "bmc-misc-ctrl"
+offset:		A one or three cell property describing the registers
+		associated with the field.
+
+		If the optional property 'set-clear' is not present then the
+		node describes a register with read-modify-write semantics. The
+		offset property has one cell describing the register of
+		interest.
+
+		If the optional property 'set-clear' is present then the node
+		describes a register set that together implement read,
+		write-1-set and write-1-clear semantics. The offset property
+		must be three cells, the first is the address of the register
+		to read from, the second the write-1-set register and the third
+		write-1-clear.
+
+mask: 		A mask whose set bits represent the bits of the field.
+label:		The name of the field
+
+Optional Properties
+-------------------
+
+read-only:	Define a read-only field (RMW/W1SC irrelevant).
+set-clear:	Define whether the field exists in a RMW or W1SC register set
+default-value:	Single cell applicable to RMW. The field will be updated to the
+		cell's value.
+default-set:	For W1SC, set all bits in the field
+default-clear:	For W1SC, clear all bits in the field
+
+Valid Uses
+----------
+
+Description:	Control bit for switching the video display DAC mux between
+		host VGA and BMC CRT mode
+Machines:	aspeed,ast2500
+Parent:		compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
+Node:
+		field@2c.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x2c>;
+			mask = <0x00030000>;
+			label = "dac-mux";
+		};
+
+Description:	Host VGA scratch registers
+Machines:	aspeed,ast2500
+Parent:		compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
+Node:
+		field@50.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x50>;
+			mask = <0xffffffff>;
+			label = "vga0";
+			read-only;
+		};
+
+		field@54.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x54>;
+			mask = <0xffffffff>;
+			label = "vga1";
+			read-only;
+		};
+
+		field@58.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x58>;
+			mask = <0xffffffff>;
+			label = "vga2";
+			read-only;
+		};
+
+		field@5c.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x5c>;
+			mask = <0xffffffff>;
+			label = "vga3";
+			read-only;
+		};
+
+		field@60.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x60>;
+			mask = <0xffffffff>;
+			label = "vga4";
+			read-only;
+		};
+
+		field@64.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x64>;
+			mask = <0xffffffff>;
+			label = "vga5";
+			read-only;
+		};
+
+		field@68.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x68>;
+			mask = <0xffffffff>;
+			label = "vga6";
+			read-only;
+		};
+
+		field@6c.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x6c>;
+			mask = <0xffffffff>;
+			label = "vga7";
+			read-only;
+		};
+
+Description:	Super I/O device scratch registers for host/BMC communication
+Machines:	aspeed,ast2500
+Parent:		compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
+		field@f0.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0 24 8>;
+			mask = <0xff000000>;
+			label = "sio-2b";
+		};
+
+		field@f0.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x00ff0000>;
+			label = "sio-2a";
+		};
+
+		field@f0.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x0000ff00>;
+			bit-shift = <8>;
+			label = "sio-29";
+		};
+
+		field@f0.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x000000ff>;
+			label = "sio-28";
+		};
+
+		field@f4.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0xff000000>;
+			label = "sio-2f";
+		};
+
+		field@f4.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x00ff0000>;
+			label = "sio-2e";
+		};
+
+		field@f4.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x0000ff00>;
+			label = "sio-2d";
+		};
+
+		field@f4.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x000000ff>;
+			label = "sio-2c";
+		};
+
+		field@f8.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0xff000000>;
+			read-only;
+			label = "sio-23";
+		};
+
+		field@f8.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x00ff0000>;
+			read-only;
+			label = "sio-22";
+		};
+
+		field@f8.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x0000ff00>;
+			read-only;
+			label = "sio-21";
+		};
+
+		field@f8.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x000000ff>;
+			read-only;
+			label = "sio-20";
+		};
+
+		field@fc.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0xff000000>;
+			read-only;
+			label = "sio-27";
+		};
+
+		field@fc.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x00ff0000>;
+			read-only;
+			label = "sio-26";
+		};
+
+		field@fc.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x0000ff00>;
+			read-only;
+			label = "sio-25";
+		};
+
+		field@fc.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x000000ff>;
+			read-only;
+			label = "sio-24";
+		};
diff --git a/MAINTAINERS b/MAINTAINERS
index 07d1576fc766..9766d7832d8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2736,6 +2736,12 @@ S:	Supported
 F:	drivers/net/bonding/
 F:	include/uapi/linux/if_bonding.h
 
+BMC MISCELLANEOUS CONTROL
+R:	Andrew Jeffery <andrew@aj.id.au>
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
+
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
-- 
2.17.1

