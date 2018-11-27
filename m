Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AA3208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6pFxlxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AA3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeK0NB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:01:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46360 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeK0NBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:01:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so7057109pgp.13;
        Mon, 26 Nov 2018 18:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HceQpm+Y1ZbD1rpfaGMY9nQ/A+0TiH92egWM3unopz8=;
        b=A6pFxlxGVVfx2b+td0C8B5SdPqtGo/XtZQiRHENP40kBUg6yHAJPj4jdiWFRpVRaIn
         908iPT9CfyhrKMX4hMfEYzcidqINIem7vrAv/JEPSCLcLGQNQ+5hzUPLKRIWx8jNU89J
         IpQEDUjTFuaXC5gT5JJJ2MKHZ4+hjvQfWRVV1j6OswjzgTteLgTy52qzJ5FGxIgw0FHR
         JGbwpAdolgoqWkb9Pj+aNdDSo+j0h8YTd6yJrdQwVVwh9d5uRGg94jLhTCHgHuUqHSEs
         D0uoIyjzHp4H2HUkAfQaAbi7Z+lCSpE9l98LZZMGEbvo0re3gqZblp8llV47s7x4XBmF
         vz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HceQpm+Y1ZbD1rpfaGMY9nQ/A+0TiH92egWM3unopz8=;
        b=ktHd9SB0qTn0+nw/2/q8X2jnJdede6hxe8+EBiuQU2B+IMTyKOFZdH960edke8+1YR
         aGcNCJMe4m7b2iYG1etAEfm/yce+azkR0kmlaAcZ3p2ioFfzuIS3D2DWskW9n3KkO48J
         aIbZWq72U9nKwXIQg+OoL2LxvgHbOwFWAb3cBz6Al2e+U2TiKA8q+VGcT+yIZJh0X4vy
         /z7imeUQtX8TdN5XFCJXPidQwlbd8omdyEjVNuiYUz+hUNtMcDK4uOccSdfe92FO1ZnZ
         TTGsu7B0Ztp1rUM33lVKkb/1JdKeyyMgi38s3eTvjDCgIhrwkSW0DcnzkRTZ3MQ0ce2a
         eq/w==
X-Gm-Message-State: AGRZ1gLLBEqSqrw6bN+N6/DAN/DQJ7w1HJnLg9msInEWltowNOx3P5Kh
        Pd1mDmyM1MjaWEu8u4ys4jh3XrmSvMk=
X-Google-Smtp-Source: AJdET5eR1Ggl2c4Dk2gVTrQn8yXemBeDV/7Sx1q4Rg3Q9J88fLJzFD5wGXx7s+BBd8fCaH5iwknhSg==
X-Received: by 2002:a62:c21c:: with SMTP id l28mr30562786pfg.74.1543284312016;
        Mon, 26 Nov 2018 18:05:12 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id s37sm3061284pgm.19.2018.11.26.18.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:05:10 -0800 (PST)
Date:   Tue, 27 Nov 2018 11:05:06 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] zram: fix lockdep warning of free block handling
Message-ID: <20181127020506.GA237537@google.com>
References: <20181126082813.81977-1-minchan@kernel.org>
 <20181126082813.81977-2-minchan@kernel.org>
 <20181126124928.8fbbf01966b741ac79a3d003@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126124928.8fbbf01966b741ac79a3d003@linux-foundation.org>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:49:28PM -0800, Andrew Morton wrote:
> On Mon, 26 Nov 2018 17:28:07 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > 
> > ...
> >
> > With writeback feature, zram_slot_free_notify could be called
> > in softirq context by end_swap_bio_read. However, bitmap_lock
> > is not aware of that so lockdep yell out. Thanks.
> > 
> > The problem is not only bitmap_lock but it is also zram_slot_lock
> > so straightforward solution would disable irq on zram_slot_lock
> > which covers every bitmap_lock, too.
> > Although duration disabling the irq is short in many places
> > zram_slot_lock is used, a place(ie, decompress) is not fast
> > enough to hold irqlock on relying on compression algorithm
> > so it's not a option.
> > 
> > The approach in this patch is just "best effort", not guarantee
> > "freeing orphan zpage". If the zram_slot_lock contention may happen,
> > kernel couldn't free the zpage until it recycles the block. However,
> > such contention between zram_slot_free_notify and other places to
> > hold zram_slot_lock should be very rare in real practice.
> > To see how often it happens, this patch adds new debug stat
> > "miss_free".
> > 
> > It also adds irq lock in get/put_block_bdev to prevent deadlock
> > lockdep reported. The reason I used irq disable rather than bottom
> > half is swap_slot_free_notify could be called with irq disabled
> > so it breaks local_bh_enable's rule. The irqlock works on only
> > writebacked zram slot entry so it should be not frequent lock.
> > 
> > Cc: stable@vger.kernel.org # 4.14+
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  drivers/block/zram/zram_drv.c | 56 +++++++++++++++++++++++++----------
> >  drivers/block/zram/zram_drv.h |  1 +
> >  2 files changed, 42 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index 4879595200e1..472027eaed60 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -53,6 +53,11 @@ static size_t huge_class_size;
> >  
> >  static void zram_free_page(struct zram *zram, size_t index);
> >  
> > +static int zram_slot_trylock(struct zram *zram, u32 index)
> > +{
> > +	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].value);
> > +}
> > +
> >  static void zram_slot_lock(struct zram *zram, u32 index)
> >  {
> >  	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
> > @@ -443,29 +448,45 @@ static ssize_t backing_dev_store(struct device *dev,
> >  
> >  static unsigned long get_entry_bdev(struct zram *zram)
> >  {
> > -	unsigned long entry;
> > +	unsigned long blk_idx;
> > +	unsigned long ret = 0;
> >  
> > -	spin_lock(&zram->bitmap_lock);
> >  	/* skip 0 bit to confuse zram.handle = 0 */
> > -	entry = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
> > -	if (entry == zram->nr_pages) {
> > -		spin_unlock(&zram->bitmap_lock);
> > -		return 0;
> > +	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
> > +	if (blk_idx == zram->nr_pages)
> > +		goto retry;
> > +
> > +	spin_lock_irq(&zram->bitmap_lock);
> > +	if (test_bit(blk_idx, zram->bitmap)) {
> > +		spin_unlock_irq(&zram->bitmap_lock);
> > +		goto retry;
> >  	}
> >  
> > -	set_bit(entry, zram->bitmap);
> > -	spin_unlock(&zram->bitmap_lock);
> > +	set_bit(blk_idx, zram->bitmap);
> 
> Here we could do
> 
> 	if (test_and_set_bit(...)) {
> 		spin_unlock(...);
> 		goto retry;
> 
> But it's weird to take the spinlock on behalf of bitops which are
> already atomic!
> 
> It seems rather suspicious to me.  Why are we doing this?

What I need is look_up_and_set operation. I don't see there is an
atomic operation for that. But I want to minimize irq disabled
area so first, it scans the bit lockless and if race happens,
i can try under the lock.

It seems __set_bit is enough under the lock.

> 
> > +	ret = blk_idx;
> > +	goto out;
> > +retry:
> > +	spin_lock_irq(&zram->bitmap_lock);
> > +	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
> > +	if (blk_idx == zram->nr_pages)
> > +		goto out;
> > +
> > +	set_bit(blk_idx, zram->bitmap);
> > +	ret = blk_idx;
> > +out:
> > +	spin_unlock_irq(&zram->bitmap_lock);
> >  
> > -	return entry;
> > +	return ret;
> >  }
> >  
> >  static void put_entry_bdev(struct zram *zram, unsigned long entry)
> >  {
> >  	int was_set;
> > +	unsigned long flags;
> >  
> > -	spin_lock(&zram->bitmap_lock);
> > +	spin_lock_irqsave(&zram->bitmap_lock, flags);
> >  	was_set = test_and_clear_bit(entry, zram->bitmap);
> > -	spin_unlock(&zram->bitmap_lock);
> > +	spin_unlock_irqrestore(&zram->bitmap_lock, flags);
> 
> Here's another one.  Surely that locking is unnecessary.

Indeed! although get_entry_bdev side can miss some bits, it's not a critical problem.
Benefit is we might remove irq disable for the lockdep problem.
Yes, I will cook and test.

Thanks, Andrew.
