Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FF5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6ED219F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="II/lP8OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6ED219F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeHHSyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:54:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33370 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:54:25 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48539CE;
        Wed,  8 Aug 2018 18:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533746035;
        bh=9s1IoCs3+0QeZiHLRD+5rkRxuAsjtjoIymI/CY/JVLM=;
        h=From:To:Cc:Subject:Date:From;
        b=II/lP8OKkXk55ZCup9tAogcPkbVdornzZy7vVAiMzMRYMakOKj/8JNuNhIMwfymLq
         1f5aTNqJBgo98/Mm3rBa6+Vr5nM2Nl06YX5ESyapTx5XEchV84fx4ZX2s+bR6QDHXp
         xD7VL4TWZav1wm5/2kBDb0DKHPDLc4Fg9+7DdMVc=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     mchehab@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v2] dt-bindings: media: adv7604: Fix slave map documentation
Date:   Wed,  8 Aug 2018 17:33:51 +0100
Message-Id: <20180808163351.28852-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reg-names property in the documentation is missing an '='. Add it.

Fixes: 9feb786876c7 ("media: dt-bindings: media: adv7604: Extend
bindings to allow specifying slave map addresses")

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

---
v2:
 - Commit title changed to prefix as "dt-bindings: media:"

If this is collected through a DT tree, I assume therefore this will be
fine, but if it is to go through the media-tree, please update as
necessaary to prevent the redundant dual "media:" tagging.

(I'll leave it to the maintainers to decide whose tree thise should go
through)

Thanks

Kieran

 Documentation/devicetree/bindings/media/i2c/adv7604.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
index dcf57e7c60eb..b3e688b77a38 100644
--- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
+++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
@@ -66,7 +66,7 @@ Example:
 		 * other maps will retain their default addresses.
 		 */
 		reg = <0x4c>, <0x66>;
-		reg-names "main", "edid";
+		reg-names = "main", "edid";
 
 		reset-gpios = <&ioexp 0 GPIO_ACTIVE_LOW>;
 		hpd-gpios = <&ioexp 2 GPIO_ACTIVE_HIGH>;
-- 
2.17.1

