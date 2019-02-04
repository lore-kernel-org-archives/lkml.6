Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AD0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438CB20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQL8BZo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfBDPgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:04 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:55388 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBDPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:04 -0500
Received: by mail-wm1-f48.google.com with SMTP id y139so295514wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 07:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkT0CcH/USPbOVsb8fwGUe2c7Huu9wmfBqvMYcCn5fM=;
        b=mQL8BZo2cBc6KN2NiD4/wq13lUm/uh8m+hK6bYgtpmV0uV1HcZBu60Tep2CzJZxCUy
         TYzaq1HTVLCABIZI9oYzmtm6oDBYc2uyRChPODaoJKRaDUi0vzCl2cubS771yVBXgtI0
         0hGqp+mz9Y2rk5DMpGmTVkFE2KNkM+40/YUrmOP3da3KK+OQn4B6ydxJscGWQ1oYyt0A
         K84jBW0BCwpO1dkD8+jxMQSNyiZPLJ0TtCVMpPdOeidBmwIm0vEeCa7A6avK8krR9wFe
         xKvK4aElY1Pmm4NqptNCWo5Om1ZpLfo7XitGfyU1v9OP+wNxeEruGZ5ZaXjiDrV5SssV
         7BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkT0CcH/USPbOVsb8fwGUe2c7Huu9wmfBqvMYcCn5fM=;
        b=sO846HLZYua+BlE7JmXPaVeheODhjFBMSXbq2daARO0elvgSSxHJtUbj9OHXVxWkqb
         2fhHVQkkLpbRwdJ2SsaiTiAu3bA5BWM2mgxdeF3jSRjoiHKCVJIWgCYONBni/0RWGh3R
         Ruvc7zfNVR/FdjkqLb1j3rjmmgZImGGOF5dn0gA6h8unWtxgAe0/krCQTdNrma7dpo9i
         abOKvwx6FznYsfBSrJj/yVdH/BIc3ZIf4Xxnw+yoRuu0ezbNGsQ6fj1UHrWeobnE5zSm
         fXZiDeq2XyBPtptqkWTgw+aDeaqvhKAhh1OcKdipWVE0+vxXjgBI7Xg8wdbjPbMUuSJD
         td8w==
X-Gm-Message-State: AHQUAuYew0lz4grxDWsxldpm51mwcFynWTCpl/7m676x/CRP+J79qIIU
        qbUVrPW5TZIYihL0jmZBRyI=
X-Google-Smtp-Source: AHgI3IalmIVxYobHYv8LezCfrueBoS0bssH3vIWp3lEwiRD1bXwISQmG1EVRx5kV/pA0ifWg5GSnsQ==
X-Received: by 2002:a1c:2088:: with SMTP id g130mr13691148wmg.122.1549294562421;
        Mon, 04 Feb 2019 07:36:02 -0800 (PST)
Received: from localhost.localdomain (genymobile-2-6-86.fib.nerim.net. [213.215.6.86])
        by smtp.gmail.com with ESMTPSA id a4sm1100675wrt.37.2019.02.04.07.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 07:36:01 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Adrien Charruel <adrien.charruel@devialet.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] ASoC: ak4118: fix missing header
Date:   Mon,  4 Feb 2019 16:35:38 +0100
Message-Id: <20190204153538.26166-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver use the gpio consumer interface.
Add the header as it's needed.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---

This has been triggered by Kbuild-all for information:
https://lists.01.org/pipermail/kbuild-all/2019-February/057379.html

 sound/soc/codecs/ak4118.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak4118.c b/sound/soc/codecs/ak4118.c
index 238ab29f2bf4..ce419e8cf890 100644
--- a/sound/soc/codecs/ak4118.c
+++ b/sound/soc/codecs/ak4118.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-- 
2.19.1

