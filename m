Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3BFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C9206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMNX+K7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfAJVeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:34:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45673 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfAJVeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:34:01 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so15512657qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NwwX/dDBPEXy9VzNfDpT4PusAJgSqiqrWum/jdc5iNM=;
        b=LMNX+K7nA9XtU3f6PkQ/QBcpZfsdx99wSl8nOALODAUDdskRDKDsqdZ7JlOygdK9qk
         /8hmswBGIyJ0xD+n4WEGOWu+52G6n1N18C/Zc5gyOJ9C84th7VaUFHprkmGWxQWtimie
         tfnYhJAlTdKLbeli9F3OLuXXUy7yCKbUqdbBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NwwX/dDBPEXy9VzNfDpT4PusAJgSqiqrWum/jdc5iNM=;
        b=PlNZl+sX6IkxZYHVnVLfcmkORJ74RqsCcMdJBWjF7Cxu/jxuueB/ICT3xW96N2wq0l
         IYzEbvTM0q4QXfnF6zymTtl+mtNifDAHGhypdo8j12zCGwq2sqPGjIFyyT9BKqqFvUYe
         nNc0m59UD3PkcbQ0uSMuJZF7zb+0bmXIKekQw26ihx5gcz0BMDf1zGdhP5dH6PgC3KSa
         y9iSMV1Xy8Q1YzMDdZ8+HOQUqtgVQ8ojdoK3Yy9k1v3f2RTYe+1GzA4e54pPylNYn/5l
         DfuCbM8aKmMLETauls1osqZDLFrexQKUGbBfnCVNC4jpRvjLXNqUCgCrMS1h1Sf6wC0q
         YJlg==
X-Gm-Message-State: AJcUukcpMOZ2V5VheSyrRB0nVf3RK9A7rOLsMxdCNk4Infxq2CuDsH5t
        I/cX9lwR4IXJWgzuQu2U4X3pXTJogvk=
X-Google-Smtp-Source: ALg8bN5Uq0qkbY9ptR0ZxD5Jtdawaqh/IMYRoBs3//2tvGVc+dB1o0iGcwtmhQy79OH0FefdMxMISQ==
X-Received: by 2002:a0c:ad16:: with SMTP id u22mr11688166qvc.240.1547156039562;
        Thu, 10 Jan 2019 13:33:59 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id u4sm30883239qkk.51.2019.01.10.13.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:33:58 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:33:55 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Dave Mielke <dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: unconfuse vc_origin when using soft scrollback
In-Reply-To: <nycvar.YSQ.7.76.1901101620580.6919@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1901101629420.8261@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1901101131090.6027@knanqh.ubzr> <nycvar.YSQ.7.76.1901101620580.6919@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Nicolas Pitre wrote:

> The vt code is just a frigging mess of integer variables and pointer 
> variables referring to the same thing. It is therefore littered with 
> casts all over the place. And of course I missed one in this patch.  
> 
> Here's a revised patch to quiet a warning:

And of course I forgot to commit and reposted the same patch 
with the missing cast. So here it is again:

----- >8

Subject: [PATCH] vgacon: unconfuse vc_origin when using soft scrollback

When CONFIG_VGACON_SOFT_SCROLLBACK is selected, the VGA display memory
index and vc_visible_origin don't change when scrollback is activated.
The actual screen content is saved away and the scrollbackdata is copied
over it. However the vt code, and /dev/vcs devices in particular, still
expect vc_origin to always point at the actual screen content not the
displayed scrollback content.

So adjust vc_origin to point at the saved screen content when scrollback
is active and set it back to vc_visible_origin when restoring the screen.

This fixes /dev/vcsa<n> that return scrollback content when they
shouldn't (onli /dev/vcsa without a number should), and also fixes
/dev/vcsu that should return scrollback content when scrollback is
active but currently doesn't.

An unnecessary call to vga_set_mem_top() is also removed.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org # v4.19+

---

I tagged it for stable starting with v4.19 as this is the kernel that
introduced /dev/vcsu* which is directly affected. Users of earlier kernels
most likely won't care.

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 09731b2f68..c6b3bdbbdb 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -271,6 +271,7 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 
 static void vgacon_restore_screen(struct vc_data *c)
 {
+	c->vc_origin = c->vc_visible_origin;
 	vgacon_scrollback_cur->save = 0;
 
 	if (!vga_is_gfx && !vgacon_scrollback_cur->restore) {
@@ -287,8 +288,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	int start, end, count, soff;
 
 	if (!lines) {
-		c->vc_visible_origin = c->vc_origin;
-		vga_set_mem_top(c);
+		vgacon_restore_screen(c);
 		return;
 	}
 
@@ -298,6 +298,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	if (!vgacon_scrollback_cur->save) {
 		vgacon_cursor(c, CM_ERASE);
 		vgacon_save_screen(c);
+		c->vc_origin = (unsigned long)c->vc_screenbuf;
 		vgacon_scrollback_cur->save = 1;
 	}
 
@@ -335,7 +336,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 		int copysize;
 
 		int diff = c->vc_rows - count;
-		void *d = (void *) c->vc_origin;
+		void *d = (void *) c->vc_visible_origin;
 		void *s = (void *) c->vc_screenbuf;
 
 		count *= c->vc_size_row;
