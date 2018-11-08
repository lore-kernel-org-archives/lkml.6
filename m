Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3BEC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586DE2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFPij7EE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586DE2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKHRFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:05:07 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40447 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:05:06 -0500
Received: by mail-wm1-f47.google.com with SMTP id b203-v6so170171wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mc195RJu0UJs4H78Cp7za0Bh0tH77ZEKKnpx/sQZboE=;
        b=nFPij7EE1+dyNU+aJiMriy5Zq/fTKs3nWHmRCQ5sU6X9SQ7mLBLvcsInZBKAha1UeW
         FmEoiG/FZGwv+1G+IJLH1vS7W2v0dPRdxDkQnNk/F8EqSymqZFzOC3pWwn90tQM6U4Ur
         rorEy0pKpdpSWZ3RCo4cOut4y8fXHBGK4pfLf3/t60P3aeekUp06sN++uuLDPXYwBP7T
         UFFEsVO4PGsUz3j5B3VMbd2jDLJYcYgpz/Qy1gBfuMGgtF512iMIcoyIFk/uuD+FbH2I
         CtqGLhnrYQEJ6nX6cPXX9ahzKxuQ1z3id+XtZYoYrjlEZwuqN0iDikQzNYxImed+L5rE
         KKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mc195RJu0UJs4H78Cp7za0Bh0tH77ZEKKnpx/sQZboE=;
        b=Xv51mY08RdKewjSeiwMbTl+3lg4t45IpmCqQu7ZcRJVLH1yJZ5UUKv2MC9WsA0rTZi
         +6cmXyGBn7DeJD+ey1x1ccU+GZ02E1AOxQpM8NR9ADnfDO8YIgXB/a11m4WKhY25bCeI
         LiPm1VkYtn9jsU9U+RUVQTPllJUwJfdGuEQw1/BCy3qfCErpw8cPgGwUymgRvnHmGvef
         ZcZwhd+2st23EP+og4k9tXzo8e07S2iC1m5UOxQiwXGm80avOatfk+2NA41SxMAhRLb0
         Y/aDMFXLJz4KtKTXUCT0/3cDmUwtXjyh0zc3weIIqgpxES0ixYgXOl+K+6ZdiC3PT7TE
         HBCw==
X-Gm-Message-State: AGRZ1gKa0dwgDfylXV41K1cJbgER5Mm9eWnZsWCbT2YoFif1JdVEI7aZ
        36uESK/ysQu6CgPC8Ua7gb0=
X-Google-Smtp-Source: AJdET5cb2ki/ffE34Xd4xkH3jA1NeY7odtZFxCdBnSi8wNr7lzH2Mbc+CYrsL5F9eidjSlj9fJ/uLQ==
X-Received: by 2002:a1c:e088:: with SMTP id x130-v6mr178870wmg.6.1541662254918;
        Wed, 07 Nov 2018 23:30:54 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m9-v6sm3014753wrn.36.2018.11.07.23.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 23:30:54 -0800 (PST)
Date:   Thu, 8 Nov 2018 08:30:51 +0100
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
Message-ID: <20181108073051.GC20032@gmail.com>
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

> + - Fixes: 12char-SHA1 ("sub/sys: Original subject line")
> +
> +   A Fixes tag should be added even for changes which do not need to be
> +   backported to stable kernels, i.e. when addressing a recently introduced
> +   issue which only affects tip or the current head of mainline. These tags
> +   are helpful to identify the original commit and are much more valuable
> +   than prominently mentioning the commit which introduced a problem in the
> +   text of the changelog itself because they can be automatically
> +   extracted.
> +
> +   The following example illustrates the difference::
> +
> +     Commit
> +
> +       abcdef012345678 ("x86/xxx: Replace foo with bar")
> +
> +     left an unused instance of variable foo around. Remove it.
> +
> +     Signed-off-by: J.Dev <j.dev@mail>
> +
> +   Please say instead::
> +
> +     The recent replacement of foo with bar left an unused instance of
> +     variable foo around. Remove it.
> +
> +     Fixes: abcdef012345678 ("x86/xxx: Replace foo with bar")
> +     Signed-off-by: J.Dev <j.dev@mail>

Let me extend this policy element, I frequently write out commits in the 
changelog itself *as well*, because that's where I utilize it myself when 
reading other people's changelogs.

I.e. I would convert this:

     The recent replacement of left with right left an unused instance of
     variable left around. Remove it.

     Fixes: abcdef012345678 ("x86/xxx: Replace 'left' with 'right')
     Signed-off-by: J.Dev <j.dev@mail>

... to the following form:

     Two years ago the following commit:

       abcdef012345678 ("x86/xxx: Replace foo with bar")

     ... left an unused instance of the variable 'left' around. Remove it.

     Fixes: abcdef012345678 ("x86/xxx: Replace 'left' with 'right')
     Signed-off-by: J.Dev <j.dev@mail>

This changelog style, while more verbose, has a couple of advantages:

 - It's a bad practice to force the reader to go the tags sections, fish
   out a commit ID, just to be able to see the original commit. 
   Especially with longer changelogs and with changelogs mentioning 
   multiple source commits in-lining the commit ID is useful.

 - Also note how this style allows for human-readable time information to
   be inserted - which can be important to backporters. While an unused
   variable warning might not be backported, in other cases the time
   information can be useful in prioritizing the backporting.

 - Also note another pet peeve of mine: the quotation marks around the 
   variable names 'left' and 'right'. I changed the variable names to 
   English words that are ambiguous in free-flowing changelog text, just
   to illustrate how important it can be to escape them for better
   readability.

The 'Fixes' tag is mainly a standard tag that backporter tooling can 
search for - otherwise for human readers the in-line explanation is more 
useful.

I really trivial cases the inlining can be skipped and only a 'Fixes' tag 
is perfectly sufficient.

Thanks,

	Ingo
