Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDA1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966C820857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fAZ8awyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966C820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeIFOT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:19:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33597 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbeIFOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:19:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id r1-v6so13909808wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GdDoGGGCnDzwoVBcTkzvGUgTIWTGiOZCABgdNN8twlc=;
        b=fAZ8awyfPTfYxIfY7+BEHeT1wILEQ9TmvGEp9CxcokFhDQoIDe3UwPVyWDOP0NA7AQ
         fDLNWgWUM+OG0W02LjAcUeXUTulZk6idxbEcCX00vHfKe98cD+c/9T9qUsw7vxLhK1AL
         U39FBX5uXWukCQ9qNYN2cqlBm+EWjL6w4NZwMi9bY+GhqeVxQYorTJPiApkL/sVHUbFi
         QZrCf1arub5zkIN439iPg5PgZzgRjXH/4gTWWV+GHL72/WtYlNmgCGjE6OKmtxZD1Zxq
         NPfF9Sl90NTL2mcpME0bBoXBDFEdCUOPqQzVV16C5AeZC/xE7wSoHpQTZGbuPo5MH1iI
         g1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GdDoGGGCnDzwoVBcTkzvGUgTIWTGiOZCABgdNN8twlc=;
        b=LCdNSCM8VNANc+FujzYDwa3wrdqFWRAx5kL5B9lAK4GLM7SLKBovkS0KTrT6YB9J8E
         Zwy+DHd6Dcj29lmeJnSug4E5vrdzzvS6tvr01IY8l4ucVy2IGdhPqRgwXzsUQhEnlQjw
         U7buoouzvxPWOc9s4Q2vYLNBcL4ubTKBVXEM72oabJGRTqpbpnEDWWtjcQwNZGUFlzQk
         kM1QNkF88Jb4FEN6EjIcQpBdVpN16G3WY/f0/QPZN+4kQBtLC4LjFY1FiDcD8w2nC2tA
         Cuj/0bmIs4PxSD+3hk9PNN6HcaKleFvVEpfgs+fdEANbjHdbaBukJxzeD3kj0NXdzHwC
         BZCw==
X-Gm-Message-State: APzg51De4nwgRN0TcBsEJr95MhgspkXaptehqOkJUnMvKcUlki5WGS5j
        3uX3tZDKQ3Q4SOhgym1E5pcmjLDNUR/3Nw==
X-Google-Smtp-Source: ANB0VdbmAm/5rl+HdX3tkoJvA4vA1ADOOQm+jEhU7Mmoyq5FRhnTr0ysF6UN9rzfT4AtWDSGzXcbEg==
X-Received: by 2002:a1c:b157:: with SMTP id a84-v6mr1521959wmf.18.1536227116047;
        Thu, 06 Sep 2018 02:45:16 -0700 (PDT)
Received: from localhost (smb-adpcdg1-01.hotspot.hub-one.net. [213.174.99.129])
        by smtp.gmail.com with ESMTPSA id k13-v6sm3425599wrq.7.2018.09.06.02.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 02:45:15 -0700 (PDT)
Date:   Thu, 06 Sep 2018 02:45:15 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 22:27:13 PDT (-0700)
Subject:     Re: [PATCH] y2038: Remove newstat family from default syscall set
In-Reply-To: <20180901174353.GA14271@roeck-us.net>
CC:     Arnd Bergmann <arnd@arndb.de>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-a047b20f-8546-4762-bcf0-f884be595b92@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Sep 2018 10:43:53 PDT (-0700), linux@roeck-us.net wrote:
> Hi Arnd,
>
> On Fri, Apr 13, 2018 at 11:50:12AM +0200, Arnd Bergmann wrote:
>> We have four generations of stat() syscalls:
>> - the oldstat syscalls that are only used on the older architectures
>> - the newstat family that is used on all 64-bit architectures but
>>   lacked support for large files on 32-bit architectures.
>> - the stat64 family that is used mostly on 32-bit architectures to
>>   replace newstat
>> - statx() to replace all of the above, adding 64-bit timestamps among
>>   other things.
>>
>> We already compile stat64 only on those architectures that need it,
>> but newstat is always built, including on those that don't reference
>> it. This adds a new __ARCH_WANT_NEW_STAT symbol along the lines of
>> __ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 to control compilation of
>> newstat. All architectures that need it use an explict define, the
>> others now get a little bit smaller, and future architecture (including
>> 64-bit targets) won't ever see it.
>>
>
> This patch causes my riscv boot tests to crash in -next

Ah, thanks for running these!

> sbin/init: error while loading shared libraries: libc.so.6: cannot stat shared object: Error 38
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>
> The following change fixes the problem for me, but of course I have no idea
> if it is correct. Copying RISC-V maintainers for input.
>
> Guenter
>
> ---
> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
> index 0caea01d5cca..eff7aa9aa163 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -16,6 +16,7 @@
>   * be included multiple times.  See uapi/asm/syscalls.h for more info.
>   */
>
> +#define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_SYS_CLONE
>  #include <uapi/asm/unistd.h>
>  #include <uapi/asm/syscalls.h>

I'm afraid I'm not sure what the right thing to do here is either, but from the 
patch description it does seem like we should have this guarded by an "#ifdef 
CONFIG_32BIT" so we can keep it out of our 32-bit ABI (which isn't in glibc 
yet, so isn't stable) in favor of statx() (or maybe stat64()?).  The one 
problem here is that I can't find "newstat" anywhere in glibc to verify it's 
actually supposed to be part of our 64-bit ABI, though I can find a bunch of 
references to "statx" that seem to indicate it's meant to be present.

That said, assuming you don't have anything wacky going on in userspace if this 
breaks the ABI then it breaks the ABI, so however newstat got into a binary we 
still need to keep it around.  Poking around my Fedora glibc image I see

    000000000009b040 <__xstat>:
       9b040:       e51d                    bnez    a0,9b06e <__xstat+0x2e>
       9b042:       04f00893                li      a7,79
       9b046:       f9c00513                li      a0,-100
       9b04a:       4681                    li      a3,0
       9b04c:       00000073                ecall

which seems to coorespond with sys_newfstatat, which indicates to me we should 
have it in the 64-bit ABI.
