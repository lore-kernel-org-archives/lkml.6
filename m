Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DAEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2952196F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BitkmFaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfBQFfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 00:35:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42995 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBQFfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 00:35:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so1096811pgl.9;
        Sat, 16 Feb 2019 21:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1YaAA4x2iE7iO4L85+fa3yu0FOa2paoXC3q/RIVCTm0=;
        b=BitkmFaU4hUsNv77cLkvboqzx8akO5t+Q93h/UVBx2gMxAqIU/y8nU6RZPNt7aqoDC
         CdHOZMAxdGGGRi4eOM88Hc3pUzfGuqAmRN90MrZsgQUfJRBMAXdACXA5Z6u2nAipFyAi
         0kBgScCKMxe/5l2vs+alkaIU7Cn2Mvk4IzoZJimNc4ewWX8BF9xe5yjMjQD1nU5CBKXX
         W8p/ds0cB0Q44TTDYX+yEGK/k1up+2GYmho9kp/1m7GEMQboqj25Mz5nKKRAs5UxnDPd
         6AAbidPz8mwtE5wZvfN06hrfxCW+NZu2O08Np3yVf4XKh6Xk5cm8eYJhS8hGFnDKK0Ei
         bBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1YaAA4x2iE7iO4L85+fa3yu0FOa2paoXC3q/RIVCTm0=;
        b=ZQ1JVRNdbAGSk9L6pRmVlMcvdXhTZEveMFgVzw0dVLlvpIjjNOMx/SRt9ik+0yhmCN
         nAWne8/Yc0b6XuKilDkrVZW8EB2TZiFdx79XSas5AcPuZYav+ju8qav1s39JGW9/2wgC
         RjVSWozoRnTCw17/gAUfiSpc18Vjnns5CBDN8KG42McFn9ZNMWTIjxA4ndFP59YiXb+p
         RQVXFYstHn2/j/TaLyfkp4BrfkLikvFRzvED7uqVJGb11QGGwc1l4HBhym3I4QfZPrKE
         dKGjtZbx69JZNZL7uO71pG/ZQl+dPRH3A0N/PPHEx7Jfgc75kMbbnsRf8CfPFJq90yWN
         wMVQ==
X-Gm-Message-State: AHQUAubyWsAUOG/JXWMxgHfD7nrsxwfCnBFNUKsRnXCQbZdsNEXk7mMm
        uTn2FGXSEy2YVR9ySOM9LvgVYdM9
X-Google-Smtp-Source: AHgI3Ib0TIrjdLo9bXeKuYrpD4DspPFn380cp6P/k+qot65V25pgUvv9JuvXsKvhLcmzMSVnAoUxCg==
X-Received: by 2002:a62:bd13:: with SMTP id a19mr17817478pff.222.1550381705955;
        Sat, 16 Feb 2019 21:35:05 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w11sm12271838pgt.9.2019.02.16.21.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 21:35:04 -0800 (PST)
Date:   Sat, 16 Feb 2019 21:35:03 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     kuninori.morimoto.gx@renesas.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: st1232 - include gpio/consumer.h header for
 gpiod_set_value_cansleep()
Message-ID: <20190217053503.GC107793@dtor-ws>
References: <201902131841.xHSZ8Cvm%fengguang.wu@intel.com>
 <20190213111958.9031-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213111958.9031-1-martink@posteo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 12:19:58PM +0100, Martin Kepplinger wrote:
> gpiod_set_value_cansleep() needs it's declaration in the corresponding
> header. This fixes build errors like
> 
>    drivers/input/touchscreen/st1232.c: In function 'st1232_ts_power':
> >> drivers/input/touchscreen/st1232.c:146:3: error: implicit declaration of
>    function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'?
>    [-Werror=implicit-function-declaration]
>       gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
>       ^~~~~~~~~~~~~~~~~~~~~~~~
>       gpio_set_value_cansleep
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Thanks Martin, I'll fold it into the original patch introducing gpiod so
we keep bisectability.

-- 
Dmitry
