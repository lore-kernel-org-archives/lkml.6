Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F05ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D536E2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeviS9Am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D536E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeJTFnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 01:43:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35766 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeJTFnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 01:43:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id d7-v6so5682112lfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vCJKLuhyAalzx94IeighY92rYqXKUI5Q5oRT2gKrGts=;
        b=ZeviS9Am+yRwU34dBxpHbMfMSw6SaXfjG9bv2FehROu+mgZAQiqmhe9h4K0ZpPVBxb
         vkDLaHI19bPto3kvCQu/16GLfYJ7IckkCoCuRedqitCvq/bzOFHtn1+eeRsxwCmIsOHa
         2gGu/hgrUKh1XjeX7UNMmpAoW9EdIibQlEnn601F6aj7D05gink00S08xbL1ycd8ll39
         JY8gZmr3cgtVgizvvvj1juuHR2F8NsHLXh0XJNrmmZOVd+EqnHa3ERrdpikOEDSkC77Q
         /7h7vz1JB0AyABWY2HHEv/L240Hx3P/sh53VbA8xlZZDOzVYodr9/Ylu367oDHFAVrZT
         H3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCJKLuhyAalzx94IeighY92rYqXKUI5Q5oRT2gKrGts=;
        b=O5YSjtxN21UhxP8IgfLMbdT/+UzJC3+Yn3iRa+NH8E/WPgrlpIuj166Xy/dP6fVulA
         huPgFx1+HdUMtZvLxy0MSuw5jQ/pdCCUyGpUikp6EvCOGj7SfwRdPp8xExjYZf5GGWQS
         esJp/Ysxl2xwtXDZGQAxUUhadcO421zBq8UP2jPnW3A8IUYKHCpbnGuBzOxE7MTrM0IW
         uVxR0dciQ7wb85xNRjTxiQtWAZ5113V4tnH2fG6RE8RuV1uT7c3pGdjUyfsy76l75qof
         OqV+he+0NxJioi2xrIGQXmk6iuwxIVMfnJcVVjNhaOrmIKjeo3E+lc0nQ11rkHC3aaNx
         fexQ==
X-Gm-Message-State: ABuFfogaD9WPUWzf7soMQWZCmp8DPojEL6KD5AJZPDoGoKFPahuj7iIR
        W5RE2TX35sl+UeFAHFmElRU=
X-Google-Smtp-Source: ACcGV609jSAdSlNmVK3WwEtUzrJHcts866k5a5Zlc9Uu6kaXGevn+vYUBT1OfIeqwBJYgd7z30sgKA==
X-Received: by 2002:a19:4bc9:: with SMTP id y192-v6mr4011250lfa.144.1539984943025;
        Fri, 19 Oct 2018 14:35:43 -0700 (PDT)
Received: from metis.ciupak.eu ([31.130.108.122])
        by smtp.gmail.com with ESMTPSA id n3-v6sm5259835lfe.8.2018.10.19.14.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 14:35:42 -0700 (PDT)
Date:   Sat, 20 Oct 2018 01:38:06 +0200
From:   Marcin Ciupak <marcin.s.ciupak@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, kbuild-all@01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: nrf24: add new driver for 2.4GHz radio
 transceiver
Message-ID: <20181019233806.tzwn7dv63nzbepgl@metis.ciupak.eu>
References: <20181017110001.65pcxebwsirsclim@metis.ciupak.eu>
 <20181019065801.vp6nmaodt7n7qyqh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019065801.vp6nmaodt7n7qyqh@mwanda>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 09:58:01AM +0300, Dan Carpenter wrote:
> Hi Marcin,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Marcin-Ciupak/staging-nrf24-add-new-driver-for-2-4GHz-radio-transceiver/20181018-164230
> 
> smatch warnings:
> drivers/staging/nrf24/nrf24_if.c:538 nrf24_create_pipe() error: 'p->dev' dereferencing possible ERR_PTR()
> drivers/staging/nrf24/nrf24_if.c:753 nrf24_probe() error: 'device' dereferencing possible ERR_PTR()
> drivers/staging/nrf24/nrf24_sysfs.c:118 plw_store() warn: impossible condition '(old < 0) => (0-255 < 0)'
> 
> # https://github.com/0day-ci/linux/commit/f4952b4a228f4dc0149a814630c94e0e87a9f473
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout f4952b4a228f4dc0149a814630c94e0e87a9f473
> vim +538 drivers/staging/nrf24/nrf24_if.c
> 
> f4952b4a Marcin Ciupak 2018-10-17  503  
> f4952b4a Marcin Ciupak 2018-10-17  504  static struct nrf24_pipe *nrf24_create_pipe(struct nrf24_device *device, int id)
> f4952b4a Marcin Ciupak 2018-10-17  505  {
> f4952b4a Marcin Ciupak 2018-10-17  506  	int ret;
> f4952b4a Marcin Ciupak 2018-10-17  507  	struct nrf24_pipe *p;
> f4952b4a Marcin Ciupak 2018-10-17  508  
> f4952b4a Marcin Ciupak 2018-10-17  509  	//sets flags to false as well
> f4952b4a Marcin Ciupak 2018-10-17  510  	p = kzalloc(sizeof(*p), GFP_KERNEL);
> f4952b4a Marcin Ciupak 2018-10-17  511  	if (!p) {
> f4952b4a Marcin Ciupak 2018-10-17  512  		ret = -ENOMEM;
> f4952b4a Marcin Ciupak 2018-10-17  513  		goto err_return;
> f4952b4a Marcin Ciupak 2018-10-17  514  	}
> f4952b4a Marcin Ciupak 2018-10-17  515  
> f4952b4a Marcin Ciupak 2018-10-17  516  	ret = ida_simple_get(&nrf24_ida_pipe, 0, 0, GFP_KERNEL);
> f4952b4a Marcin Ciupak 2018-10-17  517  	if (ret < 0) {
> f4952b4a Marcin Ciupak 2018-10-17  518  		dev_err(&device->dev, "%s: get_minor failed\n", __func__);
> f4952b4a Marcin Ciupak 2018-10-17  519  		goto err_free_mem;
> f4952b4a Marcin Ciupak 2018-10-17  520  	}
> f4952b4a Marcin Ciupak 2018-10-17  521  
> f4952b4a Marcin Ciupak 2018-10-17  522  	p->devt = MKDEV(MAJOR(nrf24_dev), ret);
> f4952b4a Marcin Ciupak 2018-10-17  523  	p->id = id;
> f4952b4a Marcin Ciupak 2018-10-17  524  
> f4952b4a Marcin Ciupak 2018-10-17  525  	INIT_KFIFO(p->rx_fifo);
> f4952b4a Marcin Ciupak 2018-10-17  526  	init_waitqueue_head(&p->poll_wait_queue);
> f4952b4a Marcin Ciupak 2018-10-17  527  
> f4952b4a Marcin Ciupak 2018-10-17  528  	p->dev = device_create_with_groups(nrf24_class,
> f4952b4a Marcin Ciupak 2018-10-17  529  					   &device->dev,
> f4952b4a Marcin Ciupak 2018-10-17  530  					   p->devt,
> f4952b4a Marcin Ciupak 2018-10-17  531  					   p,
> f4952b4a Marcin Ciupak 2018-10-17  532  					   nrf24_pipe_groups,
> f4952b4a Marcin Ciupak 2018-10-17  533  					   "%s.%d",
> f4952b4a Marcin Ciupak 2018-10-17  534  					   dev_name(&device->dev),
> f4952b4a Marcin Ciupak 2018-10-17  535  					   id);
> f4952b4a Marcin Ciupak 2018-10-17  536  
> f4952b4a Marcin Ciupak 2018-10-17  537  	if (IS_ERR(p->dev)) {
> f4952b4a Marcin Ciupak 2018-10-17 @538  		dev_err(&device->dev,
> f4952b4a Marcin Ciupak 2018-10-17  539  			"%s: device_create of '%s' failed\n",
> f4952b4a Marcin Ciupak 2018-10-17  540  			__func__,
> f4952b4a Marcin Ciupak 2018-10-17  541  			dev_name(p->dev));
> f4952b4a Marcin Ciupak 2018-10-17  542  		ret = PTR_ERR(p->dev);
> f4952b4a Marcin Ciupak 2018-10-17  543  		goto err_ida_remove;
> f4952b4a Marcin Ciupak 2018-10-17  544  	}
> f4952b4a Marcin Ciupak 2018-10-17  545  
> f4952b4a Marcin Ciupak 2018-10-17  546  	cdev_init(&p->cdev, &nrf24_fops);
> f4952b4a Marcin Ciupak 2018-10-17  547  	p->cdev.owner = THIS_MODULE;
> f4952b4a Marcin Ciupak 2018-10-17  548  	ret = cdev_add(&p->cdev, p->devt, 1);
> f4952b4a Marcin Ciupak 2018-10-17  549  	if (ret < 0) {
> f4952b4a Marcin Ciupak 2018-10-17  550  		dev_err(&device->dev, "%s: cdev failed\n", __func__);
> f4952b4a Marcin Ciupak 2018-10-17  551  		goto err_dev_destroy;
> f4952b4a Marcin Ciupak 2018-10-17  552  	}
> f4952b4a Marcin Ciupak 2018-10-17  553  
> f4952b4a Marcin Ciupak 2018-10-17  554  	dev_dbg(&device->dev,
> f4952b4a Marcin Ciupak 2018-10-17  555  		"%s: device created: major(%d), minor(%d)\n",
> f4952b4a Marcin Ciupak 2018-10-17  556  		__func__,
> f4952b4a Marcin Ciupak 2018-10-17  557  		MAJOR(p->devt),
> f4952b4a Marcin Ciupak 2018-10-17  558  		MINOR(p->devt));
> f4952b4a Marcin Ciupak 2018-10-17  559  
> f4952b4a Marcin Ciupak 2018-10-17  560  	return p;
> f4952b4a Marcin Ciupak 2018-10-17  561  
> f4952b4a Marcin Ciupak 2018-10-17  562  err_dev_destroy:
> f4952b4a Marcin Ciupak 2018-10-17  563  	device_destroy(nrf24_class, p->devt);
> f4952b4a Marcin Ciupak 2018-10-17  564  err_ida_remove:
> f4952b4a Marcin Ciupak 2018-10-17  565  	ida_simple_remove(&nrf24_ida_pipe, MINOR(p->devt));
> f4952b4a Marcin Ciupak 2018-10-17  566  err_free_mem:
> f4952b4a Marcin Ciupak 2018-10-17  567  	kfree(p);
> f4952b4a Marcin Ciupak 2018-10-17  568  err_return:
> f4952b4a Marcin Ciupak 2018-10-17  569  	return ERR_PTR(ret);
> f4952b4a Marcin Ciupak 2018-10-17  570  }
> f4952b4a Marcin Ciupak 2018-10-17  571  
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Interesting, I will take a look on that (and most probably provide a new
patch)

Thanks for the hint Dan!

br,
Marcin
