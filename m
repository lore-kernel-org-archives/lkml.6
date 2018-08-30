Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21200C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4AB2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BIo9/M2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4AB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeH3MxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:53:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36198 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbeH3MxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:53:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so1158293wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIWBNUFtw2DamXZxHIAppm1nASHs6dmCxWRmP6GJnUk=;
        b=BIo9/M2G8rSz2eSzZ6dVfAebsIJ2vdiuQsFLjHluAiJlgV82B04IXbg13Z3pfnEaHK
         Ls+oTxqh1dPIU3yDmiH+Puo58C3BPE3BrWiaKP8rKbPEDxbYb44+VlpDcAO1LphaBYo9
         MGqf/nUrCOgV65054CR0fDcvSU5FFmfzxaBmSQDxHrVNE7Kxp3xV2EGFzLu1Fx0umXK5
         GsfGDwZI7Ybtzbr0EB9szmmJgp/v6Iz6niCfxwsO/PIShjWEUuwtNJBFIL8Jh2VrT2KI
         so1pmvZnRsIPhiRXTUvPIeNFnbUvV8Ojcs0PswDhhSC7g10QQeaWrReCHPZJvURq2kL9
         ffEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIWBNUFtw2DamXZxHIAppm1nASHs6dmCxWRmP6GJnUk=;
        b=GbQi45/WvwHFhPor+DOMuMsNvyMgWZZ9sIuZCXNzNIng92KfEgSOASA6ROhIPz4btS
         JVjUtYW4G2dtUUnhfEuQM+owHVuw1nsqx4i7wRu+6fGMWdDS+LSGxdyCcARn2vC9LB1o
         Xdmc1bzMKfsVcUnhlWxPzWxsNj692Fo3Q7QThpefIhIMh5dBGCFtQRxZWRq3sd0kyRhv
         CibwV/D3qs7GmgVWz8JM/RECvl7nJvlmHh2Fih6OhZoVpTPd6RQ248eBj5a/hHgRsAqp
         THtSnJk0MuzfD/2h3q5wmwI3b2xcnvl2yaElHnxwFjXlhJy2Psf51J+jBQCJcmECO0tE
         Wptg==
X-Gm-Message-State: APzg51AsCEBzns2ZTFDXtrEvW7FlwPllcBM13hKpTdp33A4QGM1y0+FB
        WVYIVzTczaabP6/l6Rfqbyh6BDELtKM=
X-Google-Smtp-Source: ANB0VdYvlQug8kxrGNyGgRWjP84Npw5kkb5qna6Jt0+77BsKCC1pfbWMMcuY9PbCFEG5+8zZXeCc8Q==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr1142442wme.20.1535619134985;
        Thu, 30 Aug 2018 01:52:14 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t70-v6sm1264696wmt.30.2018.08.30.01.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 01:52:14 -0700 (PDT)
Message-ID: <186a782b20053c42ca8311c421925617d83ffa07.camel@baylibre.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>, Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
Date:   Thu, 30 Aug 2018 10:52:12 +0200
In-Reply-To: <84d5399c-67d4-f8a4-3613-00d91f21292f@amlogic.com>
References: <1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com>
         <1535096165-45827-2-git-send-email-hanjie.lin@amlogic.com>
         <8c48964151d24758298ba935da336c0829e2b287.camel@baylibre.com>
         <11d7547b-feb4-6ecb-cef3-db46ce8ee2ef@amlogic.com>
         <20180829004122.GA25928@bogus>
         <84d5399c-67d4-f8a4-3613-00d91f21292f@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 15:37 +0800, Hanjie Lin wrote:
> 
> On 2018/8/29 8:41, Rob Herring wrote:
> > On Mon, Aug 27, 2018 at 04:55:20PM +0800, Hanjie Lin wrote:
> > > 
> > > 
> > > On 2018/8/24 16:22, Jerome Brunet wrote:
> > > > On Fri, 2018-08-24 at 15:36 +0800, Hanjie Lin wrote:
> > > > > From: Yue Wang <yue.wang@amlogic.com>
> > > > > 
> > > > > The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> > > > > PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> > > > > controller.
> > > > > 
> > > > > Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> > > > > Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> > > > > ---
> > > > >  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 63 ++++++++++++++++++++++
> > > > >  1 file changed, 63 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> > > > > new file mode 100644
> > > > > index 0000000..8a831d1
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> > > > > @@ -0,0 +1,63 @@
> > > > > +Amlogic Meson AXG DWC PCIE SoC controller
> > > > > +
> > > > > +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
> > > > > +It shares common functions with the PCIe DesignWare core driver and
> > > > > +inherits common properties defined in
> > > > > +Documentation/devicetree/bindings/pci/designware-pci.txt.
> > > > > +
> > > > > +Additional properties are described here:
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible:
> > > > > +	should contain "amlogic,axg-pcie" to identify the core.
> > > > > +- reg:
> > > > > +	Should contain the configuration address space.
> > > > > +- reg-names: Must be
> > > > > +	- "elbi"	External local bus interface registers
> > > > > +	- "cfg"		Meson specific registers
> > > > > +	- "config"	PCIe configuration space
> > > > > +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
> > > > > +- clocks: Must contain an entry for each entry in clock-names.
> > > > > +- clock-names: Must include the following entries:
> > > > > +	- "pclk"       PCIe GEN 100M PLL clock
> > > > > +	- "port"       PCIe_x(A or B) RC clock gate
> > > > > +	- "general"    PCIe Phy clock
> > > > > +	- "mipi"       PCIe_x(A or B) 100M ref clock gate
> > > > > +- resets: phandle to the reset lines.
> > > > > +- reset-names: must contain "phy" and "peripheral"
> > > > > +       - "port" Port A or B reset
> > > > > +       - "apb" APB reset
> > > > 
> > > > The above description is not coherent (phy <=> port)
> > > > 
> > > 
> > > Yes, this should be port and apb here.
> > > We'll integrate phy driver into ctrl driver, and move phy reset to here also.
> > 
> > Why? That's the wrong thing to do if they are separate h/w blocks. You 
> > can do whatever you like in the drivers, but the DT should reflect the 
> > h/w.
> > 
> > Rob
> > 
> > .
> > 
> 
> We have the dedicated phy driver which only process reset job,
> and we consider that it's too overkill to do just these things .
> So we will integrate phy reset job into the controller driver int the next version.

Rob has a point there. Even if overkill, it does model the HW as it is.
+ I spotted in your v2 that there is also a register access, so not only the
reset

> 
> thanks. 


