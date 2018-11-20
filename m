Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60960C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4868620851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajL3n7BS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4868620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeKTSnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:43:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46422 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeKTSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:43:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so818097ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMFDLP47LVR8jcbrIpBlq/7VZs4+TPJy4W+Qq+E/LBE=;
        b=ajL3n7BS+3i1kGrs3ZfvrFYv6CHRqASUI+kStaQ6D8UD/pew0UkpfPAShTb0rNkFPh
         VGkGDOxKbRRCaKeVtKnMoXMi3pfHWfq9eUfTeHlteTpITjEbh4Ye9d0cpDkXoCdgZQLN
         +N5vYvzQJ266Z1ln+KW/39ALLMYbIOil2YXUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMFDLP47LVR8jcbrIpBlq/7VZs4+TPJy4W+Qq+E/LBE=;
        b=GyHo2nfPiaDlJ6K8qdvA2NIE3r9rmPoIyDgX6hUsTWxKcGjNR21LNF6WC6CKWYxD7m
         0NEYpZIodnKclFegzOSEF+dJ3IvF4/Y1MMyy7XG9dBeH3xncfni4znQ6oEzvgauQ/CNi
         8nGF6zjwy6zpfMSK3QebNbMDkBrtzYpoaMn8RuEMg5q/vhquURTGYrZOhgBvvQmzja8+
         wWmdkU3j2e1TvPC+7ZXvJCeDXhVn4cjzGElCXqXR8bs3xUIwm/Mzd9MQNcbmqGgAtuDl
         Y+QvAO8/Pb2TuSSW8Ycu5pWOZ52RxpUTh3APU4oVlLjbDggSmNvXZFjJVqwNipzVPW/N
         wVCw==
X-Gm-Message-State: AA+aEWY7sflb0ob436PyULE2H3KmW7ug5E8jWiEzBafEpAdZdnAhTOmG
        +hAijFf+McKzgUGkNo8WOnRSgVNY2PxUzDslxliVlQ==
X-Google-Smtp-Source: AFSGD/UH38Tk1855Sbk2I52yy2/WMCVCLlSvAJql95updU9IoYmgYJA5qji5E14VXIDRTf/9Yhbg8wHPxbq1/irFkQM=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr602983ljj.9.1542701754441;
 Tue, 20 Nov 2018 00:15:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au> <c235d0b21a648d329668f1ab436161c09d96e875.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <c235d0b21a648d329668f1ab436161c09d96e875.1542589838.git.fthain@telegraphics.com.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 09:15:42 +0100
Message-ID: <CACRpkdZdJDYaOi1HeMiS2hkjOf0gjQphGXy-Ka+m=1LbDCXPfA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/14] m68k: mac: Convert to clocksource API
To:     fthain@telegraphics.com.au
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
        schwab@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        schivers@csc.com.au, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        schmitzmic@gmail.com, John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:22 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> Add a platform clocksource by adapting the existing arch_gettimeoffset
> implementation.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>

As noted for the Amiga CIA (which is pretty much a sibling to this
MOS 6522 VIA) this chip also has two counters and could use one
as clocksource and the other as clock event.

Again I bet this is just using one timer out of habit.

It will be an easy feat to make a clean clocksource+clock event
for this hardware as well once this refactoring is complete.

Yours,
Linus Walleij
