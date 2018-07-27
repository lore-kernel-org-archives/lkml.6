Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C226C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15E02064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSBuLln2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15E02064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbeG1AW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:22:59 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:37444 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbeG1AW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:22:59 -0400
Received: by mail-pg1-f169.google.com with SMTP id n7-v6so4020176pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ArhQwW3+3Cikb+xhijiDdrmnU9WsjgLLuELg+PbsJLQ=;
        b=XSBuLln2nk+E7TfZ6WzBOFvYVKet4G4cHV0Yz8DO6Wx3k/uDavQTNLJb4yBCbBrmsL
         HerCqzNxs9mz+UotZyJZs/BIoXmoMDoIalHsNZ0EIm2tvVqVjUcSEIHLRogE4Glx6XmS
         kIJYlMG0aC8XjlA6un7q5wTG4+/t37o3EdiNNusbLcM7acTG9BGotC4OTUksBY2OukHg
         tn6KaZjhwTJcqrqIi1pBqov+6jlzlFfQkwpvn96BTSPZciyswf6NBL7tsJfAx+wzkwC+
         jWWzj2cCwjFlar5ogVgjX+o64EUwk/HAWQ4drUFyp8dTdQQuYP9i2y+bKydlwjOmjbAJ
         7QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ArhQwW3+3Cikb+xhijiDdrmnU9WsjgLLuELg+PbsJLQ=;
        b=KRoJUetVzs8EM8YkUc/tiEf8jBi45buRbnaXsHwEnK7IG6NNiAZlQ8l0JQ7XKx3zWM
         DrLhrVvkQgN82SC20fB7Kdq9A7cUvyCebq5oyDL5GIme/mbufcljCIS9yQO0eq4aSfXP
         Djr0X7vAdsNPLuCiGUSy540R1PUdUsNJqHYgz3tyHHpiOnU2SRVC4DR9kLGQyc+uxrs4
         NuRQXN+lqoFouYR65TX2rjqpdqxPH2Jo3vSAyGX/cwaE0JGLTRrxduKsaVU2yVTP/w0F
         YGDTreE88Zh4skUmPz+0BMMs/ZO72V0tYQkAJ2Mc8BvE+LfkBjWXcn1HKTyhdhogOezg
         +R2w==
X-Gm-Message-State: AOUpUlFo9c0Jmr+Shy5/fPvb8i+p4ctFLzQh2AQtuMMQbMB05idtKZCe
        TUC2f7bpTjJeQuceD6tHyFM=
X-Google-Smtp-Source: AAOMgpcAUk1dmgrqB6OCCpGX7f0x3Vne+lMb7IS8PtokURls7dZCeqjLRsEBOQQJk3OiEPVPa5WuHA==
X-Received: by 2002:a63:6604:: with SMTP id a4-v6mr7590096pgc.404.1532732335734;
        Fri, 27 Jul 2018 15:58:55 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id o21-v6sm8295945pfa.54.2018.07.27.15.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:58:53 -0700 (PDT)
Date:   Sat, 28 Jul 2018 07:58:50 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Tino Lehnig <tino.lehnig@contabo.de>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180727225850.GC229060@rodete-desktop-imager.corp.google.com>
References: <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
 <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
 <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
 <15e3a0af-7e02-83fb-4b72-b05f6d7ded71@contabo.de>
 <20180726103001.GC221405@rodete-desktop-imager.corp.google.com>
 <b914205b-f3eb-7c0e-cd60-88c34341f84a@contabo.de>
 <20180727091431.GA229060@rodete-desktop-imager.corp.google.com>
 <4e0ab1cd-ea7a-0916-eb85-0396c61bd949@contabo.de>
 <20180727120517.GB229060@rodete-desktop-imager.corp.google.com>
 <54eddd07-9fe5-0a83-0d2f-556726f64516@contabo.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <54eddd07-9fe5-0a83-0d2f-556726f64516@contabo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 02:13:57PM +0200, Tino Lehnig wrote:
> On 07/27/2018 02:05 PM, Minchan Kim wrote:
> > And bad page is always with writeback enable?
> > 
> > writeback enable means "echo "some dev" > /sys/block/zram0/backing_dev,
> > not just enable CONFIG_ZRAM_WRITEBACK.
> 
> Yes, the bug only appears when backing_dev is set.

Thanks for the clarifiation.

I made a mistake on previous patch.
Could you test this patches?

> 
> -- 
> Kind regards,
> 
> Tino Lehnig

--CUfgB8w4ZwR/yMy5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-zram-remove-BD_CAP_SYNCHRONOUS_IO-with-writeback-fea.patch"

From 77a5fc378dfae733af5a0f0c7ef901668d8c9778 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 27 Jul 2018 15:15:33 +0900
Subject: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback feature

If zram supports writeback feature, it's no more syncrhonous
device beause we need asynchronous IO opeation.

Do not pretend to be syncrhonous IO device. It makes system
very sluggish as waiting IO completion from upper layer.
Furthermore, it makes user-after-free problem because swap
think the opearion is done when the IO functions returns so
it could free page by will but in fact, IO is asynchrnous
so driver could access the freed page afterward.
(I will make description more clear at the formal patch).

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7436b2d27fa3..0b6eda1bd77a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -298,7 +298,8 @@ static void reset_bdev(struct zram *zram)
 	zram->backing_dev = NULL;
 	zram->old_block_size = 0;
 	zram->bdev = NULL;
-
+	zram->disk->queue->backing_dev_info->capabilities |=
+				BDI_CAP_SYNCHRONOUS_IO;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
 }
@@ -400,6 +401,8 @@ static ssize_t backing_dev_store(struct device *dev,
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
+	zram->disk->queue->backing_dev_info->capabilities &=
+			~BDI_CAP_SYNCHRONOUS_IO;
 	up_write(&zram->init_lock);
 
 	pr_info("setup backing device %s\n", file_name);
-- 
2.18.0.345.g5c9ce644c3-goog


--CUfgB8w4ZwR/yMy5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-swap-free-allocated-page-if-swap_read-fails.patch"

From 7c263ac8b9557c60c631c239cc7b863ed762098f Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 27 Jul 2018 17:17:01 +0900
Subject: [PATCH 2/2] swap: free allocated page if swap_read fails

swap_readpage could fails by -ENOMEM. In this case, we should free
allocated page instantly and bail out. There is no reason to retry.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7206a634270b..8a5e304ffd91 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2943,7 +2943,8 @@ int do_swap_page(struct vm_fault *vmf)
 				__SetPageSwapBacked(page);
 				set_page_private(page, entry.val);
 				lru_cache_add_anon(page);
-				swap_readpage(page, true);
+				if (swap_readpage(page, true))
+					goto out_page;
 			}
 		} else {
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-- 
2.18.0.345.g5c9ce644c3-goog


--CUfgB8w4ZwR/yMy5--
