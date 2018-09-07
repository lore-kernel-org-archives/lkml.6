Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8F5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79EF20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79EF20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeIGIu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:50:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:22289 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbeIGIu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:50:28 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Sep 2018 13:11:28 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 38451180B88;
        Fri,  7 Sep 2018 13:11:28 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 7 Sep 2018 13:11:28 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 02A284035C;
        Fri,  7 Sep 2018 13:11:28 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B39E0120147;
        Fri,  7 Sep 2018 13:11:27 +0900 (JST)
Date:   Fri, 07 Sep 2018 13:11:27 +0900
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
In-Reply-To: <20180906140926.GB214747@bhelgaas-glaptop.roam.corp.google.com>
References: <20180906103819.252A.4A936039@socionext.com> <20180906140926.GB214747@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20180907131126.FACD.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, 6 Sep 2018 09:09:27 -0500 <helgaas@kernel.org> wrote:

> On Thu, Sep 06, 2018 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
> > > > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > > > @@ -0,0 +1,464 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +//
> > > > +// PCI-express host controller driver for UniPhier SoCs
> > > > +// Copyright 2018 Socionext Inc.
> > > > +// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > 
> > > Use /* ... */ comments except for the SPDX line.
> > 
> > Okay, although I wondered which way to put, I'll replace the header next.
> 
> The easiest thing is to look at similar files already in the tree and
> follow their style.  The details are here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n540
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst#n74

Thanks for your advice.
Although I've found both styles in some sub-systems, these are helpful for me.

I replaced it in posted v2.

Thank you,

---
Best Regards,
Kunihiko Hayashi


