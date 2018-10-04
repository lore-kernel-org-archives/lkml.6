Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB42EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CD92064E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CD92064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJDQDC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:03:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57961 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeJDQDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:03:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 966F920719; Thu,  4 Oct 2018 11:10:40 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 48A5920618;
        Thu,  4 Oct 2018 11:10:30 +0200 (CEST)
Date:   Thu, 4 Oct 2018 11:10:30 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Vignesh R <vigneshr@ti.com>, Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "juliensu@mxic.com.tw" <juliensu@mxic.com.tw>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>,
        "masonccyang@mxic.com.tw" <masonccyang@mxic.com.tw>
Subject: Re: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
 mt35xu512aba
Message-ID: <20181004111030.4ae3670c@bbrezillon>
In-Reply-To: <VI1PR04MB103837831B8BFEC2F7FD12E799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
        <20181003165603.2579-2-vigneshr@ti.com>
        <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181004093925.2961d881@bbrezillon>
        <VI1PR04MB103837831B8BFEC2F7FD12E799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018 08:47:33 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > 
> > Yogesh, you already sent "spi: add flags for octal I/O data
> > transfer" [3] which is only adding the new OCTAL flags but is not
> > patching spi.c and spi-mem.c to take those new flags into account.
> > Here is my version of this patch [2] (it's still missing an update
> > of SPI_MEM_MAX_BUSWIDTH). Let me know what you want to do (rework
> > your version to address the problem or take mine). 
> I haven't said that I have sent the patches.

Well, you at least sent one of them, I know it because I was in
CC :P.

> My patches are ready and needed to be sent for review.

I initially told you to drop those patches because we didn't have a
user yet, that's about to change, so I guess we're all good.

> In these patches,  I am adding support for X-X-X protocol for octal
> support and integrating them with spi  and flash m25p80 interface.

From what I've seen you're not adding support of 8-8-8 but for 1-8-8 an
1-1-8, which is a lot easier to deal with (it's completely stateless,
which is what the spi-nor expects). Unless you're talking about other
patches you haven't sent yet...

