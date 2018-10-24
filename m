Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF49C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F9720833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2bZyxEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F9720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJXRQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeJXRQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:16:53 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0712082F;
        Wed, 24 Oct 2018 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540370981;
        bh=/r/uQVEgQJgOoCblGOZqP/08XrnHCSEfmo6FIoJhdng=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Q2bZyxEG7PTTELFva0QXl3SXy/CzUrtT3WfnTxNC+48SO9TPQTkL0xf5vYb3OPAR1
         5KsjDPmuNpEHGcKLOiG9GDpQUsEqipaRk/jpgcH41/1pm9NBqAR+/g6E74kIWJNpEI
         OGozz6eCc7evpYfs085UXvGWo800r+Joo6M06A5c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181023155035.9101-13-jagan@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-13-jagan@amarulasolutions.com>
Message-ID: <154037098047.53599.11415144740017316303@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 12/15] clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
Date:   Wed, 24 Oct 2018 01:49:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jagan Teki (2018-10-23 08:50:32)
> A64 manual say PLL_MIPI rates are 500MHz to 1.4GHz, but
> using minimum 500MHz can't release the clock and which
> is not working.
> =

> So use working minimum rate as 300MHz which is tested on
> Bananapi DSI panel.

That's weird, but OK.

> =

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

