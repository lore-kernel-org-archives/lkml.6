Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49DAC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8980C208CC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8980C208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeGHOOt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:14:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:47297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752121AbeGHOOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:14:48 -0400
Received: from homer.simpson.net ([185.191.217.104]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlV4F-1gCKLT1qul-00bMzQ; Sun, 08
 Jul 2018 16:13:56 +0200
Message-ID: <1531059232.4665.38.camel@gmx.de>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
From:   Mike Galbraith <efault@gmx.de>
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Sun, 08 Jul 2018 16:13:52 +0200
In-Reply-To: <1530998709.5350.32.camel@surriel.com>
References: <20180706215658.18018-1-riel@surriel.com>
         <20180706215658.18018-2-riel@surriel.com>
         <1530951813.22672.10.camel@gmx.de> <1530998709.5350.32.camel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:wLQALEBKgP/XI4M/qKuStx8JbEKpo0R6A+ojjcDUCiWld8ZO6QJ
 TzJriIDLG4yUsTpIqLRB+fi5NeV2R7wdV1gzhLXo7nmEmy9HSUklJ5ja6D1nVlURKxz4gZy
 72A+QVBCLLQNuWNnwoR8iFI+lHkHHydmEx7Iqq5N9iPscAv6x2hZbfqeTyiEaMTuuVQa8CT
 OH15QE1VCuAqcmw1lQlAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X+f4RXdJ61g=:m+hRRR3aOVxohRua1eNntj
 hPDluXWv8V3KJG3w3mXbGsyFq6Lk4bwRdUjx33MSSPFTcnYw78xLUhBwT9rte9NwRfByQc7vr
 w0WsWLt38fl6oGxb1yhx1NDC0cxka20K5c+FzC1esZSuNcZNnthXZXiYgemRYKcm8AcIxUL4p
 seiYM1WILw5yjF9u0wAIm/gPWiBnwIfFa4NvCRH4MMGSAMRIywT4MLQb+VqdtmEeS1CU5RjzD
 FOUIpDRJOLkp0iuCQfv2kZEnLv6yh0RUzSpkG4UprTxH8ZqCQTggu5C8pcqUcoGhKdolIqXhL
 +0MqXLOWCZkEoDp2x8bw0FPeVE2bG8DIDiV21LaCvdPahcP3kUcboHufLhKje7EN9RjO6/OJy
 C2Rs/YExUwrQfGSEdIqPtDiBaP/l4k6tKBek6SnEsJjnuhffBIM45odpWysDvmZCpp5QDQ34/
 42QjzAADFWeE8s6vpCrWTSz60RF8RktrmPpzV3Sn6a3kJLWaSQvOhuFW0dp18zvWNFOxMwBMf
 n+RKV7ULcxCS4ux+Ob5SVUrTEtIpZdny5nNEMALcn7pTOmUrLkS9pNSpf9dVEelldnNwkxErk
 tp0j04JbYg1rPqtmM9ot6pVsgv62LpB50vwihbumvO1PPkwywd/mSqHyWcV0HfEsFO6Qoonl6
 npiAp0OiLbihj8OOoXFXcDKkEqK9t3/1AvtPZ/o2A7OYp0I/LkI1DxEkw6kUD57+TTDHxZRjd
 1DqvAuiXSlRnq1ed+W+sHrLr8qkwaf2+WE1QKEpvQcqpFpfDBWBj/m8Gs60TMjUrneRXDxVgZ
 IxpexeJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-07 at 17:25 -0400, Rik van Riel wrote:
> 
> > ./include/linux/bitmap.h:208:3: warning: ‘memset’ writing 64 bytes
> > into a region of size 0 overflows the destination [-Wstringop-
> > overflow=]
> >    memset(dst, 0, len);
> >    ^~~~~~~~~~~~~~~~~~~
> 
> I don't understand this one.
> 
> Inside init_mm we have this line:
>         .cpu_bitmap     = { [BITS_TO_LONGS(NR_CPUS)] = 0},
> 
> which is the way the documentation suggests statically
> allocated variable size arrays should be allocated 
> and initialized.
> 
> How does that result in a memset of the same size,
> on the same array, to throw an error like above?

Compiler knows that ->cpu_bitmap is 64 bits of storage, and with
!CPUMASK_OFFSTACK, nr_cpumask_bits = NR_CPUS.  With NR_CPUS > 64,
compiler gripes, with NR_CPUS <= 64 it's a happy camper.

> What am I doing wrong?

Below is what I did to get box to both STHU, and to boot with the
openSUSE master branch config I sent.  Without the efi_mm hunk, boot
hangs early with or without the other hunk.

I build and boot tested the openSUSE config, a NOPREEMPT+MAXSMP config,
my local config w. NR_CPUS=8, and master-rt w. NR_CPUS=256, which is
the only one that got any real exercise (building the others).

---
 drivers/firmware/efi/efi.c |    1 +
 include/linux/mm_types.h   |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -82,6 +82,7 @@ struct mm_struct efi_mm = {
 	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
+	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
 };
 
 static bool disable_runtime;
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -501,7 +501,10 @@ extern struct mm_struct init_mm;
 
 static inline void mm_init_cpumask(struct mm_struct *mm)
 {
-	cpumask_clear((struct cpumask *)&mm->cpu_bitmap);
+	unsigned long cpu_bitmap = (unsigned long)mm;
+
+	cpu_bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	cpumask_clear((struct cpumask *)cpu_bitmap);
 }
 
 /* Future-safe accessor for struct mm_struct's cpu_vm_mask. */
