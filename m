Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE5C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE61F21885
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="C+YLgFKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE61F21885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbeHGSJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:09:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60426 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403877AbeHGSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:09:55 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 50D5157;
        Tue,  7 Aug 2018 17:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533657297;
        bh=DdHYYAkFJD8Ysd5DfPf5cnIxWO1vvkrkb0u7d2VGdyo=;
        h=From:To:Cc:Subject:Date:From;
        b=C+YLgFKilyKaTf2GB2RLnm0c/Rtl1ZOqk3WFBMtVhgwWUUccOACkkmENhAnLpHpVS
         r5Ay8+AiWZUGM4ZHlDnet5n/3l8TFqL4SqAC/vo6dnOAF9ZZZTulDo4XsQTl3kk5Es
         /J6SPdBAOW8f8Oi2Nwmokyq+JKvkCLyvkz/67gpg=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH] media: dt: adv7604: Fix slave map documentation
Date:   Tue,  7 Aug 2018 16:54:52 +0100
Message-Id: <20180807155452.797-1-kieran.bingham@ideasonboard.com>
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

