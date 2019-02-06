Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A7720844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5kgIqAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfBFUIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:08:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43155 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBFUIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:08:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so3870942qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ILKlvuUbPFyAG+5JJDItOklQEVaqz1AJ3gr+H60JLxw=;
        b=h5kgIqAiqIyCyQbfgADMUsTyfTHAxAcwtGmWr/kx4L7gEXHG1U96vbpjkUz8ZeruVn
         Uw7G9zyT5TRshxrrxMn7tDXE5TBxlUCNtA2CVVB4zXJeSz13MI3Fzir1lWvZsJzoC/TG
         rAR/G6leoK9uc/Y+b+fNEZkxEQImvvW2cy6NLduuRStXsLIVhbjqHMRPavPn+TQ3sbGf
         s0VOknrFKtNGa/N9SWkOzlPkp7N6vUq3xa1yeDcLu00ZjTjI4em70qoG5uFYaX50bOyl
         P0Q/L7sJEjkCS5obrKQdFG5XF9iQHQW9I9b7Rs5XO4ZsbSQASIoCafAeLYTW7OVJAZ8w
         w6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ILKlvuUbPFyAG+5JJDItOklQEVaqz1AJ3gr+H60JLxw=;
        b=nqu6JRfNWxxWUq4BnYB6GWrWbaPy6mWqikswr5pKwoUyXUUSBI7dHgbZO+iEYDgjIj
         0TIWbqD96m7ffL+AtoxA5dyGG6NlqiKWxT7O7CJXzPb8wasHkdD2UFIvzmvX18sunAty
         hdEc+lXQ63d1/ond+PR9r8aikQPrurZ4/B/6MopALEZUciCZFfXWZ/3xZUu5rrzCVg9U
         MPApieC/a14vmmpbOfbhACLvSSDaCXgKalpVkdTnG1A0Cj/JAqwLXdD6sGJ2GUBsGazE
         E9LoSsMUQveEoEsX1dE0j/cTLmflsJQQbP5fS6x+R2WEdv/TfRxBbFvnNgZDoaqb9CK1
         jWIw==
X-Gm-Message-State: AHQUAubXQz3fgz1xEqvDF0ueFxHYQwNJcLCDK/o70LjptVKgJdTHE0z0
        fIlNyQi2IYcmv1oUk3V00dg=
X-Google-Smtp-Source: AHgI3IbzgU09qqGx5RVBj/0QrbxhsNXm9gJ5PxGBBRLk6hKjfIXVOTGSHtkj9q2siPlv4hkYuuqadA==
X-Received: by 2002:aed:3907:: with SMTP id l7mr9200485qte.65.1549483698482;
        Wed, 06 Feb 2019 12:08:18 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p2sm12160754qkg.92.2019.02.06.12.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 12:08:17 -0800 (PST)
Date:   Wed, 6 Feb 2019 18:08:13 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: WARN when hrtimer_forward_now fails
Message-ID: <20190206200813.d5w7gjpepoeeadiy@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the variable have the same type of function hrtimer_forward_now
return.

Add a warn to verify the hrtimer_forward_now return.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 5a095610726b..734a3e197df8 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -16,7 +16,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 						  vblank_hrtimer);
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_crtc_state *state = to_vkms_crtc_state(crtc->state);
-	int ret_overrun;
+	u64 ret_overrun;
 	bool ret;
 
 	spin_lock(&output->lock);
@@ -43,6 +43,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 
 	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
 					  output->period_ns);
+	WARN_ON(ret_overrun != 1);
+
 	spin_unlock(&output->lock);
 
 	return HRTIMER_RESTART;
-- 
2.17.1

