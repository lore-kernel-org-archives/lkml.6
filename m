Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09198C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DE12190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPbJyUZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbfBMKMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:12:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33930 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBMKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:12:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so956788plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4PkyRM9LdRS3VccLHP+LNCCOIPvUX0cNYbYPhXWFY7M=;
        b=bPbJyUZ4Y/la1Ew8iVoCMd2F9jAa5gtu9gs6bFMN6NP0+y+n5zAPu7M3kCiT7exsMD
         2pHEnQhP/Li8sE671vCYA6prsfZulzO63qC9t84U4j12PbOcD/5RdqvvDGCUl1L1jyOw
         zFQ0cJPiP+BQg3ZNalayPYdNgEO7xFagnJWxTKu8UJCx7jdyabhYHtBn/PbSaxut1YnD
         ep72hrXYMUDFfygByXibWLRi2Kg4QjLnvTu06QmqDrEpsrECQlTNSJxlSC6riNe7s0dQ
         3PxH/S5rRq1g8BIg7+Do/GMDnReqjrF+l3mfgnPc3IZUdMmmqCwqg2DP8jeeVkCrRts4
         jccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4PkyRM9LdRS3VccLHP+LNCCOIPvUX0cNYbYPhXWFY7M=;
        b=HSFLExmJvv4RhAlhr0HU3fy4JbR5aBHgTSfb6YhqKhIv6J8YhVEBLw/DtjsoyQJYwx
         Fn9mlZdB1plO7aj0X5JXbjpsJ2WyA5EIIuekmxw0dcm58BrYdCSeiq4lZx/SQeUAZ3jX
         64rT4CVu1MLilGsAlWyvKB1v3exBrwCSN3RPgRxV2wuDXnNbkO167v1+pPEwBD4o4N42
         5UiDQFz7fOxaiOZbLv6qojnhEtSez6tJ/q45NTvEZGdQg0BnObf3v8TJXEMplb1WHfvy
         JLrMYLnGd+h+7SLCZM3sm0dhiD1Igow943ZUSE1/xW7bqGHLB9eWMuSV4tD8usJ2JV3l
         BXSw==
X-Gm-Message-State: AHQUAubuvR0iePZEarD7szsIG2n5ramb0y0PoQ1r9yhJe+OKOjWJTLoN
        zxKZzA0hfu/YdFsH1P8xxmMCMg==
X-Google-Smtp-Source: AHgI3IYWwA6lcbc/EsGpZrBVdFTKqR4fupbOcssyJqdXM7th1frwx8mkX0qAnPgaFJw4eRuxBgDX+g==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr9122566plc.108.1550052733308;
        Wed, 13 Feb 2019 02:12:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 22sm7897323pfk.53.2019.02.13.02.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 02:12:10 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:42:07 +0530
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
Message-ID: <20190213101207.ggunz5lhlv46r5o6@vireshk-i7>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
 <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-02-19, 08:46, Anson Huang wrote:
> Hi, Viresh
> 
> Best Regards!
> Anson Huang
> 
> > -----Original Message-----
> > From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> > Sent: 2019年2月13日 15:09
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > catalin.marinas@arm.com; will.deacon@arm.com; rjw@rjwysocki.net;
> > Aisheng Dong <aisheng.dong@nxp.com>; Daniel Baluta
> > <daniel.baluta@nxp.com>; Andy Gross <andy.gross@linaro.org>;
> > horms+renesas@verge.net.au; heiko@sntech.de; arnd@arndb.de;
> > bjorn.andersson@linaro.org; jagan@amarulasolutions.com;
> > enric.balletbo@collabora.com; marc.w.gonzalez@free.fr; olof@lixom.net;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-pm@vger.kernel.org; dl-linux-imx <linux-
> > imx@nxp.com>
> > Subject: Re: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
> > support
> > 
> > On 13-02-19, 03:09, Anson Huang wrote:
> > > On NXP's i.MX SoCs with system controller inside, CPU frequency
> > > scaling can ONLY be done by system controller firmware, and it can
> > > ONLY be requested from secure mode, so Linux cpufreq driver has to
> > > call ARM SMC to trap to ARM-Trusted-Firmware to request system
> > > controller firmware to do CPU frequency scaling.
> > >
> > > This patch adds i.MX system controller cpufreq driver support, when
> > > doing CPU frequency scaling, cpufreq driver will do ARM SMC call and
> > > trap to ARM-Trusted-Firmware, then SIP(silicon provider) service will
> > > communicate with system controller for CPU frequenct scaling.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  drivers/cpufreq/Kconfig.arm      |   9 ++
> > >  drivers/cpufreq/Makefile         |   1 +
> > >  drivers/cpufreq/imx-sc-cpufreq.c | 183
> > > +++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 193 insertions(+)
> > >  create mode 100644 drivers/cpufreq/imx-sc-cpufreq.c
> > 
> > Why can't you use cpufreq-dt driver like everyone else ?
> 
> Just notice that we can overwrite the set_target if using cpufreq-dt, then we still
> need a platform cpufreq file to implement arch_set_freq_scale(), I can use it to save

Why do you need to implement arch_set_freq_scale() ? It is already
defined for arm64 I believe.

> the code of imx system controller cpufreq driver, and BTW, can cpufreq-dt support
> multi clusters cpufreq? As i.MX8QM has 2 clusters running with different OPPs.

Yes, it supports multi-cluster.

-- 
viresh
