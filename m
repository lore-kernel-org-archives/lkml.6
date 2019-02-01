Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99729C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664BC21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbI6dwZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfBAKF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:05:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfBAKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:05:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so2712837pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 02:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2TzCYk2iasS2nlPfucWgzNH5eOiN+TG9wLNm9KmdNuo=;
        b=dbI6dwZugF+c/RMui/QMOdWjjX3z6EFFYnloOu32TotnnAsnDOnsYR0oxT1sL5o8jd
         f8zhxlRKopy5cflxJYRfTueXzW1hH0w2B8Tg59x/YcfF9yqDkNwW0NuXJZrpkMNREe0w
         9UQB0e4+0B2moHFuVlwMOxBAZLVKxxIWPdTaH2MUs+Ms5x1flzl2SLwnys3j5ApvAuS6
         0Y4X9aAUChDDlXGUgPn5tOzPfgWnatyKACxA22tuDeWpYMML8ncDAsrRp60EM4usX8If
         gQXnNcaHl4hycDWgub/1hBoglKHjRNtlrqbJKRxOHfkCjXJ7aQa+bUv4fDsDJRLgUqMH
         0hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2TzCYk2iasS2nlPfucWgzNH5eOiN+TG9wLNm9KmdNuo=;
        b=fP83ys930ik8vDnUynig5IF+QiDuzEKRatbj40AFNdnOkHhjBH7dHA6M4kACYXwMXh
         /fqVqAv+duvpmPjl2O2L2mU4sRriqnHaVlVejcOlO2mvV/KZm66zpc2l34oO3w8Jo8VA
         5RrswjRe3L7t6sXAMi1E5ud6lwFOOe6Pj3CxXzp4Td6xXs7OihyaI2dNxMguT390ivuw
         SZGwR37bwcICeYJlhneg9co1zh52pjCHBKHIXkoL7s6DMh8eaLcSnewE0evE4Bjfcf7S
         6UD0+ChUznKJgrw3d1iIvvThjH0Vn0ezQ/m1hCw81vERgEKu9pkWjwx7jIicE4iBxAzl
         8KoQ==
X-Gm-Message-State: AJcUukenBaI4sJ/Zbl788Nynn2AUrzyAMFCCoICrP20E5awLUqo3U+45
        qppGFM4U+GlNIylKKZnzF5PgmL5McTk5Uk+s4qI=
X-Google-Smtp-Source: ALg8bN51xa/5EQqXXcMgJkG1FQZScQ5bIqFfyrBuRla6ie5IsA9o9f8nAOFOIgQnoTz3IiZcsZGPkfLhs8WRFwHj1sc=
X-Received: by 2002:a63:d450:: with SMTP id i16mr34439744pgj.246.1549015524490;
 Fri, 01 Feb 2019 02:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20190124180328.76533-1-andriy.shevchenko@linux.intel.com> <20190201092545.GH783@dell>
In-Reply-To: <20190201092545.GH783@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Feb 2019 12:05:13 +0200
Message-ID: <CAHp75VdUuRCPLw4kVu5583TLm5E2otw3rPMQsiz6Bh_1o4NVig@mail.gmail.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Move linux/pm.h to the local header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 11:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 24 Jan 2019, Andy Shevchenko wrote:
>
> > We now using a common macro for PM operations in Intel LPSS driver,
> > and, since that macro relies on the definition and macro from linux/pm.=
h
> > header file, it's logical to include it directly in intel-lpss.h.
> > Otherwise it's a bit fragile and requires a proper ordering
> > of header inclusion in C files.
>
> I don't agree with this.  File which use various headers should
> explicitly include them.  Inheriting header files is non-optimal.
>

intel-lpss.h _is_ using pm.h.
I don't see a contradiction here.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/intel-lpss-acpi.c | 1 -
> >  drivers/mfd/intel-lpss-pci.c  | 1 -
> >  drivers/mfd/intel-lpss.h      | 2 ++
> >  3 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
With Best Regards,
Andy Shevchenko
