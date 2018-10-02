Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9139CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455D820652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihwloDR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455D820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeJBP7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:59:13 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35189 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeJBP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:59:13 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so2692574itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SGt0tvuEIdupHC+zHme9ECBCFcVsk1G0xysrA6VkoVI=;
        b=ihwloDR0pNfZ2durv1Al5ESJdCjzd+in4+RRastS97oxPZ70uVgc3H1v9zWyrqdubW
         KoUXbg3aezAiR3nm8HmTj0DJh/CMw29t7mnUA/re7B5ybB0NAPRLytiUaVfPtFKTD97e
         X0n/GnosIXZpZtIoVg2xQH8nnlb+GRGbzustQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SGt0tvuEIdupHC+zHme9ECBCFcVsk1G0xysrA6VkoVI=;
        b=T4df2phP/7e9A8aKZvoVC3g7E75jpHaPrucRRuNLZo/nntlTmvuIW8gpZgUgzBcCnH
         NITZfgFA7KBiezW9OW3CuYqVWfrTajeDNrhvB8V6bpTcFflRiZf4wGOq8+2OKf23QqO6
         CfEGPx1xNiKKOrT2dDyV6bO1UqlVY0EvyT1PSdhTl2EN3+xyK0VQN/WRIkWWCCe1KNuV
         3pJi1CWggWF03bAWU+8accVTV+FA+ENf8rtnsKr9Y+6B2zoHKD/pOCyZxF5+Hv8EZJdL
         acg6OsEIq9oleIspzQ8PtHE6AFk/DJsLt4EAmLFvwIYlm0icuq8H518pPjxN1TS/uOXG
         chig==
X-Gm-Message-State: ABuFfoji4DC0HRDjYGUD9mbCuulRWHio+myUfT8qkREIu+ENygNW8uYn
        qfNEm7bu/gDZj3XeiB3G6smHC92Fq+ddt86Xtb5i/g==
X-Google-Smtp-Source: ACcGV62ZfNAJa0XUY4JB6Vj6BUoxH1kfu85u83O8i5RVcZQE4q/aoVWoeweg/iTrWcDHrhUp16/PplxhUPy06LBMQNg=
X-Received: by 2002:a24:e48e:: with SMTP id o136-v6mr1218619ith.58.1538471816149;
 Tue, 02 Oct 2018 02:16:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 02:16:55 -0700 (PDT)
In-Reply-To: <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com> <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com> <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 11:16:55 +0200
Message-ID: <CAKv+Gu-BPAH6Xiggji9Vs3o89nGfdhhAeGz=GKCqNSo9mkWd7w@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Eric since he wrote the ChaCha20 scalar code)

On 2 October 2018 at 09:51, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Oct 2, 2018 at 5:53 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> Hi Arnd,
>>
>> Apologies for the delay in getting back to you. I had some MTA issues
>> and stupidly assumed ARM developers were taking the day off instead...
>>
>> On Tue, Oct 2, 2018 at 5:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> > -arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
>> > +arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m
>>
>> Unfortunately this doesn't really cut it in my case, as it's not only
>> those multiplications:
>> chacha20-arm.S:402: Error: selected processor does not support `bxeq
>> lr' in ARM mode
>>
>> I think we're going to wind up playing whack-a-mole in silly ways. The
>> fact of the matter is that the ARM assembly I'm adding to the tree is
>> for ARMv4 and up, and not for ARMv3.
>
> I don't see what issues remain. The 'reteq lr' that Ard mentioned
> is definitely the correct way to return from assembly (you also need
> that for plain armv4, as 'bx' was added in armv4t), and Russell
> confirmed that using -march=armv3m is something we want
> anyway for mach-rpc.
>

In fact, this bxeq instruction is the only remaining impediment to
building all scalar code with -march-arm3m, and looking at the code

ENTRY(chacha20_arm)
    cmp r2, #0 // len == 0?
    bxeq lr

it seems to me that we can move this len == 0 check into the caller instead.

index 163815f51aac..b2108e00d451 100644
--- a/lib/zinc/chacha20/chacha20-arm-glue.h
+++ b/lib/zinc/chacha20/chacha20-arm-glue.h
@@ -59,6 +59,8 @@ static inline bool chacha20_arch(struct chacha20_ctx
*ctx, u8 *dst,
                        src += bytes;
                        simd_relax(simd_context);
                } else {
+                       if (unlikely(!len))
+                               break;
                        chacha20_arm(dst, src, len, ctx->key, ctx->counter);
                        ctx->counter[0] += (len + 63) / 64;
                        break;
diff --git a/lib/zinc/chacha20/chacha20-arm.S b/lib/zinc/chacha20/chacha20-arm.S
index 5abedafcf129..845843a14ab1 100644
--- a/lib/zinc/chacha20/chacha20-arm.S
+++ b/lib/zinc/chacha20/chacha20-arm.S
@@ -398,9 +398,6 @@
  *                  const u32 iv[4]);
  */
 ENTRY(chacha20_arm)
-       cmp             r2, #0                  // len == 0?
-       bxeq            lr
-
        push            {r0-r2,r4-r11,lr}

        // Push state x0-x15 onto stack.
