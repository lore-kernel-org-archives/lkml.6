Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57E7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9656E20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BmD+CKeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfBLRsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:48:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46837 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfBLRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:48:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so2656466lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7GJynW1//DZN8sWxuqUfb0Diu52R1DQ2mOVeMbIEdc=;
        b=BmD+CKeHsLfeIBYi26wxLm9HkIm4SyX/sZVeuVMACA33n0hK9nud1caFKel6/5jxR0
         Sm+EUzwIN7or+S3lB/RQ0k+zvGw+m0sgnmSzEuGMqzN7n8kwsQ5Q2UKhuS/ViGMJawhM
         XE3m2OpJlp7aNO7ANHNBx0u7PNE7sUVzgkEMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7GJynW1//DZN8sWxuqUfb0Diu52R1DQ2mOVeMbIEdc=;
        b=KZio61nSl9KTXTr5BEF6kioTxTg+t/v/6zKwTRICTRC44I3Jrpl+MJ6ciEozSkYKeg
         am9+M9wO5A9qFwYhlsMhFf+NqzdDjiEnDKFXM+B4Ai0alPHXBrrHXSZ5oiMn6wMOQItY
         cJ/cwx3JsVPB10U/DH4OXDK5QI3YZ6FKPB7DFHm6jX2axRU8F07cUgH5ufmdXTC8hCjm
         pv3w23tzf2XdSjzzg1fAwYVApUEPH0BSEZmek+OHmw1puIaLeNZd02DM1wHpO7Q5Na8R
         o1vP1fYNksjWxYCbFu22SY9XihJ+XLlZKDpA96DxbSocCKohXBNjLb6nLYyQdkDuf+eE
         aYpQ==
X-Gm-Message-State: AHQUAuY9A65EgeOSpP/qwueZpzW+KX2J4CpXwVNlKQhm7rqjTPZCtAds
        yP5zv3s3bThRI56xJbXPDVqX4zhv5Tw=
X-Google-Smtp-Source: AHgI3IbWUrrp74sdmNvQlzMtnZnPxHlvmBJ2YpMwvsPHuU0r5q7tCKNT/jAOsDNO1nWPW+xQp203cg==
X-Received: by 2002:a19:d250:: with SMTP id j77mr3120948lfg.21.1549993229158;
        Tue, 12 Feb 2019 09:40:29 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o6-v6sm2810703ljj.6.2019.02.12.09.40.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:40:28 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id n15so2677896lfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:40:28 -0800 (PST)
X-Received: by 2002:a19:7613:: with SMTP id c19mr1652550lff.103.1549993225718;
 Tue, 12 Feb 2019 09:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20190212171423.8308-1-frederic@kernel.org> <20190212171423.8308-4-frederic@kernel.org>
In-Reply-To: <20190212171423.8308-4-frederic@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Feb 2019 09:40:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKtW+=x5zVmsxBOUnjQYQKzkfYUhE5F=eY_R=opa-vNA@mail.gmail.com>
Message-ID: <CAHk-=wiKtW+=x5zVmsxBOUnjQYQKzkfYUhE5F=eY_R=opa-vNA@mail.gmail.com>
Subject: Re: [PATCH 03/32] locking/lockdep: Convert usage_mask to u64
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
> The usage mask is going to expand to validate softirq related usages in
> a per-vector finegrained way.

So here you start explaining why you wanted that u64. Much too late,
considering that you already changed to u64 earlier.

                 Linus
