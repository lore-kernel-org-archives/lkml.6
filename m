Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA45C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5227F20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wg1e9/P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfAKMZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:25:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43276 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfAKMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:25:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so12750839lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdsESOGbRKiRNxdPcXpg9XNxPPBWWG5+p2LUtuOv3CA=;
        b=Wg1e9/P0IQ7GBlEPv+F3XAL0xi4w8pywuaBIJ1b1D3hIPe9SjjxboDBctrnx50LMK+
         wkOX6UOkWsYx2ZR7IsTdNFZDafkWpBvdSznJnTaw144pQizOAgFpsm1Bn0/b6ysyy5FT
         Ddzg6kMNdFNMTek3ZgH5+Is1Ybi4/FxttLWXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdsESOGbRKiRNxdPcXpg9XNxPPBWWG5+p2LUtuOv3CA=;
        b=jmirImLKUeT4ThC+ZhzpffKrRhBI5EhQy9GyN1WITlXDhvYE/1c7thHm8ke8V5NnTx
         zAag3yr01r0OeAjPGqBzynCaS0AM3CYpOqtftgpUQs+g/hjk81JmLiPUy6CKifPAw9PK
         4OE2JwbJUFR3xPZth/6ojLTccuihFD7wb3sNunhua5dRcghLKhJLMQR4HzSlaUXc3+WH
         NzMGyeR8l57JQ2GhHz+SJfh1Mrk1HD3dMvNv3PCfITakC09Jpqo/SnCjwJ48diPtTywG
         Dchrssj1nKqvj8wdIUxuqrnwup3h3DX6PW/zvZKacfEq+PJCXVPNc+srOAlTaAnJAOaM
         yViQ==
X-Gm-Message-State: AJcUukflwpuAdrWoqtt9J9J2L/Y1PIj8nSpeQft7XF0l1xGBfKTzj+35
        3xFKzM4huU5H6UMxaolbAJp4Vxp0ou5KPJyDPFiyNA==
X-Google-Smtp-Source: ALg8bN4E6VhqTcppuvh3BjDY7EX/U7s+63hNCiJmT9bByc9mNbf/yofgZnr+qfj5zQNrwgM9D36r+IIiMXw1J4Kbqcs=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr8469613ljc.97.1547209503753;
 Fri, 11 Jan 2019 04:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20190104213508.GA20333@embeddedor>
In-Reply-To: <20190104213508.GA20333@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 13:24:52 +0100
Message-ID: <CACRpkdYoVLARk8oxqFesKZ0FDyqCoaoxLdTXR=0TS5N_PQdyTw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sirf: atlas7: use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Barry Song <baohua@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 10:35 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied.

Yours,
Linus Walleij
