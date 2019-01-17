Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB7EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DA9205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfAQQIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:08:20 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55624 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728448AbfAQQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:08:18 -0500
Received: (qmail 1747 invoked by uid 2102); 17 Jan 2019 11:08:17 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jan 2019 11:08:17 -0500
Date:   Thu, 17 Jan 2019 11:08:17 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ran Wang <ran.wang_1@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
In-Reply-To: <20190117091135.44209-1-ran.wang_1@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901171107150.1207-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019, Ran Wang wrote:

> arm/arm64's io.h doesn't define clrbits32() and clrsetbits_be32(), which
> causing compile failure on some Layerscape Platforms (such as LS1021A and
> LS2012A which also integrates FSL EHCI controller). So use
> ioread32be()/iowrite32be() instead to make it workable on both
> powerpc and arm.

For patches 1/3 and 3/3:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Have you tested these on the Layerscape platforms to make sure they 
work correctly?

Alan Stern

