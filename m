Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3699ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557552146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQ642pAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557552146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbeISBRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:17:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45247 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeISBRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:17:35 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so2550007iok.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zp/prRIqX6uqNKhny7UXEwgjhvksawDmeFnFpvf7LwQ=;
        b=OQ642pAlwGBsrCSFDUTUCQE/65Sb26ekCpkWi8yIuBxJ36nY1eioRaq1eP2vWXzd9a
         P/R6LoCJBc6wEvoY0ol1V0baabPi3pqUz3ntqmpkljclzarwGTk97/CIzixz4Vgs5Jx0
         86K7V0NRKuksPAr2j/tX8reRQ98/Vw5/qRQp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zp/prRIqX6uqNKhny7UXEwgjhvksawDmeFnFpvf7LwQ=;
        b=mdlPUjJ9dPaYEGmr/TvBZbDs2wl+jbiQp0yJCQzKQs5IPgFVBK4V7Nd2U0SVfMNK79
         lLH0xbHJFKJuyHa8BI2E7XDsfFuuiq2xkbrMZNDdZQLOhqU5O9i8dnIoCOwawa7hdjKZ
         LrAbbwlaYhfK547/B9PgELOTBJbfCPkpO8dgXvMtzSH6jMd7ki+ISPG62+2pSDm5ibXY
         wfEfYCIaNTEff3/pmbTuxQWFgk2W2JNEYFyGDhNnao9LuwCs8pbyR4omjWa46PuXNSal
         JdepAC6Rby97W48GHCG3GzCCdX3cF8Qym5I6VFpg16Msfs47S1y6+rttSY6o/e/NqFNw
         TgbQ==
X-Gm-Message-State: APzg51By1CCIYebAEUjgy+W2FLcocanlHJe00Q9ltWmqWEIExFLc9CY8
        F416U0XX9MBHncQjC5SpB7fDDbAbwSFqpVaSZxXKYQ==
X-Google-Smtp-Source: ANB0Vdar3ZP2ZAIvnblCtYde2JpF5jcD8gt+6YqjMVSj5HfTwcXWbXrKGfT1BS8zh7TXdWrcnxwM/KImj2bfdmijS44=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr26009430iof.304.1537299810400;
 Tue, 18 Sep 2018 12:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <d43dc09d7ef45940ee14ecf546e939e39315a28f.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <d43dc09d7ef45940ee14ecf546e939e39315a28f.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:43:17 -0700
Message-ID: <CACRpkdabZop+9L5Hq9pCrYmHXug_qpm6QZV99HdnBh_ecXLnVw@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] pinctrl: mediatek: extend struct
 mtk_pin_field_calc to pinctrl-mtk-common-v2.c
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

On Sat, Sep 8, 2018 at 4:08 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> This patch adds members sz_reg fixed in struct mtk_pin_field_calc
>
> - The 'fixed' is used to represent the consecutive pins share the same
> bits within the same register with the 1st pin so that it can largely
> reduce the entry size a bit.
>
> - The 'sz_reg' is used to indicate the range of bits we use in a register
>   that may vary by SoC
>
> The above changes make the code more generic and this is useful as there
> might be other existing or future chips all use the same logic to access
> their register set and then being a little more abstract could help in the
> long run.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
