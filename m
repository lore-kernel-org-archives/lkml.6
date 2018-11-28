Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D47C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE88321019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ9M9+DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE88321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeK2KEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:04:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55672 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeK2KEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:04:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so328729wmc.5;
        Wed, 28 Nov 2018 15:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Nahj6ebtsgINE1zUrkx6+6FmVwTfDGZppWC3wJOctU=;
        b=EJ9M9+DD1KrtvGDJihxMDy4X2w05Umm98sByIvHlY69/PRFIHOtFW19oZVbBm+qQzc
         z2M0QyvUyGjUzaPDG7fsYJ3Z/Wp5JOI7UiW3o/N1r8Xv8Nmgm3B5072Qjj6XlEWf0xoV
         eSENthH8t2hMsSnq5atW//Gt8Fn1f9OQlyB5982dKm7rcwUpouX/Vt+qPTFKsUo+4/Zb
         dz5tJNKl0lqEQj7hwqJx5hzdg10LY8PQIiueNBk8rcNqRmIrclsUz90QefiPUXC/aZc3
         SUxO3sOsZadfWTBh9GnLNz0zm5ly/V627jvdhtQaubblw9MKkEAkgjT2+iP57ZTzzFcQ
         IEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Nahj6ebtsgINE1zUrkx6+6FmVwTfDGZppWC3wJOctU=;
        b=XY0KeZun3Vw71bQlHGARWjgtc8dOSCr9aWQeq2homE3NzC9CIX4dVR14h2APKOnwUr
         aO9NkgOzmwU8OBPErYhST29LdDeyXT2YIC3mnrPLfTIXTuJbJC7ZbiDi07NtQ0mWdzaC
         90lJ9RY9UA2/HCMsp2p07dBEKlIga4mf72moxVg4oPRPbOUJ4lEp4cZe3Z67a3/ff++l
         +DiZKL6AIG0KmE288BzXkySLlb0pAb/Y3RicEqdVHfCp5WhcyLeuw+fTmloTQP0cJjdR
         wvXfURosPzQ+Af9YNnBUnKB78jYvCPHFIIRAd4c2cFgNEa0xLniR9le9YtTnSu0MO13V
         Z1pw==
X-Gm-Message-State: AA+aEWYu44p46BH63H6JAIi9akJy0rEUiVhgqnEPU0OX1L1tRWEgOp+Q
        YUG/7g+nGIYBQt+I4lvqLvmlee6RNLl6/mtcFs8=
X-Google-Smtp-Source: AFSGD/WOnbQL4c2v8EoNK1PxnYQ9Yp8uC+vQmSgtt16ZO6a/Dm4+EOUr4WlZyw2A2EBvEYfbA1jYkQ1oN4IALyE9j94=
X-Received: by 2002:a1c:860b:: with SMTP id i11mr4646186wmd.5.1543446082350;
 Wed, 28 Nov 2018 15:01:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk> <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
 <20181128.112717.149234960284639699.davem@davemloft.net> <20181128194708.GP30658@n2100.armlinux.org.uk>
In-Reply-To: <20181128194708.GP30658@n2100.armlinux.org.uk>
From:   Shuah Khan <shuahkhan@gmail.com>
Date:   Wed, 28 Nov 2018 16:01:10 -0700
Message-ID: <CAKocOOO2jELMaVh85m3V562ewCBDRUMJ1q_xoq7DgvUiagpTjQ@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
To:     linux@armlinux.org.uk
Cc:     David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>, hch@lst.de,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, robin.murphy@arm.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        linux-alpha@vger.kernel.org, xen-devel@lists.xenproject.org,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
        Shuah Khan <shuahkhan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:48 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Wed, Nov 28, 2018 at 11:27:17AM -0800, David Miller wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Date: Wed, 28 Nov 2018 10:00:06 -0800
> >
> > > Not all memory is accessible even to the kernel. If you have memory
> > > that shows up in the last page of phys_addr_t, you just mark it
> > > reserved at boot-time.
> >
> > It's not the physical memory at the end that needs to be reserved.
> >
> > It's the IOMMU mapping arena.
>
> True, if and only if you have an IOMMU.
>
> Where there isn't an IOMMU, then we'd have to reserve every page that
> that translates to a bus address in the top 4K of dma_addr_t on any
> bus in the system - that means knowing early in the kernel
> initialisation about all buses in the system so we can detect and
> reserve these pages.
>

The arch and platform differences/confusion as to "what is DMA error
value" is the reason why dma_mapping_error is part dma ops. I
understand that iy would make sense to reduce the overhead of an
additional call, however, I am not sure if would be trivial change to
address this.

I was down this path of trying to address the missing mapping error
checks a few years ago and introduced dma_mapping_error checks in the
DMA DEBUG API. As you might already know that there is no common
definition for the mapping error.

Quick look at the defines shows:

#define CALGARY_MAPPING_ERROR 0
#define S390_MAPPING_ERROR  (~(dma_addr_t) 0x0)
#define SPARC_MAPPING_ERROR (~(dma_addr_t)0x0)

This is the reason why there is a arch or in some cases bus specific
mapping_error ops is needed.
We could unify this and fix all these first. I haven't looked at the
patch set closely, maybe you are already doing this.

thanks,
-- Shuah
