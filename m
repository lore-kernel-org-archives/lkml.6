Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACCEC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0DB20779
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0DB20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeGCWMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:12:33 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42091 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCWMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:12:31 -0400
Received: by mail-yb0-f194.google.com with SMTP id i3-v6so1329768ybl.9;
        Tue, 03 Jul 2018 15:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ej0bLx6JQeonCL2BxnsF+nNNsFG5pzs4RbWHapOyY5o=;
        b=ex7S6hPMWc8ASqk1DKpav0nxbXMgxO/asaCKBR776ikyuvP5AyPAe7qj6qJ4V48fI8
         gAg/jCpsuW8Ddp4Q2nnVhUmpsrLweZ0E0LRATB2pFyHzpuO8SN/LFb8EwYEW72yoIgUg
         siOzSmR+FHVucYb5qEAU5idWKObX60dU0mKMQTlEedmmisRAfwVTzMbU0su1HqgjY7Nm
         rvtDfZDh/IXP81EkrJU8n+2xsiQC6jAt/l+YTPpDMp/UCQ/GfOuQA0p1Qzcb0HgQHc2M
         VLktP6Wt4ncCJ/J3WXlQs4myWIIIjomu/JmOTtLiknLCpAxee6WzXkPpdgUYSodiZpXE
         j0jg==
X-Gm-Message-State: APt69E0OuuYoin96Rq1LKNHZXWhoHc/mAYAbfxKWj0Ka7pykxUkTO+0C
        aTy3eWEnmwD9BPUhNCTCrDyl1YN0+g==
X-Google-Smtp-Source: AAOMgpc3SmNenL0Rei2jax1jyx8xjkgNOMglH/kfCR/BHRMjCw4aUIunHqPg0Y83sDzFZzk9OvyI1A==
X-Received: by 2002:a25:6114:: with SMTP id v20-v6mr7786561ybb.462.1530655950762;
        Tue, 03 Jul 2018 15:12:30 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id y4-v6sm786384ywf.70.2018.07.03.15.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:12:29 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:12:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: rockchip: add document for
 px30 vop
Message-ID: <20180703221228.GA9739@rob-hp-laptop>
References: <1530003215-46593-1-git-send-email-hjc@rock-chips.com>
 <1530003215-46593-2-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530003215-46593-2-git-send-email-hjc@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:53:34PM +0800, Sandy Huang wrote:
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> index eeda359..5de2a0f 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> @@ -8,6 +8,8 @@ Required properties:
>  - compatible: value should be one of the following
>  		"rockchip,rk3036-vop";
>  		"rockchip,rk3126-vop";
> +		"rockchip,px30-vop-lit";
> +		"rockchip,px30-vop-big";
>  		"rockchip,rk3288-vop";
>  		"rockchip,rk3368-vop";
>  		"rockchip,rk3366-vop";
> -- 
> 2.7.4
> 
> 
