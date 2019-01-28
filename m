Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C5BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3422171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhXSymGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfA1NyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:54:03 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41729 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:54:03 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so14644593otk.8;
        Mon, 28 Jan 2019 05:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dewdheXsERU+vQDnag1Ee60H9kCbIKcxr8jfS0p/Gos=;
        b=QhXSymGvPEIkZSoixO+pwGwgH3sPWmnFs3RuKj3QdBLjiwkRaJZB+IUvRES3lqRcVS
         cyRh0HHl3dHRmabDGroG9OEWv+brRcC986HGrxwGOhF1hrO1QPVLe2k4I7JDYHDEZaBP
         dWU2H1rbXiUFbQ0sEP9Rq4HyCMpry4AIpzcZQ6KoL7c6wlqjiRibx/+v7lWsEet1FcJt
         3MXSciGJyzzl5OBySKe6Ay14m/A5P1bcBAdoxOjPLzXXhyc3prixJxjrLSqytMpDFp7U
         /YD6VplQdZWaU/GEoLhvo4v3Fi7s2GrhkGyKodPpdUf6uSetyf9pW/U6eif7UUupagFL
         iGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=dewdheXsERU+vQDnag1Ee60H9kCbIKcxr8jfS0p/Gos=;
        b=GEWLr0xLV4ek149M0Y1EKzfcaniHoT/GVBGDNEeBc5PL9RcIyN/hB0zO2misPDeZC5
         SVIH7BE5xFbx2aVSY1KTOHWkkWt6JPKbYWpI+GUhXOSzxg2XVPpjl4mHWSzNL6mBtFTW
         o/xyGaPo60DzESfbMX4IbpQjPnnCM7GB+Qh9jCtigUj9Axx+zzJjpYS19dBiy+87mpG7
         J9uWdY43DeIfHRB3XbUxqOyb/FNDIzRM2LwPF8f3iX8wMozsNbW/WnAgmfAIVVtvBTxb
         efm1xwE7VjcT9R1BaEWJI48SwYS0D9KLTBLfxIH3eyrEUSAPqf1F81TRQvni2gcuHL00
         vgMg==
X-Gm-Message-State: AJcUukc7NnEfDQ+5LDMvvi14PYJtnvpa0hu3wfI5QYkY7hZTTCsj2AgS
        x4hj6PZ39Si+D5OPbChNgA==
X-Google-Smtp-Source: ALg8bN74hXBX1qe8O894e3baxAlc+vuss7pEq2NDzXdj0W+B1mnXlLYWwEiy8xlirrh82VmSii0EWQ==
X-Received: by 2002:a9d:3e84:: with SMTP id b4mr16842192otc.330.1548683642078;
        Mon, 28 Jan 2019 05:54:02 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id w5sm4887724oif.48.2019.01.28.05.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 05:54:01 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2494:1989:377c:bd77])
        by serve.minyard.net (Postfix) with ESMTPSA id E092A54E;
        Mon, 28 Jan 2019 07:54:00 -0600 (CST)
Date:   Mon, 28 Jan 2019 07:53:59 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     cminyard@mvista.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        qiaonuohan@huawei.com
Subject: Re: [PATCH v3] ipmi_si: fix use-after-free of resource->name
Message-ID: <20190128135359.GB4979@minyard.net>
Reply-To: minyard@acm.org
References: <1548644934-36452-1-git-send-email-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548644934-36452-1-git-send-email-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:08:54AM +0800, Yang Yingliang wrote:
> When we excute the following commands, we got oops
> rmmod ipmi_si
> cat /proc/ioports
> 

snip..

> 
> If io_setup is called successful in try_smi_init() but try_smi_init()
> goes out_err before calling ipmi_register_smi(), so ipmi_unregister_smi()
> will not be called while removing module. It leads to the resource that
> allocated in io_setup() can not be freed, but the name(DEVICE_NAME) of
> resource is freed while removing the module. It causes use-after-free
> when cat /proc/ioports.
> 
> Fix this by calling io_cleanup() while try_smi_init() goes to out_err.
> and don't call io_cleanup() until io_setup() returns successful to avoid
> warning prints.

Thanks a bunch for working on this.  Fix is in my next tree now, if it
is stable in there then I will send up to Linus.

-corey

> 
> Fixes: 93c303d2045b ("ipmi_si: Clean up shutdown a bit")
> Cc: stable@vger.kernel.org
> Reported-by: NuoHan Qiao <qiaonuohan@huawei.com>
> Suggested-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c    | 5 +++++
>  drivers/char/ipmi/ipmi_si_mem_io.c  | 5 +++--
>  drivers/char/ipmi/ipmi_si_port_io.c | 5 +++--
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index dc8603d..f1b9fda 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2085,6 +2085,11 @@ static int try_smi_init(struct smi_info *new_smi)
>  	WARN_ON(new_smi->io.dev->init_name != NULL);
>  
>   out_err:
> +	if (rv && new_smi->io.io_cleanup) {
> +		new_smi->io.io_cleanup(&new_smi->io);
> +		new_smi->io.io_cleanup = NULL;
> +	}
> +
>  	kfree(init_name);
>  	return rv;
>  }
> diff --git a/drivers/char/ipmi/ipmi_si_mem_io.c b/drivers/char/ipmi/ipmi_si_mem_io.c
> index fd0ec8d..7558361 100644
> --- a/drivers/char/ipmi/ipmi_si_mem_io.c
> +++ b/drivers/char/ipmi/ipmi_si_mem_io.c
> @@ -81,8 +81,6 @@ int ipmi_si_mem_setup(struct si_sm_io *io)
>  	if (!addr)
>  		return -ENODEV;
>  
> -	io->io_cleanup = mem_cleanup;
> -
>  	/*
>  	 * Figure out the actual readb/readw/readl/etc routine to use based
>  	 * upon the register size.
> @@ -141,5 +139,8 @@ int ipmi_si_mem_setup(struct si_sm_io *io)
>  		mem_region_cleanup(io, io->io_size);
>  		return -EIO;
>  	}
> +
> +	io->io_cleanup = mem_cleanup;
> +
>  	return 0;
>  }
> diff --git a/drivers/char/ipmi/ipmi_si_port_io.c b/drivers/char/ipmi/ipmi_si_port_io.c
> index ef6dffc..03924c3 100644
> --- a/drivers/char/ipmi/ipmi_si_port_io.c
> +++ b/drivers/char/ipmi/ipmi_si_port_io.c
> @@ -68,8 +68,6 @@ int ipmi_si_port_setup(struct si_sm_io *io)
>  	if (!addr)
>  		return -ENODEV;
>  
> -	io->io_cleanup = port_cleanup;
> -
>  	/*
>  	 * Figure out the actual inb/inw/inl/etc routine to use based
>  	 * upon the register size.
> @@ -109,5 +107,8 @@ int ipmi_si_port_setup(struct si_sm_io *io)
>  			return -EIO;
>  		}
>  	}
> +
> +	io->io_cleanup = port_cleanup;
> +
>  	return 0;
>  }
> -- 
> 1.8.3
> 
> 
