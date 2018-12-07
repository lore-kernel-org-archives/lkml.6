Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB05C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95734208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZpnHsgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95734208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLGJqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:46:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46759 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLGJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:46:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so2514599lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHFzK1kA205KsPcDSSgpBTJ2wwL+eQOeFE1VMWe3mBA=;
        b=hZpnHsgmjta5vss2x7dc2xlO7wb+CJ4XXGbvUTjeAAC31awC85WCQdFeWIyb+bn452
         V2XhKJZEi3iv9vLjQJOrRyCFC5WTO80OL7XlrZvjjKGquFQbMdacX+5qBgLQddJnKVXz
         2t7pGkVlJb87mmla8I2SZ5K8qArZP1xvAWovo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHFzK1kA205KsPcDSSgpBTJ2wwL+eQOeFE1VMWe3mBA=;
        b=JxPeu/M4mMl8ZBkG1f7+2f5mbz3At36H4JhQJuaGYiYiZ9KmqvQACdmq2PzdHK+z8H
         WUpmpoXv300RQ83zIQjNsaRpv7iRifEEdrJTiHD7JjdPK+4yu1xZjfaIe2dvXMrLK/xY
         Baqa9IXflXxxvj1nRzFGNXXVTBDPhN6geMQee2Bv1UrXpi+xIvT2ncFkkdkavPlKU2T/
         SlCI1iJlPZEsvBv65v+abLnPBI8l3GKCbw4RcPZ/DwJrOAcHf1SCnBWMNUJnWPSh7JYz
         ZKQJYxFxMU2jg3R9SdUaLsyxXxKjRIMtIrjxaK+GTmn3PgzRWciekdlMDDZy/S/r1oBn
         JjkQ==
X-Gm-Message-State: AA+aEWbQNWWNuM0DW8Vg1SzpSyARY2bjlaJQH65eLLcO20cNsF1gFsS/
        O15C1TLYaKlzYNBLQTJzUni49VwCjwdbVJToDTyOTA==
X-Google-Smtp-Source: AFSGD/WKpWdhsfTk/yslSmFbJk8reKO3YhH3cOmh1dj2xlDkz6BSlClMYWdAOe6/Bwuik9oSjrPPtMjEUAqyqFjPCyE=
X-Received: by 2002:a19:4849:: with SMTP id v70mr893570lfa.62.1544175998063;
 Fri, 07 Dec 2018 01:46:38 -0800 (PST)
MIME-Version: 1.0
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 10:46:26 +0100
Message-ID: <CACRpkdbsXHj=5uZNcJyxYNGhTeF3KhOyHaFgC8_DtTD8mRwynA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mt7621: report failure of devm_kasprintf()
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 7:12 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> kasprintf() may return NULL on failure of internal allocation thus the
> assigned  label  is not safe if not explicitly checked. On error
> mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
> (unlikely) failure case should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")

Patch applied with Bartosz and Sean's tags.

Yours,
Linus Walleij
