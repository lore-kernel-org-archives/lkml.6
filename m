Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06089C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A812159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A812159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeI1DQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:16:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37520 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:16:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so2555831oib.4;
        Thu, 27 Sep 2018 13:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9AAgp1aJCtiE2iLY0ITsG/CFSqTHj/NZRI7o5wIkE0=;
        b=NMwHztak7WflvhQD4YB53B67gXxBuKIvn0f3oXKZayy94ryqjZPWJEP8lTkNhPu1wC
         2XbEY/qhHHzQnsAIFpvo3GwA4uOJ559pvCe0KcLyiOwiZF1qMZRY17NFeikgJm+GrScm
         nVi2lDsqktTAX/CWF23AvG+Lzf/FxRBsqmMPzIkcWL1OHKye8+gDvAzEEo3Lwy5q+Svc
         hIlv5J+xVv4yc819z1S8lPOMMV/enSzuglpst29UqWbvnSYGnziQkaY+szUBnksbwCpV
         d0C+NCxONc60/hM275vCjZSpVPxJLS/z7e+symwm3Kd9DGfukeAmBX1D4snpQPvw+gSX
         0S7w==
X-Gm-Message-State: ABuFfoiNy0uRR3Udue2XaNu4zFOST0ddysZmLTvnaYWwOIHMWM40UvQ3
        0lE8T1annlaKPW2uzPDp0g==
X-Google-Smtp-Source: ACcGV61YOWnQaCv31JfgfMNgpRP15DW5Bok1sGEErY1wVBO2irIPDRnyxzlrfpAU48HlhOsGSPV2uA==
X-Received: by 2002:aca:3946:: with SMTP id g67-v6mr4294416oia.145.1538081772272;
        Thu, 27 Sep 2018 13:56:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y131-v6sm553144oie.25.2018.09.27.13.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:56:11 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:56:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH i2c-next v3 1/3] dt-bindings: i2c: aspeed: Add 'timeout'
 property as an optional property
Message-ID: <20180927205610.GA29022@bogus>
References: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
 <20180926215842.23125-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926215842.23125-2-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 02:58:40PM -0700, Jae Hyun Yoo wrote:
> This commit adds 'aspeed,timeout' property as an optional property
> which can be used for setting 'timeout' value of
> 'struct i2c_adapter'. With this patch, the timeout value can be
> set through an I2C_TIMEOUT ioctl on cdev, or through this optional
> DT property.

Isn't controlling this from userspace or relying on a default 
sufficient?  I can't see this needing to be highly tuned for each 
platform.

However, if we do have a property, it should be common.

> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> index 8fbd8633a387..d6965b360fbc 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -17,6 +17,9 @@ Optional Properties:
>  		  specified
>  - multi-master	: states that there is another master active on this bus.
>  
> +- aspeed,timeout : I2C bus timeout in microseconds defaults to 5 seconds when
> +		   not specified.
> +
>  Example:
>  
>  i2c {
> -- 
> 2.19.0
> 
