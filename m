Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59D4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72E22150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72E22150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJQXNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:13:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33252 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeJQXNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:13:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so30468548qte.0;
        Wed, 17 Oct 2018 08:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJhucte1JFR8QoTgASjpGTR2zSKbY51DYcyxve2bl5o=;
        b=KxPB/LgoUiaq7E3iqqwudlEzMbVVpBCi4vS9KXZ+zNbdjtbf0D+T+uH1MAefzFC/8m
         9OmNzhGwhvdNFGe8kmPM42I1dRL9LqXSv5RtznKVxYmLecl/5xIwBh6rWIE02T0yUHZp
         +DwhmM7riN3xCPn9VO+AhmB+w2B1aBkvDHQMLPdXAy5vIvdVGUfcF97/YhMK0TE5vCGF
         C+Q90dGaCTHEitQ24/NEatgJQgTlMR0KUAoqsqyBk5mvlFtAk7QOawPda1It4HMo34BQ
         JrYUdMn3yDVYK+WI7H2N+2asWyaX66EBCUEFB5c4RYoeg0/SIFrlOum9GL3myBtmlEKD
         WCIA==
X-Gm-Message-State: ABuFfogOzAWNbtzBaUDNiQDQP0Dug/XBlll2LClyTATRjgPw3f4YNNJp
        DUzXdReVT9xAFt3ApL7cb/odypNHrtO1wq4x7FY=
X-Google-Smtp-Source: ACcGV60ZHQ3RBQCC/HvlNpvDDjaHR/0qjq4xyYeu/zbU71xt1ID42y91ZXPaUvXiQLPEVehHVIZaxRXqivVuR2+dlHo=
X-Received: by 2002:ac8:2bf0:: with SMTP id n45-v6mr25707902qtn.152.1539789441913;
 Wed, 17 Oct 2018 08:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:17:05 +0200
Message-ID: <CAK8P3a2x_ECC0bjYGUHm5mO9KrWviyWg8xVWNqXkSeNmpjdDxA@mail.gmail.com>
Subject: Re: [PATCH V9 11/21] csky: Atomic operations
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com,
        andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds atomic, cmpxchg, spinlock files.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

I'd wait for Peter to give his final Ack here.

     Arnd
