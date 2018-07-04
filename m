Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D084EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8253123CE4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="l51EtzDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8253123CE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeGDPhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:37:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37033 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeGDPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:37:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id h20-v6so2887069pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NKfl1dakeZMXG6ETvE88g5rSQ2aAB3IhZ9upFpgwujw=;
        b=l51EtzDchNn9+m14Kj+JzmC1l1jQRiUDSBX73d2vV8DxN5uz/0vn/F0SJd+KdBKI8c
         KCXPveJ4WDcBA87eVvt2v8vU8PZVrpsbcA0jHBAhAPOuDs9sY1eQCiiVxfHKkWk+RfsA
         blNOhZ93OSTMN1l5EZgqIOMDk+/eFmtYWEYGQvLvnEFAAO5BkxzK+rrgQ8hsR+S8/yhj
         9jkQHV2Msnn8h7emvQv3oXuBC31yhWROVXFALc1fZQiVSYkgvLfizCLz69xVcyUCqTXD
         FjuFWujNY9YneEaOoqsSGVHjPwMa8QyKf5WWMCmeohIaBpXrQPc/Wu1w2CrHlcMN61RD
         Gk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NKfl1dakeZMXG6ETvE88g5rSQ2aAB3IhZ9upFpgwujw=;
        b=BAYxXPldloZSPQ1XMScDIIBwb+K8mkoCj1rH4FSViFkErAmBwqY5J+ilJpwZ5Yquy9
         MylrzjuEdQC/N1C/wN5vUAcoeBjZTf3SfidHHBigZHR1xaldL+9SwYsSuc4xzHq3WYaQ
         m8SIQot3CxqsQ5AnO5Jy5coGL4OSfehlNUdvM3xTocRXfAY7WuTA4ThqU30BqEExx9vY
         80jBoGkO0G/tB9S7Ha0mK6IOA5G5bJG5XA/2DRLwJlZcKt7czrYvc7I7mRB1jfN22s/4
         cNstOD7/qtPpUc5Up73jfjahgBpgKXIAIE79IZ4+loM+rys6Y6GsvczF6MsOjRNqo7Iq
         kf+Q==
X-Gm-Message-State: APt69E2m+2tAU8RTcQNFUwtRWkNMe6YHEL6e9ZlmWvBI+iPJ5f1jmp2M
        4sgE7QkjLAWgUNoxY7KYe9Pjmg==
X-Google-Smtp-Source: AAOMgpfZls11ri1ytJCALMMsJ1Pp71Fp7/sRhK5tBa2VJsWaKVT/Z+4wNFLK4vA7RmBMktCl2bs32g==
X-Received: by 2002:a17:902:8645:: with SMTP id y5-v6mr2495153plt.334.1530716943070;
        Wed, 04 Jul 2018 08:09:03 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id o26-v6sm3686811pge.61.2018.07.04.08.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 08:09:02 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id DE78B30003D; Wed,  4 Jul 2018 18:08:57 +0300 (+03)
Date:   Wed, 4 Jul 2018 18:08:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 05:21:50PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jul 03, 2018 at 03:44:03PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> > > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> > > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> > > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> > > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> > > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> > > >> config for reference, and am happy to test patches, provide sample QCOW
> > > >> images, etc.
> > > >
> > > 
> > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> > > 
> > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> > > too with the same symptoms
> > 
> > I tracked it down to -flto in LDFLAGS. I'll look more into this.
> 
> -flto in LDFLAGS screws up this part of paging_prepare():

+Masahiro, Michal.

I've got it wrong. *Any* LDFLAGS option passed to make this way:

  make LDFLAGS="..."

would cause a issue. Even empty.

It overrides all assignments to the variable in the makefile.
As result the image is built without -pie and linker doesn't generate
position independed code.

Looks like the patch below helps, but my make-fu is poor.
I don't see many override directives in kernel makefiles.
It makes me think that there's a better way to fix this.

Hm?
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f895fdde..4f24baa8cdeb 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -42,16 +42,16 @@ KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
-LDFLAGS := -m elf_$(UTS_MACHINE)
+override LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 ifeq ($(CONFIG_X86_32),y)
-LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
+override LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
 else
 # To build 64-bit compressed kernel as PIE, we disable relocation
 # overflow check to avoid relocation overflow error with a new linker
 # command-line option, -z noreloc-overflow.
-LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
+override LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
 endif
 LDFLAGS_vmlinux := -T
-- 
 Kirill A. Shutemov
