Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC6EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAB9222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bIC1B4Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390746AbfBMIjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:39:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38789 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390731AbfBMIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:39:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id n15so1125195lfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iOifMK0uBt7VTyazd6LE6XG5PgJEOOOxaUYoLYDd+0c=;
        b=bIC1B4Tx59QTCm1j4b5+dNqPVezqd2Hauwax9QKOqr8z7vY5PW/9UpvbSWwqQJIAGA
         PQUoPB0XhVVLl23zGORNtyyrMaSGUiFGWAEcMHsViQN5VaqWWVAAYYpl8mvjZR9kXu6D
         QRw7m/e+J91purVSYZb1oadNxG7RO71iyEfGzKkaPZn3V7s7ra9en0khucvoP6dAzmmM
         vAzkCJzwEfU8IagmG/5f7uvov0Ynq8qttj5TPW+rnKec3PGGmvjU6dFOlYMR8dhUv2PA
         bXgWQinDeLkhJla1zCojZYtqPkst9YeI05/+ufyeTAFuwgiIrdOUWA0xXClElSQWXrlh
         v6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iOifMK0uBt7VTyazd6LE6XG5PgJEOOOxaUYoLYDd+0c=;
        b=Sy187V/n76ACBN/Asd/00f1NUg+P2zW9NaVamo8e5/PGlLePaP7KIVzkF8Dv1NxK1j
         WXxSdkHIZTje/KE9O0OSM/zrI9yyRF5yNDAaqhUWeJrNJ9ao43nrbqZ4HNSh5W/9hA+N
         43HzD/MaQh0qmbJ0jkhQ5CsAtzyXFLBWk7SfGh7nKSEM1N40nDDWAFzwxFFYeAkTeDte
         ZWWZlFV+LaHj+j8KU3GlHUbYvF4dQz43/QVdhutxhJPib0Gwv6M2DED1m+M9escIGu1E
         bPpocUTsG2nBObRp+A3QK9PmKDs7N5b9alc00qFd6e7hnUdyo0ZhliNs09U/EuaKuQnV
         k4CQ==
X-Gm-Message-State: AHQUAub17stU0aiR/moyAWxkc6N0/Cqhk3iPfy2YM8PtAePLowJiUelS
        225vwTMn3wySMSbL4tqFbSF0WTZCqSc=
X-Google-Smtp-Source: AHgI3IYsnuTbxHqB5YuPCLIhSNo6vgI44z/hRb1M5ueKJhFWinNLVJhB9u+5UC5UGZ25VRYyPxFKmQ==
X-Received: by 2002:a19:7507:: with SMTP id y7mr5454087lfe.140.1550047146721;
        Wed, 13 Feb 2019 00:39:06 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.178])
        by smtp.gmail.com with ESMTPSA id x26sm2733103lfe.45.2019.02.13.00.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 00:39:05 -0800 (PST)
Subject: Re: [PATCH v3 7/9] usb: typec: Find the ports by also matching
 against the device node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
 <20190213074557.66028-8-heikki.krogerus@linux.intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <4df6b497-6abb-c680-165b-6d17d72c93e7@cogentembedded.com>
Date:   Wed, 13 Feb 2019 11:38:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213074557.66028-8-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2019 10:45, Heikki Krogerus wrote:

> When the connections are defined in firmware, struct
> device_connection will have the fwnode member pointing to
> the device node (struct fwnode_handle) of the requested
> device, and the endpoint will not be used at all in that
> case.
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/usb/typec/class.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 45abe2c7e9f3..2eb623841847 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
[...]
> +	/*
> +	 * FIXME: Check does the fwnode supports the requested SVID. If it does

    Perhaps "check if the fwnode supports"? Or at least s/supports/support/...

[...]

MBR, Sergei
