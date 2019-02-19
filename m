Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E52C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EC3217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550594296;
	bh=9ayXR1Bxlq4XHKaPzd94GKKaHz9camC4dHMKB4s8OLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hkHSRMHs2ShxW5Xqmvf4utatS3EVZaVX/VT8WhfkBZpD6kuvI0I9P6Gibg6bdvuhf
	 phq6UXIVm4eD/PYRlZSsjoafDd7fTWTL21nOW6WNY2ee/EZEpCsppwg7yEUX9nONu5
	 DRV6dPR0xhBlReWX/7FLGM/NnPmT2syXLyEGLbNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfBSQiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:38:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39078 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBSQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:38:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so10374825pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3vSKvwRq6Mlh59XGH+sEm/KyWQuNbx4IsYuOzKsqm/E=;
        b=Lb2QjnAG15w0lJMpF6lHIjAsd0J7vOpTOwVXESBgLeypgumI09WyppP3Rv5f45MPCm
         /qbCLE5FltiLnKlKq6seqgscxaIvxvKWxWH2mwu5sl/F2dfOHKFfiWyGy803OTfOjOpx
         zLWD7HAiUBlwxo/qHgG2id/qlcMFDjuCPq9SCmpk15etrJnP1eiEm3quaKRuQEzFXfkB
         vDGSsxzBG+s6pI4D3z9BrzlRYrsBQxXhnxa3E2oHpBb5Vp1uQPeGH5BSqG+7eXHV/PgK
         OGnC5dseR2/SbsVo64dN5UmALLhqmt0BLVfjtjWcaZRmDW3/t4Ji1iPlI2Rs8Cqqws42
         Rl6w==
X-Gm-Message-State: AHQUAuaQ3Ev5JABJIWkVwnx6k7sZo5591ChjojFLcpL4A6n9fBWDNUC2
        TmEbRjGE23ZTdnxj7Jd2ADQ=
X-Google-Smtp-Source: AHgI3Ia+lKBrbYt6tQOnkQwqADqQGJIH5QBM2EoMwoa8rN8BLKI9sp1hLnuJfThbXdf4al8xpCcBIA==
X-Received: by 2002:a65:5003:: with SMTP id f3mr24937180pgo.39.1550594293608;
        Tue, 19 Feb 2019 08:38:13 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id o85sm33679768pfi.105.2019.02.19.08.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 08:38:12 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Tue, 19 Feb 2019 08:38:10 -0800
Date:   Tue, 19 Feb 2019 08:38:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     yuankuiz@codeaurora.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: hardcode the debug message for -ENOENT
Message-ID: <20190219163810.GI11489@garbanzo.do-not-panic.com>
References: <7e752055f72d67a4b963436d67965123@codeaurora.org>
 <e1e9df03b288daf7258ab9e0f7402ca1@codeaurora.org>
 <20190204233047.GT11489@garbanzo.do-not-panic.com>
 <d2f930db664d8433894a7bf20db32748@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f930db664d8433894a7bf20db32748@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 04:25:10PM +0800, yuankuiz@codeaurora.org wrote:
> On 2019-02-05 07:30 AM, Luis Chamberlain wrote:
> > On Mon, Jan 14, 2019 at 05:58:30PM +0800, yuankuiz@codeaurora.org wrote:
> > > Hi,
> > > 
> > >     Refined at below.
> > > 
> > > From bbd0d9c8f28eb78ca34353347c3d4092e88f000c Mon Sep 17 00:00:00 2001
> > 
> > This is all garbled, not sure why your patch looks all messed up.
> > 
> > Are you using git sendemail or something manual?
> > 
> >   Luis
> > 
> Done. Update it with resend it as below.

Sorry but I have not received it, can you resend?
While at it please address my comment below.

> From: John Zhao <yuankuiz@codeaurora.org>
> 
> When the return code of "-ENOENT" was printed inside
> of the debug message, which could be hardcoded meaningful.

This sentence doesn't read well. Please adjust it a bit to make
coherent sense, and resend it.

Perhaps you can use something like this:

We already issue a custom firmware debug print message when no file / path
was not found, however only the error code is returned. Stating clearly
that the file was not found is much more useful for debugging, so let's
be explicit about that.

  Luis

> 
> Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
> ---
>  drivers/base/firmware_loader/main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c
> b/drivers/base/firmware_loader/main.c
> index 8e9213b..7eaaf5e 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -328,12 +328,12 @@ fw_get_filesystem_firmware(struct device *device,
> struct fw_priv *fw_priv)
>  		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
>  						msize, id);
>  		if (rc) {
> -			if (rc == -ENOENT)
> -				dev_dbg(device, "loading %s failed with error %d\n",
> -					 path, rc);
> -			else
> +			if (rc != -ENOENT)
>  				dev_warn(device, "loading %s failed with error %d\n",
>  					 path, rc);
> +			else
> +				dev_dbg(device, "loading %s failed for no such file or directory.\n",
> +					 path);
>  			continue;
>  		}
>  		dev_dbg(device, "direct-loading %s\n", fw_priv->fw_name);
> -- 
> 2.7.4
