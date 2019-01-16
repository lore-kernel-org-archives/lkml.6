Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00255C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC872082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FQaEcRba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392726AbfAPM2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:28:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37622 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390089AbfAPM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:28:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so6721550wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 04:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4NfPscd33YfCts+OAvk6v5W92clce1d3rs145yFmNw=;
        b=FQaEcRbahfG+TnXDcCkYUtCScD9QwtNF9xwSw1P8coMNwd6FH+PuCXhCcIc0aXJx24
         uTjtFuv9FqG4HgeoFuz2xOvcuJTxQL3UdHM2iMQIXLk9wbV9EY6TBwSqhUvlbkjXFFrv
         D3UsdVP3AnAsYgggt9xVS9k5ZJgqayR9gFsuewkg3DTfsdmzhzdi9GYrxjZeb5+SiN6B
         khC2FHjYiqpwJJWf7BYXtBLF/gYYFnHpXKK69hfqBXPusU6+4NWeyH59PT2hdfpActnA
         iMb0caql2wyoCb+MwNLAV9JJ0nOuj+U/RLxCVwppeMDKT4XvHUwk6A48gQT0hyjARZug
         wNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4NfPscd33YfCts+OAvk6v5W92clce1d3rs145yFmNw=;
        b=uDeM1JFpKzZ7MwZnAXkKf8DpRREYUBEaDYlu8ihOC1DHot0uR4CgrIO527KDa2BKhx
         dCpLU9Xm91yiwvhJvrp7uqpG1xLbL6KbEEhjly1sEQk/OBz8nB1apuWYW7mP0/VYAWvC
         TQLP0qYBwwEyth24yJlNnHUYND0FLaO5l0S8lsJjHHTm6zmul3OP5IgKhELwZ3NR/pFs
         IgHEL7E/kX80/5JOIYZaQG44LqagQ0QF+F+f99X4F+7TuCMVIPMiY6eYnkBLQm0XGoGf
         wDZFtL8iowXO+0Tf9DtPB1JV00Z0XW2WAnXhj1BuJByJOizr4k1FCxzXErwHDVtvI4Xp
         7rYA==
X-Gm-Message-State: AJcUukevWDLAdDLS5rJeDzBqywuQZdwesLHCtMR1A73ofFRdnjFSyuth
        KgWHioSCqDURQBwopQWo6Ghox5M59ZpoqxugkfkeGg==
X-Google-Smtp-Source: ALg8bN55aGnn/rCggprsVOZmW4BpW+w4PPoodQ3bjNNI9imPwrCf+gPaTwU3JYDgBw7x0VRpLcXriGgPneKFN65/qwE=
X-Received: by 2002:adf:a58a:: with SMTP id g10mr7297402wrc.3.1547641678842;
 Wed, 16 Jan 2019 04:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20190107095307.15233-1-mjourdan@baylibre.com> <20190107095307.15233-2-mjourdan@baylibre.com>
 <20190111222509.GA14462@bogus>
In-Reply-To: <20190111222509.GA14462@bogus>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Wed, 16 Jan 2019 13:27:48 +0100
Message-ID: <CAMO6nazpZmr7sNNc4HL_f7Sovv3xAfDmOAc=_NTyFFH7F2y__Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: meson: add specific simplefb bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:25 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 07, 2019 at 10:53:06AM +0100, Maxime Jourdan wrote:
> > Similar to simple-framebuffer-sunxi, we support different display pipelines
> > that the firmware is free to choose from.
> >
> > This documents the "amlogic,simple-framebuffer" compatible and the
> > "amlogic,pipeline" extension.
> >
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > ---
> >  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
>
> Use the compatible string for the file name:
> amlogic,simple-framebuffer.txt
>
> With that,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review, will send a v3.
