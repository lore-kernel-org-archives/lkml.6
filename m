Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F58C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8133421909
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545946964;
	bh=tu+yxr28pYq6dLUv3EQc2Wxay5d9GAHH4RS7DqC84N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sydelqhkg2iYcjXMXJ9kkiJdjyQhbnhi/fExsk8pZcnMAc9vT6QdgforJPMGWchmu
	 DYLEBB5tPdAzldsmaWaORBkl3tAIu5z1XTlGb6xYsZXiKEOBDoTlzOTHqjUUzul4lz
	 RqzDUPWKRS0RmMBA6DR8Hp5Fnn2Knk9KvdjtkN9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbeL0Vmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:42:43 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39239 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeL0Vmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:42:43 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so25200977itl.4;
        Thu, 27 Dec 2018 13:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YDRlM9iTAR6SXAB2Mi5oMWRbavZlWKteJrKfbkVf7wo=;
        b=KSutgB65OwA6Ujk59sJY+g0y6vbPrX6nxbiq45GtQVdQJ1/1IZT2cD/nI4oXr6bS5d
         ivCTL4UmUch6JSgN/W79RRAZq0uhvyXjPaOVNZGJ947w1niUKPlcO4Y6v2Pa5QxnLPF+
         ucqqEJ3jUbQk2oK1XPyY2NJqqARLdLBfA/u37ZTOX9S1SlUb5B4CjDyV8lqrzV6FizpC
         nIFDivUXTXIRichmEvutR28gvVfWagI5iGeclLDpdHta+eTiLnQ6+kySB1L3y9ttgj2h
         676C3sGUUGOdFI+HKL+RuQrkwfxFaqxIYjw8IP+HIRPoXygBcBMmyetqs+aT2AWMWkKZ
         b3Ow==
X-Gm-Message-State: AA+aEWbp3lBWgZIyhzMr6075hOLZg73PZV4JAEQRfhe4ft1MCD2UdoP1
        8+UhPJg+KgtR+Jsc/Zfm+w==
X-Google-Smtp-Source: AFSGD/X/qzipHgYiQWM4fEA9sA4fF3E030kIh8jdbhjOKJl8OEtanbb6dvJvaB0fEbXK2SH/6N8bbw==
X-Received: by 2002:a24:1e06:: with SMTP id 6mr16523420itt.46.1545946962511;
        Thu, 27 Dec 2018 13:42:42 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id b25sm14659130itd.37.2018.12.27.13.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:42:41 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:42:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dinguyen@kernel.org, arnd@arndb.de, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net,
        mcoquelin.stm32@gmail.com, mchehab+samsung@kernel.org,
        bjorn.andersson@linaro.org, olof@lixom.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCHv2 2/6] Documentation: dt: socfpga: Add S10 System Manager
 binding
Message-ID: <20181227214241.GA25008@bogus>
References: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
 <1545351802-4354-3-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545351802-4354-3-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 18:23:18 -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add the device tree bindings for the Stratix10 System Manager.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  New compatible string and usage for Stratix10
> ---
>  .../devicetree/bindings/arm/altera/socfpga-system.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
