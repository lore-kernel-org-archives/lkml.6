Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5A1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6FB24790
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pX5XVHTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6FB24790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeGCUaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:30:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeGCUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zf9Mlk7SF/705SyNWIDS67fJBD5qkM+FWVtZ37HtJj0=; b=pX5XVHTTCZSz8NbXmOyRiUZAh
        8jEVDZRdgrfwxx2pdqrKKwLW/HvyfuaBuLCsW4qoUXhhjQB3JPBDTv8roXCqj5jTjOTEdpKmoSICs
        8imcDtjLTTgv2LxSU70F/E/wqHgrzaqqx+0wwpZD7bWpWUzAEacFG7bOYrasvX/kBOemqW2lD/NyT
        d1ZkyGuVLZe77zs0XercsImTqvsSSd2U2+finZlLj2u7F2jUjdHoB/uPmPkURvE6COORXPokDxf73
        2G8g5TwbdoQNqvJyr9uN9ud1tXK8ByLKHKJtiEc09NKuarO19/7onwyYuxm25zFNtKiJRc79GkAK+
        1UqSspTGQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faRwE-0003rr-2j; Tue, 03 Jul 2018 20:30:14 +0000
Subject: Re: [PATCH 14/15] Introduce Cadence USBSSP DRD Driver - added Kconfig
 and Makefile files.
To:     Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, ltyrala@cadence.com
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
 <1530647879-10007-15-git-send-email-pawell@cadence.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <98da7ac8-47dc-b0dd-fb13-12174a2572f7@infradead.org>
Date:   Tue, 3 Jul 2018 13:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530647879-10007-15-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 12:57, Pawel Laszczak wrote:
> Signed-off-by: Laszczak Pawel <pawell@cadence.com>
> ---
>  drivers/usb/usbssp/Kconfig  | 29 +++++++++++++++++++++++++++++
>  drivers/usb/usbssp/Makefile | 17 +++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 drivers/usb/usbssp/Kconfig
>  create mode 100644 drivers/usb/usbssp/Makefile
> 
> diff --git a/drivers/usb/usbssp/Kconfig b/drivers/usb/usbssp/Kconfig
> new file mode 100644
> index 000000000000..e55c97a2da5f
> --- /dev/null
> +++ b/drivers/usb/usbssp/Kconfig
> @@ -0,0 +1,29 @@
> +config USB_USBSSP
> +	tristate "Cadence USBSSP DRD Controller"
> +	depends on (USB || USB_GADGET) && HAS_DMA
> +	select USB_USBSSP_GADGET
> +	help
> +	  Say Y here if your system has a cadence USBSSP dual-role controller.
> +	  It supports: dual-role switch Host-only, and Peripheral-only.
> +
> +	  If you choose to build this driver is a dynamically linked

	                                     as a

> +	  module, the module will be called usbssp.ko.


-- 
~Randy
