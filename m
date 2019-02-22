Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D2BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B312070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zXesRFfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfBVTVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:21:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43065 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBVTVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:21:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id i8so2569527oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEh1PpN8MZdEODahk7HJYfWRejKVe1bP2E3naiVJUf8=;
        b=zXesRFfyjpqvIH8VP1xf1g80dCuBgVRRUkhCYDPpHLePIzmXKJ7sgzrOgJPsRIfRG6
         nJ/mxqOXn2qC/yBY+wf5StldKufB5l4Pt7OLHD3LdnAfMtrBYffP1jllN16rYAndqMpL
         /0bN/tGDiow85dPXI++3sBxvyiZ/sEZRUqBJb+cNowmwtTA6MWt8DB1zbChG8/2lLdr5
         MumJXC6d98+tU0xLk+xrqDwYrhIQuFYD7SChKWRCWIH82Qi/eE4ws3TL05qVCZzWa2cO
         4oETD5m1fGNc/AE1KaTFOMgDqajwXGsar3u56lNojHz21SzqbDI16F1VcopdbbwVGpEb
         Lw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEh1PpN8MZdEODahk7HJYfWRejKVe1bP2E3naiVJUf8=;
        b=NwQmBqjSMGp5FvqWYO/hSlxJ9dXW+0q1iC4soHwOu7aWsn220T4aBFms8TqhdK+eL2
         okvmd7jzlT3Eh6shYetqYR0LFxXzHFvN4iv6P7LEdoM6K2vyZ7zQCYUKnar8wncz5Ba1
         lYB78XpslJC6bn92u7PBjUd0H3MEjZd3P0mZpTNJaJhOkrjw4r/sdfCbvFla/e8Xa/lg
         cW69jsXy2x+P93boE1x16zWCO0TpZiUvrrRVL2nJ3VQxp/iryLCK0UMFAmRxEOganssb
         9X49UIj2Qq+B6D0ZdIZ+j9plTRHbn703s8dAjMKy4lPg6AELYToqKCTINqFlKhAl+LAm
         mbhA==
X-Gm-Message-State: AHQUAubrHSUvGQiNbAVYSDqdWq+MkiBODPV2CeGfX2gOnutjGpv5iFz/
        Zjh9Tq9rNBs9OfysrSOBMMIEYuakEN+bZ4s9LiPuoQ==
X-Google-Smtp-Source: AHgI3Iaw+mm3X+7iHZPF7QY6qOMX3Smk7WLYRYr2Q3MhrxIWq1RoC3N33E90+AHMtwL3PkXea/PKpphVypI1nVnlj7M=
X-Received: by 2002:aca:32c3:: with SMTP id y186mr3360644oiy.118.1550863309451;
 Fri, 22 Feb 2019 11:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com> <20190222184831.GF10237@localhost.localdomain>
In-Reply-To: <20190222184831.GF10237@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Feb 2019 11:21:37 -0800
Message-ID: <CAPcyv4jpP0CP-QxWDc_E1QwL736PLwh8ZPrnKJzVnYrAk++93g@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:48 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Wed, Feb 20, 2019 at 11:02:01PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 14, 2019 at 6:10 PM Keith Busch <keith.busch@intel.com> wrote:
> > >  config ACPI_HMAT
> > >         bool "ACPI Heterogeneous Memory Attribute Table Support"
> > >         depends on ACPI_NUMA
> > > +       select HMEM_REPORTING
> >
> > If you want to do this here, I'm not sure that defining HMEM_REPORTING
> > as a user-selectable option is a good idea.  In particular, I don't
> > really think that setting ACPI_HMAT without it makes a lot of sense.
> > Apart from this, the patch looks reasonable to me.
>
> I'm trying to implement based on the feedback, but I'm a little confused.
>
> As I have it at the moment, HMEM_REPORTING is not user-prompted, so
> another option needs to turn it on. I have ACPI_HMAT do that here.
>
> So when you say it's a bad idea to make HMEM_REPORTING user selectable,
> isn't it already not user selectable?
>
> If I do it the other way around, that's going to make HMEM_REPORTING
> complicated if a non-ACPI implementation wants to report HMEM
> properties.

Agree. If a platform supports these HMEM properties then they should
be reported. ACPI_HMAT is that opt-in for ACPI based platforms, and
other archs can do something similar. It's not clear that one would
ever want to opt-in to HMAT support and opt-out of reporting any of it
to userspace.
