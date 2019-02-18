Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0918217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520469;
	bh=7nm0wZKC7QeRtHycAQLGrNK4FrYX4oOvdAEnvulXj8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WqrkiMOryDuegHE/7d/UYL/h/X682UQYuZgTWiMFOQGj1AU22rSTFI8YuTcqT+EIp
	 gIpcS2f/CWnPVH+fjysEFMtrnnOGTFzQGund58DD5M5fqUCEsKAAtbFTEdiiTc/y5K
	 9k0mvZPxt+63Uv5ImE4WWzZHU0yMUKH6Dcz7iHcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfBRUHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:07:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32835 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:07:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so30444125otl.0;
        Mon, 18 Feb 2019 12:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l4nPA88dKyLN/7qzjdL3b+1KxKUoGywzAkT8a2/2cHg=;
        b=S7DdunZq1pYo6Wq3rppHNpoNlJazbiFOV63LCUg8biH+XAUdnNgcmOAOMQ2Y+RpTw6
         W3PWkhddmznvt2GymCCqZGsCMPy+yLmVkwqDF7wstwzi8hQJ96XCJjbNW9IIfxtxjpO4
         J60z7mIaab6FJsejUvzSMisdxMU+mGYfrw9KWS6+/FnTn9itfbIV6dJHpKobVOkgc+XY
         AsB8HWTP8NzS9c11JBKwMjMcgYhaifw56DUFf2Nr5o73KSbyeHw7KxzCB5vBT9TJqT8J
         z5fGOGlN4hHnTTGMhotQ86uR0xa3tg0C+Fr8wHD5XNjmfTG5h2gHgXUIunPW7BbFlrSr
         IbaA==
X-Gm-Message-State: AHQUAuZcS66kjbdssQew2F7xgMvKChBjg2nFzLw9cJcFftTnhrm88Spi
        1t7Xxug6LfDgNmClqIg8Uw==
X-Google-Smtp-Source: AHgI3IaQUpKm+BCTrBrJXywu6koj9likdmcIeeGHoRovfUq/GA7g4ySMClmR2U2lNlOwwQQHs+jiaQ==
X-Received: by 2002:a9d:2af:: with SMTP id 44mr15574919otl.181.1550520466279;
        Mon, 18 Feb 2019 12:07:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u64sm6428178oig.2.2019.02.18.12.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:07:45 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:07:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, baolin.wang@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: sprd: Use SoC compatible
 string instead of wildcard string
Message-ID: <20190218200745.GA8619@bogus>
References: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 12:55:18 +0800, Baolin Wang wrote:
> Use SoC compatible string instead of wildcard string.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Add 'sprd' to indicate the module in subject line.
> ---
>  .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
