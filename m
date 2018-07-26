Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829E9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3679120891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bc9SvuRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3679120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeGZIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:08:49 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37410 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeGZIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:08:48 -0400
Received: by mail-yb0-f193.google.com with SMTP id r3-v6so250493ybo.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=87JFKFZbNJPGs1Ttelijo7vXA4cY151mWg2Clitw3SM=;
        b=Bc9SvuRmoDWCKom4hUB1LFrZwirG/2x+nHL0Wt/hW+pGmQeSyj5ZnOpqXgrKbgrYcI
         OmR4CsUmjEqz1mDxX2mNPyeMU9j63hgbxZx7Urt9HM31cw4nMlHnHWadBXRA9T607AgF
         ZhHmyNrL+9pbBimvSNW3Wh+USQtIjEyGZ1GGywIZ409+LfkEdNhjceDPvVxNrXp2sO/c
         2mWvJbTzxZBdFxWXudl9J+tPbq4Lw+8xjcYlXh3OFgwHEyp/Yp0Uzb1PYs+Cr3jC+O+D
         IteMJUjDSdYhmSYBJUBvoDVXL4ZuEJfYQDnbIvJvvT9U2VbXWTydrrSioitLrki2OCfa
         bXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=87JFKFZbNJPGs1Ttelijo7vXA4cY151mWg2Clitw3SM=;
        b=VXoNJ8l96u3hTLUWfdpju/MEqPeJY4PmGlW8b8BbYVS+Ym7FzzZIps2xplHz2hH1Vt
         Cv1nuol78IVBzQpVJFONJXLFt/SANg4y2IEYmKxZ/Mi3zX4kSg/bdSMMnA3reiNZQNZp
         CawVRuhXa2IsJDv6ptAZlxI4cizBjS4nBWc6Abv61u/PXKrAiDD9huVlDF2A6+zoGb7G
         2XTfOr/Kn6qsiUtnAC1I0RXtDRxwYj00vqo1rIKK0U5Q6Eyj5s2u3O0VsbXmuJjQIj+U
         bHGV3tkAEXcrMhyHHsgQhsPTtuhQtpL3eIbnt95+IeGRl60SFagnCwdC/du1AdLGkpjy
         Xqhw==
X-Gm-Message-State: AOUpUlEyilaYeHbeEQNGkh629kJUVpIDcrsERz5wl15w4a79YWxyqpXl
        iMuV9OR0s0X72vASx0liyE7Kow==
X-Google-Smtp-Source: AAOMgpeVak81JLcMPUgNJlx1e8prn5TPCPbTGoT27WhqM8SORH2rOZ2MvCWi5KGuuw0CdOXkGR7dmw==
X-Received: by 2002:a25:844f:: with SMTP id r15-v6mr324388ybm.345.1532588005315;
        Wed, 25 Jul 2018 23:53:25 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l62-v6sm241364ywb.29.2018.07.25.23.53.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jul 2018 23:53:24 -0700 (PDT)
Date:   Wed, 25 Jul 2018 23:53:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
In-Reply-To: <alpine.LSU.2.11.1807240121590.1105@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1807252334420.1212@eggly.anvils>
References: <000000000000d624c605705e9010@google.com> <20180709143610.GD2662@bombadil.infradead.org> <alpine.LSU.2.11.1807221856350.5536@eggly.anvils> <20180723140150.GA31843@bombadil.infradead.org> <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
 <20180723203628.GA18236@bombadil.infradead.org> <alpine.LSU.2.11.1807231531240.2545@eggly.anvils> <20180723225454.GC18236@bombadil.infradead.org> <alpine.LSU.2.11.1807240121590.1105@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Hugh Dickins wrote:
> On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> > On Mon, Jul 23, 2018 at 03:42:22PM -0700, Hugh Dickins wrote:
> > > On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> > > > I figured out a fix and pushed it to the 'ida' branch in
> > > > git://git.infradead.org/users/willy/linux-dax.git
> > > 
> > > Great, thanks a lot for sorting that out so quickly. But I've cloned
> > > the tree and don't see today's patch, so assume you've folded the fix
> > > into an existing commit? If possible, please append the diff of today's
> > > fix to this thread so that we can try it out. Or if that's difficult,
> > > please at least tell which files were modified, then I can probably
> > > work it out from the diff of those files against mmotm.
> > 
> > Sure!  It's just this:
> > 
> > diff --git a/lib/xarray.c b/lib/xarray.c
> > index 32a9c2a6a9e9..383c410997eb 100644
> > --- a/lib/xarray.c
> > +++ b/lib/xarray.c
> > @@ -660,6 +660,8 @@ void xas_create_range(struct xa_state *xas)
> >  	unsigned char sibs = xas->xa_sibs;
> >  
> >  	xas->xa_index |= ((sibs + 1) << shift) - 1;
> > +	if (!xas_top(xas->xa_node) && xas->xa_node->shift == xas->xa_shift)
> > +		xas->xa_offset |= sibs;
> >  	xas->xa_shift = 0;
> >  	xas->xa_sibs = 0;
> 
> Yes, that's a big improvement, the huge "cp" is now fine, thank you.
> 
> I've updated my xfstests tree, and tried that on mmotm with this patch.
> The few failures are exactly the same as on 4.18-rc6, whether mounting
> tmpfs as huge or not. But four of the tests, generic/{340,345,346,354}
> crash (oops) on 4.18-rc5-mm1 + your patch above, but pass on 4.18-rc6.

Now I've learnt that an oops on 0xffffffffffffffbe points to EEXIST,
not to EREMOTE, it's easy: patch below fixes those four xfstests
(and no doubt a similar oops I've seen occasionally under swapping
load): so gives clean xfstests runs for non-huge and huge tmpfs.

I can reproduce a kernel BUG at mm/khugepaged.c:1358! - that's the
VM_BUG_ON(index != xas.xa_index) in collapse_shmem() - but it will
take too long to describe how to reproduce that one, so I'm running
it past you just in case you have a quick idea on it, otherwise I'll
try harder. I did just try an xas_set(&xas, index) before the loop,
in case the xas_create_range(&xas) had interfered with initial state;
but if that made any difference at all, it only delayed the crash.

Hugh

--- mmotm/mm/shmem.c	2018-07-20 17:54:42.002805461 -0700
+++ linux/mm/shmem.c	2018-07-25 23:32:39.170892551 -0700
@@ -597,8 +597,10 @@ static int shmem_add_to_page_cache(struc
 		void *entry;
 		xas_lock_irq(&xas);
 		entry = xas_find_conflict(&xas);
-		if (entry != expected)
+		if (entry != expected) {
 			xas_set_err(&xas, -EEXIST);
+			goto unlock;
+		}
 		xas_create_range(&xas);
 		if (xas_error(&xas))
 			goto unlock;
