Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670BFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CED20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CED20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbeGWMDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:03:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53581 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbeGWMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:03:45 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fhYcD-0003L2-FP; Mon, 23 Jul 2018 13:02:57 +0200
Message-ID: <1532343774.3501.8.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] reset: imx7: Fix always writing bits as 0
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Date:   Mon, 23 Jul 2018 13:02:54 +0200
In-Reply-To: <1532338865.3163.95.camel@pengutronix.de>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <54f436a1d2a11a379af642a3327312367ef95343.1532090446.git.leonard.crestez@nxp.com>
         <1532338865.3163.95.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-23 at 11:41 +0200, Lucas Stach wrote:
> As this doesn't depend on any other patch in this series, I think it
> would be fine if Philipp takes this patch through the reset tree.
> 
> Regards,
> Lucas
> 
> Am Freitag, den 20.07.2018, 15:47 +0300 schrieb Leonard Crestez:
> > Right now the only user of reset-imx7 is pci-imx6 and the
> > reset_control_assert and deassert calls on pciephy_reset don't toggle
> > the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
> > 1 or 0 respectively.
> > 
> > The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
> > other registers like MIPIPHY and HSICPHY the bits are explicitly
> > documented as "1 means assert, 0 means deassert".
> > 
> > The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.
> > 
> > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thank you, applied to reset/fixes.

regards
Philipp
