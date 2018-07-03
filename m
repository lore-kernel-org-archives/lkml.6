Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F272C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A9323C19
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSinXxf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A9323C19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933986AbeGCQoJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:44:09 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46189 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932520AbeGCQoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:44:08 -0400
Received: by mail-qk0-f194.google.com with SMTP id o2-v6so1335458qkc.13;
        Tue, 03 Jul 2018 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1wNCcbZuS/uxRdodOlI2/DPyHSzehxwgeuoGmB3mH30=;
        b=cSinXxf/QThPy/w/0NIKz8YwGSd2wx8ZQrOxeMp6GbqdrO0kZd8XIM9fPRFe6BxrvO
         Ztqp5QmIx1z7SseMAlDr+K4dcseu/+Dg6iXHrwJHxIms+6JZaIpbgeMwHPL9PJkF2T7T
         X3AgMSrhictuTkq/y03Mf9mptVlIWSaD9IPwDLEqc7KrXNZYLc8ODDiDLCBNIkELhWAE
         Qu5vn0imxf61ZErObkFkmuvXNNcp92cSA/MmjDZZai4iMsunP92YRqZK0rmKDgNTh7oE
         JyZyl/DWelGmBuaV3Yt/uEaMvNBCnZWvjlYpMDdyZN0aUAx0i2PArnrMitjNLLwNkW/z
         5UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1wNCcbZuS/uxRdodOlI2/DPyHSzehxwgeuoGmB3mH30=;
        b=ogdLPfzNRCP+1wxOTk+iCCzjJ93WMwEbKESKzVxUvr7wpwX1hhUNWyneIJRTikIvel
         p08rZhajNvWqX5Nhibqw6AiwjEXvHAqLQKvwWxFSA5g2BGlxF0LePCpE+jpbwBMnkHoi
         +qBr47mzqqtJxu+mOiojJPam4i01dX+Oo4mrq+cYnmo4Yrol1tJE/EFhPuZmC1EKKJWi
         YpMbcDtZ9WD+mik7vT4m4Q2ipZ1QJWobVtb5nBOPoo2EPwDNqg5ZLCEe8VVIgSPMUuIn
         2+ljDCG/pv+eujCqDkkOeyHNtwwRzsDxJqLeEoLzNIbhKLWYwfsLciimT+LQMGypsQqV
         OuJw==
X-Gm-Message-State: APt69E2ccF4lKbFiXdXXFMo3F7+9aCLywZoleH2OLo7jfVA9hVp6tbFF
        Ff53z8QAAMiNx4MU0tVoXoU=
X-Google-Smtp-Source: AAOMgpeG/j1fAfar+kCN8kH0b9zSVhq4W6eLcaO52TDeM+uHz9tWrNwALUZbTYUE95gHO4xUO3RD1A==
X-Received: by 2002:a37:b12:: with SMTP id 18-v6mr26017635qkl.217.1530636247288;
        Tue, 03 Jul 2018 09:44:07 -0700 (PDT)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id f64-v6sm1406848qkf.2.2018.07.03.09.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:44:06 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/mdp5: fix missing CTL flush
Date:   Tue,  3 Jul 2018 12:43:50 -0400
Message-Id: <20180703164403.23877-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f9cb8d8d836e fixed various race conditions with CTL flush, in particular
flushing and sending the START signal before encoder state was updated.
But it did this a little too well in some cases that don't trigger
encoder->enable(), and CTL[n].FLUSH would never be set.  When page flips
happen it would paper over the bug, since the first plag flip would
flush out the state to the hardware.

The issue could be reproduced with, for example, modetest (without the
'-v' argument).

Fixes: f9cb8d8d836e drm/msm/mdp5: rework CTL START signal handling
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
index 9af94e35f678..fcd44d1d1068 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
@@ -319,7 +319,17 @@ static int mdp5_encoder_atomic_check(struct drm_encoder *encoder,
 
 	mdp5_cstate->ctl = ctl;
 	mdp5_cstate->pipeline.intf = intf;
-	mdp5_cstate->defer_start = true;
+
+	/*
+	 * This is a bit awkward, but we want to flush the CTL and hit the
+	 * START bit at most once for an atomic update.  In the non-full-
+	 * modeset case, this is done from crtc->atomic_flush(), but that
+	 * is too early in the case of full modeset, in which case we
+	 * defer to encoder->enable().  But we need to *know* whether
+	 * encoder->enable() will be called to do this:
+	 */
+	if (drm_atomic_crtc_needs_modeset(crtc_state))
+		mdp5_cstate->defer_start = true;
 
 	return 0;
 }
-- 
2.17.1

