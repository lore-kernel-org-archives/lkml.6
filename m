Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE9B2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8fjSocm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE9B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJZB2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:28:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41058 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeJZB2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:28:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id c32so9798939otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nz6SP2OMsuwLn17z7g6CbZCJ0LCVrXE2/yRuLIz4DpI=;
        b=k8fjSocmjEp43q0VOt4A0aON+JPqF99sfcMYC0a20F9FpEpKDjw4f/cypOU9QNxt8t
         eY+bxujykjT+AVZJP4QaEhZuEMyhl1h8Rxq8GwFdXNkVPv3CKZ7yYD1eeIYS2rHezs7j
         mxSATBCQyM7n9YwPIVOFJVm3grl69/SEbVNVEqPD0NYE58t5DSuqE58IJRVPzHKHAclO
         IoZwsc/5cZgmbqsDiN00QwB//ouyBdXjHIFddiadU19JwavJvM1h5yMKzbJg2WidG5vP
         g8AI5IVvNYZNnka9WgSmuEb2Yc30cHxQ+clCoSmbxCZM2+cqQPC29NOuTYoiAm5SRccT
         omOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nz6SP2OMsuwLn17z7g6CbZCJ0LCVrXE2/yRuLIz4DpI=;
        b=YvKysAB2cuoGJjKtm6J0xpkuEqKZo+aLvDuojBq4cj805ziRpf9GHGOmvuUmuATqYn
         36aIXfbQEwdCRDq3ulSZXY2t0ErSpZTfMp0FH1tt7a0NVHo+lqbKZ+TqEmC33pgIkkRe
         IiF9/1Kc39ZQY+XvuWvlogkQLBQyUfdAd3XL4XBY4mhymRVuiJhioWIcKVQwmDL7mPPL
         JOYTNSM7CUSHZwoZ5Zn4JU+6HZag+7JhjGmFCLqQpH69YrhwH/FdW21eHUwt6nCV9u52
         1iVGCSPVRap7bhT/4ORD2xe0zmI+rRPRd915LvqFrK9xCYajbb1zNjGdt7wcsVr+v6qx
         1UwQ==
X-Gm-Message-State: AGRZ1gKDtsEreBP95jilD3Lnjb1lYKoxRqTFb3e10Ol8bvyAAqaIsOnj
        IYUNPcIcqnkcvBn3s4RzcpSb3u927z3n81maioXuXQ==
X-Google-Smtp-Source: AJdET5ccQorfAoae94eGaO7GjG3UzrX8qsEf6zeEYZYQKwj5wtU8G7LbZP8i7NIbSTcjYfWNnwIL5NiEwGIini5b0p0=
X-Received: by 2002:a9d:3f91:: with SMTP id r17mr7340otc.63.1540486516925;
 Thu, 25 Oct 2018 09:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2ac9:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 09:55:16
 -0700 (PDT)
In-Reply-To: <558fea0b4df498eefcaea5ae07a089ad9706c1a2.1540369608.git.jsteckli@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
 <558fea0b4df498eefcaea5ae07a089ad9706c1a2.1540369608.git.jsteckli@amazon.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 25 Oct 2018 09:55:16 -0700
Message-ID: <CALMp9eQBhz1fzN4z=oMy5X9OKN3JxNyiD4GBYbH+fhen_aP6Ww@mail.gmail.com>
Subject: Re: [PATCH 2/4] kvm, vmx: move register clearing out of assembly path
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, js@alien8.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:28 AM, Julian Stecklina <jsteckli@amazon.de> wrot=
e:
> Split the security related register clearing out of the large inline
> assembly VM entry path. This results in two slightly less complicated
> inline assembly statements, where it is clearer what each one does.
>
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> Reviewed-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
> Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
> ---
>  arch/x86/kvm/vmx.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 93562d5..9225099 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10797,20 +10797,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vc=
pu *vcpu)
>                 "mov %%r13, %c[r13](%0) \n\t"
>                 "mov %%r14, %c[r14](%0) \n\t"
>                 "mov %%r15, %c[r15](%0) \n\t"
> -               "xor %%r8d,  %%r8d \n\t"
> -               "xor %%r9d,  %%r9d \n\t"
> -               "xor %%r10d, %%r10d \n\t"
> -               "xor %%r11d, %%r11d \n\t"
> -               "xor %%r12d, %%r12d \n\t"
> -               "xor %%r13d, %%r13d \n\t"
> -               "xor %%r14d, %%r14d \n\t"
> -               "xor %%r15d, %%r15d \n\t"
>  #endif
> -
> -               "xor %%eax, %%eax \n\t"
> -               "xor %%ebx, %%ebx \n\t"
> -               "xor %%esi, %%esi \n\t"
> -               "xor %%edi, %%edi \n\t"
>                 "pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
>                 ".pushsection .rodata \n\t"
>                 ".global vmx_return \n\t"
> @@ -10847,6 +10834,26 @@ static void __noclone vmx_vcpu_run(struct kvm_vc=
pu *vcpu)
>  #endif
>               );
>
> +       /* Don't let guest register values survive. */
> +       asm volatile (
> +               ""
> +#ifdef CONFIG_X86_64
> +               "xor %%r8d,  %%r8d \n\t"
> +               "xor %%r9d,  %%r9d \n\t"
> +               "xor %%r10d, %%r10d \n\t"
> +               "xor %%r11d, %%r11d \n\t"
> +               "xor %%r12d, %%r12d \n\t"
> +               "xor %%r13d, %%r13d \n\t"
> +               "xor %%r14d, %%r14d \n\t"
> +               "xor %%r15d, %%r15d \n\t"
> +#endif
> +               :: "a" (0), "b" (0), "S" (0), "D" (0)
> +               : "cc"
> +#ifdef CONFIG_X86_64
> +                 , "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
> +#endif
> +               );
> +

Looking at the second asm statement and the comment that precedes it,
my first question would be, "What about the registers not covered
here?" I'm also not convinced that the register-clearing asm statement
is actually "clearer" with some registers cleared as input arguments
and others cleared explicitly, but otherwise, the change looks fine to
me.

Reviewed-by: Jim Mattson <jmattson@google.com>
