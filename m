Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E8ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40A82150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40A82150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJQXrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:47:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32863 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:47:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id q40-v6so30613012qte.0;
        Wed, 17 Oct 2018 08:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbvyB4+oX2WtB7fD0QYYuZg1+JZn0MDHN5ykQ++2Og0=;
        b=FwfziEGRRNU6yHMoCULlw+skaFfjHfi0AxKWjMaF5dMgSUHOqrZm1+hYQlwe/SIYc1
         O89s1S9njFuI7k1njaS2nOUfN8CyDwM6twW6junx+4y2ZQtuQIzWwRvCzwXvREkcC8pZ
         /bP2EZeIvahBvulNj42ENQJT3YXudbsyvaMeQjAyJIgh+hH2huGVSJjbts+rMyRwilIU
         Cr7NfKGWFjk6Las/39+2c6be/6SgE+Sg4gSvgVr6C2C2Bic/JEq8sB0GbbrZ7oWyzaRz
         bSUvqxHV3tz75L7xNZhgUx0upEERvmVmJEgwDjEOwTvJamX57BRqoPtBb+LkxwDhczPx
         JH9Q==
X-Gm-Message-State: ABuFfoh+4gffqOo7O/1H15wDWwBjvGMc6QKW3kewxIhhDQ3zLNDTSH74
        eTsLqDCXo0BvbeeEekFtQ3rxv9DTFtkgkHE09oU=
X-Google-Smtp-Source: ACcGV60UUJnYlm1J5G3B7wdHSID4jc4oE/DR5Zt6T+zCmvHh4QcVeLRQJF3QBOPGcwNmMv6craY86vQfGjbvtoq9G+k=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr24853090qtd.319.1539791449597;
 Wed, 17 Oct 2018 08:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:50:33 +0200
Message-ID: <CAK8P3a1WM08tTDKH7E9hQP7GLUXmHndKCyEuaWrvTq5YKGR5+Q@mail.gmail.com>
Subject: Re: [PATCH V9 18/21] dt-bindings: csky CPU Bindings
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
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:30 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds the documentation to describe that how to add cpu nodes in
> dts for SMP.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Rob Herring <robh@kernel.org>

I don't see anything wrong, but I'll let Rob or some other DT maintainer
provide an Ack when they are happy.

      Arnd
