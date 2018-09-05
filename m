Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7277C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FE42077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKdIkvbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FE42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeIETHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:07:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43300 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:07:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id z27-v6so6265589edb.10;
        Wed, 05 Sep 2018 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AOR9vNktlirgYv7sLEsBOdMyfPrKcafubPqxJiu/WPM=;
        b=vKdIkvbtiCw39V0ZrhkrgV3AAG6dp9Zu3v26I8By17nZtjVi1pNG2vzA9YWw80ybPs
         j5kC8qwSHx+wRbbwWmqqBUXf+z4Enstxb8d9QjPRkhaY0jkvR9rXpnQhC01uo4rlUtnm
         VMuHbGDOylbHJndvennFKx8BFLh7Dek7FkP0EW8mz4AQgsdEcYtSxD7TYQLT45Diir8F
         v0mYj0x3IG3K8Gr++DT43UNe7uO/rWg5UAm7zBPkHhMwxzY9YJtqUwkXRu59TtyZouEu
         cun7zx5HDaHyOmdWWj2//7+gyAmAg9+36WeFJ6pioKMO2Bu3eWmVPHz2fNue1phBJ+M0
         TDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AOR9vNktlirgYv7sLEsBOdMyfPrKcafubPqxJiu/WPM=;
        b=i85RKl1M+Eb86qsPd1ankt600YoI74wlFfiiZdk+GGnBrt1BWeCVU81cNB7kSn3aUx
         8BaeytMsAcPzzkUSvJ3bTG4M7JwawgrpN0lf3ldxpEJ8654wChsyHNC06Q9Xgg2YMS+C
         rfjcartLKetPNFj+TpqR8xtY5JIK+zYkUhdtk6yJHqUjlIQ34nh4PspfSgTvo0g1GvbO
         j2eiTunOKR4E6KA4fBbu1I5LJdchtNAztl4FxHlWbM/5VECo7CqYf7Y7jBoONIik+b7D
         vcD23Ru0UDEpX2d5og0Ty7FU203NeYDtD4PlpoquyXZoOuzxH7s2lF9TxxFu0W6pV/H2
         7jTw==
X-Gm-Message-State: APzg51Bk6gmykoJp081IcZrGCu++F8ACeP63+Nk1/Ak//a1CdPPjuxjT
        7fYU99NMdxmDfWHLiLu9Efo=
X-Google-Smtp-Source: ANB0Vdarsw8TMTClokd97V9MAeiFNhIcxMjjidHCYlGtHK2Lrv6s6Qq4Qk3ufRMc5DMcqmDGUEk0JQ==
X-Received: by 2002:a50:afc4:: with SMTP id h62-v6mr42105605edd.251.1536158225655;
        Wed, 05 Sep 2018 07:37:05 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u53-v6sm1556413edm.51.2018.09.05.07.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:37:04 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 8/8] dt-binding: mtd: Document gpio-addr-flash
Date:   Wed,  5 Sep 2018 16:36:43 +0200
Message-Id: <20180905143643.9871-9-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for gpio-addr-flash. This binding allow creating
flash devices that are paged using GPIOs.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 .../bindings/mtd/gpio-addr-flash.txt          | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
new file mode 100644
index 000000000000..4279e8cad09b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
@@ -0,0 +1,46 @@
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
+ - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
+   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
+ - #address-cells, #size-cells : Must be present if the device has
+   sub-nodes representing partitions (see below).  In this case
+   both #address-cells and #size-cells must be equal to 1.
+
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. See partition.txt for more detail.
+
+Example:
+
+	cfi_flash_0: cfi_flash {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-gpio-addr-flash";
+		bank-width = <2>;
+		reg = < 0x00300000 0x00200000 >;
+		gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
+		partition@0 {
+			reg = < 0x0 0x200000 >;
+			label = "Golden Bitstream";
+		};
+		partition@200000 {
+			reg = < 0x200000 0x200000 >;
+			label = "User Bitstream";
+		};
+		partition@400000 {
+			reg = < 0x400000 0x200000 >;
+			label = "V4L Controls";
+		};
+		partition@600000 {
+			reg = < 0x600000 0x200000 >;
+			label = "Production Data";
+		};
+	} ;
-- 
2.18.0

