Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0694AC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED3B21A8F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc1ki0HB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED3B21A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933414AbeFUUhu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:37:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44730 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932885AbeFUUht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:37:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id h12-v6so2072494pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2SpQUdWhkmJF0k4d/D8e8DVuHPqitvtlOV7xXSzP9d0=;
        b=Cc1ki0HBxe/u0imt9Uptc1hfTiM+14O9QsQIOF6ZPaZKNGmYz7lrq/TeLUfGIBYkO9
         N3nVnU1M9HLg0F/tOU+/XViZ7JTR2yrRggdiZLwTDRASF2vDA1VIrwhnjn2qK80nSluI
         hA37ErBr9oR4Dj+DEtsfr81GdyX/1mQ5P8XdFjaOiPTctZexvvSiil0UH/2OuFJDnn/O
         2nO/IF4YgmS3BFwyVoDRqAEnG+AFM6UXoIbHWj+f2QoHDuhOfFCKVFw9wc5Lny1aSD+k
         gEuzi/myDKe4tId7rwSnGADA//Yzq5NRODAZQdCj4qx9aKu9XzIx1fU2clOeFyJavyCQ
         a3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2SpQUdWhkmJF0k4d/D8e8DVuHPqitvtlOV7xXSzP9d0=;
        b=hY1bMQWC70Lm99Nx4b9zhCGVa1YZ3CUg50DRS9OULBMKpQgXRom6yPc6+bBXUa25RC
         10Ok5oRA5Upek6L9dvu1cOwYAv//sAdT9kjlsixsdl96jrciqy3jKJDJKYIGEBllLRx6
         RI9l1fKbK8a3S/iJA9ZYrtRRArTMhnD2xN4ONZiatQ3EN8KoNWD3jZvoKd0KXN9Wr3+W
         Ul8jfYD74JANUvzBQ3Bk3DbdyrRYJJuo+dJ/wooPssNtozrgGth8rAcgfrIyX8+ZohE6
         0EE3uD83rsUngEuOokp2ek2ZuIPfAIDIoPhrfB2L6KM08HXlbsPnmBHUECLqNIOCwMBy
         gfaA==
X-Gm-Message-State: APt69E3Alv+masJTf73I4l2MzP446RC0Wm/tBaqBz4+YVNvFgGIEdO6V
        GhurdtLa5J19ZMeqBtivmCM=
X-Google-Smtp-Source: ADUXVKK9qDUVjzi69wNXngB9DZVyc9ZU1lDoMIYw8IDg72HQIi93ZzwTIBbG5KRs16LLmFi2e/DhTQ==
X-Received: by 2002:a63:7f15:: with SMTP id a21-v6mr23747677pgd.21.1529613468684;
        Thu, 21 Jun 2018 13:37:48 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id q19-v6sm8667720pff.9.2018.06.21.13.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 13:37:47 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:37:45 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matt Delco <delco@chromium.org>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.or, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: intel-vbtn: Ignore extraneous events from
 tablet mode
Message-ID: <20180621203745.GA50452@dtor-ws>
References: <20180621201207.178426-1-delco@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621201207.178426-1-delco@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:12:07PM -0700, Matt Delco wrote:
> The Dell laptop I have has an ACPI that sends 0xCB and 0xCC on entering
> tablet mode.  On exiting tablet mode it sends 0xCA and 0xCD.  This
> change has the driver ignore 0xCA and 0xCB.
> 
> Signed-off-by: Matt Delco <delco@chromium.org>

This looks good to me.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/platform/x86/intel-vbtn.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index c13780b8dabb..4c6f2bb1d1ac 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -38,8 +38,10 @@ static const struct key_entry intel_vbtn_keymap[] = {
>  	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
>  	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key press */
>  	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key release */
> -	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet */
> -	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop */
> +	{ KE_IGNORE, 0xCA, { KEY_UNKNOWN } },			/* Laptop key press */
> +	{ KE_IGNORE, 0xCB, { KEY_UNKNOWN } },			/* Tablet key press */
> +	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet key release */
> +	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop key release */
>  	{ KE_END },
>  };
>  
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 

-- 
Dmitry
