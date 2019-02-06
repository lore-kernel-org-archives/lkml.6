Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5617C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4770206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTLfH2kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfBFSxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:53:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41108 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfBFSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:53:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so3486386pfi.8;
        Wed, 06 Feb 2019 10:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h6gQFshFQ4BigvAMWkD7qbBVXwSeUDq0U/vrkFZ2xKQ=;
        b=gTLfH2kvUoXtNwOQB2mj7p4kdKRc9PVCcqixPTzPf1IDVcYNW9uj7VDD0LOL7e09WA
         3HKymQIc92PLFnBSUV6ONMn0YmPSXpkW0j8QUvdaCzcJ8kofhE+jTEObKJb6HF+NytkW
         ecYi5lxx4DkeoxYrzrUJRVYMUAIHfMvMgz3HOvUxuff1oDLgcNFJjAjmGIPtJkPMKv2g
         SGhSG3SujVa8QwgpP3VkD5FE2b6Jaej0mswcOi7s32USM+niDCtFzOftWuAuB6jVBcfv
         86wyQjiaQTEZ5SjptMpdePrI0LBfFZdftL0c7TNZWC5HZmfEqEK7dSa++zVg98VcF7UD
         +5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h6gQFshFQ4BigvAMWkD7qbBVXwSeUDq0U/vrkFZ2xKQ=;
        b=TwaDUd5tjl3XB9UDABNbH+IKvIZPveXmQ+lAptT2E1UDA8ZQs/heN+Z37npLzvnb0f
         sOtV0QDICmruCgDBhHQ3MkrC5fuqhl0V7795SRV1XB80s3fdLBs3k8A5hMCuZReK64Ga
         POBaXzOtvDmhs46ysJZ7wXZs3uUbX0aWNKItl+pqopf4uxtsBbsdn5k1Q+aVSF2yJTL4
         kpWMw+7RGlQBNZQD+HLTBv6mFaZ49cWS9ObJjkO5D7frtRgvtxDCoShlb798vXHyk088
         +t3dMrDo6tg1fzsJ3GwPelC/b2DDmD49tEPZ4TWWlE6QSHHdCFLLyfzDXmqfLsArcmFz
         OlHA==
X-Gm-Message-State: AHQUAuZ2IVt/MKEEViwS7cxJ6m6SoJeybg+uZ95k8i03OOnc+Vp8XzDl
        SdIunW1zGt+o1A6HGjs95oKySgLi
X-Google-Smtp-Source: AHgI3IYgVDc2i6uK6plAWLyYC9GyD5vmV4nqzqRBkp11KYq0V3VwzpwUoKLlRLjkjqUOe8OaMjdKJA==
X-Received: by 2002:a62:5910:: with SMTP id n16mr11840767pfb.128.1549479189343;
        Wed, 06 Feb 2019 10:53:09 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g15sm31123356pfj.131.2019.02.06.10.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:53:08 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:53:07 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] input: misc: bma150: Register input device after
 setting private data
Message-ID: <20190206185307.GD174258@dtor-ws>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
 <20190202151806.9064-6-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190202151806.9064-6-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 04:18:06PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Otherwise we introduce a race condition where userspace can request input
> before we're ready leading to null pointer dereference such as
> 
> input: bma150 as /devices/platform/i2c-gpio-2/i2c-5/5-0038/input/input3
> Unable to handle kernel NULL pointer dereference at virtual address 00000018
> pgd = (ptrval)
> [00000018] *pgd=55dac831, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#1] PREEMPT ARM
> Modules linked in: bma150 input_polldev [last unloaded: bma150]
> CPU: 0 PID: 2870 Comm: accelerometer Not tainted 5.0.0-rc3-dirty #46
> Hardware name: Samsung S5PC110/S5PV210-based board
> PC is at input_event+0x8/0x60
> LR is at bma150_report_xyz+0x9c/0xe0 [bma150]
> pc : [<80450f70>]    lr : [<7f0a614c>]    psr: 800d0013
> sp : a4c1fd78  ip : 00000081  fp : 00020000
> r10: 00000000  r9 : a5e2944c  r8 : a7455000
> r7 : 00000016  r6 : 00000101  r5 : a7617940  r4 : 80909048
> r3 : fffffff2  r2 : 00000000  r1 : 00000003  r0 : 00000000
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 54e34019  DAC: 00000051
> Process accelerometer (pid: 2870, stack limit = 0x(ptrval))
> Stackck: (0xa4c1fd78 to 0xa4c20000)
> fd60:                                                       fffffff3 fc813f6c
> fd80: 40410581 d7530ce3 a5e2817c a7617f00 a5e29404 a5e2817c 00000000 7f008324
> fda0: a5e28000 8044f59c a5fdd9d0 a5e2945c a46a4a00 a5e29668 a7455000 80454f10
> fdc0: 80909048 a5e29668 a5fdd9d0 a46a4a00 806316d0 00000000 a46a4a00 801df5f0
> fde0: 00000000 d7530ce3 a4c1fec0 a46a4a00 00000000 a5fdd9d0 a46a4a08 801df53c
> fe00: 00000000 801d74bc a4c1fec0 00000000 a4c1ff70 00000000 a7038da8 00000000
> fe20: a46a4a00 801e91fc a411bbe0 801f2e88 00000004 00000000 80909048 00000041
> fe40: 00000000 00020000 00000000 dead4ead a6a88da0 00000000 ffffe000 806fcae8
> fe60: a4c1fec8 00000000 80909048 00000002 a5fdd9d0 a7660110 a411bab0 00000001
> fe80: dead4ead ffffffff ffffffff a4c1fe8c a4c1fe8c d7530ce3 20000013 80909048
> fea0: 80909048 a4c1ff70 00000001 fffff000 a4c1e000 00000005 00026038 801eabd8
> fec0: a7660110 a411bab0 b9394901 00000006 a696201b 76fb3000 00000000 a7039720
> fee0: a5fdd9d0 00000101 00000002 00000096 00000000 00000000 00000000 a4c1ff00
> ff00: a6b310f4 805cb174 a6b310f4 00000010 00000fe0 00000010 a4c1e000 d7530ce3
> ff20: 00000003 a5f41400 a5f41424 00000000 a6962000 00000000 00000003 00000002
> ff40: ffffff9c 000a0000 80909048 d7530ce3 a6962000 00000003 80909048 ffffff9c
> ff60: a6962000 801d890c 00000000 00000000 00020000 a7590000 00000004 00000100
> ff80: 00000001 d7530ce3 000288b8 00026320 000288b8 00000005 80101204 a4c1e000
> ffa0: 00000005 80101000 000288b8 00026320 000288b8 000a0000 00000000 00000000
> ffc0: 000288b8 00026320 000288b8 00000005 7eef3bac 000264e8 00028ad8 00026038
> ffe0: 00000005 7eef3300 76f76e91 76f78546 800d0030 000288b8 00000000 00000000
> [<80450f70>] (input_event) from [<a5e2817c>] (0xa5e2817c)
> Code: e1a08148 eaffffa8 e351001f 812fff1e (e590c018)
> ---[ end trace 1c691ee85f2ff243 ]---
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/bma150.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
> index 1cdc8ce97968..64caf43e5bca 100644
> --- a/drivers/input/misc/bma150.c
> +++ b/drivers/input/misc/bma150.c
> @@ -470,7 +470,6 @@ static void bma150_init_input_device(struct bma150_data *bma150,
>  static int bma150_register_input_device(struct bma150_data *bma150)
>  {
>  	struct input_dev *idev;
> -	int error;
>  
>  	idev = devm_input_allocate_device(&bma150->client->dev);
>  	if (!idev)
> @@ -482,18 +481,14 @@ static int bma150_register_input_device(struct bma150_data *bma150)
>  	idev->close = bma150_irq_close;
>  	input_set_drvdata(idev, bma150);
>  
> -	error = input_register_device(idev);
> -	if (error)
> -		return error;
> -
>  	bma150->input = idev;
> -	return 0;
> +
> +	return input_register_device(idev);
>  }
>  
>  static int bma150_register_polled_device(struct bma150_data *bma150)
>  {
>  	struct input_polled_dev *ipoll_dev;
> -	int error;
>  
>  	ipoll_dev = devm_input_allocate_polled_device(&bma150->client->dev);
>  	if (!ipoll_dev)
> @@ -509,14 +504,10 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
>  
>  	bma150_init_input_device(bma150, ipoll_dev->input);
>  
> -	error = input_register_polled_device(ipoll_dev);
> -	if (error)
> -		return error;
> -
>  	bma150->input_polled = ipoll_dev;
>  	bma150->input = ipoll_dev->input;
>  
> -	return 0;
> +	return input_register_polled_device(ipoll_dev);
>  }
>  
>  int bma150_cfg_from_of(struct device_node *np)
> -- 
> 2.17.1
> 

-- 
Dmitry
