Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D066F21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SikCJ6BH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbfA1QzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:55:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36874 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbfA1QRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:43 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so13487611edb.4;
        Mon, 28 Jan 2019 08:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uFD/Owd38q497/w4OoAejQLrXu9nchwiyGKjcx2o8tk=;
        b=SikCJ6BHWH8es4E9HJ8/iuKltrXqyZL2Wr+OKcq9wyaOMNvWTDYF+AANx9imckkHJz
         Tg99tG2+8vIIuSYhC0rTlvcLymH2gloL2KugR+aE0CXWPinac3ryWW4UCczl7sDuevcu
         OgBDTAgDoHcyT1l8Z7yNqWOtK3akQ/5cdYfH70ALwULmlqYwsRYiXD8uk/KFSizYfnd2
         uE1OAtCheLBOWVNNERYZKX7EAuR2teFoUqnS3sY957noT1mIFcOFNab353tEFdHdUN68
         ijlRiY2BW6UtfWY6vRRew0k6x0e9fCr2dIMmSdyd6jvEF7uu0kAifH6pmJTiqUk+1kRZ
         OIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uFD/Owd38q497/w4OoAejQLrXu9nchwiyGKjcx2o8tk=;
        b=FuOCi5xms/LcxUy/q690LHPvncLzLqx6MdHfHEGMBWOclbGL3OfUdYHLmlEZwsd7Pe
         obsVY6cTukw5hgo5b9ZW+UXKnp4VDz6BT9tDzn9kZtQwcYTm+dUc5Z4uczUCWknWj2gx
         ANqfr3f3j1zuJ3XN0cAcbDGyYyfbgsC71z2HT2tljR4+c93Irw/Gs4qDsuWkp7Hu6cq0
         tjsIjpYl+d/zL8++V3pS+g4K8Iy8pyTP/hEAl21xSY3lCSoMJtJVGMrK+IXI4tuWL7J5
         SDnVwzBQc7AoN48PuYf6idHw8ZEE2DCIkPaojvuTHMK6+vR/Gtk6LkxpQPf6jNuF1Rgt
         3oOw==
X-Gm-Message-State: AJcUukfXL5u1MQUlNsye5Hq18nkGojQ3k8rj4NlEiTLkMSGY7FrGt/Vc
        aze2tTMnlLjF4b59pU+dUFo=
X-Google-Smtp-Source: ALg8bN6wmvx5QqHx1gTU1HU0N81A3BoTySGoww5caPuebu+OoOJ+OZLhinn4reviRq72NgQIZv9wSw==
X-Received: by 2002:a17:906:c393:: with SMTP id t19mr19876451ejz.55.1548692260417;
        Mon, 28 Jan 2019 08:17:40 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id c30sm13939167edc.70.2019.01.28.08.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:17:39 -0800 (PST)
Date:   Mon, 28 Jan 2019 09:17:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Don.Brace@microchip.com
Cc:     axboe@kernel.dk, aacraid@microsemi.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, manoj@linux.ibm.com,
        mrochs@linux.ibm.com, ukrishn@linux.ibm.com,
        linuxdrivers@attotech.com, don.brace@microsemi.com,
        brking@us.ibm.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, ndesaulniers@google.com,
        bvanassche@acm.org
Subject: Re: [PATCH v4] scsi/ata: Use unsigned int for cmd's type in ioctls
 in scsi_host_template
Message-ID: <20190128161737.GA23636@archlinux-ryzen>
References: <20190114044206.6351-1-natechancellor@gmail.com>
 <20190126075256.29608-1-natechancellor@gmail.com>
 <SN6PR11MB2767DF2A2BEF95EE07C15172E1960@SN6PR11MB2767.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2767DF2A2BEF95EE07C15172E1960@SN6PR11MB2767.namprd11.prod.outlook.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:16:34PM +0000, Don.Brace@microchip.com wrote:
> 
> Clang warns several times in the scsi subsystem (trimmed for brevity):
> 
> drivers/scsi/hpsa.c:6209:7: warning: overflow converting case value to switch condition type (2147762695 to 18446744071562347015) [-Wswitch]
>         case CCISS_GETBUSTYPES:
>              ^
> drivers/scsi/hpsa.c:6208:7: warning: overflow converting case value to switch condition type (2147762694 to 18446744071562347014) [-Wswitch]
>         case CCISS_GETHEARTBEAT:
>              ^
> 
> The root cause is that the _IOC macro can generate really large numbers, which don't find into type 'int', which is used for the cmd paremeter in the ioctls in scsi_host_template. My research into how GCC and Clang are handling this at a low level didn't prove fruitful. However, looking at the rest of the kernel tree, all ioctls use an 'unsigned int' for the cmd parameter, which will fit all of the _IOC values in the scsi/ata subsystems.
> 
> Make that change because none of the ioctls expect to take a negative value, it brings the ioctls inline with the reset of the kernel, and it removes ambiguity, which is never good when dealing with compilers.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/85
> Link: https://github.com/ClangBuiltLinux/linux/issues/154
> Link: https://github.com/ClangBuiltLinux/linux/issues/157
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
>  static void __exit esas2r_exit(void)
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c index ff67ef5d5347..28cfd3d01c5a 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -251,10 +251,11 @@ static int number_of_controllers;
> 
> Acked-by: Don Brace <don.brace@microsemi.com>
> 
>  
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index f564af8949e8..5d9ccbab7581 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -6043,7 +6043,8 @@ static int pqi_passthru_ioctl(struct pqi_ctrl_info *ctrl_info, void __user *arg)
>  	return rc;
>  }
> 
> Acked-by: Don Brace <don.brace@microsemi.com>
>  
> 

Thank you for the reply and the review, I really appreciate it :)

Nathan
