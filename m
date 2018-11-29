Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0ED20832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUVH0DHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0ED20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeK2NrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:47:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34356 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2NrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:47:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so231066pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 18:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sy0TEUwUKFbfkqVGIbmjs4BRdnwvbbu9XWWoJmJzJGw=;
        b=gUVH0DHpimjEbUft/30wWVbeMKzCX9DcD+XApIJAdQYqxGvpigcei4dpzEHi9w1xfz
         9xZ0o3lFiAXkTKzlM+f6P/wt3T1lgNel9XT0BcoKzmN39SBQf20OENqolgjnJUPha8+L
         eIrAh+FHNk4hLiLQ/JxqtxaUa01+mw0MYg82YCKF1pj9eLwjvmaphCwGP7AkHA9NYCVi
         VpkIzncXcsFahjQ/SUhPAbkwIxK6qFRF9p4MwMUU53sWnkoGnCswu27xXA5iEQ80J5qr
         iZimNriviNoFBAKdgDXToEg9RUdqH2+haOu44BKWCoQAjpKL/doPoCkUm14AWNuMNo5h
         cvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sy0TEUwUKFbfkqVGIbmjs4BRdnwvbbu9XWWoJmJzJGw=;
        b=sMI/roimttmpti1gl20myeyJIaU4XQfg3yTUDf6t+rrfet7oOePCaiHQIYrosjjeKI
         Uz9ijDrYGqdwOUsWklLtaE8sSyk2yf2T2QD3WTokFvgQuQYgvaqkENuXUT1TsLGNHnGD
         B1IsvRLrGwDHLqAuNTfGovBgRA3rXM/47HIu+lgkAZSZpbR1O4TzQ8zGNcUq73B+uOpQ
         naHZsgX5MPfNcjKnRfh7v54aZnYx2DhBWOGeETWPs1ZTW8ytWemomJ5xHag5l9V8N8Wm
         ctGlGVTt1mTrnIZY0Q8gWXshjLcKgDjI8K5kJ24r1U2QeSfBJt6jfqfbiCm8w5ZPjiku
         xl2w==
X-Gm-Message-State: AA+aEWb+YxdHSSrJRYdigpHx8EoSqC+19l+vN6I1V03noyh0CrwlLH2S
        REaGaTdmz9kl+4MZJgvapLk=
X-Google-Smtp-Source: AFSGD/XvGljGLtoEr6FNl3SYke9pto+7MJeGCTXgwAcRQV2f+/grLb4gCH6WY+X6lGuEInsIG8N1TA==
X-Received: by 2002:a62:1112:: with SMTP id z18mr19984847pfi.173.1543459418310;
        Wed, 28 Nov 2018 18:43:38 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id q1sm349695pgs.14.2018.11.28.18.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 18:43:37 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:43:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 1/7] zram: fix lockdep warning of free block handling
Message-ID: <20181129024334.GD6379@jagdpanzerIV>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127055429.251614-2-minchan@kernel.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 14:54), Minchan Kim wrote:
> With writeback feature, zram_slot_free_notify could be called
> in softirq context by end_swap_bio_read. However, bitmap_lock
> is not aware of that so lockdep yell out. Thanks.
> 
> get_entry_bdev
> spin_lock(bitmap->lock);
> irq
> softirq
> end_swap_bio_read
> zram_slot_free_notify
> zram_slot_lock <-- deadlock prone
> zram_free_page
> put_entry_bdev
> spin_lock(bitmap->lock); <-- deadlock prone
> 
> With akpm's suggestion(i.e. bitmap operation is already atomic),
> we could remove bitmap lock. It might fail to find a empty slot
> if serious contention happens. However, it's not severe problem
> because huge page writeback has already possiblity to fail if there
> is severe memory pressure. Worst case is just keeping
> the incompressible in memory, not storage.
> 
> The other problem is zram_slot_lock in zram_slot_slot_free_notify.
> To make it safe is this patch introduces zram_slot_trylock where
> zram_slot_free_notify uses it. Although it's rare to be contented,
> this patch adds new debug stat "miss_free" to keep monitoring
> how often it happens.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
