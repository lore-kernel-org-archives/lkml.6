Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DDFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F18521564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="itRdRD0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F18521564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeI0HEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:04:44 -0400
Received: from onstation.org ([52.200.56.107]:47118 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeI0HEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:04:43 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id AFCCE3B0;
        Thu, 27 Sep 2018 00:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538009349;
        bh=S1wRnSpAJx1+34SFcU/8ATvsd8R3TbJy++krKmc6suE=;
        h=From:To:Cc:Subject:Date:From;
        b=itRdRD0/ENxs9GnS3KdJuoql88CCyq/b95L+UvLhSkCWGf5LEc4rEAkNdTcOxcwSV
         heAT0bbVvtYABejv/5LVyzjVvenBeLhQtzJLcxQdG/Bv/iZmZQAjeLlnu3jM13OinS
         5/ICdfn59SWtwfMkEkKP8wcPK2EEewzo5YjchEA4=
From:   Brian Masney <masneyb@onstation.org>
To:     robh@kernel.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.reichel@collabora.co.uk,
        mark.rutland@arm.com
Cc:     masneyb@onstation.org
Subject: [PATCH v2] dt-bindings: input: pwm-vibrator: correct pwms in example
Date:   Wed, 26 Sep 2018 20:48:58 -0400
Message-Id: <20180927004858.32529-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the example for the pwm-vibrator bindings, pwm8 is the direction pin,
and pwm9 is the enable pin. The pwms on the vibrator node has these two
values swapped so this patch corrects it.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- Swapped the pwms values instead of the pwm-names values since enable
  is required and direction is optional. Based on feedback from
  Rob Herring.

 Documentation/devicetree/bindings/input/pwm-vibrator.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
index 09145d18491d..88c775a3fe21 100644
--- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
+++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
@@ -58,8 +58,8 @@ Example from Motorola Droid 4:
 
 	vibrator {
 		compatible = "pwm-vibrator";
-		pwms = <&pwm8 0 1000000000 0>,
-		       <&pwm9 0 1000000000 0>;
+		pwms = <&pwm9 0 1000000000 0>,
+                       <&pwm8 0 1000000000 0>;
 		pwm-names = "enable", "direction";
 		direction-duty-cycle-ns = <1000000000>;
 	};
-- 
2.17.1

