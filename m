Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E37C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A322083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A322083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeIFGLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:11:14 -0400
Received: from mx.socionext.com ([202.248.49.38]:4981 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbeIFGLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:11:14 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 06 Sep 2018 10:38:21 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 0E79C180093;
        Thu,  6 Sep 2018 10:38:21 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 6 Sep 2018 10:38:20 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 73D1C40348;
        Thu,  6 Sep 2018 10:38:20 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 331F612013F;
        Thu,  6 Sep 2018 10:38:20 +0900 (JST)
Date:   Thu, 06 Sep 2018 10:38:20 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] pci: dwc: add UniPhier PCIe host controller support
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20180905172529.GO107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1536114731-28630-3-git-send-email-hayashi.kunihiko@socionext.com> <20180905172529.GO107892@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20180906103819.252A.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, 5 Sep 2018 12:25:29 -0500 <helgaas@kernel.org> wrote:

> Follow capitalization conventions for subject.
> 
> On Wed, Sep 05, 2018 at 11:32:11AM +0900, Kunihiko Hayashi wrote:
> > This introduces specific glue layer for UniPhier platform to support
> > PCIe host controller that is based on the Designware PCIe Core, and
> > this driver supports Root Complex (host) mode.
> 
> s/Designware/DesignWare/
> s/Core/core/

I'll fix them like [1/2].

> 
> > diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> > new file mode 100644
> > index 0000000..13ce02e
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > @@ -0,0 +1,464 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// PCI-express host controller driver for UniPhier SoCs
> > +// Copyright 2018 Socionext Inc.
> > +// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Use /* ... */ comments except for the SPDX line.

Okay, although I wondered which way to put, I'll replace the header next.

Thank you,

---
Best Regards,
Kunihiko Hayashi


