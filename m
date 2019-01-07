Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59533C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212472147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/4i/VYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfAGKra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:47:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34938 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:47:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so37684269ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7D5soVore4iK1huJI19KJjAvfCZZVvTmQB1fxdd23EQ=;
        b=Z/4i/VYitGMrqZGwF3FyPT0rHu0SS1DB4gWbeF1VpGIljespK+y5uKhDg9i9ZVQ1qq
         fn7N9wj5s8+eZhVwzm4uF6wtiVg9YMIqL9UO1D0m3vWpf6VayQg/JpDmWrgrB/y+HoOY
         LK00BT9CM+nJlWkW+8KtCwlM83TH2ObpAS0Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7D5soVore4iK1huJI19KJjAvfCZZVvTmQB1fxdd23EQ=;
        b=ki4BYEMBYv95/Uh7WaYezleRRgETqbIfACbBN6vQJI1LzvhR9ihRub2AWtbEj1h1Wf
         xmBlA0cphtAXH6RvNpdJMwzGHbPYae5lBxXDwHqqeJ+4UMNUEpg1qALI+BlCDAaT9UOD
         xCul0aEzo+xOWXKLnCcjZUSFY6Qr6rMxINhcVrTlxcy3jpaDNehyhSPmZ0YHkAaDcI0M
         0mNG2yKnjNzi6BMgV43g6f3SACFR129cpuzuFdi5Z0jvHZJ15XrvwV2ao51mffwwEIAa
         umxER/prr+XWSraMqiOW4CwYKqlIZjOen7xIuBcB3FR8LjGdQg0+R3IaqnkBpEBmT7+c
         4eEA==
X-Gm-Message-State: AJcUukc4++pWNQ8OSDX8SAE7Q0NcAX0QPdsXlpsNFkUmbrxsIakP6zD6
        cFPV4aD3aijK8Ln/RW/aOFFgZabzMMJNKKqeYT2Q3w==
X-Google-Smtp-Source: ALg8bN6BnTgZYkXUJgebagLeAZ5yOIyeaQZcRAI2hUU4BD//dbokLCrO+qy1pPuKmypNKEII+YVbTbI0ADH0qISWsJ8=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr26158435ljj.120.1546858048024;
 Mon, 07 Jan 2019 02:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20190107021145.6370-1-masneyb@onstation.org> <20190107021145.6370-2-masneyb@onstation.org>
In-Reply-To: <20190107021145.6370-2-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Jan 2019 11:47:16 +0100
Message-ID: <CACRpkdas_OLjbAAX=chzwwoVjW35L3iS=BhpNXS9QC6ccFMtsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] spmi: pmic-arb: hardcode IRQ counts
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 3:11 AM Brian Masney <masneyb@onstation.org> wrote:

> Note: The qcom,pms405-gpio looks suspicious to me. The existing code
> will start at gpio1, which is supposed to be a hole according to the
> comment. I can fix this in a later patch if there is a desire. I didn't
> do it now to try to keep this series as small as possible. Its no
> worse than what was there before.

If the range has holes the valid_mask should be set up to mask
them off for this variant.

That would be a separate patch though and hardly your problem
as you say.

Yours,
Linus Walleij
