Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E312C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C620873
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="On43Tbs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeLTAuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:50:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35919 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbeLTAuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:50:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so20162plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 16:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tqbnizE6Ve2UTRY0tN2T7/m07fToxesmjMrvAuibSDA=;
        b=On43Tbs7Wj+gnCUx5ZdDmBnikqmqBFbrd4rIPHflPg93BC0KUb3HEDrAjp/ToXpPvp
         DmxLrsNhue/6oI48QEB9WVTvLl36o0AxPW2ZRJRpSyfhoFQaRdwm41SjtHW0fnx7vg7f
         M9O6nbozEn2wNU8zbUQZTfG+yNKpJ3wi8E1z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tqbnizE6Ve2UTRY0tN2T7/m07fToxesmjMrvAuibSDA=;
        b=hL+7qZ45oZltbcBRSC9HVB+cQ5lUJC1SOGCEbLiE3zS8vC0MHY7HLDg6R4mEdNOYbh
         SWT9cRxS8sagGq/RKstIoj4KRokAIhQBRZG3YTOsBh6GaGUe0BM4K5IlFxjn7jxXY9y2
         SSE95qA7c6Hzh3QKhFNx3dAHYBaSsSPPzzGlmRaVb8whhtgM7X8lWzva2oTTivkNg2wD
         OGEgbVKbScv1w2RYQ4VbPwxxpjt9RYlf1/v+dmfJM6EnGhr/FCxvhXPVcj+5Y8XaVY1g
         Chsb71CqkasCe4QfJsudNPNCPBKGATT2yYukzf73/uEHhzc7KMxIQy7q+6N016KlwSve
         vUMw==
X-Gm-Message-State: AA+aEWYcvRVMP0fQY5qabQwLOGeDMiDrJIp2It4quMdYXVjhwyIpWKK1
        i7SI/EwHLfDbo9Kp+pklyuTwBQ==
X-Google-Smtp-Source: AFSGD/UqSlTzxqqMU9NyA9LMMVtIrZo7n2VvsnFDLsOo8iLqnLY1A1aLMMti0/u5/SQJkwdVowWHlw==
X-Received: by 2002:a17:902:9a8b:: with SMTP id w11mr21673984plp.121.1545267003826;
        Wed, 19 Dec 2018 16:50:03 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id s79sm27908823pgs.50.2018.12.19.16.50.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 16:50:02 -0800 (PST)
Date:   Thu, 20 Dec 2018 08:48:50 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181220004848.GB16635@dragon>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
 <20181127100722.9993-3-shawn.guo@linaro.org>
 <20181219200107.GD1997@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219200107.GD1997@jackp-linux.qualcomm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 12:01:07PM -0800, Jack Pham wrote:
> Hi Shawn,
> 
> On Tue, Nov 27, 2018 at 06:07:22PM +0800, Shawn Guo wrote:
> > It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> > is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/phy/qualcomm/Kconfig                  |  10 +
> >  drivers/phy/qualcomm/Makefile                 |   1 +
> >  .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 529 ++++++++++++++++++
> 
> Just caught this...
> s/snsp/snps/ in the file name? The bindings doc in Patch 1 is named
> correctly.

Oops, I will fix it with v6.  Thanks for spotting it.

Shawn
