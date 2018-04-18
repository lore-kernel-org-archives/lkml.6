Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeDRX12 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752849AbeDRX11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:27:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7457121781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1524052351-14103-1-git-send-email-yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
References: <1524052351-14103-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <152409404578.51482.16644171573677016161@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: sunxi-ng: replace lib-y with obj-y
Date: Wed, 18 Apr 2018 16:27:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2018-04-18 04:52:31)
> We had commit 06e226c7fb23 ("clk: sunxi-ng: Move all clock types to a
> library") and commit 799c43415442 ("kbuild: thin archives make default
> for all archs") in the same development cycle, from different trees.
> 
> With migration to the thin archive, the entire drivers/clk/sunxi-ng/lib.a
> is linked to the vmlinux.  This does not break build, but we do not get
> any size saving.
> 
> However, we do not need to go back to the individual Kconfig options.
> The default configuration pulls in all (or most) of the CCU parts anyway.
> Also, once we enable CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, we can simply
> list all files with obj-y, and the linker will drop all unused functions
> by itself.
> 
> After the long discussion [1], people there agreed to fix this, but
> nobody sent a patch after all.  I am doing it now.
> 
> I lifted up CONFIG_SUNXI_CCU to drivers/clk/Makefile because everything
> in drivers/clk/sunxi-ng/ depends on SUNXI_CCU.
> 
> [1] https://patchwork.kernel.org/patch/9796521/
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks for remembering to take care of this. I forgot about it all.

Acked-by: Stephen Boyd <sboyd@kernel.org>

Or I can pick this up directly. Let me know.
