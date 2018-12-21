Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5833AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154DF218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHzskhaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbeLUAIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:08:24 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38193 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbeLUAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:08:24 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so4332671ith.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiy+htGKZDqnDmeSkX50CasjUnRZlAezIYV3yScFu8s=;
        b=kHzskhaUlA0F4JF45fCn0KJxRpWjDm+/fiYmjwt0H7svaVAPe+gykBfmiC60klkBfr
         juoGtHWLKK+/ShJY1jF2NA/VF/y5uJb1iLikgrSHuGWX5kcCaFMGQt5d6dGJHR2X2BwD
         zyUQTBmeZbnOLQsSu8kjhkPucnG+SaIV06Zwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiy+htGKZDqnDmeSkX50CasjUnRZlAezIYV3yScFu8s=;
        b=CbbVHibFuLYCMqAr4AvyuYpFIB/i/HTqrxyjB6zAIDjqkmB1WyLwn/IvnHmXznFTa1
         +GYmbElcgwbjEEourr++KZhgxV7iiGWsxVCOwyP68FdZ23/WfNjrB7mt6rmg/OQ8mzJP
         EzcA9Z2d6DJI+1x0W4SkRwdGnsEYb9UrqVlo7hT2JNYzIwKpZY4mIRsM2Kf6Hp1QpzjE
         NY+oFaU1b/TanYUJ6PPVAM2naiuOgrT/eBAStV8gGjz4fqQIhQeg5GMLRZq78GvIEcir
         ituNXzZBghsfrvNVjBwxYQ0s2xS29OQz+I2c0Ylc4gUxXYPofEejM0F2bL/Q2XNG9BUK
         Dn4Q==
X-Gm-Message-State: AA+aEWbSfhkIgISAoDByLbfl1w1xOHy9vJ86saA++tUySogL9nI+81mJ
        TQ1ox44qWYLUcjAQvW0lOizokWs2eATty8DTUuZZJ8gTfko=
X-Google-Smtp-Source: AFSGD/UP53SwFoatHdW8lQnmDVhWfZZFFvKEyCGN7rGakwCYaAygKE75TowU+RCllUMM3ayvAwcrzJRJegJqSPhAFGc=
X-Received: by 2002:a02:734b:: with SMTP id a11mr224035jae.62.1545350902827;
 Thu, 20 Dec 2018 16:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20181217180214.9436-3-ard.biesheuvel@linaro.org>
 <tip-793423cf07e51e3185b8680167115813589c057d@git.kernel.org>
 <8cfd64a9-1a66-0ca1-851b-c3fc9a47809d@gmx.de> <CAKv+Gu8kZutLz-4Z4QP+C4g5UFavWjGVNfx4340hd15j=fEVtw@mail.gmail.com>
 <52f43437-b3a1-4d66-f721-cb46d0dcd922@gmx.de> <CAKv+Gu_SZvFkoOUPacVe0EEv4eHscnPgZVucDwRL91FwfxtrzA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_SZvFkoOUPacVe0EEv4eHscnPgZVucDwRL91FwfxtrzA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Dec 2018 01:08:10 +0100
Message-ID: <CAKv+Gu9_0u3CyQPU8t767ZL98OVs0L2LjpiKr3EEkSdBgWzShw@mail.gmail.com>
Subject: Re: [tip:efi/urgent] efi: Align 'efi_guid_t' to 64 bits
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Qian Cai <cai@gmx.us>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 23:50, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 18 Dec 2018 at 00:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 12/17/18 11:42 PM, Ard Biesheuvel wrote:
> > > On Mon, 17 Dec 2018 at 23:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> On 12/17/18 7:16 PM, tip-bot for Heinrich Schuchardt wrote:
> > >>> Commit-ID:  793423cf07e51e3185b8680167115813589c057d
> > >>> Gitweb:     https://git.kernel.org/tip/793423cf07e51e3185b8680167115813589c057d
> > >>> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >>> AuthorDate: Mon, 17 Dec 2018 19:02:14 +0100
> > >>> Committer:  Ingo Molnar <mingo@kernel.org>
> > >>> CommitDate: Mon, 17 Dec 2018 19:12:48 +0100
> > >>>
> > >>> efi: Align 'efi_guid_t' to 64 bits
> > >>>
> > >>> The UEFI Specification Version 2.7 Errata A defines:
> > >>>
> > >>>   "EFI_GUID
> > >>>   128-bit buffer containing a unique identifier value.
> > >>>   Unless otherwise specified, aligned on a 64-bit boundary."
> > >>>
> > >>> Before this patch efi_guid_t was only 8-bit aligned.
> > >>>
> > >>> Note that this could potentially trigger alignment faults during
> > >>> EFI runtime services calls on 32-bit ARM, given that it does not
> > >>> permit load/store double or load/store multiple instructions to
> > >>> operate on memory addresses that are not 32-bit aligned.
> > >>>
> > >>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >>> Cc: <stable@vger.kernel.org> # v4.9+, or earlier if possible
> > >>> Cc: Andy Lutomirski <luto@kernel.org>
> > >>> Cc: Borislav Petkov <bp@alien8.de>
> > >>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > >>> Cc: H. Peter Anvin <hpa@zytor.com>
> > >>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > >>> Cc: Peter Zijlstra <peterz@infradead.org>
> > >>> Cc: Qian Cai <cai@gmx.us>
> > >>> Cc: Rik van Riel <riel@surriel.com>
> > >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >>> Cc: linux-efi@vger.kernel.org
> > >>> Link: http://lkml.kernel.org/r/20181217180214.9436-3-ard.biesheuvel@linaro.org
> > >>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > >>> ---
> > >>>  include/linux/efi.h | 2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/include/linux/efi.h b/include/linux/efi.h
> > >>> index 100ce4a4aff6..e6480c805932 100644
> > >>> --- a/include/linux/efi.h
> > >>> +++ b/include/linux/efi.h
> > >>> @@ -48,7 +48,7 @@ typedef u16 efi_char16_t;           /* UNICODE character */
> > >>>  typedef u64 efi_physical_addr_t;
> > >>>  typedef void *efi_handle_t;
> > >>>
> > >>> -typedef guid_t efi_guid_t;
> > >>> +
> > >>>
> > >>>  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> > >>>       GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> > >>>
> > >>
> > >> Before rushing this patch in, we should carefully review its side
> > >> effects, e.g. on 32bit system this changes the size of
> > >> efi_config_table_32_t from 20 to 24, which is part of the interface to
> > >> the UEFI firmware.
> > >>
> > >
> > > grmbl.
> > >
> > > Thanks for spotting that.
> > >
> > > The UEFI spec defines a GUID struct as { UINT32; UINT16; UINT16;
> > > UINT8[8]; } so its natural alignment is 32 bits not 64 bits. The
> > > alignment issue on ARM would be solved by using __aligned(4) rather
> > > than __aligned(8), while not affecting the size of the config table
> > > struct (and potentially others) on 32-bit architectures.
> > >
> > > Ingo, apologies for the breakage. Do you prefer a replacement patch or
> > > a followup patch?
> > >
> >
> > The UEFI spec explicitly requires EFI_GUID to be 64-bit aligned. On the
> > other hand neither EDK2 nor GRUB not U-Boot cared about this requirement
> > up to now. So the array of efi_config_table_32_t had 20 byte long
> > members at least on Linux, EDK2, GRUB, U-Boot, and possibly on other
> > UEFI implementations though the UEFI spec does not mention packing here.
> >
> > As the 4.20 kernel release is imminent, please, keep this patch out
> > before causing breakage.
> >
>
> Ingo,
>
> Let's just drop Heinrich's patch for now, and I will come back to it
> for the next release. There is very little EFI on 32-bit ARM in the
> field, and this patch in its current form will break IA-32 as well, so
> a quick followup fix is probably not the best approach here.

Ingo,

Could you please let me know what your plans are with this patch? It
has been pulled into -next now.

Please either drop it or revert it.
