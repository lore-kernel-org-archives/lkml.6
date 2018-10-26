Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E38ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB4E2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHDYTRX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB4E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeJ0Dm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:42:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39980 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbeJ0Dm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:42:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id l11-v6so1827684qtf.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/T11tt3vJuAf+zMu9ml2T7wwulQeXdHFKE/giNS+b9Y=;
        b=qHDYTRX96Vz1IhGg0mNqLOp4qg9SAYYotElg05imu/bgVQf7AaXZqCHxT0N9kkxJbQ
         3RIHrqQjZsD4WFOhncd5Rhl2+NKzliCy0/52D+I/KaoN87LmIy5dGruax6w3rRpYNr8G
         8/hndggwVjxaR6dHxp4bpEDywcOsbLh8wcEtQi+2xQ94NdrBWRUbXk0LdxpdW6jmmg6x
         ftneUr9ySdAo51nX1Ix/jqSAWU/iAt+srhLJ6f3CC9exzCYwRA7X1WvrzXgZwUj/Ne6x
         H8dxLZNy+LFo6kfBYJgEY3B40yYhtpz4Yq0WCp6JpjOaOetiEJPlRzVsiL5GQu/3KhAn
         gm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/T11tt3vJuAf+zMu9ml2T7wwulQeXdHFKE/giNS+b9Y=;
        b=oAF6kXCS9/WAXEqPIWoCzH4LXb5WxCKNNM3UaSlTBYivZvy4R+7Rz5S39O4aPA9NHw
         79nUW7yGudCw0KCgGnSvcLEG50IuWF6s3SdX3kVc9eIvGbKR4B+0/4a+isDB52VJOC1A
         wmzO11EPRV1JeWycz2pcikBa5TmlRLlhXN42xrHtUNPSTrj6FWO3fetEjUqc2Llrmdbz
         Ab58K+3Rqm641mfdi3IOwgO020A9wG8uYAL0krNf1eUm5o5dhNCD6iZYfiDecV45pDlB
         WvnrJQZinsVaUzdOtpP4V7fi+gKkPKStbtxBsR2PRyigoOz6Og/H4W5HoERyBoghPKgY
         F3NA==
X-Gm-Message-State: AGRZ1gL19Rtz7qOHpX6tafHKN/oZdjtEmnTXn+zJrorcuflmXU39T8aB
        lhIr4BSvW6SkiSf9P4djXkQ=
X-Google-Smtp-Source: AJdET5cnJ3IqIrhUseepQNOi6q8piKsTXAj0VFvISbE/wCwXEPP+nOKiaTrlb8mtCnQoBQ+Luf4Omg==
X-Received: by 2002:aed:2166:: with SMTP id 93-v6mr4544406qtc.24.1540580654360;
        Fri, 26 Oct 2018 12:04:14 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s21-v6sm1825308qkg.79.2018.10.26.12.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:04:13 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:04:10 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [RESEND PATCH 1/2] staging: vboxvideo: Change uint32_t to u32
Message-ID: <a81ed59de19694f34b5c5d183e06007d6cc50d1f.1540580493.git.shayenneluzmoura@gmail.com>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540580493.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change was suggested by checkpath.pl.

CHECK: Prefer kernel type 'u32' over 'uint32_t'

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/staging/vboxvideo/vbox_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
index 79836c8fb909..8a1b117990b8 100644
--- a/drivers/staging/vboxvideo/vbox_mode.c
+++ b/drivers/staging/vboxvideo/vbox_mode.c
@@ -311,7 +311,7 @@ static int vbox_crtc_mode_set(struct drm_crtc *crtc,
 static int vbox_crtc_page_flip(struct drm_crtc *crtc,
 			       struct drm_framebuffer *fb,
 			       struct drm_pending_vblank_event *event,
-			       uint32_t page_flip_flags,
+			       u32 page_flip_flags,
 			       struct drm_modeset_acquire_ctx *ctx)
 {
 	struct vbox_private *vbox = crtc->dev->dev_private;
-- 
2.19.1

