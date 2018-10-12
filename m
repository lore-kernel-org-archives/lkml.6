Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69155C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340DC20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340DC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeJLWZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:25:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38914 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbeJLWZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:25:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id y81-v6so10062463oia.6;
        Fri, 12 Oct 2018 07:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FaQPY6u1Odv2ZksqyM88sBreLULFY12IOj4u5TskUyc=;
        b=RmmVJVy+HQu8pWUwUtad8eW/Kxrj8jhi4X81SPQ6E/fDVo4+GWgT2REFMq3EISpGyI
         1TINu1KNQw2mmARzNQ8mDjfDaGh8armGnMyV79N4GProrJPKC/Bmh/gz3+EE85ARP7Dx
         /ZYqP2JNxWEUemGFjpQNCVfpI+kLdc95I9SfCCJPvYAYcCZEWSlKdNnVvnEbgXL8LDzF
         AKCf4wcYn+IGqd/GCmxGjQEIrZ8G3K47eYTRvvoPLIe5ck6ddJxg3p4mocJaYncxKaQq
         s5n0xCek2wt0ePC3siXph/MQ5sJikBN9ozOMi62HH9TrZ0c4c2e9VA+UBvQLVBnNfr1Y
         laug==
X-Gm-Message-State: ABuFfoiEAxLdgmzM9gZisaAY9M5ZLjHnMPwJo9nzqV93nrlJRYWHcIW7
        KkJukNSPkZl6dEkzJKcUrQ==
X-Google-Smtp-Source: ACcGV63KivqcqTnZr9rrbq0e1Y28KrHbaJmG9y7wE12as8f3SBkMDtvR7KgBcUmNdSMJNlFQszAC8g==
X-Received: by 2002:aca:b689:: with SMTP id g131-v6mr3246189oif.283.1539355973469;
        Fri, 12 Oct 2018 07:52:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t69sm391834ota.10.2018.10.12.07.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:52:52 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:52:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP
 power domain driver
Message-ID: <20181012145251.GA6489@bogus>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
 <BL2PR02MB2130719D4A82F429745DDBEEB8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL2PR02MB2130719D4A82F429745DDBEEB8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 06:41:44PM +0000, Jolly Shah wrote:
> Ping for comments

Please see my comments on other ZynqMP firmware patches. In summary, I 
need to see a complete binding, not piecemeal additions.

Rob

> 
> Thanks,
> Jolly Shah
> 
> > -----Original Message-----
> > From: Jolly Shah [mailto:jolly.shah@xilinx.com]
> > Sent: Thursday, October 04, 2018 2:24 PM
> > To: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> > geert+renesas@glider.be; bjorn.andersson@linaro.org;
> > sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> > <michals@xilinx.com>; robh+dt@kernel.org; mark.rutland@arm.com
> > Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Jolly Shah
> > <JOLLYS@xilinx.com>
> > Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power
> > domain driver
> > 
> > The zynqmp power domain driver communicates the usage requirements for
> > logical power domains / devices to the platform FW.
> > FW is responsible for choosing appropriate power states, taking Linux' usage
> > information into account.
> > 
> > This patch series is based on top of Xilinx firmware patch set:
> > https://patchwork.kernel.org/cover/10555405/
> > 
> > v3:
> >  - Changed binding to have FW node as a power controller as suggested by Rob
> >  - Updated FW driver to register it as mfd child devices from firmware probe
> >  - Move bindings location as suggested
> > 
> > v2:
> >  - Rebased on top of latest firmware driver patch series
> >  - Updated driver name from zynqmp-genpd to zynqmp-power-controller
> >  - Updated device tree bindings to move power controller node under firmware
> > node
> > 
> > Jolly Shah (1):
> >   drivers: soc: xilinx: Add ZynqMP power domain driver
> > 
> > Rajan Vaja (3):
> >   dt-bindings: power: Add ZynqMP power domain bindings
> >   firmware: xilinx: Add APIs to control node status/power
> >   firmware: xilinx: Add node IDs for zynqmp firmware
> > 
> >  .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 ++
> >  drivers/firmware/xilinx/Kconfig                    |   1 +
> >  drivers/firmware/xilinx/zynqmp.c                   |  73 ++++
> >  drivers/soc/xilinx/Kconfig                         |   9 +
> >  drivers/soc/xilinx/Makefile                        |   2 +
> >  drivers/soc/xilinx/zynqmp_pm_domains.c             | 403
> > +++++++++++++++++++++
> >  include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 ++
> >  include/linux/firmware/xlnx-zynqmp.h               |  98 +++++
> >  8 files changed, 659 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-
> > genpd.txt
> >  create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
> >  create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
> > 
> > --
> > 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
