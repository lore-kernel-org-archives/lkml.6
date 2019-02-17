Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58909C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 06:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A9520C01
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 06:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GryOWSf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfBQGyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 01:54:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35259 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfBQGyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 01:54:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so6893259pgs.2;
        Sat, 16 Feb 2019 22:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o5vhrC9DOZGFGyHGF+splJ+1OBSbBR/9Fce6vMvOBpE=;
        b=GryOWSf6ed82RXWS2lb/M/1EOz+2dDJXHZrtuvszTyz1/WPkE+Fc0lnvMbPC4CzDGt
         os9dhhqS2iwjrDNZMNIL5mKsqNjW0G8nY1F5hn5HkATmr54LqgmiQi2VQudfdU+relTY
         Lh8x6/4VZIkdHJLhHmPFi3F1+xTbGpolauMTJVW1nrUDFycVzb6kcJY15f8Wkf9yNPkE
         BbhUGzRYsCQDBMDAt7gGLB8k5uKpLwGvjeuFDMX6iC16p+3/86eq9sbGyERpLrjZArpk
         OtaEhh7GgRkrcso4lYL6vpT1TlP50377uBhcvNq7h4zQrO8TUsbspJNXetJPKspN0Hrf
         EyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o5vhrC9DOZGFGyHGF+splJ+1OBSbBR/9Fce6vMvOBpE=;
        b=l/J3KACs71yxjNlts9YGiSqDgfUjw7AsPbowM+RlhGhkFtvfER9Xk/rIi/HHzEgp5L
         vL8GKMewFiwZSINKWqIAJ//cGZ0xr3KhJgxdrWyiZHfLchEcyA3+580zg3Xrg/7De4bQ
         so+KYOtNuvA9xpC8W9mAeYB/Cdzt6bSUMmweNSW+zGLTUdLH1vUFx+r7RIKtHGiRlEAe
         SuMCKXniz8HcDFX13hW7P7i6/0nHG2Bj0awkd87wf+2qRM1YbBT/Iz7SZzPlnacjBVWU
         RQGKiLPpexFkJjrCEt+5eSM3DJZXDiN1dDF3fpxDxNXb6/VeBasrnahS+V+sLSO2NVBD
         XIag==
X-Gm-Message-State: AHQUAuYbZ7hQIEp8FsHvHdny7s5sVROuBwKHzrdPUnncob4Hzu7+4L5Q
        /zm2Ex6gleroLGOlcZycQKQOjIqh
X-Google-Smtp-Source: AHgI3IbUxaM3Fuyc4GlJ9PPJP3psrMeLRzP75Zm22M13NyuOeoTK305zGX5MKVHfNjQ72ErbsFutvA==
X-Received: by 2002:a62:20c9:: with SMTP id m70mr17095263pfj.118.1550386451701;
        Sat, 16 Feb 2019 22:54:11 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 67sm31069217pfl.175.2019.02.16.22.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 22:54:10 -0800 (PST)
Date:   Sat, 16 Feb 2019 22:54:09 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     thesven73@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] Input: synaptics_i2c - remove redundant spinlock
Message-ID: <20190217065409.GA148958@dtor-ws>
References: <20190217061053.4559-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217061053.4559-1-TheSven73@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 01:10:53AM -0500, thesven73@gmail.com wrote:
> From: Sven Van Asbroeck <TheSven73@gmail.com>
> 
> Remove a leftover spinlock.
> 
> This was required back when mod_delayed_work() did not exist,
> and had to be implemented with a cancel + queue. See
> commit e7c2f967445d ("workqueue: use mod_delayed_work() instead of
> __cancel + queue")
> 
> schedule_delayed_work() and mod_delayed_work() can now be used
> concurrently. So the spinlock is no longer needed.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

Applied, thank you.

> ---
> 
> v2: replace useless synaptics_i2c_reschedule_work() with
> 		mod_delayed_work().
> 
>  drivers/input/mouse/synaptics_i2c.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index 8538318d332c..fa304648d611 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -219,7 +219,6 @@ struct synaptics_i2c {
>  	struct i2c_client	*client;
>  	struct input_dev	*input;
>  	struct delayed_work	dwork;
> -	spinlock_t		lock;
>  	int			no_data_count;
>  	int			no_decel_param;
>  	int			reduce_report_param;
> @@ -369,23 +368,11 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
>  	return xy_delta || gesture;
>  }
>  
> -static void synaptics_i2c_reschedule_work(struct synaptics_i2c *touch,
> -					  unsigned long delay)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&touch->lock, flags);
> -
> -	mod_delayed_work(system_wq, &touch->dwork, delay);
> -
> -	spin_unlock_irqrestore(&touch->lock, flags);
> -}
> -
>  static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
>  {
>  	struct synaptics_i2c *touch = dev_id;
>  
> -	synaptics_i2c_reschedule_work(touch, 0);
> +	mod_delayed_work(system_wq, &touch->dwork, 0);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -461,7 +448,7 @@ static void synaptics_i2c_work_handler(struct work_struct *work)
>  	 * We poll the device once in THREAD_IRQ_SLEEP_SECS and
>  	 * if error is detected, we try to reset and reconfigure the touchpad.
>  	 */
> -	synaptics_i2c_reschedule_work(touch, delay);
> +	mod_delayed_work(system_wq, &touch->dwork, delay);
>  }
>  
>  static int synaptics_i2c_open(struct input_dev *input)
> @@ -474,7 +461,7 @@ static int synaptics_i2c_open(struct input_dev *input)
>  		return ret;
>  
>  	if (polling_req)
> -		synaptics_i2c_reschedule_work(touch,
> +		mod_delayed_work(system_wq, &touch->dwork,
>  				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
>  
>  	return 0;
> @@ -530,7 +517,6 @@ static struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *clien
>  	touch->scan_rate_param = scan_rate;
>  	set_scan_rate(touch, scan_rate);
>  	INIT_DELAYED_WORK(&touch->dwork, synaptics_i2c_work_handler);
> -	spin_lock_init(&touch->lock);
>  
>  	return touch;
>  }
> @@ -637,7 +623,7 @@ static int __maybe_unused synaptics_i2c_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	synaptics_i2c_reschedule_work(touch,
> +	mod_delayed_work(system_wq, &touch->dwork,
>  				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
>  
>  	return 0;
> -- 
> 2.17.1
> 

-- 
Dmitry
