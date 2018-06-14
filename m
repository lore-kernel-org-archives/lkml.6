Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A52B1C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64848208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64848208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbeFNIbI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:31:08 -0400
Received: from gloria.sntech.de ([95.129.55.99]:51846 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752887AbeFNIbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:31:06 -0400
Received: from ip5f5a8448.dynamic.kabel-deutschland.de ([95.90.132.72] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fTNej-0003Ma-EU; Thu, 14 Jun 2018 10:30:57 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     David Wu <david.wu@rock-chips.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for PX30
Date:   Thu, 14 Jun 2018 10:30:56 +0200
Message-ID: <2582999.2hZx6CH9S6@diego>
In-Reply-To: <3aa2445f-ab2a-93b6-3a49-36be6c98d327@rock-chips.com>
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com> <1961033.25ax7s0Z5i@diego> <3aa2445f-ab2a-93b6-3a49-36be6c98d327@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Juni 2018, 10:14:31 CEST schrieb David Wu:
> Hi Heiko,
> 
> 在 2018年06月14日 15:54, Heiko Stübner 写道:
> > I don't see that new clock documented in the dt-binding.
> > Also, which clock from the clock-controller does this connect to?
> 
> The clock is the "SCLK_GMAC_RMII" at the clock-controller, which could
> be set rate by the link speed.

Hmm, while these huge number of clocks are somewhat strange,
shouldn't it be named something with _rmii instead of _speed then?

Also, I don't see any clk_enable action for that new clock, so you could
end up with being off?

And someone could convert the driver to use the new clk-bulk APIs [0],
so the large number of clk_prepare_enable calls would be a bit
trimmed down.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-bulk.c


