Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FBBECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1917F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppYCsHH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1917F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeJRXHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeJRXHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:07:49 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA36821480;
        Thu, 18 Oct 2018 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539875183;
        bh=S6czBM1rFt93PQiPfU4eYhXjZjY9wkF5xrl+D83l3eI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ppYCsHH+AbpeWcumMaB+D1zUhFzaSCmNWqeLnXKowdkx7KlSjS6KJXYsuVlpkFdOd
         bnYVw6Y0ON79ZETxt8g46gOzA2jthwVRQK+9WFkJ03Jp0tron2SNl+mvJWh7Hhfb9p
         ZjcqHCY8sjwjxm/9XUxJOq8eROp4XRa55qe85BmQ=
Received: by mail-wr1-f54.google.com with SMTP id f17-v6so2333856wrs.12;
        Thu, 18 Oct 2018 08:06:22 -0700 (PDT)
X-Gm-Message-State: ABuFfog7QzXN54Ie+eMfisR2xC1TH1K6gCUcDhaTC4ZqKwWRbnmxi7/g
        ZKbdZwHnO05ODWevRw0t9DQtM3X/mXW/wDPU4hI=
X-Google-Smtp-Source: ACcGV60tOvIluL5p8LDzqdF1g2iGhs2CzSgWqD9xqJMoAyzCgSlt9hEYwxfiwAy0u9QkQ/if+bUyWsz0Eo+AleMUyAI=
X-Received: by 2002:adf:c187:: with SMTP id x7-v6mr28702994wre.233.1539875181198;
 Thu, 18 Oct 2018 08:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-6-manivannan.sadhasivam@linaro.org> <c8d65395-c60c-5d06-92ad-c389642c22ba@gmail.com>
 <20181011164429.GA18174@Mani-XPS-13-9360> <e7abee72-23a3-4716-baf0-484514bbb019@gmail.com>
In-Reply-To: <e7abee72-23a3-4716-baf0-484514bbb019@gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 18 Oct 2018 23:06:08 +0800
X-Gmail-Original-Message-ID: <CAGp9LzoP2zkryhJCQNGpe9X0+7yUd31ffV7vM4j6KvTdfPpCrA@mail.gmail.com>
Message-ID: <CAGp9LzoP2zkryhJCQNGpe9X0+7yUd31ffV7vM4j6KvTdfPpCrA@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: mediatek: Add initial pinctrl driver for
 MT6797 SoC
To:     matthias.bgg@gmail.com
Cc:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-gpio@vger.kernel.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, mars.cheng@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:01 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 11/10/2018 18:44, Manivannan Sadhasivam wrote:
> > On Thu, Oct 11, 2018 at 05:50:19PM +0200, Matthias Brugger wrote:
> >>
> >>
> >> On 08/10/2018 21:14, Manivannan Sadhasivam wrote:
> >>> Add initial pinctrl driver for Mediatek MT6797 SoC supporting only
> >>> GPIO and pinmux configurations.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>> ---
> >>>  drivers/pinctrl/mediatek/Kconfig              |    7 +
> >>>  drivers/pinctrl/mediatek/Makefile             |    1 +
> >>>  drivers/pinctrl/mediatek/pinctrl-mt6797.c     |   82 +
> >>>  drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h | 2430 +++++++++++++++++
> >>>  4 files changed, 2520 insertions(+)
> >>>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
> >>>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
> >>>
> >> [...]
> >>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
> >>> new file mode 100644
> >>> index 000000000000..8949d2a15c39
> >>> --- /dev/null
> >>> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
> >>> @@ -0,0 +1,2430 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +/*
> >>> + * Based on pinctrl-mtk-mt6765.h
> >>> + *
> >>> + * Copyright (C) 2018 MediaTek Inc.
> >>> + *
> >>> + * Author: ZH Chen <zh.chen@mediatek.com>
> >>> + *
> >>> + * Copyright (c) 2018 Manivannan Sadhasivam
> >>> + */
> >>> +
> >>> +#ifndef __PINCTRL_MTK_MT6797_H
> >>> +#define __PINCTRL_MTK_MT6797_H
> >>> +
> >>> +#include "pinctrl-paris.h"
> >>> +
> >>> +static const struct mtk_pin_desc mtk_pins_mt6797[] = {
> >>> +   MTK_PIN(
> >>> +           0, "GPIO0",
> >>> +           MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
> >>> +           DRV_GRP3,
> >>
> >> As far as I have seen, you put all pins in driving group 3, but from the public
> >> available "Functional Specification" (page 51-81) I can see that there exist
> >> several driving groups:
> >> 2/4/6/8 mA (DRV_GRP3)
> >> 4/8/12/16 mA (not sure which group this is)
> >> 2/4/6/8/10/12/14/16 mA (DRV_GRP4).
> >>
> >
> > Not sure about that. But I derived the configuration from DRV_CFGx
> > registers available in "Application Software Register Table - Part 1"
> > from page no: 906.
> >
> > This register supports 2/4/6/8mA and this belongs to DRV_GRP2/DRV_GRP3
> > [1].
>
> I can see other driving groups as defined in the "Functional Specification" [1]
> which gets also reflected in the "Application Software Register Table - Part 1"
> [2], see for example page 852.
>
> CCing Mars, maybe he can help to clarify.
>

the driver currently only supports the basic operation, not including
driving operation, so
what value for the driving mode for a certain pin seems not really
matter in the early patch. I think these advanced operations can be
added with another patch.

> Regards,
> Matthias
>
> [1]
> https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Functional_Specification_V1_0.pdf
> [2]
> https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_1.pdf
>
> >
> > Still I'm not fully confident of my choice here. Maybe Sean can throw
> > some inputs!
> >
> > Thanks,
> > Mani
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c#n40
> >
> >> Regards,
> >> Matthias
> >>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
