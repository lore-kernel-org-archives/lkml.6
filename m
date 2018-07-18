Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119AAECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5472075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuewShHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5472075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbeGRUoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:44:21 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:37385 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeGRUoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:44:21 -0400
Received: by mail-lf0-f52.google.com with SMTP id j8-v6so4338192lfb.4;
        Wed, 18 Jul 2018 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dV7m+AxIEjwx3ExpyOoCtdzJ5sYjTa5tp8rFk/LB6Co=;
        b=DuewShHo8VRsdzUhaSJXLjlpKwkhAEovHDfuWHGxIDYWBzwaUxN8vS16BRJq0oBZi+
         lCuVe6JdPRmPa9bDXlNq0K1SdUswH276jp5V/Ctx4o5+V28SUl5stpX4iRJ8jFP1Xgyb
         NWDchepWbDm6RNoxz/s53/NsWEk+X8IX1OuWZHGhGZZPk5winHs7GhxcZJVAfp65S0Yq
         A0tgkZF5A2EZDBlMxgSgExnIhN/QJ0NGGn86aRCVUMPIhtbkMXCCMxyLSRRmRa/tCL37
         TN5K2QB2goILHGg7VkVvuSEGuqQdYJxm6mSsTc6+Kn1h0A3NTXJ6bNZQXOetLwOwoJNp
         MuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dV7m+AxIEjwx3ExpyOoCtdzJ5sYjTa5tp8rFk/LB6Co=;
        b=r2iAvqY7uuWsIfD6G/UeWnDP7FQ11RCIqtj1QmOlCkXZTcFR1Dbi+Dhn96B4kTPFLO
         YIDmmUuDIK+fEkfe8yHrPmpmJekuHbb7tSYeCWIWoGITlGzAHE+oON7E21484neofZcW
         Im+0ZSLX+CvjLa1uLTDolnqPnvR77+ARwRqdh02sV93CGkPqjSTNts+71VJt3DO/QwHD
         SnUBtdSSShuQmZZN2wx7rfDwQ/TXnGMVE/KDTbopbPIxeLojnNyfhw7a/o8VHrUEUsBJ
         Ls5QlcFKbi4Lx9Z/ooL+6XvgjfgvF7xm0n8wVmew1570SQhaTEHuP87ajF1hjid9qSYd
         xwrg==
X-Gm-Message-State: AOUpUlFwGxEKdV28w6ALhrR8d43BJibJsmGQ2lMCb7lFQhnG24hpoZwQ
        R0yeAE6zs+raGlj60SbKt5E=
X-Google-Smtp-Source: AAOMgpdVz3HX1G+eNEQ7KuDFCOTRKsyN6P2UqQz8yF+JT/4u4HyaVS9pedNg4f+a9tNwsWJcSedMiw==
X-Received: by 2002:a19:4ecd:: with SMTP id u74-v6mr4655229lfk.57.1531944292229;
        Wed, 18 Jul 2018 13:04:52 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id p20-v6sm769182lji.13.2018.07.18.13.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 13:04:51 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ffsgh-0003bW-KU; Wed, 18 Jul 2018 22:04:39 +0200
Date:   Wed, 18 Jul 2018 22:04:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "m13297920107@163.com" <m13297920107@163.com>
Cc:     johan <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moviesong@aten-itlab.cn" <moviesong@aten-itlab.cn>,
        "billli@aten-itlab.cn" <billli@aten-itlab.cn>
Subject: Re: your mail
Message-ID: <20180718200439.GK10204@localhost>
References: <2018071901551081442221@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2018071901551081442221@163.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 01:55:12AM +0800, m13297920107@163.com wrote:
> From 14bd57ea5c5fc385bd36b5a3ea5c805337bbc8db Mon Sep 17 00:00:00 2001
> From: Movie Song <MovieSong@aten-itlab.cn>
> Date: Thu, 19 Jul 2018 02:20:48 +0800
> Subject: [PATCH] USB:serial:pl2303:add a new device id for ATEN

Add spaces after the colons (':') in the Subject above, and place a
short commit message here before your SoB.

> Signed-off-by:MovieSong<MovieSong@aten-itlab.cn>

Missing spaces in you SoB as well.

> ---
>  drivers/usb/serial/pl2303.c | 2 ++
>  drivers/usb/serial/pl2303.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index 5d1a193..e41f725 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -52,6 +52,8 @@
>   .driver_info = PL2303_QUIRK_ENDPOINT_HACK },
>   { USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_UC485),
>   .driver_info = PL2303_QUIRK_ENDPOINT_HACK },
> + { USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_UC232B),
> + .driver_info = PL2303_QUIRK_ENDPOINT_HACK },
>   { USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_ID2) },
>   { USB_DEVICE(ATEN_VENDOR_ID2, ATEN_PRODUCT_ID) },
>   { USB_DEVICE(ELCOM_VENDOR_ID, ELCOM_PRODUCT_ID) },
> diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
> index fcd7239..26965cc 100644
> --- a/drivers/usb/serial/pl2303.h
> +++ b/drivers/usb/serial/pl2303.h
> @@ -24,6 +24,7 @@
>  #define ATEN_VENDOR_ID2 0x0547
>  #define ATEN_PRODUCT_ID 0x2008
>  #define ATEN_PRODUCT_UC485 0x2021
> +#define ATEN_PRODUCT_UC232B 0x2022
>  #define ATEN_PRODUCT_ID2 0x2118
>  
>  #define IODATA_VENDOR_ID 0x04bb

As I suggested earlier, try sending the patch to yourself first and run
scripts/checkpatch.pl on it. The patch is still whitespace corrupted
(probably by your mail client) as checkpatch would have let you know:

WARNING: Use a single space after Signed-off-by:
#13: 
Signed-off-by:MovieSong<MovieSong@aten-itlab.cn>

WARNING: email address 'MovieSong<MovieSong@aten-itlab.cn>' might be better as 'MovieSong <MovieSong@aten-itlab.cn>'
#13: 
Signed-off-by:MovieSong<MovieSong@aten-itlab.cn>

WARNING: please, no spaces at the start of a line
#27: FILE: drivers/usb/serial/pl2303.c:55:
+ { USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_UC232B),$

WARNING: please, no spaces at the start of a line
#28: FILE: drivers/usb/serial/pl2303.c:56:
+ .driver_info = PL2303_QUIRK_ENDPOINT_HACK },$

total: 1 errors, 4 warnings, 15 lines checked


git-send-email is convenient for sending patches (e.g. generated with
git-format-patch). Perhaps you can set that up.

One more try?

Thanks,
Johan
