Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2CAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FE921904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQnOohxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbfBMHJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:09:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34261 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBMHJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:09:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so760684plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vykvHra8yq7WQFpSVoMklR3MmMLAQ8rqYPPLApssG0M=;
        b=EQnOohxMtVenP1TgNqecDBgl7ZUw2GguD/DliPNQ/LXbSijsAL5WJFL1LogwX70x8Q
         7Aj7KIOFAOnJrMAzotfhh+ojG1GTWs75ZU4D8T7hwC/IFFr5Z/oS49YmEiABxAhfA/sF
         wGuNfhvfQU1/n4glxLX+/Z69gBfQ0ii8gWhNKkCpj8eherLrr9QfMiU6T/CdZTMzJWRn
         AZ6Q0f7AhaVbvg2cFVuzNOKVQ2eb0IMtYWqrTM/LmlcTrO69Adj7V8+opkobRmYeuwTN
         l6WCThKJ9zdaEYISTF/Cxvk5Br/Y14AElly+gWSbaPl65nRAjEaSv225SYLPBtbTQE/4
         PXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vykvHra8yq7WQFpSVoMklR3MmMLAQ8rqYPPLApssG0M=;
        b=F+pQhJnF9RnD+whIzr7IMPa1+FYNxf/oX52AusKsfX3ZcUenKIajKH0rPLRVjlxJe7
         vjNwIZyOxeYx6KfqRM76j2wOQRndZfeb+1kzUE1eh/MHqwUZ4LdWQwvO3olqLPpvusXh
         2bdX0IuZPt6/BbkzUtRtIppuvKzRW3XgodSr5drFBlIwgteNEtblEv9EQh8YYw5ID6EP
         wb9nNBTquPSKRSHdMNAeBVHKNzIrNbpJKxdwzOk01O4lJwd7wM99qFIiXMggzwvsiBXm
         xxCPezRJPsvnVZ21nqwwQePPX7GgodhtjLw9ca7tsG/LqnXMbT9NputGHCV0mLicD9Gg
         rSrQ==
X-Gm-Message-State: AHQUAubv03ivGOkyEAugFjA6IP0FO5BbHlDl5vNZvQMDQ7GMReBd7VTP
        mk+FP0J7nKEpbbtvFMti2FzoVg==
X-Google-Smtp-Source: AHgI3IbxbJy3iUVtynJLH70BaBWHG66bzG/Xifqi0gYpqFDzKBcYJwwASXDG3T5cW9S5Z4C9Dz9h1g==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr8278118plb.58.1550041748336;
        Tue, 12 Feb 2019 23:09:08 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id b2sm19014678pgg.87.2019.02.12.23.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 23:09:06 -0800 (PST)
Date:   Wed, 13 Feb 2019 12:39:04 +0530
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
Message-ID: <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-02-19, 03:09, Anson Huang wrote:
> On NXP's i.MX SoCs with system controller inside, CPU frequency
> scaling can ONLY be done by system controller firmware, and it
> can ONLY be requested from secure mode, so Linux cpufreq driver has
> to call ARM SMC to trap to ARM-Trusted-Firmware to request system
> controller firmware to do CPU frequency scaling.
> 
> This patch adds i.MX system controller cpufreq driver support,
> when doing CPU frequency scaling, cpufreq driver will do ARM SMC
> call and trap to ARM-Trusted-Firmware, then SIP(silicon provider)
> service will communicate with system controller for CPU frequenct
> scaling.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/Kconfig.arm      |   9 ++
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/imx-sc-cpufreq.c | 183 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/cpufreq/imx-sc-cpufreq.c

Why can't you use cpufreq-dt driver like everyone else ?

-- 
viresh
