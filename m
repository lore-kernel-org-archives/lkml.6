Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095DCECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEF420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8ekDHcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEF420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbeGXRCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:02:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38371 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbeGXRCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:02:54 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so1962336pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8FB4pyAG5YKoZ7RCb3DnyeuSnQCtMo2ckTNoC5NpCjo=;
        b=I8ekDHcH9i15/CfqYX++a10BrJ1NwO02L5qUDCLBKMeSUeOG0X2bjS6hGhKyVk9oFD
         cKMdRW13kngdgrO0DZT6o/O72ppKxJIgnDJbZCClpzJ8b0m1rn8hx/VNNtqlUGLpedvf
         aZ6QvJwcDpe+IRLo3KPBUCcDxObWgmci2T4wCUFw/YNFY4LKe4DYF2Lhq0+V1QGvtz7p
         TXKoFQefIHeFFe3TVSJhwgK2wzzTSB0F8bx0MUiP/42WLjqGL7+mjKfE9Q9xV7DervWW
         PROfSDvCUlUlyGh8fNpUH4dE4nnf6+Ops2VIRwJNBI5Nt+bl+7VJT+wI9ofjE4OPKygf
         EpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8FB4pyAG5YKoZ7RCb3DnyeuSnQCtMo2ckTNoC5NpCjo=;
        b=To9BwCV5OOpoWt9+t0euYr6ZJP/YxBJiOpE5h8h4QUVFjdQ6GJPtHUmkkGJqYiS5j7
         xgXdePyxIuGzDlBXxbM6uIZXPDebqKcvadBlREoHwxet6LQ9cemCQtpC7w7eQt+FgBrQ
         NPZdpX+/dM9r1mePybCV98e6sw5BMRWpf0c/6hSF1cUywfc4f+m6EsPLJEog97VBh7D3
         VOzyqPu4TAPmdA5sgUdP0HxnTWF7/e/N1pYsqt/bjfxXLi/qGCg0igeUelG2lUJyEiPJ
         pIFBlkx2TftxDFGKP6iw1MuL8/e3jpeFrFd81AKSnskKa3GxMqIrCYpWKNvdlPiXj7pk
         sq2g==
X-Gm-Message-State: AOUpUlFU0NwTiZ4yNf2fEkwbC2wUEjSlv4mTiUCeHYMrgUgzVlKmNHMv
        Fu3rNNfggZtzaUljORdzKIQ=
X-Google-Smtp-Source: AAOMgpf7jJevb6/cAmh3NKSovnQt8iUOYE433q3gMTudsMM85k3uKaCEG6snp+njZ1ruFvAs5jCHJg==
X-Received: by 2002:a17:902:7688:: with SMTP id m8-v6mr17450157pll.338.1532447747736;
        Tue, 24 Jul 2018 08:55:47 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l85-v6sm21468802pfk.34.2018.07.24.08.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:55:47 -0700 (PDT)
Date:   Tue, 24 Jul 2018 08:55:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>,
        Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] firmware: vpd: Fix section enabled flag on
 vpd_section_destroy
Message-ID: <20180724155546.GB917@roeck-us.net>
References: <20180723183927.GH100814@dtor-ws>
 <20180724151038.14838-1-vasilyev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724151038.14838-1-vasilyev@ispras.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 06:10:38PM +0300, Anton Vasilyev wrote:
> static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
> in vpd_probe() based on header's ro and rw sizes.
> In vpd_remove() vpd_section_destroy() performs deinitialization based
> on enabled flag, which is set to true by vpd_sections_init().
> This leads to call of vpd_section_destroy() on already destroyed section
> for probe-release-probe-release sequence if first probe performs
> ro_vpd initialization and second probe does not initialize it.
> 
> The patch adds changing enabled flag on vpd_section_destroy and adds
> cleanup on the error path of vpd_sections_init.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: add cleanup on the error path of vpd_sections_init
> ---
>  drivers/firmware/google/vpd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index e9db895916c3..1aa67bb5d8c0 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -246,6 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
>  		sysfs_remove_bin_file(vpd_kobj, &sec->bin_attr);
>  		kfree(sec->raw_name);
>  		memunmap(sec->baseaddr);
> +		sec->enabled = false;
>  	}
>  
>  	return 0;
> @@ -279,8 +280,10 @@ static int vpd_sections_init(phys_addr_t physaddr)
>  		ret = vpd_section_init("rw", &rw_vpd,
>  				       physaddr + sizeof(struct vpd_cbmem) +
>  				       header.ro_size, header.rw_size);
> -		if (ret)
> +		if (ret) {
> +			vpd_section_destroy(&ro_vpd);
>  			return ret;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.18.0
> 
