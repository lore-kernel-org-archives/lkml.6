Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5551DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081F120823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su2TlvPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081F120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeKAAB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:01:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40339 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbeKAAB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:01:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id f18-v6so9964065qkm.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZVy5C7gVTqrB0QrFgaOuL+scvRINcyS9QCdTNwdZ+a8=;
        b=Su2TlvPSItfVwrJIyg9IkiBJE2+VSvnFUdNlfsSwD4vtx28TZ22nj6C1si4U9Kgkkv
         2Dd3ePVK7R8Oevln75eIVcfiV65/IisZdWT4hGTFa+UOfNGtiYqP6ewWEYJPo24JkaUX
         3dvY3j145gbpRrgJ6u4hhPYY+flCho4lSDnBb2ciZL4Wn2K2loBg0xKW4aLfHuzthcT7
         4jWSLsPN5JcfJiO+mgY9klYx76yx7z5QeEIDAfXj7yddl32gnSI5l7wXAoFloUGwmXFg
         efH1I12wEGGVVKqeWfjmC8VOvekM4GkCP6hu24lV6LUXalUpGsXeWmu9FJl8QV8/LjWj
         RtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZVy5C7gVTqrB0QrFgaOuL+scvRINcyS9QCdTNwdZ+a8=;
        b=lX0yP9F+2rICSnFaRvA955HxsKxPKvGIy43vNiOlPJV8RIMS/wCl1r8Mh21v6dxB9a
         WTzgE54mUd0mVNAR2Riw5Zu+FMPH/XeVNHmPQfErzkr6jtNtCCWsWEtVngvVwZ6cXtsB
         mDatSZ37Ues/WBmq+CWREja8pWoqhkKe59zOshV70ch9fZszDttJdBYW7AxrEhnQVGNV
         ztnhqNUqHVn/VEmOB4lrw0kC1Dgieu8LAaWKlay7eka8lLg9/wZJ4U8UKCW7xkQX4bS4
         1wVyRkJ29bYjaivtOByWCNUfJd2TVr7Fft/lbAl1WZEJpX1GblBKjC9/HcDW/ngjzmBK
         wu+g==
X-Gm-Message-State: AGRZ1gKAc6aJVDHIaZpvvZ8zteitq6AgTgcvR/bzmNgDhk3FVwhsIata
        l2U6IaRSPqyY6cYpAY4vVH4=
X-Google-Smtp-Source: AJdET5fn1+z4dQz3u+y9/LvpiOgZ7MkvriL7rMHjYOIdSwPkbSDbTWpwWheAQAz3w5hYItlJIukbiQ==
X-Received: by 2002:a0c:f684:: with SMTP id p4mr3069036qvn.80.1540998211419;
        Wed, 31 Oct 2018 08:03:31 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x34-v6sm14853639qth.86.2018.10.31.08.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 08:03:30 -0700 (PDT)
Date:   Wed, 31 Oct 2018 12:03:26 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v3] staging: vboxvideo: Remove unnecessary parentheses
Message-ID: <20181031150326.yikoivqgwfurtrg4@smtp.gmail.com>
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

Changes in v3:
  - Update to apply patch to the latest kernel tree

 drivers/staging/vboxvideo/vbox_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
index 7466c1103ff6..ad0e0b62bd1e 100644
--- a/drivers/staging/vboxvideo/vbox_main.c
+++ b/drivers/staging/vboxvideo/vbox_main.c
@@ -122,10 +122,10 @@ void vbox_framebuffer_dirty_rectangles(struct drm_framebuffer *fb,
 			struct vbva_cmd_hdr cmd_hdr;
 			unsigned int crtc_id = to_vbox_crtc(crtc)->crtc_id;
 
-			if ((rects[i].x1 > crtc_x + mode->hdisplay) ||
-			    (rects[i].y1 > crtc_y + mode->vdisplay) ||
-			    (rects[i].x2 < crtc_x) ||
-			    (rects[i].y2 < crtc_y))
+			if (rects[i].x1 > crtc_x + mode->hdisplay ||
+			    rects[i].y1 > crtc_y + mode->vdisplay ||
+			    rects[i].x2 < crtc_x ||
+			    rects[i].y2 < crtc_y)
 				continue;
 
 			cmd_hdr.x = (s16)rects[i].x1;
-- 
2.19.1

