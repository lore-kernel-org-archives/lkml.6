Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2887293-1526600119-2-18437716024022477718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526600118; b=fyEB3V8pDb0rM7NYykIooJi1AB4+KOc7Af+35Z033G3R8EQbk3
    TYmJNcm9yXyssGk7lJZuKjuaGAmHcWynFgQYrD+hTS25hA27KCfr8v574oKSfFPu
    kzEbVkoeV7rD6r+zy1L/XLaDpwvaw+3hEAM4W6dahOREj154JWTWIyf7tvoJtuuw
    18WNsi22kwxmLrtmB3cI+FCKQx7uuUqdp7xXneud57ExtyZgCpO8qvC0aQRR87UD
    6rh9rMh1LTbUfz0ZvdZbMRvv8hqOHrwec3FGbyIcbksSN5f+316l8mEx4jt6j+C3
    1zrLvk9ecNs5xJ2EUcUAOJV679ZJ+4hN+wlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526600118; bh=F3WqJG4Q+uKhFRw6T4rz6O4CbCCel3
    IP4qlvMIAabDc=; b=Vfq+ermRb8bkMs86s2Pr2sUPJYlYOCrAvzDAIF1PvK7vUu
    ahhkjxMeY9zDTNSkM+LpgVwQhm6MCE24rPgKTIjQdjWR4Tk8+GHpQujl1xFZw7kw
    vhfkVdgWRIxrmcLLjrlbHoKtqY5FOFTj9tof2pmD+tXv8UfeUtQcI+WwTXGwegZV
    egbhDfidWiKMPUZFb99xCn+gpQTiXunk8WgqtJvytlDqTjh7ZmiHHb9r0CirrG6T
    M/o/sz1CCv6ru/dkLDNoO4jGwOjIm+c7jyqucFnviUjXKOrTdmLb/fiJH5pr59Tc
    1Dr5PK2cMCIOeOhfgoO9ZPisob8WCUDaC6Gzbreg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=arista.com
    header.i=@arista.com header.b=dbNw/wv/ x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=googlenew;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=arista.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=L19wfogI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arista.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=arista.com
      header.i=@arista.com header.b=dbNw/wv/ x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=googlenew;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=arista.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=L19wfogI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arista.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHDzoJt14xc8ZCLueN1SG+MXtqExzMErTcl/G9ixO+t2gr4XYDtP7tfQWK3zeHHannz7dsZ+EyzhjmVoJ5Rf/xDvRnqvEZiyM8F2KlvY7YTR2IjpJ+5F
    zeAUtBT+2F7AOfMSAMi0gjjR7GdOwJW+Evb6rY5Tt4Llf9iLxi/O6/rmRyjURSpPZPGFp+2H4bB3Y1Y5vjBe++6yklotWqU7yC2s/zP6xTEfi7GntHoNouy4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=6rqHouBjAAAA:8
    a=pGLkceISAAAA:8 a=oGMlB6cnAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
    a=37rDS-QxAAAA:8 a=VwQbUJbxAAAA:8 a=xjQjg--fAAAA:8 a=n2GhSfulAAAA:8
    a=-Jv3JYRLCU2IalZc48MA:9 a=Hx1yvPaMooE3kwe23bt7:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=k1Nq6YrhK2t884LQW06G:22 a=AjGcO6oz07-iQ99wixmX:22 a=L4vkcYpMSA5nFlNZ2tk3:22
    a=9NqWk_7B-uqI6kdQTXIl:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeEQXfO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 19:35:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51285 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQXfN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 19:35:13 -0400
X-Google-Smtp-Source: AB8JxZogIEdv2ijCuervgtsG5tDDT10PC8KZBl4+Xw5rt0E/99/ahDw0NJXKfiw+x4Pc585KXwpvtg==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <dima@arista.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Alexander Monakov <amonakov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        x86@kernel.org, stable@vger.kernel.org
Subject: [PATCH] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
Date: Fri, 18 May 2018 00:35:10 +0100
Message-Id: <20180517233510.24996-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The x86 mmap() code selects the mmap base for an allocation depending on
the bitness of the syscall. For 64bit sycalls it select mm->mmap_base and
for 32bit mm->mmap_compat_base.

exec() calls mmap() which in turn uses in_compat_syscall() to check whether
the mapping is for a 32bit or a 64bit task. The decision is made on the
following criteria:

  ia32    child->thread.status & TS_COMPAT
   x32    child->pt_regs.orig_ax & __X32_SYSCALL_BIT
  ia64    !ia32 && !x32

__set_personality_x32() was dropping TS_COMPAT flag, but
set_personality_64bit() has kept compat syscall flag making
in_compat_syscall() return true during the first exec() syscall.

Which in result has user-visible effects, mentioned by Alexey:
1) It breaks ASAN
$ gcc -fsanitize=address wrap.c -o wrap-asan
$ ./wrap32 ./wrap-asan true
==1217==Shadow memory range interleaves with an existing memory mapping. ASan cannot proceed correctly. ABORTING.
==1217==ASan shadow was supposed to be located in the [0x00007fff7000-0x10007fff7fff] range.
==1217==Process memory map follows:
        0x000000400000-0x000000401000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
        0x000000600000-0x000000601000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
        0x000000601000-0x000000602000   /home/izbyshev/test/gcc/asan-exec-from-32bit/wrap-asan
        0x0000f7dbd000-0x0000f7de2000   /lib64/ld-2.27.so
        0x0000f7fe2000-0x0000f7fe3000   /lib64/ld-2.27.so
        0x0000f7fe3000-0x0000f7fe4000   /lib64/ld-2.27.so
        0x0000f7fe4000-0x0000f7fe5000
        0x7fed9abff000-0x7fed9af54000
        0x7fed9af54000-0x7fed9af6b000   /lib64/libgcc_s.so.1
[snip]

2) It doesn't seem to be great for security if an attacker always knows
that ld.so is going to be mapped into the first 4GB in this case
(the same thing happens for PIEs as well).

The testcase:
$ cat wrap.c

int main(int argc, char *argv[]) {
  execvp(argv[1], &argv[1]);
  return 127;
}

$ gcc wrap.c -o wrap
$ LD_SHOW_AUXV=1 ./wrap ./wrap true |& grep AT_BASE
AT_BASE:         0x7f63b8309000
AT_BASE:         0x7faec143c000
AT_BASE:         0x7fbdb25fa000

$ gcc -m32 wrap.c -o wrap32
$ LD_SHOW_AUXV=1 ./wrap32 ./wrap true |& grep AT_BASE
AT_BASE:         0xf7eff000
AT_BASE:         0xf7cee000
AT_BASE:         0x7f8b9774e000

Fixes:
commit 1b028f784e8c ("x86/mm: Introduce mmap_compat_base() for 32-bit mmap()")
commit ada26481dfe6 ("x86/mm: Make in_compat_syscall() work during exec")

Cc: Borislav Petkov <bp@suse.de>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <linux-mm@kvack.org>
Cc: <x86@kernel.org>
Cc: <stable@vger.kernel.org> # v4.12+
Reported-by: Alexey Izbyshev <izbyshev@ispras.ru>
Bisected-by: Alexander Monakov <amonakov@ispras.ru>
Investigated-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4b100fe0f508..12bb445fb98d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -542,6 +542,7 @@ void set_personality_64bit(void)
 	clear_thread_flag(TIF_X32);
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
+	current_thread_info()->status &= ~TS_COMPAT;
 
 	/* Ensure the corresponding mm is not marked. */
 	if (current->mm)
-- 
2.13.6
