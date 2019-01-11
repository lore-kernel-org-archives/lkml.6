Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6FA218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547234959;
	bh=zf+F/p6Azvc6vinhZSBxedK+ZH6YJc2GS/DJpyDepIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RrF1fk5IEWezGvXy7faSLm6GAf6VX7LUAUdLMzHS0d/Vq/nBA/bVCE5MjPPaU8UNL
	 BK0mJuxcH1cLXRqkrEh27tBzXlv36XZI65qnFmPBZPc3mBO9W3d7iWEhyKHlSVAntK
	 OO/SsufogSKEP6d6xwQWVgnSzNDYWOiBUMM5JVQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfAKT3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:29:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36008 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731807AbfAKT3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:29:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so14120661otk.3;
        Fri, 11 Jan 2019 11:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2BYGI3XUbtBip/6Pn/WEr4+G6mRxfAk9QGOSRGink9Y=;
        b=e7xkyWWSI9Ziw+9D/k3/xITq7wWYZ9cbdK1W3PH/llPYzm/16SUUS9aFDhgk3mBM6f
         azSC7dljYjVihXPCmnWN/E0TIOOvJ9cR9l6qUCFeB0yHkdzqunzYIFpbArB36lHGh2ZB
         cgeZ81t3JabkQqrBh9zj2YtFTOsFjrDJgJ3TR5jEMgUkWlAWLb3xCWA0Kqdy8RlyRQ4R
         3pbMJ4YPbY9PiC/q+DaNbz3AkpaKYzT/1rttNNLYEFB8+K/EvRN6Zzkmy9IhKbUwI9Yv
         dsDshT2sY0awGvLHd3eKjg4EAb8K1H0Z8MBXInEehyrqm1VYmELWRLOolkDDZUl2QRuT
         TtvQ==
X-Gm-Message-State: AJcUukcG7Taxhi5qqCXPM9/pisb4R3kwjB0m2LpSmRKNjSJOvjXLz6KT
        dP4ypaTB471HP1uDUlDllA==
X-Google-Smtp-Source: ALg8bN5BGZe9LUOzfOQYm8VHEkroqdYpR9RuD8DNGh1mm/RZr+lc87sQx0Z60/lSxEOg+0felT4W/w==
X-Received: by 2002:a9d:3e16:: with SMTP id a22mr7685269otd.43.1547234956992;
        Fri, 11 Jan 2019 11:29:16 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm81941600oia.55.2019.01.11.11.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:29:16 -0800 (PST)
Date:   Fri, 11 Jan 2019 13:29:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4] ARM: dts: rv1108: Add support for rv1108-elgin-r1
 board
Message-ID: <20190111192915.GA17772@bogus>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
 <20190104014023.17973-4-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104014023.17973-4-otavio@ossystems.com.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jan 2019 23:40:23 -0200, Otavio Salvador wrote:
> rv1108-elgin-r1 board is based on Rockchip RV1108 SoC.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/rv1108-elgin-r1.dts         | 206 ++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rv1108-elgin-r1.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
