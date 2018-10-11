Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C31DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A92521470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyLDvQIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A92521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeJLA6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:58:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39053 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeJLA6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:58:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so10247124wmd.4;
        Thu, 11 Oct 2018 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:references:user-agent:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=jw5SJVgl/NVu04ZCTIosEqV9bKq4TEHenpiEG+fQ0d0=;
        b=JyLDvQIRGvH9nkjhWon0CQuRZJuu6GtXEuKftGsl4hQIXW/q/Px5vYJCsw2VCbsppH
         XgTUt5wG6toXL6WGy/H2gUjNLW8b3yAlRnOOkrbk64Jh4RpL5dfQ3bUu2yJruJKzYuNC
         Mpcmy7Xobq6cpVMO1okfzwayVGkAJdyUyKkiFlKRlame3T0mRx0OTdK3YOOMlbjaKH9T
         8ulYnaVb1J1l27bV9meVMvldAOpf5NMPmKrBtKNEjCvbH/S2Hkm7MuZBuh05wfVVBFWK
         +L/nK8/XGCVkDE+jQcTlYFG671Ik9BZ56xK06pY8mLTsEdmmotEuD37ReyZKjUrACPLT
         Fndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:user-agent:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=jw5SJVgl/NVu04ZCTIosEqV9bKq4TEHenpiEG+fQ0d0=;
        b=blIL/I/8GU/yJKLJkcn1pVOXpuhn9FSWeoKb7mdbrq2wPxj/U+ZaetDburEjOTtJdr
         amnp+ZzsRfAz+TCABHH9HwZ1LDZt4t2WObh3IQqWtGFcsQ7A+UM/+t5CkX72LxWSwk6v
         x8UeRnOe9RVpyqFRBbCEClj3stqVDV3x2ZMAbORVfUHcFoS5DHCLyK2WXx9d/9HpGPIf
         QZKNzy51pWo/MtqUyOXhhAOPynDGHI19ArNFnU7+Dwas1Yg39LUR1YEtiuTQIdghhzFa
         qfhOWO0QGamHJxSzJ0E81q/t+3jPTncZh+HUXJSX6N4p7+HcQTTd826MD/6wfdnCYwqC
         4hbA==
X-Gm-Message-State: ABuFfojLp+cpwoBu4/Ng5yx78IHam89fbsP1cMjL5Q2mttdVdfUe9jvC
        FdRDUvJE5tFToJq2FSw1mTQ=
X-Google-Smtp-Source: ACcGV62/woU1t42YEzzQ0gX/OL015wWDpSCV9GZCouwtHWQBHmO263fP5yf0UYOe2+w9v24slMw4QA==
X-Received: by 2002:a1c:4d0b:: with SMTP id o11-v6mr2573843wmh.94.1539279031744;
        Thu, 11 Oct 2018 10:30:31 -0700 (PDT)
Received: from ptitpuce.local (val06-1-88-182-161-34.fbx.proxad.net. [88.182.161.34])
        by smtp.gmail.com with ESMTPSA id z12-v6sm14216876wrv.46.2018.10.11.10.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 10:30:30 -0700 (PDT)
From:   Christophe de Dinechin <christophe.de.dinechin@gmail.com>
X-Google-Original-From: Christophe de Dinechin <christophe@dinechin.org>
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-4-bigeasy@linutronix.de>
User-agent: mu4e 1.0; emacs 25.2.1
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 03/11] x86/fpu: make __raw_xsave_addr() use feature number instead of mask
In-reply-to: <20181004140547.13014-4-bigeasy@linutronix.de>
Date:   Thu, 11 Oct 2018 19:30:07 +0200
Message-ID: <m1murk75nk.fsf@dinechin.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sebastian Andrzej Siewior writes:

> Most users of __raw_xsave_addr() use a feature number, shift it to a
> mask and then __raw_xsave_addr() shifts it back to the feature number.
>
> Make __raw_xsave_addr() use the feature number as argument.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/fpu/xstate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 87a57b7642d36..38d0b5ea40425 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -811,10 +811,8 @@ void fpu__resume_cpu(void)
>   *
>   * Note: does not work for compacted buffers.
>   */
> -void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
> +void *__raw_xsave_addr(struct xregs_state *xsave, int feature_nr)

It might be clearer to offer both interfaces, since both are used?

>  {
> -	int feature_nr = fls64(xstate_feature_mask) - 1;
> -
>  	if (!xfeature_enabled(feature_nr)) {
>  		WARN_ON_FPU(1);
>  		return NULL;
> @@ -842,6 +840,7 @@ void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
>   */
>  void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
>  {
> +	int feature_nr;
>  	/*
>  	 * Do we even *have* xsave state?
>  	 */
> @@ -869,7 +868,8 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
>  	if (!(xsave->header.xfeatures & xstate_feature))
>  		return NULL;
>
> -	return __raw_xsave_addr(xsave, xstate_feature);
> +	feature_nr = fls64(xstate_feature) - 1;
> +	return __raw_xsave_addr(xsave, feature_nr);

and then move that to a wrapper function that takes a mask?

>  }
>  EXPORT_SYMBOL_GPL(get_xsave_addr);
>
> @@ -1018,7 +1018,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
>  		 * Copy only in-use xstates:
>  		 */
>  		if ((header.xfeatures >> i) & 1) {
> -			void *src = __raw_xsave_addr(xsave, 1 << i);
> +			void *src = __raw_xsave_addr(xsave, i);
>
>  			offset = xstate_offsets[i];
>  			size = xstate_sizes[i];
> @@ -1104,7 +1104,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
>  		 * Copy only in-use xstates:
>  		 */
>  		if ((header.xfeatures >> i) & 1) {
> -			void *src = __raw_xsave_addr(xsave, 1 << i);
> +			void *src = __raw_xsave_addr(xsave, i);
>
>  			offset = xstate_offsets[i];
>  			size = xstate_sizes[i];
> @@ -1161,7 +1161,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
>  		u64 mask = ((u64)1 << i);
>
>  		if (hdr.xfeatures & mask) {
> -			void *dst = __raw_xsave_addr(xsave, 1 << i);
> +			void *dst = __raw_xsave_addr(xsave, i);
>
>  			offset = xstate_offsets[i];
>  			size = xstate_sizes[i];
> @@ -1215,7 +1215,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
>  		u64 mask = ((u64)1 << i);
>
>  		if (hdr.xfeatures & mask) {
> -			void *dst = __raw_xsave_addr(xsave, 1 << i);
> +			void *dst = __raw_xsave_addr(xsave, i);
>
>  			offset = xstate_offsets[i];
>  			size = xstate_sizes[i];


--
Cheers,
Christophe de Dinechin (IRC c3d)
