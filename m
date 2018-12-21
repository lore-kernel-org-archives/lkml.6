Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA08EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4EF21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9B1oKGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392105AbeLUWFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:05:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41373 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392089AbeLUWFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:05:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so3061781plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AsQsPg3ShIURHNXRg58ZbH/pPp0okhxVuZTUYM5av44=;
        b=R9B1oKGV3nG/jxvqGU0EpTtXB9Q+6BhMv30KmuSkn4kCyYzKnewdwQ7iDXv5c98BK9
         m0dVpkF1eMZbNgABxZgZmAe7weP1Qsjmnw45ItSD3To5gBVyteUOQXpzp9JiLTJU7fpE
         OI0g62DGVXsHQ49yTDHWaxsSIt4jZrI0C4wR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AsQsPg3ShIURHNXRg58ZbH/pPp0okhxVuZTUYM5av44=;
        b=ooDIo8koqhEdgEQlE3qqkXhoEIm0Mjj9hSs4zJYHNGDfPwvr9zoSZIhOeBq03yQlj4
         DxxkwyzrBjXtmQjL+YUesXgzSPzrAL+BSfxm4dvGsFsvZNlIn0jnNInIcriZqH1l1e4E
         +Y3abZ6CGmzcV75agYDJpY860hLLPDdRr+nnaZ+gQ/EY0G45NSeF31rkzMrmy9UvANkK
         ymh6eJbQ7Wh6J1sNQ5oD3xgtefCYtAj5Fxc7tBa7S9Ie8p8ijxTEx33lCEl9mASz4pjd
         3F/rqm0VrGmZUcsQR88WOnG8G198XKYzBpiRjLsnl+dlWwGU/6oHMLdflj6062BCEH+V
         KC2w==
X-Gm-Message-State: AJcUukdyBRT3PGvcn0X+ZsnxLdnNt8yWWmBoPSRF00fFqYcTyVvzfX0v
        oJb87TqJaNr8zVCxuwXxKqYAxA==
X-Google-Smtp-Source: ALg8bN7WRz15jcIQMqDR4USgQ73Bv6HciGcKxCCn8Efuc0WPSA8vKpVvwy9TaB7fRG5C42Mv7pjUhA==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr4364191pld.184.1545429936563;
        Fri, 21 Dec 2018 14:05:36 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i73sm36700442pfi.66.2018.12.21.14.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 14:05:35 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:05:33 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] soc: qcom: rmtfs-mem: Add class to enable uevents
Message-ID: <20181221220533.GB9704@minitux>
References: <20181221201001.160613-1-evgreen@chromium.org>
 <20181221201001.160613-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221201001.160613-2-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Dec 12:10 PST 2018, Evan Green wrote:

> Currently the qcom_rmtfs_memN devices are entirely invisible to the udev world.
> Add a class to the rmtfs device so that uevents fire when the device is added.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

I agree with Brian on the whitespace chances, apart from that you have
my

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v2:
> - Moved class registration/deregistration into init/exit routines (Brian)
> 
>  drivers/soc/qcom/rmtfs_mem.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index 97bb5989aa211..99a1363ece254 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -132,6 +132,11 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static struct class rmtfs_class = {
> +	.owner          = THIS_MODULE,
> +	.name           = "rmtfs",
> +};
> +
>  static const struct file_operations qcom_rmtfs_mem_fops = {
>  	.owner = THIS_MODULE,
>  	.open = qcom_rmtfs_mem_open,
> @@ -199,8 +204,8 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  
>  	dev_set_name(&rmtfs_mem->dev, "qcom_rmtfs_mem%d", client_id);
>  	rmtfs_mem->dev.id = client_id;
> +	rmtfs_mem->dev.class = &rmtfs_class;
>  	rmtfs_mem->dev.devt = MKDEV(MAJOR(qcom_rmtfs_mem_major), client_id);
> -
>  	ret = cdev_device_add(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add cdev: %d\n", ret);
> @@ -239,7 +244,6 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>  put_device:
>  	put_device(&rmtfs_mem->dev);
> -
>  	return ret;
>  }
>  
> @@ -258,7 +262,6 @@ static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
>  
>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>  	put_device(&rmtfs_mem->dev);
> -
>  	return 0;
>  }
>  
> @@ -277,32 +280,42 @@ static struct platform_driver qcom_rmtfs_mem_driver = {
>  	},
>  };
>  
> -static int qcom_rmtfs_mem_init(void)
> +static int __init qcom_rmtfs_mem_init(void)
>  {
>  	int ret;
>  
> +	ret = class_register(&rmtfs_class);
> +	if (ret)
> +		return ret;
> +
>  	ret = alloc_chrdev_region(&qcom_rmtfs_mem_major, 0,
>  				  QCOM_RMTFS_MEM_DEV_MAX, "qcom_rmtfs_mem");
>  	if (ret < 0) {
>  		pr_err("qcom_rmtfs_mem: failed to allocate char dev region\n");
> -		return ret;
> +		goto unregister_class;
>  	}
>  
>  	ret = platform_driver_register(&qcom_rmtfs_mem_driver);
>  	if (ret < 0) {
>  		pr_err("qcom_rmtfs_mem: failed to register rmtfs_mem driver\n");
> -		unregister_chrdev_region(qcom_rmtfs_mem_major,
> -					 QCOM_RMTFS_MEM_DEV_MAX);
> +		goto unregister_chrdev;
>  	}
>  
> +	return 0;
> +
> +unregister_chrdev:
> +	unregister_chrdev_region(qcom_rmtfs_mem_major, QCOM_RMTFS_MEM_DEV_MAX);
> +unregister_class:
> +	class_unregister(&rmtfs_class);
>  	return ret;
>  }
>  module_init(qcom_rmtfs_mem_init);
>  
> -static void qcom_rmtfs_mem_exit(void)
> +static void __exit qcom_rmtfs_mem_exit(void)
>  {
>  	platform_driver_unregister(&qcom_rmtfs_mem_driver);
>  	unregister_chrdev_region(qcom_rmtfs_mem_major, QCOM_RMTFS_MEM_DEV_MAX);
> +	class_unregister(&rmtfs_class);
>  }
>  module_exit(qcom_rmtfs_mem_exit);
>  
> -- 
> 2.18.1
> 
