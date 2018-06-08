Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XxcTGAXmGlsrWwAAmS7hNA
	; Fri, 08 Jun 2018 20:24:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 43E7D607E4; Fri,  8 Jun 2018 20:24:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvuvDfss"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A61BF60275;
	Fri,  8 Jun 2018 20:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A61BF60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeFHUYe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:24:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42183 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeFHUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:24:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id c10-v6so1256839pgu.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zb0NlS41FFxaZXKJxfK7CgpNQdgL7b5xDoN2IKLlHwc=;
        b=VvuvDfss2NLLKnuDt0wZb4OMBX5Pn17sW0JKaM2tOOITVjsXrF+CdyqbaCsr5r74j/
         QAAQeFzd2C7rQAIo/OtIkrTJRWS2AptcT151uWypNOQJsN5C6KBaOc7A/JBtnFPl6YjD
         EoE7qZvXiQNlqRPPiYf8xrgo5HM51nAfJjla4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zb0NlS41FFxaZXKJxfK7CgpNQdgL7b5xDoN2IKLlHwc=;
        b=mgj6jqmHReFwY8gpeZ+LTAHr8qojbQkzp2rbwCqznvTzHbNuopiJqmRw9JEffJLsBE
         zpLYwqdM/1Am7kJvUoOjTxFyxnBFWW43BfD+L67gwd5sGbP6qN2d/p8BhzkpbXEn1trv
         t258IdCwQw/SVTbXjySFiyGcPLXDCGB5tMyqf+tkypZofb1dzvGYkbplJbWQnfXBBXzV
         bRSluelcco1DQ3WrfmJtd4ppM336RJvdXBDJNM8NiqrT/cFLmOp7qk7deLdY8rdlYF1u
         yTJLAY+RKgk8aCZD66LxLAAWcWksIPdYhLGecvU8BqLLBGUG7RFN0ZDXEI08r6sOvZU0
         mZgw==
X-Gm-Message-State: APt69E1CBaQd3dadj1Mc5PmeoxIxK+0SaR1oGi90LSlTHH//V6uKt/FN
        80SBWl/62Z5w3agAteCWjrmOkw==
X-Google-Smtp-Source: ADUXVKKoTpL0ThVNOHrE3Z16K6D58ZGnGor2P6116KLoos79OsmEGW3cqwdc2pw0g72/79xA2TEAGA==
X-Received: by 2002:a65:498e:: with SMTP id r14-v6mr6323319pgs.78.1528489471807;
        Fri, 08 Jun 2018 13:24:31 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h27-v6sm87746987pfk.160.2018.06.08.13.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:24:30 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:24:28 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: [PATCH 06/20] coresight: Handle errors in finding input/output
 ports
Message-ID: <20180608202428.GE30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:17PM +0100, Suzuki K Poulose wrote:
> If we fail to find the input / output port for a LINK component
> while enabling a path, we should fail gracefully rather than
> assuming port "0".
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 69e9136..3c1c058 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -107,7 +107,7 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
>  	dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
>  		dev_name(&parent->dev), dev_name(&csdev->dev));
>  
> -	return 0;
> +	return -ENODEV;
>  }
>  
>  static int coresight_find_link_outport(struct coresight_device *csdev,
> @@ -125,7 +125,7 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>  	dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
>  		dev_name(&csdev->dev), dev_name(&child->dev));
>  
> -	return 0;
> +	return -ENODEV;
>  }
>  
>  static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
> @@ -178,6 +178,9 @@ static int coresight_enable_link(struct coresight_device *csdev,
>  	else
>  		refport = 0;
>  
> +	if (refport < 0)
> +		return refport;
> +
>  	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
>  		if (link_ops(csdev)->enable) {
>  			ret = link_ops(csdev)->enable(csdev, inport, outport);

Queued for the next rc - no need to resend.

Thanks,
Mathieu

> -- 
> 2.7.4
> 
