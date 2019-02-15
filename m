Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46687C10F08
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034A021B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550223388;
	bh=viaP8pi+j0HPcwV2AJGHxK7282GzeSe8ViWZS4l6QJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PzbMDWdWRV9+AEAzagNFQlkOiX5P8XE7shDb2s00t71fWf/Vtpvssh6DHm98zv6TD
	 95WWQcok9fhL7q5x2uHxQevmKzGR2d4cDknxcas1G7TVKJEVdrQJCTYzDVQM7jFANI
	 TANE1On+eHVP2d7JGsxTU7PykwiG9kr6PTF2yaOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392999AbfBOJg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:36:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54845 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfBOJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:36:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so9234162wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hUJbgrIil+SxD1M9JonZtUjsa7KuDTQAYaLl25F+q+8=;
        b=FA+/PrPU7mlIobgH5XoFyGNE2InDhTZKZPnwNrlGNRyrezxkpMZHfrXsNd+LtFviEX
         dKNU2eC4+sOspZD/adZgE2CIJ5ipSXt8y6/uRKqj2ywipNYjy3VA8WvAPxytWcJnKhRT
         XPwiUsrBwgfQFlfxQ5nlO4aA8kmXiTI1yEogyxwB2V+qJu2aVytFubnHgfWSqRzw0UKG
         dwUt7BQ3W+XpSdpTZuZCLbsTZRsVXXoWSr6EsoMprDRl41LP2SAfFyWYyYWgRIJMMZkt
         +PUNGMfg6RN/Pd45NPYruXSEN5/mvmirTEDRaA+tsaWJYFXQYeSROB9L8vGSsRUIjfMD
         97pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hUJbgrIil+SxD1M9JonZtUjsa7KuDTQAYaLl25F+q+8=;
        b=DgsjPE+dJFKOEMfGW7UOqYzhuA1fzDVj/DuX/ssEf3kzteUrSmPLcqrVOZCojXQ+QP
         d6XgGGsRCGTuWFNPDOnG22EWv80+0uEyHn+/xVBKC1xlienCjNjd6oENWvwRj/2WO2Q2
         fWwIo9kHXtLoP6evnY/fKx9+cWIOPBKyc3P66BvlapxxmEIL117XtoM/3WocnaM5Rojs
         Etkk6BVFVKqxSNWFyiVG/jGgKHA3zgxp2lcRRSmKVtFZxKQ5jTZIH9ToQ2+Za7ZMZUkG
         6lTbh3qR4CYn1SWKbf9vKZeV59bvRs5Jfed3gi4rerSKv+c6ZRvLNkwAbOAGgwXom9EG
         DJHA==
X-Gm-Message-State: AHQUAuY+4pPK3kG3KBxK728U9XN2A7V5jVRosikWNaEBz7vj2QuYpwbY
        jL765/HvSOAOunbdtM9sVLU=
X-Google-Smtp-Source: AHgI3IbsKMbWxGRWMk7U5+S71JuqojwEmyAFx4OWdxKFg3s03lepV3FBK7RG1gKnmLoMOy3IzpATlw==
X-Received: by 2002:a1c:cf43:: with SMTP id f64mr4905480wmg.61.1550223381721;
        Fri, 15 Feb 2019 01:36:21 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s8sm8740640wrn.44.2019.02.15.01.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 01:36:21 -0800 (PST)
Date:   Fri, 15 Feb 2019 10:36:18 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jan@schnhrr.de>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/tsc: Allow quick PIT calibration despite
 interruptions
Message-ID: <20190215093618.GA84754@gmail.com>
References: <20190214214608.8672-1-jan@schnhrr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214214608.8672-1-jan@schnhrr.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan H. Schönherr <jan@schnhrr.de> wrote:

> Some systems experience regular interruptions (60 Hz SMI?), that prevent
> the quick PIT calibration from succeeding: individual interruptions can be
> so long, that the PIT MSB is observed to decrement by 2 or 3 instead of 1.
> The existing code cannot recover from this.
> 
> The system in question is an AMD Ryzen Threadripper 2950X, microcode
> 0x800820b, on an ASRock Fatal1ty X399 Professional Gaming, BIOS P3.30.
> 
> Change the code to handle (almost) arbitrary interruptions, as long
> as they happen only once in a while and they do not take too long.
> Specifically, also cover an interruption during the very first reads.
> 
> Signed-off-by: Jan H. Schönherr <jan@schnhrr.de>
> ---
> 
> v2:
> - Dropped the other hacky patch for the time being.
> - Fixed the early exit check.
> - Hopefully fixed all inaccurate math in v1.
> - Extended comments.
> 
>  arch/x86/kernel/tsc.c | 91 +++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index e9f777bfed40..aced427371f7 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -485,7 +485,7 @@ static inline int pit_verify_msb(unsigned char val)
>  static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *deltap)
>  {
>  	int count;
> -	u64 tsc = 0, prev_tsc = 0;
> +	u64 tsc = get_cycles(), prev_tsc = 0;
>  
>  	for (count = 0; count < 50000; count++) {
>  		if (!pit_verify_msb(val))
> @@ -500,7 +500,7 @@ static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *de
>  	 * We require _some_ success, but the quality control
>  	 * will be based on the error terms on the TSC values.
>  	 */
> -	return count > 5;
> +	return count > 0 && pit_verify_msb(val - 1);
>  }
>  
>  /*
> @@ -515,7 +515,8 @@ static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *de
>  static unsigned long quick_pit_calibrate(void)
>  {
>  	int i;
> -	u64 tsc, delta;
> +	u64 tsc = 0, delta;
> +	unsigned char start;
>  	unsigned long d1, d2;
>  
>  	if (!has_legacy_pic())
> @@ -547,43 +548,65 @@ static unsigned long quick_pit_calibrate(void)
>  	 */
>  	pit_verify_msb(0);
>  
> -	if (pit_expect_msb(0xff, &tsc, &d1)) {
> -		for (i = 1; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
> -			if (!pit_expect_msb(0xff-i, &delta, &d2))
> -				break;
> -
> -			delta -= tsc;
> -
> -			/*
> -			 * Extrapolate the error and fail fast if the error will
> -			 * never be below 500 ppm.
> -			 */
> -			if (i == 1 &&
> -			    d1 + d2 >= (delta * MAX_QUICK_PIT_ITERATIONS) >> 11)
> -				return 0;
> -
> -			/*
> -			 * Iterate until the error is less than 500 ppm
> -			 */
> -			if (d1+d2 >= delta >> 11)
> -				continue;
> -
> -			/*
> -			 * Check the PIT one more time to verify that
> -			 * all TSC reads were stable wrt the PIT.
> -			 *
> -			 * This also guarantees serialization of the
> -			 * last cycle read ('d2') in pit_expect_msb.
> -			 */
> -			if (!pit_verify_msb(0xfe - i))
> -				break;
> -			goto success;
> +	/*
> +	 * Reading the PIT may fail or experience unexpected delays (due to
> +	 * SMIs, for example). Assuming, that these underlying interruptions
> +	 * happen only once in a while, we wait for two successful reads.
> +	 * Of these, we assume that the better one was not delayed and use
> +	 * it as the base for later calculations.
> +	 */
> +	for (i = 0; i <= MAX_QUICK_PIT_ITERATIONS; i++) {
> +		if (!pit_expect_msb(0xff - i, &delta, &d2))
> +			continue;
> +
> +		if (!tsc) {
> +			/* first success */
> +			start = i;
> +			tsc = delta;
> +			d1 = d2;
> +			continue;
>  		}


The logic looks mostly good to me, but do we really want to use 'delta' 
as an implicit success-counter here? In principle 'delta' could end up 
being 0 due to some TSC borkage, and we'd interpret that as "first 
success", which it clearly isn't.

The end result will still be a 'failure', but why not use a proper 
separate variable to count attempts and make the code easier to read and 
failure scenarios more predictable?

Thanks,

	Ingo
