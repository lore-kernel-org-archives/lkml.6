Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92CE218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKIcwgUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfBKWQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:16:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38874 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBKWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:16:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so224840plb.5;
        Mon, 11 Feb 2019 14:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w1CPVe+6tPCyxJC4cBu9P5R8GU8vmg6dMVXkexyJFrE=;
        b=eKIcwgUExGA9MGygLeVtqgH2bdrKDbSJW2/ouEAEAg6B2Mf8k03WgRJBqgMROukoy5
         mMRd0QDamRWV0cuRqLkvDVwYuNF6aWcjx6qXuWWxPbwVndRMuHC+8rxwO/xsRk7Gp0NJ
         vp5oVfyrOjsruEwHy++cC6ZoJagzTRV4VswePxu80bu8HDjpuYBkdktuxQM99tmehjei
         PEbRjlSicBnBW2cTtoizXdyh2P9m5VrlYRtIYMJq0S98r3a4YfBBIzEvnJTDBeaJzQiY
         ZZvtpOOcRklCxZ7tGVBa/7ROaAOfmeZ0XwHeYxCd/FdjpwkAAT6k6wc8RruMFPXr8cv1
         CdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1CPVe+6tPCyxJC4cBu9P5R8GU8vmg6dMVXkexyJFrE=;
        b=qVrTGG/iF5gxscaMbilYU+ShIhDgjWEJKrVegdNhuPsEFdoPExRR09RYxFFMqTbXg6
         REHQSYhGG2wKy8WGPtG8k3OEnJ8usfoKv1NNwhliEagHTKl9szk7TcsxQIdZS1ZhE1tJ
         SvR7sTeIWkXry6gmMCkSna+LXJCcf6Dq1pudBzsEw3v/2cDQFY8g4szTpJHTZ4WDYR8a
         i5EigiF62JsJUYm0vMYY145WCw2CpAWPque6GMikZDwDBNhPE4JV2xnaRwv6eJwbTVl/
         rCKG0cMJD7CSH68dlv7lw3cDik01Ii3vQxtq1xwyl2Pm1MlYI5ltN/SzXSRZG4+j5VGw
         YydQ==
X-Gm-Message-State: AHQUAuaAsTZj6mimfa3EkM/2CikLQRXLFdGioMi2UrK9VPkZL0uxBTsU
        vXNchsc53govoUDFJqcTeCA=
X-Google-Smtp-Source: AHgI3IbCAqoJrg5ah7UFE0F7MTJ+QAh3g6/9m/Rvu2hqkhBldC+Ul4fMJngKHHNw1mbZ92rwoRLh4Q==
X-Received: by 2002:a17:902:402:: with SMTP id 2mr406682ple.318.1549923375293;
        Mon, 11 Feb 2019 14:16:15 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n10sm18129597pfj.14.2019.02.11.14.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:16:14 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:16:12 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     thesven73@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Input: qt2160 - remove redundant spinlock
Message-ID: <20190211221612.GB149505@dtor-ws>
References: <20190211023222.29168-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211023222.29168-1-TheSven73@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 09:32:22PM -0500, thesven73@gmail.com wrote:
> From: Sven Van Asbroeck <TheSven73@gmail.com>
> 
> Remove a spinlock which prevents schedule_delayed_work() and
> mod_delayed_work() from executing concurrently.
> 
> This was required back when mod_delayed_work() did not exist,
> and had to be implemented with a cancel + schedule. See
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
>  drivers/input/keyboard/qt2160.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
> index 43b86482dda0..23dc7c0c7d78 100644
> --- a/drivers/input/keyboard/qt2160.c
> +++ b/drivers/input/keyboard/qt2160.c
> @@ -69,7 +69,6 @@ struct qt2160_data {
>  	struct i2c_client *client;
>  	struct input_dev *input;
>  	struct delayed_work dwork;
> -	spinlock_t lock;        /* Protects canceling/rescheduling of dwork */
>  	unsigned short keycodes[ARRAY_SIZE(qt2160_key2code)];
>  	u16 key_matrix;
>  #ifdef CONFIG_LEDS_CLASS
> @@ -221,22 +220,15 @@ static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
>  static irqreturn_t qt2160_irq(int irq, void *_qt2160)
>  {
>  	struct qt2160_data *qt2160 = _qt2160;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&qt2160->lock, flags);
>  
>  	mod_delayed_work(system_wq, &qt2160->dwork, 0);
>  
> -	spin_unlock_irqrestore(&qt2160->lock, flags);
> -
>  	return IRQ_HANDLED;
>  }
>  
>  static void qt2160_schedule_read(struct qt2160_data *qt2160)
>  {
> -	spin_lock_irq(&qt2160->lock);
>  	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
> -	spin_unlock_irq(&qt2160->lock);
>  }
>  
>  static void qt2160_worker(struct work_struct *work)
> @@ -406,7 +398,6 @@ static int qt2160_probe(struct i2c_client *client,
>  	qt2160->client = client;
>  	qt2160->input = input;
>  	INIT_DELAYED_WORK(&qt2160->dwork, qt2160_worker);
> -	spin_lock_init(&qt2160->lock);
>  
>  	input->name = "AT42QT2160 Touch Sense Keyboard";
>  	input->id.bustype = BUS_I2C;
> -- 
> 2.17.1
> 

-- 
Dmitry
