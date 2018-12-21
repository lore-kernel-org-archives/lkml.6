Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49420C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1669121929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nBiTqiff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390811AbeLUVzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:55:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37141 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeLUVzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:55:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so3065511pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32XPJbJI1zWIw8yKldA20B1UrX5pY5Vdinz5KsDZRVI=;
        b=nBiTqiff8BvBl1on7pfr3YxXLdkWLpmuiiV7pNlSfHVPUJfbhcoWQXluNz+HgoFxZI
         mOrndmc5cbflsgOPKO2drti5pvZvD9q7BhsoV7/iu+Gb7HJMdFlOQzc5fYwa09bLwU0q
         IfSjY8UbV0aLyJ7CW571SLUDrrMHBxxODln44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32XPJbJI1zWIw8yKldA20B1UrX5pY5Vdinz5KsDZRVI=;
        b=PMX0iNQVFYuPluRNO2W2MT/m92RE8vKc+kg1yyrzE9by6VgwPOD6aicMHShGGuDRtR
         J/f+MqrbAAd8sKrQLQm3gzgyq2e19/L0CX8Dw1IFeqJ+HyI++FRts/QvqVXINtM8wUCs
         K0auM3SMXDrOGLj1Rhlaug4AHRoOFv8PE5DGYDNqdyL330tsFZlIvhb2M91abXv73gqy
         JfwFwBOWyq86hcIEUbfkmzt/jhInKokOOnjMUpMjYGfi01YXoodiPgqSUOHK8ZMf1bqR
         pQNV7GoruuHKuIGZNgfnf33K0hNPB2Vej+SDShI8vSZXyHDBQve74aq2OYWo0DihIuaY
         pFpw==
X-Gm-Message-State: AJcUukeWORierErgeN72p4ZJp6D0+rV2gHuCiz8imph1b4tzQ3YMloaJ
        LlOeuXeKeZbZ0A5J1YVxNTQy/w==
X-Google-Smtp-Source: ALg8bN7byq1aFJv2aPnrJzmGqDs5anuEqiHxIymjbwvujeUBJV6EaSGkYbr2bIOmvO4n8hmSbWvSfA==
X-Received: by 2002:a63:334a:: with SMTP id z71mr4056318pgz.400.1545429353786;
        Fri, 21 Dec 2018 13:55:53 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 196sm94013241pfc.77.2018.12.21.13.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 13:55:52 -0800 (PST)
Date:   Fri, 21 Dec 2018 13:55:50 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ben Chan <benchan@chromium.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] soc: qcom: rmtfs-mem: Add class to enable uevents
Message-ID: <20181221215548.GA77420@google.com>
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

On Fri, Dec 21, 2018 at 12:10:00PM -0800, Evan Green wrote:
> Currently the qcom_rmtfs_memN devices are entirely invisible to the udev world.
> Add a class to the rmtfs device so that uevents fire when the device is added.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

You've got some spurious whitespace changes below, but otherwise:

Reviewed-by: Brian Norris <briannorris@chromium.org>

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

Does this belong here?

>  	return ret;
>  }
>  
> @@ -258,7 +262,6 @@ static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
>  
>  	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
>  	put_device(&rmtfs_mem->dev);
> -

And this?

Brian

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
