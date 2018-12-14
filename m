Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D425C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8B120643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZobD+rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbeLNNe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:34:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41466 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:34:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so4260897lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r61N4PE69wRKahV5/6F2/1K+6Lo+o/EPZs1j9+mQGs8=;
        b=MZobD+rYDRGuLK5pH+NclyApdW5SC9HzyqJGaE8liMZoZgtY0A4FSWgDap9E6u5EmF
         W8eYLd5siKIyAZKHU1vqHpad7sr2T4GClqF3aNR+8cMrbZ6Q+kQA/6U1bqd95KNm0zLk
         ILRwftGGnqgdZe6QzZz/nRwtnFMespfcs95mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r61N4PE69wRKahV5/6F2/1K+6Lo+o/EPZs1j9+mQGs8=;
        b=LEc/qn8Ah/97W24RrSwasIgc2B5OhlL+YpFlW7/yOgQlvJp5/HKGRDvIQKZQLGM3/N
         GZs23Tt/pubpm6Ws1Oj9UhX6O8UPlTbVfqT/ZHz2EOZ6RYchQ/OBpewfGyAhkJBeP0Hz
         nHVtKNk4IgttQ7snbh9d3cwLYbEn116nPhY5FZlmUVcdiPdqWU1jEIFP85rAAIWXcrdC
         wjtFJpkcqsN9PYzDHAJCotzJ+J1flqa/IoorBnTQeE2rDV6kc3uPMG14OP6kSsJvmTB8
         AOvzrIzLKODOV9QSAm60mInJscAHm+EYSbmi1gecC35OcwV0T1lLn9L1VpG10WtryF8J
         Bktw==
X-Gm-Message-State: AA+aEWajbveZR5cKAgaUpQ/uU1B+2nKyAmg2XKrXaMVFzSTCNNWT0ol9
        rrndiCNQQSJE2o+pfO5DPWTghoEBQV6u6+r+qJRlrw==
X-Google-Smtp-Source: AFSGD/W8LiLzZxnviYjj3LSdljy0KMxxnsM95gN+ZSIoSTP4KhuCMi5LTaCjOYXPxZbgyz/b6tIyrtgEliuUspaLL1I=
X-Received: by 2002:a19:4849:: with SMTP id v70mr1816392lfa.62.1544794494911;
 Fri, 14 Dec 2018 05:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20181129170312.23625-1-thierry.reding@gmail.com> <20181129170312.23625-4-thierry.reding@gmail.com>
In-Reply-To: <20181129170312.23625-4-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 14:34:43 +0100
Message-ID: <CACRpkdbuRJ+UAoZkZNtWNzrF2+_0h-ibkTaDXWcPe70yJCx+5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gpio: tegra186: Rename flow variable to type
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 6:03 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> The IRQ core code refers to the interrupt type by that name, whereas the
> term flow is almost never used. Some GPIO controllers use the term
> flow_type, but it is most consistent to just go with the IRQ core
> terminology.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied.

No need to wait for genirq or other changes to apply this.

Yours,
Linus Walleij
