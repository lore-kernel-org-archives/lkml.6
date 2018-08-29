Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6FEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6502087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6502087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeH2E0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:26:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36933 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2E0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:26:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id p84-v6so6175255oic.4;
        Tue, 28 Aug 2018 17:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i8XvlEMxbxRtgpFCaiERkBAAAkQ/USkuE7nuS50M55I=;
        b=KG9VXHtiaj0Z+bLjm1/QhirtPSeAtwEj6NcF352ybs2na/lCbJQ5DIC4AESsQUzZrj
         89iLP2FG+LvGyTU9TXGrYaP1Vuir3kP3cx+MUE0SGLOpHQTu6WBaJwAuFbENumPWbyot
         K6exed51uJNaz4wXztJYyvbsnSCsUdXFsaDRQ9qfEGP03ZelaNzPo5Godz83cr6a0REN
         VPA7dAQezdwleodsOvNbnpirQFH9uluMnnfeB6nQlDT2psvtt+eWt6dZ4qBiBA+RBJt9
         6T8CfjJd9eppmFRNI+olg9kKcGhokMexqksQaS297VjNCZ33p2gFjzisDJ72Gevkxv9L
         0Wzg==
X-Gm-Message-State: APzg51D4BbiHhBMXdE4bBgCIgNPpTj979/9t8P9VsQ5p8weKk2wayX/t
        mRYhG1wRt0pDm0+Eb9Q/+g==
X-Google-Smtp-Source: ANB0VdYvwwhI6o9SRteTwrSSsm3aw8PgsDGi6DCBBUfvWdBM1TGQqWgbgMZgKNnaERMIDiMKNRXM0A==
X-Received: by 2002:aca:c5d8:: with SMTP id v207-v6mr501164oif.264.1535502756869;
        Tue, 28 Aug 2018 17:32:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r187-v6sm1261581oie.43.2018.08.28.17.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:32:36 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:32:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: pinctrl: Update pinctrl-ingenic for
 JZ4725B and GPIO merge
Message-ID: <20180829003235.GA12527@bogus>
References: <20180821164236.21101-1-paul@crapouillou.net>
 <20180821164236.21101-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821164236.21101-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 06:42:29PM +0200, Paul Cercueil wrote:
> The pinctrl-ingenic driver now supports the JZ4725B SoC.
> 
> Furthermore, the gpio-ingenic driver was dropped and the pinctrl-ingenic
> driver is now responsible for providing the GPIO functionality.

Driver changes aren't really valid reasons to change the binding. This 
is really just "combine the gpio binding with the pinctrl as it is all 
one block." In any case,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: New patch
> 
>  .../devicetree/bindings/gpio/ingenic,gpio.txt      | 46 ----------------------
>  .../bindings/pinctrl/ingenic,pinctrl.txt           | 39 ++++++++++++++++--
>  2 files changed, 35 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
