Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE0C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B253F2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5bfLM8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B253F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLGQks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:40:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46184 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeLGQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:40:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so4358397wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0S+N6XO0NSZ7wv+BOTf/5P2MlBdfSNlts/jfDT2XT2c=;
        b=X5bfLM8QiKBj9TElLojRnSNCiUBK8XJq8+wFn9ctJ5Geqh9Kwv+ABWskn6leZb7f4o
         g12RLlvZ04iaeNep6WyZvmcSFGLp3UCjVB8+jzpNKyrpOIrXjBNXjYke7Sq2FTdL/9li
         G603o4ktQAxLpuxFGPBTkMMz8scFAPRXq1zso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0S+N6XO0NSZ7wv+BOTf/5P2MlBdfSNlts/jfDT2XT2c=;
        b=bo/en39JFT5BEQgnu2XWKMqodBO4p4VWmkAQ9sZPf8sGBTMwYfATpqLJ6p3+t4/Md1
         oZjjxg+9DllUsc6+s8+lMYgd6xk5dSD5GW/QhYu5sZwJpHjrMOlYd3MQuh5V9/Y+boXC
         lKuwGXUXEK3LaZGytvOabBVgXLuj1/VMXeUV66Jcv4T0Njn1xdgmxWMGdNJlQch6vLdH
         OPnJ6RWj7W+/HfHk301Zb/ZdoJirpc/2ZsDVhykSXmgcRwqV+29ZTP2em8vYcx5dIYdG
         8VY7xAavPKprLDm4y/KeUh5oTTHprKjnAPTkG/oBB6lbuUmHcEPeTOP/Ki45hX8R5Yj0
         q0IQ==
X-Gm-Message-State: AA+aEWZL3w76P0o1F/6Biq5KrS7s9DlAn4u9UKnnZhMfggPEgX7ghVOJ
        6QBcN0pae0hYKcdcUQIdPb6TfA==
X-Google-Smtp-Source: AFSGD/VAD7+Ju+1VzEyiCIkPqo+/RTkAGef0t5aan2oLb6iPlPnYt34baXM5DgCZlXYGQmjMsF2dZw==
X-Received: by 2002:adf:9467:: with SMTP id 94mr2361113wrq.305.1544200846726;
        Fri, 07 Dec 2018 08:40:46 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id e16sm5365720wrn.72.2018.12.07.08.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 08:40:46 -0800 (PST)
Date:   Fri, 7 Dec 2018 16:40:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 7/8] mfd: axp20x: Add AC power supply cell for AXP813
Message-ID: <20181207164044.GJ26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-8-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120175211.3913-8-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Oskari Lemmela wrote:

> As axp20x-ac-power-supply now supports AXP813, add a cell for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
