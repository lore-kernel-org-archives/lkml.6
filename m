Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B805FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E33820867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E33820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeH1Sr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:47:26 -0400
Received: from foss.arm.com ([217.140.101.70]:39700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbeH1Sr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:47:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 223ED18A;
        Tue, 28 Aug 2018 07:55:24 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768833F557;
        Tue, 28 Aug 2018 07:55:21 -0700 (PDT)
Date:   Tue, 28 Aug 2018 15:55:11 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RESEND] PCI: imx: Initial imx7d pm support
Message-ID: <20180828145511.GA32352@e107981-ln.cambridge.arm.com>
References: <d577303de61fb060aa428898f5df1d0bc9be89b8.1535369231.git.leonard.crestez@nxp.com>
 <20180828100758.GA27217@e107981-ln.cambridge.arm.com>
 <efcb160f08bb53620ba0570e55dbb9190275aeb0.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efcb160f08bb53620ba0570e55dbb9190275aeb0.camel@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:00:02PM +0000, Leonard Crestez wrote:
> On Tue, 2018-08-28 at 11:07 +0100, Lorenzo Pieralisi wrote:
> > On Mon, Aug 27, 2018 at 02:28:37PM +0300, Leonard Crestez wrote:
> > > On imx7d the pcie-phy power domain is turned off in suspend and this can
> > > make the system hang after resume when attempting any read from PCI.
> > > 
> > > Fix this by adding minimal suspend/resume code from the nxp internal
> > > tree. This will prepare for powering down on suspend and reset the block
> > > on resume.
> > > 
> > > Code is only for imx7d but a very similar sequence can be used for
> > > other socs.
> > > 
> > > The original author is mostly Richard Zhu <hongxing.zhu@nxp.com>, this
> > > patch adjusts the code to the upstream imx7d implemention using reset
> > > controls and power domains.
> > 
> > I will add a Suggested-by: replacing this paragraph, it is always better
> > to add proper tags rather than credit hidden in commit logs messages.
> 
> Isn't "Originally-by:" a better tag for this?

We can add that, yes or add Richard as patch author, as you prefer to
give him credit.

Lorenzo
