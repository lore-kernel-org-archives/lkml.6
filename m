Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C962C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B66E21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IRBoYPkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437880AbfBNR6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:58:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53190 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437813AbfBNR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:58:03 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so17201031itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fGCGdqm3RAepP74+LvCBxZoDYBWuJpR+3MyMVFFDokE=;
        b=IRBoYPkzSdiQztYw6MxHVNC+x9VpkbxkNWUNyAFXuG8qenf4Juxpr1qN9jqg8Tkipv
         tFD9NubGpVq1Kgk+i/1fqwEj2YS9MDV5Coi0h0HZgxmrnMIwhzH07qx7+Yuk0L+VtaCA
         ist8UFHCcmjiS9Yk1DPG7nIjmr3Yr6sJaY5ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fGCGdqm3RAepP74+LvCBxZoDYBWuJpR+3MyMVFFDokE=;
        b=AqDxU/mGF60hvW0dpwyEXrbVKJnH6kSuy8m/ewJgokMlnWVyxviFcpdNNMQ8S+dFYG
         xazJyPJIGWMuSijdzUWbMk7okzGQxREkAX4d+/tonKWP5uL2xK0x4HYXKYKoA1eJ5Sdm
         sOQ2VoY3ay9WwR/oIjwkV+dhFo3+p7AYPXKS5SszOFnhlwrYpmNgShoglIUmWAff3ggA
         tLDdiObJMk1BtGfTCWVbzHgfgMxn0ubWoxYi0jkgf6jUmyVkalLPrwlgug8m4GWtMbNI
         JvaTxWY722bml0aUqHXeiVITWgIFzoF8l7y5dmWRnTA+R7PiQ1SBv4PVuVJMyvP9OSlE
         AH+w==
X-Gm-Message-State: AHQUAuZZIn5/Hs0VLSxu8AbEnGrIvfUH6GjiXY0hOeZ7FSx0fSMP54W/
        TvYastkcI4Vj7L+g+y0MKKdVRw==
X-Google-Smtp-Source: AHgI3IZdkA++LNv7Ts5SFqk3VxLEQJTkpqqhr7pwHg3I8pWazyHPFkUL6jF4SzUfI6ttFbpGZHEdBA==
X-Received: by 2002:a6b:b644:: with SMTP id g65mr2927148iof.198.1550167082407;
        Thu, 14 Feb 2019 09:58:02 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:58:01 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
Date:   Thu, 14 Feb 2019 09:57:23 -0800
Message-Id: <20190214175725.60462-7-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Update iProc I2C binding document to add new compatible string
"brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
also added that allows configuration of the host view into the APE's
address for "brcm,iproc-nic-i2c"

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 7a32bf81bfa9..d12cc33cca6c 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -3,7 +3,7 @@ Broadcom iProc I2C controller
 Required properties:
 
 - compatible:
-    Must be "brcm,iproc-i2c"
+    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
 
 - reg:
     Define the base and range of the I/O address space that contain the iProc
@@ -26,6 +26,10 @@ Optional properties:
     case, this property should be left unspecified, and driver will fall back
     to polling mode
 
+- brcm,ape-hsls-addr-mask:
+    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
+    'APE' co-processor. Value must be unsigned, 32-bit
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1

