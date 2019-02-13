Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1EAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08799206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KL+czqKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436801AbfBMVdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46204 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfBMVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:32 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so4409095qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKNS61az1WGOd8AWFZ4ZTIsUVQ0LSar+s/KyUDJcDZM=;
        b=KL+czqKkXMMB508fq669G8sT+oinM88F0RwPUXD47WYPeCn3WLKCVKUEffgwBJq773
         Bg1l2Idlw4ewZ01aKj8lj1coFPtuAL3watPBEPI0V1YOSoDdePcdZB8Th3Fd3c0qQWUv
         9PHttCq3XE4t+Wgv1+Od9KHuSsuezWVZO4EV+qtM7rzYx61k6AeU+ooiynssjwKJsgSE
         /dlmUOsLQF+2QCdYMAHoMSSlAEoiaEMG5c7qpJ6d4se4O0aALSlTRnnsKxhoSXQc2K//
         ilgZIL3sdIklo9RYYGOMyomibbU7A4nJ4qtH3wT1x9FoXpGyuxCFuDjugd7OXe3YmVEl
         u4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKNS61az1WGOd8AWFZ4ZTIsUVQ0LSar+s/KyUDJcDZM=;
        b=hgonRmJEyKf1lQKrJcwZ754emVrH+kKTQpTTYixk7SNQ6/UVuq8FeiZpFYAQo7BsZO
         3CNRGObOG0rO65Mg6PBuf7vfvQ0+oYgOxgm1vKMXvy/ZLr3tRNkatYhVTsCeOy069BOC
         MDHSksP/XhgAY5yQF0iXF7WT2xIsBafwpV+ZqCxuybJkty1D+TaMz/7PdLtOKYwqVo7D
         mrhlcHdTr9s6X0cTT4xmzQJmjpLqrwg1/G8lalOAI5DqpyxeDL8RSAPTzOMHegDMlqMx
         /PYf2aYlQZakGhq9/DfgpFpHkOGtTMdogVzx4TZI08uCGsW+SkUjgbQyF5VAtxQ+CYpA
         B7yA==
X-Gm-Message-State: AHQUAuajtPvIAXFtrbG8HwtjuJGEQiWleAHXB8Tee9VBv0KuhO9ShSgl
        /Se4dO6BSYAiIGs24P+zI6b9ew==
X-Google-Smtp-Source: AHgI3IafCpIs/y9rPR16co2x66QKSVzJyNLtvmMs6gDQZEW/2cbXdskUKQ+2kKteni/lPrG/s6kmDg==
X-Received: by 2002:aed:2044:: with SMTP id 62mr224159qta.11.1550093551451;
        Wed, 13 Feb 2019 13:32:31 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:30 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 04/17] ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
Date:   Wed, 13 Feb 2019 16:32:10 -0500
Message-Id: <20190213213223.916-5-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 319508902600c2688e057750148487996396e9ca upstream.

Copy events to user using __copy_to_user() rather than copy members of
individually with __put_user_error().
This has the benefit of disabling/enabling PAN once per event intead of
once per event member.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/sys_oabi-compat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index f0dd4b6ebb63..40da0872170f 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -277,6 +277,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 				    int maxevents, int timeout)
 {
 	struct epoll_event *kbuf;
+	struct oabi_epoll_event e;
 	mm_segment_t fs;
 	long ret, err, i;
 
@@ -295,8 +296,11 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 	set_fs(fs);
 	err = 0;
 	for (i = 0; i < ret; i++) {
-		__put_user_error(kbuf[i].events, &events->events, err);
-		__put_user_error(kbuf[i].data,   &events->data,   err);
+		e.events = kbuf[i].events;
+		e.data = kbuf[i].data;
+		err = __copy_to_user(events, &e, sizeof(e));
+		if (err)
+			break;
 		events++;
 	}
 	kfree(kbuf);
-- 
2.17.1

