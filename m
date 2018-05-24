Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159093-2-5671077271908412224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159092; b=KUUXUArOdJ3rF78go6R+ZdPnYTnmI8mb8XSFLirCEPdjDFS6zv
    Ljqr6rRoiW9VoBs+fsv528By0GcfL3SXdgX69fcoEmE/lvapvx1pu19+KAj0f7RM
    udA3ohafsCNT0rQr/pItz9wVh/iphhDip196bz+s3uIVkPMx/chP3ZP8ZIJNZz8X
    H088CMF2Qdh6wKXB/vadg7c4FiCv8A0EpbOMBCigvqZUPxCXw2BjmbpVz9WIbUz7
    7aJOi3WelB6rwQYLYawIjeWl5+I3TShe0NAddIORnmMTNvYN7qUFoL3IsmpauR5W
    BiBNaL5h1mcWMbTTdx+Y8rXLaWaVsksj6BOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527159092; bh=qkxXghPjKmeKly0clD5d/iNVb5RRRf
    T6SleOWjoXccs=; b=I6s5D0V6RCtcdztI4qsjPlwGcqx4d/d2VhJce6dQ/f4Omm
    qjydhwpgFaOu5N4nOpuuTqflUQBCydDmgyb7J2bTPnPIu8XIfwTu3a5PquUAxKE4
    ptWzef1ObURTPJBKJuQT0kWm8vf4DvosZfZ+CGJIzMowmeJ0meVFZs1/VJl2fQUl
    7yQZu94VUiWc6ntGBsBnpv9TcGT6T5H9u21G5D7BUno16dQLnene8MqCggybsEXJ
    2iCPM91UQc/LvZcBQ4dV4I2DSJY53RU7PGxpTP0+88hlaEoA+Zs2GcHEcKS9hMiz
    phpVu/16kL/YW1MTvNFzkkXeAVEQIm+vV2Q8R7MQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEKXSXBz1vUmsGAGpgULPr1hZ5u3/sspJP7Ra78H4TH+jFvvkyksmRS3j4Tt7vue/Nl2DwxbKukmoAIxZIsOvG5syBlKiAgzz9llwXrluYozOtPSJO+C
    DF3falfm6D7saebAgqW1Nz28Jiy6BQuiSjaOrItlHH7kbKInCyDEu/gAgz/b1BDFHodmslu7OQYar6TgX6Ez6aIqcpamWDXSH1cQaObi6K3mT8HpgNAR88Zi
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=R_Myd5XaAAAA:8 a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8
    a=iox4zFpeAAAA:8 a=K5TaBE0mRc37vMaz9pQA:9 a=CjuIK1q_8ugA:10
    a=L2g4Dz8VuBQ37YGmWQah:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030501AbeEXKvQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:51:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030472AbeEXKuN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:50:13 -0400
Date: Thu, 24 May 2018 12:50:11 +0200
From: Jan Kara <jack@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 4.4 50/92] mm: filemap: avoid unnecessary calls to
 lock_page when waiting for IO to complete during a read
Message-ID: <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524093204.290399449@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093204.290399449@linuxfoundation.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 24-05-18 11:38:27, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.

Just one objection: Why does stable care about this (and the previous
patch)? I've checked the stable queue and I don't see anything that would
have these patches as a prerequisite. And on their own, they are only
cleanups without substantial gains.

								Honza

> 
> ------------------
> 
> From: Mel Gorman <mgorman@techsingularity.net>
> 
> commit ebded02788b5d7c7600f8cff26ae07896d568649 upstream.
> 
> In the generic read paths the kernel looks up a page in the page cache
> and if it's up to date, it is used.  If not, the page lock is acquired
> to wait for IO to complete and then check the page.  If multiple
> processes are waiting on IO, they all serialise against the lock and
> duplicate the checks.  This is unnecessary.
> 
> The page lock in itself does not give any guarantees to the callers
> about the page state as it can be immediately truncated or reclaimed
> after the page is unlocked.  It's sufficient to wait_on_page_locked and
> then continue if the page is up to date on wakeup.
> 
> It is possible that a truncated but up-to-date page is returned but the
> reference taken during read prevents it disappearing underneath the
> caller and the data is still valid if PageUptodate.
> 
> The overall impact is small as even if processes serialise on the lock,
> the lock section is tiny once the IO is complete.  Profiles indicated
> that unlock_page and friends are generally a tiny portion of a
> read-intensive workload.  An artificial test was created that had
> instances of dd access a cache-cold file on an ext4 filesystem and
> measure how long the read took.
> 
> paralleldd
>                                     4.4.0                 4.4.0
>                                   vanilla             avoidlock
> Amean    Elapsd-1          5.28 (  0.00%)        5.15 (  2.50%)
> Amean    Elapsd-4          5.29 (  0.00%)        5.17 (  2.12%)
> Amean    Elapsd-7          5.28 (  0.00%)        5.18 (  1.78%)
> Amean    Elapsd-12         5.20 (  0.00%)        5.33 ( -2.50%)
> Amean    Elapsd-21         5.14 (  0.00%)        5.21 ( -1.41%)
> Amean    Elapsd-30         5.30 (  0.00%)        5.12 (  3.38%)
> Amean    Elapsd-48         5.78 (  0.00%)        5.42 (  6.21%)
> Amean    Elapsd-79         6.78 (  0.00%)        6.62 (  2.46%)
> Amean    Elapsd-110        9.09 (  0.00%)        8.99 (  1.15%)
> Amean    Elapsd-128       10.60 (  0.00%)       10.43 (  1.66%)
> 
> The impact is small but intuitively, it makes sense to avoid unnecessary
> calls to lock_page.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  mm/filemap.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1581,6 +1581,15 @@ find_page:
>  					index, last_index - index);
>  		}
>  		if (!PageUptodate(page)) {
> +			/*
> +			 * See comment in do_read_cache_page on why
> +			 * wait_on_page_locked is used to avoid unnecessarily
> +			 * serialisations and why it's safe.
> +			 */
> +			wait_on_page_locked_killable(page);
> +			if (PageUptodate(page))
> +				goto page_ok;
> +
>  			if (inode->i_blkbits == PAGE_CACHE_SHIFT ||
>  					!mapping->a_ops->is_partially_uptodate)
>  				goto page_not_up_to_date;
> @@ -2253,12 +2262,52 @@ filler:
>  	if (PageUptodate(page))
>  		goto out;
>  
> +	/*
> +	 * Page is not up to date and may be locked due one of the following
> +	 * case a: Page is being filled and the page lock is held
> +	 * case b: Read/write error clearing the page uptodate status
> +	 * case c: Truncation in progress (page locked)
> +	 * case d: Reclaim in progress
> +	 *
> +	 * Case a, the page will be up to date when the page is unlocked.
> +	 *    There is no need to serialise on the page lock here as the page
> +	 *    is pinned so the lock gives no additional protection. Even if the
> +	 *    the page is truncated, the data is still valid if PageUptodate as
> +	 *    it's a race vs truncate race.
> +	 * Case b, the page will not be up to date
> +	 * Case c, the page may be truncated but in itself, the data may still
> +	 *    be valid after IO completes as it's a read vs truncate race. The
> +	 *    operation must restart if the page is not uptodate on unlock but
> +	 *    otherwise serialising on page lock to stabilise the mapping gives
> +	 *    no additional guarantees to the caller as the page lock is
> +	 *    released before return.
> +	 * Case d, similar to truncation. If reclaim holds the page lock, it
> +	 *    will be a race with remove_mapping that determines if the mapping
> +	 *    is valid on unlock but otherwise the data is valid and there is
> +	 *    no need to serialise with page lock.
> +	 *
> +	 * As the page lock gives no additional guarantee, we optimistically
> +	 * wait on the page to be unlocked and check if it's up to date and
> +	 * use the page if it is. Otherwise, the page lock is required to
> +	 * distinguish between the different cases. The motivation is that we
> +	 * avoid spurious serialisations and wakeups when multiple processes
> +	 * wait on the same page for IO to complete.
> +	 */
> +	wait_on_page_locked(page);
> +	if (PageUptodate(page))
> +		goto out;
> +
> +	/* Distinguish between all the cases under the safety of the lock */
>  	lock_page(page);
> +
> +	/* Case c or d, restart the operation */
>  	if (!page->mapping) {
>  		unlock_page(page);
>  		page_cache_release(page);
>  		goto repeat;
>  	}
> +
> +	/* Someone else locked and filled the page in a very small window */
>  	if (PageUptodate(page)) {
>  		unlock_page(page);
>  		goto out;
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
