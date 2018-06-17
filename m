Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13888C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBACD20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBACD20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbeFQOD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 10:03:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:50873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754082AbeFQOD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:03:57 -0400
Received: from homer.simpson.net ([188.174.240.203]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWTfu-1fjIwJ0yAU-00XcWO; Sun, 17
 Jun 2018 16:03:01 +0200
Message-ID: <1529244178.4674.1.camel@gmx.de>
Subject: Re: [tip:x86/pti] x86/asm: Pad assembly functions with INT3
 instructions
From:   Mike Galbraith <efault@gmx.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>
Date:   Sun, 17 Jun 2018 16:02:58 +0200
In-Reply-To: <1529242717.4472.3.camel@gmx.de>
References: <20180507213755.GA32406@avx2>
         <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
         <1529235613.4572.7.camel@gmx.de> <20180617120012.GB16877@zn.tnic>
         <1529242717.4472.3.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jkaTpEn97dNo335C7zTWkTIclQ3eqP46kuaf+xi4tZ8SFVX2u88
 Yd8EMvRgGFIkDBGWr8YmDyIjpejIcGcRy2oiir+JOmYVU9jJOaJBfKog6aJHNqvcpkv/KiF
 rX7v9cEzLZGkqkZ4/QEYzcj3zC4JqvHTCp7R0W1LOTRVuhoEb7lv8EbJ7cThup8wvxcxgeZ
 GDQIiMIrsfqVN8vKaWG6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vR3tMdBYsHo=:PIiuJNbKneyo3TxaajUf2o
 dWguheJeQ+nvaJLBBvjfk4wgx8CPxHC9NVkyuLPaBK4MPQ4cRwIZMpAtE7nNf6dxB8RcoU0ml
 x0A6NTTzhR8kLsAnZLUJNopgT1EwSI+Y1fSt83gkhRTxuMcREUePVvVrS2xqqZyUOGb8+qiB1
 /qF71szbq/VP8PKKfA+Xv4Fjdq6EnaOhUjJ3nsiJY2ZPYt1KP8/C5BTPjqchRj51UB2o8P3Q9
 Gq83evq3ajp4zG7X6rHFpJEeRNMwqftQpzmzIOhn+BwW6j6JVDz7xru6mDHjT1AgLe/XbEWtg
 H18OFUcI1gHr/piQk54P1gUa8DrQT2NK2do6jkHElUYmzkp80MBSBnvj8FVZ0ekVHu/rQTbnM
 IA3HiYd4i2pcH797ioT4+wm8xEAMGPVXqgDoC0WawMS9eLLhB7H+dvewgGdEN8UaLjLqjmpiv
 1OkfldNPCYleD4g5MgXa/Otqn6AIr8mJ4R4d01M2pGTX497Hxivww6WJkKHLnbYOR7P4CZ39/
 fw2WFEwT7QpFI4zsIHnFc8qquShxX4FDaTQ8Tmho+QixKDfhJoR5V0BQUzNkyYMCpZayVKb+i
 JrdvDkYVZnZM1e7LgVFUPWHiOj6suwz/s8wtHaJJetvm7EMJhQ+Q2kSzaHAg0P0EeT6GalmJ9
 RCIzUftiHjV72KEzLjlp16n9a1XkSei3KUqQHnOnLNVUDpApgkqOJVGtiVhB0tsMqVcTJh5Tl
 4TorB/dWyadq76fcr2RaScxh81692NE6PmIeh6epsIArLoAclHXan0xqE95uK6LakZcZux7OQ
 VhCqnFO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 15:38 +0200, Mike Galbraith wrote:
> On Sun, 2018-06-17 at 14:00 +0200, Borislav Petkov wrote:
> > On Sun, Jun 17, 2018 at 01:40:13PM +0200, Mike Galbraith wrote:
> > > On Mon, 2018-05-14 at 05:53 -0700, tip-bot for Alexey Dobriyan wrote:
> > > > Commit-ID:  51bad67ffbce0aaa44579f84ef5d05597054ec6a
> > > > Gitweb:     https://git.kernel.org/tip/51bad67ffbce0aaa44579f84ef5d05597054ec6a
> > > > Author:     Alexey Dobriyan <adobriyan@gmail.com>
> > > > AuthorDate: Tue, 8 May 2018 00:37:55 +0300
> > > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > > CommitDate: Mon, 14 May 2018 11:43:03 +0200
> > > > 
> > > > x86/asm: Pad assembly functions with INT3 instructions
> > > > 
> > > > Use INT3 instead of NOP. All that padding between functions is
> > > > an illegal area, no legitimate code should jump into it.
> > > 
> > > Is dinky patchlet suggesting cryptomgr is being naughty?
> > > 
> > > (revert silences spew, but..)
> > > 
> > > ...
> > > [   21.041608] int3: 0000 [#1] SMP PTI
> > > [   21.041754] CPU: 3 PID: 935 Comm: cryptomgr_test Tainted: G            E     4.17.0.g075a1d3-tip-default #146
> > > [   21.041888] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> > > [   21.042035] RIP: 0010:crypto_aegis128_aesni_enc_tail+0x74/0x80 [aegis128_aesni]
> > > [   21.042171] Code: 38 dc ca 66 0f 38 dc d3 66 0f 38 dc de 66 0f ef e5 f3 0f 7f 27 f3 0f 7f 47 10 f3 0f 7f 4f 20 f3 0f 7f 57 30 f3 0f 7f 5f 40 cc <cc> cc cc cc cc cc cc cc cc cc cc cc 48 83 fe 10 0f 82 c3 03 00 00
> > 
> > Looks like it misses a RET:
> 
> Bingo.
> 
> [   28.751069] RIP: 0010:crypto_aegis128l_aesni_enc_tail+0xcd/0xd0 [aegis128l_aesni]
> 
> Next next next..

(/me does that.. all better)

From 6ac281ee69f4cb5b581d5f49662fb56b6326155a Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@suse.de>
Date: Sun, 17 Jun 2018 13:57:42 +0200
Subject: [PATCH] x86/crypto: Add a missing RET

crypto_aegis128_aesni_enc_tail() needs to return too.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/crypto/aegis128-aesni-asm.S  |    1 +
 arch/x86/crypto/aegis128l-aesni-asm.S |    1 +
 arch/x86/crypto/aegis256-aesni-asm.S  |    1 +
 arch/x86/crypto/morus1280-avx2-asm.S  |    1 +
 arch/x86/crypto/morus1280-sse2-asm.S  |    1 +
 arch/x86/crypto/morus640-sse2-asm.S   |    1 +
 6 files changed, 6 insertions(+)

--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -535,6 +535,7 @@ ENTRY(crypto_aegis128_aesni_enc_tail)
 	movdqu STATE3, 0x40(STATEP)
 
 	FRAME_END
+	ret
 ENDPROC(crypto_aegis128_aesni_enc_tail)
 
 .macro decrypt_block a s0 s1 s2 s3 s4 i
--- a/arch/x86/crypto/aegis128l-aesni-asm.S
+++ b/arch/x86/crypto/aegis128l-aesni-asm.S
@@ -645,6 +645,7 @@ ENTRY(crypto_aegis128l_aesni_enc_tail)
 	state_store0
 
 	FRAME_END
+	ret
 ENDPROC(crypto_aegis128l_aesni_enc_tail)
 
 /*
--- a/arch/x86/crypto/aegis256-aesni-asm.S
+++ b/arch/x86/crypto/aegis256-aesni-asm.S
@@ -543,6 +543,7 @@ ENTRY(crypto_aegis256_aesni_enc_tail)
 	state_store0
 
 	FRAME_END
+	ret
 ENDPROC(crypto_aegis256_aesni_enc_tail)
 
 /*
--- a/arch/x86/crypto/morus1280-avx2-asm.S
+++ b/arch/x86/crypto/morus1280-avx2-asm.S
@@ -453,6 +453,7 @@ ENTRY(crypto_morus1280_avx2_enc_tail)
 	vmovdqu STATE4, (4 * 32)(%rdi)
 
 	FRAME_END
+	ret
 ENDPROC(crypto_morus1280_avx2_enc_tail)
 
 /*
--- a/arch/x86/crypto/morus1280-sse2-asm.S
+++ b/arch/x86/crypto/morus1280-sse2-asm.S
@@ -652,6 +652,7 @@ ENTRY(crypto_morus1280_sse2_enc_tail)
 	movdqu STATE4_HI, (9 * 16)(%rdi)
 
 	FRAME_END
+	ret
 ENDPROC(crypto_morus1280_sse2_enc_tail)
 
 /*
--- a/arch/x86/crypto/morus640-sse2-asm.S
+++ b/arch/x86/crypto/morus640-sse2-asm.S
@@ -437,6 +437,7 @@ ENTRY(crypto_morus640_sse2_enc_tail)
 	movdqu STATE4, (4 * 16)(%rdi)
 
 	FRAME_END
+	ret
 ENDPROC(crypto_morus640_sse2_enc_tail)
 
 /*
