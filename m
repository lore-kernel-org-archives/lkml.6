Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA966C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D92A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D92A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966326AbeFSOtW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:49:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46968 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S965688AbeFSOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:49:20 -0400
Received: (qmail 2212 invoked by uid 2102); 19 Jun 2018 10:49:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2018 10:49:19 -0400
Date:   Tue, 19 Jun 2018 10:49:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Avi Fishman <avifishman70@gmail.com>
cc:     gregkh@linuxfoundation.org, <tmaimon77@gmail.com>,
        <venture@google.com>, <yuenn@google.com>,
        <brendanhiggins@google.com>, <mathias.nyman@linux.intel.com>,
        <bjorn.andersson@linaro.org>, <jhogan@kernel.org>, <albeu@free.fr>,
        <chunfeng.yun@mediatek.com>, <tony@atomide.com>,
        <baolu.lu@linux.intel.com>, <elder@linaro.org>, <digetx@gmail.com>,
        <kstewart@linuxfoundation.org>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] USB host: Add USB ehci support for nuvoton npcm7xx
 platform
In-Reply-To: <20180619142246.104469-2-avifishman70@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1806191044530.1473-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 avifishman70@gmail.com wrote:

> From: Avi Fishman <AviFishman70@gmail.com>
> 
> This patch adds support for ehci controller for the Nuvoton
> npcm7xx platform.
> Most of the code was taken from ehci-spear.c + specific initialization
> code
> 
> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> ---
>  drivers/usb/host/Kconfig        |   8 ++
>  drivers/usb/host/Makefile       |   1 +
>  drivers/usb/host/ehci-npcm7xx.c | 212 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 221 insertions(+)
>  create mode 100644 drivers/usb/host/ehci-npcm7xx.c
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 9f0aeb068acb..e3100b249f0f 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -185,6 +185,14 @@ config USB_EHCI_MXC
>  	---help---
>  	  Variation of ARC USB block used in some Freescale chips.
>  
> +config USB_EHCI_HCD_NPCM7XX
> +	tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
> +	depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
> +	default y

Are you sure this is what you want?  The value defaults to Y whenever 
COMPILE_TEST is enabled?  Will that annoy people doing compile tests?

Aside from that one issue,

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

