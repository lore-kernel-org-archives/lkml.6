Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A3AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20E620020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+yziCH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20E620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966895AbeFSRJL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:09:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42409 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966468AbeFSRJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:09:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so177308pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxeF8FT51s8VsfayKODgispQy/SzF3AFKefvkclxn7M=;
        b=L+yziCH1pGc9srMiiv8qvCW/GHxKUcruYWfwwXhE7wCfjfq1WpyNjEABHnv4VL/KYi
         iN9KVdC3CM2epGyB9CJmE7Ikrb+GsJdiGfGFFagj7k4y42mdiJe4zcLlYMfOVPc6pNf2
         rb8lj6C0Z5pfnTgP+/ZRGxttNewyO40/GZ5+AynJtDQood58umBQfmNvh4XIObmtnqAh
         R/lO1h296NtmhpVbsy5k5qLGBWPp516kznwC8Mz2257DuTKeFEp+kUpDLovhNlp3wkgg
         Xm5t6I4n+pkduzP3n4G6VKbvtuFit3Js0Utfft5W9mwh5Mo0MW0oj6peCScJksBFGved
         UpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxeF8FT51s8VsfayKODgispQy/SzF3AFKefvkclxn7M=;
        b=AfmeMe/BHYzlY6TfBAy3ooXIU4R3vJ8CQ9acLFcWzqHiqnIohQ8gMkHkJXidMqFHzE
         Nw33GEjT3O9aSAH09UO0NbLwYfYmTzs1otU19VQY/eq5ax5XNJCHAKeQLccj7KcRBjNj
         LUItqwj+ao1gIr0lg8pLoZW5x3przgyDiQG8vg0lyCQGWvqwlL326Ba5Q+zweSrAo45j
         3CnyWIjniyFbJHn26Jr/BXXtgLQ2SIiXGe4U6DkbZa8rypDzUug3cAiUDYOFsixa+fHE
         +91cXxO9rraCMBCNFqG1P8s8TAlw9PKNDz51z/59dM1ktpszWpVBYFZB8K9CiBAsCbTs
         GA9A==
X-Gm-Message-State: APt69E1ekW0wnhqLJHsyE15VoF/XyUVQi6rmcFaxKNipfCDgHpWMgx3B
        ocYEJkklywx3liaye2FrpfoUdkTljCSalisf65FpFA==
X-Google-Smtp-Source: ADUXVKLxWbC12An6igp3YyeGwcBf3epj/mnnDAAzSJCjgHNvSczXe6pQURjXp+/P7I37j1pp/hkYF18abdguMlGMrIg=
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11-v6mr20057422plo.20.1529428148096;
 Tue, 19 Jun 2018 10:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174731.47588-1-mka@chromium.org> <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
 <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
 <20180615182945.GN88063@google.com> <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
 <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com> <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
In-Reply-To: <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jun 2018 10:08:55 -0700
Message-ID: <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
To:     pbonzini@redhat.com
Cc:     joe@perches.com, Matthias Kaehlcke <mka@chromium.org>,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 8:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 15/06/2018 20:45, Nick Desaulniers wrote:
> >>
> >>> In any case I think it it preferable to fix the code over disabling
> >>> the warning, unless the warning is bogus or there are just too many
> >>> occurrences.
> >> Maybe.
> > Spurious warning today, actual bug tomorrow?  I prefer to not to
> > disable warnings wholesale.  They don't need to find actual bugs to be
> > useful.  Flagging code that can be further specified does not hurt.
> > Part of the effort to compile the kernel with different compilers is
> > to add warning coverage, not remove it.  That said, there may be
> > warnings that are never useful (or at least due to some invariant that
> > only affects the kernel).  I cant think of any off the top of my head,
> > but I'm also not sure this is one.
>
> This one really makes the code uglier though, so I'm not really inclined
> to applying the patch.

Note that of the three variables (w, u, x), only u is used later on.
What about declaring them as negated with the cast, that way there's
no cast in a ternary?

Ex:

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690d8b95..53673ad4b295 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4261,8 +4261,9 @@ static void update_permission_bitmask(struct
kvm_vcpu *vcpu,
 {
        unsigned byte;

-       const u8 x = BYTE_MASK(ACC_EXEC_MASK);
-       const u8 w = BYTE_MASK(ACC_WRITE_MASK);
+       const u8 x_not = (u8)~BYTE_MASK(ACC_EXEC_MASK);
+       const u8 w_not = (u8)~BYTE_MASK(ACC_WRITE_MASK);
+       const u8 u_not = (u8)~BYTE_MASK(ACC_USER_MASK);
        const u8 u = BYTE_MASK(ACC_USER_MASK);

        bool cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
@@ -4278,11 +4279,11 @@ static void update_permission_bitmask(struct
kvm_vcpu *vcpu,
                 */

                /* Faults from writes to non-writable pages */
-               u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
+               u8 wf = (pfec & PFERR_WRITE_MASK) ? w_not : 0;
                /* Faults from user mode accesses to supervisor pages */
-               u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
+               u8 uf = (pfec & PFERR_USER_MASK) ? u_not : 0;
                /* Faults from fetches of non-executable pages*/
-               u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
+               u8 ff = (pfec & PFERR_FETCH_MASK) ? x_not : 0;
                /* Faults from kernel mode fetches of user pages */
                u8 smepf = 0;
                /* Faults from kernel mode accesses of user pages */


Maybe you have a better naming scheme than *_not ? What do you think?
-- 
Thanks,
~Nick Desaulniers
