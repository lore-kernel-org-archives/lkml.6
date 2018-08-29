Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70A4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F4F20837
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F4F20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeH2Efg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:35:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32959 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeH2Efg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:35:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so6226075oip.0;
        Tue, 28 Aug 2018 17:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y3F/1L89+peaLfjmgMvkoCRzSlbdBvnrDYYc5739lGI=;
        b=DeYFIyMRKYhk5P/wjUReh5/gXZ0nmyP8KOgIDPDxVyZwWfyBTAZQrrHcISTcNvayMb
         Yw5AAbZE+e42HJpfUCLC+eqomco98v2kwBljzu3ERnDvx4T0wtzGmHv/zGzDAbUq7tc/
         gLHpqUxfPxixfKvmKbgMlZ+3/45G9pXn3++fDFdFuo11aEPnN5faiMgMWtmmwAJUBuai
         SVNruymjj0iykrTe121hy3xGxY48u09DWEwwszngF7aSB/7NtKdG2lH/mQ7hnf6Mrrwq
         aS9z7TEriS/ZuJwvOZhJSX63ZuBIevdtOSiBBwpQ1+sb4mbpZuMlMfITB7zAZF7IrALW
         0LMQ==
X-Gm-Message-State: APzg51CuVoaibArngRjuY0l1XF4EQvkq3sLHsKTlK0TRNGfpjLJhu1qy
        w+Cq95fMr/WM7mjHm+m4ew==
X-Google-Smtp-Source: ANB0VdYUmuYeTJeI0TOog2LHfXiFBZqPkcwWxIZJllaNDKjadYYAnBbz0KPQX1p6fJd1H4MUZpiJZw==
X-Received: by 2002:aca:4d0a:: with SMTP id a10-v6mr467019oib.175.1535503284008;
        Tue, 28 Aug 2018 17:41:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o125-v6sm3668047oig.44.2018.08.28.17.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:41:23 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:41:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
Message-ID: <20180829004122.GA25928@bogus>
References: <1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096165-45827-2-git-send-email-hanjie.lin@amlogic.com>
 <8c48964151d24758298ba935da336c0829e2b287.camel@baylibre.com>
 <11d7547b-feb4-6ecb-cef3-db46ce8ee2ef@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d7547b-feb4-6ecb-cef3-db46ce8ee2ef@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:55:20PM +0800, Hanjie Lin wrote:
> 
> 
> On 2018/8/24 16:22, Jerome Brunet wrote:
> > On Fri, 2018-08-24 at 15:36 +0800, Hanjie Lin wrote:
> >> From: Yue Wang <yue.wang@amlogic.com>
> >>
> >> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> >> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> >> controller.
> >>
> >> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> >> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> >> ---
> >>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 63 ++++++++++++++++++++++
> >>  1 file changed, 63 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >> new file mode 100644
> >> index 0000000..8a831d1
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >> @@ -0,0 +1,63 @@
> >> +Amlogic Meson AXG DWC PCIE SoC controller
> >> +
> >> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
> >> +It shares common functions with the PCIe DesignWare core driver and
> >> +inherits common properties defined in
> >> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> >> +
> >> +Additional properties are described here:
> >> +
> >> +Required properties:
> >> +- compatible:
> >> +	should contain "amlogic,axg-pcie" to identify the core.
> >> +- reg:
> >> +	Should contain the configuration address space.
> >> +- reg-names: Must be
> >> +	- "elbi"	External local bus interface registers
> >> +	- "cfg"		Meson specific registers
> >> +	- "config"	PCIe configuration space
> >> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
> >> +- clocks: Must contain an entry for each entry in clock-names.
> >> +- clock-names: Must include the following entries:
> >> +	- "pclk"       PCIe GEN 100M PLL clock
> >> +	- "port"       PCIe_x(A or B) RC clock gate
> >> +	- "general"    PCIe Phy clock
> >> +	- "mipi"       PCIe_x(A or B) 100M ref clock gate
> >> +- resets: phandle to the reset lines.
> >> +- reset-names: must contain "phy" and "peripheral"
> >> +       - "port" Port A or B reset
> >> +       - "apb" APB reset
> > 
> > The above description is not coherent (phy <=> port)
> > 
> 
> Yes, this should be port and apb here.
> We'll integrate phy driver into ctrl driver, and move phy reset to here also.

Why? That's the wrong thing to do if they are separate h/w blocks. You 
can do whatever you like in the drivers, but the DT should reflect the 
h/w.

Rob

