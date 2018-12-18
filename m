Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C66A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCZlcvoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeLRI16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:27:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRI15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:27:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so1680416wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AsXRuswQIYGGQFk2zXN+QwtHyBah43uCOT8zd+13vr4=;
        b=cCZlcvoN2/JOsUFOxX1Vbwm7lb2VBrbKUvIcEEomSHDwaP9LP8okYFJtu4vaVsCOhI
         Gi3Gqitn09N4PdX5I+T7MgsoNJgJSg6ZkJcOyxDngdm6gMQCte13QANK7BIiR1EOiwF/
         rLmSZ6io8E6bNOHfhw+XLnqNhIfY+tt4Lg/cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AsXRuswQIYGGQFk2zXN+QwtHyBah43uCOT8zd+13vr4=;
        b=A1lTwjiJHty1DeGsUvLIYsmlymJqeIXBMY3xwWIjO9brDTQdiFhnA46g+DbMwVw6W6
         ElwlQyHKqGcsYx04c0AJ74uC+amxX0Fcm72v5sQULC96Rbf8BBU+7yWILKLUd56DLB9i
         f50icq8ug5vcHq36Mr3su3U64YaAbAbl9NjkAj7GTCI06oemwAuVFrvhw9plEKJzibeY
         3SVj4twBfSu8pibUftUWFPSAiYSernALuGpzvGZ2p1hciqaYrJsOQjtW9/NlsYN60VKm
         f/OAo4HMNwyx1wMSg6B82fgY6CEGZXJOvoq1g+QVId2s060+MiyvNuUhJ0KMs8XR9Y0z
         DlFA==
X-Gm-Message-State: AA+aEWa/39hk5WdVaqHbCj864Tw50xDJJuA2XXErihgoacgRqtbrsbpv
        etVLT7DK3SWHKvABT1Zue2CmLg==
X-Google-Smtp-Source: AFSGD/XM5N5wlHAd5/NVwcnSIbr6eOmbXdQciZXBxfQTAV0cuJ/FeYPQD9kHMPwZ0D4KbSpMrZ8jtA==
X-Received: by 2002:a1c:5892:: with SMTP id m140mr2195712wmb.60.1545121675986;
        Tue, 18 Dec 2018 00:27:55 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id o82sm1330561wmo.29.2018.12.18.00.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 00:27:55 -0800 (PST)
Date:   Tue, 18 Dec 2018 08:27:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/19] mailbox: sti: Use device-managed registration
 API
Message-ID: <20181218082753.GF4497@dell>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-11-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217150217.32435-11-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Thierry Reding wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mailbox/mailbox-sti.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
