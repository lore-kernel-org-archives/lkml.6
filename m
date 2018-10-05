Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482A0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE902084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6pQmfjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE902084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJEQ3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:29:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37738 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeJEQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:29:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 185-v6so1263194wmt.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6b5RAu8nslePBLcX+6zAScDK9hKZqca4C/HNQ9Y2NwA=;
        b=u6pQmfjjO3W6koZhhOu0aweX7qUOXBwuYnqmjxiUnXxJ3Z9RQt7I5pjGkkKNge5Fem
         HpBzRgxmimY6QsF++ngxTwnDXDhsSmm26bsft4GL53XE1DSqvqUscQbbPAYeHW74JUvC
         qrAfk9uUcgTIdCQJ566NONduMjLYQOanQSDSug9hHsTWwCijPJ5BNtwqHaJVCyCOGNxE
         7C/ISTcwUi+UirVopiGHaVHx55DdeAiIBF5eTQBt3Ng8+46iLmBSXTs1kdQ6plb6goeS
         iBY3UJLoxv3itiRXQ2pneUxoGDEN+czCFWnFTsw0K/mGhT7nrjoYe0ltfOA50sGCr/6s
         R8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6b5RAu8nslePBLcX+6zAScDK9hKZqca4C/HNQ9Y2NwA=;
        b=o78Qs8HRrC/hA3/DQK8R6xZtrNSYiemJssr+SmH/SP/RPZK1Ck7r7+yrvc4kkNSJY8
         hZqxYPW+FF81IX/kBBQAAVIDjblefOBzuCpJyR37nN3gmxB7ky8Ch/k2Ri/6l1N8uK4o
         5cq74dZfdDZyD/wnhmbtAsOi98DVvrBfzxEW6nTT9qWqBMrlcz+rVklqJnQq8JRlPoYG
         7vPABYnu/+rI/DQZykzL5V8FK/ZURh+BVdy0FhA5DtXRHWAQFUayHD7ZWecem3RZ/iRl
         cL7ozLOA25hrvDDbXWLu1jnLmhxjwPFiNbss+6NqVE1MRkA0XAWAvRRx7YPSwcXqqNoj
         CimQ==
X-Gm-Message-State: ABuFfoh7Q2XLLrIx4AH9eL9pmo1pLuHkP3FgFRB3d+7hhqNIHG3zNbmm
        90NsWD90jTX2YN8kaRXhFXk=
X-Google-Smtp-Source: ACcGV61o/hK2tdgJ41KRaKqpqjozGDSUtJuO/2PHmmlboFZKt6owGYwMmuOvq31hPmcRznYNOgPMRA==
X-Received: by 2002:a1c:2681:: with SMTP id m123-v6mr6831757wmm.129.1538731871882;
        Fri, 05 Oct 2018 02:31:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b143-v6sm2537134wma.28.2018.10.05.02.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 02:31:11 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:31:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181005093108.GA24723@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <20181004091222.GB21864@gmail.com>
 <D42AB116-BFA4-4CF0-BF45-41C579A9B4C7@vmware.com>
 <20181004094519.GA97692@gmail.com>
 <29591D3B-D49B-4D7A-B280-85A2C3F63F9C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29591D3B-D49B-4D7A-B280-85A2C3F63F9C@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> > Are you using defconfig or a reasonable distro-config for your tests?
> 
> I think it is best to take the kernel and run localyesconfig for testing.

Ok, agreed - and this makes the numbers you provided pretty representative.

Good - now that all of my concerns were addressed I'd like to merge the remaining 3 patches as 
well - but they are conflicting with ongoing x86 work in tip:x86/core. The extable conflict is 
trivial, the jump-label conflict a bit more involved.

Could you please pick up the updated changelogs below and resolve the conflicts against 
tip:master or tip:x86/build and submit the remaining patches as well?

Thanks,

	Ingo



=============>
commit b82b0b611740c7c88050ba743c398af7eb920029
Author: Nadav Amit <namit@vmware.com>
Date:   Wed Oct 3 14:31:00 2018 -0700

    x86/jump-labels: Macrofy inline assembly code to work around GCC inlining bugs
    
    As described in:
    
      77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")
    
    GCC's inlining heuristics are broken with common asm() patterns used in
    kernel code, resulting in the effective disabling of inlining.
    
    The workaround is to set an assembly macro and call it from the inline
    assembly block - which is also a minor cleanup for the jump-label code.
    
    As a result the code size is slightly increased, but inlining decisions
    are better:
    
          text     data     bss      dec     hex  filename
      18163528 10226300 2957312 31347140 1de51c4  ./vmlinux before
      18163608 10227348 2957312 31348268 1de562c  ./vmlinux after (+1128)
    
    And functions such as intel_pstate_adjust_policy_max(),
    kvm_cpu_accept_dm_intr(), kvm_register_readl() are inlined.
    
    Tested-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Nadav Amit <namit@vmware.com>
    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Andy Lutomirski <luto@amacapital.net>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Brian Gerst <brgerst@gmail.com>
    Cc: Denys Vlasenko <dvlasenk@redhat.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Kate Stewart <kstewart@linuxfoundation.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Philippe Ombredanne <pombredanne@nexb.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Link: http://lkml.kernel.org/r/20181003213100.189959-11-namit@vmware.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

commit dfc243615d43bb477d1d16a0064fc3d69ade5b3a
Author: Nadav Amit <namit@vmware.com>
Date:   Wed Oct 3 14:30:59 2018 -0700

    x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs
    
    As described in:
    
      77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")
    
    GCC's inlining heuristics are broken with common asm() patterns used in
    kernel code, resulting in the effective disabling of inlining.
    
    The workaround is to set an assembly macro and call it from the inline
    assembly block - which is pretty pointless indirection in the static_cpu_has()
    case, but is worth it to improve overall inlining quality.
    
    The patch slightly increases the kernel size:
    
          text     data     bss      dec     hex  filename
      18162879 10226256 2957312 31346447 1de4f0f  ./vmlinux before
      18163528 10226300 2957312 31347140 1de51c4  ./vmlinux after (+693)
    
    And enables the inlining of function such as free_ldt_pgtables().
    
    Tested-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Nadav Amit <namit@vmware.com>
    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Andy Lutomirski <luto@amacapital.net>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Brian Gerst <brgerst@gmail.com>
    Cc: Denys Vlasenko <dvlasenk@redhat.com>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Link: http://lkml.kernel.org/r/20181003213100.189959-10-namit@vmware.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

commit 4021bdcd351fd63d8d5e74264ee18d09388f0221
Author: Nadav Amit <namit@vmware.com>
Date:   Wed Oct 3 14:30:58 2018 -0700

    x86/extable: Macrofy inline assembly code to work around GCC inlining bugs
    
    As described in:
    
      77b0bf55bc67: ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")
    
    GCC's inlining heuristics are broken with common asm() patterns used in
    kernel code, resulting in the effective disabling of inlining.
    
    The workaround is to set an assembly macro and call it from the inline
    assembly block - which is also a minor cleanup for the exception table
    code.
    
    Text size goes up a bit:
    
          text     data     bss      dec     hex  filename
      18162555 10226288 2957312 31346155 1de4deb  ./vmlinux before
      18162879 10226256 2957312 31346447 1de4f0f  ./vmlinux after (+292)
    
    But this allows the inlining of functions such as nested_vmx_exit_reflected(),
    set_segment_reg(), __copy_xstate_to_user() which is a net benefit.
    
    Tested-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Nadav Amit <namit@vmware.com>
    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Andy Lutomirski <luto@amacapital.net>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Brian Gerst <brgerst@gmail.com>
    Cc: Denys Vlasenko <dvlasenk@redhat.com>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Link: http://lkml.kernel.org/r/20181003213100.189959-9-namit@vmware.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

