Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3658C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D84D20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9iHyn91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D84D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKHQj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:39:57 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37928 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:39:56 -0500
Received: by mail-wr1-f44.google.com with SMTP id d10-v6so19986949wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5jU00AhD3z0p44HJndZ6AHK//JtMnONOzAPnW++cgs0=;
        b=d9iHyn91HqvMfM7bLaqxIV5/dyMKdvWlZDJ2zduqnzgUfjq3Tb5ZqQXRjhxQWquz+D
         PTXbC4XUvSZdegiJRm+HYjfF8ls4guieZoikApWl928Ohl96BuwsmIEp9iVGciGpdJpz
         BsGEjARPwuqy0NoRuxEJMgGXUxvGFsR065mEq7h3Wipv2qiXtm0Fii7PoujAvSAM7dWH
         fAFmlKhta+v9FlTpimmM/v5aK6gCws7xGyflX9OtStNSzOkb55h5cGvT5ldOdpieggcl
         pNjHSnXp0NiPbbMhT7lRyN1ytZM0V/FKndF8nwGNuQePHFfiynRzpEG3bK8H1FwTly8M
         Cx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5jU00AhD3z0p44HJndZ6AHK//JtMnONOzAPnW++cgs0=;
        b=Lfaz37CanUqAbQ/S/aE7xHIJdRGZ8Ec8wNRqE37JQQ/9ieseWkyX+nUoZGDCwRA2uc
         R1ii9/Rrd+9D86HIOY4Q2xDqrHemnKr6aqokN5nWQYqnYwaWb0PyylyJ+fGIdlBHa6wr
         Ge+jy9ebv+abvM/SvLiCpV6dtzDZgpXwzjsi5t+GI+9RoUbCgWMQ9gV0c5r62jiuvqil
         W0eN+pChaa9PeOcaQVXGpM8Cemzm1w/yd6Wx28+tbQfqxJBlcZn2uAHmmZ0koxCsL2Gz
         GntsVUYuFw3OjxC82nA+9ISty7qrC9wCHyNLqgiCOJUxXfzEqkEJmTGnMnmc4IzwKSeR
         4fMQ==
X-Gm-Message-State: AGRZ1gKVaZA+bqewW7qRHP1ePVlbm4CYi7HEAFQZx4XaThyTFjULZI+X
        C0tCGJ5nqOzLnFKV48TudY0=
X-Google-Smtp-Source: AJdET5edg6D/Tu/tFdgJbLLLM3bG/4LnH1HR4thxujr2xRu6Y9YXm/PkoZaY1Cmx6NzqFwbbYKemfg==
X-Received: by 2002:adf:e581:: with SMTP id l1-v6mr2939539wrm.253.1541660751340;
        Wed, 07 Nov 2018 23:05:51 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u14-v6sm3291417wrs.27.2018.11.07.23.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 23:05:50 -0800 (PST)
Date:   Thu, 8 Nov 2018 08:05:47 +0100
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
Message-ID: <20181108070547.GA20032@gmail.com>
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

> +Coding style notes
> +------------------
> +
> +Comment style
> +^^^^^^^^^^^^^
> +
> +Sentences in comments start with a uppercase letter.
> +
> +Single line comments::
> +
> +	/* This is a single line comment */
> +
> +Multi-line comments::
> +
> +	/*
> +	 * This is a properly formatted
> +	 * multi-line comment.
> +	 *
> +	 * Larger multi-line comments should be split into paragraphs.
> +	 */
> +
> +No tail comments:
> +
> +  Please refrain from using tail comments. Tail comments disturb the
> +  reading flow in almost all contexts, but especially in code::
> +
> +  	if (somecondition_is_true) /* Don't put a comment here */
> +		dostuff(); /* Neither here */
> +
> +	seed = MAGIC_CONSTANT; /* Nor here */
> +
> +  Use freestanding comments instead::
> +
> +	/* This condition is not obvious without a comment */
> +	if (somecondition_is_true) {
> +		/* This really needs to be documented */
> +		dostuff();
> +	}
> +
> +	/* This magic initialization needs a comment. Maybe not? */
> +	seed = MAGIC_CONSTANT;

Yeah, so I think a better way to visualize and explain the 'no tail 
comments' guideline in -tip is not these more complex code flows, but the 
totally simple linear flows of statements.

With tail comments the code looks like this:

	res = dostuff(); /* We explain something here. */

	seed = 1; /* Another explanation. */

	mod_timer(&our_object->our_timer, jiffies + OUR_INTERVAL); /* We like to talk */

	res = check_stuff(our_object); /* We explain something here. */
	if (res)
		return -EINVAL;

	interval = nontrivial_calculation(); /* Another explanation. */

	mod_timer(&our_object->our_timer, jiffies + interval); /* This doesn't race, because. */

... while with freestanding comments it's:

	/* We explain something here: */
	res = check_stuff(our_object);
	if (res)
		return -EINVAL;

	/* Another explanation: */
	interval = nontrivial_calculation();

	/* This doesn't race with init_our_stuff(), because: */
	mod_timer(&our_object->our_timer, jiffies + interval);

This comment placement style has several advantages:

  - Comments precede actual code - while in tail comments it's exactly
    the wrong way around.

  - We don't create over-long lines nor artificially short tail comments 
    just because we were trying to stay within the col80 limit with the 
    "this doesn't race" comment. The full-line comment was able to 
    explain that the race is with init_our_stuff().

  - Freestanding oneliner comments are much better aligned as well: note 
    how ever comment starts at the exact same column, making it very easy 
    to read (or not to read) these comments.

  - In short: predictable visual parsing rules and proper semantic 
    ordering of information is good, random joining of typographical 
    elements just to create marginally more compact source code is bad.

  - Just *look* at the tail comments example: it's a visually diffuse, 
    jumble of statements and misaligned comments with good structure.

Do you want me to send a delta patch, or an edited document?

Thanks,

	Ingo
