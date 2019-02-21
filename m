Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9724DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6082E2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbk7lNby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfBUNgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:36:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44368 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUNgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:36:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id c4so9165016pls.11;
        Thu, 21 Feb 2019 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TN/EGxLlvHPDZJhW6YNNCkRaz5cnU9nsLApM90KmxD8=;
        b=Lbk7lNbyUCKGFbH5jzaIiXnAwSmsSz39jUWCN8S6sa9cbCtG/xHoMLiD/Vu4OGsIIK
         MBNRMrnyMwU8GJuj5ZMwXZeUVV0GHdF20IDI+qTpMHfJ1csdsUp7ygheTFi7mCLqzUhy
         o5t+f9a8X3zIDgM4Lxz78eXwMtdZ8zrMnZdH2JTbUYCwWgNoMtTu8aUH6UZ6R4FcZsMa
         vZAYEWz3TLUzDo0IP8OTTvr86CxJxRJlq4Y5jfLrB9eQtEw5KNRm4UAZBSzNEgCeacGS
         WB7r2GlElnG+hFuQWXNAcBLEM6C7GXEV4cNzk56WpdaRYvMxrlqjk1lMvj+Z8Ygd3/hL
         yBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TN/EGxLlvHPDZJhW6YNNCkRaz5cnU9nsLApM90KmxD8=;
        b=sLfP5BgCy9djF8g/qvqVzHo3ALR6j+rMgdlj68DNvh2DAwMHX41qqmGClTupGX4pEP
         jEtBLd/E2UiHwIQPKABDGUvniq+moObx+k2xAaqOkdI5IVwWEdk+sbGJ9ok52XGxF8vL
         JH5SyHOn0sXoGjC+0kCZq3UPuy0D+iUEPYyshtZ2MI/Wob9IitClsJn/zucjnpCJIl+r
         OAc/Xp0OUaXXcbq6R1aBK/aSiFNZp1CTQUr65oaLAM8p2D+Z9sZPfJghGNrWQFp1v/NH
         B1NZkXn3zWW1u0piQBXI0EQD/qyKy7LaZvouQ4y0wC96WyeNhJ3pdmytAEBZrVJMBc3u
         0A4g==
X-Gm-Message-State: AHQUAuaMrqFJYFqGKksF60+G45lGkHQoSX9p8mAymeMGJiQj7jnUk9Ip
        pCWhWHE1oi6QpqLLJJXqfD7XRacp9FFzMUdHpM8=
X-Google-Smtp-Source: AHgI3IYhqAqZpj+gMRrzEs2Y+n87oBq9eLLs0tqV44kwqAJwYJZmrbk8QYAerC6IjBFWBHc4B+i79vbOIMpxA1WEuDw=
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr32315986plq.144.1550756173736;
 Thu, 21 Feb 2019 05:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20190207095703.564e76b2@canb.auug.org.au> <38152c55-c2c1-c89f-2751-0ef0d40fcba9@linux.intel.com>
 <CAHp75Vf6gs1342N16MZHvPmiiv3+xJyMyyJQK677KPZbb_7Vrg@mail.gmail.com>
 <e0c40627-f1a2-254f-14b0-b9df0d62dd34@linux.intel.com> <20190221004041.GA5838@wrath>
In-Reply-To: <20190221004041.GA5838@wrath>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 15:36:02 +0200
Message-ID: <CAHp75Vezu6Kbu2OxG90V43EpBWDnZQ5NJbvwhh7MzTd90hH4tQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the drivers-x86 tree
To:     Darren Hart <dvhart@infradead.org>
Cc:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 2:40 AM Darren Hart <dvhart@infradead.org> wrote:
> On Wed, Feb 13, 2019 at 08:45:56PM +0530, Bhardwaj, Rajneesh wrote:
> > On 07-Feb-19 9:25 PM, Andy Shevchenko wrote:
> > > On Thu, Feb 7, 2019 at 4:06 AM Bhardwaj, Rajneesh
> > > <rajneesh.bhardwaj@linux.intel.com> wrote:
> > > > On 07-Feb-19 4:27 AM, Stephen Rothwell wrote:

> > > > In commit
> > > >
> > > >    4284dc008f43 ("platform/x86: intel_pmc_core: Fix file permissions for ltr_show")
> > > >
> > > > Fixes tag
> > > >
> > > >    Fixes: 63cde0c16c67 ("platform/x86: intel_pmc_core: Show Latency Tolerance info")
> > > >
> > > > has these problem(s):
> > > >
> > > >    - Target SHA1 does not exist
> > > >
> > > > Did you mean:
> > > >
> > > >    2eb150558bb7 ("platform/x86: intel_pmc_core: Show Latency Tolerance info")
> > > >
> > > > Yes, upstream commit is 2eb150558bb79ee01c39b64c2868216c0be2904f. For some reason when i do git show on my repo with both these SHA1 i see the same patch.
> > > >
> > > > I will fix this in next version.
> > > Hmm... this came to our published branch, i.e. for-next, would it be
> > > better to update it via rebasing?
> > >
> > > Darren, what do you think?
> >
> > Hi Andy, I have corrected this in v2 anyway and i sent to upstream today,
> > just in case you prefer it over rebasing.
> >
> > https://patchwork.kernel.org/patch/10810123/
> >
>
> While we try hard not to rebase, if the choice is to rebase for-next or send a
> bad commit to upstream, I will opt for the rebase.
>
> Andy, I would suggest doing the rebase.

Okay, I do it right now then,

-- 
With Best Regards,
Andy Shevchenko
