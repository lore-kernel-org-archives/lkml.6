Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4300AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AD72081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544432807;
	bh=PxADLcgj8fnGACM5AT3LL43voCoIW5+Ztd1k7V7tr4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kSQr9TiOlRjd7sX60VrMiOxkHZzjDDANmdaLpSp5x4aXB2MHkedgt7HMSSYS9IJMw
	 A+LA7fFKXsFfqO4lnPmPDC9ZRP0aRcZI1E9jTi4XMCvaJWeZiiDe7/JoF9MpfinGPN
	 qZgDQMz5c3qcXWPPBGdAFNTmXFl27haMl6JiGRbU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AD72081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeLJJGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:06:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40794 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:06:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so8874092lji.7;
        Mon, 10 Dec 2018 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OGi8y75XTtmgxAc6Cgl66CnLfTeNH7UtZegJNN7vxlM=;
        b=WZjdPKyJ6/7K6c4ml/rgWDYgsH80SQz5Y2I+NKKQs8MRCWt03rdSnVpvhj7TjGQXTg
         U7gu40VGfWuW1uqcc/okLys4qLanagGQ1Vap7k8B4hZxfC9msqUDRJoPqCr9uORKqUa5
         cSk67nXhFzUlk6rdEK4nvhe0MsEuvT9aI/0+YjJqtnRCI5fSNo4lzkjgvsqbXfpAVzSE
         6Fq+rV47jv4ziXw18LCE8mM4w3Gv0+GMhK5ajNlzr7fZcAwywyhYe2LJnsRZqCceD71W
         a8YOYEcBjMOgMepeXp+A1WY1KYinkUZ4+++B8Kw+gk4aF+6Vm3yS26fjRqfjrDKEaCnz
         lnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OGi8y75XTtmgxAc6Cgl66CnLfTeNH7UtZegJNN7vxlM=;
        b=uGFdyMWEabF5JS0BG1o/qN2ox7udcPoEGAo8ETwUCndCV5PjCo8/C+f4NE24m1W9fc
         Pwkdy4Nk4C66ur7tDcsde+q8d1OlYUfEbkTL8yj/vRIidck2vqEygVrBQ0o3fbVishLA
         bHMej4AEW4YfAm84S7JSr8rwu+7ra5HoUJM/ppVbonsZnNW6zQAPbqBZ/ph8o2QDc/o4
         68ANCtgJXfcunHuO1rBpPcRxTliNcgSohW4vPjXQYdaKHmtXRJOMfLNplB2ExOpxS6wk
         IG5+ghOuZmWHbmkXsHK7ySBOuV40RLlq3Bk+y3bA1B6pMykSYdCOLh49Yfd981FnAOgc
         Q5Vw==
X-Gm-Message-State: AA+aEWbc1ahB9a95mtneEFc4+joDV0Z0jloQLEliOX0uYLi+M6YYUnpK
        z42einXXFiQdqNAnhpnXlcI=
X-Google-Smtp-Source: AFSGD/W7k3absNqO2dB5ZmTSzJuT6Lu/FD+fQ6Xk1H4Kh55FDFnZZyeUCVLz425C4j+6DTMgTOE3tQ==
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr6378184lji.93.1544432802336;
        Mon, 10 Dec 2018 01:06:42 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y11-v6sm2011859ljc.85.2018.12.10.01.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 01:06:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gWHWk-0006Rd-1b; Mon, 10 Dec 2018 10:06:58 +0100
Date:   Mon, 10 Dec 2018 10:06:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tore Anderson <tore@fud.no>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add HP lt4132
Message-ID: <20181210090658.GC31358@localhost>
References: <20181208180510.19235-1-tore@fud.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208180510.19235-1-tore@fud.no>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 07:05:12PM +0100, Tore Anderson wrote:
> The HP lt4132 is a rebranded Huawei ME906s-158 LTE modem.
> 
> The interface with protocol 0x16 is "CDC ECM & NCM" according to the *.inf
> files included with the Windows driver. Attaching the option driver to it
> doesn't result in a /dev/ttyUSB* device being created, so I've excluded it.
> Note that it is also excluded for corresponding Huawei-branded devices, cf.
> commit d544db293a44a.

> Signed-off-by: Tore Anderson <tore@fud.no>
> Cc: stable@vger.kernel.org
> ---
>  drivers/usb/serial/option.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index e24ff16d4147..1a6fa4726def 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -552,6 +552,10 @@ static void option_instat_callback(struct urb *urb);
>  #define WETELECOM_PRODUCT_6802			0x6802
>  #define WETELECOM_PRODUCT_WMD300		0x6803
>  
> +/* HP products */
> +#define HP_VENDOR_ID				0x03f0
> +#define HP_PRODUCT_LT4132			0xa31d /* Huawei ME906s-158 */
> +
>  
>  /* Device flags */
>  
> @@ -1941,6 +1945,11 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_6802, 0xff, 0xff, 0xff) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD300, 0xff, 0xff, 0xff) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x10) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x12) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x13) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x14) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(HP_VENDOR_ID, HP_PRODUCT_LT4132, 0xff, 0x06, 0x1b) },

I replaced the defines with numerical constants as we're trying to move
away from using the former (and also for consistency with the current HP
entry just above):

-       { USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
+       { USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) },    /* HP lt2523 (Novatel E371) */
+       { USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x10) },    /* HP lt4132 (Huawei ME906s-158) */
+       { USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x12) },
+       { USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x13) },
+       { USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x14) },
+       { USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x1b) },

Now applied.

Thanks,
Johan
