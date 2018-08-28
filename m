Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A476A20880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2M/bn5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A476A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeH1U4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:56:09 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41255 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH1U4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:56:09 -0400
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so2515189qtc.8;
        Tue, 28 Aug 2018 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ys7wvYaSXuwi7sUXLIGNM2d8k5hkjFf+MKWgy5jUKRk=;
        b=n2M/bn5zd6sCujSSaVVp3om/4QVcTPPBqXWGdN0BGN3WihLSj77KcUrarzPzTjKtCy
         sUhpUeWClaJ5lhDBqVZ2mtlVO/icf9IJ/d3E85Sk02e2zdNVeXvqfIC4L47LjmLCSZ8l
         6uJ/3BcPSLYoyVinByp723Zv50+r5AO6OkKPDdK+PIh1x+0VNR/fIjzvBlC0/LoOUlc+
         4hQ/U0Nv5lUdxJNQJyEcyv0QHHoq5RzhX90AK8fPUyg9DhTXaKToZpEYrOW265bLLKMy
         cy96MZcOxQ1XI6zvCze04kLsF9fLEFFNYuvD+H7vrkjH/TsgnR47DYBkICtfBvhDAMmB
         t5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ys7wvYaSXuwi7sUXLIGNM2d8k5hkjFf+MKWgy5jUKRk=;
        b=ee4Ss9NxBZOOOCZqOLw7ESa2OS+UERSpi0KtgPdNr+TyFOjKJ6DlR+3i6oY+PnUwFW
         R75tToc6THl2N4lEqhSXBLXoAGbKKGlsZTSf6ukC+Al8UeZx+I3ZC7CrQgxNcqWdAg6G
         AvF4hMLeDlL1zskj+yECDxPoz6w/ONghV2sXArDTPvL/aj/S760OvPbd0zU2jxnFpefj
         IIO1yqgX8t+Rvvv+CpyiQYpa8b6Ye1bBISuEsnie1Fh9cZkRmKUWHgqfLvwjoQzun11s
         6AYkH+KDzCUK7mnSndEATmZeQ57BCrnhlpqcwdCp8ajFVuwiw+D2yii9QFX8Ib1Cgu5Y
         9XnA==
X-Gm-Message-State: APzg51BZymSMDTd7ANcpCbb9wDCklxWUrl7CCE0XJv/rPgrW81mxnVDd
        Q8vu6ML/PmJrepM0i0T1A72INs5xf/fsE6cgasaNG9cSh88=
X-Google-Smtp-Source: ANB0Vda4hcLmuksdzaB9iK9jjKcAJsUjfAgAyh4Ns47qN3LfJoYDBDWq1b+JKVcH1SXPmyygoy2uRCvwYD81Fm8Ff/o=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr2496755qvc.180.1535475814958;
 Tue, 28 Aug 2018 10:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180828142421.15335-1-semen.protsenko@linaro.org> <20180828142421.15335-2-semen.protsenko@linaro.org>
In-Reply-To: <20180828142421.15335-2-semen.protsenko@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Aug 2018 20:03:23 +0300
Message-ID: <CAHp75VdiRH_J8QUALDNufdWh0eNnKsTmp5q+RGBassFdMcpEmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] codafs: Fix build using bare-metal toolchain
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu, jaharkes@cs.cmu.edu,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>, paul.sokolovsky@linaro.org,
        mszeredi@suse.cz, sumit.semwal@linaro.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:24 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> The kernel is self-contained project and can be built with bare-metal
> toolchain. But bare-metal toolchain doesn't define u_quad_t type.
> Because of this codafs build fails when building with bare-metal
> toolchain. This patch fixes it by defining u_quad_t type in case when
> non-Linux toolchain is used.

>  #endif /* !KERNEL */

I'm wondering what the heck KERNEL is doing in UAPI header.
Looks like this header is split wrongly in the first place.

> +#if defined(__KERNEL__) && !defined(__linux__) && !defined(_UQUAD_T_) && \

P.S. Actually it's the only header which uses KERNEL in UAPI.
Definitely it should be fixed first.

--
With Best Regards,
Andy Shevchenko
