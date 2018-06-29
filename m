Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE7FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6251327EDD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ittoOWjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6251327EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965315AbeF2MW5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:22:57 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39829 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755250AbeF2MW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:22:56 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so2572025itp.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXjYu1WHmDS8iw9JunwKaK9Z2F4WzJ2sF+REkwNOmeI=;
        b=ittoOWjt4bJvFvHqstYoez+eR2rPa90rT0Y/XqScyph1hJxXEZuqD5dmB5hjQ+uWaz
         TsGjkt9UArB7EevL7Ow8LGa2cu7re3X77qbsSI9y2LmsU7gPMIuH9tPIdwWIOAW+reEj
         EZ5HAcH0ES4FtnGLdL2ILEOt5C6OeFDMDBzEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXjYu1WHmDS8iw9JunwKaK9Z2F4WzJ2sF+REkwNOmeI=;
        b=PR0/PVPaMS4Iwd5f9QAONBYnGBiFdqR0w62fGcNjhTqhlg8XEcXm0Fz1gbUqD5V5E2
         w40LTA+ZOv7AFM8DtYroudLlK7/Z9p6wsjTeMqsLwIlnVJ42kKeNkbOtewAEwwGUhG/l
         OYhrISPo2MMrnKfazRsCrxXaHTgmxmA8dlt0+ynGNUGEPRSB847ieyA1suixE3MYrMhc
         pBQfSsMINTbNMy5jMrnMlXykJl6fknx4KLS29qEAOYNyZMMMqUuWS3DSBgqPLT8pObDi
         zWhwKqHbrh7939qt7ERs1+6TdNk1ZG8KGM8Ah+2twV0nmgyrd3Aocaq4LXQiTWJ1EGu2
         /JJg==
X-Gm-Message-State: APt69E3SVMtlmZ2EoQ+Nqy/Z0d3pv98ukAmxGiCFl4jlCMKBwRNT4uwX
        a10cwmTkoBmxg0OX7gNtEQxnZAaUerAKskbBeu8r3A==
X-Google-Smtp-Source: AAOMgpc4SYuI5P+k73PaZYtARcW61JzgYwo0W1eYoHWHfPtV2WmUnM+HMF9SKlLGbYCIY+Z4AY78+r9wDMPD5b9VDvI=
X-Received: by 2002:a24:79c3:: with SMTP id z186-v6mr1231568itc.38.1530274976004;
 Fri, 29 Jun 2018 05:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <e0483accc1e82280492a2f68a90959232ba868f6.1529639050.git.sean.wang@mediatek.com>
In-Reply-To: <e0483accc1e82280492a2f68a90959232ba868f6.1529639050.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:22:44 +0200
Message-ID: <CACRpkdZta2f1OKB3E1crLH1mymq26_6vU4hF=fseRt_70EDEuA@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: mt7622: use gpio-ranges to pinctrl device
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

On Fri, Jun 22, 2018 at 5:49 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Using gpio-ranges property represent which GPIOs correspond to which pins
> on MT7622 pin controllers. For details, we can see section 2.1 of
> Documentation/devicetree/bindings/gpio/gpio.txt to know how to bind pinctrl
> and gpio drivers via the "gpio-ranges" property.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
