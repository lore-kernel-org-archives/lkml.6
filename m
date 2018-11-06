Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8A3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3592083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3592083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbeKFXKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:10:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39885 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeKFXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:10:18 -0500
Received: by mail-qt1-f194.google.com with SMTP id g10-v6so2580917qtq.6;
        Tue, 06 Nov 2018 05:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOH/B72ksyrzmsnVMjLkumh97gaH1VEutKWWhjyRqIE=;
        b=UYr8lP3e31S2s1BaZpka+Jzj5odnwErVaqK6KWa205YKOS3vnFy8DXWBqnUiugaopI
         NbOhUr05eEYzlLiWYTax/+SSZjPzwPe7TFZ84NN7gI0jDxapti/YOg4ouPWGYqy1VOZq
         rVTxS2Na01NOnjJ++t58ctOuMRzE14D2uTqPRBnIe2bvreqAZL5xvcXoIV3F+/KAvbeY
         /ZU381pXEc4BqOkD8AhY6eLluU/P/TctrZm5QY9UXbNFNHCRjQ5OTUOtXEImLn8os+PP
         AY7R1J4LxKEcWtRHEVwPAApQXpK3dxIXyozZKGqwmenPMAlJErC0Cl5mwVds6iUJJLnS
         0+aw==
X-Gm-Message-State: AGRZ1gIyLpo6bqC6Sk54hucmP85yMQ+wUcHyXPqTOjZ8oppY27YqyhDM
        pSimAQX/OtWCICjOhWdnnIeHtEXbhFI1+evbyhk=
X-Google-Smtp-Source: AJdET5f1THi5XVh833Rn3rnuHnIKCk8Rdv80y5fdSyzs6gmK1kdeE70gYlWcbvgxVrTig8W4tuF/VC6l2ttp3qClvpA=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr24947325qtl.343.1541511898645;
 Tue, 06 Nov 2018 05:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20181102153232.1450251-1-arnd@arndb.de> <20181102161013.GG14602@zn.tnic>
 <20181102173959.GA27709@agluck-desk> <20181102234255.GE26770@zn.tnic>
In-Reply-To: <20181102234255.GE26770@zn.tnic>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Nov 2018 14:44:42 +0100
Message-ID: <CAK8P3a2yE8FGvpN0P8hXnyCpS4h-ZOHeYhSCjE+Ov=7s1TB=5g@mail.gmail.com>
Subject: Re: [PATCH] EDAC: skx_edac: add ACPI dependency
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 12:42 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 02, 2018 at 10:39:59AM -0700, Luck, Tony wrote:
> > On Fri, Nov 02, 2018 at 05:10:13PM +0100, Borislav Petkov wrote:
> > > On Fri, Nov 02, 2018 at 04:32:06PM +0100, Arnd Bergmann wrote:
> > > > We cannot currently select ACPI_ADXL without also enabling the top-level
> > I have to say that Arnd's fix is prettier. With it, we can go back
> > to
> >
> >       select ACPI_ADXL
> >
> > instead of
> >
> >       select ACPI_ADXL if ACPI
>
> Arnd's fix already has that last line in there:
>
>  config EDAC_SKX
>         tristate "Intel Skylake server Integrated MC"
> -       depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
> +       depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG && ACPI
>         depends on ACPI_NFIT || !ACPI_NFIT # if ACPI_NFIT=m, EDAC_SKX can't be y
>         select DMI
>         select ACPI_ADXL if ACPI
>         ^^^^^^^^^^^^^^^^^^^^^^^^
>
> so I'm reading this as *additionally* needed, ontop of the ugly fix.
>
> But let's wait until he clarifies first.

No, it was unintentional, the 'if ACPI' can be dropped when we add
'depends on ACPI'.

     Arnd
