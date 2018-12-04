Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1500EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51A72146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yMHQWIfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51A72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLDDd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:33:56 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46146 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDDd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:33:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so13004851oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NQOYfu0gso17ENW2tOFxX2Qb2a1xkVETAFlxtlKLcw=;
        b=yMHQWIfb72r3cv2AzFYAg1hl2xJGWIG2m++5H6qUQbxu/WbwmSZjWFwv5AFxxryJZ0
         U/ptCk9oZy6fmo281HS7kTmTWcTNf9/y6ElxX00oyISyic3y2W9TXLx6ADu4QJjnYHSr
         HkDIEZKPoYnOZOKPDWKDb/lMxUaM4xwwwdv2KLIZRoO8ROESf7RWaSLeoWd6+pOH76mn
         l9Gx7AJZEX/eeXHFitTgW3IXBZrkBVQhiThGpNzN9YbNF1ZJUXUadiFyJOwSuIGvNX4l
         SB0u5Xy2WKskaJ4XL/2nqNum1EqgaW8AL9ltRIqVCl4ZFwjHmTrma360vj4RDobvFFnO
         r2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NQOYfu0gso17ENW2tOFxX2Qb2a1xkVETAFlxtlKLcw=;
        b=dLHmrI9zuNzNj8jou4jLapSE2utrfDm+NqoPW0v0cqdLt6EtDvj8cod3IyVxlYQ3ra
         FB653kkaepZIhe7hX8aNolbM6x2Q+s8DjVe7oxxUj3PogjLm6+L/1IuKgOgapCTqQg/v
         VZqEKW+SrAYYi26Ntw3gAfEQHzDTKdwxX9YWcxc3ChHtATlMVXID8PRDbJcpmDAnHgg8
         dPMCeG2/wKkjXFO95L3GVSUywJJRGkcQBoRkBCYJUa7S0WNrpRvTAD0nfqr/r71xo00S
         lqxhjajwcASH4jJEmX9DIfg+OaZMgh/p2SClZYd/TjGx7C0Q6BzDvA3YIUvLc/C5GJOl
         aFqQ==
X-Gm-Message-State: AA+aEWbkyLFUB7jZ5WWp5g0h4LGlshM+rHD9ZcKvWm+7Veti6zr2BL3L
        /P0BF3AU8OHrc43ws8hTICG3YgSmWN+QZqlLRINFJA==
X-Google-Smtp-Source: AFSGD/UFAaoougO9Y9pJeOcPMFne/uY73ffBVxiWxsSqqyW3P3BgjoF3fwarI+P43IS4eFERVWtqV2BiVfiTps94mo8=
X-Received: by 2002:aca:d946:: with SMTP id q67mr4502019oig.0.1543894435141;
 Mon, 03 Dec 2018 19:33:55 -0800 (PST)
MIME-Version: 1.0
References: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181130154902.GL10377@bombadil.infradead.org> <CAPcyv4iE375mP7eJP4nb76shWNaATy6FcZYi800wZ3iAJE8G8g@mail.gmail.com>
 <20181130162435.GM10377@bombadil.infradead.org> <CAPcyv4gBwtCxN4xTncsyShMwMzNiLG3SxKA-frYh9Fn-f6QV=g@mail.gmail.com>
 <CAPcyv4gDO7sUJgE5kKe=VC5uUG36QaUrkb6tCrtnaFMkgdSYGw@mail.gmail.com>
 <20181130195021.GN10377@bombadil.infradead.org> <CAPcyv4iqA84WbE8pE=Yi15Q0T8JUXnPZss27HqhQTP08F9sTrQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iqA84WbE8pE=Yi15Q0T8JUXnPZss27HqhQTP08F9sTrQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 3 Dec 2018 19:33:43 -0800
Message-ID: <CAPcyv4jFwpsiMTwj3tzbQ4NjV_XnO5-2hTqKYOaWtRCGtT=T+g@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix Xarray conversion of dax_unlock_mapping_entry()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:05 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Nov 30, 2018 at 11:50 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Nov 30, 2018 at 09:01:07AM -0800, Dan Williams wrote:
> > > On Fri, Nov 30, 2018 at 8:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > On Fri, Nov 30, 2018 at 8:24 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Fri, Nov 30, 2018 at 07:54:49AM -0800, Dan Williams wrote:
> > > > > > Looks good to me, although can we make that cookie an actual type? I
> > > > > > think it's mostly ok to pass around (void *) for 'entry' inside of
> > > > > > fs/dax.c, but once an entry leaves that file I'd like it to have an
> > > > > > explicit type to catch people that might accidentally pass a (struct
> > > > > > page *) to the unlock routine.
> > > > >
> > > > > That's a really good idea.  Something like this?
> > > > >
> > > > > typedef struct {
> > > > >         void *v;
> > > > > } dax_entry_t;
> > > >
> > > > Yes, please.
> >
> > Oh.  The caller needs to interpret it to see if the entry was successfully
> > locked, so it needs to be an integer type (or we need a comparison
> > function ... bleh).
> >
> > > > > I could see us making good use of that within dax.c.
> > >
> > > I'm now thinking that this is a nice improvement for 4.21. For 4.20-rc
> > > lets do the localized fix.
> >
> > I think both patches are equally risky.  I admit this patch crosses a
> > file boundary, but the other patch changes dax_make_entry() which is
> > used by several functions which aren't part of this path, whereas this
> > patch only changes functions used in the path which is known to be buggy.
>
> I'm almost buying this argument... but I'd feel better knowing that
> all dax_make_entry() usages are safe against this bug pattern. I
> didn't audit the other occurrences of dax_make_entry() for this bug,
> did you build some confidence here?
>
> >
> > This patch has the advantage of getting us closer to where we want to be
> > sooner.
>
> One comment below...
>
> >
> >
> > From 1135b8d08f23ab4f5b28261535a817f3de9297c9 Mon Sep 17 00:00:00 2001
> > From: Matthew Wilcox <willy@infradead.org>
> > Date: Fri, 30 Nov 2018 11:05:06 -0500
> > Subject: [PATCH] dax: Change lock/unlock API
> >
> > Return the unlock cookie from dax_lock_mapping_entry() and
> > pass it to dax_unlock_mapping_entry().  This fixes a bug where
> > dax_unlock_mapping_entry() was assuming that the page was PMD-aligned
> > if the entry was a PMD entry.
> >
> > Debugged-by: Dan Williams <dan.j.williams@intel.com>
> > Fixes: 9f32d221301c ("dax: Convert dax_lock_mapping_entry to XArray")
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  fs/dax.c            | 21 ++++++++-------------
> >  include/linux/dax.h | 15 +++++++++------
> >  mm/memory-failure.c |  6 ++++--
> >  3 files changed, 21 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 9bcce89ea18e..d2c04e802978 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -351,20 +351,20 @@ static struct page *dax_busy_page(void *entry)
> >   * @page: The page whose entry we want to lock
> >   *
> >   * Context: Process context.
> > - * Return: %true if the entry was locked or does not need to be locked.
> > + * Return: A cookie to pass to dax_unlock_mapping_entry() or 0 if the
> > + * entry could not be locked.
> >   */
> > -bool dax_lock_mapping_entry(struct page *page)
> > +dax_entry_t dax_lock_mapping_entry(struct page *page)
> >  {
> >         XA_STATE(xas, NULL, 0);
> >         void *entry;
> > -       bool locked;
> >
> >         /* Ensure page->mapping isn't freed while we look at it */
> >         rcu_read_lock();
> >         for (;;) {
> >                 struct address_space *mapping = READ_ONCE(page->mapping);
> >
> > -               locked = false;
> > +               entry = NULL;
> >                 if (!dax_mapping(mapping))
> >                         break;
> >
> > @@ -375,7 +375,7 @@ bool dax_lock_mapping_entry(struct page *page)
> >                  * otherwise we would not have a valid pfn_to_page()
> >                  * translation.
> >                  */
> > -               locked = true;
> > +               entry = (void *)~0UL;
> >                 if (S_ISCHR(mapping->host->i_mode))
> >                         break;
> >
> > @@ -400,23 +400,18 @@ bool dax_lock_mapping_entry(struct page *page)
> >                 break;
> >         }
> >         rcu_read_unlock();
> > -       return locked;
> > +       return (dax_entry_t)entry;
> >  }
> >
> > -void dax_unlock_mapping_entry(struct page *page)
> > +void dax_unlock_mapping_entry(struct page *page, dax_entry_t entry)
>
> Let's not require the page to be passed back, it can be derived:
>
>     page = pfn_to_page(dax_to_pfn((void*) entry));
>
> A bit more symmetric that way and canonical with other locking schemes
> that return a cookie.

The patch does not apply on top of the pending fixes. could resend on
top of the current libnvdimm-fixes branch [1]?

I think because we are changing the calling convention to take return
a locked dax_entry_t type, I feel like we should go back to the
originally proposed names of these interfaces. I.e.

    dax_entry_t dax_lock_page(struct page *page)

    void dax_unlock_page(dax_entry_t entry)

Yes, it introduces an entry-to-pfn and pfn-to-page conversion.
However, If I can't convince you to drop the page argument, lets at
least do the name change. I.e. offload the responsibility of conveying
that this is not the traditional page lock to the fact that a
dax_entry is returned and passed back to the unlock routine.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=libnvdimm-fixes
