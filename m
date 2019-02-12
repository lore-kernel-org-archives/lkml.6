Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C0FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405A8222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A7Xk7Leu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfBLRjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:39:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33181 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfBLRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:39:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id q12so2697233lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLbEticvpK9sychpH1QhyvE3cQSBg4Qz+YdNCSyvNFk=;
        b=A7Xk7LeuL/kAOhgXEKpPNya6utUWVjueg0sv91+ilpFsO4DtYZzud9UWQbaIUpdmx8
         l6PdGe7iA12KY4a3P5BIR9ToamzEw7m++srE2ntsQyuL6OktTQxJHhK1nZzhZ2c2K0fS
         SPFu2U8vFDqnoBVQLyNwj+AW3mFXMGSokFeqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLbEticvpK9sychpH1QhyvE3cQSBg4Qz+YdNCSyvNFk=;
        b=KPnooXb6f9TSyUY7Fwh448xVVXWVCms3vLlTrYLvNODVi9NHB/qPy0G7XnaBHKkx0S
         YmPLE5fO1NgcanNNjwBuyzNS5HcOBDRsug1SxvOBQqFLQ7rvtXDllhmzg8J+Q3w9Lr9F
         0tzm0yhuSaZFgQFIJjYbBD+6V+VogSL2gu3oBp/K87btY10infmBf7cgnOlCSW/heQFC
         iYoo+hPfKlO6SejAILgNCF15wVFma5WBV6EQoE5/2077anaGLaaU3tNB4bntfqoTzGDu
         MG7YvKdrg9262+uZT792UMfwqE3uYnCbVOM37EhfOrgcjYYcT9n7AXnoZ7qjqEhPpgPo
         M52Q==
X-Gm-Message-State: AHQUAuZUr2HL+mAxUxGn61ncQ1PINitM8jNmoAtrRZ9F/hEWe2ZCVhr9
        bV2OFn4qSrHhoKUZqkBhmao8t2E0Vmk=
X-Google-Smtp-Source: AHgI3IZQfkTgmC6SwPRWTG6ImvF4Iw/T8N7Ci/ZzttlREBE+t/oUY0/ogwpThFPlOqdUJaaMB9brcg==
X-Received: by 2002:a19:f517:: with SMTP id j23mr2272809lfb.118.1549993140363;
        Tue, 12 Feb 2019 09:39:00 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f140sm1995311lff.41.2019.02.12.09.38.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:38:59 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id u21so2685822lfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:38:58 -0800 (PST)
X-Received: by 2002:a19:7613:: with SMTP id c19mr1648722lff.103.1549993138511;
 Tue, 12 Feb 2019 09:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20190212171423.8308-1-frederic@kernel.org> <20190212171423.8308-3-frederic@kernel.org>
In-Reply-To: <20190212171423.8308-3-frederic@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Feb 2019 09:38:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=witwrbw0mExDpGzxYic87FpGhe1gCB+nqm1woUvwPY9GA@mail.gmail.com>
Message-ID: <CAHk-=witwrbw0mExDpGzxYic87FpGhe1gCB+nqm1woUvwPY9GA@mail.gmail.com>
Subject: Re: [PATCH 02/32] locking/lockdep: Introduce struct lock_usage
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
> +static u64 lock_usage_mask(struct lock_usage *usage)
> +{
> +       return BIT(usage->bit);
> +}

More insane "u64" - and it's *incorrect* too.

    #define BIT(nr)                    (1UL << (nr))

fundamentally means that "BIT()" can only work on up to "unsigned long".

So this odd use of u64 seems to be a disease. It only uses more memory
(and more CPU) for no obvious reason.

u64 is not some "default type". It's expensive and shouldn't be used
unless you have a *reason* for it.

              Linus
