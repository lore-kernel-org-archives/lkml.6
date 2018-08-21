Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D217C43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3A820E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUU4T0jO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3A820E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeHURwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34459 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeHURwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so10788436eds.1;
        Tue, 21 Aug 2018 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AOR9vNktlirgYv7sLEsBOdMyfPrKcafubPqxJiu/WPM=;
        b=NUU4T0jOagyIeSDtGs1gVOu9zuA0NTvqHQP7Du8wbpHhWhD0HEuQciaDtuSMAf6AcF
         95q/yYLEw8UwjhgH7y0pWi9lIwersCKu9Mu1eUOwu1vWPvDV4Lq/b3TyqrL9eQP39w/2
         KNxBS02gmpTh19LunIMZUtdWSwjUrgamG32eizXgBT0hZq3zS/+0jIMU4jSHxnniyG3U
         +9GgRNP/gc3L4O65fMu8yUCqD8cBi/yaXu6CHYE8/ITTZpYBOmQ3t08BpzSm5K05PLM/
         FqJXJtMukr4QV36VGgvKn1iVnCjAO00NaD0mYKwtsIs73vBN/oSnWzbhEYqY74pjlAWY
         RPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AOR9vNktlirgYv7sLEsBOdMyfPrKcafubPqxJiu/WPM=;
        b=qFQzMspd6rWlUkncVpAM0wfblwsGtkHoTfE2BpUnCkp5gl336AVY1AvLZq8A+IAWxX
         KFnZNQYbGUG9no6O6a5iNBL9RyRvAbJh6iDPefxlK6dNdIZ7hEVdtL8aMggGGtW7qXIh
         QfeylDgC6QVvjiyIKVKvn/+WxucUKUIdugo+zROJo0zFHiB6Xgvn/im0VMcM9aByJqGN
         iFENnGZZBS3mDFy4z8DHuYsBFK+L9A94AsbyjYmN9MKfXktB1zF1T1YC6RPlDm/lIzyG
         ZVKfzl4r3fAWEAzNO3rDP2QyYcetK85tnULMOPafTyH1yhERU0Qhl6EQLarTysyxwRak
         Op5w==
X-Gm-Message-State: AOUpUlEQ2bjb93tJuKrBRmHAxjZu9amZ4BZSkmWgZ4bsIeLJLy3wuw1W
        zJ4j1y3TuWtdhtjcvdDe9I0=
X-Google-Smtp-Source: AA+uWPzxh8JZCmPa8MhAjU7janiQJPmo/tvSsouHNdRnczx7k3qnBXZvfZY3qugqO5V1qEXUzHaHpQ==
X-Received: by 2002:a50:89d3:: with SMTP id h19-v6mr61377817edh.140.1534861936211;
        Tue, 21 Aug 2018 07:32:16 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:32:14 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 8/8] dt-binding: mtd: Document gpio-addr-flash
Date:   Tue, 21 Aug 2018 16:31:52 +0200
Message-Id: <20180821143152.32293-9-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
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

