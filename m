Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AB0C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B46721916
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B46721916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeHLTDF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 15:03:05 -0400
Received: from sauhun.de ([88.99.104.3]:45700 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbeHLTDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 15:03:04 -0400
Received: from localhost (p5B0B5C8B.dip0.t-ipconnect.de [91.11.92.139])
        by pokefinder.org (Postfix) with ESMTPSA id 68ADB72C645;
        Sun, 12 Aug 2018 18:24:29 +0200 (CEST)
Date:   Sun, 12 Aug 2018 18:24:29 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v0.1 PATCH 0/7] mmc: tmio: refactor TMIO core a bit and add
 UniPhier SD/eMMC controller support
Message-ID: <20180812162428.GA888@kunai>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

> Add UniPhier SD/eMMC controller support.
> 
> As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
> The clock rate setting is platform-specific, and UniPhier variants
> will add another way.  I thought it would be better to split this
> to a hook to avoid a mess.

Thanks for this series! I see you did not base it on the renaming
patches. I think is a good decision because it would be a complicated
dependency. I had a glimpse on the patches and the new hook looks good
to me. I want to do full review and testing within the next two weeks.
Then, I can also comment about re-implementing the internal DMA core
handling vs. factorizing it out. It may be fine this way, I simply can't
tell now.

Regards,

   Wolfram

> 
> 
> 
> Masahiro Yamada (7):
>   mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
>   mmc: tmio: move tmio_mmc_set_clock() to platform hook
>   dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
>   mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
>   mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
>   mmc: renesas_sdhi: refactor CLK_CTL bit calculation
>   mmc: tmio: refactor CLK_CTL bit calculation
> 
>  .../devicetree/bindings/mmc/uniphier-sd.txt        |  60 ++
>  MAINTAINERS                                        |   1 +
>  drivers/mmc/host/Kconfig                           |  10 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/renesas_sdhi_core.c               |  40 +-
>  drivers/mmc/host/tmio_mmc.c                        |  56 ++
>  drivers/mmc/host/tmio_mmc.h                        |   4 +-
>  drivers/mmc/host/tmio_mmc_core.c                   |  79 +--
>  drivers/mmc/host/uniphier-sd.c                     | 694 +++++++++++++++++++++
>  9 files changed, 869 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
>  create mode 100644 drivers/mmc/host/uniphier-sd.c
> 
> -- 
> 2.7.4
> 
