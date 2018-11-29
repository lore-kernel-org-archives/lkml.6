Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D48C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50472145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TryIH1kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50472145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeK3F5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:57:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40484 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeK3F5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:57:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so2750471oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNU4zFmf0REbjXQ0E7eND/wFj9YL0csfLAstiAxIlH8=;
        b=TryIH1kc1KlWt5Fh365iitsQYlRmZo2A9e55pKEcPDOop1iM2NijSwScJQ5qfecf6+
         Ke/mwuAkskWMXikuk/C981f9vyl/lMk7VbPOFpqQ5nVZIP3WKIXT5kxV6hq4OjedGdSh
         UqSiGFmJF8sHEaAYHY5F6m0lhkUi5DB/r7zbSi0wVsNYsH6F66b7wZZ6zFRS7ri00uFQ
         8oMBAMVh7vUxQCLD/dFAjZ3IxtasKuP0DTqeGQB0qyJAxNk0eNydk4ut/BAhuUok0W3+
         fVHBvG9n0eYwaccuu3cP6kc46/ZPcKpn1MKmH3O+EV9eWbX3dAN4gQP1+QSoYgxCNOSO
         mCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNU4zFmf0REbjXQ0E7eND/wFj9YL0csfLAstiAxIlH8=;
        b=bURiVlG7w0THTtb3cuMVv7GLOQgMl63T1gGBfiBt9pVOQHPHsVBp8lX5gnig/suwQM
         Y4n7ywzyy09oLLQSHJOFVjpHEU6NgGmKS6A0QuUc0I+uHs+TeQbrCjsGCeb/JEJRmxZx
         m7NARCZ5IGoLLquUvqA3rxJaEoF1JUwFvwWuC3gW0ftzPb+Qxg9QH62efLZyvLIPawHk
         QRVWhuNEG7nwqonANlZ5CD6PUNB/jwFKSAPHc+OQ3mYz3EElFJq5ReJ/P1EY0lvNpmfd
         SFarPV0Q8Prha82DigObQO0y6x9cWP5afFaK/lnPojdUCiqPzJ+gLbg9RdkaEiynhkXx
         He4Q==
X-Gm-Message-State: AA+aEWYO13zxfdKhL6kFDx2wmUMkq+T0IzVMhqY+Q3kg+umjneYu2tKl
        12+rGru2h9Nfmevw9C264fPL4xX7S5eNTBzrkuUKqg==
X-Google-Smtp-Source: AFSGD/UZBC0yw62GAqJIbQ4r2xJnawZvbaQmwrJ6E5oauBERCGOzlujSbr+K2nFasUc/siQWQbhlbv01SBxa42JRmqw=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr1700705otn.214.1543517478617;
 Thu, 29 Nov 2018 10:51:18 -0800 (PST)
MIME-Version: 1.0
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com>
 <6875ca04-a36a-89ae-825b-f629ab011d47@deltatee.com> <CAPcyv4i9QXsX9Rjz9E3gi643LQbSzaO_+iFLqLS+QO-GmrS0Eg@mail.gmail.com>
 <14d6413c-b002-c152-5016-7ed659c08c24@deltatee.com> <CAPcyv4gZisOAE8VJPJChNXrWv0NhUevWuutsPdvNORBTOBXJfA@mail.gmail.com>
 <43778343-6d43-eb43-0de0-3db6828902d0@deltatee.com>
In-Reply-To: <43778343-6d43-eb43-0de0-3db6828902d0@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Nov 2018 10:51:06 -0800
Message-ID: <CAPcyv4hJV71RLhBCKgqc=nQ_D_upySD=ZZk0y=5Qk69kKPHFog@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mm, devm_memremap_pages: Fix shutdown handling
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:51 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-29 10:30 a.m., Dan Williams wrote:
> > Oh! Yes, nice find. We need to wait for the percpu-ref to be dead and
> > all outstanding references dropped before we can proceed to
> > arch_remove_memory(), and I think this problem has been there since
> > day one because the final exit was always after devm_memremap_pages()
> > release which means arch_remove_memory() was always racing any final
> > put_page(). I'll take a look, it seems the arch_remove_pages() call
> > needs to be moved out-of-line to its own context and wait for the
> > final exit of the percpu-ref.
>
> Ok, well I thought moving the wait_for_completion() into the kill() call
> was a pretty good solution to this.

True, it is...

> Though, if we move the
> arch_remove_pages() into a different context, it *may* help with the
> problem below...

Glad to see my over-engineered proposal in this case might be good for
something...

>
> >> Though, now that I look at it, the current change in question will be
> >> wrong if there are two devm_memremap_pages_release()s to call. Both need
> >> to drop their references before we can wait_for_completion() ;(. I guess
> >> I need multiple percpu_refs or more complex changes to
> >> devm_memremap_pages_release().
> >
> > Can you just have a normal device-level kref for this case? On final
> > device-level kref_put then kill the percpu_ref? I guess the problem is
> > devm semantics where p2pdma only gets one callback on a driver
> > ->remove() event. I'm not sure how to support multiple references of
> > the same pages without creating a non-devm version of
> > devm_memremap_pages(). I'm not opposed to that, but afaiu I don't
> > think p2pdma is compatible with devm as long as it supports N>1:1
> > mappings of the same range.
>
> Hmm, no I think you misunderstood what I said. I'm saying I need to have
> exactly one percpu_ref per call to devm_memremap_pages() and this is
> doable, just slightly annoying. Right now I have one percpu_ref for
> multiple calls to devm_memremap_pages() which doesn't work with the
> above fix because there will always be a wait_for_completion() before
> the last references are dropped in this way:
>
> 1) First devm_memremap_pages_release() is called which drops it's
> reference and waits_for_completion().
>
> 2) The second devm_memremap_pages_release() needs to be called to drop
> it's reference, but can't seeing the first is waiting, and therefore the
> percpu_ref never goes to zero and the wait_for_completion() never returns.
>

Got it, let me see how bad moving arch_remove_memory() turns out,
sounds like a decent approach to coordinate multiple users of a single
ref.
