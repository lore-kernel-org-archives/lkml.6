Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF6AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346582087C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="pS7KrK2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346582087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754202AbeGCFoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:44:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35069 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeGCFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:44:13 -0400
Received: by mail-it0-f68.google.com with SMTP id l16-v6so1473965ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vftHCgCKId8SKQaC+CSvj//2aQyLLKPH3+0LVK4Vz4U=;
        b=pS7KrK2AOgC3tWgs/BDOLHcgK1RK0TmqZOZZbVwdfooZCRSJEdcjQZVXbqrcwJjX8Q
         AapZJJjtgXIi1/vK5yojrx6YeYALxIy05uR7C54Na7RlXVadWmfvQaIqTXsfthUxLIQ6
         R9GUwaB7biLMAAF8ZPsWzI0gXXRZskHKi9t3hOmOr9SSxQXuaePz1s2a5zT71HCS9hj3
         O5K9WUwO9mZHLeujmQ4OrrqS24YZ1CBWbshFPPNb1YMCm2zlCoPqxxZ3ph+YTvPDValt
         FciL28JDvl/SCxXy389gz4jxk5V2kqberU8mUikvK41TFdkrnaLqPcxLoLEWE4fayfIF
         kuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vftHCgCKId8SKQaC+CSvj//2aQyLLKPH3+0LVK4Vz4U=;
        b=iukvfHhVbgDUT8pgY7xgv7YCZbniaiBVUorq5qckdiPUUHqwP0BQOPdWN4Og2z/YJ0
         piSy5LCnsz3TIt2GFmV2iCPnltAfaa1iSU9p/i/GY/NaYKwdHWFMRDExY1hhD6dclED5
         6yLKxwjfvWzPUzSP14cJeBO0xiyFHdSWP8/mepOafJZcvUEL3Nob7D0IMfHByjfnWooK
         uSwXm9MG7ldXdU0/2ume+6LimgvpspR57Pij2c0nNyDc9a5eGGePMybzZi6Kw1ABJC3f
         0ezn0DAc2av0coPaqrBYHHOvXeeoN9KSkUrvewXcAazJHm/n2C6p/8efY5WnvKGIQflj
         appw==
X-Gm-Message-State: APt69E3W4er+Wp6l2D4EVEooazHTolewoykM8jXvbY1BXqYHCrhV0LaJ
        RdkMcc/dM24z1FOvkuYSoWwAu7XR7pFehE5ecYAy4Ube
X-Google-Smtp-Source: AAOMgpcYvR93WffQumiKqEcN2VvLI04IxJYmVd3eJo+Ut8iOVQSQK5Vi2dN0zrJX+rAtN23QkfnFi+zqnEBKn2Hu/oM=
X-Received: by 2002:a02:8952:: with SMTP id u18-v6mr3654630jaj.13.1530596652700;
 Mon, 02 Jul 2018 22:44:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7391:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 22:44:12 -0700 (PDT)
In-Reply-To: <20180525095452.5203-1-jian-hong@endlessm.com>
References: <20180525095452.5203-1-jian-hong@endlessm.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Tue, 3 Jul 2018 13:44:12 +0800
Message-ID: <CAPpJ_ecd0iRTY3XeZdz1ZbiJDQsGwnF4ZuqKi7pO6teRC8gmGw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add a new Realtek 8723DE ID 0bda:b009
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just gently ping.
May this patch be reviewed and merged?

Thanks,
Jian-Hong Pan

2018-05-25 17:54 GMT+08:00 Jian-Hong Pan <jian-hong@endlessm.com>:
> Without this patch we cannot turn on the Bluethooth adapter on HP
> 14-bs007la.
>
> T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=b009 Rev= 2.00
> S:  Manufacturer=Realtek
> S:  Product=802.11n WLAN Adapter
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3a477b6b3ce6..d93b25faeed9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -374,6 +374,7 @@ static const struct usb_device_id blacklist_table[] = {
>         { USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
>
>         /* Additional Realtek 8723DE Bluetooth devices */
> +       { USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
>         { USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
>
>         /* Additional Realtek 8821AE Bluetooth devices */
> --
> 2.11.0
>
