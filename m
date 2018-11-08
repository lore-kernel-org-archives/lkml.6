Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A76C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145232081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA55w6V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145232081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKHQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:48:24 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39567 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:48:24 -0500
Received: by mail-wm1-f52.google.com with SMTP id u13-v6so139705wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IOI5Byqvujf9twcMR9hcxIR2eQ4JMv8fiW+U6OB0WBw=;
        b=HA55w6V2dj4hxK6twAz2ZtVrr6IXDQKFP3B0XZ9zucuwINhz96xajjwoTjZrm2DXEH
         PR0mkd26DMS+XNoQdrjOvt51wVtfYrFGDa5YwAgfAoubiMxWyoX5tGqgi2ApF0j0pcde
         /PsjEOEK37qsI74gXZH9D30P/j4ds+0j9BQRCageqmJS3uaZzWH+A7k0T3qwUIjV9kmJ
         zmo8klzx+dK1ApZEj71RkTLFsbn/24yD+omJ18PXbLCOpv3hZ/bCF260G6iuxT7AZ/yB
         6y9gu8nusR5Cqm0oZgOxjDNLUqGJrn55k1ez3jn7sWF0bVzYsO/lnJzERQ1JzWcqpx0/
         afuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IOI5Byqvujf9twcMR9hcxIR2eQ4JMv8fiW+U6OB0WBw=;
        b=SmENvOZw7Y6UnK+zL+98pSp8Jk5iOIdcTc+1YI2ifHkZlXTz4rT6g/Vc6pOqBcGezf
         gCJ6NogDht6kRX+Ns6+IhcGmQiN5TEOxXTqfkMdforYQ+uHGDoHqSEcxTTLRXzMV+F8N
         7VGzYaTnJr/rumv2ZRFTnT6TtTmqYBfEp/rWyXu4j+whAqv5ltQuV4Lb27Qe7SUa4QHE
         WGlZhlnm1DNjYp2Ur2nEp0aONtg/2l/26jeG+hbDCF3izmwNQtyceN2Ahk1wcyzAVGXR
         LN+6nsSXaw4OCYCjPl9jyuS5FsMxyi2DZv33B6FYmXFwQNfB+C9p82SWstwX0/jrclTK
         3XHg==
X-Gm-Message-State: AGRZ1gK0p/p28PRvdovcWIldB/xuAcuCuhn1KIQCJKcFiCY4OxVzyyDC
        PpriNRC3Io3/1lCdtvObM0A=
X-Google-Smtp-Source: AJdET5dNTAwirRt6uo1feLrEj0jQjnvPxnrtnvJHZi8lEwqrkyl3F17pSLOoxZH60qwD+PhJRpThdQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14-v6mr113652wmg.45.1541661256470;
        Wed, 07 Nov 2018 23:14:16 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a127-v6sm2974340wmh.24.2018.11.07.23.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 23:14:15 -0800 (PST)
Date:   Thu, 8 Nov 2018 08:14:13 +0100
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
Message-ID: <20181108071413.GA25195@gmail.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
 <20181108070547.GA20032@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108070547.GA20032@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> With tail comments the code looks like this:
> 
> 	res = dostuff(); /* We explain something here. */
> 
> 	seed = 1; /* Another explanation. */
> 
> 	mod_timer(&our_object->our_timer, jiffies + OUR_INTERVAL); /* We like to talk */
> 
> 	res = check_stuff(our_object); /* We explain something here. */
> 	if (res)
> 		return -EINVAL;
> 
> 	interval = nontrivial_calculation(); /* Another explanation. */
> 
> 	mod_timer(&our_object->our_timer, jiffies + interval); /* This doesn't race, because. */
> 
> ... while with freestanding comments it's:
> 
> 	/* We explain something here: */
> 	res = check_stuff(our_object);
> 	if (res)
> 		return -EINVAL;
> 
> 	/* Another explanation: */
> 	interval = nontrivial_calculation();
> 
> 	/* This doesn't race with init_our_stuff(), because: */
> 	mod_timer(&our_object->our_timer, jiffies + interval);
> 
> This comment placement style has several advantages:
> 
>   - Comments precede actual code - while in tail comments it's exactly
>     the wrong way around.
> 
>   - We don't create over-long lines nor artificially short tail comments 
>     just because we were trying to stay within the col80 limit with the 
>     "this doesn't race" comment. The full-line comment was able to 
>     explain that the race is with init_our_stuff().
> 
>   - Freestanding oneliner comments are much better aligned as well: note 
>     how ever comment starts at the exact same column, making it very easy 
>     to read (or not to read) these comments.
> 
>   - In short: predictable visual parsing rules and proper semantic 
>     ordering of information is good, random joining of typographical 
>     elements just to create marginally more compact source code is bad.
> 
>   - Just *look* at the tail comments example: it's a visually diffuse, 
>     jumble of statements and misaligned comments with good structure.

Forgot to mention the role of punctuation:

    - Also note how punctuation actually *helps* the integration of 
      comments and code. The ":" will direct attention to the code that 
      follows, making it clear that the sentence explains the next 
      statement. There are exceptions for when different type of 
      punctuation is a better choice, for example:

	/* TODO: convert the code to our newest calc API ASAP. */
	interval = nontrivial_calculation();

      Here we don't explain the statement but document a TODO entry. 

      Also, it's frequent practice to use multi-line comments to explain 
      the next section of code, with a particular note about the first 
      statement. Proper punctuation helps there too:

	/*
	 * Establish the timeout interval and use it to set up
	 * the timer of our object. The object is going to be
	 * freed when the last reference is released.
	 *
	 * Note, the initial calculation is non-trivial, because
	 * our timeout rules have complexity A), B) and C):
	 */
	interval = nontrivial_calculation();

      Note how part of the multi-line comment describes overall 
      principles of the code to follow, while the last sentence 
      describes a noteworthy aspect of the next C statement.

Thanks,

	Ingo
