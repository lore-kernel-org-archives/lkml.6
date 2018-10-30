Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2677C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708B420827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708B420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJaFXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:23:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40641 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaFXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:23:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id m15so12441097otl.7;
        Tue, 30 Oct 2018 13:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=37aYZuhg1Zxza/c3j3Mc6wWnVbttgexS56fKhEeknMc=;
        b=boC71BtWBuCLCSVa/XPfwrHIuyL5b/vSM9rGf2VPEs4qYARSHy9w4AGuG8LCZbDHBA
         DQFQSuVV0GPmgcLKE66QK/vm+nDwVvKkwyRA5lvmEfPN3uIKnb265+GWlrGqy3Qg3/dN
         0AJ38eL8XG6miRlFF98UscFwJWKhW7Ac8YjhG87JJdelX9XGJVGD9fzedfPg+LoClHbJ
         lL640L3Bzz0O5SmoN3U7TwtFUHbEh/MjoK6mdW7mvb0EKoO/IGYXM5LuYvpvjMWqKxd9
         L4TJ/MJIfIhMHnFupXr0CRj/dPUJHDjdZhhxavJmQT2dKDM1/aQsqfXfqpsnWzDoBfkO
         dQHg==
X-Gm-Message-State: AGRZ1gJilkSgCD7BX9iXgoDxBvhvJ8+a7f1YlDILp8uRy4MzTgWDljEb
        Avg/zUQZZmt8y8uuLWuPdw==
X-Google-Smtp-Source: AJdET5ecfvtN94QYoVj0R/ErV2Ndx7UCFG0MNNxcAFXy0efxki8bApnvOq1vBqBzdzbQ1zw/C3B4IA==
X-Received: by 2002:a9d:c43:: with SMTP id 61mr154223otr.222.1540931313154;
        Tue, 30 Oct 2018 13:28:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a93sm8563857otc.16.2018.10.30.13.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 13:28:32 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:28:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 22/25] dt-bindings: sun6i-dsi: Add compatible for A64
 DPHY
Message-ID: <20181030202831.GA22352@bogus>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-23-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-23-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 20:13:41 +0530, Jagan Teki wrote:
> The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
> on the one on A31.
> 
> Add A64 compatible and append A31 compatible as fallback.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
> Changes for v2:
> - new patch
> 
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
