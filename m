Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3BSCCV7ZGFtiVgAAmS7hNA
	; Thu, 07 Jun 2018 07:06:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 84AF2607F7; Thu,  7 Jun 2018 07:06:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2apqN+F"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F2C8C60452;
	Thu,  7 Jun 2018 07:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2C8C60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeFGHGs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:06:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51711 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbeFGHGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:06:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so15788934wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/otPUZ82UeDndZwAX2QgrwyhF/EKR2YiPodbsP8G5W4=;
        b=f2apqN+FeaAydDH/aH2N4rSQBH5j5clE3m+NE9ldEmpvo9naWtZDF/UgB9u38UQhyd
         fGQrEpN9b47eA/ouDxg+8vJxC/Xi+28erFYJ7lc3C7SlV7l2RQF0t1cqbFld4MiZPwH2
         uMvm8bGE7eih7P0oTiQO/mGgswvHdXF2L4BeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/otPUZ82UeDndZwAX2QgrwyhF/EKR2YiPodbsP8G5W4=;
        b=W3J8mVFQN6370wrQgX5oq9zEEObIbGew5Tgn7w3HPTvQF2ltznAqLw0bh7zSEHootz
         YcG13sY2YI8pnCPCu+Uj5fJKLlksy9Ju8J75t8KgCPA/30xQ1J2c1cP1WDYfQ5hlpb2z
         0WucRlif9yiTtJVzrm+iCck0/wKmVuRiYeB5hw02HDIfTnRnPUJANDIoURpvHAsBOjwB
         rmdcFqaey+4wY1H0vuibJcsWpDVpQHuzx/DX8zV8z7Ttgo1s9AtMFxEsHQm2SBa3C1n+
         jmY0ms5x/gZzbfb0KHbAWgp4xQImxkURjJ4EcDC/ZXAbnTxCPA7ibLpyRHL48+tMQC2R
         neXQ==
X-Gm-Message-State: APt69E1waW6Ns+6sQvKB31paa406vvqqw//Gwydi8sPj+8zNFN1rXVZX
        YHZR2R4p1RM7bG1BXe+kM1J0XQ==
X-Google-Smtp-Source: ADUXVKIqqgaxI4CN+W38Yu1nYQe8tFpFFmYCh3FU0bcZzwRzkoZNSRJBmzKrUaSR+pE85cVZRCdZ5Q==
X-Received: by 2002:a1c:800e:: with SMTP id b14-v6mr666422wmd.83.1528355205850;
        Thu, 07 Jun 2018 00:06:45 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id v12-v6sm748088wmc.35.2018.06.07.00.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 00:06:44 -0700 (PDT)
Date: Thu, 7 Jun 2018 08:06:42 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 03/14] mfd: da9063: Use regmap_reg_range
Message-ID: <20180607070642.GB22841@dell>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <20180606100003.17067-3-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180606100003.17067-3-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Marek Vasut wrote:

> Convert the regmap_range tables to use regmap_reg_range() macro.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V5: New patch
> ---
>  drivers/mfd/da9063-i2c.c | 174 ++++++++++++-----------------------------------
>  1 file changed, 42 insertions(+), 132 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
