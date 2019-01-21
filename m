Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BF1C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82DB20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IuV0TLGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfAUSLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:11:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34967 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfAUSLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:11:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so24533012wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=x+oFH5CfxZ7C6Sua9d+gUiEAtXOfmj2np6FmFpROcok=;
        b=IuV0TLGPNLZBEiui1KPY3bF9vJuak24t6isOW0k7zS3IcRYyxEc1pDfRD+beif4a4/
         Q7whpV7QkMpjyVaexdQWMvcu7bBZEikaNKz7t6cIxUK+wcZApRtvw4QBLBT61UYgaC95
         FsPH7shnpH7QQSIOkunQc9WrdmLPO4yLzWR3lHrQv/oyYY1PriCn5BAdnW1LXhSy/E+b
         kbHppitqfNbl+7Xi9Fx5c1DiGmtCmpcDgDTOAdPoFMaAyhMhEHL4FCof9O+3GbZD0qI2
         w+MJJuNQx6juzgaBIjow9XoDU9xSdRPH3Pw3o2qNxOzky9foBUhGvnVwbM5JIEubysoM
         Y7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=x+oFH5CfxZ7C6Sua9d+gUiEAtXOfmj2np6FmFpROcok=;
        b=M/7hXYt/iKYRwiZ93cI2PELzuLrw1xUsGj9XcHFFiffuTtxFAy9CL707AaVn7dMcGg
         ILygQCpDPY1GT2Ida1sicF0sCyFdnrTY3cLrPfqPLDFAAqHwdgrlh0624s6I1K2bemxT
         PEY49WkOiHJ1r/AnzsP3VpK0OpvN2sGZMY+C6pJJmVHPqCq2dX3s88tw7kYaetqaDpgl
         rJ6xxxnoVD38b/U/01Kex/cEpqrTherEDtQd9MotUpm3AKzR2D9nblHpdJ+4TsFjjCOO
         TuSiHFd2o2cb+9wUAQp4yysmqXACo+QwI4ZVbQQXk1w982y5ObC92Yf+VtoFuq+xPgCu
         uP4w==
X-Gm-Message-State: AJcUukdDTXj8mg2Ko0r60xHg93CSyzL4wzdqWzgqTP4h+Ym4uIj5wyUi
        VkQ+ShjUcknuvwB5cjxwNj0gXw==
X-Google-Smtp-Source: ALg8bN6foyjYeieuxE9FmRK0G2uxi0S3Trv/iVPOIQh+IpwgCIwTu1NOhk63eyWUt5Qr05zldsV0yA==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr28517335wrr.155.1548094281780;
        Mon, 21 Jan 2019 10:11:21 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k15sm127918568wru.8.2019.01.21.10.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 10:11:21 -0800 (PST)
Message-ID: <d8b4eaa459108471ceaf821937dc857c83bb8487.camel@baylibre.com>
Subject: Re: [PATCH 0/2] arm64: dts: meson: g12a: enable pinctrl
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Date:   Mon, 21 Jan 2019 19:11:19 +0100
In-Reply-To: <20190117103151.3349-1-jbrunet@baylibre.com>
References: <20190117103151.3349-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 11:31 +0100, Jerome Brunet wrote:
> This patchset enables pinctrl on the g12a and adds the necessary
> pinctrl settings to the u200 uart
> 
> Kevin, please note that this patchset depends on the:
> * dts bus fixup: [0]
> * pinctrl region fixes [1].
> 
> [0]: https://lkml.kernel.org/r/20190116165236.8330-1-jbrunet@baylibre.com
> [1]: https://lkml.kernel.org/r/20190117102315.1833-1-jbrunet@baylibre.com
> 
> Cheers.

Hi Kevin,

Please ignore this series. It is missing gpio-ranges.
I'll add it in the v2

> 
> Jerome Brunet (2):
>   arm64: dts: meson: g12a: add pinctrl support controllers
>   arm64: dts: meson: g12a: add uart_ao_a pinctrl
> 
>  .../boot/dts/amlogic/meson-g12a-u200.dts      |  2 +
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 67 +++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 


