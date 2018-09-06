Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8D2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA8D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeIFGLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:11:04 -0400
Received: from mx.socionext.com ([202.248.49.38]:4975 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbeIFGLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:11:03 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 06 Sep 2018 10:38:09 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id AFB2B180093;
        Thu,  6 Sep 2018 10:38:09 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 6 Sep 2018 10:38:09 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 6C17640348;
        Thu,  6 Sep 2018 10:38:09 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 2A60212013F;
        Thu,  6 Sep 2018 10:38:09 +0900 (JST)
Date:   Thu, 06 Sep 2018 10:38:08 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pci: add UniPhier PCIe host controller description
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20180905172118.GN107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1536114731-28630-2-git-send-email-hayashi.kunihiko@socionext.com> <20180905172118.GN107892@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20180906103808.2529.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thank you for reviewing.

On Wed, 5 Sep 2018 12:21:18 -0500 <helgaas@kernel.org> wrote:

> 
> Please follow the capitalization convention, i.e.,
> 
>   $ git log --oneline --no-merges Documentaon/devicetree/bindings/pci/ | grep -i pci
>   82dfbd27c837 dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
>   92f9ccca4c08 PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver DT bindings
>   71918e24cb49 dt-bindings: PCI: designware: Add support for EP in DesignWare driver
>   467c7a737642 dt-bindings: PCI: designware: Example update
>   1dca7a636933 dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe EP driver
>   2ca25bd7472f dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to rockchip-pcie-host.txt
> 
> On Wed, Sep 05, 2018 at 11:32:10AM +0900, Kunihiko Hayashi wrote:
> > Add DT bindings for PCIe controller implemented in UniPhier SoCs when
> > configured in Root Complex (host) mode. This controller is based on
> > the Designware PCIe Core.
> 
> s/Designware/DesignWare/
> s/Core/core/

Okay, I'll fix capitalization conventions in all the descriptions
according to the previous commits.

> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/pci/uniphier-pcie.txt      | 78 ++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > new file mode 100644
> > index 0000000..ea63f78
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> > @@ -0,0 +1,78 @@
> > +Socionext UniPhier PCI-express host controller bindings
> 
> s/PCI-express/PCIe/ (also in other occurrences below)
>
> > +
> > +This describes the devicetree bindings for PCI-express host controller
> > +implemented on Socionext UniPhier SoCs.
> > +
> > +UniPhier PCI-express host controller is based on the Synopsys DesignWare
> > +PCI core. It shares common functions with the PCIe DesignWare core driver
> > +and inherits common properties defined in
> > +Documentation/devicetree/bindings/pci/designware-pcie.txt.

Indeed, there are descriptions of inconsistency. I'll fix them.

Thank you,

---
Best Regards,
Kunihiko Hayashi


