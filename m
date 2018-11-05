Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012FE20854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012FE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeKESbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:31:20 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:54174 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKESbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:31:20 -0500
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1gJavu-0003pd-SA; Mon, 05 Nov 2018 10:12:30 +0100
Date:   Mon, 5 Nov 2018 10:12:30 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
Message-ID: <20181105091230.z2ooz7olbdpopxyd@viti.kaiser.cx>
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
 <20181104144614.GJ26016@tiger>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104144614.GJ26016@tiger>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thus wrote Shawn Guo (shawnguo@kernel.org):

> On Thu, Nov 01, 2018 at 06:32:47PM +0100, Martin Kaiser wrote:
> > The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
> > function blocks. Add their ipg and per clocks to the device tree.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>

> Are these EPIT devices actually used in upstream kernel, or just
> somewhere else?

Until I saw Vladimir's mail this morning, I wasn't aware of any mainline
driver that's using the EPIT devices. I found that the clocks are
missing when I tried to use EPIT with a company-internal driver that's
not suitable for mainline integration.

Still, I think that merging this patch does no harm. If the EPIT devices
are present in the DT, we should add all resources they're using.

Thanks & best regards,

   Martin
