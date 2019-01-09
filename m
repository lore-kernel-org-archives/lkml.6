Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D085C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E33C206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbfAIPOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:14:15 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43764 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731728AbfAIPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:14:15 -0500
Received: (qmail 2161 invoked by uid 2102); 9 Jan 2019 10:14:14 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jan 2019 10:14:14 -0500
Date:   Wed, 9 Jan 2019 10:14:14 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ran Wang <ran.wang_1@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
In-Reply-To: <AM5PR0402MB28654E2A6EB5914CB3C35174F18B0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Message-ID: <Pine.LNX.4.44L0.1901091010570.1453-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Ran Wang wrote:

> > Why do you change this writel() into iowrite32be() but leave other instances
> > of writel() unchanged?  Was this a mistake?
> 
> Yes, I didn't notice there are other writel() used in this file.
> However, as I know, on both powerpc and arm SoC, EHCI FSL IP's memory mapped
> register block is always Big-endian, so I'd like to replace all writel() with iowrite32be()
> in this file. Is it necessary? 
> 
> Or I just replace them with ehci_writel() and select CONFIG_USB_EHCI_BIG_ENDIAN_MMIO?

That should work okay.  ehci_fsl_setup() sets ehci->big_endian_desc and
ehci->big_endian_mmio according to the platform data, so you just have
to make sure the platform data is initialized correctly.

Alan Stern

