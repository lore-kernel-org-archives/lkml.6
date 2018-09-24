Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0158ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABD5208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDoKLSTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABD5208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeIXNyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:54:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41032 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIXNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:54:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so17317244ljy.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WP9LVPyGV6NgowDqPwPSShx19l4S/pVujq/Vyfho1WE=;
        b=cDoKLSTvlsTOumFwDRQ2gPaCbgr2iqLdVOszRBw5+nzA8sHL5RLoWXhfi2qgTE38Wa
         il0MFRvcrZKyTcjGyal5nCXeoAeAH3Yza0EAX7bmUZP1mMcSjvLNTaOjvTAv1ngCAbuL
         BD+4JkMv8URSlRtjhgYH0RwbQquv6Pp/x3M9HNBQRUVnr0bgbQBWWGd9jUc6xDxW/1Np
         EigiDK7PSC/aiIb9xlK2ty3ElXuAjZ05UjybkrPH3UH94fV5Y1fGrSRGhykRye37fJUg
         mZB7TANwmddTkKHkkuQenu5NBy5INmDW1aZF555rnvE/kUSiPNUn6jWDeCaPSEQbtNHb
         px1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WP9LVPyGV6NgowDqPwPSShx19l4S/pVujq/Vyfho1WE=;
        b=NBkqfiWiUJmEbbS5zC4VV6dquj0rg+DtkgqC6qGkJA2mSiA6dyOfHC4VjImkaEj0/F
         VK8GuOOGpPx/QMVNv4Vzz1sGHu5I/mbdAnGgBjFZPPzgSLiDFcms1EkfdRXvd6fAAEik
         45LIAv4oRaATISwuKem1BYJOp4zkHqOf30LGuze1ezzlTuP8c1AHXKLR0xDBkiftLsZc
         8Ef1jo1Z1+MTU4N4CWBOMnSAiLTRVgbJNX/HQy3wQK6PinmqWCG2r2MWlipuVSkDjHPu
         kphOXFn8wxXxfaSS4Iq+4d8UpnwSMArPKRNppB9qSEraZCG8RYDUoP0ya0aC3wwFB0gr
         zeiQ==
X-Gm-Message-State: ABuFfogLg7mnJXajUacn1zD16Wdzs53021sMugdwo1sqzLkoI1Z4os+2
        yk/Zz02+Oq3mUr7RkEQCdKmlaAdCPlv2BVTnkRu3BWXB
X-Google-Smtp-Source: ANB0VdbKC7C0VdBOPuLdmTwHtZigGhPK3AZ6pFMe6DfMGx66hatPT3lbPmFOS0bxYxfxdRTYvzchdbla9ptA73BGPFE=
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr9558980ljj.103.1537775597402;
 Mon, 24 Sep 2018 00:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180920191254.GA22764@jordon-HP-15-Notebook-PC> <20180922142241.GD14042@bombadil.infradead.org>
In-Reply-To: <20180922142241.GD14042@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 24 Sep 2018 13:23:05 +0530
Message-ID: <CAFqt6za2iZDwoemUBSGb0BUnWffOH4Ek5hpEbmFMepw655QfNA@mail.gmail.com>
Subject: Re: [PATCH] kernel/kcov: Replace vm_insert_page with vmf_insert_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, aryabinin@virtuozzo.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>, tchibo@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 7:52 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 21, 2018 at 12:42:54AM +0530, Souptick Joarder wrote:
> >               for (off = 0; off < size; off += PAGE_SIZE) {
> >                       page = vmalloc_to_page(kcov->area + off);
> > -                     if (vm_insert_page(vma, vma->vm_start + off, page))
> > -                             WARN_ONCE(1, "vm_insert_page() failed");
> > +                     if (vmf_insert_page(vma, vma->vm_start + off, page)
> > +                                     != VM_FAULT_NOPAGE)
> > +                             WARN_ONCE(1, "vmf_insert_page() failed");
> >               }
>
> I think this is the wrong approach (as well as being buggy).
>
> We should have a vmalloc_insert_range() _or something similar_ that
> replaces this entire loop.  That makes each _user_ simpler.  What you're
> trying to do right now makes each user more complex, and that's the
> wrong approach.

There are two different opinions here.

Andrey mentioned, to use vmf_insert_page() in fault handlers context and
not to remove vm_insert_page in his review comments.

And your opinion is to have vmalloc_insert_range() _or something similar_
that will replace whole loop. with this vm_insert_page will be removed.

Which one is better to go with ??
