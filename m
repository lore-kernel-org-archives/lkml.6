Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F8420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+TLl6du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbfAKN3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:29:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41510 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfAKN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:29:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so6965116pfi.8;
        Fri, 11 Jan 2019 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hmoEOcHlKNs7k1TiLOLKywpZU3wdLP3/4O8TMbTr0c=;
        b=j+TLl6du7+BZKRko/ynLWBREDEo2lhHIyhr4Rqn2vn6cGcN30hIy/5DNRY3XywuQkf
         Pe8jbjrnzk8wloJkeJJB7dnnl/AT2xEWc77mZd3vXAVWJulkde8D/mmk26dkVSYLyiYy
         nWG69wa4Yyv+mv+lbKbWQawFJU/hvBIen001yD7DmndWcN6vSEHbUC2ZvhDXG/SR4sJ9
         o/MJuhb1er/CQn1koIxajJPOK+e7xHRD8DUY4of5jT26TXLBbJV2by0j/0yOncWurU6M
         9Te+u6OHjx9O4LmPuwEDtyRXWkBCytC1yh5El7g+hoAhAPCaNB2lfItIwAOafvoV7fd9
         LPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hmoEOcHlKNs7k1TiLOLKywpZU3wdLP3/4O8TMbTr0c=;
        b=cHvRMnIlf6C2RZCSPWazsuXAqxir6dKUbUjbxbyNN4Ec2EbZEsRYRG8omY8KgdqWDL
         wVPMl6wyDSw7G+ajXD18dbIBRX96pSmWqPxLx6nNhNdqIgYZI+2jsEY0t0MNfm/JGXQY
         TL++ywYl7xCyD0pVdLf0SxEuvIYp4aitpLCJNzKaG4A7iH0sqxYID3nUXqe+VeSWBIHI
         DtOA70t0LxD+3u5LsnJRvcHo+4oCmMtCrUGxRUsHGk/FuLj1hVys/WyxF55oO5jdQ5Ua
         +06zQPPS9xS4DhEIOzqu0lOZ8CH02bApXRjoM7cKIyGzcE4N3XT5IYXkTC/zNixf2qx3
         zE7A==
X-Gm-Message-State: AJcUukc6gke80fwTu9oy2AAYtpYdrmS36r6X8nAY5+ZMna9udeeqUqn2
        7ZmJhitT5ryB8IWIqiPpvIZIpHmaE4wIehpXRX0=
X-Google-Smtp-Source: ALg8bN4pP1ElXgwKLO/BqOYYsp6IXeWD89/biP7a4HcFk4RwwqDySpCh0d69w0OZmTGnwsHcJslaBfYfIiQxHCaTTpM=
X-Received: by 2002:a63:3287:: with SMTP id y129mr13384827pgy.337.1547213391815;
 Fri, 11 Jan 2019 05:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0hzUAYDxneYUNjcpvN5H+F+=fH1PnVcHP5TgLr-5Jc6YA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hzUAYDxneYUNjcpvN5H+F+=fH1PnVcHP5TgLr-5Jc6YA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jan 2019 15:29:39 +0200
Message-ID: <CAHp75Vfn+_7Nn8mHR8ZhU2+CAF4HvrnvjxP7wb9N+=M29b8z1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper macros
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 3:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 9, 2019 at 5:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > These macros are often used by the drivers and we have already a lot of
> > duplication as ICPU() macro across them.
> >
> > Provide a generic x86 macro for users.
> >
> > This adds no driver data variants.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

> If you want me to apply the series, I need an ACK for this one.

I hope Ingo can help with this.

> Alternatively, if you want to apply it yourself, please feel free to
> add ACKs from me to the ACPI-related patches in it.

Thanks, you already gave yours at time of v1.

>
> > ---
> >  arch/x86/include/asm/intel-family.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> > index 25b28760fada..afd70055a750 100644
> > --- a/arch/x86/include/asm/intel-family.h
> > +++ b/arch/x86/include/asm/intel-family.h
> > @@ -86,10 +86,16 @@
> >         .family         = _family,                              \
> >         .model          = _model,                               \
> >         .feature        = X86_FEATURE_ANY,                      \
> > -       .driver_data    = (kernel_ulong_t)&_driver_data         \
> > +       .driver_data    = (kernel_ulong_t)_driver_data          \
> >  }
> >
> >  #define INTEL_CPU_FAM6(_model, _driver_data)                   \
> > -       INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
> > +       INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, &_driver_data)
> > +
> > +#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)              \
> > +       INTEL_CPU_FAM_ANY(_family, _model, 0)
> > +
> > +#define INTEL_CPU_FAM6_NODATA(_model)                          \
> > +       INTEL_CPU_FAM_ANY_NODATA(6, INTEL_FAM6_##_model)
> >
> >  #endif /* _ASM_X86_INTEL_FAMILY_H */
> > --
> > 2.20.1
> >



-- 
With Best Regards,
Andy Shevchenko
