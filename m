Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB7320869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAfLTiGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbeLSWu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:50:26 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37365 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbeLSWuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:50:23 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so185531iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GH0SUReUA+i/jHdSmpO8toGMiUCkv/bOwb3y9uJWsSI=;
        b=LAfLTiGxvTCj/TdWEHvKTPuN2+BZVNc5hDWabUWLzbdgdEe82JvSykze8cQVLk2dYR
         uyK3L58JC9dczvc01OQOWecRMA6qtjpa6v2Hb1mAAF45fhU+N96gpBUaVGiRQ67/lMdW
         WTf0VFFRx8XcX2TI2fRLAgYZhFdvIe7/H+y0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GH0SUReUA+i/jHdSmpO8toGMiUCkv/bOwb3y9uJWsSI=;
        b=mCLQc/a6QY7f98bwzX8GwNbgzMj+SrUdpeG3JlPceIWjNkPVyKzae60p/iB2jE9PP4
         LiIxoKTv+1YAfhGaNwxUsdyJqCvaI35zWaMU2nShtMBQrc9adHksQ+L13JAXcYHP0AOi
         YjnbLuPF9dW+cAU/kFmuGOIzPg5vAmHIt9UvI4HzFVnYjPn6cJULhQeZ3sQqQevtxlvJ
         ZMYNNjMyToxjBHrtMQ3cBIqkvT+Uu/Ri5EN4ZpVTi037AOQykRX6jMv42Zpa5+y1Mq3J
         bc0vj9Frw+whj0+XEy3m5fGu/ZmEdvGELXtt1XxtyuG2UJeOdwZJhf+gbtf+BAkRtzAB
         AysA==
X-Gm-Message-State: AA+aEWaSRXVCzBvRIUVwgW/tPAaMOe2jYApTLfzRQxhYv3MZGkrwlgdU
        Gx/P3m6RAvRgqO5DKm7o+Iu3KqzyTFdL0Asq4szJZw==
X-Google-Smtp-Source: AFSGD/Wt79F25+g4gizHhAS3Er2/T+3OE10f8ktc6v0cYBZbrdbJ4d2scKHH3831MElgWTINVx9gAlZmM91h6+NgfDQ=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr8493436itk.71.1545259822177;
 Wed, 19 Dec 2018 14:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20181217180214.9436-3-ard.biesheuvel@linaro.org>
 <tip-793423cf07e51e3185b8680167115813589c057d@git.kernel.org>
 <8cfd64a9-1a66-0ca1-851b-c3fc9a47809d@gmx.de> <CAKv+Gu8kZutLz-4Z4QP+C4g5UFavWjGVNfx4340hd15j=fEVtw@mail.gmail.com>
 <52f43437-b3a1-4d66-f721-cb46d0dcd922@gmx.de>
In-Reply-To: <52f43437-b3a1-4d66-f721-cb46d0dcd922@gmx.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Dec 2018 23:50:10 +0100
Message-ID: <CAKv+Gu_SZvFkoOUPacVe0EEv4eHscnPgZVucDwRL91FwfxtrzA@mail.gmail.com>
Subject: Re: [tip:efi/urgent] efi: Align 'efi_guid_t' to 64 bits
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Qian Cai <cai@gmx.us>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 at 00:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/17/18 11:42 PM, Ard Biesheuvel wrote:
> > On Mon, 17 Dec 2018 at 23:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 12/17/18 7:16 PM, tip-bot for Heinrich Schuchardt wrote:
> >>> Commit-ID:  793423cf07e51e3185b8680167115813589c057d
> >>> Gitweb:     https://git.kernel.org/tip/793423cf07e51e3185b8680167115813589c057d
> >>> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>> AuthorDate: Mon, 17 Dec 2018 19:02:14 +0100
> >>> Committer:  Ingo Molnar <mingo@kernel.org>
> >>> CommitDate: Mon, 17 Dec 2018 19:12:48 +0100
> >>>
> >>> efi: Align 'efi_guid_t' to 64 bits
> >>>
> >>> The UEFI Specification Version 2.7 Errata A defines:
> >>>
> >>>   "EFI_GUID
> >>>   128-bit buffer containing a unique identifier value.
> >>>   Unless otherwise specified, aligned on a 64-bit boundary."
> >>>
> >>> Before this patch efi_guid_t was only 8-bit aligned.
> >>>
> >>> Note that this could potentially trigger alignment faults during
> >>> EFI runtime services calls on 32-bit ARM, given that it does not
> >>> permit load/store double or load/store multiple instructions to
> >>> operate on memory addresses that are not 32-bit aligned.
> >>>
> >>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> Cc: <stable@vger.kernel.org> # v4.9+, or earlier if possible
> >>> Cc: Andy Lutomirski <luto@kernel.org>
> >>> Cc: Borislav Petkov <bp@alien8.de>
> >>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>> Cc: H. Peter Anvin <hpa@zytor.com>
> >>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Qian Cai <cai@gmx.us>
> >>> Cc: Rik van Riel <riel@surriel.com>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Cc: linux-efi@vger.kernel.org
> >>> Link: http://lkml.kernel.org/r/20181217180214.9436-3-ard.biesheuvel@linaro.org
> >>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> >>> ---
> >>>  include/linux/efi.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >>> index 100ce4a4aff6..e6480c805932 100644
> >>> --- a/include/linux/efi.h
> >>> +++ b/include/linux/efi.h
> >>> @@ -48,7 +48,7 @@ typedef u16 efi_char16_t;           /* UNICODE character */
> >>>  typedef u64 efi_physical_addr_t;
> >>>  typedef void *efi_handle_t;
> >>>
> >>> -typedef guid_t efi_guid_t;
> >>> +
> >>>
> >>>  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> >>>       GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> >>>
> >>
> >> Before rushing this patch in, we should carefully review its side
> >> effects, e.g. on 32bit system this changes the size of
> >> efi_config_table_32_t from 20 to 24, which is part of the interface to
> >> the UEFI firmware.
> >>
> >
> > grmbl.
> >
> > Thanks for spotting that.
> >
> > The UEFI spec defines a GUID struct as { UINT32; UINT16; UINT16;
> > UINT8[8]; } so its natural alignment is 32 bits not 64 bits. The
> > alignment issue on ARM would be solved by using __aligned(4) rather
> > than __aligned(8), while not affecting the size of the config table
> > struct (and potentially others) on 32-bit architectures.
> >
> > Ingo, apologies for the breakage. Do you prefer a replacement patch or
> > a followup patch?
> >
>
> The UEFI spec explicitly requires EFI_GUID to be 64-bit aligned. On the
> other hand neither EDK2 nor GRUB not U-Boot cared about this requirement
> up to now. So the array of efi_config_table_32_t had 20 byte long
> members at least on Linux, EDK2, GRUB, U-Boot, and possibly on other
> UEFI implementations though the UEFI spec does not mention packing here.
>
> As the 4.20 kernel release is imminent, please, keep this patch out
> before causing breakage.
>

Ingo,

Let's just drop Heinrich's patch for now, and I will come back to it
for the next release. There is very little EFI on 32-bit ARM in the
field, and this patch in its current form will break IA-32 as well, so
a quick followup fix is probably not the best approach here.
