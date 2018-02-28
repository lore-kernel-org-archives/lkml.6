Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeB1A4R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeB1A4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:56:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546DD21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Wed, 28 Feb 2018 08:55:56 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: imx: avic: set low-power interrupt mask for imx25
Message-ID: <20180228005555.GZ3217@dragon>
References: <1518628894-8328-1-git-send-email-martin@kaiser.cx>
 <1519766955-4302-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519766955-4302-1-git-send-email-martin@kaiser.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 10:29:15PM +0100, Martin Kaiser wrote:
> imx25 contains two registers (LPIMR0 and 1) to define which interrupts
> are enabled in low-power mode. As of today, those two registers are
> configured to enable all interrupts. Before going to low-power mode, the
> AVIC's INTENABLEH and INTENABLEL registers are configured to enable only
> those interrupts which are used as wakeup sources.
> 
> It turned out that this approach is not sufficient if we want the imx25
> to go into stop mode during suspend-to-ram. (Stop mode is the low-power
> mode that consumes the least power. The peripheral master clock is
> switched off in this mode). For stop mode to work, the LPIMR0 and 1
> registers have to be configured with the set of interrupts that are
> allowed in low-power mode. Fortunately, the bits in the LPIMR registers
> are assigned to the same interrupts as the bits in INTENABLEH and
> INTENABLEL. However, LPIMR uses 1 to mask an interrupt whereas the
> INTENABLE registers use 1 to enable an interrupt.
> 
> This patch sets the LPIMR registers to the inverted bitmask of the
> INTENABLE registers during suspend and goes back to "all interrupts
> masked" when we wake up again. We also make this the default at startup.
> 
> As far as I know, the other supported imx architectures have no similar
> mechanism. Since the LPIMR registers are part of the CCM module, we
> query the device tree for an imx25 ccm node in order to detect if we're
> running on imx25.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks.
