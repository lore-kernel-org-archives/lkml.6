Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF1FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871DE2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFsBl/Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871DE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeGIWqY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:46:24 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:52097 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGIWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:46:23 -0400
Received: by mail-it0-f46.google.com with SMTP id g4-v6so11719689iti.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDgeUh3UqcV4h57CQM7Lv5Tmd43+UVu2024ZByUVSBg=;
        b=ZFsBl/XqznR6sVSe107UEO5q8sMxnT7TNGc8R7fcgdgQPFI+hvfy6yRgCMl/u7Snhh
         PGVdp4gHrcBYLuDrSLNNnFA8y0i93sLt7kaZqY+AfvREZ+c1HGIeCOpp4ac1+oM3bHOb
         kSFuHEUW8hD8AYyegrc1BKSlnQ5tuMrNkuLlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDgeUh3UqcV4h57CQM7Lv5Tmd43+UVu2024ZByUVSBg=;
        b=GEOa48v2HhF84C+v9lZvlEwcbfgxs95pI9Etad/pj9f+exw+58R+YxPaB7Cqm/r6Fx
         +EgR4h9oZnUkEoy37V/DGmdGq5tqNEYK1eStT4i5ek4yAwRJE+0vgL4SMH0xbMV+iOMU
         retfD8MtkyfglKja14VkPaR8JgWPWG3jf2vVK57nLCQ5QqPXpKsmuHxiaqsPSOoB2gjG
         9VOC7Ky8nyME7GETmcPgIB2aIwKxAYcM7gfVSl8q9tloI8Z7O3IOjer/9vbdvh5B8tCc
         6slZu0GirA11B+eicFeeipVsbv8Oj8Kv1WpLpI2SbUPjTE7zpQqmYwPR2rmxEY4h8QFL
         T5cA==
X-Gm-Message-State: APt69E16YahV/rApqy0A/WHOGRk5V5i3n0GKYLA8kFB6QrsYoO4DNhzo
        lPd9GkoHTO62yYwzPIk1Gs8CaFWsLQpQAh6HYUzjNQ==
X-Google-Smtp-Source: AAOMgpd/7uktYrZAGO2pshcvsgqzkNqO0a+8xymb4DCAROFolq1sDLJrm//s0+bO8woFaF10IHoL17+VSBuf09jrOk8=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr17350508itf.70.1531176382394;
 Mon, 09 Jul 2018 15:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180710075439.4a449b3d@canb.auug.org.au>
In-Reply-To: <20180710075439.4a449b3d@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Jul 2018 00:46:09 +0200
Message-ID: <CACRpkdZrsGzULrNaoaX6bSy6z6o-gshQXrRhzUk=tuFF86shDw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hm must have come from Geert's pull request?

(I'm regularly wrong about this so not so certain...)

Geert can I fix it the usual way by simply rebasing and
adding the right SoB?

Yours,
Linus Walleij

On Mon, Jul 9, 2018 at 11:54 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Linus,
>
> Commit
>
>   a742fcf72902 ("pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and functions")
>
> is missing a Signed-off-by from its author.
>
> --
> Cheers,
> Stephen Rothwell
