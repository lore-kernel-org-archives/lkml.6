Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38651C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2F42064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LryKbhA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2F42064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeJBP4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:56:50 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37604 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeJBP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:56:50 -0400
Received: by mail-it1-f196.google.com with SMTP id m9-v6so2666817ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwdtfJImt6PmBcRMz3xD6YfiBGME8bw3oXOIH41apcQ=;
        b=LryKbhA06LFyMkSRwxjKH/tshkw8G0ld0o2aFt+xfjj0J17592WBBPTAZ3skxDDAn7
         2eUFmA5QYIP2Trw367klKpESdQJALTlH2KNsw/g9gobnMATRlD8JCvM5ngAMGn6WGMbp
         P0AiiLIhLgo++z4ZfdTlXQk6pOt/MvqM+ERuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwdtfJImt6PmBcRMz3xD6YfiBGME8bw3oXOIH41apcQ=;
        b=GE7S+XLB5J2A4f2qudWF+dkJuPrTkX1TD4bjyUVMBZ6VTICuaMkn5wPnOHE645SMcb
         TI9z/yNrlF9A5xrThOzmcqi3Du10bgEhaqYQ1Wui3G63JlZ0+pTdojNaEYJqdkhKTlij
         M45cpjO7Z8J7pPI5X+PZ+x+L7SwfWdUgvjzBJziPTBzknPF52yMaYgOYeLFtIiVn20AU
         xcOyot9yRewbpCgcO/w+NhdS0q5Db5RsTSj+JYvojS6RoWJ8lWFl2wHOzbVdctOP0SXb
         XJVunI6tOxzJl3z6Ouw9TqyK3WfLUo/YKihiDzDQejAP1yndrWkY6uyMGgx76BmIOW+1
         1a1w==
X-Gm-Message-State: ABuFfoiLsYQ9os40W3JM/50mfti43gtVLg81aW+q2A/8gCT6n2VdK8IO
        dZ7CJFYkTgsfjzo0vSvqxzJLjKEpNZ8U3w+VuaqqtQ==
X-Google-Smtp-Source: ACcGV61Sj8Z5Sj8X2aG3RbACK5Nrf0OgfwPDtSemTUQP++sAi+OZH2ymzlDH36CihAJXwruG0xoew81hQ6NagcOy8aw=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr1368550ite.16.1538471673857;
 Tue, 02 Oct 2018 02:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181002082731.20141-1-ricardo.ribalda@gmail.com>
In-Reply-To: <20181002082731.20141-1-ricardo.ribalda@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Oct 2018 11:14:20 +0200
Message-ID: <CACRpkdaFciX3xMw8ErRCwy79VVF6HDVkjAHi2EOtXXX_X1uVuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpiolib: Add init_valid_mask exported function
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Timur Tabi <timur@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        jhugo@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 10:27 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> Add a function that allows initializing the valid_mask from
> gpiochip_add_data.
>
> This prevents race conditions during gpiochip initialization.
>
> If the function is not exported, then the old behaviour is respected,
> this is, set all gpios as valid.
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

This is a very appetizing patch set.

I think patches 1 & 2 should be applied for sure even if
we don't apply patch 3, simply because it is way more
elegant.

Looking forward to see some test on Qualcomm's hardware
for this!

Yours,
Linus Walleij
