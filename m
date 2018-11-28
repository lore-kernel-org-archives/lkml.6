Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DFBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F6720832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1M6fi2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F6720832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeK2IcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbeK2IcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:32:05 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC962081B;
        Wed, 28 Nov 2018 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543440545;
        bh=+ePQ1+C+CiT7J2d8VmYN8mgSP5fwmIIfMuINI/pWZfA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=S1M6fi2BH+Yhgck29Td8JWPTWoJ35SJFs3w7jSr/fgaJwFH24KzUsQPAOKNOYTq8o
         oeIk5f0/yC8JMaTEyIdc8HJGs0zmZoIc1F3DjE/81jJxEWyhruuQX8OfYjWrdnB6zj
         3bjm02M8mon+r8Ppn2JWv+/hIykLqcFHT2G5lYpM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181128093013.24442-11-wens@csie.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-11-wens@csie.org>
Message-ID: <154344054442.88331.8887745218976145062@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 09/15] clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output
Date:   Wed, 28 Nov 2018 13:29:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2018-11-28 01:30:07)
> On the R40, in addition to a mux between the RTC's own RC oscillator and
> an external 32768 Hz crystal, which are muxed inside the RTC module, the
> CCU also has its own RC oscillator, which runs at around 2 MHz, and can
> be muxed with the LOSC output from the RTC. This muxed output is called
> "SYS 32K" in the module clock diagram, but otherwise referred to as the
> LOSC throughout the CCU documentation.
> =

> The RC oscillator is not very accurate, even though it has an undocumented
> calibration function. We really want a precise clock at 32768 Hz,
> instead of something at around 32 KHz. This patch forces the SYS 32K
> clock to use the RTC output as its parent, and doesn't bother
> registering the internal oscillator nor a clock mux.
> =

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

