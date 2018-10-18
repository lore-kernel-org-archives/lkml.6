Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C3C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="JFUWZwbm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mq+hjHd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C3C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJSAy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:54:57 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57821 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727294AbeJSAy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:54:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DC259ADC;
        Thu, 18 Oct 2018 12:53:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Oct 2018 12:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DIMDT6bSST5I2HG027pPjkeYYnp
        roZYNP6E0aSxH1tM=; b=JFUWZwbmhDGqest0DezA+pNe7l4sxyUhHFkMtFOXrjW
        F5UHh63b9suJD0sHAJFLsCZlxoBwnuBllEYUS7d2FOpsiJ7P0asG6vZRYo8YcQlT
        oQ6viV+j07IjozIvobVDDt/CLiXCvxixdsZn3T8DXG/VNuZ3dmUpPAMFqd9YXkC8
        0hYDyAPe7lzYI2BEn8hTZwtlRJS7L/4oqzAjShP5ZIwLUKE/6gntNokGKZPv5HtP
        bVrdeILWgYrF0uLPUb6np5dTVfRBtB1v0HFHf4WEohCBULKuKBLkKaP3q6q/aO90
        +RtpM2wZ4tirAj8pfSKpGJ8oJV31WdX6Rp1p5AgMTIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DIMDT6
        bSST5I2HG027pPjkeYYnproZYNP6E0aSxH1tM=; b=Mq+hjHd61oHoFsTMce7f9i
        793j0+mG3uqPcrh5HbVGJirQfY1MG42oeu5Y0tgNk1b2tQ9LGR3jHUD0glTSaOQ3
        q8DKgvTGzTt5c5h1BLQcJjbfy5O3i/SY3aEvJH5RGyR2pIfgBj/9idzutm1QblK1
        xUNvvRI259nCdByw1uewCulMlkTAKNcrUtDy67FNV043hUmVfYHgAp7RxWQSYcC9
        X73cMCOIkJMm+iXEn18c06sPtH3U3Gz97ts2BRV+9p8fw4GVXMl0cUcdT6m0KIJH
        kM5WAbUzRc2JppE0xke6Wy7U275OV0VchfON7nOdK+ZVijsa/huyTxxtBZeDdxUA
        ==
X-ME-Sender: <xms:cbrIW5ehhPkNmv1Ye4B3c6Hu9IJwUg5X_o3nMv9cKY2J8wcYindCjA>
X-ME-Proxy: <xmx:cbrIW7qDnala6aH0CZ-ul7KosMDjD16pKlkjNgR8cPMBZpVr7e2rGA>
    <xmx:cbrIW0stSwaD6WDHtL5L-8f63VoGjTPA4ST3dOs9HRob8siFLFRiWQ>
    <xmx:cbrIW-ZoZJc0OUDrjwwXAO2yaHJD1m-bqR-txmKgyh6YkhqLwYwqkA>
    <xmx:cbrIW7Zr8EhxxKACNS744ELVHKqlCY1by7TKFtXTEhUBas4O9UBzxQ>
    <xmx:cbrIW_nuKVdskdtoCMQdC7xderjy1VNAks81PyGdLwUbs4lCbirSmw>
    <xmx:cbrIW4BA4nsC2j8vsStjeyj_mE_-qCR9UXzEKuWYNxiO3j1OvDhmBw>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF4CC102E2;
        Thu, 18 Oct 2018 12:53:04 -0400 (EDT)
Date:   Thu, 18 Oct 2018 18:53:03 +0200
From:   Greg KH <greg@kroah.com>
To:     Da Shi Cao <dscao999@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-terminal@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support of TI ICDI to USB simple serial device
Message-ID: <20181018165303.GA1915@kroah.com>
References: <CAG3POB=BYJ_+iYy-xNygzp2RVOaUY2qEhRn9kTSNXYUo=9a5Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG3POB=BYJ_+iYy-xNygzp2RVOaUY2qEhRn9kTSNXYUo=9a5Og@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 05:10:50PM +0800, Da Shi Cao wrote:
> In-Circuit Debug Interface is a debugging interface for TI ARM
> microcontrollers. It has three USB interfaces and two of them are
> presented as standard ACM serial device. The 3rd interface is the
> debugging interface and it can be driven as a Linux USB simple
> terminal. With it, debugging session and firmware up/down loading are
> supported on Linux.
> 
> Signed-off-by: Dashi Cao <dscao999@hotmail.com, dscao999@gmail.com>
> ---
>  drivers/usb/serial/usb-serial-simple.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/serial/usb-serial-simple.c
> b/drivers/usb/serial/usb-serial-simple.c
> index 4d0273508043..ae43088b659e 100644
> --- a/drivers/usb/serial/usb-serial-simple.c
> +++ b/drivers/usb/serial/usb-serial-simple.c
> @@ -109,6 +109,11 @@ DEVICE(suunto, SUUNTO_IDS);
>         { USB_DEVICE(0x908, 0x0004) }
>  DEVICE(siemens_mpi, SIEMENS_IDS);
> 
> +/* TI In-Circuit Debug Interface */
> +#define ICDI_IDS()              \
> +       { USB_DEVICE_INTERFACE_CLASS(0x1cbe, 0x00fd, USB_CLASS_VENDOR_SPEC) }
> +DEVICE(ti_icdi, ICDI_IDS);
> +
>  /* All of the above structures mushed into two lists */
>  static struct usb_serial_driver * const serial_drivers[] = {
>         &carelink_device,
> @@ -124,6 +129,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
>         &hp4x_device,
>         &suunto_device,
>         &siemens_mpi_device,
> +       &ti_icdi_device,
>         NULL
>  };
> 
> @@ -141,6 +147,7 @@ static const struct usb_device_id id_table[] = {
>         HP4X_IDS(),
>         SUUNTO_IDS(),
>         SIEMENS_IDS(),
> +       ICDI_IDS(),
>         { },
>  };
>  MODULE_DEVICE_TABLE(usb, id_table);
> --
> 2.11.0

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
