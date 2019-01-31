Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7370DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CE9218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOYEcUED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfAaT0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36040 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbfAaT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:38 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so3246828lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esfscYUeOA4mcBlrHfkn6mmYHWVM1Ba5XHxoxLz9cXY=;
        b=nOYEcUEDsBzd0VAIi/WWKa3NvieTVmzaXwL/02fJiSlzvq9V6Vr3XwHT0ZPG+3OmPV
         uppPSvPq8Ozah7lOIHlFWhm6gPHnSlku9wRf37Ihh7Fa6TWK8KWJVKGVcHHHLMUofgzv
         6gjaCm5tDsHbBPabO5jyAgjmnP1gQD/WYq2XsL088QfuFaNebm+HUlXWKRkqQRzbQxma
         hP98TaKGOXj7b1M67hMIP/c5j4JqtOG9f/6QZElMM3AMVUIKRFoJfThTU1mMQMNNX8Ah
         PwvUugYhk5uc7nJXWIwvbZ3HAxQ3XzQtlkagKcpGGhX9a2prrUZ0EV5g6hCDU+0k8R4b
         J53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=esfscYUeOA4mcBlrHfkn6mmYHWVM1Ba5XHxoxLz9cXY=;
        b=b+MpXIqWO7PeTHS0E7synSl6tEdjGZ/WLKQs/JJHHE/Y6MmVj25BmypvKj1OiYd6oR
         tbuNcvW1nQVdlpM0Pc60pTntELvSQWJg3+CeJVP32bqfvlxpfxPSraQiwldDPUWKfIlO
         V+pjmHHXBB22As1dZ/Evk/uxKWsVUvoDRdBP6jc1mJvcjzfHtZvls++eHlZdfDy41zso
         Mx4JGuPf/czEYgZPgvbFWD3Eg/SPlxOYcVNy5uhXp7OrCT+SpPhacj2qcINPvl9a9Qsh
         mqXaGAz43kuuXdIcKopK2iEUPc6tJox2OAbHbC4iwvN73tYYnQJ6C79Uhf9cOW7NRDHI
         1xhg==
X-Gm-Message-State: AJcUukf6Gn3lJGfAx6m1AgPCCfGBhx1jj/vjSo4viGOu2Sc25zCQ3A4i
        jntB2cTyUmEEUHOC0C1yVAw=
X-Google-Smtp-Source: ALg8bN5y6Qmk0eWjvM3EkRZCHw3p50djkZ43bQfecnTOf+Ne4NcOSnySuRZ5BIWgv2Cd3cndOUOiMg==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr25349176lfl.129.1548962796538;
        Thu, 31 Jan 2019 11:26:36 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:35 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 02/19] drm/panel: panel-innolux: drop unused variable
Date:   Thu, 31 Jan 2019 20:26:02 +0100
Message-Id: <20190131192619.9763-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The num_supplies variable is not used, delete it.
Build tested.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 6c3da2cbacd9..c8d0da3116dd 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -57,7 +57,6 @@ struct innolux_panel {
 
 	struct backlight_device *backlight;
 	struct regulator_bulk_data *supplies;
-	unsigned int num_supplies;
 	struct gpio_desc *enable_gpio;
 
 	bool prepared;
-- 
2.12.0

