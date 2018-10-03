Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F7FC65BAC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A86B21479
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSWWASSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A86B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJDC3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:29:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42675 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDC3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:29:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id n2-v6so6415265edo.9;
        Wed, 03 Oct 2018 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUdiv3GxcKIGRchs0tikWhabjt2xJ5EVou+ayt6rXzE=;
        b=qSWWASSedwNTvf4cXruRNmwqRV5s9Pos2P66j+SdUqiqAjtfA0OWX9/tzuCumUDe0w
         ro03gJzfo3bAAdhBt2d9OaI6AX3eMl9lRbHr73oWwRDV2JE1M/q5ymohBIromZFuGkm5
         CAYLo/rA0usRaBrn/3Nm9Ecgv6CCv3TIjjiKkPtfZ3xDAnnJ5WOX52Xw3sNC08eOmSEW
         NNKOcVRfVu09Tr7tuRmNtFNyxw4qS1DI0cIpZMdgAwFXUP20nIRYpMCO2W+fhWoBsIld
         HV5JDJH6JehWdTz7SOt48ok9ETZRx1IOoVO7sgdaaZg6vDLEt/N9Lmr7bzaKmbbBE5/1
         z+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUdiv3GxcKIGRchs0tikWhabjt2xJ5EVou+ayt6rXzE=;
        b=RwRHQCReM7s1UUvvvcKWDyUBfe9u8QSI9inn3EMrs1Jpgsn0y0yyb1hbX0pljUX435
         Ny9kJkcXIMHA1Kv/8TL5relkXMjHf64lCG7wwHYFRr6jdFLy9Ct0eVqjg/fMBjQZ0JYr
         PonSDoaEJ23x+mZN/W0ELfrbZPqUe9xucF+PiZ3iQkLkaHJkBNLsScztJrsaydfgW8Tl
         ejcn+u239REUlwyf1JJByqv5h3H/HwzRh2rUmcHoxZLT5wNWtRlEMZwUc9qcz2CzYEHD
         yjMtwKB9lHk0uNcJZKYLzDRZjU6R0ABHrgMkje9dDtRoE+Nfp08hRT4v4AOsiDDfeMZY
         CqpQ==
X-Gm-Message-State: ABuFfoi33jvwBz+hxMXZb4j0XadR2azcVWJqiRolLn2MD26V6OBJ5IlK
        HxTWVOZ+Pmc5LhJItA3FKr8=
X-Google-Smtp-Source: ACcGV6125Uz8ifFRRuu+yBVLw3QDZH8ZrmLMErmL1j9qxy14pBPquBD4vc8gcsNixbGxPLK7iSylpQ==
X-Received: by 2002:a17:906:b01:: with SMTP id u1-v6mr3428970ejg.124.1538595553273;
        Wed, 03 Oct 2018 12:39:13 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b49-v6sm765263eda.70.2018.10.03.12.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:39:11 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 7/8] dt-binding: mtd: Document gpio-addr-flash
Date:   Wed,  3 Oct 2018 21:38:58 +0200
Message-Id: <20181003193859.23928-7-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for gpio-addr-flash. This binding allow creating
flash devices that are paged using GPIOs.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 .../bindings/mtd/gpio-addr-flash.txt          | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
new file mode 100644
index 000000000000..5006a26e1753
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
@@ -0,0 +1,54 @@
+Memory Mapped flash with some address lines addressed using GPIOs
+
+Handle the case where a flash device is mostly addressed using physical
+line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
+to a 2MiB memory range and use the GPIOs to select a particular range.
+
+ - compatible : "cfi-gpio-addr-flash"
+ - reg : Address range of the mtd chip that is memory mapped, this is,
+   on the previous example 2MiB.
+ - bank-width : Width (in bytes) of the bank.  Equal to the
+   device width times the number of interleaved chips.
+ - gpios: List of GPIO specifiers that will be used to address the MSBs address
+   lines. The order goes from LSB to MSB.
+ - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
+   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
+ - #address-cells, #size-cells : Must be present if the device has
+   sub-nodes representing partitions (see below).  In this case
+   both #address-cells and #size-cells must be equal to 1.
+
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. Check partition.txt for more details.
+
+Example:
+
+	flash@300000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-gpio-addr-flash";
+		bank-width = <2>;
+		reg = < 0x00300000 0x00200000 >;
+		gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = < 0x0 0x200000 >;
+				label = "Golden Bitstream";
+			};
+			partition@200000 {
+				reg = < 0x200000 0x200000 >;
+				label = "User Bitstream";
+			};
+			partition@400000 {
+				reg = < 0x400000 0x200000 >;
+				label = "V4L Controls";
+			};
+			partition@600000 {
+				reg = < 0x600000 0x200000 >;
+				label = "Production Data";
+			};
+		}
+	} ;
-- 
2.19.0

