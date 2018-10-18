Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ADEC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BFD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rzMt2cxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BFD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJSGgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:36:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34449 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSGgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:36:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id v2so24267460otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4hfxhH0UdUsEFua3vEOdHZ0Wd870wJbzFajCRMnYKw=;
        b=rzMt2cxxWaEr3r/fvU7FaBc9ohair7AEeUlgdCWV1wl49yiuPr7tTBXGt9qcxVaQmU
         62oLjA+P+wK4CvBI2dvxlPFdgE2s0Uaj3BzlTaIEhFQfkXGqTAKrzVNAx2Rt0IUTqaq8
         /NvDM1mOIlLcmk5meqEEbuPTCtOqnbLhZ83+86cR5ASX5/Cfc6bNzJWd3RvhQpAuqDSH
         Tt1e9dvySpMI/Z7FV9O4HCm19OSCTsmRHWSmXzAYQB7WWUZMWp9mxQA0t52XkkzYW4bD
         EU5wzQSOtH/ktX2QGgtOuLzEI52Ky6gDVRYeyUoAPFAN+dCwVemiQVfZxR6i1ZRlYmn7
         qPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4hfxhH0UdUsEFua3vEOdHZ0Wd870wJbzFajCRMnYKw=;
        b=stl0wNp4buxWs5/NtjIYkKTWS+Wfyv367y7qoLd0bEwn9lrbp3If+Qk7PzYm25QQxX
         OKmyM+OK2friUEAkR5YaF99UIJ+nWH1lsm6Kmzce5xdb7R4hLOhdEs0RsMcUPsaIB2UR
         K7jFv58/r8acwQUPcdh05QsLRKaaDSkERf9LORDSTf7bLaUqHJED8CsrmFutDB6zTryv
         P5yM7svDQcBUV28y0bgLPr14DY8WlA5DXxAbzTduawkmSExd1X75jfdYSWEm7vSAzzO0
         x5R5XeoKsQsIgipzkUZ50JWRR52UJ6/l/YUpZgNrTKxSySRYnlZxYZBlRJ1UxlIkPfNW
         u2dQ==
X-Gm-Message-State: ABuFfoi3Zipqm62LmXSrGWhn9MOz4AoVxQmUc9rtUYlz9K7+XXdLZNgE
        b+8dflQCks0du/PfMm3asUGL4EIqEsLcvV0tyWXNeA==
X-Google-Smtp-Source: ACcGV60LN6H5j818q40C1eU7yJCt7ADjV9piKe2HGmbMp71tJFCgRu3OpCdnfSuyU4EgsL7mshrNMAtCbr8FAqTNaZs=
X-Received: by 2002:a9d:24c7:: with SMTP id z65mr20135793ota.229.1539902009161;
 Thu, 18 Oct 2018 15:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
 <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
 <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com>
 <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com>
 <CAPcyv4hyZFRog8EBvhnO0bz3ryVNX=udupgnFUSZDgUBN23YWg@mail.gmail.com> <CAGXu5j+q4_+vQx8fcJgGUzne0PH33isZofkQ3YR6eL2kUO=Njg@mail.gmail.com>
In-Reply-To: <CAGXu5j+q4_+vQx8fcJgGUzne0PH33isZofkQ3YR6eL2kUO=Njg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Oct 2018 15:33:18 -0700
Message-ID: <CAPcyv4jYiEregTvHV83ogc19vWSd56T-OgwePxKD9n4ym-gr+A@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>, joel@joelfernandes.org,
        zwisler@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 18, 2018 at 3:23 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > On Thu, Oct 18, 2018 at 3:19 PM Kees Cook <keescook@chromium.org> wrote:
> >>
> >> On Thu, Oct 18, 2018 at 2:35 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >> > On Thu, Oct 18, 2018 at 1:31 PM Kees Cook <keescook@chromium.org> wrote:
> > [..]
> >> > I cringe at users picking addresses because someone is going to enable
> >> > ramoops on top of their persistent memory namespace and wonder why
> >> > their filesystem got clobbered. Should attempts to specify an explicit
> >> > ramoops range that intersects EfiPersistentMemory fail by default? The
> >> > memmap=ss!nn parameter has burned us many times with users picking the
> >> > wrong address, so I'd be inclined to hide this ramoops sharp edge from
> >> > them.
> >>
> >> Yeah, this is what I'm trying to solve. I'd like ramoops to find the
> >> address itself, but it has to do it really early, so if I can't have
> >> nvdimm handle it directly, will having regions already allocated with
> >> request_mem_region() "get along" with the rest of nvdimm?
> >
> > If the filesystem existed on the namespace before the user specified
> > the ramoops command line then ramoops will clobber the filesystem and
> > the user will only find out when mount later fails. All the kernel
> > will say is:
> >
> >     dev_warn(dev, "could not reserve region %pR\n", res);
> >
> > ...from the pmem driver, and then the only way to figure who the
> > conflict is with is to look at /proc/iomem, but the damage is already
> > likely done by that point.
>
> Yeah, bleh. Okay, well, let's just skip this for now, since ramoops
> doesn't do _anything_ with pmem now. No need to go crazy right from
> the start. Instead, let's make it work "normally", and if someone
> needs it for very early boot, they can manually enter the mem_address.
>
> How should I attach a ramoops_probe() call to pmem?

To me this looks like it would be a nvdimm glue driver whose entire
job is to attach to the namespace, fill out some
ramoops_platform_data, and then register a "ramoops" platform_device
for the ramoops driver to find.
