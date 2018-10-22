Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2504C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB35220652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6CUhNFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB35220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeJWGv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:51:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46672 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJWGv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:51:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id c16-v6so6033999qtj.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IzquyG2hwJ2BGF+7yaRRqHjroYDcegrh0OUSz7w7QvU=;
        b=F6CUhNFqBm1dX5PtOJQ3IkG7FPlT2shBGdy0fCT3No6oCv0JSjYR2CpQ4zBGcF90l/
         Y3WtOvT/UIabzUQtZ0hsk9XioyjK9dUmFhgIQ4TBbUqgzxvqshnbO++sqHkA9QyhfjUf
         gWi3nZiyPRvtNRjwjuyOw6mdg7e7/PZiJfIpu/bzxBr/l5Vkrv2X01TaVPQ3mcOgAM1b
         zIed4mShgCZgrekmLIgXPso9grnLjKH2uhZetb7RtFDZ3gJj82P8iDwZxwhy848lSI6F
         yDXEGnIQCRrUpOF3sqtaTSmec/Rz1nhGW1Yz9yxZObMlKB827+QoJVmtwlDaO++v7UC7
         rmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IzquyG2hwJ2BGF+7yaRRqHjroYDcegrh0OUSz7w7QvU=;
        b=cFBhAgx8cR/7nsOlemZLjJFHrM10DfdvEYI/tZp0+tRSvTkRrs5Fchy8BHciE8TKzf
         kHfcAcLkSjQwLMqPzW78dpydmFVcuiFxxJ6Rms9JAu9J8w7sxDtYG7Ss0Fycf21caUIq
         bM9EQuqh5UyED3lPeCUTCjqPZHooroFhz1BR3YNBuHxetVV2tLzS/Tb/4TrkLTgj1Skq
         3WsGTylUkI90EVho7Fs3Ho2dRRSRcxPUjfLVMxFc7sJpb9xFfxOHWasANaUxF9z2Jahb
         3CW8aeoSbLXmKul8VD9qF8V/sF652zXMHMWlGa8cGdQZ86FEEWXuktimybkXmkK95/Yi
         RJZA==
X-Gm-Message-State: AGRZ1gIRlQHHBtPzaZ2Pq94WCAA4+Ectodo4LitehRg364t36tmU4NBP
        H7nv7mb61styF1XdnXzrEbo=
X-Google-Smtp-Source: AJdET5ePizo2uJySRYPnLDG8z56rwq3cSB9OCpS+wppTzrPJBBWdN429kaz5ugyYE+Gd15SrTRDCOA==
X-Received: by 2002:a0c:d7d1:: with SMTP id g17mr12486170qvj.183.1540247490679;
        Mon, 22 Oct 2018 15:31:30 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm26181662qtr.91.2018.10.22.15.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 15:31:30 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:31:26 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: vboxvideo: Removed unnecessary parentheses
Message-ID: <20181022223126.smnsopiu4cavq6zh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl check:

vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
crtc->x'
vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].y2 <
crtc->y'

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/staging/vboxvideo/vbox_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
index 429f6a453619..10a862674789 100644
--- a/drivers/staging/vboxvideo/vbox_main.c
+++ b/drivers/staging/vboxvideo/vbox_main.c
@@ -116,10 +116,10 @@ void vbox_framebuffer_dirty_rectangles(struct drm_framebuffer *fb,
 			struct vbva_cmd_hdr cmd_hdr;
 			unsigned int crtc_id = to_vbox_crtc(crtc)->crtc_id;
 
-			if ((rects[i].x1 > crtc->x + crtc->hwmode.hdisplay) ||
-			    (rects[i].y1 > crtc->y + crtc->hwmode.vdisplay) ||
-			    (rects[i].x2 < crtc->x) ||
-			    (rects[i].y2 < crtc->y))
+			if (rects[i].x1 > crtc->x + crtc->hwmode.hdisplay ||
+			    rects[i].y1 > crtc->y + crtc->hwmode.vdisplay ||
+			    rects[i].x2 < crtc->x ||
+			    rects[i].y2 < crtc->y)
 				continue;
 
 			cmd_hdr.x = (s16)rects[i].x1;
-- 
2.19.1

