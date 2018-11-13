Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D690DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56952245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56952245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbeKMMIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:08:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39119 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeKMMIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:08:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so5205264pla.6;
        Mon, 12 Nov 2018 18:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zdeg41RsA7N1sAUg4m7r0Q9YXllshfrNcIalD6ikaKA=;
        b=LxOtHeh2Xc2d53d5z+YAt8jlAyTlhcAXJrSbNTCW6+K3dPTL7sZmON9y/7HjJPDQ+x
         B3ecmtw0YQEQxXJLjAs9jI30gN4G6YOt4XpiJG94y3Rp3HtmM4LGjD68OssOMHVvUNB7
         /n7/TZlea9DCuaNsOz5+OUtTf/mBUV1Yoz9JBf97Kfern2C5oDsu6Rd1xYfEc4kP7X5i
         u/kXHkBqjliWi4ucDPQrfOO/GIonN/JyOCb1BjIjI//XyuMeKdIcS2Ri6+/4fpfr5ZJV
         9smASM3YohDCUASmJXrSB/Gh7zicoxE5OZ4ri607IeXeff0SRKiPhhwe8H8QuwkxGqq3
         6oWg==
X-Gm-Message-State: AGRZ1gIiS1ryZ/s4R9R2na/rPYxXsawnck1KklzPHGcMIkcmG3Z7Tgm3
        UkNcKDu+uP1TOAQ8PS9/FQ==
X-Google-Smtp-Source: AJdET5fmpdV9e+FFusQMrWz4+XWZMw+lJv5S33qGEHRPlbfdDTb/uq6hbWwDjxu2JgT1moCELxYuAQ==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr392200plx.231.1542075127472;
        Mon, 12 Nov 2018 18:12:07 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id q8-v6sm23299688pfa.18.2018.11.12.18.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 18:12:06 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:12:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: amlogic: Add support for the
 Smartlabs SML-5442TW
Message-ID: <20181113021205.GA6962@bogus>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-3-git-send-email-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541706240-30036-3-git-send-email-christianshewitt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 23:43:52 +0400, Christian Hewitt wrote:
> The SML-5442TW is an STB for O2 Czech IPTV/VOD and DVB-S based on the
> Amlogic P231 reference design using the S905D chipset. Specs:
> 
> 2GB DDR3 RAM
> 8GB eMMC storage
> 10/100 Base-T Ethernet
> 802.11 a/b/g/n/ac + BT 4.1 HS sdio wireless module (QCA9377)
> 2x single colour and 1x dual colour LEDs on the front panel
> 1x reset button on the front panel
> HDMI 2.0 (4k@60p) video
> Composite video + 2-channel audio output on 3.5mm jack
> S/PDIF audio output
> Single DVB-S tuner (AVL6762/MxL608)
> 2x USB 2.0 ports
> 1x micro SD card slot
> UART pins (internal)
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
