Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB2BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B86C206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B86C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeIZCaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:30:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41287 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIZCaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:30:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id e18-v6so25801854oti.8;
        Tue, 25 Sep 2018 13:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EHIu6h9W6NFX+pw3BZtVkHMy+A2VO6Sii4fJuyQ8j98=;
        b=uesGERqycsI6E4niD9UbGbSEwIQMEaKiovaQ4FSYYSj9vRAlI3R5VMwzfbHhrJF5XD
         BoYidldPYeoSDIaAGphzYP+9daml+KGOmyDEX9kEyG+slLWv5zpq7ySZapNNzcmIfRkh
         IK8OWYta60PBqH6mFT2VPjq5oVaeXykL36nThz/n/EHpzwVN4oflZA0XWiUEGcvWaa2c
         t2L7XMsHakzl6N5PZslH4Iy1ZvxvxY5tsCyEV0RTOYu3KfsKU5zQR7fYhdHXuIfBhaFt
         icuGH8X405Rl1HqES8vEy3es+2yBS6tvh2FaDDQchGHst1cGU9tbbLT/rmidsnM1Kucu
         AN9g==
X-Gm-Message-State: ABuFfoiDkNs10NhYrNZYX/Nvs8mpAzytLoWNQifa8d3ToWgDXsbJh7nA
        K3zsHxjgDzm+ih1nCGpLMA==
X-Google-Smtp-Source: ACcGV62dmnk+Myt//gsfYTIqWTEWcd90Omdg06+8IOZQZUgV6Ls4T0qAsFbT1MwZag1sMKaLQp45IQ==
X-Received: by 2002:a9d:520b:: with SMTP id e11-v6mr1897745oth.396.1537906849574;
        Tue, 25 Sep 2018 13:20:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s145-v6sm1122443oih.16.2018.09.25.13.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:20:49 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:20:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        broonie@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 4/5] pinctrl: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20180925202048.GA6227@bogus>
References: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
 <20180905104120.17252-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905104120.17252-4-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:41:19AM +0100, Charles Keepax wrote:
> From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform.
> 
> Lochnagar provides many pins which can generally be used for an
> audio function such as an AIF or a PDM interface, but also as
> GPIOs.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  drivers/pinctrl/cirrus/Kconfig             |   10 +
>  drivers/pinctrl/cirrus/Makefile            |    2 +
>  drivers/pinctrl/cirrus/pinctrl-lochnagar.c | 1161 ++++++++++++++++++++++++++++
>  drivers/pinctrl/cirrus/pinctrl-lochnagar.h |  115 +++

>  include/dt-bindings/pinctrl/lochnagar.h    |  135 ++++

This belongs with the binding patch.

>  5 files changed, 1423 insertions(+)
>  create mode 100644 drivers/pinctrl/cirrus/pinctrl-lochnagar.c
>  create mode 100644 drivers/pinctrl/cirrus/pinctrl-lochnagar.h
>  create mode 100644 include/dt-bindings/pinctrl/lochnagar.h
