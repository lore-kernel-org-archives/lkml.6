Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6912150F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQYU3awB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6912150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbeIVCOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:14:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36324 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVCOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:14:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id j192-v6so4563063wmj.1;
        Fri, 21 Sep 2018 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+Q4nbAPG+AKCx3ox3Duk67TzkMct+wKOkbghER5E/E=;
        b=JQYU3awBHfoGUdA06KPbHY4yWwqyGcNDYIf6XmGcd/LGMm0v1UXvLLBWf77DKgVWxj
         5bJHF3pSnvLp6AKZzT1GpluRkuDADB2O9sshBiiX0hs/9RZW5vKXlfLCVsX5J7cVGJoK
         nVrorLKMpZfjq7XbbIoW9JFEf9CJ3BnbYV2ElPL39pRDxCFqoeq7KHiBBKuilg2AQV8w
         uOGuzfn/GlMIxikpFL99ffO6lHEmOVWVwMmn4jJLMtSUzTkslZWpxsV0yTd96i8VrVh7
         mHc+oirFALDNVlb5wO/WgkpVXOgTDwN6sg27QC1sXmlAhrjIxCxtkrtDFwu95i7qQdzB
         lFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+Q4nbAPG+AKCx3ox3Duk67TzkMct+wKOkbghER5E/E=;
        b=oqLwS8DbYt9AcP6I6yAM+gMMFoxL1WOSgVywg87jHhpocNz41LUUnixc96SeOOkWZZ
         n1m2mfIZ8Fg0uWgfw41kCmKbdcj58FNSVyXvjxaKqIGqyxtREan8rs4FdQ2Jaw20BbL+
         6lbFHbinDUB/w9CjZezL70Tj/ComqvT8o793Jkb7MR6l4LsM2u/i833s76RX4uBqIScd
         oQc1KUhSqfnAS/GxSkYCpwVBH6gtEjNYj5t7IspK9Cx1wLpKqasYdpMPNKalSX9Y9LkS
         jYiL0JujDXH3IsBoNzpOpDbDEjuA5jSFiWxSlLt2gNFvfDXW2D8OHOiCErMNoksR2rzL
         PQOA==
X-Gm-Message-State: ABuFfogj04Jz28QHZxTNHIKBQ8siTXwj8a5Hmz1L+8c771YXY+1XF53t
        jBN8XdYsTvOZzB+iY/s2kzg=
X-Google-Smtp-Source: ANB0VdaTKVyEeHiyQvzzY2t5n29DFGvwNK+e2vMwX+72UYcgL3jBnnbcQjb7tVUQMVUjZovN2FpUjA==
X-Received: by 2002:a1c:545d:: with SMTP id p29-v6mr8426260wmi.94.1537561425218;
        Fri, 21 Sep 2018 13:23:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e7-v6sm7141076wrs.25.2018.09.21.13.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:23:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] backlight: lm3639: Unconditionally call led_classdev_unregister
Date:   Fri, 21 Sep 2018 13:21:31 -0700
Message-Id: <20180921202130.12480-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
'pchip->cdev_torch' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (&pchip->cdev_torch)
        ~~   ~~~~~~~^~~~~~~~~~
drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
'pchip->cdev_flash' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (&pchip->cdev_flash)
        ~~   ~~~~~~~^~~~~~~~~~
2 warnings generated.

These statements have been present since 2012, introduced by
commit 0f59858d5119 ("backlight: add new lm3639 backlight
driver"). Given that they have been called unconditionally since
then presumably without any issues, removing the always true if
statements to fix the warnings without any real world changes.

Link: https://github.com/ClangBuiltLinux/linux/issues/119
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Alternatively, it's possible the address wasn't supposed to be taken or
the dev in these structs should be checked instead. I don't have this
hardware to make that call so I would appreciate some review and
opinions on what was intended here.

Thanks!

 drivers/video/backlight/lm3639_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index cd50df5807ea..086611c7bc03 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -400,10 +400,8 @@ static int lm3639_remove(struct i2c_client *client)
 
 	regmap_write(pchip->regmap, REG_ENABLE, 0x00);
 
-	if (&pchip->cdev_torch)
-		led_classdev_unregister(&pchip->cdev_torch);
-	if (&pchip->cdev_flash)
-		led_classdev_unregister(&pchip->cdev_flash);
+	led_classdev_unregister(&pchip->cdev_torch);
+	led_classdev_unregister(&pchip->cdev_flash);
 	if (pchip->bled)
 		device_remove_file(&(pchip->bled->dev), &dev_attr_bled_mode);
 	return 0;
-- 
2.19.0

