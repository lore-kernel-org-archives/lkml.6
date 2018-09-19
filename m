Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E03ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A5420858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkUiqua6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A5420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeITFKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 01:10:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41368 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeITFKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 01:10:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so6616139ljy.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=chn+sgkuXa4SOG8ZBaPsJB6cSes98b5j4z2c8rwadJk=;
        b=DkUiqua6k7wm50qDETskub6csIT0XlpVJ/WtQzyiD3OIzi2pjwly0YV5kohJw5UJN4
         y7x2l05ERW+cOG62aAFa13C2np7fE3aH5UOqRxgjHQuZxNeI5/wh64jfsn/0Zvhqp+Eq
         QBoaho4+G8WtmIRaQMHwZzgI9+Xon7TTRb6kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=chn+sgkuXa4SOG8ZBaPsJB6cSes98b5j4z2c8rwadJk=;
        b=hxRtNdSe4jP+A5XxuOAwpy6G8VAFrbVEGhyfhN0e6be5GE9ntRiFtK2C/hvJJSmQqw
         ufQ3NGzTjEpz9ko9e97UX+FBipgHq2F3NhkyAk1SVzMiWKH0WYTUc9x2WgdeS8ChSCp9
         T+SlOLdONWvU+g3r8HbBTlsZ7ETm+NB/q+/8DcCmzzn1Wv1FznEzE7rMFQt5Dt32UBk2
         fQe4LzGqGLdcVH+UuZztVF6baqxqobN9DtPrx1ysNM57AYimCV2q1RoNsLb0sSCCCMEx
         QI5lZeg+A41kJqQ17H8Ihd0ONl0VvjTAuqXjjJTBUB7f3UxnImrgWz79NZBjxBXyVPvs
         plyQ==
X-Gm-Message-State: APzg51Cz1zyhhtK14jyg2EBwsScH9LKsSy6JewNdlFAm9oVg3X1Hscd/
        dC3aE9koaVDGLHjjpWmD3ZgxtKAJqyYDSVpNlOuZCg==
X-Google-Smtp-Source: ANB0VdaWiB41dwmHDfdYL5z89RIosvNEfFi1ykSvlDPcCOO9YHWpoDzTnmUXbtIM9Ip5LJT7qICQEj8tEctjmyHch3Y=
X-Received: by 2002:a2e:8957:: with SMTP id b23-v6mr3095286ljk.50.1537399804046;
 Wed, 19 Sep 2018 16:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 19 Sep 2018 17:29:52 -0600
Message-ID: <CANLsYkw15j2E-sB8YXHD7datLJ_JyyCoTX4Bd+cnLyc-Eizayg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] dts: Update coresight device tree bindings
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>,
        alexandre.belloni@bootlin.com, Andy Gross <andy.gross@linaro.org>,
        bcousson@baylibre.com, David Brown <david.brown@linaro.org>,
        fabio.estevam@nxp.com, Ivan Ivanov <ivan.ivanov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, lipengcheng <lipengcheng8@huawei.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        nicolas.ferre@microchip.com, Orson Zhai <orsonzhai@gmail.com>,
        kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, tony@atomide.com,
        xuwei <xuwei5@hisilicon.com>, Lyra Zhang <zhang.lyra@gmail.com>,
        arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 at 07:54, Suzuki K Poulose <suzuki.poulose@arm.com> wro=
te:
>
> Coresight DT bindings have been updated to obey the DTS rules
> for label/address matching for graph nodes. The changes are in
> coresight/next tree scheduled for v4.20. This series updates the
> in kernel dts to match the new bindings along with updating a couple
> of new examples (e.,g CATU) in the Documentation (which were missed
> as they were still in flight when we created the series).
>
> Please note that this should not be pulled for v4.19, which I think
> is a safe assumption. But please do pull it for v4.20.
> The dt updates for the Juno boards were sent earlier with the original
> DT update series and has been queued for v4.20.
>
> Applies on coresight/next (which is based on v4.19) and should apply
> cleanly on v4.19-rc3.
>
> Changes since V1:
>  - Avoid "avoid_unnecessary_addr_size" warnings by removing
>    #address-cells/#size-cells for single port with address 0.
>  - Fix TPIU inport for qcom msm8196.  (Leo Yan)
>  - Fix documentation example for TPIU (Leo Yan)
>  - Fix subject tags (as pointed out by Leo and Shawn)
>  - Drop patch for TC2, which has been queued by Sudeep
>
>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Beno=C3=AEt Cousson <bcousson@baylibre.com>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-omap@vger.kernel.org
> Cc: lipengcheng8@huawei.com
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: orsonzhai@gmail.com
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: xuwei5@hisilicon.com
> Cc: zhang.lyra@gmail.com
> Cc: arm@kernel.org
>
>
> Suzuki K Poulose (11):
>   coresight: dts: binding: Fix example for TPIU component
>   coresight: dts: binding: Update coresight binding examples
>   arm64: dts: hi6220: Update coresight bindings for hardware ports
>   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
>     ports
>   arm64: dts: msm8916: Update coresight bindings for hardware ports
>   arm: dts: hip04: Update coresight bindings for hardware ports
>   arm: dts: imx7: Update coresight binding for hardware ports
>   arm: dts: omap: Update coresight bindings for hardware ports
>   arm: dts: qcom: Update coresight bindings for hardware ports
>   arm: dts: sama5d2: Update coresight bindings for hardware ports
>   arm: dts: ste-dbx5x0: Update coresight bindings for hardware port
>
>  .../devicetree/bindings/arm/coresight.txt     |  27 +-
>  arch/arm/boot/dts/hip04.dtsi                  | 346 +++++++++---------
>  arch/arm/boot/dts/imx7d.dtsi                  |  14 +-
>  arch/arm/boot/dts/imx7s.dtsi                  |  82 ++---
>  arch/arm/boot/dts/omap3-beagle-xm.dts         |  17 +-
>  arch/arm/boot/dts/omap3-beagle.dts            |  17 +-
>  arch/arm/boot/dts/qcom-apq8064.dtsi           |  71 ++--
>  arch/arm/boot/dts/qcom-msm8974.dtsi           | 104 +++---
>  arch/arm/boot/dts/sama5d2.dtsi                |  17 +-
>  arch/arm/boot/dts/ste-dbx5x0.dtsi             |  65 ++--
>  .../boot/dts/hisilicon/hi6220-coresight.dtsi  | 181 +++++----
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  95 ++---
>  arch/arm64/boot/dts/sprd/sc9836.dtsi          |  82 +++--
>  arch/arm64/boot/dts/sprd/sc9860.dtsi          | 215 +++++------
>  14 files changed, 682 insertions(+), 651 deletions(-)

I have applied patch 1 and 2 in this set.

Thanks,
Mathieu

>
> --
> 2.19.0
>
