Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A87C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73C82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73C82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeLJKgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:36:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54888 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLJKgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:36:22 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7E8C920D92; Mon, 10 Dec 2018 11:36:19 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3166C20D23;
        Mon, 10 Dec 2018 11:36:09 +0100 (CET)
Date:   Mon, 10 Dec 2018 11:36:09 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181210113609.59355f12@bbrezillon>
In-Reply-To: <f51ab7b2-bc23-1a8f-5970-18c2d200eb6a@kontron.de>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
        <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181210111909.35384eee@bbrezillon>
        <f51ab7b2-bc23-1a8f-5970-18c2d200eb6a@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 10:31:57 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> >> Yes, I need to validate op->addr.nbytes else LUT would going to be programmed for 0 addrlen.
> >> I have checked this on the target.  
> > 
> > Also agree there. Some operations have 0 address bytes. We could also
> > test addr.buswidth, but I'm fine with the addr.nbytes test too.  
> 
> The "if (op->addr.nbytes)" is needed of course, but I think the default 
> case in the switch statement (and for other reasons the whole switch 
> statement) is not needed and rather a check for op->addr.nbytes > 4 
> should be added to nxp_fspi_supports_op(). I wrongly assumed this check 
> already exists in nxp_fspi_supports_op().

Ok, then this check on the max number of address bytes should indeed be
moved to the supports_op() implementation.
