Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486FCC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CE720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGvtJGD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CE720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeKHTCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:02:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46463 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeKHTCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:02:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id s9-v6so1700368pfm.13;
        Thu, 08 Nov 2018 01:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3l8WlJ94ocuKoQ1daIOR0/jVOmBkVIaeo2qryyJE/ig=;
        b=pGvtJGD7VNpkIWGo5kyafLn3p+iyBMa+C7dwUzO8HxMBFL1h6b3EaBK71Y2eUzn3qo
         4ZMRJBuG6zyp+ky0CgWz2m/Q4VGl+YjazYj8psuirNn9r/ui/ZftN6DuVFCZ2L2GYAYh
         Z3zsySkAEIfOFOu3Rp8jbr1VHzLsM4FVlGgqTuKxmV3UFSxHUPJynCTcApsfdlGyMyIM
         JkEembM2NpgL1oVC2FB3mMMEX7/yJ6iFwTLs1bXleCBMBQd2/rCd+MseIQ2/pXuqQDxF
         4rZA3b6ruY8GuugDyrc+Om98dgMi571cuYjUmcyzDLb7KA6DkLOJyPkn2Daot2L7cCJS
         zW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3l8WlJ94ocuKoQ1daIOR0/jVOmBkVIaeo2qryyJE/ig=;
        b=PVae5lw+wOSnH8oxTjgRoE7ay+A/9EDGpxcIzu+On1XokTxv/M7nLkEIWc9Di7l3Jq
         qfIexkR2hV5c2BPf3Od3Iy8gSIfnHAZLnxofWgbbFfldrLHtB5aTMcAzXw1blW/qnC7/
         O9ow858rp05qFYPlmtebEkGsEyBGoSSUy5+IGWmR66D8MGrp3GFo8RqZ8KECAUhL1EnE
         HG4fjB8h2k0fGokLpiApmEPGubLilcYQM27ZIv5FDBJcfzavW9KkpJHWaFaPtoUvf1ii
         k2Z1JpEzGRrY6m9PhiGJ17FY8ZmxgJReLu8vCqO4GBgU5elhFCcgTVVbH11ZZrvqeVbN
         jdLQ==
X-Gm-Message-State: AGRZ1gLJaUrBlSfHSMQwqqvMw5L9ctPg6Do6VOxhNAu4oKx4b18YJjKq
        BUjmQoBgMpVrwQsVl0NkiK0=
X-Google-Smtp-Source: AJdET5e6EXoK7YuykGLUPSSeC1/ETVVZWFx9B2tnXdkn3fwnnltzdEjncoLR4yHRWHVsg+Wu4rsC1g==
X-Received: by 2002:aa7:8719:: with SMTP id b25-v6mr3768066pfo.250.1541669296869;
        Thu, 08 Nov 2018 01:28:16 -0800 (PST)
Received: from localhost (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id m17-v6sm3411733pfi.102.2018.11.08.01.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 01:28:15 -0800 (PST)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v6 2/3] iio: magnetometer: Add DT support for PNI RM3100
Date:   Thu,  8 Nov 2018 17:27:48 +0800
Message-Id: <20181108092749.12167-3-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181108092749.12167-1-songqiang1304521@gmail.com>
References: <20181108092749.12167-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

