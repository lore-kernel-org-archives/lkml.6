Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D162086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aee0i9kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D162086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeKHRsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:48:09 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40355 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeKHRsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:48:09 -0500
Received: by mail-wm1-f42.google.com with SMTP id b203-v6so272206wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 00:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oRv1Z6RHKSMfwySoxfjuxrvFXwdbeAmXSJlk3Ckhtls=;
        b=aee0i9kQdWh4IrimlCwwUKuEcPmGBL8ME0OhY54W2ibbzD7/QBjYBvC36PT53er6zB
         fx+0Ywe6CN9U4RDK7o0o/EPC8tZZxeQfDH34mpplhxcjevp73/rlFtMDldvq3U5iaf/E
         VrojtaT5zWnasxpvp7QLoJAAa2u1csPri04nWJD+PclgDxqf5AplbnnPrDdcsh5g43B5
         VeAtJlCBSdgCMCLv/LVhqXGcvxvjATCNuXKYOxtts2qbs6JJqKFJtQ9n+m23TNqhZgmd
         PzNDLBztEXEZKT6JDWjLcl1wC9fcf21XTLSBLWALgtPwKJQN2Xq4ycYs23U90vg+4iLU
         Pn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oRv1Z6RHKSMfwySoxfjuxrvFXwdbeAmXSJlk3Ckhtls=;
        b=MDWPm9Za4jaaWx/IONpERyn6NU5ci2HBMP+x3pUDf8G0GaIWaX9CW3Pw++BBVipD2z
         t+zqBssNwf6xejX+HYCfWjuywSqli+1Zm8cTsxJ7J6+a7IN8TaRnQxyw4D47sWKjEjpu
         D6+UdFQ/4+wt530FO8SAE04t/1+wzHmN5pSkr5o2MiLjFdkSe+27PiE0myeNibwbuqdo
         zxW1q2qBVU41m6kThEyH4HjffpUDh9uPSL5rrxX7anIMSj3nygfjbULhSjRcbOKBsroN
         xxL7nSbBTJfamOn1Wr4fymEL2UHuzKAtQCzj6tcpWajBNB++oc3ISyaNuIb6iH1hfN0N
         QANw==
X-Gm-Message-State: AGRZ1gKt6Y4ngiHpQZvuMySXFqVJ9d1g4uJCh+PSd8481yA4TwGXgWWJ
        kJD0pt0lTeQq07n8ZF3ASi8PyzTq
X-Google-Smtp-Source: AJdET5dzG1S78BgPBwJVsFeszkJQ5VdnJWT+XqA/x8gxKVwBtBAZ/cOMmFBu1xK844/iGENsZkFNVQ==
X-Received: by 2002:a1c:d047:: with SMTP id h68-v6mr300924wmg.118.1541664828124;
        Thu, 08 Nov 2018 00:13:48 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i7-v6sm4703315wmd.41.2018.11.08.00.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 00:13:47 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:13:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108081345.GG20032@gmail.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107171149.165693799@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +Namespaces
> +^^^^^^^^^^
> +
> +To improve readability and to allow easy grepping for information the usage
> +of consistent namespaces is important. The namespace should be used as a
> +prefix for globally visible (inline) functions and variables. A simple rule
> +for chosing a namespace prefix is to combine the subsystem and the
> +component name, e.g. 'x86_comp\_', 'sched\_', 'irq\_', 'mutex\_', etc. For
> +static functions and variables the namespace prefix can be omitted.
> +
> +Also be careful when using vendor names in namespaces. There is no value of
> +having 'xxx_vendor\_' or 'vendor_xxx_` as prefix for all static functions
> +of a vendor specific file as it is already clear that the code is vendor
> +specific. Aside of that vendor names should only be used when it is really
> +vendor specific functionality.
> +
> +As always apply common sense and aim for consistency and readability.

I'd also suggest adding:

> +This also includes static file scope functions that are immediately put into 
> +globally visible driver templates - it's useful for those symbols to carry a
> +good prefix as well, for backtrace readability.
> +
> +Truly local functions, only called by other local functions, can have 
> +shorter descriptive names - our primary concern is greppability and 
> +backtrace readability.

Beyond the driver-template aspect also note the backtrace readability 
argument I added: good namespaces are not just about greppability.

Thanks,

	Ingo
