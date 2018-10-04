Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA80C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308FB21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9PRGK3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308FB21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJDTyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:54:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32796 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeJDTyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so8307717ljz.0;
        Thu, 04 Oct 2018 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mi6p39XaHpJHZl8Psk/3hUmWx8Q0ifFV62Ay17By3MI=;
        b=b9PRGK3b6u6qCq5THocpUE7EBH0SUn1Hc4xTjgPfhR6TdeSxv+5tnKh2Icj+5sQ7LA
         /Heu9YYXJ09g2k3tfcyfv+pat5tN97U4sqxFtOYXtNgNZh9I9ckhe+ov4fugtkOD0x2j
         oDEB6+IkyoIUmaCJ92ZeQphaiQ/n+a1fCsjaz9i4SFbmLMZDoHwvQav7Pgy27HWLbZTj
         pczJQGG9c9O3Gh08fKl3oTJOczK/6YMJyoTBUjk1pZzt3pBriBitCdudG9op/qs/wpVV
         Ie716RKY6iitdlV8KeoG3wDkXCATphU0OdOXBF1KKotHVOBvUAhW69962BISpSb0UTDy
         jeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mi6p39XaHpJHZl8Psk/3hUmWx8Q0ifFV62Ay17By3MI=;
        b=UJEVOUET8B4fQPQVwSYLivYQVCEtDbq8v86Zknzn3Uiq7rY+oGG26ytLOBO1ueJ81Y
         sujzbRD9UuKHBCCUdiqAAdYbGwEkcgFl5pqfUXT4cQ+dRKPTM1snFhmqWu6e8td0XLpe
         tZrRD7J+EmV0XmOTEgzRV/V7Um2HHagLd8fKuZ6L2Wgw56b06dAFigiYq6GarsIDLXYP
         9yt53DRuXA3zklgoVrAGSFv38Uyuu5jwJvpS6qTeukrQJYfwmf2SYKoSOO53MeHsXMxB
         FLkAm66CXFAseBz0Pp5ACFOVSgM53JY2e6rhp2nMs6+JRVzXmviwzIk1iqL+ucH/gZV7
         5Y6w==
X-Gm-Message-State: ABuFfoja8wybOKifa9sI8L2LDbw7gefuGA5kTZjhHkMDNJeicJa+GmcT
        bE5RVKCLHi6wGli4UKLfDOs=
X-Google-Smtp-Source: ACcGV623ANedVX89vhJ9HLENZPxY512+1oNqKT/gmpn89kzpDDtSF1m2fM6WcXy0Wmsey2FdvT5ngg==
X-Received: by 2002:a2e:3101:: with SMTP id x1-v6mr1966794ljx.83.1538658097885;
        Thu, 04 Oct 2018 06:01:37 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:36 -0700 (PDT)
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
Subject: [PATCH v6 09/10] dt-binding: mtd: Document gpio-addr-flash
Date:   Thu,  4 Oct 2018 15:01:09 +0200
Message-Id: <20181004130110.8496-9-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
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
 .../bindings/mtd/mtd,gpio-addr-flash.txt      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt
new file mode 100644
index 000000000000..304a33880f9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt
@@ -0,0 +1,25 @@
+Memory Mapped flash with some address lines addressed using GPIOs
+
+Handle the case where a flash device is mostly addressed using physical
+line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
+to a 2MiB memory range and use the GPIOs to select a particular range.
+
+ - compatible :  must be "mtd,gpio-addr-flash", "cfi-flash";
+ - reg : Address range of the mtd chip that is memory mapped, this is,
+   on the previous example 2MiB.
+ - addr-gpios: List of GPIO specifiers that will be used to address the MSBs
+   address lines. The order goes from LSB to MSB.
+
+For the rest of the properties, see mtd-physmap.txt.
+
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. Check partition.txt for more details.
+
+Example:
+
+	flash@300000 {
+		compatible = "mtd,gpio-addr-flash", "cfi-flash";
+		bank-width = <2>;
+		reg = < 0x00300000 0x00200000 >;
+		addr-gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
+	} ;
-- 
2.19.0

