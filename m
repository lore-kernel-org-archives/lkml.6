Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2386C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6804D20657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVoZdb//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6804D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeI2CpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:45:09 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34418 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeI2CpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:45:09 -0400
Received: by mail-yb1-f196.google.com with SMTP id 184-v6so3212620ybg.1;
        Fri, 28 Sep 2018 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HI4q73IG+mRuqdKI+/sZeNi41z3wIZxcUf28STytLfU=;
        b=ZVoZdb//8DGs7JIf7ZrA/XyuVRVrAj0d9zZU5FWy1g8EVdTyE6LpWXYxYW8GzQKdVf
         bgwV5gXKkySqW4G3BL5xYtUoWa0QU1o7BLaZ9kIGfy+AcUyiIWMLIhPLaZC+6imwU990
         dyiIUyRKfTGdA6Dx24socgQhK4eH3uryl+wW3nilowBnpB+8A5k6IymH7BASqBEEMTSN
         bAj//Q8syoThFdqAsHFzDmMwpgl77bZ8Hwim+RcFs4XUirXZ2rGUnd5pq+0JKUQxUNzd
         dswBWbPEKEUInzCYkSRKFMn7Zz3v3AqzSHET6uiGPFx7t/HsZaIq1Mo0hcFSTc7NrYYy
         u0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HI4q73IG+mRuqdKI+/sZeNi41z3wIZxcUf28STytLfU=;
        b=XupvAWB1lm1G490OAXhLxCY3UGhC70TuziJy725u/KQFxUO3o0Agp707bZGj4i+cEI
         QeYLnwhAkRfWhqFwtUDeZD14B86mFZgq1NUc6S/inz751uQdXLoami7kTCzKHfBCO+Bf
         PrgoXCfzv3GU/w1s40N7BEcHyXC5K/nok5WfoDW5y7cG5C9NmZ1MYd5vGaBzv6pLHGzF
         5Ny4VtBdRftKcnOf5WXaTaG3qJ+gv67AvoQEi4dYdE/8wAf66KVadmp+rWGx6bQNlVXn
         L3YaFE6zZO88vseKCpg5BZXpmvWCYUV9vzp1jMfNSDsJAgLk9SnH9UCvo+CTOsqU/7ZM
         xizA==
X-Gm-Message-State: ABuFfogiwB8q4BVli0o/Ws1WXl6rwTKskZCPFD61Kg1A6VYRj7K5j7Tj
        2O97zsDiRTEg5R7VWh08JjLPJIeeaP/yIx1c6RQ=
X-Google-Smtp-Source: ACcGV62F04t0fv5suQ4l+BnSzCg+o3RNbH6/BSu7w7upMeqH2zmbXE8eWMc1qZZ/8Nj5wEynWePr8aQFy57XuZ4IA50=
X-Received: by 2002:a25:6788:: with SMTP id b130-v6mr182661ybc.84.1538165987277;
 Fri, 28 Sep 2018 13:19:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:505:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 13:19:46 -0700 (PDT)
In-Reply-To: <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
 <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
 <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
 <20180928103726.07761672@mschwideX1> <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de>
 <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1>
 <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 28 Sep 2018 13:19:46 -0700
Message-ID: <CAMo8BfJ7t-qPWzGPb6JzqEhPm9JBzvAX0a2paBXeQt-RCeHe_w@mail.gmail.com>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        fthain@telegraphics.com.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:02 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> There may be a much nicer solution.  Unless I missed something, only
> mips and xtensa even have the possibility of cmpxchg being missing.
> We could just make those arches supply a futex-detecting helper.

In case of xtensa availability of cmpxchg is known at build time.

-- 
Thanks.
-- Max
