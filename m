Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37075222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fOZMuFbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfBLRsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:48:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46250 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfBLRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:48:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so2959630ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApO5PhJOy5F4U/cO8FGzo1vuRxGzslRJ42N0POxUQrM=;
        b=fOZMuFbjFzSycB5imPxK8v2PnsmqnAn6fr2DH+82CMe9Qam09z+uezFaXBS+WtXILO
         wgC8IB9FY2P/AqD/FBZSPL3wQ6f986xdiwKRLTl3+S1W1r1VIW2HQvhsHHhEW/CCOncV
         vAZ0p/HntPSMJK07PL+P2izfTwEo2yX2cqsmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApO5PhJOy5F4U/cO8FGzo1vuRxGzslRJ42N0POxUQrM=;
        b=bPuxRo2ISNxkB6p8/qa3r0Gtp3Hsz4u0z/xtC7QIgfqVZ4lUO00+QGjDWvZafvjNwg
         v5yn8yTujd1TSvXn71kr3vS9a8Kln+SSV4jUMRBQk9lAIY59Zkw80Kax+VmGthpzbmYI
         jq3IDwMR+eR/M+8KlEHK674JvJg7Uj+3uaWKhWdK5gRW/jIf0VkSeypkp+IyJ36e4DMD
         01vtINZEnwkM6UW/Fmr2LZ78nrtAQpKpWAPu1tNXe6Hj3QkuCvCRGprUFFO8Y1IRgG+O
         b9Ag7UXUWPFFVZun/uqWxB5sBFNV6710A7YlCrG8xV3seGTtd9uM8rck88OUPT6om1TB
         5Z1A==
X-Gm-Message-State: AHQUAuZVpXjCtjyGD/l07DGyhhpvZWuyWYJz2kdz7o8IdnQTcCd0VRK3
        cBk86dv0VJN3MNRjnd+5aN1y2LCSgus=
X-Google-Smtp-Source: AHgI3IYR8JT5OnSKRM0J4t5reaoPengoFUn6mS1aQCN062ntV1KWPoGN5MEPRtdiqK5WZuphr61iug==
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr2900560ljt.107.1549993677861;
        Tue, 12 Feb 2019 09:47:57 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3087643lje.18.2019.02.12.09.47.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:47:56 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id z25-v6so2984643ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:47:56 -0800 (PST)
X-Received: by 2002:a2e:9944:: with SMTP id r4-v6mr2977856ljj.185.1549993676154;
 Tue, 12 Feb 2019 09:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20190212171423.8308-1-frederic@kernel.org> <20190212171423.8308-10-frederic@kernel.org>
In-Reply-To: <20190212171423.8308-10-frederic@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Feb 2019 09:47:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPfzTR8my+Ktw93SC4YXO8pBc70gTEso06ei_K2jZqRQ@mail.gmail.com>
Message-ID: <CAHk-=whPfzTR8my+Ktw93SC4YXO8pBc70gTEso06ei_K2jZqRQ@mail.gmail.com>
Subject: Re: [PATCH 09/32] locking/lockdep: Save stack trace for each softirq
 vector involved
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

On Tue, Feb 12, 2019 at 9:15 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
>
> +static int save_trace_mask(struct lock_class *class, u64 mask)
> +{
> +       int bit = 0;
> +
> +       while (mask) {
> +               long fs = __ffs64(mask) + 1;
> +
> +               mask >>= fs;
> +               bit += fs;

Same buggy pattern of "ffs+1" and overflow of shift count.

                 Linus
