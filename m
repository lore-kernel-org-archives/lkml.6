Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4EDC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE3E20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE3E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeG3JBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:01:01 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37340 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeG3JBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:01:01 -0400
Received: by mail-ua0-f194.google.com with SMTP id y10-v6so7174574uao.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 00:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIAMCZoY2w9neRdMF8IOu4iH3e1Hy5h+ZaRrwzExWDA=;
        b=KZBOYE8vO02t+w6BU638wey4U7IqgbcP7BbKLDSzI+ui1KTO8rKsTcRc0bTlbJxX1D
         PIkPi6DC+EYVcljBYOGACmbpM+L0w8Lz3KgHQuluR7qtjfNd0zWQDnBjN1I/WdLmdvE1
         fJWK2FvhZUaO/zEdwbLzHr8xLDEro7W8YCq/suQ1NrRhUm3/CuflWQcFyqM8eBZuj33T
         /+p3hXb9Dv4maxwbS7notjvt2v4aD5+wgZ1fgwxQc1cTGgHEokFXzGSc45PcGy9uy52Z
         DqmR1c/vVHvmZ/fphkS8by6sjap2AWj5wKI11C6tz172BBHlf2T9CW2RN3uRpWjqVW7R
         8PqQ==
X-Gm-Message-State: AOUpUlF5O1eC/UJzB7wgNilKQIdG0HYDWGh63+5DaCay1nqM/nmKjjbs
        Gq//Ft5PcBHbazqjcq3dSMeJApCo2pzkXbNmJEOjBazN
X-Google-Smtp-Source: AAOMgpdy+doIIjeJruRYcgxJhPRcNk86gXn29b0fzPJiJWFt7PZjmWtvUn4HJaaDJ0ur4obA2wGecHOwCjAnohG8hZ4=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr11345898uad.12.1532935643428;
 Mon, 30 Jul 2018 00:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
 <CAMuHMdU_7V0n6HCNR87pmxYSMJxC=WpbtChpdzT2DQi3VWBZ7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdU_7V0n6HCNR87pmxYSMJxC=WpbtChpdzT2DQi3VWBZ7Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jul 2018 09:27:11 +0200
Message-ID: <CAMuHMdXFo8RxfkHJ5z11kzj1Nn_1tZEgDjJb_kC4MSf5aE+27Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] macintosh/via-pmu: Replace via-pmu68k driver
 with via-pmu driver
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 9:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Jul 2, 2018 at 10:21 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> > switch over to that driver and remove the via-pmu68k driver.
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
