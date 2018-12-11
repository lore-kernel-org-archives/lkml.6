Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E03C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED61E2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566485;
	bh=MOg56AmdPi2CDO8OVeLy4mBjyZerEAztZBsOan4j8NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ptDmQXAFNSOz6SxQj1/COo3b0H9uJpDZa3qvhDu446AYuKxaiBmupz9xjU6L0kmv7
	 883i66D8jOgHk1Rmedcbo7+wZFjzZlfAbf+KM0Fu2rple7JZXQniaUFE7fzbHfSjQc
	 stCUCgSUPvocgl74iiENNhvFQ13Zxc0V5b+68tlw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED61E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeLKWOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:14:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37951 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLKWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so15694473otl.5;
        Tue, 11 Dec 2018 14:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D0sCKaEjw/eZqy6umisQ9sSlHoBAkWaiOYTCt1krQAY=;
        b=CB3h2UWNxlKZC5yjPpx/GpFfbGNEs2arSIDWY6U0RgkGOem9KjgpD2PDeWIyPkDGcq
         59ZxegIi4uZIrzOoPb3iaxtQqIVWjVxyUY09areImQV1FMMyEQ66y3keFf0WZdfA67lH
         /WxiT0tzuss5IaMVRhtN3kEh2q6TnEE7PAuLa8AAGm/RQZIQTfKQeTZ3mOLasou1euhp
         YO+gbq0xm07qaoHLhy44QtSYWjJjJNBitR7oPIaJ8x+Qiz0YrQNqI7XULKAET6yWyVaz
         biuHFLxLYeRjcl2Pn+KmpMEisfR4sHbFCg1R7nGFwLlkj8WQ710i06Swe73FT+XWYQco
         oMAA==
X-Gm-Message-State: AA+aEWYuI6c3mF82IBXFinoyxHsaYqUpmaArG6Jh8KA79K2tn35AgvF8
        dKOLvy7Ag2iHTLMZSMrQkPx3cQ8=
X-Google-Smtp-Source: AFSGD/W+uUjwKQQPw6LStOQmDHuZlcScJ7fICSbmAH+JxxWxJVycWy4FuG2RK4S8+CD83T5fGEZhIQ==
X-Received: by 2002:a05:6830:10c3:: with SMTP id z3mr13078779oto.337.1544566481453;
        Tue, 11 Dec 2018 14:14:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v1sm7408727otq.80.2018.12.11.14.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:14:40 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:14:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jan Tuerk <jan.tuerk@emtrion.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: drm/panel: simple: Fix typo in EDT
 etm-series compatible
Message-ID: <20181211221440.GA17962@bogus>
References: <20180831121842.GA23617@bogus>
 <20181127152804.16652-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127152804.16652-1-jan.tuerk@emtrion.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 16:28:03 +0100, Jan Tuerk wrote:
> This fixes the error in the compatible documentation for the EDT
> etm0700[g].. panels which have accidentally documented as etm0700[8]0..
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  .../devicetree/bindings/display/panel/edt,et-series.txt     | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Changes v2:
>  - Updated subject line
> 

Reviewed-by: Rob Herring <robh@kernel.org>
