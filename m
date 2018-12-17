Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41CBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B56F214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545081804;
	bh=8ffBfHlrMCxthGlfCgkSuNx43NjDuZHuCLxV2pINzKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wl/t/5fsWyGN00HdJQ0S9Twi79M8ylYJJ4xzvDuKjEQIibTHdGk87nbA6U1JbuSm5
	 2/fkRTK0YBevtco14Kp8HZ/XTOJ2nDkyj0BlOtWvK7+VLrHuA2Pu42dbUTA5Qt1xDT
	 ySlvSxObgtfqoaUw+rbdY9+AfYsXQHBirjJN7WoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeLQVXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:23:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40318 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbeLQVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:23:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so5975118edr.7;
        Mon, 17 Dec 2018 13:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHrwMGWIppqkLJNYipwySwGrAgEzaDIAHFLV8YWzQuE=;
        b=Nltxen/RiFjm1MLUwBlQuy2ZJh/o1CqitMy//ef/gIpGJx2ZO3eGef+IG5BbcOtU0F
         3QTn5Q2rqg0qbsceIAjpOIlZjJMw3Rnx+fJ4bWBlRWSfcxKGp2BMuVC9Ftw7qVEnRbEY
         GbXgNTO2YpajRaEkMWfH7rBL7eks3b37lZjDxpJCpIk8jR4SAKvWqtxMMcTfHGLev6f5
         DwZKslj9pAA+t5UvoQ5NkBze83tNW3rDu5UYk7QQKre1A+sad0HD38yaF+WiQSsnhCQD
         xyiHiyQuGwLbUiOeCtFCP5nGEv26oBWzIcSgVNxfvsbrzf4xS9MF3oknvzS/NeP6CvVh
         H27Q==
X-Gm-Message-State: AA+aEWZQy/vb+P/oIQ0JGp22plx6XZOd5q09JEGw3wKPZ4Nb64+JZRPd
        Kbas5bQu76tguLQDCfavyts=
X-Google-Smtp-Source: AFSGD/UV8awV1ha7qfoaV2poc21VI2EW9dMXyS+/hB1y9vN9nh4KuFs6ZiTOg5hZbKuN3z/H6cmEzA==
X-Received: by 2002:a17:906:77c1:: with SMTP id m1-v6mr11280095ejn.233.1545081801432;
        Mon, 17 Dec 2018 13:23:21 -0800 (PST)
Received: from kozik-lap ([178.38.170.116])
        by smtp.googlemail.com with ESMTPSA id q50sm3991339edd.66.2018.12.17.13.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:23:20 -0800 (PST)
Date:   Mon, 17 Dec 2018 22:23:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/4] arm64: dts: exynos: Add Bluetooth chip to TM2(e)
 boards
Message-ID: <20181217212319.GA24130@kozik-lap>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
 <CGME20181214113419eucas1p2473172a49bf798ddd95265fa31125d96@eucas1p2.samsung.com>
 <20181214113410.22848-5-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214113410.22848-5-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:34:10PM +0100, Marek Szyprowski wrote:
> TM2(e) boards have a Broadcom Bluetooth chip connected to 3rd UART port.
> Add a device tree node describing it and its resources (control GPIO lines
> and clock).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 14 ++++++++++++++

Thanks, applied.

Best regards,
Krzysztof

