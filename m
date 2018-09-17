Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E002ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D3B214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1f5pN6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D3B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIQXUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:20:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39533 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:19:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so7910163pff.6;
        Mon, 17 Sep 2018 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7QqwkFGeyW0W6EfnTCDKFYl8ETeKiFXHK0qEGjF3Dkw=;
        b=E1f5pN6fjdUtryvFc4uRjUttLTNBDUEkJ/wOnarriH56crZ0M0MXvxowcR/mMlB8hL
         j4NGeos6ZMOUMMnY8A/gWD1kOfttn6KUUbEOeW/VL8VIQ5JrIYOv4yrtMZZN1pf+Gc49
         hEB20t3JWoYaBrl2nubqornrafR5SwF9tr43rpolNxVBePnllCphab1zCrQzLNDntDBL
         ayMYfb1xGnokZv3+qgMpZGtSf1ETQcdAsXDwajUbY4R+hp0cTfLI2LJlrAH4lHtANvCW
         des/7TzX9o6DeLg3PNGq3CsQUBLDxx+A48A46M/bvcjI+rKvC9HcqUuf0tGob/ntyeFY
         tKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7QqwkFGeyW0W6EfnTCDKFYl8ETeKiFXHK0qEGjF3Dkw=;
        b=hlDAnLaseA7heW72Nr1ASeRGmLhaLwJac/KHa63FxPyMTvnOQ+NyDCAN/3ssPEz0wa
         fUvrXYm9waiaynI/xD9NZKQ9gQ8U2jRCcVl7KM4YI8+rxatEzSkRxtnOpUUwUnblNHz+
         1MagUbO59IEzF6d6JwjiNvtEPf1sNZRSJvLPzHzS7El6yTEVIzxoEFXp1YzWkDN7LsON
         G6ne38ORvQ5w2LKJi5EjEKMsDdHF4YqDJnJzkSf46GahqUjVnRPpExKsCnG0HkZB5nOV
         qUQ5w7oUmmLEtTXbCG4zBDoQkIWNuKmTfbR0/1LXxNdDGDcWYGAqZvYooYD/yOjNlvVj
         hbdw==
X-Gm-Message-State: APzg51Ahw18IOiNY6GGsf6JqJAeNZ9Mk/xG6dumq4j2f4USATQCu2zcv
        DuBWZmMY9WHq9LNrT5RkE5U=
X-Google-Smtp-Source: ANB0VdZKo6XryRSM7BoIxQEZYGC1NYGnd664fkZAHLkoPf6l/fgTjQEuPGWKje5DOEi9a0LskCiOFA==
X-Received: by 2002:a63:555c:: with SMTP id f28-v6mr24782337pgm.37.1537206694665;
        Mon, 17 Sep 2018 10:51:34 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e190-v6sm32665826pfc.81.2018.09.17.10.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:51:33 -0700 (PDT)
Date:   Mon, 17 Sep 2018 10:51:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org,
        wsa@the-dreams.de, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Message-ID: <20180917175131.GA104770@dtor-ws>
References: <20180917052254.12336-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917052254.12336-1-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, Sep 17, 2018 at 07:22:54AM +0200, Andreas Kemnade wrote:
> When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> the counter will be incremented but the resume callback not called,
> so enumeration and charging will not start properly.
> To avoid that happen, wait and try again later.
> 
> Practically this happens when the device is woken up from suspend by
> plugging in usb.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
> index a44680d64f9b..1f3cf4e48383 100644
> --- a/drivers/phy/ti/phy-twl4030-usb.c
> +++ b/drivers/phy/ti/phy-twl4030-usb.c
> @@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>  
>  	status = twl4030_usb_linkstat(twl);
>  
> +	/* we might get here too early when runtime is not ready yet
> +	 * and we will get an EACCESS later, so try again later
> +	 */

How exactly can this happen? What disables (and later re-enables)
runtime PM? How can we guarantee that the interrupt will be
re-triggered?

> +	if (!pm_runtime_enabled(twl->dev)) {
> +		cancel_delayed_work(&twl->id_workaround_work);
> +		schedule_delayed_work(&twl->id_workaround_work, HZ);
> +		return IRQ_HANDLED;
> +	}
> +
>  	mutex_lock(&twl->lock);
>  	if (status >= 0 && status != twl->linkstat) {
>  		status_changed =
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry
