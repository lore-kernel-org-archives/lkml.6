Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10C4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC52B20834
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEH6E8S8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC52B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933479AbeGDGYG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:24:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33676 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933358AbeGDGYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:24:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so12154673wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=itUrj/mxEesl+nygtNadtT5Xmxuwz+ndLFNt4EYzj68=;
        b=SEH6E8S8VfAY5tg/akVX9f7j5Y9u03oLTZ0FHOk5Q9sDC8R4Qqhts56VPHdEubbPW6
         ckp4JdYi1cpFX9/9dYOxauzOOeUo63rMZohkK+Dea97dXZlzHUg6wQonGYpXcTdOMCrx
         Kt1lLa9OKFmNXmcNqC/N7ese1j0G9UfMoOdUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=itUrj/mxEesl+nygtNadtT5Xmxuwz+ndLFNt4EYzj68=;
        b=ujBRpbTIT6q9IuO3htHPYoYnUFBZBmxXeDqwrGPysXnsGjV/7NSRQyB9TY9g5NYx5p
         pUtc5WLRT+mslOCiBjQBhZryP/TthN29nczF6TjYprlVArqS+9tUKguKo4apq+I2qqK5
         D+GnVLN4LRAaLy6sKW4FRAjUY9Pp8Vy6Nx4Gx9QgkrofIRol2VaOHAQMDVpeAs5RAF23
         cX8A6cUT3gQHuMaayf73mqR66SBBIcfYAoXgiPc1+ijpDjICU5NHy9+dRX5V9U7cgaBF
         /rEW0MaHcigkDbXj8e+iRCZQABZKQA/YHQdp2CPbLCG94EWRo+B+Bjdryu4FpAGMRvfK
         1KQA==
X-Gm-Message-State: APt69E3OVNaani/TdVVARYDJN7ZDOz+DGSCtQBO9oP6BjspmwnZoKvuf
        md7OBw5NoUuiZ9xhaYFCkRpH9Q==
X-Google-Smtp-Source: AAOMgpczZtIImgm0OlPZNIEBJaQtIGro/+OMSBkphkBGBHFCwia7EJW39RIeS4ZuhLrsV+vTjhUARg==
X-Received: by 2002:a1c:944e:: with SMTP id w75-v6mr596566wmd.105.1530685442198;
        Tue, 03 Jul 2018 23:24:02 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id c7-v6sm5394176wre.73.2018.07.03.23.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 23:24:01 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:23:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 1/6] MAINTAINERS: add at91 usart mfd driver
Message-ID: <20180704062359.GZ20176@dell>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-2-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625172230.29686-2-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Radu Pirea wrote:

> Added entry for at91 usart mfd driver.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
