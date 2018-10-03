Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BC1C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD8F2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pcMtSqHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD8F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJCPV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:21:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37017 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJCPV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:21:26 -0400
Received: by mail-it1-f196.google.com with SMTP id m9-v6so7678620ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hgOINVaMo1/mnHiF5wNaNhWpUaZ4OXX0HsbF0E72rCk=;
        b=pcMtSqHy/1Bjole4s4RbAquOrJbXWhA+TFdca/yXIwzF73SC6Jg/a4TCOqz/b2NKta
         xN55nHyAF5j8qFEzE0/3LP6HA9imn83O/QE6Lni26G8XH83uJaZcmJCKmsLeYaIGrH7v
         bOqIlnVALgTiFqaFJvKA8CURUWUrwRWUGyEHLnILvCz6CMv+jRSyrVFe5VQ0uFiX5KZ0
         lTl/91zymqKnH5iYBD+4qKCn4rIVCaqNPjJWziA8k8rbZ26z7L7PIocefd48l81wcbG+
         lLS5RJft6ALbRq2qLBY6EOfkFkGPP+rCiNiBpY+dUyF57/bo41vDx2n5PiKP8I2z560O
         ylKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hgOINVaMo1/mnHiF5wNaNhWpUaZ4OXX0HsbF0E72rCk=;
        b=gB+pQlzNUfP58luJcnQ3bkbxpV+sJUmGlcNXbwRYloOpDQyB+TId1BxqPX/RIy4eF6
         PPobuAsqaSoHF5EASpg5EBsEUQZ4u4NcEp/abcxuMnHyFhLFUSYuHNMt3l2+BJRMYkqC
         751h4KbzMU2S97A+CMtFZBYJLRrNkfY9HIRwCj2QduVSuvjwK4Dd0iJAm0mj1x14w6fL
         U75WKgr0owRaR96jC/e8+UjBzGB8nb17d3WlQS8M/C72dwezOvyNVQq/ydkmvCRuqK/b
         DdbJo3kS/YVIXZwa+JYxM9sahLZt72lVkuHvnx906aSyEfPXr56tPCTFHbtsIuPQ7NsV
         63aA==
X-Gm-Message-State: ABuFfojs1Qdj+sC19edO4t7r+GXFu6S+44AtdP+w0gikKmBjfCSPH92b
        dU+f5RwxHBNKcfmDHLmhANZ02S6kacC8zf1OD1iMOg==
X-Google-Smtp-Source: ACcGV63nFoeJHWUPcJWg50ESW2ub3qZRzBFU92FEUYPSQU+XP/geZUaRS8qnPlKo1oS9a1NYuZ3WLR51yrZR6ZDLrkI=
X-Received: by 2002:a24:6f05:: with SMTP id x5-v6mr518430itb.111.1538555643031;
 Wed, 03 Oct 2018 01:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180930202615.12951-1-brgl@bgdev.pl> <20181001160901.GY15943@smile.fi.intel.com>
In-Reply-To: <20181001160901.GY15943@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 3 Oct 2018 10:33:52 +0200
Message-ID: <CAMRc=MdMda1fhRZsB96MZd=XXd5otaik9zAnAE3qXWggqhweMA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] devres: provide and use devm_kstrdup_const()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 1 pa=C5=BA 2018 o 18:14 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Sun, Sep 30, 2018 at 10:26:11PM +0200, Bartosz Golaszewski wrote:
> > This series implements devm_kstrdup_const() together with some
> > prerequisite changes and uses it in tegra-hsp driver.
>
> Thanks!
> For the first three,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> >
> > v1 -> v2:
> > - fixed the changelog in the patch implementing devm_kstrdup_const()
> > - fixed the kernel doc
> > - moved is_kernel_rodata() to asm-generic/sections.h
> > - fixed constness
> >
> > v2 -> v3:
> > - rebased on top of 4.19-rc5 as there were some conflicts in the
> >   pmc-atom driver
> > - collected Reviewed-by tags
> >
> > v3 -> v4:
> > - Andy NAK'ed patch 4/4 so I added a different example
> > - collected more tags
> >
> > v4 -> v5:
> > - instead of providing devm_kfree_const(), make devm_kfree() check if
> >   given pointer is not in .rodata and act accordingly
> >
> > v5 -> v6:
> > - fixed the commit message in patch 2/4 (s/devm_kfree_const/devm_kfree/=
)
> > - collected even more tags
> >
> > Bartosz Golaszewski (4):
> >   devres: constify p in devm_kfree()
> >   mm: move is_kernel_rodata() to asm-generic/sections.h
> >   devres: provide devm_kstrdup_const()
> >   mailbox: tegra-hsp: use devm_kstrdup_const()
> >
> >  drivers/base/devres.c          | 36 +++++++++++++++++++++++++++--
> >  drivers/mailbox/tegra-hsp.c    | 41 ++++++++--------------------------
> >  include/asm-generic/sections.h | 14 ++++++++++++
> >  include/linux/device.h         |  4 +++-
> >  mm/util.c                      |  7 ------
> >  5 files changed, 60 insertions(+), 42 deletions(-)
> >
> > --
> > 2.18.0
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Greg,

I think that the three first patches of this series are ready to be
picked up. The last one can wait until the next release cycle. Out of
those three two are devres patches and one is mm. Do you think this
should go through your tree?

Best regards,
Bartosz Golaszewski
