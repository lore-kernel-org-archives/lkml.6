Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C894CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1AB26EE5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqFA8c4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1AB26EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeFZUvn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:51:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45192 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934010AbeFZUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:51:41 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1-v6so8130478pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k0OcJZAZADY88xBSPsJL4U+192O8aLihynuqf9eZToM=;
        b=PqFA8c4xCvuglke1ib8XIo8mNuJU7VtU8P8vsEgp5WJHtFLsDv2287cIqxmTSB+BVv
         wseOlb06vygnJayznO9oVpngWdWN4qnPfGYQSsFJRWuMtfInzuxfrWEDxm3A5u9Bynz0
         OTLVgH1GS5R3hd+kOOhrWe8lHuyuv+g54tnAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k0OcJZAZADY88xBSPsJL4U+192O8aLihynuqf9eZToM=;
        b=mSyt2id/ofWsVeSdATwCA+8cvE2ArkQsf03/LFIohDrSnJ3lcBjUBvX4GsMCaBCoBv
         WHlq3GfEtJx91Yw9GSDMOv7uanmqAcX62KNrxKzFqBXYNNki5Q6HHy0ThmJwb3iFCvo5
         BGJmOgOZNU8368NN5EafgKTTASvKsgqisL8t6kt8nO6ckyBPG18Yv7NkZgzisg7NONsd
         lLiFj9nXgnp7JKDNcTf0a0k8cGPENXFsh9ZbeOJJvkp8d5F59nzv8ni0A15dWvY9m0ns
         9LLYzUisgm9eGI4sZwtvrhvr5H9uhO0CVJ2EH0UoGyAWxX/SJWYTqTNxLTrXZHyUaKic
         8ouA==
X-Gm-Message-State: APt69E2LW0RXnjn5axshgc7IWRumUX/2xYyMEtSfLMKBS5bpr0LD8Osq
        L5GL2Ru2y9PWTmI0wu672BZ7Ng==
X-Google-Smtp-Source: AAOMgpdrFesCoToO2yNq57024YgYTVtZoP+UXlBP0jXPnI0JG2KEz9Ziw/EvAqoyNB2sNzW/ggq5Fg==
X-Received: by 2002:a62:a6dd:: with SMTP id r90-v6mr3013976pfl.60.1530046300945;
        Tue, 26 Jun 2018 13:51:40 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u67-v6sm106075pfg.63.2018.06.26.13.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:51:40 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:51:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     ohad@wizery.com, broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] hwspinlock: sprd: Use devm_hwspin_lock_register()
Message-ID: <20180626205138.GF3206@builder>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
 <e5f5f315a882fe5cdd161c8cb1790c9f3de0920a.1529654288.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5f5f315a882fe5cdd161c8cb1790c9f3de0920a.1529654288.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Jun 01:09 PDT 2018, Baolin Wang wrote:

> Use devm_hwspin_lock_register() to register the hwlock controller to
> avoid unregistering the device explicitly.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/hwspinlock/sprd_hwspinlock.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
> index dc42bf5..ba5daf6 100644
> --- a/drivers/hwspinlock/sprd_hwspinlock.c
> +++ b/drivers/hwspinlock/sprd_hwspinlock.c
> @@ -120,8 +120,9 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, sprd_hwlock);
>  	pm_runtime_enable(&pdev->dev);
>  
> -	ret = hwspin_lock_register(&sprd_hwlock->bank, &pdev->dev,
> -				   &sprd_hwspinlock_ops, 0, SPRD_HWLOCKS_NUM);
> +	ret = devm_hwspin_lock_register(&pdev->dev, &sprd_hwlock->bank,
> +					&sprd_hwspinlock_ops, 0,
> +					SPRD_HWLOCKS_NUM);
>  	if (ret) {
>  		pm_runtime_disable(&pdev->dev);
>  		clk_disable_unprepare(sprd_hwlock->clk);
> @@ -135,7 +136,6 @@ static int sprd_hwspinlock_remove(struct platform_device *pdev)
>  {
>  	struct sprd_hwspinlock_dev *sprd_hwlock = platform_get_drvdata(pdev);
>  
> -	hwspin_lock_unregister(&sprd_hwlock->bank);

Until the hwspinlock is unregistered it's possible for clients to issue
operations on it, so disabling power and clocks before that seems bad.

Regards,
Bjorn

>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(sprd_hwlock->clk);
>  	return 0;
> -- 
> 1.7.9.5
> 
