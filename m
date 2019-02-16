Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF98C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97FF222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550277622;
	bh=O5tMFdEraOHdNmuSg5PUk6dWxbx6ysYD6z0WMVZZZyE=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=J+DMVWQ0FSrrwNHLXiMQxO9Zdh7s2oCvdo0MDWN1Lw7MWgvWEQhvQYv6LCwil4koG
	 OTdQNhloMFcXp1aZks9vcd8PXzi7qKO+yJF16MtwQECSPOFtyFzWBdwUAeCRjAWBq0
	 ng9NahTDW8y/Pf0YFFlu+Q47DFRLNvoZvrqdWNsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403879AbfBPAkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfBPAkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:40:21 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49168222A1;
        Sat, 16 Feb 2019 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550277620;
        bh=O5tMFdEraOHdNmuSg5PUk6dWxbx6ysYD6z0WMVZZZyE=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=J2LmySMkhDzjYGgkXhfXO3JDaXBMArPrId82r9KN1iR2WE4X2uX9BtU/1ocJHBrER
         pY6B7EaHzYCuzX3BqpOH5TbkL6gW6dkPi4+UPGj0ztSThODvPUZfEKumfDVlYsvQ8i
         cHImqFfPR8GP+Y2FjAMrSiLSjS5UsfrD5NgK0w10=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <1550137826-18531-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V6 2/2] clk: imx: scu: add cpu frequency scaling support
Message-ID: <155027761947.115909.17708921995062238540@swboyd.mtv.corp.google.com>
References: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com> <1550137826-18531-2-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 16:40:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-02-14 01:55:57)
> On NXP's i.MX SoCs with system controller inside, CPU frequency
> scaling can ONLY be done by system controller firmware, and it
> can ONLY be requested from secure mode, so Linux kernel has to
> call ARM SMC to trap to ARM-Trusted-Firmware to request system
> controller firmware to do CPU frequency scaling.
>=20
> This patch adds i.MX system controller CPU frequency scaling support,
> it reuses cpufreq-dt driver and implement the CPU frequency scaling
> inside SCU clock driver.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

