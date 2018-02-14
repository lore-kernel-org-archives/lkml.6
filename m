Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3959515-1518646350-2-3483747358561298083
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518646349; b=o/kJlkWyNT36mlctZvKRVarqUpxUObzJw5a4z7sT9PjS9wR
    ULoyObApKcw3AphehR7g4uk32ePSLW5A9/MXEuaNeB0RuF1HEADbGNj2teEwZVL6
    o5YGwEvl0oDK2vr050CbflVFblurmXy4KWMW5+3XPXL96ryFFRbYnZdxFS6BBXoV
    dpIloU7O+glfewe4mRku+HlYpnl4RI7+YHdVN46DYtw2NyBngEd7BGA4fk+IJ9cJ
    HQ21cLghHH/I5zXIPZzD5cmlPeIjKaEFLYEcmEMskzYdq+qT/s7bAPBSNwICEYBw
    +B3CG4YOl3tYNsPkjwmysVZxgcftScA6yFUDYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518646349; bh=G5hLyay3RrNNa7HTJPN9K5H9fkP5CurdS++oRG
    reEGc=; b=SyOAcNp9v9UDv/CEqbJAE15YPLE9jEPFCcfCRISNjkkp/Yd1TlafUe
    kbnTBS9BZ1maEwFV2hl80Pctt2wG8VbfUd7RZd7HL8mTvk4lZhmP/lxarNPZKnPq
    Bl3eOck4DFM7j+RYw98IPe0mhgacQg8ilslz21gcpCAuUreoUfIIQZbFGutM81rF
    MyaLTcgTSDCDPi5r8lHfMi1OQR86IgzcIWkUx4BX+UDskRZf+SbLTM7KX5hCEjLb
    HBGALkddWKpr4VYcxKrdzg4Hey0I13e8o7D97Qs4ZhWcqwCdy3xkdgZoWBQZoi5F
    oZIemuKlQ0yscahUMX3OTwD8UH+X+t0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rq23iSe2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cZDcdYvP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rq23iSe2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cZDcdYvP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031554AbeBNWM1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 17:12:27 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41162 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031551AbeBNWM0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 17:12:26 -0500
X-Google-Smtp-Source: AH8x224agkTdkXXMr83hnB0YZcZa81FE7SGhf1ywA/Arw+5pyDkFmMUZ56V58odh6e8fK5uAvPYibBeCzgbHpSlnN4s=
MIME-Version: 1.0
In-Reply-To: <af5124d4-b2cc-7d3c-5b8e-f7381859efd6@linux.intel.com>
References: <20171206141627.688219-1-arnd@arndb.de> <CAK8P3a0ZN2ALu1tj9sm8-Lt9SsRgpbQtz91zR4MhY-Np7TQNyg@mail.gmail.com>
 <af5124d4-b2cc-7d3c-5b8e-f7381859efd6@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 23:12:24 +0100
X-Google-Sender-Auth: QmZXnjzvM6YV4eq6D1jme7KK0q8
Message-ID: <CAK8P3a3pyM2FwHcAvFQckvbfqt7WvgRYSWE97pwLAtdvd77ToQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/kaiser: avoid 32-bit/PAE build warning
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Dec 6, 2017 at 4:08 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
> On 12/06/2017 07:03 AM, Arnd Bergmann wrote:
>> On Wed, Dec 6, 2017 at 3:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> This changes the type to u64 in the architecture-independent dummy,
>>> and to pteval_t in the x86 specific portion that is used when KAISER
>>> is enabled, ensuring that the flags can always fit. Unfortunately,
>>> pteval_t is not provided by most other architectures, so we are
>>> a little bit inconsistent here.
>>
>> I ran into a new regression with my patch applied, after doing more randconfig
>> builds:
>>
>> In file included from /git/arm-soc/include/linux/kaiser.h:5,
>>                  from /git/arm-soc/arch/x86/events/intel/ds.c:4:
>> arch/x86/include/asm/kaiser.h:34:10: error: unknown type name
>> 'pteval_t'; did you mean 'dev_t'?
>>
>> Maybe it's better to just to the last one-line change in include/linux/kaiser.h.
>
> Hi Arnd,
>
> Are you hitting this in -next?
>
> The newest version of this code has a single kpti_init() function that
> shouldn't have any of these problems.

Coming back to an old thread...

I did some randconfig testing on 4.9.80, and now I see the same problem there,
since that version uses the KAISER patches rather than PTI:

/git/arm-soc/arch/x86/kernel/ldt.c: In function 'alloc_ldt_struct':
/git/arm-soc/arch/x86/include/asm/pgtable_types.h:208:24: error: large
integer implicitly truncated to unsigned type [-Werror=overflow]
 #define __PAGE_KERNEL  (__PAGE_KERNEL_EXEC | _PAGE_NX)
                        ^
/git/arm-soc/arch/x86/kernel/ldt.c:81:6: note: in expansion of macro
'__PAGE_KERNEL'
      __PAGE_KERNEL);
      ^~~~~~~~~~~~~

I also saw another warning:

/git/arm-soc/arch/x86/mm/kaiser.c: In function 'kaiser_init':
/git/arm-soc/arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot'
undeclared (first use in this function); did you mean
'massage_pgprot'?

I can send this as proper patches for inclusion in 4.9-stable, unless
someone has a better idea or finds a problem

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/linux/kaiser.h b/include/linux/kaiser.h
index 58c55b1589d0..b56c19010480 100644
--- a/include/linux/kaiser.h
+++ b/include/linux/kaiser.h
@@ -32,7 +32,7 @@ static inline void kaiser_init(void)
 {
 }
 static inline int kaiser_add_mapping(unsigned long addr,
-                                    unsigned long size, unsigned long flags)
+                                    unsigned long size, u64 flags)
 {
        return 0;
 }
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -13,7 +13,6 @@ extern void map_vsyscall(void);
  */
 extern bool emulate_vsyscall(struct pt_regs *regs, unsigned long address);
 extern bool vsyscall_enabled(void);
-extern unsigned long vsyscall_pgprot;
 #else
 static inline void map_vsyscall(void) {}
 static inline bool emulate_vsyscall(struct pt_regs *regs, unsigned
long address)
@@ -23,4 +22,6 @@ static inline bool emulate_vsyscall(struct pt_regs
*regs, unsigned long address)
 static inline bool vsyscall_enabled(void) { return false; }
 #endif

+extern unsigned long vsyscall_pgprot;
+
 #endif /* _ASM_X86_VSYSCALL_H */

      Arnd
