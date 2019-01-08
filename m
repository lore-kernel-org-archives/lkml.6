Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7499C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3882087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfAHQLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:11:38 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53538 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728854AbfAHQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:11:38 -0500
Received: (qmail 1649 invoked by uid 2102); 8 Jan 2019 11:11:37 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2019 11:11:37 -0500
Date:   Tue, 8 Jan 2019 11:11:37 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Ran Wang <ran.wang_1@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>
Subject: Re: [PATCH 1/3] usb: kconfig: remove dependency FSL_SOC for ehci
 fsl driver
In-Reply-To: <20190108060426.11581-1-ran.wang_1@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901081110550.1355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Ran Wang wrote:

> From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> 
> CONFIG_USB_EHCI_FSL is not dependent on FSL_SOC, it can be built on
> non-PPC platforms.
> 
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/usb/host/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 16758b1..53cbc0c 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -179,8 +179,8 @@ config XPS_USB_HCD_XILINX
>  		devices only.
>  
>  config USB_EHCI_FSL
> -	tristate "Support for Freescale PPC on-chip EHCI USB controller"
> -	depends on FSL_SOC
> +	tristate "Support for Freescale on-chip EHCI USB controller"
> +	depends on USB_EHCI_HCD

This line is not needed.  The entire entry lies within an "if 
USB_EHCI_HCD" block.

Alan Stern

>  	select USB_EHCI_ROOT_HUB_TT
>  	---help---
>  	  Variation of ARC USB block used in some Freescale chips.
> 

