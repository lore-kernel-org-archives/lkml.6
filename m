Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69472ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395BF2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395BF2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJQWzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:55:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43735 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQWzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:55:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so30327143qtq.10;
        Wed, 17 Oct 2018 07:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mly7v/sbHoS6CiC5E7KOBdxuTUB1L2SbeOM1ziZBkgs=;
        b=bmcLyOUFiETMnuAv6x1PFAwoXPz9sVqzc5UskhWkdoaaoYS+UBuX03ewB/sVS6TR8q
         rmOYet+SDStX8rUyJRQKWdNyq7Uoo+LVQ7sotSDEp1Ah2I1yJNOFWfXWTutpZxNJzEPa
         Clv9/CjjlKrjGzXP+3Ea3kIWxy+YMkR87Mzjzt7oo9/sxTUUMQkcXV4cIAudeDu8IeDM
         el5BVP0ReIiV9XM87UQ+EBY5RDXYOVI720xJaIyfPDDsrvMzNNsetHgP49LTX4XQm7a5
         k+gAg16uFH0syYubSnB4fNae0pkWw41rP+FJZ62NHYz9DURSe//vFzP4NPAmJq6EYg0m
         Fpfg==
X-Gm-Message-State: ABuFfohwKus6obfTsIXWHd8mmrJA5eoIg3Pb+IjYjKv4fjVDz8K3mC0a
        dWSLbKsCjD/XY+1GlxXywaa0BfPqfC8FDU0D0AM=
X-Google-Smtp-Source: ACcGV61nLWJdW/TTFxXJhKyhzuMIG3ArA7hG8AVzBKC0pRhQinZy+tWwcF0wvAY+KwutOOxAKxuohFodsQ+X6JO/Gv0=
X-Received: by 2002:aed:35cd:: with SMTP id d13-v6mr24798638qte.212.1539788348276;
 Wed, 17 Oct 2018 07:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <4fc690db42b5b43edb15fd23517a6f3ba5b2c9ff.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <4fc690db42b5b43edb15fd23517a6f3ba5b2c9ff.1539655731.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 16:58:52 +0200
Message-ID: <CAK8P3a0PxhheSTuiMX76R3HZNvkJ9+qPM37AQPgmHgK2-TV1wQ@mail.gmail.com>
Subject: Re: [PATCH V9 03/21] csky: Kernel booting
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

On Tue, Oct 16, 2018 at 4:59 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch add boot code. Thx boot params is all in dtb and it's
> the only way to let kernel get bootloader param information.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> Changelog:
>  - Use built-in dtb when dtb param is NULL.
>  - Add dummy console for allmodconfig.
> ---

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
