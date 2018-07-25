Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13469C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF932064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyD8GVhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF932064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeGYJOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:14:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35657 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbeGYJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:14:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so5028825wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tPGXO1H05yFO6anYT/j+3CB6rkDxIPDW9pjA0qsOa5E=;
        b=FyD8GVhfco+uWFsGtEkemxB7f6Tj6Wwf3X+aQ2pQ9U4OGUVxgK5Y9IMpVZOZho+4P3
         bCeCkQHv9faYuZ82U2/bOGZr0ClgQLhdvG+befX4raigyoRubBh6ElCJqHEiCWQ9CtEc
         TfW1/2ax5U4kneTCgW/ns7U+58H9xyKzpxniw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tPGXO1H05yFO6anYT/j+3CB6rkDxIPDW9pjA0qsOa5E=;
        b=UYv5GacmOER9y30gANnzSY3inET3EqMuS6feuck79aOiQTlvy4KnaKwPG3Ytem35mE
         sji/SD43D7aP4HCLmjBbGhEvnyYyv/cm5dmhsvX2Cb2JZzZKTsvopo2Kqbm0scth2Wv3
         aafAblU895szNdznFyRVUdbq3ymknRIyy9qaAD1YaVroOZJd1Wr5jmnWGqATTF44MmvI
         3szLiRAfwq6w+jUMhWOv9VX3SoROxTm0Hg2DYboiqleJYtcoYHd/8w9QMeEOLPbCW8Le
         yoO36jHCKw1qOEM0S1lgjFolyWmlYOtOVg/pP72q4HAjQbcrShLL/F6pfeB1b4HocHX5
         /w9Q==
X-Gm-Message-State: AOUpUlH3oq/jM64Vsr81v0/UGy400St2XUmbR1CXS8Tord8lD7WR2BzB
        gvT+qcPHjHBU4fLOfj5qQEQcZw==
X-Google-Smtp-Source: AAOMgpdTePTm/CkKd6hqfAgTK73Xm72W7apkzAqM/fiEMRgQkFVxZXZeegT9fdGDUNb3oo6TKdJeFg==
X-Received: by 2002:a1c:168a:: with SMTP id 132-v6mr4271257wmw.13.1532505838409;
        Wed, 25 Jul 2018 01:03:58 -0700 (PDT)
Received: from dell ([95.149.164.105])
        by smtp.gmail.com with ESMTPSA id l16-v6sm3079950wme.36.2018.07.25.01.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 01:03:57 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:03:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v4] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180725080355.GC5835@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180725073830.31421-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725073830.31421-1-daniel.thompson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Daniel Thompson wrote:

> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix with a simple initialize to zero.
> 
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between brightness-levels")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Notes:
>     v4:
>      - Remove line break from Fixes: and update the *-by:s
>     
>     v3:
>      - Switch to the simplest fix and zero the uninitialized variable. git
>        grep indicates that ~25% of calls to of_property_read_u32() use this
>        pattern (pre-initialize optional properties with sane values and
>        ignore the return code).
>     
>     v2:
>      - Simplify SoB chain (with Marcel's permission)
>      - Separate complex if statement and make other similar calls use same
>        return code checking approach
>      - Tidy up comment formatting and fix pre-existing grammar error
> 
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
