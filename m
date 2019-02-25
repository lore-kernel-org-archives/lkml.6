Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE73C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42521213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpQRfdvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBYMnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:43:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36721 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfBYMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:43:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so10233299qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 04:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVW7OFD5R6YBZ5gSu3no36vWuxWNNKm4zh4xPKQSso4=;
        b=gpQRfdvh0idkWzvi5S7qS7PiO1lYjDKnFyOBrKl2fslQcqxiTgwCURCqetwbGj9Sew
         SVE3sKlQkljGiPTYvXLL0vTp0AXo89KOz02pQfTtObLo7z1/1tMye+Gwjydejqw50vKY
         WHPpN21xy3z/9TJzFcdhg6dJLd1CsPSg8HSxqg4wTiCnBfVd0/I18L4rAj5VbgRQm5eJ
         aSVTHhX/nzdC17J9grKkm4Da741QQa+kdOSh7D1gKpP0piTp4hx0jKRYgQM1ktG/T/o2
         IW48uE6hCuVM9km6y+C0qFpUdl6YL/NggU4HcgedYipJJMf1jwK0Ol8+OkEJB2tcKekU
         4Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVW7OFD5R6YBZ5gSu3no36vWuxWNNKm4zh4xPKQSso4=;
        b=obdN5eQ8AoQd94LCYkzsvTEES/D6VRzHdRtmNngaY++hqxMcny3wCDGgy09tZiqCdX
         kwbMehiA7Bhv1ZQU6ujouNdsmAvORgp87q/bc1USDSEO0Z5m576MQQIUXcR/ySMtBLIU
         vMqUJCCmNpO/KLWIf5wbaxuNsHxWxm0zmiTqh2xxOpSKDFSyOt9B7dtAdW+VxJMpNeDX
         2QJJOAa32tJSCiK5GDHJGsAUZPuSfKghkpTcPdoTs+0QqVAi4Nyn6kSjMLHmkHxdjPBU
         tfAx8xe4XoKu8jvKB9r7WFGP8Lh7QF6nraPHBnVNL27gXi7ggXiH/Vh9Abq6weqTZhN3
         pS4Q==
X-Gm-Message-State: AHQUAuYMvdNMC2NOJpZmIRPC8cC27Ch3VCgXVl9CQ/Sx3gYKYfNHmwcD
        Es0Qo/sMWOcKGZav6z4J8iifTBawU5u4HTH/IElncg==
X-Google-Smtp-Source: AHgI3IYAeQUnocHFqqR9aEgmoSY6G/oWRe339+36nSXEhXHsopy4F3IAwny5uvewxccriTCitPd9bXlUEofBpYYfFxU=
X-Received: by 2002:ac8:2de4:: with SMTP id q33mr13246389qta.358.1551098625792;
 Mon, 25 Feb 2019 04:43:45 -0800 (PST)
MIME-Version: 1.0
References: <1550891629-29004-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550891629-29004-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Feb 2019 13:43:32 +0100
Message-ID: <CACRpkdYWB2FVN3YPZmvVnOexbmNsq-Oz59ps5RyNq3PWe6j38A@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: add check to return defer probe if clock tree
 NOT ready
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 4:18 AM Anson Huang <anson.huang@nxp.com> wrote:

> On i.MX8MQ platform, clock driver uses platform driver
> model and it is probed after GPIO driver, so when GPIO
> driver fails to get clock, it should check the error type
> to decide whether to return defer probe or just ignore
> the clock operation.
>
> Fixes: 2808801aab8a ("gpio: mxc: add clock operation")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Patch applied.

Yours,
Linus Walleij
