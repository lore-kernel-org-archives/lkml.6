Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD02C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6594B208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Of8VHgPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6594B208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbeFRFsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:48:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33824 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeFRFsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:48:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so15400842wro.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WtYdziSqrC+D16a75PaSD2xxmYWgF/xPtyOXU+148n8=;
        b=Of8VHgPyBu/KE3zUVWsIn5xzIabHeXWyDQeGXlqWLWYkhcnvKzluw85gfDPYzAfIuc
         4twh0PvOLAaTxi5AIUjHSCkTZlZOf5xP+l3ImV67rtS5h4VGu2nIAb7wNxysENXkadmf
         NxvwjVgI8mhkKNvFp9H2eN3t8bEdF4jy/NGvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WtYdziSqrC+D16a75PaSD2xxmYWgF/xPtyOXU+148n8=;
        b=emgdBnA1uFwPVUCFKhePVbTftzKUzCC3HZNKE8sbocQeHSzVkI10CtRvVVYT8Ft8qY
         qY1Fib5dWlkUfvKVIUeTUZLoCYXQoUv9o4DvI1jc0MaQ24R9G9zoSNmlDAyBKYF8Xt8n
         wRE5xEXZaB56ie1KiW8NPNBcIb5m9DmDWOLny58MxGnK5p9d4IahECNk/w9t17aOJ4ai
         Y+odLTkALw13Fq9W3cebt3tqErZ4j9jrynFKEMx0pnuV2PHIGmO8x/GJReWcSYfzDBiZ
         0fu5vt962m7bL7zenSiEh7A7P8nteDnO9Ic6tWqewXnee6HKuMcGkhxADupDs2DXsh0L
         Bb6A==
X-Gm-Message-State: APt69E0P98MF/4a1rsaXs6hW4y6lyrXuh3MkADZ9yMA65LiwrZxNuQ1x
        mtb+J5CkASBwvYJRqzPeLoxAdA==
X-Google-Smtp-Source: ADUXVKKVMAHGJ0enc6ET3CloRSPLv3GCxwF7Nf6dWX6IB2KKg3A6gmHws6Riqd+engEwxWa9WVTx+Q==
X-Received: by 2002:adf:ad2f:: with SMTP id p44-v6mr9290595wrc.164.1529300896274;
        Sun, 17 Jun 2018 22:48:16 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id p38-v6sm32515687wrc.11.2018.06.17.22.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 22:48:15 -0700 (PDT)
Date:   Mon, 18 Jun 2018 06:48:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 22/26] devicetree: fix name of pinctrl-bindings.txt
Message-ID: <20180618054813.GA31141@dell>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <1832904c012f823958663464ac4fb249f77978b5.1529079120.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1832904c012f823958663464ac4fb249f77978b5.1529079120.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Mauro Carvalho Chehab wrote:

> Rename:
> 	pinctrl-binding.txt -> pinctrl-bindings.txt
> 
> In order to match the current name of this file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt | 2 +-

>  Documentation/devicetree/bindings/mfd/as3722.txt              | 2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/mmc/microchip,sdhci-pic32.txt         | 2 +-
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt            | 2 +-
>  .../devicetree/bindings/pinctrl/pinctrl-max77620.txt          | 4 ++--
>  .../devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt          | 4 ++--
>  Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt   | 4 ++--
>  .../devicetree/bindings/serial/microchip,pic32-uart.txt       | 2 +-
>  Documentation/devicetree/bindings/spi/spi-st-ssc.txt          | 2 +-
>  9 files changed, 12 insertions(+), 12 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
