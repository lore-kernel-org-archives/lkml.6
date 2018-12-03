Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE02C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF50221479
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc1RJ7AS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF50221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeLCJPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:15:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40789 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLCJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:15:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so11262223wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQaEkHRaot1wBFKxlKh+ZrWlG+RRqLhA+1jrGGt8gFI=;
        b=oc1RJ7ASedxO4KYiamh3dO34V6Pe2aJj/8ofYGBvnutmi7b6z9Ep5fPQctW8vpI3y4
         qtUlpvdV0CQh4YMM9+i1yZ3VKwOKIdDD/01XMJOySmEazlJgZ5R74nIyHlDpDljrsDgJ
         e9al/nVMWK7x9iBY2XqeYTjgNEqSJdKoFsmlCZtR0fIlHX4WNjbciuBPZFTbErpGnl/G
         GtDdnN99ESc9wSMIGH4BwY6sdt/LnAy/oZ1elNiXfDozr/P33dWh26jUe2G29z0e3U9k
         YPunzyol3AQnyDlzN6h2Vjuz/yaA10Xn5Cgs8MnvLfL61nQ93Lt3UE3eLKHW9j8DKQQg
         p5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQaEkHRaot1wBFKxlKh+ZrWlG+RRqLhA+1jrGGt8gFI=;
        b=j9FGdMqZ46TI6XUbAJMyT2DH5Vtoq7NJ2CxwDp0LzgXKycmCCfb286JILvl1dGLuZv
         mYpjY8ojGzReuFNUxpkYwUVKqbJqNOSiQ/PmoKNNft++v9fIsfYQMvme44BPNs0nW+On
         D40YmZGQbFrf7rW9juoX4c64n/+4l0OvTfmoaOhTA/LWtIoPJ/dR1Of1upGWz5SlQGy0
         9QolyQSD3Ola9TemYGU9E7bx4pRjOB+aEGFFtDmCfTEHVA/SwJ1X13fsYqLwbjqREmy3
         QR8jxYIQjIwna6+oeXG9ueo1YlDxU8wxEFss+DKuG5//2ffBAoTJy1KGSIdWIy/TvxYL
         5+ug==
X-Gm-Message-State: AA+aEWazblYgwzP4NgVlYxKxGHs5u3NHIWV46vr1OHhH6Q//TlqaqqCr
        Tvt7g+wr6S+ubZVxQ/ntpns=
X-Google-Smtp-Source: AFSGD/VPIYXPQG3O7+8BsG7Z7v5j1fi6Nj8lYLLRqtlcWOaFztIxikNApX+y8loeNaVc0gqWgaQ/rQ==
X-Received: by 2002:adf:8264:: with SMTP id 91mr12679104wrb.312.1543828525112;
        Mon, 03 Dec 2018 01:15:25 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h4sm11655611wrt.66.2018.12.03.01.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 01:15:24 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:15:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        "Peter Zijlstra (Intel)" <peterz@infraded.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] cpu: Bool tests don't need comparisons
Message-ID: <20181203091522.GC2516@gmail.com>
References: <20181201080444.9305-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201080444.9305-1-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Wen Yang <wen.yang99@zte.com.cn> wrote:

> This is the patch to the file cpu.c
> which fixes the following coccinelle warning:
> 
> WARNING: Comparison to bool
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> CC: Josh Poimboeuf <jpoimboe@redhat.com>
> CC: "Peter Zijlstra (Intel)" <peterz@infraded.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Mukesh Ojha <mojha@codeaurora.org>
> CC: linux-kernel@vger.kernel.org
> ---
>  kernel/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 91d5c38eb7e5..5bdd7e150a11 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1650,7 +1650,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
>  	lockdep_assert_cpus_held();
>  
>  	sp = cpuhp_get_step(state);
> -	if (sp->multi_instance == false)
> +	if (!sp->multi_instance)
>  		return -EINVAL;
>  

This is a *totally* bogus explanation.

This is an equivalent pattern to '== 0' which is commonly used.

The patch is still doing the right thing, but only accidentally, for 
another reason, it's because we are using ->multi_instance in an 
inconsistent fashion:

 kernel/cpu.c:	if (!step->multi_instance) {
 kernel/cpu.c:	if (sp->multi_instance == false)
 kernel/cpu.c:	if (!sp->multi_instance)
 kernel/cpu.c:	if (sp->multi_instance) {

But that's really just by accident - if all usages were of the
'== true/false' pattern then this wouldn't be necessary.

Thanks,

	Ingo
