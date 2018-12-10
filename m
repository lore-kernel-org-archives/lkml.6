Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F98EC67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335372084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544480528;
	bh=tF2lR67ckhGdHgwrfDwGTaxEHuPMNepUnJIw87vrdxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=arDym2o1DVr5H86cBzKfXvpaoewmGrXTw0i2Ntq6RSrG1aU1d4RL6oX2SsPvpWe9H
	 5ZqkADgbgsde6CrsvuTaXCeg4WJwteve0Bx9e4QIO5AjYizwwcu46PdfdZcwD4lIx6
	 z9a/vp+7RK+rXfJcehfSLZ1pC8QGX3wNxwgE5J0I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335372084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeLJWWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:22:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33331 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJWWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:22:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so12103354otl.0;
        Mon, 10 Dec 2018 14:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mD3hTgKG+kAzWU2qpeROvIPDZyqqXzsIxk4QtDaleJU=;
        b=iu+NqdiByM/uSp6fqwnIO0QgTj6L4HP4GP64foGxlNtTWijkjX8cG7rCSQmWtefCnT
         balw5ZY8GQOCuHwhNqcuvBmY2uDgMnP0Xq+CnptQZz8iyfXnHL38GyYLnJpOgW1gyYwc
         zuctTBff3Aoj2a0Eh0WO+BIu/FtzXYiscmZwrq2PRl3urxGqo5K9IWK2IkF577ZmEDnQ
         QXtTm18xtC+l+XPtexFHgEPlq7veSew5n2X1E4xmKmR1ptTmCidcPncdLu1hW2JV5tlA
         IHNe0oukH5UJQohnCYRSWDFD+dXztPNnKL+ylEEQ4HVUiT5/vkisVISU0tTouLM+8axS
         lgGQ==
X-Gm-Message-State: AA+aEWYFklWhVxyy1er62Z37CCVqr4mVk2PtcbL59Eagz8v/KQecjejH
        5GPfEgogCBrpZRG466PAaw==
X-Google-Smtp-Source: AFSGD/UhRTCXzAAO/kNvwXMfrZe77bXgksUPeiSME1jKSBsVFLZNatFVX1D8vobzfdbjZ1cpXaKHMg==
X-Received: by 2002:a9d:2da2:: with SMTP id g31mr10228310otb.310.1544480525256;
        Mon, 10 Dec 2018 14:22:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s186sm6021009oif.0.2018.12.10.14.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:22:04 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:22:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/4] dt-bindings: fsl: scu: add rtc binding
Message-ID: <20181210222203.GA27927@bogus>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
 <1543455856-18021-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543455856-18021-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 01:50:04 +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and secure RTC etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to do RTC operation, this patch adds binding doc for i.MX
> system controller RTC driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *move rtc binding doc to scu binding doc since it is belonging to SCU.
>   *change compatible name to start with "fsl" instead of "nxp" to align with other nodes in dtsi.
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
