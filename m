Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E09D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEiGB3+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E09D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeK3TsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:48:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43002 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeK3TsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:48:21 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so3878343ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oVpzrxXNeM32VxY4XuqS+aXLlgFCBv811+/vubnsorI=;
        b=EEiGB3+YWWDTxvmT6JqdbDNirgsWfs6JtDMnKyBXHU4m+06z56mOFSTTJQaQuLaGzN
         U0oUCG3zIv/2zxJ6nBm5jd4W+Pkf/9dHxI76+AWYS8BkPBj4xLQrfJqY3Tx1zpzidf/D
         wVeYYLZDw1ck3HKMbpp4kGxY7JqW9HK4MZA6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oVpzrxXNeM32VxY4XuqS+aXLlgFCBv811+/vubnsorI=;
        b=J6Z2gnDBHu3Y+SztzzlaLw4m/MDggmLs46a4RsXYruo5xgQe/QM8Xd3LNFVtC6lY1F
         mM9ZtbA9IuOWZrLAPwWmVWmXQpZVO/lmASMzJ0jcgIACwmn6WRJIM0EHmK6WW1b3EuLZ
         ndDoOdNd7xkcFcQswcVQCUc34t01vaTLDOwdYX7dms73AegK4K0Rqkgu2Ql9uKm6Lt4P
         54AV7Q9lnE4szaXFpwkslIYgRQiQ8zAbRnmoHKC6juBto+Y1kJtiGU5yNI6HkpHmJQb9
         qQcQuEIJyEzZBKXlqKLaMK+dBDAcsQ7jgGxeWySKAExhuB/O3NG1lCfVF7wadlWCLCbK
         Xrkw==
X-Gm-Message-State: AA+aEWafDn0FzO0rT6zy8lUga8d5PjXo5e+xzStU7sGSJ1VYxWF8QteR
        6NeaVAzaUvR4QQ5gnvhvHUpezG6Gr5sWh89gVxebng==
X-Google-Smtp-Source: AFSGD/VFUu+GsSajztyvH00BzMvF1kMV2bz2UTGP1mQakYs2cdSfp/0HwoUu46pQ7T+SqyAL1kp+2oWsmdiITnvGrYo=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr3742982iob.170.1543567187250;
 Fri, 30 Nov 2018 00:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-11-ard.biesheuvel@linaro.org> <20181130083823.GB97998@gmail.com>
In-Reply-To: <20181130083823.GB97998@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 30 Nov 2018 09:39:34 +0100
Message-ID: <CAKv+Gu8aOK3rY0v0XsHp9wfHOo-F5cHE3VcLXu6k7WLB1R8UjQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] efi: reduce the amount of memblock reservations for
 persistent allocations
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 09:38, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > The current implementation of efi_mem_reserve_persistent() is rather
> > naive, in the sense that for each invocation, it creates a separate
> > linked list entry to describe the reservation. Since the linked list
> > entries themselves need to persist across subsequent kexec reboots,
> > every reservation created this way results in two memblock_reserve()
> > calls at the next boot.
> >
> > On arm64 systems with 100s of CPUs, this may result in a excessive
> > number of memblock reservations, and needless fragmentation.
> >
> > So instead, make use of the newly updated struct linux_efi_memreserve
> > layout to put multiple reservations into a single linked list entry.
> > This should get rid of the numerous tiny memblock reservations, and
> > effectively cut the total number of reservations in half on arm64
> > systems with many CPUs.
> >
> > Tested-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  drivers/firmware/efi/efi.c | 20 +++++++++++++++++---
> >  include/linux/efi.h        |  3 +++
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 80b11521627a..e90bc32c2670 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -998,7 +998,8 @@ int __ref efi_mem_reserve_persistent(phys_addr_t ad=
dr, u64 size)
> >  {
> >       struct linux_efi_memreserve *rsv;
> >       int rsvsize =3D EFI_MEMRESERVE_SIZE(1);
> > -     int rc;
> > +     unsigned long prsv;
> > +     int rc, index;
> >
> >       if (efi_memreserve_root =3D=3D (void *)ULONG_MAX)
> >               return -ENODEV;
> > @@ -1009,11 +1010,24 @@ int __ref efi_mem_reserve_persistent(phys_addr_=
t addr, u64 size)
> >                       return rc;
> >       }
> >
> > -     rsv =3D kmalloc(rsvsize, GFP_ATOMIC);
>
> I fixed the following build warning in this patch:
>
>   drivers/firmware/efi/efi.c:1000:6: warning: unused variable =E2=80=98rs=
vsize=E2=80=99 [-Wunused-variable]
>
> 'rsvsize' got entirely orphaned by the patch, so it can be removed.
>

Thanks, that was a rebase error on my part - apologies for not spotting it.
