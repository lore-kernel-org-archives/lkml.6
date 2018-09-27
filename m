Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5270C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664942170B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664942170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeI0X5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:57:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39390 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeI0X5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:57:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id c12-v6so3372353otl.6;
        Thu, 27 Sep 2018 10:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u7An+RNIBLO4O18VMZttAslJeYKvxjirnHe/HfmRScs=;
        b=ROS54IUyHOCYu22K16VkodLrfqJHk65Cbm6hZvofgjBC+hEIrw4Ygxq2GTBUxOxTZC
         rMidewMMFadiT4QbW8McI+GWSSWDjCsjlLMRDKAwuCRowtMNZP/cKL/Ygqnpjg6TupCo
         dOpyacm9thlb1N9+/DyFJtBQs+VMuvH9CPir/mtj9kJiGDHblYs0uC/bzKmrF9jRgj/i
         pWzsPfO2wYgCBy9X03VfPWwUBd8goAkifEa6ifWjepRy9cbN+/8jJs/ZsiujYr5x6TEz
         qeGYiz83XcwlortF/l3OpYN+3lRaI53o0zGNG/S80945Z0bj8yIJc41YsVhA7zj6eQuT
         Qzig==
X-Gm-Message-State: ABuFfojWt1+X6805Hih42k241aPCXwosksFg9yHTudNfntqWwX/Y05bc
        vwlPDl/8X2dMhqHwlnOxQSxW805Vs6rw
X-Google-Smtp-Source: ACcGV61gvZqboz7Q8ssy9EGTLF+VdVE0E4pql9XpeYqvhN8InIPeIqPuSeepX07GfacH2ohgyey7zw==
X-Received: by 2002:a9d:5c0b:: with SMTP id o11-v6mr7224589otk.77.1538069902649;
        Thu, 27 Sep 2018 10:38:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k23-v6sm833573otl.69.2018.09.27.10.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:38:22 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:38:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Damian Kos <dkos@cadence.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, pgaj@cadence.com,
        ltyrala@cadence.com, rafalc@cadence.com, jartur@cadence.com,
        piotrs@cadence.com, quentin.schulz@bootlin.com, jbergsagel@ti.com
Subject: Re: [PATCH v5 4/5] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings
Message-ID: <20180927173821.GA7422@bogus>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com>
 <1537866837-4408-5-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537866837-4408-5-git-send-email-dkos@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 10:13:34 +0100, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> Document the bindings used for the Cadence MHDP DPI/DP bridge.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
