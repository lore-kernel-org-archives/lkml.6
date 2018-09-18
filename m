Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6D521471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AooVzlJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6D521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbeISBVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:21:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33780 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeISBVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:21:01 -0400
Received: by mail-it0-f66.google.com with SMTP id j198-v6so15140141ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01CO52F7ZaLIqzUB5c4Nbs9ZGyeI8ZxXHcCkZSx9T8E=;
        b=AooVzlJrswpuxR8FWnKKJcPwJageUxW4DQqZQOOQkN0Wi8ukYO6YQdzBlm5LXwTOpe
         ZBGTwZMQ+xbVAEtSn1zsFbw8BslKmFeaVCoM+WyE7hxXJWY1k9jkyiCchuX+xyS4TY1H
         hpHCGiNAyRN8kqGTrmFFTWYM8BAa+uPVXL0yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01CO52F7ZaLIqzUB5c4Nbs9ZGyeI8ZxXHcCkZSx9T8E=;
        b=Btj0FXetrsjE1Yrh4kJdoYZLX1mxhLuQNXP2rSbtZKJzlDMiwqdFUFpvcylIGPeCHX
         Ie24Ugke4rID2Buup+ikolvhEx6OrbxsnwjmoSvc36MX/nx+xLiS7F/Y3EcQ+dYBLwoc
         AAcPZdM+nnehUTsle7eVujzVGoxx/U77+ZvWOKbLH2SdeOxrHD7RTcGkA48EpOuD7CCY
         voRIyYvJAPqkNGykUT2ZuD520bNdYLsjnq5kt/EfRf9RjqZckO8Hdnoq7yc8G6fPp+rx
         npaAxlc2DBlD7vo5+uv7WXU9iBqMwE0HMF/UJJBEHnUiQzYGOrzgkZAkyJ8o7JwpIwIa
         835A==
X-Gm-Message-State: APzg51AZvbc1LHrleGiiej78OQqOKn1KtDNrWXToA+aQJ6m1e0olYGSj
        9qSgLPs7/+Hgmw2SaF+SqrRDg2bmCK53K0c7LToWFA==
X-Google-Smtp-Source: ANB0Vdb/c6MJ14WdffChFcFyhgLnWsuXnID0IZupazifpHKYUtoWemy0JOJTbuE2OTuzSzWr02MSK+5T/6jVu8sq/YI=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr29069437jab.87.1537300015395;
 Tue, 18 Sep 2018 12:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <ffa1fc0c62bc9408524619c8b530759351fd366c.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <ffa1fc0c62bc9408524619c8b530759351fd366c.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:46:42 -0700
Message-ID: <CACRpkdbaZT5vfbTzfPBDY61FDeqguTDkX6d8yRFvHpWdmr0oRw@mail.gmail.com>
Subject: Re: [PATCH v2 06/22] pinctrl: mediatek: add driving strength related
 support to pinctrl-mtk-common-v2.c
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Put driving strength support related functions to pinctrl-mtk-common-v2.c
> as these operations might be different by chips and allow different type
> of driver to reuse them.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
