Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3258BC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015802147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549549468;
	bh=8vLtbC6dh76i7Sjlg9l4X0Fsqht/I+dl794pb2g4h+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BSXnLU09TzRVl5v/H2oR2aaHD7tcSWCxVHfVHTkwY41KKZdodIEoy5kNyB0zYGkrW
	 USrWvXKODzeP/C4oGRM6O5tRrKN7gvWpylxlGC/b2zvlk7hplPq+HwhNXVCj8H6T9B
	 1dK9SBM//Gw7bt7EDbyA3IlNRAHB7gTZYc4nLJE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBGOY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:24:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42929 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfBGOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:24:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so9434587lja.9;
        Thu, 07 Feb 2019 06:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6tFV6BRj8BLfpz97khRzghKQBUt1w5CEhYXIcTU3ogU=;
        b=lYtc7PoMyfhSM5y+LEfp8279hVmYyyKIgTJRXf6DSTBf4Zo8+PyUDojGL3qVixUtrZ
         VeuAxzUNYFkSJckMm5lr39znuIoasS81nLpPejavqeiU0etDxDZsmirOhf7lRxxzAsS1
         bR9e9dWgEBKtCgZC0Lrdb24LUi1zqa2D98f7YCHGIHgEGuZmZ9hxr4meqNlVddXkwJLy
         kGh3mB8MYvLUsuPKQCAK4NmTaR+Ye51DZddKsKK13OaxRLflQ8pTYc9MJPKfLOCdhkn5
         3/aaRDKwG2SnEYD3bJzlISKPH9yEBXoMi0ot8qGEB4SSruuQNnBFKl8KZgVD2SEJ/91j
         PT6A==
X-Gm-Message-State: AHQUAuaenRCXaPqLg5MG4kqlabGVSl89NANmQAT0ypWzZmVMKf64pLcp
        +UkQRG3fGCAAGXC9Z2JmFfcuVKSC
X-Google-Smtp-Source: AHgI3IZ4uQgNdmy4gazQ8EvyLftiP8zI03lf60NuAEIEmosSO4lo6xR0CaqzblduGvNCU+PfGQS8rA==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr8997285ljj.49.1549549463563;
        Thu, 07 Feb 2019 06:24:23 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z4-v6sm1017726ljz.15.2019.02.07.06.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 06:24:22 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1grkbE-00056B-N4; Thu, 07 Feb 2019 15:24:20 +0100
Date:   Thu, 7 Feb 2019 15:24:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Add ID for Ingenico 3070
Message-ID: <20190207142420.GN4686@localhost>
References: <20190206161413.14536-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206161413.14536-1-mironov.ivan@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:14:13PM +0500, Ivan Mironov wrote:
> Here is how this device appears in kernel log:
> 
> 	usb 3-1: new full-speed USB device number 18 using xhci_hcd
> 	usb 3-1: New USB device found, idVendor=0b00, idProduct=3070
> 	usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> 	usb 3-1: Product: Ingenico 3070
> 	usb 3-1: Manufacturer: Silicon Labs
> 	usb 3-1: SerialNumber: 0001
> 
> Apparently this is a POS terminal with embedded USB-to-Serial converter.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>

Now applied, thanks.

Johan
