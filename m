Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C2C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E630526173
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E630526173
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755554AbeFYVXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:23:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40628 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeFYVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:23:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id t6-v6so2066697plo.7;
        Mon, 25 Jun 2018 14:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SuDhzoGI1ZTQdS8wnxZf87oRh6JkuyiNCpzu2I2ktuA=;
        b=sM+W/WQtZKO+gA+1TNJ/1LnOLKXR0nb31YVkhdgDBvQRaTGHZ/3M/RIr5pXA65oXLl
         0Iny6YdTSWvyPYylQ05EubuojpgdSm3Efaer/Y+hh8EACZPpeD6s+09HVBYe/aThx21z
         TrJPJtnTX9MFlcwJ9CXpUZ7ep5TrilMimmVGQUhnmTZTcNnQ6t6ECJSIr5LYXl+vdsxW
         LhcU0a1lhVXlvAJBELqInswjmpZuevBcqGWssUHW6GsaHZW0cK0K6a4l5WHRxBY4BjeR
         kdR+5i8qrKbclDfSDR21J+ju80BBAu3xqnSXRII0dN+gRMzQs93Igqk/uGeS4NQ0s5r7
         vBNw==
X-Gm-Message-State: APt69E0mhyTrgwJxJ1w1c5OSrgILQ6krH+3YJXlN69FTNGmOqu26enP8
        IMbWdrjCVM8PHeeNOriqtA==
X-Google-Smtp-Source: ADUXVKJ11Ie777ZzDkFrbQnztfWsnkEGxuy7t9f4nrlzv9c9zZx9m4UYmIhcEo625QZ7SlDVgOhcyw==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr14237267pld.163.1529961811082;
        Mon, 25 Jun 2018 14:23:31 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id s85-v6sm1750769pfj.28.2018.06.25.14.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:23:30 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:23:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 12/19] mmc: mmci: add variant property to request a reset
Message-ID: <20180625212329.GA26557@rob-hp-laptop>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-13-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528809280-31116-13-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:14:33PM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> Some variants could require a reset.
> STM32 sdmmc variant needs to reset hardware block
> during the power cycle procedure (for re-initialization)
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>  drivers/mmc/host/mmci.c                        | 9 +++++++++
>  drivers/mmc/host/mmci.h                        | 4 ++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> index 03796cf..e952707 100644
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -11,6 +11,8 @@ Required properties:
>  - compatible             : contains "arm,pl18x", "arm,primecell".
>  - vmmc-supply            : phandle to the regulator device tree node, mentioned
>                             as the VCC/VDD supply in the eMMC/SD specs.
> +depend of variant:

Just make it an optional property.

> +- resets                 : phandle to internal reset line.
>  
>  Optional properties:
>  - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
