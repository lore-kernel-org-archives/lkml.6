Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3455337-1526628042-2-13190635391574274167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526628042; b=P7PW2KoQp4TQsqnmbmrdgQCX3l4qGXA2ntOCP2KeP+8fb+zqTU
    BGQffHRk252AMuJ5vbjWn7hPO/7ZZjZzhcMn9SxWalMT6Y5b6yKslVhYqRIp7TkO
    +1XjiJ6u8cS+tnzkmNpX2iketqND6oWDkoZrnzs4TGPHZP4ulnKXoXXdVfCCC8cU
    cQG1dBXk7Dqmu8FEksJDsOeLXYmmvS7sYXUIlaJV1xhYnEvKcXv4MTaZ+OD2H226
    hL9OF41PLZU7jMXGOTJptp1sO3OuCezl7lVZmjaMENay5fx61S9subAuGhFR6oZw
    l7MX87l3YZikTqUgLX9qtUO0cHda82iktsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526628042; bh=rhCiMGhYcHNcPPWmaaTlyd18zyH42t
    0pF03IGFVqYuk=; b=isOf4fSQlCQgEmvQNaLsIDwfPrCtJ8ALflHEKWdUiZoRrt
    jD4NLGqIqslMdFFXxVM6Q28IqTKm3L0OANM1ntoWmajcW2RozyAVSNJkQWcel/EY
    XnSA/CMHlUXMzsUzkOL0GVT2GuS95Mw8fe2nPVrBdBnX11cTbVmm/flx+yA84HDP
    SHTaLUHUQoYNjBofdukJnSN2TCBo36UAf4FlldlBW/ZmLT+jOvJ89ODAa8TH+bEn
    a/U3R6YYRrhU7KuZsWRkA9si7glp3Lx6HCHosoEugzK3Avc1qiovrL4Ut3skD96X
    EcMZR+Fbuc0QZuWxNI+1TdQSD1ckeF3AeS/nA55Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=vVHnojPl x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Va8qZo1l;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=vVHnojPl x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Va8qZo1l;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLY3UnuQXmZ8lrdlR55A0+EABuTfJAF74XKC10uglTlT33gJSuH1190sgKETBtRto0yRWEVrZs0mnTn9nWoVZCTkQJDMNgTIRQBndTvwSUpciK3Wbs4e
    8DRJMvNS12U+0165iIyRodHLS6NKPK9h7fFM/lCq+3b4DMGVmFbudbpjACFig0WrW00cjkhYpz9j8s8hbFBRwazDK4IPvHFpW6lSJ52wtqX6VQg2Qj2+8BOB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=2Djirvd6ItAA:10 a=VUJBJC2UJ8kA:10 a=6rqHouBjAAAA:8 a=pGLkceISAAAA:8
    a=oGMlB6cnAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=37rDS-QxAAAA:8
    a=VwQbUJbxAAAA:8 a=xjQjg--fAAAA:8 a=n2GhSfulAAAA:8 a=8WYiZWZhN1W3HIF0KK4A:9
    a=CjuIK1q_8ugA:10 a=Hx1yvPaMooE3kwe23bt7:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=k1Nq6YrhK2t884LQW06G:22 a=AjGcO6oz07-iQ99wixmX:22 a=L4vkcYpMSA5nFlNZ2tk3:22
    a=9NqWk_7B-uqI6kdQTXIl:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeERHUi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 03:20:38 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40414 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeERHUd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 03:20:33 -0400
X-Google-Smtp-Source: AB8JxZrS0G2+GnNNVyTk+kb4AqgrVeCbvxg6QoQ0YVRCyIPxbL/yEBV1z7+ktJ+eGxrGSl4DmBMVog==
Date: Fri, 18 May 2018 10:20:26 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, Alexey Izbyshev <izbyshev@ispras.ru>,
        Alexander Monakov <amonakov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
Message-ID: <20180518072026.GY31735@uranus>
References: <20180517233510.24996-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517233510.24996-1-dima@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 12:35:10AM +0100, Dmitry Safonov wrote:
> The x86 mmap() code selects the mmap base for an allocation depending on
> the bitness of the syscall. For 64bit sycalls it select mm->mmap_base and
> for 32bit mm->mmap_compat_base.
> 
> exec() calls mmap() which in turn uses in_compat_syscall() to check whether
> the mapping is for a 32bit or a 64bit task. The decision is made on the
> following criteria:
> 
>   ia32    child->thread.status & TS_COMPAT
>    x32    child->pt_regs.orig_ax & __X32_SYSCALL_BIT
>   ia64    !ia32 && !x32
> 
> __set_personality_x32() was dropping TS_COMPAT flag, but
> set_personality_64bit() has kept compat syscall flag making
> in_compat_syscall() return true during the first exec() syscall.
> 
> Which in result has user-visible effects, mentioned by Alexey:
> 1) It breaks ASAN
> $ gcc -fsanitize=address wrap.c -o wrap-asan
> $ ./wrap32 ./wrap-asan true
> ==1217==Shadow memory range interleaves with an existing memory mapping. ASan cannot proceed correctly. ABORTING.
> ==1217==ASan shadow was supposed to be located in the [0x00007fff7000-0x10007fff7fff] range.
> ==1217==Process memory map follows:
>         0x000000400000-0x000000401000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
>         0x000000600000-0x000000601000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
>         0x000000601000-0x000000602000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
>         0x0000f7dbd000-0x0000f7de2000   /lib64/ld-2.27.so
>         0x0000f7fe2000-0x0000f7fe3000   /lib64/ld-2.27.so
>         0x0000f7fe3000-0x0000f7fe4000   /lib64/ld-2.27.so
>         0x0000f7fe4000-0x0000f7fe5000
>         0x7fed9abff000-0x7fed9af54000
>         0x7fed9af54000-0x7fed9af6b000   /lib64/libgcc_s.so.1
> [snip]
> 
> 2) It doesn't seem to be great for security if an attacker always knows
> that ld.so is going to be mapped into the first 4GB in this case
> (the same thing happens for PIEs as well).
> 
> The testcase:
> $ cat wrap.c
> 
> int main(int argc, char *argv[]) {
>   execvp(argv[1], &argv[1]);
>   return 127;
> }
> 
> $ gcc wrap.c -o wrap
> $ LD_SHOW_AUXV=1 ./wrap ./wrap true |& grep AT_BASE
> AT_BASE:         0x7f63b8309000
> AT_BASE:         0x7faec143c000
> AT_BASE:         0x7fbdb25fa000
> 
> $ gcc -m32 wrap.c -o wrap32
> $ LD_SHOW_AUXV=1 ./wrap32 ./wrap true |& grep AT_BASE
> AT_BASE:         0xf7eff000
> AT_BASE:         0xf7cee000
> AT_BASE:         0x7f8b9774e000
> 
> Fixes:
> commit 1b028f784e8c ("x86/mm: Introduce mmap_compat_base() for 32-bit mmap()")
> commit ada26481dfe6 ("x86/mm: Make in_compat_syscall() work during exec")
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: <linux-mm@kvack.org>
> Cc: <x86@kernel.org>
> Cc: <stable@vger.kernel.org> # v4.12+
> Reported-by: Alexey Izbyshev <izbyshev@ispras.ru>
> Bisected-by: Alexander Monakov <amonakov@ispras.ru>
> Investigated-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@openvz.org>

Thanks a lot! (At first I had to scratch my head for a second
to realize that the key moment is executing 64 bit application
from inside of a compat process :-)
