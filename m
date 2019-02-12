Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5972FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC49222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XQA659dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfBLRqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:46:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33793 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbfBLRqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:46:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id v14-v6so3024909ljv.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TPAfWelPCvV4Dy+iauCizZilE4PXUD+0SrDLJh8oMc=;
        b=XQA659dLudu/jXbkmJNoyHlATFdsZOtXkxitRUH1ejUKg0A0Stm8tjQNdhQ299o/q2
         rn8MEgkcfpxfRJq7aqdCMq7E4yUtnTvCJ5afIDS9DIHgSSJhOMMusQcLJXds9Lm4e1g3
         xx+0J0BjUYadIiF6asbiopCNrKP8iJIw0K32c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TPAfWelPCvV4Dy+iauCizZilE4PXUD+0SrDLJh8oMc=;
        b=XLkpmqGuIZVI/OaolGwUNqDl4wbL8lSjdBsG3MTuaVQ7WGIR95M1EYgXa3UXJBqinn
         fPbiKTUugg8q5jfxPRp/GGY6o1bweuJp7PVmmv/tYbQB9JC/8Q0j81m/MtkUFBbSzELI
         wEQ4hVxjB9abD2ibxpTeeZpufhTe9lbbXT26x6lSSFl8kK8NGEJ4OEBP+pcE3aOtxjQT
         xcwg5VIRg43MF/Jo+3k+kSZtIMz0H4kxdKX59GRmb3rg3zfluIWMWQewb0/wJuO0bpV+
         JUwhAoE/3Cd259GCYE8EJVKc+ec8ECWz84IE9VRHVyP2dIRBoxpL5swQGcoPxYWcaolt
         InBw==
X-Gm-Message-State: AHQUAuZNvHhxDgU2WH+DnQAyg7KrKJuD9/22JIOrJ+dM5WHpaKD9Q7O8
        Lx7utjMwOxCKU51kTrWL4BzHOtmlbgc=
X-Google-Smtp-Source: AHgI3IbAMpSHUUe7+CRjgg521HGaTJyGvK/pfo9KDPjWJa7nWGf3RgvZmaAFEUZX7Z0wzdqZ6JYtMw==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr3053857ljj.95.1549993570617;
        Tue, 12 Feb 2019 09:46:10 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h129sm501059lfg.78.2019.02.12.09.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:46:09 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id t14so2681085lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:46:09 -0800 (PST)
X-Received: by 2002:a19:2794:: with SMTP id n142mr3120798lfn.77.1549993568938;
 Tue, 12 Feb 2019 09:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20190212171423.8308-1-frederic@kernel.org> <20190212171423.8308-6-frederic@kernel.org>
In-Reply-To: <20190212171423.8308-6-frederic@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Feb 2019 09:45:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhGQuMuuBkLBKGL3kM+8j3+TC_xt+QKFCs1qNySBv3-A@mail.gmail.com>
Message-ID: <CAHk-=whhGQuMuuBkLBKGL3kM+8j3+TC_xt+QKFCs1qNySBv3-A@mail.gmail.com>
Subject: Re: [PATCH 05/32] locking/lockdep: Prepare valid_state() to handle
 plain masks
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 9:14 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> +
> +       while (vectors) {
> +               long fs = __ffs64(vectors) + 1;
> +
> +               vectors >>= fs;

This is wrong.

If "vectors" only has the high hit set, you end up with "fs" having
the value "64".

And then "vectors >>= fs" is undefined and won't actually do anything
at all on x86.

In general, avoid "ffs()", and the stupid pattern of "__ffs(x)+1".

Bit numbering starts at 0. "ffs()" is wrong. And you never *ever* just
add one to a bit number in order to shift by one more bit, exactly
because of overflow issues.

So it may look inefficient, but the correct thing to do is

    long bit = __ffs64(vectors);
    vectors >>= fs;
    vectors >>= 1;

because that actually works.

                     Linus
