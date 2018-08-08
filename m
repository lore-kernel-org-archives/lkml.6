Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4524EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE07A21653
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE07A21653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeHHC6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:58:40 -0400
Received: from mx.socionext.com ([202.248.49.38]:57991 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeHHC6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:58:40 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Aug 2018 09:41:39 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 006B318015C;
        Wed,  8 Aug 2018 09:41:39 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 8 Aug 2018 09:41:38 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 3355B40377;
        Wed,  8 Aug 2018 09:41:38 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id F211612014A;
        Wed,  8 Aug 2018 09:41:37 +0900 (JST)
Date:   Wed, 08 Aug 2018 09:41:37 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/4] phy: socionext: add USB3 PHY driver for UniPhier SoC
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <1533290045-18969-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1533290045-18969-1-git-send-email-hayashi.kunihiko@socionext.com> <1533290045-18969-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <20180808094136.5509.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 18:54:03 +0900 <hayashi.kunihiko@socionext.com> wrote:

> Add a driver for PHY interface built into USB3 controller
> implemented in UniPhier SoCs.
> This driver supports High-Speed PHY and Super-Speed PHY.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> ---
>  drivers/phy/Kconfig                         |   1 +
>  drivers/phy/Makefile                        |   1 +
>  drivers/phy/socionext/Kconfig               |  12 +
>  drivers/phy/socionext/Makefile              |   6 +
>  drivers/phy/socionext/phy-uniphier-usb3hs.c | 423 ++++++++++++++++++++++++++++
>  drivers/phy/socionext/phy-uniphier-usb3ss.c | 350 +++++++++++++++++++++++
>  6 files changed, 793 insertions(+)
>  create mode 100644 drivers/phy/socionext/Kconfig
>  create mode 100644 drivers/phy/socionext/Makefile
>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

[snip]

> +static void uniphier_u3ssphy_testio_write(struct uniphier_u3ssphy_priv *priv,
> +					  u32 data)
> +{
> +	/* need to read TESTO twice after accessing TESTI */
> +	writel(data, priv->base + SSPHY_TESTI);
> +	readl(priv->base + SSPHY_TESTI);
> +	readl(priv->base + SSPHY_TESTI);

I made a mistake here. The comment and the code are inconsistent.
I'll fix it next.

Thanks,

---
Best Regards,
Kunihiko Hayashi


