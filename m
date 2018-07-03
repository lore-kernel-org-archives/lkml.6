Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EC5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE4C20844
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4Z2T+rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbeGCIjA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:39:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50656 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbeGCIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:38:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so1383566wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L4FjDvGQgmLVJ5933cjQZXJkW7oGC7E8X7BDzb1+S44=;
        b=C4Z2T+rIVNuGlgfIaT8li3IkGkAthlG9wyBPNXoUNnJGnF2wK9EV63oo69aHGXDxjH
         p0rRDNYDbhmHqlAvYD/wSTKkVdin0PpC/DzHmOs+YhBBocli1GftTjkyz/qq3jmRv2Td
         8vr37XUNYaHYEqitldQaiVJAUIBVlUmAe8dQM1hxcqJC8p0qT/q5j/iTmtd99FELoyj6
         kVuBzrxtjCM8wsSXpbgNe0Dmyitmvn5bkXuFZufuwV+Xcty3pk8nOKzCcjU4BA8Qb45K
         7l66qZsCAHDHy4KAwJ2MUIU9n5esBAOQmonl2JErZiOHUfe4zugYgXRbtfK3LRNzLrbA
         IjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L4FjDvGQgmLVJ5933cjQZXJkW7oGC7E8X7BDzb1+S44=;
        b=WHsyl62PTyZEeQxO6OZstxZYWxPbAnHxkto+MYqrgV5Xylx3S56U7G+0PjtkVfWSjo
         ROzIjlBv9MmX4z6q+aa0sIV80yS7qiekrjr+fycsMQcapuCbSgigSEVzC96mrSUFvFsx
         LXDtax1bQIPrmQ+DdJB4NyeEr/TxjqN22q/jdIArWpy/zNWDYYsQmpbHjyKij+c9pLZ6
         fovhYGxNS+g97dpkrDUJXIrHxtfpV3GRAp7qaZWCLFy89xCRg1SbzHJooJusX8A5s3B1
         x229kPXpVH/keMYCVlDUJdnxY5FUf66ms7LsDzprga5Sl0lWEGCzLWUGuc0potEXpNYJ
         olBw==
X-Gm-Message-State: APt69E0ub2eWWjzic+eIdpaxSOqp2Z+vzcoCeaXvwBJXUgNryS+jtMUM
        0v09yPZDnm5lck8erZTFpcU=
X-Google-Smtp-Source: AAOMgpdzeEJ8Pd88fszKd8SxW9P101l+VtG7kdTCb5dmzLI9JUmxDoRuG0P008jnPJTj+LwdASM9og==
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr10559445wma.143.1530607136659;
        Tue, 03 Jul 2018 01:38:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y189-v6sm1122101wmd.19.2018.07.03.01.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 01:38:56 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:38:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v9 0/6] add support for relative references in special
 sections
Message-ID: <20180703083853.GA5369@gmail.com>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180627151510.GE30631@arm.com>
 <CAKv+Gu-dkVEtRmvZwiAUpxPSHrkTVvzeGhCwczEmxRjcgfd+LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-dkVEtRmvZwiAUpxPSHrkTVvzeGhCwczEmxRjcgfd+LQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 27 June 2018 at 17:15, Will Deacon <will.deacon@arm.com> wrote:
> > Hi Ard,
> >
> > On Tue, Jun 26, 2018 at 08:27:55PM +0200, Ard Biesheuvel wrote:
> >> This adds support for emitting special sections such as initcall arrays,
> >> PCI fixups and tracepoints as relative references rather than absolute
> >> references. This reduces the size by 50% on 64-bit architectures, but
> >> more importantly, it removes the need for carrying relocation metadata
> >> for these sections in relocatable kernels (e.g., for KASLR) that needs
> >> to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
> >> of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
> >> vs 4 byte relative reference)
> >>
> >> Patch #3 was sent out before as a single patch. This series supersedes
> >> the previous submission. This version makes relative ksymtab entries
> >> dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
> >> than trying to infer from kbuild test robot replies for which architectures
> >> it should be blacklisted.
> >>
> >> Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
> >> and sets it for the main architectures that are expected to benefit the
> >> most from this feature, i.e., 64-bit architectures or ones that use
> >> runtime relocations.
> >>
> >> Patch #2 add support for #define'ing __DISABLE_EXPORTS to get rid of
> >> ksymtab/kcrctab sections in decompressor and EFI stub objects when
> >> rebuilding existing C files to run in a different context.
> >
> > I had a small question on patch 3, but it's really for my understanding.
> > So, for patches 1-3:
> >
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> >
> 
> Thanks all.
> 
> Thomas, Ingo,
> 
> Except for the below tweak against patch #3 for powerpc, which may
> apparently get confused by an input section called .discard without
> any suffixes, this series is good to go, but requires your ack to
> proceed, so I would like to ask you to share your comments and/or
> objections. Also, any suggestions or recommendations regarding the
> route these patches should take are highly appreciated.

LGTM:

Acked-by: Ingo Molnar <mingo@kernel.org>

Regarding route - I suspect -mm would be good, or any other tree that does a lot 
of cross-arch testing?

Thanks,

	Ingo
