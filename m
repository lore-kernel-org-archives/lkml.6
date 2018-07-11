Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A598AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4253C208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ERBph8zs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNm3DGzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4253C208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeGKFes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:34:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43725 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbeGKFer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:34:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C00F20D92;
        Wed, 11 Jul 2018 01:32:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 11 Jul 2018 01:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AeCSgpmZAZV0bxftl
        oqPwF4I+ucmVudVtqffe6ul/Cg=; b=ERBph8zsaNlrgSypbbmu01G9yK2ByP/BJ
        R4Bi3lp2oEIcInH3xiweGsP9x8PKg7PzfSlLigqpcywL2hhed8dvm8YIZ9TuHwI6
        InUB9Nqq2Wx5HnsiwEd6CknCbTPI7NNuNnFgg8b0c94DMoeJYZVHRRa6Na8XmERP
        UvfISv144fUz03tTGtJBRWnuU5V37gZfdvJAEIixXWJbXgiRitqJoX2aRRxmv1P2
        u9/0czNwQl3IrxF+eRGYyRAElu/F98eDZggI7tNHXEX5FoUXVFlM0Og/ppqitr5X
        9srFTRXvJWsMBv+8pYSa7lzz2Yc0Luka+2mWMMsGTGnRU/E2CHBwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=AeCSgpmZAZV0bxftloqPwF4I+ucmVudVtqffe6ul/Cg=; b=pNm3DGzK
        /r7YfqfA9eDBjXTS7HsM9npOkryurqVB5hsBpXt9jLqwaKblNLslLJmnleCWap3x
        D8nqJZy93TjyOddxUuFA6N8vPahNuDVdWhS7jTvfbpW6d9z9tVv/Y85oYvZTiIAR
        9sOMmcZnURIJ8hcRWkzrKYbcwJwFqzCHMHEwYZz2DtoAIBranpJ8hheWebykfquE
        rWH+vbKoAAgem3QM5vTM5h7y1Rja3O0Mijp7v9ClFc8gskFaYWGgbI05/leXzBtI
        rgvRNAO0qQxrcQHwVZYInd5XGG9cwfVZSn88svU/Oe2Gj88MPPsMHdUxwYYoR6mr
        0dyXXIJfYDvRVw==
X-ME-Proxy: <xmx:X5ZFW1L-gyJddQfaEbpcOloXJcxWc98F-dwBLfzJMyOnXdZldHfuhw>
    <xmx:X5ZFW0raCj-Ydsh3fIea_LAxpo1aw894mcAqFgGKh8fLybbDKziX2w>
    <xmx:X5ZFW2MUB8ZaiNk_9nxQVTfUeLiJYXywjf65MYZjBg4FTSaAzO46LA>
    <xmx:X5ZFW5M8kyD3Z9wmcPEsP-YatQlLI_LhMeNOzHH6fLSuQVjH1ElDug>
    <xmx:X5ZFWw3Q8Xot3wHkpVMwGKPiUFFdJIj2wp78F5N4zFz5USyioYADFw>
    <xmx:YJZFW08RjH1P31-htwXZi32LiWgMiBjXyipwbaPxeIVCDzIr1Tlz2w>
X-ME-Sender: <xms:X5ZFW1LZVrYkLS-fg2rfpdhe64TesO8gtaluLA6TilijCRTUU70xjA>
Received: from localhost.localdomain (ppp118-210-173-37.bras2.adl6.internode.on.net [118.210.173.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id 337FEE45C9;
        Wed, 11 Jul 2018 01:32:10 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC control fields
Date:   Wed, 11 Jul 2018 15:01:19 +0930
Message-Id: <20180711053122.30773-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711053122.30773-1-andrew@aj.id.au>
References: <20180711053122.30773-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
provide remote management of (primarily) server platforms. BMCs are
often tightly coupled to the platform in terms of behaviour and provide
many hardware features integral to booting and running the host system.

Some of these hardware features are simple, for example scratch
registers provided by the BMC that are exposed to both the host and the
BMC. In other cases there's a single bit switch to enable or disable
some of the provided functionality.

The documentation defines bindings for fields in registers that do not
integrate well into other driver models yet must be described to allow
the BMC kernel to assume control of these features.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

Since RFC v1:

* Add a commit message
* Minor changes to documented labels

 .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
new file mode 100644
index 000000000000..2c869fcc7ef2
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
+			label = "sio2b";
+		};
+
+		field@f0.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x00ff0000>;
+			label = "sio2a";
+		};
+
+		field@f0.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x0000ff00>;
+			bit-shift = <8>;
+			label = "sio29";
+		};
+
+		field@f0.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x000000ff>;
+			label = "sio28";
+		};
+
+		field@f4.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0xff000000>;
+			label = "sio2f";
+		};
+
+		field@f4.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x00ff0000>;
+			label = "sio2e";
+		};
+
+		field@f4.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x0000ff00>;
+			label = "sio2d";
+		};
+
+		field@f4.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x000000ff>;
+			label = "sio2c";
+		};
+
+		field@f8.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0xff000000>;
+			read-only;
+			label = "sio23";
+		};
+
+		field@f8.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x00ff0000>;
+			read-only;
+			label = "sio22";
+		};
+
+		field@f8.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x0000ff00>;
+			read-only;
+			label = "sio21";
+		};
+
+		field@f8.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x000000ff>;
+			read-only;
+			label = "sio20";
+		};
+
+		field@fc.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0xff000000>;
+			read-only;
+			label = "sio27";
+		};
+
+		field@fc.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x00ff0000>;
+			read-only;
+			label = "sio26";
+		};
+
+		field@fc.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x0000ff00>;
+			read-only;
+			label = "sio25";
+		};
+
+		field@fc.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x000000ff>;
+			read-only;
+			label = "sio24";
+		};
diff --git a/MAINTAINERS b/MAINTAINERS
index 07d1576fc766..fa2033a522f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2736,6 +2736,12 @@ S:	Supported
 F:	drivers/net/bonding/
 F:	include/uapi/linux/if_bonding.h
 
+BMC MISCELLANEOUS CONTROL FIELDS
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

