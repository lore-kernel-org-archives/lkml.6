Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2329085-1517957567-2-5328038648167152795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517957566; b=VDhFIsfVUIJa06EjYoZTuCy4DdFxu5fRiv94MsZivVjWESr
    dz8XGdigzmtN+kL9heVyyrm9Sh3HQDEzxUB8bD/fiTa83i8j04YlPmuRaqHtQYJD
    koLP4sq21CfRMbuPOEzcGD6IEN1c0gCPzSOs1VK29n31DPH9Ju/qsp735uGAN/Sw
    mOCrJLkg8Lil9p2FLxwR7gJfxigh4vYWU65z8mZo/ptXYProy4yuRWpZdb9dAtMZ
    pCQv92zFn9C2Pwpl8skJqgnZBC5TTzMllkNZJHU95qxRAkem5l9pxel1rFvxq0QW
    8jIpCVk9p/PhtOSgnNTXAbxgNfiLwodKRL7OJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517957566; bh=xOCUPAHTi5SbSBOGEb1JP/VkEi
    KN+D2KMDAC1XKoYI8=; b=JepxWu/lxN/omC/ADdjygIgl7Ol9tRwHma+JvrBCRZ
    JNbOtyMeGcxD1pFfOIHqiTXas3XIHyCzjGJOg7WcByHkIFRuvHVSPcf5h9mjRFD2
    z6vTOFw4Z6WqsqDm883vEOgH3fCm2YuXWQD387Lvgh28WuYAVpykiGBXGe30Drxo
    PgsIJVKn6LjDoNpKj9vHcQOA18MIroFLpmSsjlqobRMdanX18Rl9gH7mjdmgQhfa
    d92FHmR1uvTU/uVLgR4Kj97DAwubLXBl5IrYOInl0DBW/bJpbdFSTA4oh97G/DTA
    GbL9ighipwtmcO7bCDW5IFc4xEiaPNtn1Etc5lR485ew==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbeBFWwp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 17:52:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbeBFWwo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 17:52:44 -0500
Date: Tue, 6 Feb 2018 14:52:43 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.ku>,
        Razvan Ghitulete <rga@amazon.de>,
        Guenter Roeck <groeck@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Hackmann <ghackmann@google.com>
Subject: Re: [PATCH 4.4 05/53] x86/asm: Use register variable to get stack
 pointer value
Message-ID: <20180206225243.GA7743@kroah.com>
References: <20180122083910.299610926@linuxfoundation.org>
 <20180122083910.527513802@linuxfoundation.org>
 <20180206215941.GA99249@google.com>
 <20180206223706.GC23990@kroah.com>
 <20180206224845.GA116483@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206224845.GA116483@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 02:48:45PM -0800, Matthias Kaehlcke wrote:
> El Tue, Feb 06, 2018 at 02:37:06PM -0800 Greg Kroah-Hartman ha dit:
> 
> > On Tue, Feb 06, 2018 at 01:59:41PM -0800, Matthias Kaehlcke wrote:
> > > Hi Greg,
> > > 
> > > El Mon, Jan 22, 2018 at 09:39:57AM +0100 Greg Kroah-Hartman ha dit:
> > > 
> > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > > 
> > > > commit 196bd485ee4f03ce4c690bfcf38138abfcd0a4bc upstream.
> > > > 
> > > > Currently we use current_stack_pointer() function to get the value
> > > > of the stack pointer register. Since commit:
> > > > 
> > > >   f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")
> > > > 
> > > > ... we have a stack register variable declared. It can be used instead of
> > > > current_stack_pointer() function which allows to optimize away some
> > > > excessive "mov %rsp, %<dst>" instructions:
> > > > 
> > > >  -mov    %rsp,%rdx
> > > >  -sub    %rdx,%rax
> > > >  -cmp    $0x3fff,%rax
> > > >  -ja     ffffffff810722fd <ist_begin_non_atomic+0x2d>
> > > > 
> > > >  +sub    %rsp,%rax
> > > >  +cmp    $0x3fff,%rax
> > > >  +ja     ffffffff810722fa <ist_begin_non_atomic+0x2a>
> > > > 
> > > > Remove current_stack_pointer(), rename __asm_call_sp to current_stack_pointer
> > > > and use it instead of the removed function.
> > > > 
> > > > Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > > Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Link: http://lkml.kernel.org/r/20170929141537.29167-1-aryabinin@virtuozzo.com
> > > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > > [dwmw2: We want ASM_CALL_CONSTRAINT for retpoline]
> > > > Signed-off-by: David Woodhouse <dwmw@amazon.co.ku>
> > > > Signed-off-by: Razvan Ghitulete <rga@amazon.de>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > We recently merged this patch to the Chrome OS kernel tree and it
> > > broke our x86 builds with clang:
> > > 
> > > arch/x86/include/asm/asm.h:116:50: error: register 'rsp' unsuitable for global register variables on this target
> > > register unsigned long current_stack_pointer asm(_ASM_SP);
> > >                                                  ^
> > > arch/x86/include/asm/asm.h:41:18: note: expanded from macro '_ASM_SP'
> > > #define _ASM_SP         __ASM_REG(sp)
> > >                         ^
> > > arch/x86/include/asm/asm.h:24:32: note: expanded from macro '__ASM_REG'
> > > #define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)
> > >                                ^
> > > arch/x86/include/asm/asm.h:19:29: note: expanded from macro '__ASM_SEL_RAW'
> > > # define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
> > >                             ^
> > > arch/x86/include/asm/asm.h:10:32: note: expanded from macro '__ASM_FORM_RAW'
> > > # define __ASM_FORM_RAW(x)     #x
> > >                                ^
> > > <scratch space>:4:1: note: expanded from here
> > > "rsp"
> > > ^
> > > 1 error generated.
> > > 
> > > 
> > > This can be fixed by also integrating the following patch:
> > > 
> > > commit 520a13c530aeb5f63e011d668c42db1af19ed349
> > > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Date:   Thu Sep 28 16:58:26 2017 -0500
> > > 
> > >     x86/asm: Fix inline asm call constraints for GCC 4.4
> > > 
> > > 
> > > Admittedly a v4.4 kernel built with clang + LTS merges is a very
> > > special case and we can fix this in Chrome OS by integrating the above
> > > patch locally. Still it would be good to get it into stable to avoid
> > > others from running into this, especially since the fix is very
> > > simple.
> > > 
> > > Actually I just noticed that the patch also isn't in v4.9, which could
> > > extend the number of affected 'users' significantly, so I think we
> > > almost certainly want Josh's patch in stable.
> > 
> > That patch doesn't apply cleanly to the 4.4.y or 4.9.y trees anymore.
> > It seems that only one hunk of it is really needed, the #ifndef change,
> > right?  If so, I'll be glad to apply that portion.
> 
> Indeed, only the #ifndef change is needed.

Great, thanks for verifying, now queued up.

greg k-h
