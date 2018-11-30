Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AB3C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEFD2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxaG7REd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEFD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeK3TlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:41:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36891 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeK3TlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:41:06 -0500
Received: by mail-io1-f66.google.com with SMTP id a3so3878627ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r68YudjTX+QT/Z4NwslzSVIIx5SWv9dmy0zXK1Qcio0=;
        b=cxaG7REd4FiBAx2TIL2zQUcq2QBaja9h0nxOHtHsGWoDlke6ADcjTwRm6v4sgfVwcQ
         l1uE0+87ncRfz/1rCbEHRyVP8ZZjTNcSa5gQpEKT2rk4oK6VpXbeuPBW8x6FP+c8cGmA
         9CL5p9+MxQFcJ/n87l+Rc0xvMUM0YrqqUF5Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r68YudjTX+QT/Z4NwslzSVIIx5SWv9dmy0zXK1Qcio0=;
        b=QtaOJ7mcTpXwur0dfPqUlEEDLE1bkspA4bouYrLbD7z7Ks/Y4VKdsekLbSvfSjsqZx
         C7Vnggz0jLjral6ONdsNckyqgY80qmpsQwSwqCr7mATbOs0K9eCTxTzRyAHYg6eRqIRR
         DgjzsMgz0XyVPGqxNJJvVvUnB0b4CA3ongV6qjjeP5/EZeQGFggQyZf+B82H76s8oYA6
         jj7eOzRz/Js2a8BgVsXowqeHNsB3syBTMASk5pUcKdsnNdavs9nLroSK/awad0uT0GzR
         wPQEcjaNqT9FUD/DDVu9GMUhWWgcoVHXLmBASJX40mpxUGECp2QVN+IgoEfxuc2N62ta
         CEhA==
X-Gm-Message-State: AA+aEWYGmvT4N9HePSoXAfACjY9PJ0FzAYqxjlnSwdSF/ltPVW5vhaRZ
        gqu5VyVvQVPEuugy7sZ0GfWB9yciPctn6ci8981u5w==
X-Google-Smtp-Source: AFSGD/VZDcv05yV9Q/mKNFDkRQfBedCSgSL4xNW7daX/s2FX+9m7ZCps9bHLwzcQ8oiM9ygPYL/aMeeOXwcZz+oAVtc=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr3730327iob.170.1543566754303;
 Fri, 30 Nov 2018 00:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-12-ard.biesheuvel@linaro.org> <20181130080544.GC16084@gmail.com>
In-Reply-To: <20181130080544.GC16084@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 30 Nov 2018 09:32:23 +0100
Message-ID: <CAKv+Gu9yiqDcJ-QVDYvW7rKLX0TySeZS6BxzD=aYMAqxg_0z=g@mail.gmail.com>
Subject: Re: [PATCH 11/11] efi/x86: earlyprintk - Fix infinite loop on some
 screen widths
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 09:05, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > From: YiFei Zhu <zhuyifei1999@gmail.com>
> >
> > An affected screen resolution is 1366 x 768, which width is not
> > divisible by 8, the default font width. On such screens, when longer
> > lines are earlyprintk'ed, overflow-to-next-line can never trigger,
> > due to the left-most x-coordinate of the next character always less
> > than the screen width. Earlyprintk will infinite loop in trying to
> > print the rest of the string but unable to, due to the line being
> > full.
> >
> > This patch makes the trigger consider the right-most x-coordinate,
> > instead of left-most, as the value to compare against the screen
> > width threshold.
> >
> > Signed-off-by: YiFei Zhu <zhuyifei1999@gmail.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/x86/platform/efi/early_printk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
> > index 7476b3b097e1..7138bc7a265c 100644
> > --- a/arch/x86/platform/efi/early_printk.c
> > +++ b/arch/x86/platform/efi/early_printk.c
> > @@ -183,7 +183,7 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
> >                       num--;
> >               }
> >
> > -             if (efi_x >= si->lfb_width) {
> > +             if (efi_x + font->width > si->lfb_width) {
> >                       efi_x = 0;
> >                       efi_y += font->height;
> >               }
>
> Any objections to marking this for -stable and queueing it up in
> efi/urgent as well?
>

No that is fine.
