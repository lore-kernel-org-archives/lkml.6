Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2887293-1526600450-2-9623191608191346100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526600449; b=jL60vaaEajoVbr8E2NFJfIzPAOGO+K03EB2WIbMKIWKBB2+bP7
    vHd9CvzU6Tfy2AA5Nbwc2eYbe6yUOEmltrTwfv5QXiPpI56xdkMPVhvN2qdC1jXY
    vgd+fJLzaWXRg4UrXzVUXYotQMam+q6xua1G17eNjx1153qlP80yEsELARwJdRTa
    TuGGibjWSx+2kTbWSw4ZrkrA6rTscZJsCJkRotAX/LOSTl7dhny7ewaKf3L82v33
    GjSfE+UXDXtytFiiGvckCBDV/h2Pn8etRAkuQeFGTapccfyeEPlgXLf5KPoXMvs6
    XXauuSnnyVSZJ+0g7EqXDABBXnhUyilTIgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526600449;
    bh=HeoAyG+vrT5L4SuajmcNI7Kjt52J83dmCJbhoAkiFTo=; b=EFWVZi8zsAwj
    DHRlFV+wyNPXIpz4pS6izGVXY+WAgIPJ2EP+e9dmO/2i0v8JC3hmSMMm6Q12m9O5
    UXY5FM6HN2JP/pW4jJcVO7621etalJTL9nJo96V0CmzjJBjVkdIIkeeW9hTM93BB
    wlxA+o9cpIORo5DaDjBzJgGWSCw3vAWrdpWJ3/MOABLOytAmKkN8+jxPIBYMkH/r
    +sLXKWmfVZ2fwf/nGo4MdZp2BudqdYLPlhUqrBUBm9YSTYefQFKG0HtcKBHDbStM
    vcr4rd+dfEHC/+Nb3EEUlEiwwR5q4eaGtR4c0FhxS02rIYZ3H1VTfcNkDZxVOKVp
    OtPPe4dtzA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=arista.com
    header.i=@arista.com header.b=g4w1STJ9 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=googlenew;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=arista.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=hizVuZW3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arista.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=arista.com
      header.i=@arista.com header.b=g4w1STJ9 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=googlenew;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=arista.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=hizVuZW3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arista.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCEi3MFtZIpa6NudcMK2zNlu3nTMxwRQPz2iyF1sV9kv50Z5ymwSo38VFi5+KUhHAsMmPGkILmVcJiazaM+mNMbb8QaoO8kgA7WrTnB6OaiVkfOVNyBG
    CO72nVTsLPNlt7160noLTyj+EO/ebjESHs3kxTuRRFIdwDFHtl6B7pOcKHovnLU4B/Ykm4d5QC96zbicij4XUVqsPrv1FdWKsLlxoulBSVvwP3cpNL9ul58h
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=6rqHouBjAAAA:8 a=pGLkceISAAAA:8 a=oGMlB6cnAAAA:8 a=20KFwNOVAAAA:8
    a=QyXUC8HyAAAA:8 a=37rDS-QxAAAA:8 a=VwQbUJbxAAAA:8 a=xjQjg--fAAAA:8
    a=n2GhSfulAAAA:8 a=WvB_LDz2on7dndpH3KMA:9 a=QEXdDO2ut3YA:10
    a=Hx1yvPaMooE3kwe23bt7:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=k1Nq6YrhK2t884LQW06G:22
    a=AjGcO6oz07-iQ99wixmX:22 a=L4vkcYpMSA5nFlNZ2tk3:22 a=9NqWk_7B-uqI6kdQTXIl:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEQXkq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 19:40:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51930 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQXkp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 19:40:45 -0400
X-Google-Smtp-Source: AB8JxZp2a4sMc46S1xmRu+Obk1G/ww4dtt1CbtaNB/oAxomZulIa3/TZPqm30JcU+V+ixUjD7dbOJg==
Message-ID: <1526600442.28243.39.camel@arista.com>
Subject: Re: [PATCH] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: Alexey Izbyshev <izbyshev@ispras.ru>,
        Alexander Monakov <amonakov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        x86@kernel.org, stable@vger.kernel.org
Date: Fri, 18 May 2018 00:40:42 +0100
In-Reply-To: <20180517233510.24996-1-dima@arista.com>
References: <20180517233510.24996-1-dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-18 at 00:35 +0100, Dmitry Safonov wrote:
> The x86 mmap() code selects the mmap base for an allocation depending
> on
> the bitness of the syscall. For 64bit sycalls it select mm->mmap_base 
> and
> for 32bit mm->mmap_compat_base.
> 
> exec() calls mmap() which in turn uses in_compat_syscall() to check
> whether
> the mapping is for a 32bit or a 64bit task. The decision is made on
> the
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
> ==1217==Shadow memory range interleaves with an existing memory
> mapping. ASan cannot proceed correctly. ABORTING.
> ==1217==ASan shadow was supposed to be located in the
> [0x00007fff7000-0x10007fff7fff] range.
> ==1217==Process memory map follows:
>         0x000000400000-0x000000401000   /home/izbyshev/test/gcc/asan-
> exec-from-32bit/wrap-asan
>         0x000000600000-0x000000601000   /home/izbyshev/test/gcc/asan-
> exec-from-32bit/wrap-asan
>         0x000000601000-0x000000602000   /home/izbyshev/test/gcc/asan-
> exec-from-32bit/wrap-asan
>         0x0000f7dbd000-0x0000f7de2000   /lib64/ld-2.27.so
>         0x0000f7fe2000-0x0000f7fe3000   /lib64/ld-2.27.so
>         0x0000f7fe3000-0x0000f7fe4000   /lib64/ld-2.27.so
>         0x0000f7fe4000-0x0000f7fe5000
>         0x7fed9abff000-0x7fed9af54000
>         0x7fed9af54000-0x7fed9af6b000   /lib64/libgcc_s.so.1
> [snip]
> 
> 2) It doesn't seem to be great for security if an attacker always
> knows
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
> commit 1b028f784e8c ("x86/mm: Introduce mmap_compat_base() for 32-bit 
> mmap()")
> commit ada26481dfe6 ("x86/mm: Make in_compat_syscall() work during
> exec")
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

I've tested it on master with:
- the reproducer
- x86 selftests
- criu

Some selftests are failing, but the same way as before the patch
(ITOW, it's not regression):
[root@localhost self]# grep FAIL out 
[FAIL]	Reg 1 mismatch: requested 0x0; got 0x3
[FAIL]	Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
0xffffff425aadc0de
[FAIL]	Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
0xffffff425aadc0de
[FAIL]	Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
0xffffff425aadc0de
[FAIL]	f[u]comi[p] errors: 1
[FAIL]	fisttp errors: 1
[FAIL]	R8 has changed:0000000000000000
[FAIL]	R9 has changed:0000000000000000
[FAIL]	R10 has changed:0000000000000000
[FAIL]	R11 has changed:0000000000000000
[FAIL]	R8 has changed:0000000000000000
[FAIL]	R9 has changed:0000000000000000
[FAIL]	R10 has changed:0000000000000000
[FAIL]	R11 has changed:0000000000000000

I think, R8-R11 are not preserved yet in master?
Not quite sure about register mismatches :-/
Also ia32-criu has a fail, which I need to look into (but not a
regression).

-- 
Thanks,
             Dmitry
