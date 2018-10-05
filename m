Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310AFC65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BEB208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aT07ugj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BEB208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJFEG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:06:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42063 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJFEG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:06:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id c8-v6so7360248plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIKSDfhj6MKmuvezKgWZ2DVKJsifqnFtcBzJjQRm48o=;
        b=aT07ugj9JyMovQS6zeeKTcR/onv3Oqch+bN2Unhqw4EnUy08EspuuiOzcRaA9fTtOK
         AH00D3BsweB+ABd8uTyglZlC016xQmAD7NyIOnDaufcP2oFejsxcONcHC8TpX3MhXGcT
         GAe0+NU6nZkIP6CKM4WfigjQq+7pA//soaiGNtpZB7WYT8+zqAtFmY61BOOs4EGf9NWe
         ESQguy1JhmN38DQmooF2J1vw/AXDjW7AFmOtLWw1DgptAdHtIAfqf3ZMBGConezfnJi3
         rzSUlRBaAbRNHv3Uxcjg3yxcjdJOz7jdmYhDyqEF5Gvb1o9hmIr4xKcQsGU6/qLGuGNs
         Upfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIKSDfhj6MKmuvezKgWZ2DVKJsifqnFtcBzJjQRm48o=;
        b=KJVkmajLuLL0fiJ3Zb0u9TFoIzkQ+3jXy8yACbUNbPGiotiLXyUMt07Rc+KH9EpWWq
         DYbY9gblVujCgr/JUYkHcGVewy0kPNWctXVSjVwZI+tPANYE1lGkf8SavW4Y1lCDJtPO
         232pdyi84Ue2a/cGUchK0oT43dTdO3G3q+p9FlJAStRjRvyEf7IlCrip6UBR2lE+RpMg
         cp0cECPioofk+eIRQ25h7+/MrWXjYHicc7jagI8yxTGwuRpw1xPrAjcUP1qoMNZ7VZgX
         kaInENsco6UhFhNUD19GyP5joSGk7fES9NzWwiS/Nuvphyqk5UrhRew8sz86x1Snw0SS
         G4zQ==
X-Gm-Message-State: ABuFfohdHBKJ/tOk6+0tSIu5g7kNhYJkFjWcWy2H/z5xbjrfJAspqOWM
        5mKWCYrwrLS1sS+Hdt9imtWh54dAehEVKhkFCSHkYA==
X-Google-Smtp-Source: ACcGV62PKcBh47pUoFTt2mK33fLB8MN0tsh+wKEhlXCO3jccBYQ7l6IzY8jVW9tncXysxrF3aIZqkYIEEQZFFLxdIvY=
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr13230157pls.217.1538773557585;
 Fri, 05 Oct 2018 14:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181004055559.3197-1-natechancellor@gmail.com>
In-Reply-To: <20181004055559.3197-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Oct 2018 14:05:45 -0700
Message-ID: <CAKwvOdk7v2KhA2DW6eh8RgGt-WyQQhCSp=hKgcWra8Jw9vLOJQ@mail.gmail.com>
Subject: Re: [PATCH] staging: emxx_udc: Remove unused device_desc declaration
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, damm+renesas@opensource.se,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 10:56 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/staging/emxx_udc/emxx_udc.c:1373:37: warning: variable
> 'device_desc' is not needed and will not be emitted
> [-Wunneeded-internal-declaration]
> static struct usb_device_descriptor device_desc = {
>                                     ^
> 1 warning generated.
>
> This definition hasn't been attached to anything since the driver was
> introduced in commit 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile
> USB Gadget driver") and neither GCC nor Clang emit any reference to the
> variable in the final assembly. The only reason GCC doesn't warn about
> this variable being unused is the sizeof function.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> This seems kind of wrong given this is a USB driver but there isn't an
> instance of a platform_driver in the kernel tree having a usb device
> descriptor declaration so I'm unsure of how to handle this warning aside
> from just removing the definition but I'm certainly open to suggestions.

In drivers under drivers/usb/gadget/legacy/{ether|mass_storage|hid}.c,
it seems that addresses of instances of `struct usb_device_descriptor`
are stored in instances of `struct usb_composite_driver eth_driver`
that are passed to module_usb_composite_driver().

drivers/staging/emxx_udc/emxx_udc.c doesn't mention anything about
being a composite driver, and I don't know if there are multiple
devices to warrant a composite driver?  Composite seems to imply "more
than one gadget" while the path to drivers using this interface under
drivers/usb/gadget/legacy/ seem to imply there's a modern (non-legacy)
usb gadget interface that could potentially be used instead.

If this was never intended to be a composite usb driver, or there's
some reason why it doesn't make sense for it to be one, then this code
is likely dead and your fix is correct.  If it's not, maybe folks who
know more about the USB interfaces have another solution to make this
a composite usb driver?

>
>  drivers/staging/emxx_udc/emxx_udc.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 0e8d3f232fe9..65cc3d9af972 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -1368,25 +1368,6 @@ static void _nbu2ss_set_endpoint_stall(
>         }
>  }
>
> -/*-------------------------------------------------------------------------*/
> -/* Device Descriptor */
> -static struct usb_device_descriptor device_desc = {
> -       .bLength              = sizeof(device_desc),
> -       .bDescriptorType      = USB_DT_DEVICE,
> -       .bcdUSB               = cpu_to_le16(0x0200),
> -       .bDeviceClass         = USB_CLASS_VENDOR_SPEC,
> -       .bDeviceSubClass      = 0x00,
> -       .bDeviceProtocol      = 0x00,
> -       .bMaxPacketSize0      = 64,
> -       .idVendor             = cpu_to_le16(0x0409),
> -       .idProduct            = cpu_to_le16(0xfff0),
> -       .bcdDevice            = 0xffff,
> -       .iManufacturer        = 0x00,
> -       .iProduct             = 0x00,
> -       .iSerialNumber        = 0x00,
> -       .bNumConfigurations   = 0x01,
> -};
> -
>  /*-------------------------------------------------------------------------*/
>  static void _nbu2ss_set_test_mode(struct nbu2ss_udc *udc, u32 mode)
>  {
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
