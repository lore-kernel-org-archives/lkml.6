Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D261DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89ACD20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544224408;
	bh=7flK8mgq1Q3ryWLFWkBTPhitQSi1a6sXTybvyCpFKAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UoyLuaF860kJKR5aWKxO8RTGBxRFINxSqh/rs+aeacm+7qr7plFdSsmHE7wM7K0Yr
	 7ahRUHf872Rnhv3PNhiONMP4cwE9raCtzc5j2D5qT4fwSQg6ys2JGwgUK+FppJJZg/
	 9WuZm6gn2U00eb1w1Ky9/aT7zV5HwxHRe7ENT1pU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89ACD20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLGXN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:13:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44277 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGXN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:13:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so5330224otl.11;
        Fri, 07 Dec 2018 15:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HAZLB5b01POqOGjmOzQANT2uEEynRmpPNy+sjySi55s=;
        b=YcYXZIekleDdtkW4CXk1kG/B+XpjN0dYqBbEXHAEAYrlSCGpPeCcTbJ0T+0lrzupa+
         jfhcBvsx6iBqmshd97OGH3zisyIP8vT/pIvXel1+I1f0OS5EHqpk/ZuHarJ/3Kdq3bWb
         9I92f38rEOfaBjBF4Y8hQbsBjO9+BkrnfmM8ygEo9YsUyPchhKNIV9jYQvLxgTw4za2R
         pzmrzYyIZCsi/5/eWXGqvTwcKgTybCh4SePFgalCgHY1wndVgq2JTkB4hyXZ9oCpVqTd
         9kTlb6ey9wuLTXzuMY9fUWA53qIIxV91UgpDtrbBv9C5Y+waAvyTfdGXuZzDdbI0xJAo
         9eyQ==
X-Gm-Message-State: AA+aEWaKCgqs1mIMI1wlVd2FFI8u3Kr+LjxtqKE/mIt/BtDy54gMIH/w
        ycTQa8gmYakHTm8WcsFemQ==
X-Google-Smtp-Source: AFSGD/Ueeu7MD6cA9sMKipfPB176YPmUvIUDBn6Beb9ETKeqMYNGavyMi2x9YFpI/t2PRXxaqIzmQQ==
X-Received: by 2002:a9d:346:: with SMTP id 64mr2848722otv.90.1544224404594;
        Fri, 07 Dec 2018 15:13:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 52sm8216224oti.30.2018.12.07.15.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:13:23 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:13:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20181207231323.GA10231@bogus>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
 <1543458696-4741-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543458696-4741-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 02:37:24 +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *move binding doc to SCU since it is belonging to SCU;
>   *change compatile string to start with "fsl" instead of "nxp" to align with other nodes in dtb.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
