Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5257C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA662087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IipMHWLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA662087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeJLQtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:49:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38635 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbeJLQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:49:08 -0400
Received: by mail-io1-f68.google.com with SMTP id n5-v6so8730714ioh.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5xToNaSNE2v8YDJBIz39Q7zbFqtJHpLHrXdZe8EAy8=;
        b=IipMHWLoMcJJyUcPCOHtZ1lND6v8F6gkcmTVYn6YT6T+dN52ZYPl/9i8zCdJleyot8
         awrq7s50oJHP1v99C0TzD2m84CJkgcJDO8vUTHAF1CKJmJsQJNg49pVnNzGZt+609dux
         dMjNeDx5cAJhbyHorXgraoHmEEzmYOWZTzhLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5xToNaSNE2v8YDJBIz39Q7zbFqtJHpLHrXdZe8EAy8=;
        b=hyRH5boP4gt8+ryd2kBU2h4o9u+UOOVu1kPXZkgqv9g+FuUXlJMMh9rqQcesPfO/UE
         tnJKth6Ok2usfWHvFYEUY1aA271y19YNNy7pIFmrFG8kFHo75L074CNwEHWtOviMUHtw
         wGPLMwy/tu2brjjD7E1QsebDuG22adHxVz5PhVoU30RpK/mEgzWl0oBjzem19JHIiVVh
         Uut7OZY1R6nZkVBXsDSUT5NO5d0HY3MtvsT/WG/2NFaMPCvnZTyOOhCYnnmB+5bflPrM
         IbkqPa9K+4BdganssSRR0N9vje6pjYx+vkypxGMakFNpdLdJ0eeMBLI3AT+xXlTYK0AP
         6iEg==
X-Gm-Message-State: ABuFfoiVJNnHpkBtDz3N3E4B2hIPfLo/oHU1tKfdbgRtCGwIPc8e6VoE
        nTgDn0xO7Mfuz69o8mu6fLuOk3+bKtToW+8IlxfHmw==
X-Google-Smtp-Source: ACcGV62uJf703NrT4DsiFtErIGNISd7cDexfkC0eSKH3V2RooPRd8G6xd05OS0yQto25Ke+1ib5hakXP4WMvnBiYG+o=
X-Received: by 2002:a6b:6302:: with SMTP id p2-v6mr3372179iog.175.1539335859214;
 Fri, 12 Oct 2018 02:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181011204042.GA17125@embeddedor.com>
In-Reply-To: <20181011204042.GA17125@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Oct 2018 11:17:27 +0200
Message-ID: <CACRpkdb9b6kxgj736OmLhBvzhR26DT+bE2Y=jGaMB3411oa3yw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rzn1: remove unnecessary unsigned integer comparison
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for top-posting, Geert is maintainer for this driver.

Yours,
Linus Walleij

On Thu, Oct 11, 2018 at 10:40 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> There is no need to compare ipctl->mdio_func[mdio] with => 0, because
> such comparison is always true. Notice that *mdio_func* is of type
> u32 (32 bits, unsigned).
>
> Fix this by removing such comparison.
>
> Addresses-Coverity-ID: 1474166 ("Unsigned compared against 0")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pinctrl/pinctrl-rzn1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-rzn1.c b/drivers/pinctrl/pinctrl-rzn1.c
> index ce05e3a..b5650d8 100644
> --- a/drivers/pinctrl/pinctrl-rzn1.c
> +++ b/drivers/pinctrl/pinctrl-rzn1.c
> @@ -195,7 +195,7 @@ static void rzn1_hw_set_lock(struct rzn1_pinctrl *ipctl, u8 lock, u8 value)
>  static void rzn1_pinctrl_mdio_select(struct rzn1_pinctrl *ipctl, int mdio,
>                                      u32 func)
>  {
> -       if (ipctl->mdio_func[mdio] >= 0 && ipctl->mdio_func[mdio] != func)
> +       if (ipctl->mdio_func[mdio] != func)
>                 dev_warn(ipctl->dev, "conflicting setting for mdio%d!\n", mdio);
>         ipctl->mdio_func[mdio] = func;
>
> --
> 2.7.4
>
