Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D936C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D6D208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ5VIXLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D6D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGaJSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:18:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40663 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbeGaJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:18:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so1976287wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6BOJL8BADzct8oUwN9DhrlNmfTCJuSBvtsKWw9YikIU=;
        b=QZ5VIXLK2nGUvIz5JX845G6tEBZrsweJflsi35T9IcqhekdXfDn1+kO283E0xXi8yZ
         VBX2XmI/AloGJsD5ez3USoyVI8She7WBT1QK3uuB2aDbgMtNRlwyagNfMvZjell41Q5J
         NPNVtN9NuLGTBChaeNMrkZjna96kYfemp1u28HZgRKW/A6a+8vVC7HxgHZbwjFCsAZI9
         JX81L1DgoAXp3KIWRx795+REXxZInpIy1GSybkSvt+rouLWMwb/Sz2RiPYON0FbJFWmm
         QJWijUop1hC1AHRsEDFKhPydCrtcdlP4KLI2QmypUWRZgv7U+OfbyE3C3A7SaulU/fBG
         JpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6BOJL8BADzct8oUwN9DhrlNmfTCJuSBvtsKWw9YikIU=;
        b=IuAj5WYtjCQUzjHLoap0ApJbV2UPUlBRaX2Jn4OGxGygqg0Cecl3Ev0J3CxVYe03Sz
         gxhldAV2Je1tJy6OKebE3rCQxLQA0yNi234GHvu3U3YFJr4cI9oZ4mGYv4yJ2vYQuQS7
         eaoEEDkeX+VYDO7DrvQGPAkcJNE4TsX1Bc9KTDQlvivUwfG/tChVspuzrZOC9lvwcG5k
         pypiZNYoJytsdxRTPxamDqYgBV8TslfH/yUBqWX7+UgcnSOwP4qg6dR0mw2rPj0Zapb5
         ZuoI2aWdFmN5pn5c9g41Tk4pZCwJWMpDQaL/aJZxFrd8K+gaf0Pryay1gP8Y+DbJz0R5
         1/Ow==
X-Gm-Message-State: AOUpUlEGvCwgigoc8uO55G1ZRuv4TQbKwflmRgqmJgTIUcRyXwxgIS/J
        JLufRVZZ3rcCHYN2QTJZ8UnoCphW
X-Google-Smtp-Source: AAOMgpfaIzQWj1tFYd1WS1YPLKM5qjpkHLdsx0tNSXiLC8e9+wtOApS0lfESDSMFsEEpT72xpqrtEA==
X-Received: by 2002:a1c:5f56:: with SMTP id t83-v6mr1555492wmb.27.1533022760571;
        Tue, 31 Jul 2018 00:39:20 -0700 (PDT)
Received: from [192.168.10.150] (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm9964207wmc.2.2018.07.31.00.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 00:39:19 -0700 (PDT)
Subject: Re: [PATCH] x86: kvm: Restrict X86_FEATURE_VMMCALL to x86_64 platform
To:     Matthew Whitehead <tedheadster@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180730194059.5781-1-tedheadster@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <7c274466-6d93-d1ba-8721-4d69f847b40f@redhat.com>
Date:   Tue, 31 Jul 2018 09:39:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730194059.5781-1-tedheadster@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 21:40, Matthew Whitehead wrote:
> early_init_amd() is called on all AMD processors, both 64 and 32 bit.
> Presently 32 bit processors get the X86_FEATURE_VMMCALL feature set, which
> they do not support. Add conditionals to restrict it to 64 bit processors.

This shouldn't be necessary; for systems that don't have virtualization
extensions, the comment explains why setting X86_FEATURE_VMMCALL is safe.

But it is also wrong, because you can run a 32-bit kernel as a guest on
a 64-bit processor, and then it should set X86_FEATURE_VMMCALL because
the processor has the vmmcall instruction and not Intel's vmcall.

Thanks,

Paolo

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 38915fbfae73..df06919324cd 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -662,12 +662,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
>  	}
>  #endif
>  
> +#ifdef CONFIG_X86_64
>  	/*
>  	 * This is only needed to tell the kernel whether to use VMCALL
>  	 * and VMMCALL.  VMMCALL is never executed except under virt, so
>  	 * we can set it unconditionally.
>  	 */
>  	set_cpu_cap(c, X86_FEATURE_VMMCALL);
> +#endif
>  
>  	/* F16h erratum 793, CVE-2013-6885 */
>  	if (c->x86 == 0x16 && c->x86_model <= 0xf)
> 

