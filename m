Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAF7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B07620870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ch5BgmXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B07620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeIJUdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:33:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52849 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeIJUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:33:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so21888768wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PAVofr0JXjgeA2OcxKQtOm7dSC4KXWRPynlQdHnEfUI=;
        b=Ch5BgmXzd0B9tEu8n0krFZ2c6J7fwZIEF0qfHg8o7u46dKdt2rk99KFumAK2TG6NH/
         CLkQKZQT9pDg852NLb0EHVOCeeEJ9q8GHjbwfZGNzfWjvMnSwNRqCLJ8Cd2BYwcUV8oN
         Jtu1CYdii3Nm/mlGItK0tYHuBgf01MrB+szpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PAVofr0JXjgeA2OcxKQtOm7dSC4KXWRPynlQdHnEfUI=;
        b=YSxTTbzVinzlMtpojPSTRHbkYGLjaXBfyo2H3Os6TFoPLafqw9UAjRxSPrtZz5f0pT
         F190+79BKv4ALQGiRPZigv7FEUUWmS7K7A7AptgqmXSE9Ad6WNXfco52q4MHO0w0ikNt
         VvbgjYFgPvqpU/ITHPhyKdi+69KA0DqCJIVLzhD3M/cK6nhBCXlpjK3TO5duh3eDH4Ul
         yX47zBZp5WdEKkQBtu+aecnINTBNB15esZ5bY3XKWSZhNBVU/ay2rKaBJhBke828umJp
         dT/fpboShTPakh8U71GcCsdpXI8rIlelsGUdbrde3CO6jVXvPgVdlIy+sewONY2HiBe1
         V2gg==
X-Gm-Message-State: APzg51ARv5ck5c5Jnu6UoLVS3G5q0a7jFO1USzh+boiNrZlT0fQBoR5p
        JqmvGH7TsDdMpXiN6cvmPw9bWw==
X-Google-Smtp-Source: ANB0Vdanw9LeaxKSMZPI1apeKYGAni2j2FpVrwtUr5713vTUDS2ezJF5uD9gqncpzfuUB33F9tabiQ==
X-Received: by 2002:a7b:c017:: with SMTP id c23-v6mr1170511wmb.136.1536593938805;
        Mon, 10 Sep 2018 08:38:58 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id f17-v6sm19670885wrs.1.2018.09.10.08.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:38:58 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:38:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: [PATCH] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180910153856.GC28860@dell>
References: <20180829093104.GA22065@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180829093104.GA22065@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Pavel Machek wrote:

> From: Sebastian Reichel <sre@kernel.org>
>     
> Add support for the audio-codec node by converting from
> devm_of_platform_populate() to devm_mfd_add_devices().
>    
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
