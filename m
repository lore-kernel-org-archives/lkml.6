Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF9C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAF4222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kYd6gU/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfBLRT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:19:27 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:33588 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbfBLRT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:19:26 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 1791E24E138C;
        Tue, 12 Feb 2019 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549991966; bh=XdfyAzVvy5MIDdZ2SbnUXNZW12NBCdwDNe8k3TzI3DE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=kYd6gU/03DpbJpsITqqiygVc3NQ9SMN9IXbVGh3s7jNWHr1qvqKsDKYVxIUZKBcwq
         X8cMfsB06qB2m0Gfc+KOHwLjsZ+icL5aReaBwzHakd7dVsafUcVZKvLYEWzc2oW3Fi
         ZSnSFC68OtEEahWtTxGEGeYz24MtAV9GWZZ4lrm7T/JbbDnX1yk4QwA6P0KwPnVMbR
         T2zIMtMLufl5cZXVOFOFVMQitMeJ28vbp5d3F2ensEyyl5ySQcdFET756sca4ASOse
         vJ2HPF8LMRZsKqcUqnfVeU0TCB2VWMG9ACzavT1oeRohdBtFIl9902VfYUaKGu6R2N
         XrIMcpFTobWqQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 08776A0090;
        Tue, 12 Feb 2019 17:19:25 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Feb 2019 09:17:24 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Feb 2019 22:47:29 +0530
Received: from [10.10.161.59] (10.10.161.59) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Feb 2019 22:47:28 +0530
Subject: Re: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        <stable@vger.kernel.org>
Newsgroups: gmane.linux.kernel.stable,gmane.linux.kernel.arc,gmane.linux.kernel
References: <20190208105519.26750-1-abrodkin@synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
Date:   Tue, 12 Feb 2019 09:17:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208105519.26750-1-abrodkin@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.59]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 2:55 AM, Alexey Brodkin wrote:
> By default ARCH_SLAB_MINALIGN is defined in "include/linux/slab.h" as
> "__alignof__(unsigned long long)" which looks fine but not for ARC.

Just for the record, the issue happens because a LLOCKD (exclusive 64-bit load)
was trying to use a 32-bit aligned effective address (for atomic64_t), not allowed
by ISA (LLOCKD can only take 64-bit aligned address, even when the CPU has
unaligned access enabled).

This in turn was happening because this word is embedded in some other struct and
happens to be 4 byte aligned


> ARC tools ABI sets align of "long long" the same as for "long" = 4
> instead of 8 one may think of.

Right, this was indeed unexpected and not like most other arches. ARCv2 ISA allows
regular 64-bit loads/stores (LDD/STD) to take 32-bit aligned addresses. Thus ABI
relaxing the alignment for 64-bit data potentially causes more packing and less
space waste. But on the flip side we need to waste space at arbitrary places liek
this.

So this is all good and theory, but I'm not 100% sure how slab alignment helps
here (and is future proof). So the outer struct with embedded atomic64_t was
allocated via slab and your patch ensures that outer struct is 64-bit aligned ?

But how does that guarantee that all embedded atomic64_t in there will be 64-bit
aligned (in future say) in the light of ARC ABI and the gcc bug/feature which
Peter alluded to

   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54188
   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=10360

> Thus slab allocator may easily allocate a buffer which is 32-bit aligned.
> And most of the time it's OK until we start dealing with 64-bit atomics
> with special LLOCKD/SCONDD instructions which (as opposed to their 32-bit
> counterparts LLOCK/SCOND) operate with full 64-bit words but those words
> must be 64-bit aligned.

Some of this text needed to go above to give more context.

> 
> Fixes Ext4 folder removal:
> --------------------->8-------------------
> [    4.015732] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
> [    4.167881]

..

> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: <stable@vger.kernel.org> # 4.8+
> ---
>  arch/arc/include/asm/cache.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
> index f393b663413e..74f8fcaaef5c 100644
> --- a/arch/arc/include/asm/cache.h
> +++ b/arch/arc/include/asm/cache.h
> @@ -52,6 +52,16 @@
>  #define cache_line_size()	SMP_CACHE_BYTES
>  #define ARCH_DMA_MINALIGN	SMP_CACHE_BYTES
>  
> +/*
> + * Make sure slab-allocated buffers are 64-bit aligned.
> + * This is required for llockd/scondd to deal with 64-bit aligned dwords.
> + * By default ARCH_SLAB_MINALIGN is __alignof__(long long) which in
> + * case of ARC is 4 instead of 8!
> + */
> +#ifdef CONFIG_ARC_HAS_LL64
> +#define ARCH_SLAB_MINALIGN	8
> +#endif
> +
>  extern void arc_cache_init(void);
>  extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
>  extern void read_decode_cache_bcr(void);
> 

