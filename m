Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB114C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2B42177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520765;
	bh=QKddjZxMgtM+vjAG0QPLm0BK11D/62GXzu/29im9WC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QZdSeYBPoag4dtrcYvK8AEAChIIv4QCBb0bqHRu8f2aadpmwh8uhXG7vrpB3ASvIW
	 oNu40DfRobycFmZM/4orfKJU+JyzDFC270RAdykevpeVZAAsC5JG1Na4/UWM8Y5e90
	 eWXZJr766aiIys/axOxhiCqmX93RNMxwNQQc3ohE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfBRUMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:12:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34033 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfBRUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:12:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so30477916oty.1;
        Mon, 18 Feb 2019 12:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAoPARZqeTIrtTwyaGqgW3QnqDwsKNMVTjCfdIpNMIM=;
        b=ad+Yr3UPhKQeU9ZOgn+5vaBeokYAhJ+PpvBDjrajXyI/maX4fc6BqTTXC7sHRhq22+
         tWfB7Y7ug70Fsqg9SsOnaw2paFnUpgsyVPg56Kr07a3cTDfvtrXYMhr08a/4wbw0mOas
         NyjA9ppoHr4w9YWqINteErYtroTXNOtfEHGf9USbpzZaf6uyVL5whbSjF8JiVjXhpWnp
         +cfpD+3u6yis54Yksv5tTePZH4Lf5RnBWPxGDbhqFXiFbJwdG7aTjkPBoBbLB5POPeDK
         7MNrJkRG6g9HikyZTDZlWeBj6c8Mah5OJSNAo95+g7B2Exua/OP1h8xoaL4nJ2aoS92/
         LB3g==
X-Gm-Message-State: AHQUAuZXA5+eRljt36GAk5PFQDhuTmJv48cnDONEGIPn0ZF3MSGIy7Ga
        k6xaafkxKjmnB52FPwZpgxzxlHo=
X-Google-Smtp-Source: AHgI3IZwdI3/sRYC2fDFRTosd0gNF4kHlyMGvmjq84ZMLuF+lussNFQnb6BF5JEvlxykHWwIaQkZsA==
X-Received: by 2002:aca:30c2:: with SMTP id w185mr360128oiw.163.1550520761588;
        Mon, 18 Feb 2019 12:12:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w18sm4408084otp.70.2019.02.18.12.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:12:40 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:12:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, ulf.hansson@linaro.org,
        mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com,
        zhang.chunyan@linaro.org
Subject: Re: [PATCH v2 3/8] dt-bindings: sdhci-omap: Add properties for using
 external dma
Message-ID: <20190218201240.GA14067@bogus>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-4-faiz_abbas@ti.com>
 <20190215200718.GB15711@atomide.com>
 <2aa0f7e4-c880-ee88-2e88-dc2c3187f0c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa0f7e4-c880-ee88-2e88-dc2c3187f0c9@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:11:32PM +0530, Faiz Abbas wrote:
> Hi Tony,
> 
> On 16/02/19 1:37 AM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [190215 19:18]:
> >> From: Chunyan Zhang <zhang.chunyan@linaro.org>
> >>
> >> sdhci-omap can support both external dma controller via dmaengine
> >> framework as well as ADMA which standard SD host controller
> >> provides.
> > 
> > Care to describe here also how to configure things for ADMA and
> > instead of DMA? Just leave out dmas property?
> > 
> 
> That's correct. If dmas property is populated, then use external DMA.
> Otherwise use ADMA/SDMA depending on what you read from the CAPS register.

Then the properties should be optional.

Rob
