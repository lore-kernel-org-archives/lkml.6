Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5BFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3601C2152A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O7FXuvht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3601C2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeHOWgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:36:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40547 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeHOWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:36:10 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so3498729ita.5;
        Wed, 15 Aug 2018 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYh9GDDso6xdaM96rzYq8m0zOUEfU+iT8h6UTGVAEZ0=;
        b=O7FXuvht0Q1rgnUf/cT+GbusP3M+jqCmIhNTiLmNTiFVjqH0vDIhqyLzKnhNGBn2BV
         X2YagQVcywD0bj4Fgvs954QMAdw8g1OfCMM5i6b6Oi3lX6L2RwSjDkjz2SpNh8CMGZLl
         wpDR1EDdA2QysdU+gQI+nBrgDcDMaqExE1aYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYh9GDDso6xdaM96rzYq8m0zOUEfU+iT8h6UTGVAEZ0=;
        b=MLm0/eyJt3lwNa8CasFkM6Fk0qlT/BU3kAqqMSZ8AmhLmMDMpqd1twNZHOacKTLvS5
         GuvaOOyGbYXBGBZ6DBB72X+WE4O4XL6MMvmFFvKHbt6THLB6PqnWvu4BPhTwxMwNfKud
         Ajy51rWuHmyQLzTQsC5NgkaaA1eKbi6gl866WbiwY1PsDS9yunzedsRwVF++/g5g+xrT
         BOi896b4J9GhkjxRxSPrbZtRS2dACUbmveKmnl1RI+OfUW3ECM5pN/Z8uA5YMR2go1YY
         KjPe0t8bpXpn2ZKm+5H/IgG29XE7wBQXWzazQy9ylHiMFR6W9rJrJrL7l4SNs4eXrWY8
         a2FQ==
X-Gm-Message-State: AOUpUlGtmKUNZiu63QKVpZZTyB3DyM5+EJzUjF+eNR/HzLQiwGuO/OFi
        7qF4IEJLplCuj0ug/uYhOfHFJ5N+LrgnUUiLVrE=
X-Google-Smtp-Source: AA+uWPzsN0qnWh8ehAnwSn+vKRBVdFxEgChhPQGGdOm2SB7GMh0nwYXg+co6eSuHFKsc6m0DBmjNNnQ266xGtUkce78=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr18800922itb.16.1534362158467;
 Wed, 15 Aug 2018 12:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180814171520.883143803@linuxfoundation.org> <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de> <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
 <20180815185553.GA18219@roeck-us.net> <69700876-f31a-ea0a-bdea-2e82b7a5d308@dd-wrt.com>
 <20180815192630.GA20575@roeck-us.net>
In-Reply-To: <20180815192630.GA20575@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 12:42:27 -0700
Message-ID: <CA+55aFzHYYai0ZR3eapEqQzt9KVcg8+bGDSmTmc6CzhpmFVfdw@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     s.gottschall@dd-wrt.com, Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Also seen in mainline. Meaning my non-SMP test builds are broken. Hmm.

Grr. I think it's due mainly due to commit 447ae3166702 ("x86: Don't
include linux/irq.h from asm/hardirq.h"), which exposes a number of
files that had some dodgy include file dependenencies, and just
randomly happened to get it right because of that odd include that
caused problems.

That commit itself is definitely the right thing to do, but yes, we
clearly had a lot of cases of things getting core header files
included purely by luck.

And because this was all done under embargo, we didn't get the kind of
test robot coverage we usually get.

Part of it can also be due to subtle merge issues - even if the
original branch got good coverage, later changes sometimes ended up
adding things like that.

For example, my merge of the L1TF code found that in the meantime,
arch/x86/kernel/kvmclock.c had added a call to kzalloc(), which used
to work just fine, but with the header cleanup it turned out that
kvmclock.c had never included <linux/slab.h>, so now it didn't build
right.

And that was just the one I noticed because of my limited build tests.

And yes, every single developer has CONFIG_SMP in their config, but
perhaps equally importantly, I suspect CONFIG_SMP ends up getting more
header files included almost by mistake, so it can _continue_ to hide
these kinds of incomplete header file includes that just happen to
work.

> Anyway, care to send a proper patch ? I am sure Linus will be more
> than happy to apply it.

I think "happy" is too strong a word for my state of mind with all
this, but yes, I'll apply it, and you'll get the glory of fixing some
configuration that clearly didn't get properly tested.

In the meantime, maybe I should just do a "make allmodconfig" and then
disable SMP and see if that shows anything for me.

              Linus
