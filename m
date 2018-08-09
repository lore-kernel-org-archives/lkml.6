Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADEF22393
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADEF22393
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeHJAEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:04:40 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55369 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeHJAEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:04:40 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so26166itj.5;
        Thu, 09 Aug 2018 14:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FMKA46lZAxxSR4T4yD7qmkmd2737H+PzOJCS74Hen/A=;
        b=SqZzh4+23UJvg8yueZiEUDyWBMnRQ9UV/rGlcuCQEWctNvKenYc66wJ5fAAHgdlSXv
         cac/1NWIH3Y4pp6WXo5jHi/q8wD7gfWmJXWB+S9EeHtg4+3WmlL+0QFlLjWxCWpI8roG
         ve2lVrRY6tEmRLHwUCTMpSQrop2BBUKrRPDJvwPs2h/9+j1WNxzLd7rEgbzlBGj+6jer
         BNfDUvnQmTESEXOqy5vHpt+sODARdBLn65K/UzjZWqHBc6sHhGtihHiLosy9h3kDUIF9
         VCGs0fmnCNcLmT4jjdyl+WZuogtGJBsnhanXS+VeDKB3mgIh4Trwiz7hDbwlyTfUuUm7
         ARnA==
X-Gm-Message-State: AOUpUlG2fRtX6FQnkmMTUtcxObVir5EJ8DB4288J+NJQX/GzmUo2UwQ/
        5CH2AvpzFBGdpIITjjnJPQ==
X-Google-Smtp-Source: AA+uWPzaO4SrbUgqKoLllnHxouY+YG4+yo8xTCIBZjb2vkiSa+DFhM2djwJSvbd6dkxAmEr2C/3WPA==
X-Received: by 2002:a24:9686:: with SMTP id z128-v6mr42450itd.58.1533850676573;
        Thu, 09 Aug 2018 14:37:56 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id k62-v6sm149524itc.21.2018.08.09.14.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:37:55 -0700 (PDT)
Date:   Thu, 9 Aug 2018 15:37:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: add binding for i.MX8MQ CCM
Message-ID: <20180809213755.GA23245@rob-hp-laptop>
References: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
 <1533825941-17224-2-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533825941-17224-2-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 05:45:38PM +0300, Abel Vesa wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the binding for the i.MX8MQ Clock Controller Module.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
>  include/dt-bindings/clock/imx8mq-clock.h           | 629 +++++++++++++++++++++
>  2 files changed, 649 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
>  create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

Please add acks/reviewed-bys when posting new versions even if it was 
back in January.

Rob
