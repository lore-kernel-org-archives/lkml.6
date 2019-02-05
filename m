Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D47BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240782083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfBEP3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:29:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:52192 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729525AbfBEP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:29:12 -0500
Received: (qmail 2180 invoked by uid 2102); 5 Feb 2019 10:29:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2019 10:29:11 -0500
Date:   Tue, 5 Feb 2019 10:29:11 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Bartosz Golaszewski <brgl@bgdev.pl>
cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 0/8] ARM: davinci: move the da8xx-ohci GPIO logic into
 the driver
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
Message-ID: <Pine.LNX.4.44L0.1902051027360.1472-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to drop the hard-coded GPIO base values from the davinci GPIO
> driver's platform data, we first need to get rid of all calls to the
> legacy GPIO functions.
> 
> This series moves the GPIO logic related to da8xx-ohci out of the board
> files and into the driver code.
> 
> First two patches are just coding style tweaks. Next two add the GPIO
> lookup entries to the board files. Patch 5 add the vbus and overcurrent
> GPIO logic to the davinci USB host driver. Last three remove code that's
> no longer used.
> 
> Bartosz Golaszewski (8):
>   usb: ohci-da8xx: add a new line after local variables
>   usb: ohci-da8xx: add a helper pointer to &pdev->dev
>   ARM: davinci: omapl138-hawk: use gpio lookup entries for usb gpios
>   ARM: davinci: da830-evm: use gpio lookup entries for usb gpios
>   usb: ohci-da8xx: add vbus and overcurrent gpios
>   ARM: davinci: omapl138-hawk: remove legacy usb helpers
>   ARM: davinci: da830-evm: remove legacy usb helpers
>   usb: ohci-da8xx: remove unused callbacks from platform data
> 
>  arch/arm/mach-davinci/board-da830-evm.c     |  73 ++----------
>  arch/arm/mach-davinci/board-omapl138-hawk.c |  81 ++------------
>  drivers/usb/host/ohci-da8xx.c               | 118 ++++++++++----------
>  include/linux/platform_data/usb-davinci.h   |  14 ---
>  4 files changed, 77 insertions(+), 209 deletions(-)

For patches 1, 2, 5, and 8:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

