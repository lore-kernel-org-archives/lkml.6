Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34EEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6EA20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCRwkVSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6EA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeIJToJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:44:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51163 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeIJToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:44:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so21890259wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Zg+Bc9D6pdjVcNUuxFbL72qXTYGy3Rcy/0hzdZFwqOQ=;
        b=GCRwkVSlSR3rBrramBnvlK/60GHkeJgMMkRbcvTUVlVtce0HlXhEwtLIfW385j91VO
         uBa5OfG1ZJL2JLWoRnEGCV+wCgSnO6TwCiToTLzsQKvNfa/IcDegO73Sdb5CkejooBnK
         lxofpxZK2oSe7Y/S2f32Nusf6+/FMOotuOHb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zg+Bc9D6pdjVcNUuxFbL72qXTYGy3Rcy/0hzdZFwqOQ=;
        b=VSmRP5RAnWESPChmU4TrcwU8+64TXlKTupVwBml+vnTfpMOLTcTqFT1pIt7uCMI/Rk
         Vm0q0RA0VLy+PhgA2hc9PiyQ5761tyOwYXurG/yurXrAMO3joDE7ndAGFLHdKzacUn7u
         gTvEHLMlH9KyUWCGzto5WACTOiCDsp8/iv5ivJdtj66mabsEmijUhuPIrRWDs10x/Vd0
         XfN1/xT8Sogq+e1eF57NqnckzItEvv2VqCPP42R0Iq/tePgVBGRELQRmzE9xrVdEIFCt
         6j1H1BMyoMd6p8G2rIjXbitMizGNfC+Ri2mvVte52Ltr1bdyPZKGFsURCHhJYmFD12pT
         yMQg==
X-Gm-Message-State: APzg51ApvwKjzSuZZQQiOZR8ieh3xKZQBSOtTIpemb7tREBL8aY7DnzY
        jTVLuiAstRkRiNeIR7JM3mlA3g==
X-Google-Smtp-Source: ANB0VdaXnLY69iglC24NBZO5v+DFOff3YBbKXsuUer6uPtwbawyVP0H42uxf3+BESwIGa9U+2BBbGw==
X-Received: by 2002:a1c:4007:: with SMTP id n7-v6mr992223wma.108.1536590967381;
        Mon, 10 Sep 2018 07:49:27 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id k63-v6sm19811089wmd.46.2018.09.10.07.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 07:49:26 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:49:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        cl@rock-chips.com, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v3] backlight: pwm_bl: switch to using "atomic" PWM API
Message-ID: <20180910144924.GU28860@dell>
References: <20180814165059.13219-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814165059.13219-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018, Enric Balletbo i Serra wrote:

> The "atomic" API allows us to configure PWM period and duty_cycle and
> enable it in one call.
> 
> The patch also moves the pwm_init_state just before any use of the
> pwm_state struct, this fixes a potential bug where pwm_get_state
> can be called before pwm_init_state.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Get rid of duty_cycle variable from pwm_backlight_update_status.
> - Get rid of pb->enabled and use only the status.enabled variable.
> - Make power_on match power_off.
> - Do not share status between ...update_status and ...power_on
> 
> Changes in v2:
> - Do not force the PWM be off in the first call to pwm_apply_state.
> - Delayed applying the state until we know what the period is.
> - Removed pb->period as after the conversion is not needed.
> 
>  drivers/video/backlight/pwm_bl.c | 81 +++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 39 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
