Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEDCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E742445F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ix3hEgQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E742445F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933668AbeGDHiQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:38:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44706 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932467AbeGDHiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:38:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id r16-v6so1118589wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HHIieImgxFqCIyuA/Oe1wBZVOwAAei7FMDj8umpeeBo=;
        b=Ix3hEgQb1LyEyorQ3ZttDk/4e/lkdpI4T5JLjql7AYrgH9MnEuAxFMvURVtU26GfjG
         4W738dzzb2ySJg+ZsqKx/pN0/u8MewnwGQkogKOitA9rv1oaEDPvpnnq7cb4Xmqr8c8u
         M9/A24iy5rZlwsbWztrs2HbkRQhkPbz16d5Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HHIieImgxFqCIyuA/Oe1wBZVOwAAei7FMDj8umpeeBo=;
        b=KhQyM8wCidoSPBnVKTRaczv7C+f9SVa+KY1JimdLe0LsMjDfkUpnLcIO/oNP99PVug
         lHzlD0yUa5Kh6Qs90e+iJxjqByyg6h7CuWT71L8EpK2JLUqRxvWP3/xFi7VzgJOCl01H
         Z7cbAKid/5lln3KUpiNMTu+mlyIRYvNmIH/1RohOsdcGImBryT2Pd2JpvUABftLKqDs5
         dh1OzCgsj3eZ8UxdW489ackMYV7bXSchgXOZgKso0eoLijXUA5C66yvZJ8cDOyIzxfSA
         7NdhyDF5xMMDExtkc0C0ugVuglvl3syJqIu1JwgWfcYySpeK4HaaQ/jFiywsrFUgEo9I
         lHEA==
X-Gm-Message-State: APt69E19cStpsrviJRRAsVldkB8hD4OYti69WY2HM/sRq0/DVhtMAmI/
        gZemiz5pPge0Nxl3kGj7Kdi+ww==
X-Google-Smtp-Source: AAOMgpcJRucYATYwbeck2TeIZZ704ZW7sz8x8UVUq3tJDK4EADWHvOoTdifsbI/6OM2qLE/N6MbrOA==
X-Received: by 2002:adf:b0a3:: with SMTP id i32-v6mr688592wra.213.1530689892891;
        Wed, 04 Jul 2018 00:38:12 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id 39-v6sm5722347wrv.79.2018.07.04.00.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:38:12 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:38:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/5] mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as
 wakeup capable
Message-ID: <20180704073810.GL20176@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630103318.25355-2-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Currently tscadc MFD is marked as wakeup capable which incorrect
> because, its actually touch event by child TSC device that wakes up the
> system. Therefore, remove device_init_wakeup() call that marks TSCADC
> device as wakeup capable in favor of moving to mark TSC input device as
> wakeup capable later.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 1 -
>  1 file changed, 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
