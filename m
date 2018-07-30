Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA01C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF8D20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF8D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbeGaAp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:45:27 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51157 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeGaAp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:45:26 -0400
Received: by mail-it0-f68.google.com with SMTP id g191-v6so1717566ita.0;
        Mon, 30 Jul 2018 16:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bDWDHS0jUQSEq+jgGJGFL2bynC2J89infDELFlmNaVQ=;
        b=bhE/tp6ucfmUZlvuOWclCnXvUwXDB36mKLxkp3NFab20jqhS6PwuJF2fAz5aq6oUHO
         F7FOy3CtDYUdvHMv7/O717mLFp8FYASOGDT2C/NZ36J/Et8teVUfkiMVknGn83e+UTAR
         pcCDyqXoufubQIa/Z/8ju860x4g73UrstJ6lgT6IzoCI/dD8X5DIIGmNrbDCs4KeEe51
         QnXS9d+QbqdkqgPKzZsS897JqfV39NNBlOnL+JUG9iAXuYDeNkWAbMnZfNCjI2CITbnV
         TvHM0MzZ8JUK34995dicG3VA3u6BkmzVRIb3KquPxrI1Bnk4p6/9LqzzW12fFYjU5rhn
         5BCA==
X-Gm-Message-State: AOUpUlH1HeaCQSRqOgsQX4FmlIPylDJ40zblsFroOcPh4i8vq+6kxWPE
        Kiwb4puYUOVG0sMp2RDsGw==
X-Google-Smtp-Source: AAOMgpc66qJaLbdkJrAs/cU3EVvKVgn8VteIFlC3isXwjvmPGHyQtvox1u+dRmM+UwJgW9iKGXb2Eg==
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr1115984itb.95.1532992091268;
        Mon, 30 Jul 2018 16:08:11 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m23-v6sm706494iti.27.2018.07.30.16.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:08:10 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:08:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     linus.walleij@linaro.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-binding: pinctrl: Add NPCM7xx pinctrl and GPIO
 documentation
Message-ID: <20180730230809.GA20470@rob-hp-laptop>
References: <20180730110406.132729-1-tmaimon77@gmail.com>
 <20180730110406.132729-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730110406.132729-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:04:05PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM750/730/715/705 pinmux and GPIO controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt   | 216 +++++++++++++++++++++
>  1 file changed, 216 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt

Reviewed-by: Rob Herring <robh@kernel.org>
