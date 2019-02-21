Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15D9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712BA2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550762554;
	bh=FdlhhvkYoV15nFGUtlL0rSvTmm4WaXKSep08UGxCexE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xG2NUajv/VB9x+t+SQkzlZjdh59+jFhJIzYilNX0zGYPkT//dML92TSOog7hy45oB
	 XIg/ajVwzKspS0T+viNPhQDWdgLatDyOZrsCQ/joTCQZjVtVpNemRGZPcaFSCAsM4P
	 p38uqdr4QbBIujySpYeMhmGqG+6fvT6+BDi5JScQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfBUPWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:22:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38880 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:22:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so11573889pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KngP3NedmIiPSNcbPcgspHVezoAsDtNZEXcyTuFhouc=;
        b=Au2QF2x18yfO3ipWr3AL4byBOwvicIoCKzcKN2HUdSC3nm9WLEk3xfSYsVsth72fZL
         mMOwW5dtVArOnceS5I4vwbzeqdvgVNdFFQNZkjhuAPV6dpFAJdlaaPbwSgk91mk2GtKQ
         mx9VSSk3u0ddgG5p1CRiaalzE8PXqedIa48oneceSUU53G0kPw77t2W5Nc+KSTEydcqu
         Uv/ppDdepbkHqPi4wbaBCvKN3MfGTvPfWP/GR1Esx810KxF5Ac4HkEBGD+p7zcTMVk//
         q8HPde81gLLtr3KrMvZmJxXj+Uxk6qzOy567gffqX23qFf06goXXPMQF/JOI6fWZQjml
         MMsQ==
X-Gm-Message-State: AHQUAuYYx87Bz9X6dr3TVFNwm/cwVyKryvvkWHHuD6hJyF/LXoFUi6Br
        IuvbmmV/J0M/Ii6APhVVZPI=
X-Google-Smtp-Source: AHgI3IYio7+Ip+CGXr5WCu2xyv+Z5hkCSzUHtwjcAQMkfyyvAKr0HO1jdxujTCcqrg+fPkHzN7wANA==
X-Received: by 2002:a62:fc10:: with SMTP id e16mr41346057pfh.83.1550762551799;
        Thu, 21 Feb 2019 07:22:31 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id a24sm17512569pfn.85.2019.02.21.07.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:22:29 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 21 Feb 2019 07:22:26 -0800
Date:   Thu, 21 Feb 2019 07:22:26 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     yuankuiz@codeaurora.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware: hardcode the debug message for -ENOENT
Message-ID: <20190221152226.GK11489@garbanzo.do-not-panic.com>
References: <7e752055f72d67a4b963436d67965123@codeaurora.org>
 <e1e9df03b288daf7258ab9e0f7402ca1@codeaurora.org>
 <20190204233047.GT11489@garbanzo.do-not-panic.com>
 <d2f930db664d8433894a7bf20db32748@codeaurora.org>
 <20190219163810.GI11489@garbanzo.do-not-panic.com>
 <96bbc0d0f3c76b91752db07f0f5287e4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96bbc0d0f3c76b91752db07f0f5287e4@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:39:04AM +0800, yuankuiz@codeaurora.org wrote:
> From: John Zhao <yuankuiz@codeaurora.org>
> 
> When no file /path was found, the error code of -ENOENT
> enumerated in errno-base.h, is returned. Stating clearly that
> the file was not found is much more useful for debugging, So
> let's be explicit about that.
> 
> Signed-off-by: John Zhao <yuankuiz@codeaurora.org>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
