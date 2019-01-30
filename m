Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD00C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3954E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548863302;
	bh=uNzZnrnBA0jtMK8pEO5F8/FfbuAu+4uA6iyCShB8roA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=POjMjQom9iv/GVHJTIJrbJShCLQz1S2EllUGoRHLrPJtUJd2STg67xGnz2TjQuU4E
	 wLyd2tH5W3hh72adAhfk8xND45rToVBe2DALQBvuo02t+zA6w8xR3JD9DV5mzMK3FK
	 Yl7g/wcD0Id40zXaABIS74AZjg1UcQXMk8xJfv6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfA3PsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:48:20 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37443 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfA3PsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:48:20 -0500
Received: by mail-ot1-f41.google.com with SMTP id s13so21486602otq.4;
        Wed, 30 Jan 2019 07:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hyTjy/lFXzpQi2PY1pvGcoYrNzaMLpm29jUrshhOHRY=;
        b=cFru2M7efVHkaAwgX/9bD949bR/OdQqVDJli62ed/mBy2XDTq6Ha1KMGm2PjX/FM2L
         wonwrbiBM0DndOvz4Cz2ThAdNhQA2uaiQ+GIvxibMyl9q5cmXKAYts7NaSExgNzHUPju
         uCDPHV7HNmxn0cTHmg3O2Vu9UCMx/LL3B0Ed2xvGPLizOX1dfqld49sEGcP1uckgKwaM
         uRPA3PAY8AeSYK5ktCp+OJCj5Q/l8RdWsEPEA6L+nf+bTVJki1qnlc1URcGIgAr71Gqd
         vE62AJgDQDJQG/UGLwOYIa6De9X73Wx+MkbESJKiawxQZxXVRAe5ai6utwX2kcPVZBxT
         1NNQ==
X-Gm-Message-State: AJcUukd7ZrpAxrtwzuF/hF00hSBSwhcgBrTH+HABZMLsRWzPpyJGyS07
        PNcLz3/B4DWSZRA7Ew9LcbCMfY4=
X-Google-Smtp-Source: ALg8bN7qNSpcLDwqHv9WysWmvEyFdrXIdMHGh6Klq10tXNG3GbNBWBe9DuSk12SrfnKXKximnUs8cw==
X-Received: by 2002:a05:6830:1204:: with SMTP id r4mr24575152otp.101.1548863299599;
        Wed, 30 Jan 2019 07:48:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r9sm644727otq.81.2019.01.30.07.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:48:19 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:48:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
Subject: Re: [v7 3/3] dt-bindings: msm/disp: Introduce interconnect bindings
 for MDSS on SDM845
Message-ID: <20190130154818.GA24282@bogus>
References: <1548306592-4708-1-git-send-email-jshekhar@codeaurora.org>
 <1548306592-4708-4-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548306592-4708-4-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 10:39:52 +0530, Jayant Shekhar wrote:
> Add interconnect properties such as interconnect provider specifier
> , the edge source and destination ports which are required by the
> interconnect API to configure interconnect path for MDSS.
> 
> Changes in v2:
> 	- None
> 
> Changes in v3:
> 	- Remove common property definitions (Rob Herring)
> 
> Changes in v4:
> 	- Use port macros and change port string names (Georgi Djakov)
> 
> Changes in v5-v7:
> 	- None
> 
> Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dpu.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
