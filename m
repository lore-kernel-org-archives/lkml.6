Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D590CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A224420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551289108;
	bh=/d68kpx7Cl5MOGlMDt7Nkln3PcbVi83HyVZ1XgZxCT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mrfQYA0v24PAHxo/5tXKQzgF7qsj5tyNrifxJJF8JVyhSqPCijSE6r1Ud/pYDGkZZ
	 YFYtTeDuxAJ7sdJ3skeI3p9fBTraPEP3f1XXQnyDp10v+sZo5MbuGW+2VailGTEhN8
	 dfpnPT6nHBu+xSilGvUbRNKbzNkIRbPUYofZ+7FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfB0Ri1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:38:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38774 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0RiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:38:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id 131so3928452lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu8dC+K1nPEumCoGBpz+MX/BTjwspYh9KIbrtYVVhE8=;
        b=W/9k7ljmddZUUF6ETZ21WxATpKtzJp+kgo2AwDRW/+KvnEIDWlqEaYiXeSVbJTrCDJ
         5jrQGzK6686DpmeUZb7vcfgPKZHYzIEftOCDmhEU57taAWWvgCaAoZJCIC1jyygwswFg
         Oq1yf9CkoY3flBV7VywqOeE09Q0/6NCWDidZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu8dC+K1nPEumCoGBpz+MX/BTjwspYh9KIbrtYVVhE8=;
        b=hC6s3AN91UIB/vjBbhk3v18g+oqdFKO7d+x4Cq3hY+rOqjXZeEMv9lqvcYwIpH9+ss
         ubByDLr4Gr7s2opHcklmHxMq5P1y+TSmMzav8Ld/RTDmCRiwtubORaJcFf59PWJXhN5S
         lr8OjsKp6EyoHRg6gTcmZEgXWi8B848qSm+8AiDp34t6JFRA2Fr03EaYMxLrQdoLbYcR
         EjVrq9WOBH/JO6wGSzRaovHL8vCxVKqWW7eVHq8OZyKsFRS9d1G+TaiV+d8y/smhjP5S
         +amfVV47m28odKjeprgmNhQRM75AV0ONScyMFJIUd50Na7h11IoNdlGEyh60MJpA0afw
         8hWA==
X-Gm-Message-State: AHQUAub/o08EISP754Gh7LOnWKs4n7cyQNe78+pmjEuoe0PUDsVLKARm
        4QBTJbGng12WbJKJafK9/iCoWjShgSw=
X-Google-Smtp-Source: AHgI3IZHoNUFTOuIrugqpOoRudIdUlD9uRM0oH9dHtZ2rf0dBt8P0G5wC+dJ2SlQ4IH8frxml87XJA==
X-Received: by 2002:ac2:4191:: with SMTP id z17mr1643987lfh.78.1551289102534;
        Wed, 27 Feb 2019 09:38:22 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s63sm4180870lfe.23.2019.02.27.09.38.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 09:38:21 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id j19so14699458ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:38:21 -0800 (PST)
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr2196718ljc.22.1551289100697;
 Wed, 27 Feb 2019 09:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20190227101252.413192716@infradead.org> <20190227101544.210748832@infradead.org>
 <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
 <20190227164806.GS32494@hirez.programming.kicks-ass.net> <CAHk-=wi_0GUBgi3guWqUzT3gZOAC+iEyZcSLdw0=_9xWJEwHZg@mail.gmail.com>
 <20190227173422.GV32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190227173422.GV32494@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Feb 2019 09:38:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2DPz0GVP3zYU_4vrH8iH_AasH3xu4TfMgfh_3n71qVQ@mail.gmail.com>
Message-ID: <CAHk-=wj2DPz0GVP3zYU_4vrH8iH_AasH3xu4TfMgfh_3n71qVQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and __this_cpu_{}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 9:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> But the ONCE thing defeats CSE (on purpose!) so for code-gen that
> likes/wants that we then have to use the __this_cpu crud.

Right. But I do think that if you want CSE on a percpu access, you
might want to write it as such (ie load the value once and then re-use
the value).

But I'm not sure exactly which accesses Nadav noticed to be a problem,
so.. I guess I should just look at the other patches, but I found them
rather nasty and ad-hoc too so I just skimmed them with an "eww" ;)

                  Linus
