Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE50720821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvYzAd7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfBEI1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:27:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35564 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEI1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:27:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so1184349plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3dAd757oK9DJ6817+XFjlVmTe/i0/VmoSVVwNsgUheY=;
        b=dvYzAd7SgoIM7wKZsHUm5am5HAwq8kjSuGZjTfSu/V9xoKns/DY84ioQOp2d6dQAWW
         GXRW3bkeiHsTK389IpASsHxULP4mIE+wHi9Hj6qplp2ha4sTf6gwuDXYRIwz1GKYPH1s
         0G+f0aSIsEGYTEzrLAWxN54c0f5TWAgkJPXOiOEzHACvjWbRJaK/zVbJk4VBpa7xqov/
         9L9+ef14QATrtx+jc0dTP0g/odBWUEM1KEr8G+TplnQvxv4BISzV4ot5nTXoG79gCCYT
         Ik9/ySGPqtCaHkrJOAU4tsA56btXZOWbX+Ld03xMe91LRxn38ptHkEBPdb0MGRtDOvO0
         6HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3dAd757oK9DJ6817+XFjlVmTe/i0/VmoSVVwNsgUheY=;
        b=HDF/0jYAKy5f/zB1uG5QnD97YXH0Os88FAojstGz8Nokyr2s/62D+0VGhoTkAgpYev
         YRAJp8BLDYU86o/MmheF/GNqwh3qATbB1rF8XQbQesCYGSGX5aOVhPSBm03MjSBMDFir
         N2tf1knZmFz5p309+AaJw2RpEMwNQLodFFBgMaqvdPhO+owf1n7gffEfu4xUjewjE2DK
         UfO6x/zGKo7bMmeW2a4cTl1X6XFhIgn5gXoDdBVdiVu6ppoMgPKI6aPN7UhRAR3N+03V
         /1PZcOFSom3idRFBqqDGDjsfCpAg0EDtSEKujQYGPIYpqWkK9wjTo+soQBCWC3/EzekV
         HZuQ==
X-Gm-Message-State: AHQUAuZf3HhHDvLSV1LXMZSNgwvPS1J4vz0D9Xwmgs/tuvqIjvN3zTgC
        +ApJJWjfbG8rb0DJb58IE7M=
X-Google-Smtp-Source: AHgI3Ibjw3eI9nFqrD+ROqxd3qmsQZbp1E+/c2T68ORnFAaBMWSIr1C2w6/WamBZEyHVQd/yX71lSg==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr3859199plo.64.1549355250001;
        Tue, 05 Feb 2019 00:27:30 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w5sm2858086pfn.89.2019.02.05.00.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 00:27:29 -0800 (PST)
Date:   Tue, 5 Feb 2019 00:27:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1 2/3] max17042_battery: fix potential user-after-free on
 module unload
Message-ID: <20190205082727.GB118684@dtor-ws>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-3-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204220952.30761-3-TheSven73@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:09:51PM -0500, Sven Van Asbroeck wrote:
> The work which is scheduled on a POR boot is potentially left
> pending or running until after the driver module is unloaded.
> 
> Fix by using resource-controlled version of INIT_WORK().
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> ---
>  drivers/power/supply/max17042_battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 2a8d75e5e930..a61e2b81f68a 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1100,7 +1100,10 @@ static int max17042_probe(struct i2c_client *client,
>  
>  	regmap_read(chip->regmap, MAX17042_STATUS, &val);
>  	if (val & STATUS_POR_BIT) {
> -		INIT_WORK(&chip->work, max17042_init_worker);
> +		ret = devm_init_work(&client->dev, &chip->work,
> +				max17042_init_worker);
> +		if (ret)
> +			return ret;
>  		schedule_work(&chip->work);

Are there many more instances of this? I am unsure if we need
devm_init_work() when we can easily do the same in remove() call.

Thanks.

-- 
Dmitry
