Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEB920868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7nbFDGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEB920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeK3XK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:10:58 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:39795 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeK3XK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:10:58 -0500
Received: by mail-it1-f179.google.com with SMTP id a6so8785156itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 04:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRck2750a42jgGFGGDedhPVea52jrGZj0exOL5dCNMA=;
        b=N7nbFDGygMkc2cUuwymY+FYx44x8QDk1FRJhUsYgO2kxwlNZ5EqDtETki5XNj9yBxg
         ZRIcmF70Ol/WpF0cLxyeoFIfsGQKOBxahBfo0w93UmeCHoJobAK0MV1ttckRYM45fBcq
         jE/jOzLw69yRc3bEo+kvcO86D1gJ6GN1UYnec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRck2750a42jgGFGGDedhPVea52jrGZj0exOL5dCNMA=;
        b=UPz7Ng8iRb4tg9M/9Pvx8LLdrCARemMDKLGoykFo4IC4YVPrUEPax6uNUk4csHmkw+
         zFypbivA6kp4Srr3eAts9j93qyN+RMfAhQvxUEGBGweXonRjsaO9hRm810Zn7Jk6uRWE
         qGbdqRNIGQfRykcL3mu6/YUY+thPo+o3DHxgEriZ2Ry38P+5bYNBBrKoU9ZugkEMe3Tf
         8jGlhTsskmDul5xmXooWgUgnj+qhw2KaW6aPafZzZb1+3IRNEXgomSuXxpxvrAD/Mm8W
         HqRC5BUfiHjZF45lOWIfxsMUiSWKNu13w44PGaoY8rvOIpgLpcmLoeWAOiRB897uFzWr
         FYOg==
X-Gm-Message-State: AA+aEWY8by84jT2mI+uwHwa3UsXuU+yGIaAatuBBLusWhU4ar4C2dQqB
        feyN7ybWV7ZlCaOOmT9ULRIuHnKSLGBPx8KLuDQDKA==
X-Google-Smtp-Source: AFSGD/VHovCkYYluDDkQF/YUQx4f1y+ugFH1vYxhEMl4trmV7nQYrgGZLIQrA6NzOKgPBiNsD3pUOWq/J/4saND5jKQ=
X-Received: by 2002:a02:734b:: with SMTP id a11mr4497879jae.62.1543579314226;
 Fri, 30 Nov 2018 04:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org> <FFF73D592F13FD46B8700F0A279B802F485F14B8@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F485F14B8@ORSMSX114.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 30 Nov 2018 13:01:43 +0100
Message-ID: <CAKv+Gu9wYBoLUsioOvsx+ggg6DanqWd3VKVP8nxZ+=zqOqzM3w@mail.gmail.com>
Subject: Re: [GIT PULL 00/11] EFI updates
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 19:27, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>
> Hi Ard,
>
> While building from next branch of efi tree, I noticed the below warning. Could you please check the same on your side?
>
>   CC      lib/list_debug.o
> drivers/firmware/efi/efi.c: In function 'efi_mem_reserve_persistent':
> drivers/firmware/efi/efi.c:1000:6: warning: unused variable 'rsvsize' [-Wunused-variable]
>   int rsvsize = EFI_MEMRESERVE_SIZE(1);
>       ^~~~~~~
>   CC      lib/bitrev.o
>   CC      net/core/sock_reuseport.o
>

Thanks Sai

Ingo spotted it as well and fixed it up before merging.

> > -----Original Message-----
> > From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> > Sent: Thursday, November 29, 2018 9:12 AM
> > To: linux-efi@vger.kernel.org; Ingo Molnar <mingo@kernel.org>; Thomas
> > Gleixner <tglx@linutronix.de>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>; linux-kernel@vger.kernel.org;
> > Andy Lutomirski <luto@kernel.org>; Arend van Spriel
> > <arend.vanspriel@broadcom.com>; Bhupesh Sharma <bhsharma@redhat.com>;
> > Borislav Petkov <bp@alien8.de>; Hansen, Dave <dave.hansen@intel.com>; Eric
> > Snowberg <eric.snowberg@oracle.com>; Hans de Goede
> > <hdegoede@redhat.com>; Joe Perches <joe@perches.com>; Jon Hunter
> > <jonathanh@nvidia.com>; Julien Thierry <julien.thierry@arm.com>; Marc
> > Zyngier <marc.zyngier@arm.com>; Nathan Chancellor
> > <natechancellor@gmail.com>; Peter Zijlstra <peterz@infradead.org>; Prakhya,
> > Sai Praneeth <sai.praneeth.prakhya@intel.com>; Sedat Dilek
> > <sedat.dilek@gmail.com>; YiFei Zhu <zhuyifei1999@gmail.com>
> > Subject: [GIT PULL 00/11] EFI updates
> >
> > The following changes since commit
> > 976b489120cdab2b1b3a41ffa14661db43d58190:
> >
> >   efi: Prevent GICv3 WARN() by mapping the memreserve table before first use
> > (2018-11-27 13:50:20 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> >
> > for you to fetch changes up to 1d29afdbf7ae878a23627ebee81efcd213f11749:
> >
> >   efi/x86: earlyprintk - Fix infinite loop on some screen widths (2018-11-28
> > 17:58:42 +0100)
> >
>
> Regards,
> Sai
