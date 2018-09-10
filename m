Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CCFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E7720866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIx3RFiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E7720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeIKCxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:53:08 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37000 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeIKCxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:53:08 -0400
Received: by mail-pl1-f181.google.com with SMTP id f1-v6so10346236plt.4;
        Mon, 10 Sep 2018 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7OLEc4fdAnMdwAASrTlPUVV7zYeOqLpytr1A/wAoTHw=;
        b=cIx3RFiCbbOTTdQw6rSqMpNlHfj426biYe6hFQBNRj92Qsydg4aHzsj2iLK+m6eAz8
         tQa4H0Xn5A/uEDy0ihYu5RQlI3L/CoUvE0AD7S0VcYyOKN6qq5xy3JLbP7GolKVM9wFY
         OZgzhNYKkU21V+qBxR7M0qSTrbf3Rqo05xoQYbb12hr1p0my7pQZjms4Z7LNAHgV9TkX
         wLrESZ454M74WhA5NGZt8u3cuRYlCDL8pAArkxpo1UhlxBb90Alx0i4zB68WLKyEMARw
         GwxFScNd+ZJw72lFEbLCN0C1AGw0Sqqs1KV+CVoqbrCaOUuMEEmpS3jeT+AUXtorAkF8
         TawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7OLEc4fdAnMdwAASrTlPUVV7zYeOqLpytr1A/wAoTHw=;
        b=bs1n3CM9jIaFey4C/pMJm115olgkZnd8whnSqdU8OkusVAIWAX/FiKoHoLe2JCxc8Q
         e6JWl7eDjjjefJLS2XLmw6kSYa4d0ToCvbCvc9zzjhv9s4A3CtFN+OJbqhWrbnUd7ZNG
         C4qrowUGbB7xCJh7uq1sIL/oXuSClATWMUkpbl+256VqcOzTJf9Fbd/qyqotKBmCMJWn
         WL7MBSpNAgFDSGVRuq8zlOkJ8B0NaVj3k1aYwWcdTTcWw2xfH6nUtJO5oNOAEAIV1BnZ
         zG6czkgyRRwdX7i2ydO5sRD0ozPY7BiHszS2lcJKTLQXBdgg17dzHKVouLLDIs6KXNsc
         tSjw==
X-Gm-Message-State: APzg51AW75FZN6nKu2JaXXKZwGMlncJha16ZTM5jeLq0vV/q737IAHsy
        IUgmYOv7bYiMM2g20YoWoK3/ZYTc
X-Google-Smtp-Source: ANB0VdYKpOS/EXVacirpB/C4uNChZ5J/hAJQqVLRTe8xwImuDBdicuez3Fi4mqZpxLibA//rPBYb7A==
X-Received: by 2002:a17:902:8215:: with SMTP id x21-v6mr23538246pln.175.1536616621717;
        Mon, 10 Sep 2018 14:57:01 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p3-v6sm21731332pfo.130.2018.09.10.14.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:57:00 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:56:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Random crashes with i386 and efi boots
Message-ID: <20180910215659.GA17966@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

even after commit eeb89e2bb1ac ("x86/efi: Load fixmap GDT in
efi_call_phys_epilog()"), my i386/efi qemu boot tests still crash randomly
(roughly 5-10% of the time). As before, I don't see much useful output in
the qemu log (this time it doesn't even complain about a triple fault). 

Debugging shows that the crash happens in efi_call_phys_epilog().
A sample log from a crashed test run is attached below. It appears that
the crash happens if there is an interrupt at a critical section of the
code.

While playing with the code, I found a possible fix.

diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 05ca14222463..9959657127f4 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -85,10 +85,9 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
 {
+	load_fixmap_gdt(0);
 	load_cr3(save_pgd);
 	__flush_tlb_all();
-
-	load_fixmap_gdt(0);
 }

This restores the execution order prior to commit eeb89e2bb1ac.
I have no real idea what I am doing, so this change is to be taken with
a grain of salt. All I can say is that 100 boots with the above change
were successful while the current upstream code (v4.19-rc3) crashes on
a regular basis (in a controlled test I observed 6 failures out of 100
boots).

It would be great if someone with a bit more experience can have another
look and figure out the underlying problem. Please let me know if I can
provide additional information.

Thanks,
Guenter

----------------
IN:
# efi_call_phys_epilog(save_pgd);
0xd8f9c12c:  8b 45 f0                 movl     -0x10(%ebp), %eax
0xd8f9c12f:  e8 49 01 00 00           calll    0xd8f9c27d

----------------
IN:
# efi_call_phys_epilog():
# load_cr3();
0xd8f9c27d:  55                       pushl    %ebp
0xd8f9c27e:  05 00 00 00 40           addl     $0x40000000, %eax
0xd8f9c283:  89 e5                    movl     %esp, %ebp
0xd8f9c285:  0f 22 d8                 movl     %eax, %cr3

CR3 update: CR3=1904e000
----------------
IN:
# __flush_tlb_all();
0xd8f9c288:  e8 c8 5e 2b ff           calll    0xd8252155

EAX=1904e000 EBX=00000000 ECX=d8f9c126 EDX=d8eafd60
ESI=1f09a000 EDI=00000030 EBP=d8e99f3c ESP=d8e99f3c
EIP=d8f9c288 EFL=00200207 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0068 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
FS =00d8 06c92000 ffffffff 008f9300 DPL=0 DS16 [-WA]
GS =00e0 dfcd09c0 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 00000000 00008200 DPL=0 LDT
TR =0080 ff803000 0000206b 00008900 DPL=0 TSS32-avl
GDT=     1fcc0000 000000ff
IDT=     ff800000 000007ff
CR0=80050033 CR2=ffd17000 CR3=1904e000 CR4=00040690
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
DR6=ffff0ff0 DR7=00000400
CCS=40000000 CCD=1904e000 CCO=ADDL
EFER=0000000000000000
Servicing hardware INT=0x30
  508: v=30 e=0000 i=0 cpl=0 IP=0060:d8f9c288 pc=d8f9c288 SP=0068:d8e99f3c env->regs[R_EAX]=1904e000
X=1904e000 EBX=00000000 ECX=d8f9c126 EDX=d8eafd60
ESI=1f09a000 EDI=00000030 EBP=d8e99f3c ESP=d8e99f3c
EIP=d8f9c288 EFL=00200207 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0068 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
FS =00d8 06c92000 ffffffff 008f9300 DPL=0 DS16 [-WA]
GS =00e0 dfcd09c0 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 00000000 00008200 DPL=0 LDT
TR =0080 ff803000 0000206b 00008900 DPL=0 TSS32-avl
GDT=     1fcc0000 000000ff
IDT=     ff800000 000007ff
CR0=80050033 CR2=ffd17000 CR3=1904e000 CR4=00040690
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
DR6=ffff0ff0 DR7=00000400
CCS=00000005 CCD=1904e000 CCO=EFLAGS
EFER=0000000000000000
check_exception old: 0xffffffff new 0xe
  509: v=0e e=0000 i=0 cpl=0 IP=0060:d8f9c288 pc=d8f9c288 SP=0068:d8e99f3c CR2=1fcc0060
EAX=1904e000 EBX=00000000 ECX=d8f9c126 EDX=d8eafd60
ESI=1f09a000 EDI=00000030 EBP=d8e99f3c ESP=d8e99f3c
EIP=d8f9c288 EFL=00200207 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0068 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
FS =00d8 06c92000 ffffffff 008f9300 DPL=0 DS16 [-WA]
GS =00e0 dfcd09c0 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 00000000 00008200 DPL=0 LDT
TR =0080 ff803000 0000206b 00008900 DPL=0 TSS32-avl
GDT=     1fcc0000 000000ff
IDT=     ff800000 000007ff
CR0=80050033 CR2=1fcc0060 CR3=1904e000 CR4=00040690
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
DR6=ffff0ff0 DR7=00000400
CCS=00000005 CCD=1904e000 CCO=EFLAGS
EFER=0000000000000000
check_exception old: 0xe new 0xe
  510: v=08 e=0000 i=0 cpl=0 IP=0060:d8f9c288 pc=d8f9c288 SP=0068:d8e99f3c env->regs[R_EAX]=1904e000
EAX=1904e000 EBX=00000000 ECX=d8f9c126 EDX=d8eafd60
ESI=1f09a000 EDI=00000030 EBP=d8e99f3c ESP=d8e99f3c
EIP=d8f9c288 EFL=00200207 [-----PC] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
CS =0060 00000000 ffffffff 00cf9a00 DPL=0 CS32 [-R-]
SS =0068 00000000 ffffffff 00cf9300 DPL=0 DS   [-WA]
DS =007b 00000000 ffffffff 00cff300 DPL=3 DS   [-WA]
FS =00d8 06c92000 ffffffff 008f9300 DPL=0 DS16 [-WA]
GS =00e0 dfcd09c0 00000018 00409100 DPL=0 DS   [--A]
LDT=0000 00000000 00000000 00008200 DPL=0 LDT
TR =0080 ff803000 0000206b 00008900 DPL=0 TSS32-avl
GDT=     1fcc0000 000000ff
IDT=     ff800000 000007ff
CR0=80050033 CR2=1fcc0060 CR3=1904e000 CR4=00040690
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
DR6=ffff0ff0 DR7=00000400
CCS=00000005 CCD=1904e000 CCO=EFLAGS
EFER=0000000000000000
check_exception old: 0x8 new 0xe

# qemu dies silently here

---

In another log, the code proceeeds a little further:

CR3 update: CR3=13668000
----------------
IN:
0xd35b6412:  e8 ae cb 29 ff           calll    0xd2852fc5

----------------
IN:
0xd35b6417:  31 c0                    xorl     %eax, %eax
0xd35b6419:  e8 12 2e 27 ff           calll    0xd2829230

----------------
IN:
0xd2829230:  55                       pushl    %ebp
0xd2829231:  89 e5                    movl     %esp, %ebp
0xd2829233:  83 ec 08                 subl     $8, %esp
0xd2829236:  e8 75 6c 02 00           calll    0xd284feb0

Servicing hardware INT=0x30

... subsequent log messages and crash are as before.
