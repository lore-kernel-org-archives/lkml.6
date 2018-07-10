Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AA2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A7B2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoZ8raoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A7B2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeGJF1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:27:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53696 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeGJF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:27:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so23248026wme.3;
        Mon, 09 Jul 2018 22:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RkINdTTaP58ieF7N2A1pDIHfKFsJP7k2+DlaJ/8I45I=;
        b=DoZ8raoKka0Vi2cgsPbQBhbW6MebbRH+Jvy+d3RqXqv4c4jwkEn4m4lA1Dx6frBLkm
         /S1CJm8QeaZYDoD70B+/7WtNU+MndTj1AzEh9U8cqGNPmJzJVt9ec7EvqFp+I7L/wm8V
         flwE4gJQw0qKSUfnMHTeocP8yAyprBDszTgn9CNYnVSb1ZZqkLxP79eTT1ISZlPsUx9x
         g8MfyVywOMG3pYc6/ivrxlZQRmAeyNY48mdO8nFUz9sIiRk5pNH7TOn7L2KkJ2q0/67x
         Wkk03alHnV5BkRNCro82vEA29vsUHItBjus6Q5iMBpoiCPMWoDINfOna/Djl8CPBptRZ
         3vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RkINdTTaP58ieF7N2A1pDIHfKFsJP7k2+DlaJ/8I45I=;
        b=BhKHNb0slZruHLRi3i5j8NzT2KzD9AHoVMyeOJfmA7CYZ2ht4Tdwt4wmu1tgEMbI5K
         dGfgt7IsB+T7F2NuL00lesuR5e/ffqY5//dzqcjTxtmgBQlRym3EMqVXNEmacacZ7map
         bBR7bTTT2B88uy2xacp1xuSstiITlAxpzpaqoHyZ+QR7DL5wXq8BMWEJhSitXrqkbS6V
         eVCm7ESyD7JR17Xt4JCpgum+hWrVPTJIekTtKPrYNiflr29pytnXk4Hve3G7FBAtI4Fn
         PCjKH7/T5b9nzS5BTcn3P4bK9NtGR8SWGNMN4BT0sBTieX4lkOuSF0dZEbBCZ7PGF23N
         lo9Q==
X-Gm-Message-State: APt69E25Qj2bEx22YUVsVl8gt0NHxu1wHdS4pWiXHuj7MrtdDGDYb8Q8
        ZAcMxK151xJGMC3CpvDgjZOVyg==
X-Google-Smtp-Source: AAOMgpdReG/rN6aEYE9eY8/Oe3tQIq2Cfwwe1J20K6P3Z7Dnkaemz0BT5NLoK0Injhp1DVkfDrjkJg==
X-Received: by 2002:a1c:cf81:: with SMTP id f123-v6mr14575783wmg.3.1531200468279;
        Mon, 09 Jul 2018 22:27:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s12-v6sm13637108wmc.2.2018.07.09.22.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 22:27:47 -0700 (PDT)
Date:   Tue, 10 Jul 2018 07:27:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH v2] objtool: move libelf detection to Kconfig from
 Makefile
Message-ID: <20180710052745.GA16938@gmail.com>
References: <1531186516-15764-1-git-send-email-yamada.masahiro@socionext.com>
 <20180710022904.e3oql2ts4qz43bzo@treble>
 <CAK7LNASM+81JkGu5-z8GRZ9+sRyd55gO0G0M5c54zRhE5JhE3g@mail.gmail.com>
 <20180710042609.zie5fgrvoyusmeod@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710042609.zie5fgrvoyusmeod@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Since we switched the x86_64 default to the ORC unwinder, a lot of
> people have switched over.  But this patch will reverse (or at least
> slow down) that trend, because almost nobody has the libelf devel
> packaged installed by default.  So over time, it will effectively make
> frame pointers the default again in many cases.  That's exactly what we
> *don't* want to do.  It will also cause people to accidentally re-enable
> frame pointers when they thought they had ORC.

Yeah, agreed - turning ORC off like that is a non-starter.

Thanks,

	Ingo
