Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D2ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759BD2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFD/5ofQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759BD2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbeISBdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:33:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40411 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeISBdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:33:02 -0400
Received: by mail-io1-f68.google.com with SMTP id l14-v6so2602973iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZivNaAHyPgB3I2qFr/PC0olH6lzS83VnZzbFgPEN7c=;
        b=aFD/5ofQu1GxDJahodfegTc4c0yvtwrHcgFIQz9Tc+5427STK8It0jhBIYOqi7D0kq
         ktPHAXQshsXVtBPdy1s7eZAig+UwaSUc6njwqNv6UClPClPhCRSsKy2wrvphIbf83SER
         Nj6ieIYP2dHhymv3/w5RwTjcViVlkD7dQrgOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZivNaAHyPgB3I2qFr/PC0olH6lzS83VnZzbFgPEN7c=;
        b=JdP1/cfApnJyJvoWq1/QsHucamQoUidxlOWX2lE9BFU6j18fj42xHUGNl5T/j0K6Dh
         ULSi+YoyDhuyB0eUjKpMkmaNigYAXO58D/MRqhIL+xOOaIkIBLNoX1YULftoaUfSmePQ
         L5ohm1ev7jWmUqndkwMHhypzdsFnoZRqUtytXrytynseMz1hexPk2NDn5rOZx6Rchzl6
         GYQC0jRH1k+mzfjUQp35zQRhZOQXK7Jh9Rj2+5N4IDmgZNLP27n+NX2ZSozr9vUt0/9B
         a+eBEKPgTP2Hos8tCXSIEq/bazc+i/4LheHx7E/HZH6FI6PdlEb7sHa+jL/P1lInb3ix
         skWA==
X-Gm-Message-State: APzg51DoCt2G/WURjB6z1bxcCO1OYGtTGLofMlQKo9i2wLpsMNWarIRp
        1SrANg1uPJvIA0z3gfuLLdUzRQTPBgDI8P0SAEKSVA==
X-Google-Smtp-Source: ANB0VdZwOVJ4yfyx+z8Y6bp2PYJ2fgBWxJZ3l7h7rEg/yIrDbOsRPE7UgxXLomApk7v9am48dnjp1MPUofCVXhz34QI=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr26177217iog.175.1537300733857;
 Tue, 18 Sep 2018 12:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <8706de60fe75838b595d3be73681bbca344734a8.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <8706de60fe75838b595d3be73681bbca344734a8.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:58:40 -0700
Message-ID: <CACRpkdY2YOu-BPt-qeZQt+o4TiT5UKrD8UfV_bOuJ822nAfohQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/22] pinctrl: mediatek: extend struct mtk_pin_desc
 which per-pin driver depends on
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:08 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Because the pincrl-mtk-common.c is an implementation for per-pin binding,
> its pin descriptor includes more information than pinctrl-mtk-common-v2
> so far can support. So, we complement these data before writing a driver
> using pincrl-mtk-common-v2.c for per-pin binding. By the way, the size of
> struct mtk_pin_desc would be larger than struct pinctrl_pin_desc can hold,
> so it's necessary to have a copy before the pins information is being
> registered into the core.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
