Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24786C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA5421480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX1vDT5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA5421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeIZPqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:46:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33897 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:46:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id x23-v6so16514602qtr.1;
        Wed, 26 Sep 2018 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZovLyWNqbdF00Jv4HxB8t1uuOUFX5YdAwnsIjxVm6o=;
        b=iX1vDT5Mjn/+3/BKEWuMcGOruhypMrwXqbSUV4ek2vN0M1TXiZNviDU0Sm4zN2N5dP
         twdN2lh+kimI/lzYlZ4tVWZ0+t0t1+XbZLOBRjPUOf6FRaPOKhWiJ0+ndfsOuGmeeflW
         /AChMpo/f/FyWPerbWbSjJW2WWZfi55NSocpuPxtJonQGvClSRuBxIG/GVW6PpPnn7FD
         O4ryUCy7aeKw0Cpe9G0PeNasKkYKPC3z2Pz4B+Dip3R5zCzpDRps18Lu7z3JD9n2FFeG
         UXXq/DcypwsxioqWmWIjDxlLffdGXqF0cmdnE+uo0Uf4L1pYlwh7g61Gn8iHOjbmBRUZ
         RtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZovLyWNqbdF00Jv4HxB8t1uuOUFX5YdAwnsIjxVm6o=;
        b=sr/XsjlSz425GJHQBJ9VZNCc3ISzyodT72zvc5PZYoXqnmBqrz4JUenmrhaPphR41R
         DYhRYq3nyfRi3oScEu7ibhID3vmucTRTg45Np7aRaDOUt1Q/+WOWH7erx0/t6Y3+qbTn
         7aRyXqLDR0S1zVw7hMiAcCCcDS7csM1FUk3xeneUTsIZl1JNRdkebHXg3HBcRXBtt2b5
         RvM0gLkVDOlmQ+p8TBsOFIUZsmeeqL52pUp39uI1E15vY9YzkBSk91HlsQaq37R7Grd6
         rnbuBuSxsNb5noyOfV2JvMT+g0FJerWOkgTmUNjPi39i9DBmpEOx1VfA6KYq87MMZc7I
         aa9g==
X-Gm-Message-State: ABuFfoghx70ptEh3ay1XHLbzWKN4S8rVFP/Zj9uLgbiPMUQ4AAWBCDtE
        s3LNEQNEjZLZVTtfdMtckddaCqrwQpeTC6kBtZB/0RYHEOA=
X-Google-Smtp-Source: ACcGV62VqGWY1qYWpYKPfasoU/vDwmz52P2enHpyoCxew2XqTsB+SPD27hmec4/WJQVX7GKwhP5R7QrVfncfsaLwYEo=
X-Received: by 2002:a0c:81b0:: with SMTP id 45-v6mr3712194qvd.7.1537954453728;
 Wed, 26 Sep 2018 02:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180919181451.8771-1-hdegoede@redhat.com>
In-Reply-To: <20180919181451.8771-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 12:34:02 +0300
Message-ID: <CAHp75Ved82xwafbraSauxcrZACUH7C9XwSkYyJBp-aE8ptSG5g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Enable the driver on
 Bay Trail platforms
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 9:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The intel_int0002_vgpio driver was added to avoid an IRQ 9 storm on Cherry
> Trail platforms.
>
> When originally merged the CPU ID for Bay Trail SoCs was commented out
> of the list of valid CPU IDs because we did not have any reports of the
> IRQ storm on Bay Trail platforms.
>
> We now have a report of the IRQ 9 storm on the Bay Trail based Thinkpad
> Tablet 10 which is fixed by enabling this driver, so lets enable it on
> Bay Trail too.
>
> I've tested various other Bay Trail device with this driver enabled
> without adverse side-effects.
>

Pushed to my review and testing queue, thanks!


> BugLink: https://www.dpin.de/nf/finally-s0i3-is-there-thinkpad-tablet-10-sleeps-deeply-with-linux-kernel-4-15rc/#comments
> Reported-and-tested-by: Nicole Faerber <nicole@id3p.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel_int0002_vgpio.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
> index a473dc51b18d..987a3b03f225 100644
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@ -57,11 +57,7 @@
>  #define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
>
>  static const struct x86_cpu_id int0002_cpu_ids[] = {
> -/*
> - * Limit ourselves to Cherry Trail for now, until testing shows we
> - * need to handle the INT0002 device on Baytrail too.
> - *     ICPU(INTEL_FAM6_ATOM_SILVERMONT1),       * Valleyview, Bay Trail *
> - */
> +       ICPU(INTEL_FAM6_ATOM_SILVERMONT1),      /* Valleyview, Bay Trail  */
>         ICPU(INTEL_FAM6_ATOM_AIRMONT),          /* Braswell, Cherry Trail */
>         {}
>  };
> --
> 2.19.0.rc1
>


-- 
With Best Regards,
Andy Shevchenko
