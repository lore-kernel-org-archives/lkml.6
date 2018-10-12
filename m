Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA75C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22EC20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7TBkxod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22EC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJLPHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:07:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44358 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeJLPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:07:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id p25-v6so5497726pli.11;
        Fri, 12 Oct 2018 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xWvWgd8ZLrwsxkKDcrbrw5u0Mv4V7woGCzzE71a7X+s=;
        b=K7TBkxodYI6iWlNqF47X/gbU/rw8qh5338UV+WLupAndRBzAdzrhXObtRpnp+4WGZu
         sToGtUyDqN6zAHQ1styu+zQuLeTbTV4/IPcauX4qR5cLLzmNYgKaHvzY230wsTPMACSF
         jXIWWknqx7pqofUqBoI7+30gAwdWffD2ddLarRp+xiDCvOKKj25ofucC//6WxyXUjAUx
         xDOEyRdxd057/SJr0BNews+Zv7qs23ITi27fCN19a8jMTyEuyoPhnPzg88TQRwGc3C1V
         9qv7m6b4NV6Ja3Zp7NlI1UpoG46r9u4U1c6cEMUCjG0NPqJIMLx9pCSjtbSiCRaUJO3G
         iuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xWvWgd8ZLrwsxkKDcrbrw5u0Mv4V7woGCzzE71a7X+s=;
        b=rzrrDybFYvJoswnY2LI/pWD+pXWMnZZO50Ql8iv7ycKvuAgZ6hssg1XgikJnZ2eqRD
         dkMmVDahy2xc2LlonQbMVLtIV6xQOcMRiDNbyJ2t8eBd0bPFY8oVbFzYE4ho1pqgX21+
         eoc3aE312X+nqBwURWGbf+F5rzaPyt3oEthTmAHItvHmktDy050H5gPx1pquZe5ZvXuS
         Uow9BDcIkB9DgoprBNuaEP7qEcwRzEUZJSS8zFjnDPjmlxRlUmCTdAo7nu2BJumiJR0g
         4y2bapLkdDwYFnuxuGXxvb5Ns/j2OyrCEig0LAi22+XQSA0JLXsiNpVcTHhtHJrjTQkB
         IT9w==
X-Gm-Message-State: ABuFfoh9emYe7IJV7faPjGXBNDnrlfkjIVA6MTR7niM+6pIeAs/wwnKc
        GDFF3H2I6ouQFyMcpiSj+cA=
X-Google-Smtp-Source: ACcGV62sjDGnEYN/hET9XUFx3mRFDddovWXJXIzO+IZ2VeyFos6tG6zJOjadK1G0ksxWRpZN9bDYUw==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24-v6mr4858822plp.109.1539329785477;
        Fri, 12 Oct 2018 00:36:25 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id b29-v6sm849382pfj.183.2018.10.12.00.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 00:36:25 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v4 2/3] iio: magnetometer: Add DT support for PNI RM3100
Date:   Fri, 12 Oct 2018 15:35:35 +0800
Message-Id: <20181012073536.20339-3-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181012073536.20339-1-songqiang1304521@gmail.com>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
new file mode 100644
index 000000000000..497c932e9e39
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
@@ -0,0 +1,20 @@
+* PNI RM3100 3-axis magnetometer sensor
+
+Required properties:
+
+- compatible : should be "pni,rm3100"
+- reg : the I2C address or SPI chip select number of the sensor.
+
+Optional properties:
+
+- interrupts: data ready (DRDY) from the chip.
+  The interrupts can be triggered on level high.
+
+Example:
+
+rm3100: rm3100@20 {
+	compatible = "pni,rm3100";
+	reg = <0x20>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.17.1

