Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2A7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC6720875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC6720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeJFDj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:39:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37985 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:39:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id u197-v6so11456238oif.5;
        Fri, 05 Oct 2018 13:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CkGf5wPbkzH+vS8XlJqtwYTTlXEgJeIqSANdnaucbS8=;
        b=jJCLupPLYca/dLLULuK5gohJiCXmyMkx08OYdzTJN0R8UWc5JY+jvxWEuIgKA2OmhF
         LqVytTL1SALia17WaQBpU807PP6jAsp1SFl6e0Wlm4uBvF0KrYlUhdaKgfzTmnmoqGuh
         wyKArC/THkIWv5RimQtmroJ4Q/yGopw04OVR18nFOTK0VL7MorVx6gLQUmxRKgo7rJ5y
         fxY6yXt/+qpCYCxh4hfcp0e9l+2qQUQ+j/TpFojf0iDKbklgST5qDwtlHZZERdamsjCP
         ORBX7gsdh+858ttjIUEyAdh1gz334QkEUMzRUmzokJXLuFLoDecOFBIo/R/Z8jiBD5/V
         bH2g==
X-Gm-Message-State: ABuFfogkPVWmPTN7puNnJy5q/PCLAZ9Nbv1noGCjbiIr3FPOtouAh3pr
        lNRZsYRiVM6xL9FvgnbecA==
X-Google-Smtp-Source: ACcGV61wp/mP4pV+/lqEXLgdRNt88FJ+ZfOJRZ11Iy5h9LIMFlGS+hTAPd2GRLaVzK8xJx0B77njsg==
X-Received: by 2002:aca:e6c4:: with SMTP id d187-v6mr299340oih.237.1538771972110;
        Fri, 05 Oct 2018 13:39:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 14sm691458otk.49.2018.10.05.13.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:39:31 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:39:30 -0500
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
Subject: Re: [PATCH i2c-next v6 1/5] dt-bindings: i2c: Add 'timeout-ms' and
 '#retries' properties as common optional
Message-ID: <20181005203930.GA12987@bogus>
References: <20181004204322.20665-1-jae.hyun.yoo@linux.intel.com>
 <20181004204322.20665-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004204322.20665-2-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:43:18PM -0700, Jae Hyun Yoo wrote:
> This commit adds 'timeout-ms' and '#retries' properties as common
> optional properties that can be used for setting 'timeout' and
> 'retries' values of 'struct i2c_adapter'. With this patch, the bus
> timeout value and the master transfer retries count can be set
> through these properties at the registration time of an adapter.
> Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
> on cdev at runtime too.
> 
> These properties may not be supported by all drivers. However, if
> a driver wants to support one of them, it should adapt the
> bindings in this document.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
> index 11263982470e..6d7a6e919cf8 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
> @@ -80,6 +80,12 @@ wants to support one of the below features, it should adapt the bindings below.
>  	Names of map programmable addresses.
>  	It can contain any map needing another address than default one.
>  
> +- timeout-ms

bus-timeout-ms in case we have some other timeout needed.

> +	Bus timeout in milliseconds.
> +
> +- #retries
> +	Number of retries for master transfer.
> +
>  Binding may contain optional "interrupts" property, describing interrupts
>  used by the device. I2C core will assign "irq" interrupt (or the very first
>  interrupt if not using interrupt names) as primary interrupt for the slave.
> -- 
> 2.19.0
> 
