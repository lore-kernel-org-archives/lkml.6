Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6DBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059C62156B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059C62156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeHHNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:33:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbeHHNdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:33:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8280318A;
        Wed,  8 Aug 2018 04:14:35 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3F083F2EA;
        Wed,  8 Aug 2018 04:14:32 -0700 (PDT)
Date:   Wed, 8 Aug 2018 12:14:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Message-ID: <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:53:52AM +0000, Leonard Crestez wrote:
> On Tue, 2018-07-24 at 19:14 +0300, Leonard Crestez wrote:
> > Changes since v2:
> >  * Print with dev_info if link fails on resume (Lucas)
> >  * Add a comment on imx7d pci irq mappings (Andrey)
> >  * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)
> > 
> > The ltssm_disable does not return an error because it can't be usefully
> > handled, reversing partial suspend is a nightmare and unlikely to work.
> > 
> >  * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)
> > 
> > Series is against linux-next tag next-20180724 where the reset patch was
> > already accepted. The imx7d.dtsi patch is also useful standalone.
> > 
> > Link to v2: https://lkml.org/lkml/2018/7/20/472
> 
> This is a gentle reminder that this series was reviewed by Lucas two
> weeks ago but not yet included.

Does this series have a functional dependency on the reset fix ? If yes
we can have a bisection proplem depending on which tree gets merged
first.

Please let me know.

Thanks,
Lorenzo
