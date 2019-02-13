Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54FB2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nr1pBAeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfBMKPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:15:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45215 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBMKPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:15:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so930154pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7/wA9bKDbtMGKDL+u8LUnnfnebexOgDkULd9V0FL2tE=;
        b=nr1pBAebs7PLUPoIJO5ok0jnU3a5IsvOFYglsg4W/0KYVH+Vo9r2WOktmoKOys5AAV
         /u5UClC9n8rtV4O/QVQC0ysNeeHXe8oBbsjWWLeVQ722phXkRCJ6Dv4eDNJxvJe4ETUh
         1fdtLGLdOMdhNoUlZ0HkBvCWVYg88ANOCOiJGdqxuPYbL43Q5PsTdwqH067hTrcs/DzJ
         PifGoJWMo9mPxMKPTwRkCBeAkkYUH9u7yPJ1aEs+ML6++uCGMRN5ZOJ5NgP7mPPKpN+C
         iX2AfXhdP5zPIT5AiiIsjDZabOXW+2NZfLLKRpKgewzCNgum/cB4YasqOLsRWQYPw0Zp
         mo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7/wA9bKDbtMGKDL+u8LUnnfnebexOgDkULd9V0FL2tE=;
        b=itYsrCwmjJTpokIJwNplmeXmEl03iJLGON8YH51otusgpRxzzUfmNVVOJfi/7GWs0E
         4qfyh5RCwgBBRPa1wH1DYIk/tMZxDMIj3H3sF4Jg8tVHr6h36qjWgNVT12Z4Qtpn2W0G
         fKzEzSiSk0hwyb7gfUpSv9m/ecp9LbQciuS1rsm6Tf2Ws063A8N8SkjuQQxW4099Fk+u
         xmYNF5yx7iAoKpqSXkN3f9pK63QtGgVqQUj0UWO6Ta9IYMaiFFJn6uzsNv35/Dr6xLFu
         b3Zt/15AqORupaMKzpYrp3f67SMDG/+wR/1lgur7zTZJH/PGo+hyA3Rpvqp56B/S5kqT
         p4DQ==
X-Gm-Message-State: AHQUAuavIleWgrfM9o7Nf6BMX+Gw30kXH6rnjqjGIS12kh4skmYPvA9f
        c5IIF7zEHvvE01HjzFPWhI5bfg==
X-Google-Smtp-Source: AHgI3IbMq0TBtXCQSQVG5XwfPu+5HyxlZKZxxaDLs1fs6Pvm9e+lGh9hi8zup6opQii3SL/3wLu4tw==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr2650457plb.23.1550052904800;
        Wed, 13 Feb 2019 02:15:04 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id l87sm30819083pfj.35.2019.02.13.02.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 02:15:04 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:45:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Message-ID: <20190213101502.v75d3nfwctcks2gx@vireshk-i7>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
 <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-02-19, 08:53, Anson Huang wrote:
> Forgot to mention, i.MX system controller cpufreq actually can NOT do any CPU
> clock/voltage scaling from Linux kernel, they are controlled by system controller
> firmware and ONLY can be requested via RPC with secure mode, so Linux kernel
> has to call SMC and trap to ARM-Trusted-Firmware to do it, in this case, is cpufreq-dt
> still suitable to support it? I saw cpufreq-dt driver will do CPU clock/voltage scaling
> directly.

What about moving those SMC calls to the clk-driver, then it wouldn't
matter to the cpufreq driver on how the clock is getting changed.

-- 
viresh
