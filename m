Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D63C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5616523E39
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5616523E39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeFVHbC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:31:02 -0400
Received: from gloria.sntech.de ([95.129.55.99]:38702 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeFVHbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:31:01 -0400
Received: from p57b77a9d.dip0.t-ipconnect.de ([87.183.122.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fWGX1-0008Hj-FP; Fri, 22 Jun 2018 09:30:55 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     David Wu <david.wu@rock-chips.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?5byg5pm0?= <elaine.zhang@rock-chips.com>
Subject: Re: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for PX30
Date:   Fri, 22 Jun 2018 09:30:54 +0200
Message-ID: <18221590.FEDROxemCD@phil>
In-Reply-To: <157ecfc9-d0e6-7782-1cbc-d0fb76c81edb@rock-chips.com>
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com> <2582999.2hZx6CH9S6@diego> <157ecfc9-d0e6-7782-1cbc-d0fb76c81edb@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Am Mittwoch, 20. Juni 2018, 04:40:35 CEST schrieb David Wu:
> 在 2018年06月14日 16:30, Heiko Stübner 写道:
> > Am Donnerstag, 14. Juni 2018, 10:14:31 CEST schrieb David Wu:
> >> Hi Heiko,
> >>
> >> 在 2018年06月14日 15:54, Heiko Stübner 写道:
> >>> I don't see that new clock documented in the dt-binding.
> >>> Also, which clock from the clock-controller does this connect to?
> >>
> >> The clock is the "SCLK_GMAC_RMII" at the clock-controller, which could
> >> be set rate by the link speed.
> > 
> > Hmm, while these huge number of clocks are somewhat strange,
> > shouldn't it be named something with _rmii instead of _speed then?
> 
> Okay, it is better to be named _speed.
> 
> > 
> > Also, I don't see any clk_enable action for that new clock, so you could
> > end up with being off?
> 
> The new speed is the parent of the clk_tx_rx, to enable/disable 
> clk_tx_rx, the new clock would be also enabled/disabled.

Still it is nicer to really enable it, so that the clock-framework can keep
track of usage counts.

Because also no-one hinders the chip-designer from putting a gate in
between in one of the next socs ;-)


Heiko


