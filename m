Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D4C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 05:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC22B20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 05:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC22B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeIHKaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 06:30:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbeIHKaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 06:30:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8659ADEF;
        Sat,  8 Sep 2018 05:45:50 +0000 (UTC)
Subject: Re: [PATCH v2] x86/paravirt: Get rid of patch_site and patch_default
 labels
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, virtualization@lists.linux-foundation.org
References: <20180907104917.12502-1-bp@alien8.de>
 <20180907105112.GD12849@zn.tnic> <20180907201050.GF12849@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <65bb69fa-855f-9efc-19ba-c0fab69f468c@suse.com>
Date:   Sat, 8 Sep 2018 07:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907201050.GF12849@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/18 22:10, Borislav Petkov wrote:
> On Fri, Sep 07, 2018 at 12:51:12PM +0200, Borislav Petkov wrote:
>> Whoops, no, it is still being used. Lemme see if I can remove all the
>> labels in that function.
> 
> Ok, I think I've gotten rid of them all, in both 32- and 64-bit
> versions. It boots here and a bunch of all*config builds pass.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Fri, 7 Sep 2018 12:47:10 +0200
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> When CONFIG_PARAVIRT_SPINLOCKS=n, it fires
> 
>   arch/x86/kernel/paravirt_patch_64.c: In function ‘native_patch’:
>   arch/x86/kernel/paravirt_patch_64.c:89:1: warning: label ‘patch_site’ defined but not used [-Wunused-label]
>    patch_site:
> 
> but those labels can simply be removed by directly calling the
> respective functions there.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Cc: virtualization@lists.linux-foundation.org
> ---
>  arch/x86/kernel/paravirt_patch_32.c | 21 ++++++++++-----------
>  arch/x86/kernel/paravirt_patch_64.c | 20 +++++++++-----------
>  2 files changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
> index d460cbcabcfe..af57f0d0789f 100644
> --- a/arch/x86/kernel/paravirt_patch_32.c
> +++ b/arch/x86/kernel/paravirt_patch_32.c
> @@ -34,14 +34,16 @@ extern bool pv_is_native_vcpu_is_preempted(void);
>  
>  unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
>  {
> -	const unsigned char *start, *end;
> +	const unsigned char *start __maybe_unused, *end __maybe_unused;
>  	unsigned ret;
>  
>  #define PATCH_SITE(ops, x)					\
>  		case PARAVIRT_PATCH(ops.x):			\
>  			start = start_##ops##_##x;		\
>  			end = end_##ops##_##x;			\
> -			goto patch_site
> +								\
> +			return paravirt_patch_insns(ibuf, len, start, end);
> +
>  	switch (type) {
>  #ifdef CONFIG_PARAVIRT_XXL
>  		PATCH_SITE(irq, irq_disable);
> @@ -58,27 +60,24 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
>  			if (pv_is_native_spin_unlock()) {
>  				start = start_lock_queued_spin_unlock;
>  				end   = end_lock_queued_spin_unlock;
> -				goto patch_site;
> +
> +				return paravirt_patch_insns(ibuf, len, start, end);
>  			}
> -			goto patch_default;
> +			return paravirt_patch_default(type, ibuf, addr, len);
>  
>  		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
>  			if (pv_is_native_vcpu_is_preempted()) {
>  				start = start_lock_vcpu_is_preempted;
>  				end   = end_lock_vcpu_is_preempted;
> -				goto patch_site;
> +
> +				return paravirt_patch_insns(ibuf, len, start, end);
>  			}
> -			goto patch_default;
> +			return paravirt_patch_default(type, ibuf, addr, len);
>  #endif
>  
>  	default:
> -patch_default: __maybe_unused
>  		ret = paravirt_patch_default(type, ibuf, addr, len);
>  		break;
> -
> -patch_site:
> -		ret = paravirt_patch_insns(ibuf, len, start, end);
> -		break;
>  	}
>  #undef PATCH_SITE
>  	return ret;
> diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
> index 5ad5bcda9dc6..2db6c615932f 100644
> --- a/arch/x86/kernel/paravirt_patch_64.c
> +++ b/arch/x86/kernel/paravirt_patch_64.c
> @@ -42,14 +42,15 @@ extern bool pv_is_native_vcpu_is_preempted(void);
>  
>  unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
>  {
> -	const unsigned char *start, *end;
> +	const unsigned char *start __maybe_unused, *end __maybe_unused;

Drop start and end and ...

>  	unsigned ret;
>  
>  #define PATCH_SITE(ops, x)					\
>  		case PARAVIRT_PATCH(ops.x):			\
>  			start = start_##ops##_##x;		\
>  			end = end_##ops##_##x;			\
> -			goto patch_site
> +								\
> +			return paravirt_patch_insns(ibuf, len, start, end);

... do: return paravirt_patch_insns(ibuf, len, start_##ops##_##x,
end_##ops##_##x)

and please omit the semicolon after the last instruction in the macro.

(below the same)

>  	switch(type) {
>  #ifdef CONFIG_PARAVIRT_XXL
>  		PATCH_SITE(irq, restore_fl);
> @@ -68,27 +69,24 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
>  			if (pv_is_native_spin_unlock()) {
>  				start = start_lock_queued_spin_unlock;
>  				end   = end_lock_queued_spin_unlock;
> -				goto patch_site;
> +
> +				return paravirt_patch_insns(ibuf, len, start, end);
>  			}
> -			goto patch_default;
> +			return paravirt_patch_default(type, ibuf, addr, len);
>  
>  		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
>  			if (pv_is_native_vcpu_is_preempted()) {
>  				start = start_lock_vcpu_is_preempted;
>  				end   = end_lock_vcpu_is_preempted;
> -				goto patch_site;
> +
> +				return paravirt_patch_insns(ibuf, len, start, end);
>  			}
> -			goto patch_default;
> +			return paravirt_patch_default(type, ibuf, addr, len);
>  #endif
>  
>  	default:
> -patch_default: __maybe_unused
>  		ret = paravirt_patch_default(type, ibuf, addr, len);
>  		break;
> -
> -patch_site:
> -		ret = paravirt_patch_insns(ibuf, len, start, end);
> -		break;
>  	}
>  #undef PATCH_SITE
>  	return ret;
> 

Juergen
