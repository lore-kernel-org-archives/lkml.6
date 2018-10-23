Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D72C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C542081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3moeBgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C542081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeJXCHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:07:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46371 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeJXCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:07:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id a193-v6so1368229qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LTQBbN7v01p06gTRf7aJbSH9y9Y2K/1hrzJaEfI2w6g=;
        b=f3moeBgiXEmlRXMxcVbbeSMnAbr01S7kNzC5HKP5fox0DzOIjOUGgkz+CAlO9nYGE0
         nazgPsB7YukROpfOZqpQB46jVOskf1hnPz4RbO+qX08GNcrpwg9wSTX21z0dyG0ydgar
         nQRhg8By8CWxmnytSyS+IZoFrX0hd7ndSZ475NZQBVydZ/q7cDJTUrrEz11OCo9rFWR5
         46LSBIjpnjz2dudLX13I+5vc8ddnVw+knzY2FruNQ7Tnf0wpELuKgVV0ZjaoCw5+o2Op
         5+gFUw6OvlDxUJdYheI1pvjOybgDpmIj4lKtnAKBriO2jxjfBeXnGClFVcB4E8DLzPdN
         1Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LTQBbN7v01p06gTRf7aJbSH9y9Y2K/1hrzJaEfI2w6g=;
        b=TVNNjLijXAqNBbs7THNuRItiwA4c/heg1DIgxrwOyZkx15DbSTd4FPBflPAj6CZFv4
         hJoKs1JeSYiBI8slMLlO/vlLoUGxrT9o8K153EJ0AWUhR4Xy+WRpx7VXqWQPPgOxY2az
         wkU2Gqp2IUOhHGN1QXAgR61RXA7daUFNneTUlPPSmO3QCU6m3EuNeTSGy3P3hytRnafw
         G52EpyuiIGmNG8XlHQ3wntWgLpC/eWstfj9pcWtP+XBm8PyYGjHVUsyJnVo5GbGjLEOa
         ga/9TQqrFvTeW5MBvApSkDzhWEc4rdRrLtKJeCzTrHcR2Wqh+mCkSo+TT652oduTBakw
         lvjg==
X-Gm-Message-State: AGRZ1gLk+ozyY175s1k+5oE7sGwrrQX7N++J4HithzRCrGGiQnDxch8s
        ttEt9xnYeVBZDtgwQ5zB7vQ=
X-Google-Smtp-Source: AJdET5exDiEwp8JRh6+/r0E6MEIcAaAZ7DyxtSbw46OMg086H1X27Vm4V9Pc76AO+tfr1FkvLwicmA==
X-Received: by 2002:a37:15a5:: with SMTP id 37mr6580495qkv.292.1540316588896;
        Tue, 23 Oct 2018 10:43:08 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id z188-v6sm1218662qkz.66.2018.10.23.10.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 10:43:08 -0700 (PDT)
Date:   Tue, 23 Oct 2018 14:43:04 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2] staging: vboxvideo: Remove unnecessary parentheses
Message-ID: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded parentheses around the arguments of ||. This reduces
clutter and code behave in the same way.
Change suggested by checkpatch.pl.

vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
crtc->x'

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
Changes in v2:
  - Make the commit message more clearer.
 
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

