Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F61F213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw05BhBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F61F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeJBOOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:14:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37875 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeJBOOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:14:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so672441lfa.4;
        Tue, 02 Oct 2018 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1KVNU/m5av04sKKnX9txI783M6jxzvuy+56bxkZ9iJY=;
        b=nw05BhBwAvIB9lcsnufHpO4W3tpitx0zta6GVyrhDsVRV/UDC036iWhxHRwyFL/t5V
         TwdTixR0hjG/bZsva42Ct1yvmW1hqQTBSZPaSEki4tLHYSf2BjU3SdyX6JlOq42/iAzC
         cE2nwighP335jOyEKc/YlRi9lhiAphhcY2oOnjG7lmZ023zhR4uJtkSiGvoGV8od5mWb
         vM4FAbfD9RfMr78T64/dnYkQIw0H08ytQ15YPVOfaN0ORyGL5f4wdukS+OLsXvDQXAQx
         dyWhxLrJ/idg8eU03s9DsshdJSNPNfqhHOJ2k5T3HT7QWhgj9q/NQef/putFPhoHDgRA
         EwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1KVNU/m5av04sKKnX9txI783M6jxzvuy+56bxkZ9iJY=;
        b=JI2UBgtlBztzZcP+i+knOftk+KCA+BN0WsZaYthSDVvpeloroqKp5mmnMNjplLJAXY
         JbGK/D/+F2OVY6whQUuXnQAYX47y6rkvbivftgXSo5FiCWtiRkat0jTGqr2H3MIEZ1jZ
         Y9zvfVCNmsCw2AnB112O39ryKkjACyYDpZXEGb2nfm809wuPmH/ZahxFvHZPe8TR4Y4C
         Nriiy3r12R8utA3fGCA8xhrJylnGCfuQ5z07+ak1Mydu5a4rVXwOxDZz2yJM6BKaWMX3
         YgF8E8JFiBWKF4R4pYxGUEcUcvEGvCtCwNK8/cQX6edHYngReDr4rptCOllh2efBIn5p
         zDOw==
X-Gm-Message-State: ABuFfojhi9/sIdyZXWyJlDMpGP5ug2vg/acJhBSex33jlc14cLnjqLWx
        qZaXYCg1zy5QsZkYBrncvfI=
X-Google-Smtp-Source: ACcGV61L+2Pwuwj+h3gnyUfQ+dSznS52WxJuUcUKxirkyyqvi7KZ0aDWj+h0IyKxQrrEc/AH0zwGlw==
X-Received: by 2002:a19:5311:: with SMTP id h17-v6mr7365392lfb.24.1538465546756;
        Tue, 02 Oct 2018 00:32:26 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id d17-v6sm1242246lfj.9.2018.10.02.00.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:32:25 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/6] [media] ad5820: DT new optional field enable-gpios
Date:   Tue,  2 Oct 2018 09:32:18 +0200
Message-Id: <20181002073222.11368-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
References: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new enable-gpio field. It can be used to disable the part
without turning down its regulator.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
index 5940ca11c021..9ccd96d3d5f0 100644
--- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -8,6 +8,12 @@ Required Properties:
 
   - VANA-supply: supply of voltage for VANA pin
 
+Optional properties:
+
+   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that the polarity of
+the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable
+GPIO deasserts the XSHUTDOWN signal and vice versa).
+
 Example:
 
        ad5820: coil@c {
@@ -15,5 +21,6 @@ Example:
                reg = <0x0c>;
 
                VANA-supply = <&vaux4>;
+               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
        };
 
-- 
2.19.0

