Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE592087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfARPEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:04:51 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44040 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727415AbfARPEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:04:50 -0500
Received: (qmail 2282 invoked by uid 2102); 18 Jan 2019 10:04:49 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jan 2019 10:04:49 -0500
Date:   Fri, 18 Jan 2019 10:04:49 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ran Wang <ran.wang_1@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
In-Reply-To: <AM5PR0402MB28658F89C6853D65BB381DB4F19C0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Message-ID: <Pine.LNX.4.44L0.1901181004360.1425-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Ran Wang wrote:

> Hi Alan,
> 
> On January 18, 2019 00:08, Alan Stern wrote:
> > 
> > On Thu, 17 Jan 2019, Ran Wang wrote:
> > 
> > > arm/arm64's io.h doesn't define clrbits32() and clrsetbits_be32(),
> > > which causing compile failure on some Layerscape Platforms (such as
> > > LS1021A and LS2012A which also integrates FSL EHCI controller). So use
> > > ioread32be()/iowrite32be() instead to make it workable on both powerpc
> > > and arm.
> > 
> > For patches 1/3 and 3/3:
> > 
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Have you tested these on the Layerscape platforms to make sure they work
> > correctly?
> 
> To be honest, the first goal of this patch set is to fix compile issue. 
> And I have verified it on LS1012AQDS, and encountered failure as below:
> 
> [    2.966755] ehci-fsl: Freescale EHCI Host controller driver
> [    2.973113] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
> [    2.979851] fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 3
> [    2.987549] fsl-ehci fsl-ehci.0: irq 22, io mem 0x08600000
> [    3.005769] fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 0.00
> [    3.012122] hub 3-0:1.0: USB hub found
> [    3.016088] hub 3-0:1.0: config failed, hub doesn't have any ports! (err -19)
> 
> However, actually the only board which I can find so far has known HW issue on
> EHCI part, so I plan to find other platform to do complete verification when
> possible. And will submit other fix if needed. Is that OK?
> 
> BTW, for powerpc platform, I've tested on a T1042AD4RDB and USB worked fine with it.

Okay, that's good.

Alan Stern

