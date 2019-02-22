Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC914C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A65A207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3TmaqAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfBVPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:16:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42734 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:16:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so1243262pfi.9;
        Fri, 22 Feb 2019 07:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vo6jhFpbADqF/a0Ruw2bj4J5FVM9bvOetl2FepVuCV8=;
        b=K3TmaqAD4pXvm/GlBWOLi3KMMA3nE1BcVO5H8tvU6WLblDnG6rU5iQDEcf+DenGjg/
         KPBbaD/8Ufw7zsYwK3LHwKAGate7bhzVZvAM7dVb73c7t3ViHwYtk3KN3MQyiWf5ViLB
         lI33EzlB7Lp1o/q9BZudcdhoCMMcz6pQLrSp0UbWMq9mtoyG4uorMiL9svUzcIa7nOv1
         0Fas/qtQlGh0mUU2vhqHgiAA27XlZvAAsaGOR2l8gAhc/gb0y8s+owi+uNNY2lwlKnnU
         lB71JS+fKzNQWR6j1I7kY9bqUJk3JJjdSa3qIcnN/ih8DdMdwDP1z1iLDZUjxcVJOh/1
         2liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vo6jhFpbADqF/a0Ruw2bj4J5FVM9bvOetl2FepVuCV8=;
        b=dgWohAixejJdV8FNyBRCdG5upsrhz2RfU5EByQl+eVf5DWu+URo9yaPPGmBxtDlbRo
         0V8638hxpI87qmAhPgH936XqHDhulh3Ee5gBxnv0vXDgBUtWLn+wNWpYSN7ANCtqOCHl
         N3RuX84d/NBqqtzodQ/AzT5Qoxyw9ndD/O7DwUjtejKs1HIE0trO6U83aZ02fxBpzkQK
         s21+BlnJ32xZGbTBKCQLxq8G+6IdCIXpRPTCYTjNEQf3B/r0NRCWawgCp4k29M6hYocn
         ClUimudwpjJbHQFZ+W/qxSijLdb7ToFl39HF58FcF1bd787dK/2hVwtvVBJ84GrptI4Q
         /NSw==
X-Gm-Message-State: AHQUAubmaIgW4R9FhX2QDGSLapXC/wp4CnKbxjUA4x+ZpChUi1APCa1+
        CUf/m06PbqwENG2+1w95i20eHksVq8DzAcUyNb8=
X-Google-Smtp-Source: AHgI3IZeQgqWVtrcsfm2Tm2BWN3Prl48FQfg6UjzpDJVhVgiMrpi7spJkXwnpCmoaBF9grx4xygB0oWfMnVdUG2nFc0=
X-Received: by 2002:a63:d347:: with SMTP id u7mr4363863pgi.383.1550848607431;
 Fri, 22 Feb 2019 07:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
 <20190202013825.51261-4-Tianyu.Lan@microsoft.com> <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
 <CAOLK0pzXnvk=FsfjH07jUyRJGpeiNG7-9vR9Vo0mLJtdPnt_7Q@mail.gmail.com> <d9043bc8-d006-bf64-2047-79a9b6f98183@redhat.com>
In-Reply-To: <d9043bc8-d006-bf64-2047-79a9b6f98183@redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Fri, 22 Feb 2019 23:16:35 +0800
Message-ID: <CAOLK0pyGhbd43rVPZE7waaStUkGVYVgakG2VgqtME4PxNTOY0w@mail.gmail.com>
Subject: Re: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct mmu_spte_page
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm <kvm@vger.kernel.org>,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 15/02/19 16:05, Tianyu Lan wrote:
> > Yes, you are right. Thanks to point out and will fix. The last_level
> > flag is to avoid adding middle page node(e.g, PGD, PMD)
> > into flush list. The address range will be duplicated if adding both
> > leaf, node and middle node into flush list.
>
> Hmm, that's not easy to track.  One kvm_mmu_page could include both leaf
> and non-leaf page (for example a huge page for 0 to 2 MB and a page
> table for 2 MB to 4 MB).
>
> Is this really needed?  First, your benchmarks so far have been done
> with sp->last_level always set to true.  Second, you would only
> encounter this optimization in kvm_mmu_commit_zap_page when zapping a 1
> GB region (which then would be invalidated twice, at both the PMD and
> PGD level) or bigger.
>
> Paolo

Hi Paolo:
             Sorry for later response and I tried to figure out a bug
lead by defining wrong
max flush count. I just sent out V3. I still put the last_level flag
patch in the end of patchset.
Detail please see the change log. Just like you said this was an
optimization and wasn't 100%
required. If you still have some concerns, you can ignore it and other
patches in this patchset
should be good. Thanks.

-- 
Best regards
Tianyu Lan
