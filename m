Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662BAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A16222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GTPd4wvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfBLRgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:36:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40986 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBLRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:36:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id e17-v6so2949989lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+QIZF9FOG1VcPHBdRW3/tr1YRg1wROFCnZ03UR6bTM=;
        b=GTPd4wvGO2o4MWK6loEn14sve/5dSNUdKJgnZ3SR9t5IwSPNxNu1ZO/zGb2hmPWI3z
         wncIzrbdQMrTSfZQvpMDx6Gsis/CfrJGwA4vGUMUpAm+wqLtMFgndhpExEwHbXNt+7Gw
         2CAH7HaIPLAK/b4g8O/WHpB9ttpUrRL0VO8zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+QIZF9FOG1VcPHBdRW3/tr1YRg1wROFCnZ03UR6bTM=;
        b=NMC2vtx85fOINmylHWg5+4JavM5itfMwwxRlsxHIb2q3CQL0ipN6ctzEb3Y/VBt9EW
         s4LzhuDjtdAFFJLTiqofM2ipgQz1lT+Ux4o4Uy5Yc3aW7F1LJtsKEA4S0d0KZvjr3Yfs
         cvudq8O06yH7axR7ghMiQNGk8+EQNXdoPRSceKs9t9WYMX38q9RbPyZv+a9yyUEcA2HJ
         tg6FYFA4NENquOIH/NTUNArP36N93bYEviU79snNJ1CfYX/e7jBFncOJyR01AOwc8wjV
         yv1frCCOarQiQBV9RSRlaQD6lWxYgNSSKFd6AGp0LZvOQSV4/lLT3MI60WijRi2qckxR
         /DKA==
X-Gm-Message-State: AHQUAuawtWw1DNj8BxZMvE1k9V0xxbARyW0m3lSl9myWKlPZQhNP4eSk
        qlftczzP9YSjxN3DEiWpM83zM9uv01o=
X-Google-Smtp-Source: AHgI3IY4wq48SqknLcagSBMoExLPiKFbwA5GhN7GBv7sSVpNwHEfu7zDqQyTBvSFHUEvtw2ROxzxrg==
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr3209173lja.81.1549992964888;
        Tue, 12 Feb 2019 09:36:04 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v24-v6sm2662885ljj.65.2019.02.12.09.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:36:03 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id c19-v6so2963507lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:36:02 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr3236077ljh.174.1549992962292;
 Tue, 12 Feb 2019 09:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20190212171423.8308-1-frederic@kernel.org> <20190212171423.8308-2-frederic@kernel.org>
In-Reply-To: <20190212171423.8308-2-frederic@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Feb 2019 09:35:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjYBy=TBCLwoh4v_7nf4kqLrt1h6D4CsVM7Ws2e06Efcg@mail.gmail.com>
Message-ID: <CAHk-=wjYBy=TBCLwoh4v_7nf4kqLrt1h6D4CsVM7Ws2e06Efcg@mail.gmail.com>
Subject: Re: [PATCH 01/32] locking/lockdep: Use expanded masks on
 find_usage_*() functions
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
> In order to perform softirq vector-finegrained locking validation we'll
> need to be able to check multiple vector usages at once. Prepare the low
> level usage mask check functions for that purpose.

Why is this using "u64 mask"?

That's not only fairly expensive on 32-bit targets, it wasn't what the
code did before:

> -static inline int usage_match(struct lock_list *entry, void *bit)
> +static inline int usage_match(struct lock_list *entry, void *mask)
>  {
> -       return entry->class->usage_mask & (1 << (enum lock_usage_bit)bit);
> +       return entry->class->usage_mask & *(u64 *)mask;

Note how that was an "int" mask value before, and "usage_mask" itself
is just "unsigned long".

So where does that "u64" come from?

If there is some reason you really want to use a 64-bit value (some
future change?), it should be documented.

                Linus
