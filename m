Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9928C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 00:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1D221104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 00:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="grjQhxbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1D221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeKKKSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 05:18:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47090 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeKKKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 05:18:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so4232968otm.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ly72rTFZ31JtGa1OL3SehdUUIVoW2JSNjZRCHZP6/o0=;
        b=grjQhxbXFd+k1PfXyVp0y5XCgBFrmh65IT15HfR7Kk3T6rTIs/L/IrGuZUsI2QZZus
         mPSYB5aQnlMaEeHAq1M1pk/y+iCUZNkPxOZNa+UDWIf5c8akDFyLwcm4eAZVnmH5uvWY
         +OI9CejO6Omjc0/qlqrPD+JYpH1HE7QXTFgh8VcjL3yJjaja6j155KfFt1tEo28N8qym
         Jl3WLo4qnCrQdgyM2WUHcjaLKLEkHshJ1wwwQ8Qsls+hY2cAc/FZzVWbfWMPlXQ5K9ON
         YIYQyB14ievZ+3FIeCyDay2x3Mu6x+KaoNAqI9+yNVtRlLA5CHggQSA2l6Iuq680ZCjn
         3CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ly72rTFZ31JtGa1OL3SehdUUIVoW2JSNjZRCHZP6/o0=;
        b=HdRDbORqfO0u0Bo1gp6xdcBTqL/50fj5aCAewO/KVPtTv0Ng1BRI4lSXNmLgkBdGBe
         5a4FQd2+RZUN1ZcyXEMXz11zDZwLV2MyhvfX+Lq4PDiZWS8NjzjMI605sJ3jyfNTR0OW
         Pl689GyZp5b6pcSwoy0AJYpPTeTb7/CqkfSgTiMRIsC72bUFfIfPzNRXc8vAuHV1kza2
         vOEmoSzNLfUwA5MIrGVgDfNQvvOzPspyOIwnyRCJSolQZRSdabTLi2uh6Ia0IXTkVtFv
         5zM/neM0hhqAkWhbPJGqjLTgQTSKE/cytqU8m2K3nTQsehL/gcVTf5ugZR1OOOypyHrY
         ztdw==
X-Gm-Message-State: AGRZ1gJxwBnNKUserMWk7nidt0t4vY/eo1mqE4Nrbrv7JDn6Ypna9BGM
        PujLBfa/YYghFbJ7XmGPLwkhIqUOkTUhgTDlrYPgbg==
X-Google-Smtp-Source: AJdET5e6u1quJttFWIjrkYjYGhPF2YYP8MbqCWbLnp5JxzJ/huxlOSa9viuEcVXcv3AITdUntEScBHs7EFYw2s8q6jI=
X-Received: by 2002:a9d:40cd:: with SMTP id t13mr8254048oti.98.1541896317082;
 Sat, 10 Nov 2018 16:31:57 -0800 (PST)
MIME-Version: 1.0
References: <154180834787.2060925.7738215365584115230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <7590EF40-B0CF-40BD-9D29-FB731A2A2E3A@amacapital.net> <CAPcyv4hXzBT1LkEdBYw_mkrKV+SK1LRE2PwJ5=T+e7GxWbXaNQ@mail.gmail.com>
 <9DFD717D-857D-493D-A606-B635D72BAC21@amacapital.net>
In-Reply-To: <9DFD717D-857D-493D-A606-B635D72BAC21@amacapital.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 10 Nov 2018 16:31:45 -0800
Message-ID: <CAPcyv4i7m+FuwFKLyQ6StNL2BCiNv7=O_Y9J4Ojqek7nC9mNjw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/pat: Fix missing preemption disable for __native_flush_tlb()
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ added Kirill ]

On Sat, Nov 10, 2018 at 4:19 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> > On Nov 10, 2018, at 3:57 PM, Dan Williams <dan.j.williams@intel.com> wr=
ote:
> >
> >> On Fri, Nov 9, 2018 at 4:22 PM Andy Lutomirski <luto@amacapital.net> w=
rote:
> >>
> >>
> >>
> >>> On Nov 9, 2018, at 4:05 PM, Dan Williams <dan.j.williams@intel.com> w=
rote:
> >>>
> >>> Commit f77084d96355 "x86/mm/pat: Disable preemption around
> >>> __flush_tlb_all()" addressed a case where __flush_tlb_all() is called
> >>> without preemption being disabled. It also left a warning to catch ot=
her
> >>> cases where preemption is not disabled. That warning triggers for the
> >>> memory hotplug path which is also used for persistent memory enabling=
:
> >>
> >> I don=E2=80=99t think I agree with the patch. If you call __flush_tlb_=
all() in a context where you might be *migrated*, then there=E2=80=99s a bu=
g. We could change the code to allow this particular use by checking that w=
e haven=E2=80=99t done SMP init yet, perhaps.
> >
> > Hmm, are saying the entire kernel_physical_mapping_init() sequence
> > needs to run with pre-emption disabled?
>
> If it indeed can run late in boot or after boot, then it sure looks buggy=
. Either the __flush_tlb_all() should be removed or it should be replaced w=
ith flush_tlb_kernel_range(). It=E2=80=99s unclear to me why a flush is nee=
ded at all, but if it=E2=80=99s needed, surely all CPUs need flushing.

Yeah, I don't think __flush_tlb_all() is needed at
kernel_physical_mapping_init() time, and at
kernel_physical_mapping_remove() time we do a full flush_tlb_all().

Kirill?
