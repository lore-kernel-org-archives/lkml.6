Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC60C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2932820880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyPKQq8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2932820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbeITB1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:27:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38868 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbeITB1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:27:36 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so9327883ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJud+B01iIILRY9pf3F+UUnpT5r4yviFKPlurZF71fY=;
        b=DyPKQq8ZLmRvj6yMsl1G3BfPcJXALnbGfg94tL8cFafSN8ZkK/I9a2ov2hmaOZoUYv
         0NMaHXiPKrS9mqm4i/neW1smkcwZrubzPa7+laB3DgGSnoXobWiBcQRTPyUTlx0cGXxu
         9K7MYK4gJUXWufD6EW3o+bCwj84neuPPTVkPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJud+B01iIILRY9pf3F+UUnpT5r4yviFKPlurZF71fY=;
        b=Zn0QOOI5E+epurMxCXD9afxEU9271NqdZnD6px35Pf3fiWuHS6M963X3bfiQTfC8VC
         0Rls/5gbjc9H7xwLqAoGAuPLGNr49M6tHnqhmg9h54B6PhekkyKp7cleP6lZdUWykrFY
         AW8MfgGi30A1evyvSAfo3qmv58f3Hl64rPUcjT63iP6bUdrM9Ay38th56uAzwfWN9wqY
         2LN1NQzQl7aeQYw84HFOgtIsfzbTnU2txWES+XPH6chgb4yKsLY3hJrtNRAluFtHbY5K
         lznaEsv7+62aDBhhljl0mKD42hquzsXQfbSbfXqQ7Fx8S286K2qX291XuVL6EOkWSxJc
         ihxg==
X-Gm-Message-State: APzg51BJRf43CpUgsyyLaPFKD6tS/o0Rw7davDsmuFdNwR7PxijHWNjm
        T9oB5WadK5lBM7rWstieXzlk4UYpwy/YPSaIL8DSkTUc
X-Google-Smtp-Source: ANB0VdaCpX9G12NGUbI23ONsyy5Z4pW1xy8Z5frvaT+0x8BwRjx7Di7/SwcdG1bVIFh3Ulh+EkSp9f03WuOzgdPafnw=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr22950564itd.130.1537386490690;
 Wed, 19 Sep 2018 12:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com> <1537363669-25991-7-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1537363669-25991-7-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Sep 2018 12:47:57 -0700
Message-ID: <CACRpkdZ4nCV3g7Noi9eTQvvXpWhsR46d0Fygt=uUS3aJdjRtyw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ARM: dts: stm32: add joystick support on stm32746g-eval
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> The joystick (B3) on stm32746g-eval uses gpios on STMFX gpio expander.
> These gpios need a pin configuration (push-pull and bias-pull-up),
> described under stmfx_pinctrl node.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
