Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00375C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B4B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548863482;
	bh=7Qxb5oV8vmVrO7eTVIN1wtOFNmtsw8Yl6pSVDQ3LuSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q/DmFzUilrJbT4uu/0DFnjaZlhKew6eoqnF4ErfdKY5pNbHK/TT6Tbzd9tXhTwPWL
	 lM8PXDJEceda9nAdT1TMmCchWUGLqYpG58N3mdYRgUuemQ11w353gzAtMlpsMMZOza
	 rVHZwBUEJNY/2Rw46qmxzSa9lupCxn+TAeL+jdj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfA3PvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:51:21 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44888 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfA3PvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:51:20 -0500
Received: by mail-ot1-f49.google.com with SMTP id g16so17482348otg.11;
        Wed, 30 Jan 2019 07:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a6KhZ/RV34XWL8J67/X0hcpg51Ps39ws0uRDWZ+Jn08=;
        b=hksy+RvrPWL/H2/owtZb6rxiSGY8Vd6RWlaiscT49jfAJCMzDX+HdwlJ3OzYcAI4wc
         Ru/1RgItJWEsJM5OrcLAQnKwrTv8HJPyG3zdAFXeRCzlDs3XjLxhANC9gRg6H2PuOW35
         6UkLdHx/KXKyQ4Tdgxno3mz6+RvW0tAXDQFe13HOVhED7+q0bQl5ALwVtXCj2TFC37Ti
         X99c6/WdVeq16bqdR54LanpvAg2Z1OM5/bHKcMGjFouLsAzvjhg5vuF6oLWtFIFMZ2Do
         5q58K8D2ZvWVroIpOFZzM8yX4hnJU2tS4VtoGWIJsAufzex+xf8kdAR+2VQTrmNPMqap
         wWyQ==
X-Gm-Message-State: AHQUAubC03DMA0aXF8RveBaQWT2dzbe5kFZhFXbZiyPZPbDwp18Njwn6
        mDbENVdyMxgrWO8j8z01qw==
X-Google-Smtp-Source: AHgI3IbPCpSr4frSE4DFFnyI28JcrHoO2LLNY94lhKjo6YsKjckM/xxAze38HrYmYXaf15hydLE8kQ==
X-Received: by 2002:a05:6830:1310:: with SMTP id p16mr13183255otq.309.1548863479707;
        Wed, 30 Jan 2019 07:51:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m26sm661431otl.32.2019.01.30.07.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:51:19 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:51:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com, davem@davemloft.net,
        mcoquelin.stm32@gmail.com, mchehab+samsung@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org, olof@lixom.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCHv3 2/6] Documentation: dt: socfpga: Add S10 System Manager
 binding
Message-ID: <20190130155118.GA29638@bogus>
References: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
 <1548713655-25940-3-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548713655-25940-3-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 16:14:11 -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add the device tree bindings for the Stratix10 System Manager.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  New compatible string and usage for Stratix10
> v3  No change
> ---
>  .../devicetree/bindings/arm/altera/socfpga-system.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
