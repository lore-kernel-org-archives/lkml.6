Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAABC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA9121564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGS4c/Tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA9121564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeHXQYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:24:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35314 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeHXQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:24:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so1562143wmc.0;
        Fri, 24 Aug 2018 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bxxvBICkel4BZqKVVgOBccwwBhBoonk9fpI9AbZ2jjc=;
        b=VGS4c/TtPPODCRARKarBSSRwZE9gu7/j0/vp+bByAHkwj8a9mBrpJoGrzrFh/Gtqql
         511FyG3xsyzpqnzH40i1xKt/bSYunCE71ioTPojMptOghNnY31Q9NvmIGaMBH+gv89wq
         GjBzaokNNrEtjLcTmQ/x8ppSpXk32MODwpiLQ0vZ3fp0vx2tqoYzk2FcH7izX4kRug37
         s74nars97e3SlWoXCuubTW82SoumO9Rd5JJzC0ycJhOJxLyRr1rbQRB3gVX83M8YutiR
         ID2V6cw0DS1Hl7JlxxQiz9mUik5iZAIaNHqrhC/vNvM/sVyclkDTf+XPSRk2f0iWFQq/
         jpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bxxvBICkel4BZqKVVgOBccwwBhBoonk9fpI9AbZ2jjc=;
        b=DqvALwkRg+r8f/sb1A08pqg5YEbAuN/OJ36WwPUvWoZJ99zD1vfC0EEkMhBpXTQKUo
         UwBeUPH1E7JbAuAvYMjUc6GdV//w0qf5+OTtTIqDAhJQk/KfbMwtIHfYEw+oPE/R40Q8
         LEM6aNrec4ojHk5hfLfPQT5ISrUZ4TNyK2+pWj+J7e6HP4lUedTr3sm5UU6vwZgw4b4+
         oVDp3t2pjJ3+jJo0aMKjZxA7ud3024/PyfwGXh1YQ89lPwkllvcpawY453uJABpEZDhx
         4ejBRTgaqp4/hDrK7FXCyzTF6vzy2NKZVe9gKGxyL0azkMT5z6l4ShDGUHy7wY0DDfFJ
         /RKw==
X-Gm-Message-State: APzg51BPbSdWW40FSmBaLLk2TMY6lJUscWfshIuXe+hoDSbCzfFbHaQt
        d9egxJjAkgxSxqeUiNeVZlI=
X-Google-Smtp-Source: ANB0VdZmFLGXh5h89LSESJ5NnVMYi3EvN+2pHPA+1m1zTFEcT/tDETdxkFnyz6PDGItQ3g+Sc0HQ1g==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr1385142wme.125.1535114982658;
        Fri, 24 Aug 2018 05:49:42 -0700 (PDT)
Received: from localhost.localdomain ([41.249.214.155])
        by smtp.gmail.com with ESMTPSA id y203-v6sm1050884wmd.1.2018.08.24.05.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 05:49:42 -0700 (PDT)
From:   Mehdi Bounya <bounya9mehdi@gmail.com>
X-Google-Original-From: Mehdi Bounya <contact.mehdi@pm.me>
To:     b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mehdi Bounya <contact.mehdi@pm.me>,
        Mehdi Bounya <mehdi.bounya@gmail.com>
Subject: [PATCH] Video: vgastate: fixed a spacing coding style
Date:   Fri, 24 Aug 2018 13:49:08 +0100
Message-Id: <1535114948-18615-1-git-send-email-contact.mehdi@pm.me>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed a space between function name and open parant.

Signed-off-by: Mehdi Bounya <mehdi.bounya@gmail.com>
---
 drivers/video/vgastate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/vgastate.c b/drivers/video/vgastate.c
index 548c751..122fb3c 100644
--- a/drivers/video/vgastate.c
+++ b/drivers/video/vgastate.c
@@ -455,7 +455,7 @@ int save_vga(struct vgastate *state)
 	return 0;
 }
 
-int restore_vga (struct vgastate *state)
+int restore_vga(struct vgastate *state)
 {
 	if (state->vidstate == NULL)
 		return 1;
-- 
2.7.4

