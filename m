Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6CFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481F92087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfUN/cy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbfAGRbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:31:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34864 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAGRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:31:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so498310pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y4nDVmZs/kn4rKsnx9mXGTFn5KmIxkdS54kk8CRo0nU=;
        b=VfUN/cy5kRyqgJYzi8mAY9GD7JREnEmz4Lqg2pAUSXhRshKY1JF9GfsyBbLc/j/jT0
         W7bF6kADXMd/lBkOGt4I2n4lhWN8SHMQhhL4EVgXrp/Vuv0WZwRM345tv+4Q+CnbCDun
         NOcumtqJ4mH7aowWPeEHqe06RFcXomOtANixY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4nDVmZs/kn4rKsnx9mXGTFn5KmIxkdS54kk8CRo0nU=;
        b=KvkJGAwNCJrl3/zsziDgM4U54AOpqfX/tJLcSdkxxZYvaOQKxRJjj4CV1ANvwfs4si
         5dSFepdC2K1dkTilt/4e7NChh1WD1aUayuNEU5QbnLwTKTEsfX21Z1fqiILSbZw/BCMW
         L/ZyagaZ8AKLfR+ir7jFZkkWCWEX6RhDKea2kg1s1nqWiSMPcvxsbl7pyYyVlJl9Elo4
         9OYW2J07lvhJpbNzGQ5b8Y5xFMcVv6ccHPme8QN6a+RN9n+/HOZsmO6axkwqWEyR+eaC
         Lfp7w4QgWog/sL8dULPvj19C2h1N9RyzbPkZqLaFT/wSuSqDJK1E1K4IjbvQtfmIi894
         SEnQ==
X-Gm-Message-State: AJcUukdITi6nDoREceAuKAccAKwPCjopX1cMs/bov3IlmKvBhAtiYJA/
        X6kQPrF4ZrVRoJpkbv1XfwYgTA==
X-Google-Smtp-Source: ALg8bN5CNSFopfbQMxfF8nAtFM8EcnsT+5M+aF4xp79bKV3aqjoQTSA6P47y13rsMCjrtJBTn5K8sg==
X-Received: by 2002:a65:6542:: with SMTP id a2mr11594009pgw.389.1546882260969;
        Mon, 07 Jan 2019 09:31:00 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y29sm87580147pga.59.2019.01.07.09.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:31:00 -0800 (PST)
Date:   Mon, 7 Jan 2019 09:30:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        "open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rpmsg: core: Make remove handler for rpmsg driver
 optional.
Message-ID: <20190107173003.GL31596@builder>
References: <20190107113833.243672-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107113833.243672-1-pihsun@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Jan 03:38 PST 2019, Pi-Hsun Shih wrote:

> Most other bus (for example, SPI, i2c) have the remove handler for
> driver optional. Make remove handler for rpmsg driver optional too.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Thanks Pi-Hsun, applied.

Regards,
Bjorn

> ---
>  drivers/rpmsg/rpmsg_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 8122807db38094..ea88fd4e2a6ecf 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -493,7 +493,8 @@ static int rpmsg_dev_remove(struct device *dev)
>  	if (rpdev->ops->announce_destroy)
>  		err = rpdev->ops->announce_destroy(rpdev);
>  
> -	rpdrv->remove(rpdev);
> +	if (rpdrv->remove)
> +		rpdrv->remove(rpdev);
>  
>  	dev_pm_domain_detach(dev, true);
>  
> -- 
> 2.20.1.97.g81188d93c3-goog
> 
