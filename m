Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D44A253E3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBiJ4IRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D44A253E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeGBOVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:21:49 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38260 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeGBOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:21:48 -0400
Received: by mail-it0-f66.google.com with SMTP id v83-v6so12218898itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10F1VwpoLTwxCt6mlvMfqNZcprM2F9E0ZE1Kxt+ezK4=;
        b=GBiJ4IRiEy10rs8kXXVoIBRfzGVsZaFk4NVSZYGRh1olQhnAWMTjZuDVg3CzQ9EZxl
         iSnRN6GBKivdKUZvMaPlpy/txe4h3SePDo50upJoqzlkRpjtdC/aP3pVdgBrarARQm71
         MXqoUBAbDmOPUxPTy12zE//y6WaQPIQaDcRNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10F1VwpoLTwxCt6mlvMfqNZcprM2F9E0ZE1Kxt+ezK4=;
        b=gzzUgoMTPXYxOE+4H1kuc/VQRdVe2tEZkjujJmnIwLQZ5Uan6JgUa65dxHF5nZpS1x
         ddLJZGE2FudcyWqVwNJ3e/2XHhTj/IX4lwBNRQOql1U0aYkDIIRC3h/ja5+baDLm+d1r
         Q9Wl+6o5uQhbzBZhG6TzDsfA8BRTAj/ydHLB4ZTF84UV3bap7J8vC7bnTrq2JeAn1JsP
         mx9FBOqXG7aKqmEVepMGS2eLIGv2+o5i9RJFUWVYXNEn7Qfmlqulzer+KhC/wcNEz/1a
         N7YHG1VCSqyHzvqR3SkBPYZ6UItevk/eqSv3nbjp5OWfwRcMqR8lbz+X32iOpZGv6Hnx
         g2vw==
X-Gm-Message-State: APt69E2WyfSLHGUytLFQ5oNjT5+cFTuL8gM2tLJOl1nf9D5kfXzwDCPt
        4LPcuZuB6u6RZHewSL11GZzX/kJ3RCBM1jcYOyW9gl3oPcE=
X-Google-Smtp-Source: AAOMgpfuYnz9/psQzc+NWwGoEvYqmfcWNnYyFd6yNW6DwEHU9VPcKilqAufcIfz+4p16BzL6NSz4wsMBREXLphyLhMY=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr8144342itb.38.1530541307732;
 Mon, 02 Jul 2018 07:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180629185107.GA37488@beast> <CAK8P3a30Q1ezvCWfudUY=z1q3NHdrkbwRsmSDso4s7TifQAmNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a30Q1ezvCWfudUY=z1q3NHdrkbwRsmSDso4s7TifQAmNQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Jul 2018 16:21:35 +0200
Message-ID: <CACRpkdYbmu_Y6N1G3M3q3M=3ZaECFdgije6Qgwoo6qra4g06_A@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: Remove VLA usage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>, vkoul@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:22 PM Arnd Bergmann <arnd@arndb.de> wrote:

> - Nobody uses this driver in practice, as the hardware platform
>   was a dead end

Depends what you mean with dead end.

The hardware was deployed in a few million handsets from Samsung
and Sony.

Some have been picked up as targets for PostmarketOS:
https://wiki.postmarketos.org/wiki/Samsung_Galaxy_S_Advance_(samsung-i9070)
https://wiki.postmarketos.org/wiki/Samsung_Galaxy_SIII_mini_(samsung-i8190)

So it is no more dead end than anything else discontinued, and it
has a living community who want it suppored by the mainline
kernel if possible.

Yours,
Linus Walleij
