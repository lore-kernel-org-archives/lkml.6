Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id b071NNnbGlsMaQAAmS7hNA
	; Fri, 08 Jun 2018 19:42:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1BC4D607DC; Fri,  8 Jun 2018 19:42:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViGleT4I"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6FC01601B4;
	Fri,  8 Jun 2018 19:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FC01601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeFHTl7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:41:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38303 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeFHTl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:41:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so8863010pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UR7KbOUKA/peOuihPEStJnc+wUD2fdNJJ0UAMknIjdE=;
        b=ViGleT4INd+NXRfG2UMzAzY1oHBC7J/HJZhCP+L5cBL7esoOD/awL9kDfGhx9wD5Bt
         jtXN4qZar904nDvI2xk0uwpMRb+GGtnuIjOzrxDnOJuaSN5uJo4fyM3yLBkK54lg5zL0
         CFDhblSCbXAaIAIgAYBHYjv+FHuYAsH2kK/S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UR7KbOUKA/peOuihPEStJnc+wUD2fdNJJ0UAMknIjdE=;
        b=a5+aSzQo7ihfg8C7/jKgJ2K+4jp9RSZnyIZTES5LDTjVbTL0GHKhPdAOy0FJWs05Rf
         YnfO48d8FHahQtYhlZThfCqjJZiWzLnGV5qyUFjeZQrGEjAlhgpbQeaFj2PtoZZ8wIVC
         PVdFkuH9n2H+yeLu2p+5hp7Ek2UVU3bvcq8V/9hf1L5k/dgtEGCwfS1sAmfGBSp5zBq8
         o8pM0zMwQIlBfp5PYA6ZxmkvaVbOavQNdIwHQ8E9qcBjhoRnJKAdPz5wl/BQIRbh131S
         Z+rgJxlqRiORn7H0wy5JzAr5ZMRSbKrjSNOgvP/NuSdmN/nFeE5HUWa6p2uq1RzuWEoF
         RKxg==
X-Gm-Message-State: APt69E2MWkeKNgc8csYARz2q/xE1EEs3BkU0BXaKR26B2iyp+KlFwSGZ
        LSe98YC+3fW0TodPHOi/3pJxHQ==
X-Google-Smtp-Source: ADUXVKIa0OznUPLZGqgTAdlGT62gwiTj1m2EEtZrOCyUpXOHC72lxopIfs714kyJY58N88ORDF8gBg==
X-Received: by 2002:a17:902:728a:: with SMTP id d10-v6mr8038675pll.192.1528486916883;
        Fri, 08 Jun 2018 12:41:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n25-v6sm16138340pff.119.2018.06.08.12.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 12:41:55 -0700 (PDT)
Date: Fri, 8 Jun 2018 13:41:53 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: [PATCH 04/20] coresight: Cleanup platform description data
Message-ID: <20180608194153.GA30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-5-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-5-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:15PM +0100, Suzuki K Poulose wrote:
> Nobody uses the "clk" field in struct coresight_platform_data.
> Remove it.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  include/linux/coresight.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index e5421b8..69a5c9f 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -87,7 +87,6 @@ struct coresight_dev_subtype {
>   * @child_ports:child component port number the current component is
>  		connected  to.
>   * @nr_outport:	number of output ports for this component.
> - * @clk:	The clock this component is associated to.
>   */
>  struct coresight_platform_data {
>  	int cpu;
> @@ -97,7 +96,6 @@ struct coresight_platform_data {
>  	const char **child_names;
>  	int *child_ports;
>  	int nr_outport;
> -	struct clk *clk;
>  };

I'm going to queue this up for the next rc.  No need to send it as part of
another revision.

Thanks,
Mathieu

>  
>  /**
> -- 
> 2.7.4
> 
