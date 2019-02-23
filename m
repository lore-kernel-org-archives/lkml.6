Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F7EC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471CC20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldeiozMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfBWOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 09:38:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33178 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 09:38:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id h11so2458263pgl.0;
        Sat, 23 Feb 2019 06:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6FUQSYQvUFEycWA5KwWZpSsaRLlBroz3IlvJU3oqWw=;
        b=ldeiozMw5Dv/aPnge0ahHdfu2zXrCzwVQvoCUE3DUbUL27J8OQE7AnMnb4KA1yK5Pe
         dVVz2+VfONQ/jeM6oh4j7Iv/KX9hbAtoVVGIbeQjwi0CgsICN+4xrfB5Je/4obJQZR8e
         eOfvaAmYUU2mrcRIKNg0rST8n5SowV1JDN5doew4JXUNNQ1/2f/8M9EmglhSoxfJC6xb
         0rdulcsTRW+bQ7+I8JwakOLxSY3WHCBxEFxIB2AjWYHrMfFaOIwhwr9tcM3tTxa/Nlre
         IdpjtNJ2Jl+34UAz3CZeBJxdEzUywBml6WZF3X+fr7TJrQMYqmxUOqAEK3umJLWC220C
         XeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6FUQSYQvUFEycWA5KwWZpSsaRLlBroz3IlvJU3oqWw=;
        b=deurkVR11x7BJIC4RX9p7kCcac+vL1FXxMbzGqF3J+bHw4RuqEsumutTeif0ztj3pl
         S39Ow8BFNdz+Y2nv93mOlpYCLeXP6089uBQpypXhawIzEPsEPDXw9NxSCZzpY3mp3V6F
         2efZUsiuGMpzKzPuJQkewws7QjgeYSJB4wfFQGK3+sBQ/qTmxvCgQ05Cw+7xYmOwTssZ
         bigzITfVmYEy/IEwjPse0bd9zR1kDk5WMThJhBUiqHIEtmiyK0lCngtG1YMJiVNBntmz
         BSdoYFwUJHfLSPw4JGdCbuNUYrFFz82yeZm2Nn2dAiRxoz5aOetRsfhDmzYFXPOpcyET
         n7xQ==
X-Gm-Message-State: AHQUAubVuCSf8tW4FbHwAZqN4X8/RWog04x5Q/EiwEtq8JFqFYtwc4GC
        ataSlx1NBwAnSlQqlwdRebW8pejIb86X2H8n/ZU=
X-Google-Smtp-Source: AHgI3IaTEs9wR2DkVIfSbPR8akoMBe5TzeNXZfOrzZslm6+igFUCmJYaI9AtkqFeHn9T6UXb3i7TENBXyvdFEYmCsJo=
X-Received: by 2002:a62:b502:: with SMTP id y2mr1993591pfe.212.1550932684655;
 Sat, 23 Feb 2019 06:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com> <75e9238a-f168-b90d-e1f1-89938e6df57a@redhat.com>
In-Reply-To: <75e9238a-f168-b90d-e1f1-89938e6df57a@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Sat, 23 Feb 2019 22:37:53 +0800
Message-ID: <CAOLK0pzvtO6Aj0T7uKwOHdNcsnM_Fq_wPL1VUTwF347fYA5Vdw@mail.gmail.com>
Subject: Re: [PATCH V3 00/10] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, benh@kernel.crashing.org,
        bp@alien8.de, catalin.marinas@arm.com, christoffer.dall@arm.com,
        devel@linuxdriverproject.org, haiyangz@microsoft.com,
        "H. Peter Anvin" <hpa@zytor.com>, jhogan@kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        kvm <kvm@vger.kernel.org>, kys@microsoft.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        marc.zyngier@arm.com, Ingo Molnar <mingo@redhat.com>,
        mpe@ellerman.id.au, paul.burton@mips.com, paulus@ozlabs.org,
        ralf@linux-mips.org, Radim Krcmar <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>, sthemmin@microsoft.com,
        Thomas Gleixner <tglx@linutronix.de>, will.deacon@arm.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        michael.h.kelley@microsoft.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 2:26 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 22/02/19 16:06, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > This patchset is to introduce hv ept tlb range list flush function
> > support in the KVM MMU component. Flushing ept tlbs of several address
> > range can be done via single hypercall and new list flush function is
> > used in the kvm_mmu_commit_zap_page() and FNAME(sync_page). This patchset
> > also adds more hv ept tlb range flush support in more KVM MMU function.
> >
> > This patchset is based on the fix patch "x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT".
> > (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1939455.html)
>
> Note that this won't make it in 5.1 unless Linus releases an -rc8.
> Otherwise, I'll get to it next week.
Hi Paolo:
      Sure. Thanks for your review.

-- 
Best regards
Tianyu Lan
