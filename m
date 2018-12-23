Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A7EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 08:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00AE218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 08:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkLUv5Qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeLWIpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 03:45:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53188 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeLWIpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 03:45:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so8965291wml.2;
        Sun, 23 Dec 2018 00:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EO4/NlBd0vPYnZKDM0NLQkJ/JarpwDC5UWqNsCOzNK4=;
        b=kkLUv5QyfiM1x74pVjXGMql2UFk3x5DOXwshXp7VUraKWKmrO3iCZEZFmOUzkzbtO0
         JWoVVk9lA1i6PXyDS6ZgDxV08j2XjS/hCM1yk51XN28T8EQ9fzLD7yj6lgelFS1tU/6s
         sd2CqOc/pMQhyjZBBoCO+GjyPd4kQ/nSYGNv1iCSFknX+Rn3q/r9mqqtS3nIPUqGLv8m
         wRXRx3PN+Ha+lRV1/Uuf8b9fM9TAc8FANw5ovh8RLBIC7/Dj0pr0z1SwyhBKofL4OPoR
         cjEQ8E9x3zv2YbX84kffcQQN0cPDgo52ygdvpk3uC4Z1qYMh3kuszMFEuCwAK/0lrmK2
         +IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EO4/NlBd0vPYnZKDM0NLQkJ/JarpwDC5UWqNsCOzNK4=;
        b=XfYAFRWLHxLOytsSmxtF5xg48ojVF07yBIrKZF17hqB66QNHvcqBKsZ+Rz45MrUPzs
         vKIvCjrixRS2G2Cyoe43th4ks73N5tMXYolmfxJi5fAHvtg9mwEYmSEucJ2lv5X7WHq8
         SoHFwsy/gx9WTWLHIkwVaPiVVbHqOZGVZVTSrl3h5BFlvu05BEA38RUmqY/u+3xxWxTs
         4/apBiXDUKlIUbxOmq3SmP9qqT6uDb7uFFsUvcNApdeg8juwvfJlToyMpKuSfCeU9iC0
         WjOwq/Z7G27Po7bKplDq2NfyceYMVcj2p257cxsFVKIIdtIij5RiOz8elSNEbxG7pdYA
         U7tw==
X-Gm-Message-State: AJcUukc6tecpPc2U5XQQAymYh+y5b4hw9TZDDU70DneFXQyTxdg3uLrN
        xwyvz0rsWGviBCRL85ICnYuIMM81
X-Google-Smtp-Source: ALg8bN5s+ShozbpTebJCI+Pdjj5aMz3pad0UY8HR1GgRmE693PyaV+0BENsLu7TI1TFzuJzJiJClhQ==
X-Received: by 2002:a1c:da92:: with SMTP id r140mr9024781wmg.136.1545554718435;
        Sun, 23 Dec 2018 00:45:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5512:75d2:9535:9b99? ([2001:b07:6468:f312:5512:75d2:9535:9b99])
        by smtp.googlemail.com with ESMTPSA id n5sm19556073wrr.94.2018.12.23.00.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 00:45:17 -0800 (PST)
Subject: Re: [GIT PULL] Last straggler for 4.20-rc8 or final
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
References: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
 <20181221224040.GA25147@zn.tnic>
 <b54245cb-d029-02a5-d854-129ea7734336@redhat.com>
 <20181222205916.GA64950@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <58dd99ea-f13f-d211-2d4d-cefad81655df@redhat.com>
Date:   Sun, 23 Dec 2018 09:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181222205916.GA64950@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/18 21:59, Ingo Molnar wrote:
> 
> * Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 21/12/18 23:40, Borislav Petkov wrote:
>>> + mingo.
>>>
>>> On Fri, Dec 21, 2018 at 02:09:02PM +0100, Paolo Bonzini wrote:
>>>> Linus,
>>>>
>>>> The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:
>>>>
>>>>   Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
>>>>
>>>> for you to fetch changes up to 3cf85f9f6bd7b172122865432b4c6f0ec844e22a:
>>>>
>>>>   KVM: x86: nSVM: fix switch to guest mmu (2018-12-19 22:19:22 +0100)
>>>>
>>>> A simple patch for a pretty bad bug.  I haven't yet sent my 4.21 pull
>>>> request because currently I'm waiting for a patch to be removed from
>>>> tip (MPX removal breaks KVM live migration and was committed without
>>>> Cc or Ack from me) and until that happens I cannot finalize my
>>>> conflict resolution instructions.
>>>
>>> Lemme make sure I understand it correctly: you'd like us to not send
>>>
>>> https://git.kernel.org/tip/eb012ef3b4e331ae479dd7cd9378041d9b7f851c
>>>
>>> up now and delay it for 4.22, right?
>>
>> Right, and also I will have to provide you with a topic branch to base
>> that patch on.
> 
> Ok - x86/mpx delayed for v4.22 at least.
> 
> Can we turn off CONFIG_X86_INTEL_MPX configurability in the Kconfig, via 
> a patch like below?
> 
> Thanks,
> 
> 	Ingo
> 
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8689e794a43c..20fd5695f265 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1870,6 +1870,7 @@ config X86_INTEL_MPX
>  	def_bool n
>  	# Note: only available in 64-bit mode due to VMA flags shortage
>  	depends on CPU_SUP_INTEL && X86_64
> +	depends on DEPRECATED
>  	select ARCH_USES_HIGH_VMA_FLAGS
>  	---help---
>  	  MPX provides hardware features that can be used in
> 

I think so, you can even delete all X86_INTEL_MPX code already.  All
that KVM still needs is that BNDCSR and BNDREGS remain in XCR0, I don't
see anything that affects that depending on X86_INTEL_MPX.

Thanks,

Paolo
