Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6038F21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORjvkQQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389834AbeLURCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:02:43 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36947 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389352AbeLURCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:02:42 -0500
Received: by mail-io1-f67.google.com with SMTP id r7so146449iog.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzQBByhyVxr6B7tP3LVzT6f1RBXwylr67AU8NIgZ0/8=;
        b=ORjvkQQSrOElg406Bv0bYKlXEk6/c78VOYwErxnwrulOAlXFj7fOYX/86EgnsgxgEj
         1coa+829qlrpqqVr0N2gFknNC/Id4AjZr/UhIJvYHB4fW1ks3XIpylWRa2PfREt2ZOU+
         NOLRyP2KdiMOYwacc4O+076jC5VHhO6r7wqq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzQBByhyVxr6B7tP3LVzT6f1RBXwylr67AU8NIgZ0/8=;
        b=brVOInCoBkBeDSZ9+oi2t1xTm93utodIN+UtTxh96KH4ETRlmq7EtYhyz2KnynS8nb
         tn1etP76d6djBcdyvHej3h8HhN04Kq1NGUaa76E61+KkaomYVJgPkdj3EPqrJMcXfGs0
         OdrIM721LzHNR1Rxjt62o3Cozlv1jwOTgUYRmfNLLwT7Lu5CskbcVjTtSc9aNnS+O7hS
         bziAOgay3BGh2V/GuDt8Gxyxdrpp464+ehEOHwQxsjo0KXgwHje89j8BZad5qJslYBJz
         VvqbpIaW4nhwrN3fxVBQdrDE5TCRE43eV9qfzS1DX80+hEsHxI+p69E2iNUCPXDaPZFV
         CP+g==
X-Gm-Message-State: AJcUukeOuZjWE175qTcAPJ2OVs0fewVzp/dZupfWwf5FWRFgUHSUmlID
        k/Lt0rnDyzuMh9lp25HWSWQCHJHlTjvvMnWAQ6FyCq+jae4=
X-Google-Smtp-Source: ALg8bN6NasHTHce9ZZy1dkczPUMWBFVH6EbD+z7T9/kPjnkW3eUsK2rVmfSMW2iZQn62PrRbuEnwqv29dgGSCQSdacY=
X-Received: by 2002:a5d:8417:: with SMTP id i23mr271981ion.173.1545411761597;
 Fri, 21 Dec 2018 09:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-6-ard.biesheuvel@linaro.org>
 <tip-08cfb38f3ef49cfd1bba11a00401451606477d80@git.kernel.org>
 <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com> <FFF73D592F13FD46B8700F0A279B802F486046A9@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F486046A9@ORSMSX114.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Dec 2018 18:02:29 +0100
Message-ID: <CAKv+Gu99VdPero0yrXiaByURyp1idYE948Qi4j1eqY0ENCrF5A@mail.gmail.com>
Subject: Re: [tip:efi/core] x86/efi: Unmap EFI boot services code/data regions
 from efi_pgd
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "bhsharma@redhat.com" <bhsharma@redhat.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joe@perches.com" <joe@perches.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "zhuyifei1999@gmail.com" <zhuyifei1999@gmail.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 at 20:48, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>
> > > > > Hi Thomas and Ingo,
> > > > >
> > > > > I recently noticed that the below commits [1] and [2] are broken
> > > > > when kernel command line argument "efi=old_map" is passed. Sorry!
> > > > > I missed to test this condition prior to sending these patches to mailing list.
> > > > > I am working on a fix and will send it to mailing list as soon as it's ready.
> > > > >
> > > >
> > > > Could you elaborate on the problem please?
> > >
> > > Sure! My bad..
> > >
> > > Little bit of history here:
> > > Boris with this patch set [1] introduced statically mapping EFI
> > > Runtime Services at -4G and also introduced "efi=old_map" to return to
> > > previous EFI functionality which used ioremap and __va(pa).
> > >
> > > [3] and [4] are links to old_map_region()
> > >
> > > The commit 08cfb38f3ef4 ("x86/efi: Unmap EFI boot services code/data
> > > regions from efi_pgd"), unmaps EFI boot services code/data regions
> > > *only* from efi_pgd but efi=old_map maps EFI boot services code/data
> > > regions into swapper_pgd. Also, efi=old_map  uses either
> > > ioremap() or __va(md->phys_addr) to map EFI runtime/boot time services and
> > doesn't use kernel_map_pages_in_pgd().
> > >
> > > So, we need a different unmapping routine to unmap EFI boot services
> > > code/data regions from swapper_pgd if they were mapped using efi=old_map.
> > >
> >
> > For the short term, could we simply make your changes dependent on efi !=
> > old_map? That gives us some time to fix the old_map case properly.
>
> Yes, I think we could and it should work but I hesitated to propose it because
> (as you already noted) it's a short term fix and not the right fix.
>

What is the status here?

> Alternatively, we could also evaluate if we need to support efi=old_map case going further.
> I thought dropping it would be a bad idea because it changes kernel user visible interface
> (because it's a kernel command line argument) and never brought it up.
> Not sure what Thomas, Ingo or Linus might think about dropping a kernel command line
> argument.
>

Dropping a command line argument is not a problem in itself, unless
anyone is actively using it :-)

As far as I can tell, the SGI x86 UV platforms still rely on this, so
we're stuck with it for the foreseeable future.

This means we need a fixes that makes your unmapping code conditional
on !old_memmap. Do you have an ETA for that?
