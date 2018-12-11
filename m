Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BF5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF8C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="qFYsrfsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF8C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbeLKQI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:08:57 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46683 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbeLKQI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:08:56 -0500
Received: by mail-yb1-f193.google.com with SMTP id f9so3364062ybm.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLM4cByh5Uc8ZC0cR7JhP/PtuxfYYbtS3+824fcPbNY=;
        b=qFYsrfsIl1beviePDSVlgfDgTZmlyZRnTNItQF4xSjpY8H7Kbqf12hoHRnm2naNAVi
         tT2A7p7xB8ihZVsZoAsuNbowHwd2N0DAVbRIneEJFzGavt8E26B9WpeexCKLotLpayXX
         ucwqPK/ox5Fa4NoAt3M/JATxVOl6oht33qPw2Qs4CgQ4SPIQRp2Bsq9MXTDlGSRUVDJq
         Lj3jwaWrlDrZB/Ta3FT735Lrqa37bVgQqkJnMBPvkI55hZ84nJ0hJ0UJGFvoEjouIiIy
         9CF72FhA07PsExzMtCgIKN+7o/Rb3WNcVS9+YSrpkNNfIlWEfYI/3orjoytegJXrGcYT
         tycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLM4cByh5Uc8ZC0cR7JhP/PtuxfYYbtS3+824fcPbNY=;
        b=P4euSgJw289JLJnIS0ZfNtL6dyCUApylVkPP/ezwrWqq1ch4upu985r182Er1Xy4uJ
         W9WMxzAQmVBA5bAu2J+8kDNTW81IEHTNvqG2LXIR1+a11I7KHJ0IVxfAPmnqDndP57iq
         M9Nn6OFaNcb/sdke50MHSD0PBK1vSLn+W+aJV2hJFrQcVimVD5CsrRwiGtKDvc5eLMR+
         77ls0eyIqwHWgX+xChlUWj30bJfenGxNAnsbwYk6X9MI6DWThQx7ATGJql2SkjY6dTl9
         gsczS+20UnAo5Es99Lv6gUTPw3I5UYqhXBUmKMCqMWN8nuDN8DGhIXVs8h7fTVStauuK
         8OOw==
X-Gm-Message-State: AA+aEWY0mH3x2HWZGXeyGfS7Tkfr6s5u2/GY0++O5pSc3eRY5LYDrvaU
        LjH7IGTR8sm6LFbTEjygCVHoeg==
X-Google-Smtp-Source: AFSGD/VW+tOdBwnE/XYV/Z28AvFUJdfwgLycckOWa7ltfxYO0vBgfSr9zs7jmwlZIWS5WN2ps/afrw==
X-Received: by 2002:a25:1cc1:: with SMTP id c184-v6mr16859141ybc.421.1544544534733;
        Tue, 11 Dec 2018 08:08:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:c32a])
        by smtp.gmail.com with ESMTPSA id j186sm4638366ywg.36.2018.12.11.08.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 08:08:53 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:08:53 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        david@fromorbit.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com
Subject: Re: [PATCH 3/4] filemap: drop the mmap_sem for all blocking
 operations
Message-ID: <20181211160851.hqezlvlded6zujrm@macbook-pro-91.dhcp.thefacebook.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-4-josef@toxicpanda.com>
 <20181207110138.GE13008@quack2.suse.cz>
 <20181210184438.va7mdwjgwndgri4s@macbook-pro-91.dhcp.thefacebook.com>
 <20181211094034.GD17539@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211094034.GD17539@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:40:34AM +0100, Jan Kara wrote:
> On Mon 10-12-18 13:44:39, Josef Bacik wrote:
> > On Fri, Dec 07, 2018 at 12:01:38PM +0100, Jan Kara wrote:
> > > On Fri 30-11-18 14:58:11, Josef Bacik wrote:
> > > > @@ -2433,9 +2458,32 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> > > >  			return vmf_error(-ENOMEM);
> > > >  	}
> > > >  
> > > > -	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
> > > > -		put_page(page);
> > > > -		return ret | VM_FAULT_RETRY;
> > > > +	/*
> > > > +	 * We are open-coding lock_page_or_retry here because we want to do the
> > > > +	 * readpage if necessary while the mmap_sem is dropped.  If there
> > > > +	 * happens to be a lock on the page but it wasn't being faulted in we'd
> > > > +	 * come back around without ALLOW_RETRY set and then have to do the IO
> > > > +	 * under the mmap_sem, which would be a bummer.
> > > > +	 */
> > > 
> > > Hum, lock_page_or_retry() has two callers and you've just killed one. I
> > > think it would be better to modify the function to suit both callers rather
> > > than opencoding? Maybe something like lock_page_maybe_drop_mmap() which
> > > would unconditionally acquire the lock and return whether it has dropped
> > > mmap sem or not? Callers can then decide what to do.
> > > 
> > 
> > I tried this, but it ends up being convoluted, since swap doesn't have a file to
> > pin we have to add extra cases for that, and then change the return value to
> > indicate wether we locked the page _and_ dropped the mmap sem, or just locked
> > the page, etc.  It didn't seem the extra complication, so I just broke the open
> > coding out into its own helper.
> 
> OK. Thanks for looking into this!
> 
> > > BTW I'm not sure this complication is really worth it. The "drop mmap_sem
> > > for IO" is never going to be 100% thing if nothing else because only one
> > > retry is allowed in do_user_addr_fault(). So the second time we get to
> > > filemap_fault(), we will not have FAULT_FLAG_ALLOW_RETRY set and thus do
> > > blocking locking. So I think your code needs to catch common cases you
> > > observe in practice but not those super-rare corner cases...
> > 
> > I had counters in all of these paths because I was sure some things weren't
> > getting hit at all, but it turns out each of these cases gets hit with
> > surprisingly high regularity. 
> 
> Cool! Could you share these counters? I'd be curious and they'd be actually
> nice as a motivation in the changelog of this patch to show the benefit.
> 

Hmm I can't seem to find anything other than the scratch txt file I had to keep
track of stuff, but the un-labeled numbers are 18953 and 879.  I assume the
largest number is the times we went through the readpage path where we weren't
doing any mmap_sem dropping and the 879 was for the lock_page path, but I have
no way of knowing at this point.

> > The lock_page_or_retry() case in particular gets hit a lot with
> > multi-threaded applications that got paged out because of heavy memory
> > pressure.  By no means is it as high as just the normal readpage or
> > readahead cases, but it's not 0, so I'd rather have the extra helper here
> > to make sure we're never getting screwed.
> 
> Do you mean the case where we the page is locked in filemap_fault() (so
> that lock_page_or_retry() bails after waiting) and when the page becomes
> unlocked it is not uptodate? Because that is the reason why you opencode
> lock_page_or_retry(), right? I'm not aware of any normal code path that
> would create page in page cache and not try to fill it with data before
> unlocking it so that's why I'm really trying to make sure we understand
> each other.

Uhh so that's embarressing.  We have an internal patchset that I thought was
upstream but hasn't come along yet.  Basically before this patchset the way we
dealt with this problem was to short-circuit readahead IO's by checking to see
if the blkcg was congested (or if there was a fatal signal pending) and doing 
bio_wouldblock_error on the bio.  So this very case came up a lot, readahead
would go through because it got in before we were congested, but would then get
throttled, and then once the throttling was over would get aborted.  Other
threads would run into these pages that had been locked, but they are never read
in which means they waited for the lock to be dropped, did the VM_FAULT_RETRY,
came back unable to drop the mmap_sem and did the actual readpage() and would
get throttled.

This means this particular part of the patch isn't helpful for upstream at the
moment, but now that I know these patches aren't upstream yet that'll be my next
project, so I'd like to keep this bit here as it is.  Thanks,

Josef
