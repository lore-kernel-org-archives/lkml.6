Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DdqYL9GZGltuNQAAmS7hNA
	; Fri, 08 Jun 2018 14:59:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CB0DB607E4; Fri,  8 Jun 2018 14:59:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1D41F60290;
	Fri,  8 Jun 2018 14:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D41F60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHO7a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:59:30 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44180 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeFHO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:59:28 -0400
Received: from localhost (unknown [172.58.216.148])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A5D20133E8163;
        Fri,  8 Jun 2018 07:59:27 -0700 (PDT)
Date: Fri, 08 Jun 2018 10:59:26 -0400 (EDT)
Message-Id: <20180608.105926.600207780816212953.davem@davemloft.net>
To: clabbe@baylibre.com
Cc: alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] net: stmmac: fix build failure due to missing
 COMMON_CLK dependency
From: David Miller <davem@davemloft.net>
In-Reply-To: <1528310722-11512-1-git-send-email-clabbe@baylibre.com>
References: <1528310722-11512-1-git-send-email-clabbe@baylibre.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Jun 2018 07:59:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Wed,  6 Jun 2018 18:45:22 +0000

> This patch fix the build failure on m68k;
> drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.o: In function `ipq806x_gmac_probe':
> dwmac-ipq806x.c:(.text+0xda): undefined reference to `clk_set_rate'
> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.o: In function `rk_gmac_probe':
> dwmac-rk.c:(.text+0x1e58): undefined reference to `clk_set_rate'
> drivers/net/ethernet/stmicro/stmmac/dwmac-sti.o: In function `stid127_fix_retime_src':
> dwmac-sti.c:(.text+0xd8): undefined reference to `clk_set_rate'
> dwmac-sti.c:(.text+0x114): undefined reference to `clk_set_rate'
> drivers/net/ethernet/stmicro/stmmac/dwmac-sti.o:dwmac-sti.c:(.text+0x12c): more undefined references to `clk_set_rate' follow
> Lots of stmmac platform drivers need COMMON_CLK in their Kconfig depends.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied.
