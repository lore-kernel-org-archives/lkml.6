Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB70C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663A220881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqCnViqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663A220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeGIODO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:03:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52564 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754514AbeGIODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:03:11 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so25524129itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCNyJQNzwJvW5xzxxVLSM1SuaCbLMgBwEQ3oj0Ol94U=;
        b=QqCnViqH1dH2qY0feFXY7mg0rLBgL6bJH/8DjJkzhYS1167N2A25pO1HtolqUj6OaE
         KI/hPJ+qb+lq+tAMWaMjGy8awS0wpKQ2gZJUOBKJb2VJcNT9C6aOPqQUkkrNUd8b1svq
         VgjzJiLolficPevYwl/F4YOW6HM3383TVeT/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCNyJQNzwJvW5xzxxVLSM1SuaCbLMgBwEQ3oj0Ol94U=;
        b=RJGtTeplxUGn8ILlQ/tnuQzpMzP8qHrFBSi5svQ0KUozqbG6HFgxoh8kVw4tMksZRK
         kdwjeeQqdnLDebfWz4YkxarxvEdO3Y3UCgWB58UnoaRJeYY+f8rdG6w0tePzBfZhCQpr
         6gKhmyVWW/jszRekLw58QVb+Q2ptKFhvWBOOEmNK372r30iz30vnDTrtmROAggJBSjBQ
         Y5qkU+/W4Y8aUc0izM6N7ULrUPDwn2mPkabYUnkhe6mffUooRyWYvhsWxcBNoiAzJP2I
         6Lnp8eUZvbat4tFAewHgHwBwQAMVAGIB/8TYIjzmk6J6l5Or70pNm4sP8wE2zRbSRVzW
         XNCQ==
X-Gm-Message-State: APt69E0mMfbwga6fgLsl3PoRLKKPP6g4DgA47ZsFs8YJj0/IDy3Y0CyQ
        14qi6XqoTiQWpO7cFElkZCvbWoOYP5dnXOzceJUhEQ==
X-Google-Smtp-Source: AAOMgpdERU3nKj4+MO8RGVvGocyZx4CRHjq1ipL4b6jK0+pimRSRj7IigN9klBDhc43vh1XqScMk3Izp9n9moDGNY5k=
X-Received: by 2002:a02:c007:: with SMTP id y7-v6mr17366078jai.87.1531144991359;
 Mon, 09 Jul 2018 07:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <1530532746-619-1-git-send-email-abel.vesa@nxp.com> <CACRpkdb=0uR4uYF_N8HcySJGPct6q5zT+fd6ZfnMqS4OCT_=GA@mail.gmail.com>
In-Reply-To: <CACRpkdb=0uR4uYF_N8HcySJGPct6q5zT+fd6ZfnMqS4OCT_=GA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 16:02:59 +0200
Message-ID: <CACRpkdYaw-KnidoQnY6LDNpwjS2Nibg-3k0jATQCM5mBAUr68Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] pinctrl: imx: Add driver for i.MX8MQ
To:     abel.vesa@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Stefan Agner <stefan@agner.ch>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        abelvesa@linux.com, Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:02 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 2, 2018 at 1:59 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> > This is the sixth version for the patch series sent by Lucas.
> >
> > https://www.spinics.net/lists/devicetree/msg212752.html
> >
> > Fifth version can be found here:
> >
> > https://lkml.org/lkml/2018/6/22/501
> >
> > Changes since v5:
> >  * implemented Rob's review comments related to bindings
>
> Can I get some review tag from one of the listed maintainers so
> we can proceed with Abel's patches? It all looks fine to me.

Ah we have Dong's ACK, sorry then I just apply the patches...
I'm so confused sometimes.

Yours,
Linus Walleij
