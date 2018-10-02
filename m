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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E316FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CDC206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZMWRC9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CDC206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJBR4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:56:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41327 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbeJBR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:56:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id q39-v6so1094304lfi.8;
        Tue, 02 Oct 2018 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIOABefwrBl7Un/NGeVmLllW3tfQ8OLYZAOyYXAzdxc=;
        b=FZMWRC9yub6JCDx/wLue1Kg9xybXY8WE/vWd8eaNhiz6QWW7XUevWHE0t4SA1ykjx7
         4Z5mzwG9XxvvWK1ryaHxPL+tevA3rp7w1NE6ZzHCaAH3mAXsI+3bVNmyS6kpaq2Jdgi9
         IyBSUaDQ7zHSVOzU6/powSXwFydZ2t2Jls+UzImENr6YagpqFq2jeNRebAdARwPfAAp9
         Af0NjA4lmsfl9XtAg5T9VbW1dSDygFUnXSavUL4Uoqapc430odaOP54bv60mTWjDmeO0
         e3o2mapnOtkgGJH5RIad3DvLpKyIxFpS/0Yz8Llqsp5S/itwJir3qWLQsl3aGilp7wZO
         uexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIOABefwrBl7Un/NGeVmLllW3tfQ8OLYZAOyYXAzdxc=;
        b=t4XD/DDUXVMbQQ48OJinAlJyz83ma+gb5nGq6rUmvbKjJYURwL6JWonYhRT8G5dk3O
         VWF9EHJtF1wEsZV8KTKF7LOWH0y0L6nYsxvDm1Fn2tc2LqL8ntX0vMw0qe7lB7amDSdG
         kWfvIBKTa2eheskZwpWoFPUuReih/UCitu5X4aoSfX7slKrAg3K4eqyYZ+4efnMebL13
         wzQ+hfCpaxvwVrzioYXtFuyIwYuZgPn+rdG8riDM6gqVcNvEkprD5DRURT8NaK+V2tlM
         KuV7L70fHyC8AdIO5g4xMuZyFuFSk72oKsTJr3Blx9Wxh/ry/utDjIX1DgM+CdMrZzYs
         zP9Q==
X-Gm-Message-State: ABuFfohlKcOx20+vqrNT92J79LXH0N7wpAZoDVQYc6WB7XnUXi4dlXdq
        iDpYaCbIurFMrTXkPU70w3o=
X-Google-Smtp-Source: ACcGV6255EazAZr6fk/Um4e6sGD+oAy/pjhhz7FtRFB21BorVCpkqzTvSEe07IlNNMs5Rf2JeoP7qQ==
X-Received: by 2002:a19:c951:: with SMTP id z78-v6mr7817498lff.150.1538478839488;
        Tue, 02 Oct 2018 04:13:59 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h27-v6sm3169023lfl.31.2018.10.02.04.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 04:13:58 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v6 2/6] [media] ad5820: DT new optional field enable-gpios
Date:   Tue,  2 Oct 2018 13:13:56 +0200
Message-Id: <20181002111356.32298-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
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
 Documentation/devicetree/bindings/media/i2c/ad5820.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
index 5940ca11c021..db596e8eb0ba 100644
--- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -8,6 +8,11 @@ Required Properties:
 
   - VANA-supply: supply of voltage for VANA pin
 
+Optional properties:
+
+   - enable-gpios : GPIO spec for the XSHUTDOWN pin. The XSHUTDOWN signal is
+active low, a high level on the pin enables the device.
+
 Example:
 
        ad5820: coil@c {
@@ -15,5 +20,6 @@ Example:
                reg = <0x0c>;
 
                VANA-supply = <&vaux4>;
+               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
        };
 
-- 
2.19.0

