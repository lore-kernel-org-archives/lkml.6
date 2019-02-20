Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513F1C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA9920859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PhmVANGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfBTWVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:21:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43108 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfBTWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:20:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so42962519ota.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYHmGSae92E6kyyzNFPvzSyptP9jjYpuFxHzK9ePRvA=;
        b=PhmVANGN9uxCFQvamQEsZzQyEDEeKKmsALmHaXY1uWKPkjBV6WDF1GHKhgmRPZiDke
         ss10F4tqpeTvXOgd7/x4gycVfztCap2Jn5xfoRZ0xgSSn+oUYK2/TWsl+eVcBml9a8cj
         mXi0wRnYTTNqXoYJKAtpbECOhxGmuJ6JCJAQmsp5my1hMDNSgFnMp12t8fXmx/hv97sQ
         OvUEdl1yUvzUL4xhCU/Zy9ZwQ/yFaHG16kucz3FiVr5xdOfNCxisU4zrvWoNiuklesb6
         qWyaqed/Akdfu80y7Jg1m/+PR23iTxspbkCxqREqk/eJcS1aziyzrYtjwDTLdQ107RiV
         dumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYHmGSae92E6kyyzNFPvzSyptP9jjYpuFxHzK9ePRvA=;
        b=Lpu3+SPADEt4Z2JNJUGXnzwqlQ19LMkr1aJCIBO8Udltr5y+UyyiInoSF435Qr/ODU
         GPwP18RDZPQnix248kfl5+hYnv970sVr0o2ffwT/IZAaykYYv32FgoY6QHswJ1SRLvN0
         p8XGA3roMyNe/cEl2mOUFTIHNhZ9FxFjzBkEvpwMnFc1Pr852TuIubfBFTgapZ+rtpsy
         nD4Q3ItbaJ4i3pJVFl4E+cqyq6Nu54WZ34TXXnYKwTpJ7gTxzgStgADnaUeLAfdzVsUb
         xKgwyiQhI/jjCsUTwiWV+JtYmICzh2CC0B+LGVi5G3jIVYXdxfB87Be45NZX99405VGR
         iO1g==
X-Gm-Message-State: AHQUAuaZgR+obJjabet9XuYFg9bwpAczRdikSi5wX42Yl666rGqq1jN/
        8nHwwpZFkSsQA86eOnzd7gYYgUV9i/Tly+eay7t8sQ==
X-Google-Smtp-Source: AHgI3Ia4KkP74uHBWXReoJuMyNqr85iF47p1Ij1i/ERE9QXCthX6/HpkumPtCQLmuidBS13nCSnPKArKkthePEG7S04=
X-Received: by 2002:aca:c3cb:: with SMTP id t194mr7146924oif.70.1550701258989;
 Wed, 20 Feb 2019 14:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com>
 <9ab5d6ba-4cb6-a6f1-894d-d79b77c8bc21@intel.com> <CAPcyv4iP032bqAgCZ8czRXkJ_gXz0H1EVC+ypf6NhKQ65aKczg@mail.gmail.com>
 <CAJZ5v0hwyXnsLmCKNJvzOvcG-HD1UmuWNGFvoB02=2Ks1hE0bA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hwyXnsLmCKNJvzOvcG-HD1UmuWNGFvoB02=2Ks1hE0bA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Feb 2019 14:20:48 -0800
Message-ID: <CAPcyv4iz4XYrHeQBR5f9W7T+0PcTvP0w70OsWuvbbChKtq0RUg@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 2:17 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 20, 2019 at 11:14 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Wed, Feb 20, 2019 at 2:11 PM Dave Hansen <dave.hansen@intel.com> wrote:
> > >
> > > On 2/20/19 2:02 PM, Rafael J. Wysocki wrote:
> > > >> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> > > >> index c9637e2e7514..08e972ead159 100644
> > > >> --- a/drivers/acpi/hmat/Kconfig
> > > >> +++ b/drivers/acpi/hmat/Kconfig
> > > >> @@ -2,6 +2,7 @@
> > > >>  config ACPI_HMAT
> > > >>         bool "ACPI Heterogeneous Memory Attribute Table Support"
> > > >>         depends on ACPI_NUMA
> > > >> +       select HMEM_REPORTING
> > > > If you want to do this here, I'm not sure that defining HMEM_REPORTING
> > > > as a user-selectable option is a good idea.  In particular, I don't
> > > > really think that setting ACPI_HMAT without it makes a lot of sense.
> > > > Apart from this, the patch looks reasonable to me.
> > >
> > > I guess the question is whether we would want to allow folks to consume
> > > the HMAT inside the kernel while not reporting it out via
> > > HMEM_REPORTING.  We have some in-kernel users of the HMAT lined up like
> > > mitigations for memory-side caches.
> > >
> > > It's certainly possible that folks would want to consume those
> > > mitigations without anything in sysfs.  They might not even want or need
> > > NUMA support itself, for instance.
> > >
> > > So, what should we do?
> > >
> > > config HMEM_REPORTING
> > >         bool # no user-visible prompt
> > >         default y if ACPI_HMAT
> > >
> > > So folks can override in their .config, but they don't see a prompt?
> >
> > I would add an "&& ACPI_NUMA" to that default as well.
>
> But ACPI_HMAT depends on ACPI_NUMA already, or am I missing anything?

Oh, my mistake, sorry.
