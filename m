Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BBC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667CE20868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cH0qqB3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667CE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeJMHo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 03:44:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44316 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeJMHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 03:44:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so13934594otf.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 17:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bkp1b3yp9z/uWXQetbOuaWLTZ1A7P1tg/9UbWkaLl2U=;
        b=cH0qqB3xp23UP5zCLNHJdfLzwXH7r0jEYiv6Fhmz84qb+A1HG2VB4uhPK6actazg2v
         HCK8L9nc7sKOgKKifRc3kWRetfRH43bJ4uIslFeRhr9hWqu/POfn0D1N230NRboPPDbK
         QVrq6r3q9K66gJgvb0rA1j/ZopvqhVU6Pp+6E7JXafPP9q3YilHPXLhMQlyXxr5XAd5r
         nBr2FLrSHMaswOgEjVuwyvIlzcuGzFQtu0h1fCik6yu9No3T2Zp/8id7XRicCx2lfQeW
         dumipPxVWTeQEl9uxEjZOhkKevgyUD5QEjLkITDYs/+2VKUjsyoSL4vY1z3QaHuzR/Gl
         zGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bkp1b3yp9z/uWXQetbOuaWLTZ1A7P1tg/9UbWkaLl2U=;
        b=SyFgp6AkgOqLU/bkLit3+0oNPLYjfrlbjA01eSbq/kK0H4UwB8aO4XOjZJ7j7Je1QX
         Dbzkhoy7wE/DIIafh717R6b4oyrhhoMi7t2nBTIdNb+pYAuRSQOHO4LYMBrLmx++nU7+
         lE3aNrHnx89Yv9yyBiaklmo9+HerHX2sGcjLTyU8JtUml/iR5MBdHbIzf1NkVglGS77i
         4bynLFAvSM6qzZdt8bItztFj6b55VKLzbj/RHYWtdxdSfP0FBg0zv+jM9EQcm/xrxgKE
         8bd/JaV0x2eYcpvIY7xr0mt5Ghd0Df8kF4uD6hTx6aQODH1/4+oSnG1EccyUhQyTWlPl
         nJLA==
X-Gm-Message-State: ABuFfoi7Q6t8t6fdFFLjrH2BS2E++ZSS6IA8UTdHc9Xpux1nMAUWWdOe
        9KnA+1dVqkdPJ+/ByaR6S91KnDVRjIdZfdFF3SMQ8Q==
X-Google-Smtp-Source: ACcGV639M41DQtJ3Bzi3FPu0+wsilAuqX9fxY3z3OebtRwmZSMx/ZNfJJHLHlwhGi7OSBLGGl7Zp8YllhCcioSPxoiQ=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr4824449oth.292.1539389376689;
 Fri, 12 Oct 2018 17:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com> <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
 <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
 <CAG48ez0XfGFAWDYa75COMPCsKqqGfBFOtcNuGD4_dubGf2YeAQ@mail.gmail.com> <657e6d0ada18e8ca0350bc6b3a80c49b3c0b341c.camel@intel.com>
In-Reply-To: <657e6d0ada18e8ca0350bc6b3a80c49b3c0b341c.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 13 Oct 2018 02:09:09 +0200
Message-ID: <CAG48ez383rjt+v_DvLF902X33od_SwMh8dZ-6=w1DZ-YPZ_U9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
To:     rick.p.edgecombe@intel.com
Cc:     linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, jeyu@kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 2:04 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Fri, 2018-10-12 at 19:22 +0200, Jann Horn wrote:
> > On Fri, Oct 12, 2018 at 7:04 PM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > > On Fri, 2018-10-12 at 02:35 +0200, Jann Horn wrote:
> > > > Why all the rbtree stuff instead of stashing a pointer in struct
> > > > vmap_area, or something like that?
> > >
> > > Since the tracking was not for all vmalloc usage, the intention was to not
> > > bloat
> > > the structure for other usages likes stacks. I thought usually there
> > > wouldn't be
> > > nearly as much module space allocations as there would be kernel stacks, but
> > > I
> > > didn't do any actual measurements on the tradeoffs.
> >
> > I imagine that one extra pointer in there - pointing to your struct
> > mod_alloc_user - would probably not be terrible. 8 bytes more per
> > kernel stack shouldn't be so bad?
>
> I looked into this and it starts to look a little messy. The nommu.c version of
> vmalloc doesn't use or expose access to vmap_area or vm_struct. So it starts to
> look like a bunch of IFDEFs to remove the rlimit in the nommu case or making a
> stand in that maintains pretend vm struct's in nommu.c. I had actually
> previously tried to at least pull the allocations size from vmalloc structs, but it broke on nommu.
>
> Thought I would check back and see. How important do you think this is?

I don't think it's important - I just thought that it would be nice to
avoid the extra complexity if it is easily avoidable.
