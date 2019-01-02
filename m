Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E48C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320BA2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfABVGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:06:44 -0500
Received: from hs01.dk-develop.de ([173.249.23.66]:56172 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfABVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:06:43 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 16:06:42 EST
Received: from mail.dk-develop.de (hs01.dk-develop.de [IPv6:::1])
        by hs01.dk-develop.de (Postfix) with ESMTP id 6BD971C7F5F;
        Wed,  2 Jan 2019 21:57:00 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Jan 2019 21:57:00 +0100
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     Jack Stocker <jackstocker.93@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Harry Pan <harry.pan@intel.com>,
        Kamil Lulko <kamilx.lulko@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB
In-Reply-To: <1546454264-11561-1-git-send-email-jackstocker.93@gmail.com>
References: <1546454264-11561-1-git-send-email-jackstocker.93@gmail.com>
Message-ID: <68e03db778525f1d26d72a683bc0e0e2@dk-develop.de>
X-Sender: danilokrummrich@dk-develop.de
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You're referring to this patch
cb88a0588717 ("usb: quirks: add control message delay for 1b1c:1b20")
I guess. Maybe you want to name it explicitly for better reference.

Acked-by: Danilo Krummrich <danilokrummrich@dk-develop.de>


On 2019-01-02 19:37, Jack Stocker wrote:
> To match the Corsair Strafe RGB, the Corsair K70 RGB also requires
> USB_QUIRK_DELAY_CTRL_MSG to completely resolve boot connection issues
> discussed here: https://github.com/ckb-next/ckb-next/issues/42.
> Otherwise roughly 1 in 10 boots the keyboard will fail to be detected.
> 
> Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
> ---
>  drivers/usb/core/quirks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 7909262..4a9267d 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -377,7 +377,8 @@ static const struct usb_device_id usb_quirk_list[] 
> = {
>  			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
> 
>  	/* Corsair K70 RGB */
> -	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
> +	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT |
> +	  USB_QUIRK_DELAY_CTRL_MSG },
> 
>  	/* Corsair Strafe RGB */
>  	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
