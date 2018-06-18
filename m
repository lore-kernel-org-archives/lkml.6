Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51ABC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913CC208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CS2ANsmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913CC208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755509AbeFRXVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:21:15 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39640 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755376AbeFRXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:21:13 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so9858044plt.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WKU1mWlpK3i5glcuFJj/0QQVo50QpkqAAxtESvbURlc=;
        b=CS2ANsmI4m0eHheCrvEWjHqo3Ex2zkriTLX+FgSZuSRoYzxo1nKLG3yJgSW0J3FI6J
         VTSpZp5sJ8OWaa2+1d164gz5yM7gnEckUykzZb4xD1O+nI+CSKq4tVvR2SieP9MTVOvs
         Ija3EtkX/zECjv9Fns4iUDpSM/qeDBmltJTEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WKU1mWlpK3i5glcuFJj/0QQVo50QpkqAAxtESvbURlc=;
        b=Jc9URrs/Vwjt9VSXrn35P9C0/czWEsRxIjyTJzZxJTNJm6sAXVezenP2QaxuPvUXyL
         XZRX4SW8zWF2DtPreDSJforYjDRuWLw8uK4R0kGrfbhLu+GoYo8zWJyuzPHoYTsvNsSR
         mmp55sGJ3qK3+hdPHkVnbxvQaoR/eJhq7iIhHAftN/ndx5t2Xj277CISuKmLrnubYIL9
         zVnD+tc1xnVN9Oz0fcLmThR5c29KHp31tN/lxsVlGKdgtH7pyPnCICAxHImXCmXBPqI8
         ONt1GnOjU/I2x+/9yFLR/uw2H6wcBupJ8QCwbrDQye3wSMLj2FbIBowFz8gpfBl6eMnR
         oa/Q==
X-Gm-Message-State: APt69E3mGRb6RyHGm9FWF3RdpXxwI6xdml+wC/n8gMuaIrSQJMPgXI1P
        HHerO+cH1i0A/SLgkESCNUp+zQ==
X-Google-Smtp-Source: ADUXVKJpKz08L37/I4s00DIc8rvYIRIltUQdmeZpF3clvG02zRxRXyYMTNEB41aFuMe13GJPgyMYNQ==
X-Received: by 2002:a17:902:3081:: with SMTP id v1-v6mr16585374plb.266.1529364073441;
        Mon, 18 Jun 2018 16:21:13 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id 82-v6sm27131041pft.74.2018.06.18.16.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 16:21:12 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:21:10 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 12/12] mfd: cros_ec: Add throttler sub-device
Message-ID: <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-13-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614194712.102134-13-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 14, 2018 at 12:47:12PM -0700, Matthias Kaehlcke wrote:
> Instantiate the CrOS EC throttler if it is enabled in the kernel
> configuration.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - patch added to series
> 
>  drivers/mfd/cros_ec.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 36156a41499c..5f52b6e2c21a 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -91,6 +91,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>  	return cros_ec_cmd_xfer(ec_dev, &buf.msg);
>  }
>  
> +static const struct mfd_cell ec_throttler_cell = {
> +	.name = "cros-ec-throttler",
> +};
> +
>  int cros_ec_register(struct cros_ec_device *ec_dev)
>  {
>  	struct device *dev = ec_dev->dev;
> @@ -153,6 +157,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  		}
>  	}
>  
> +	if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER)) {
> +		err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
> +				      &ec_throttler_cell, 1, NULL, ec_dev->irq,
> +				      NULL);

Most of this similar sub-device registration seems to have moved to
cros_ec_dev.c, in ec_device_probe(). Should this do the same?

And on a similar note: is there a way to determine EC support for this
feature (e.g., EC_FEATURE_*)? Or do we just have to listen for
appropriate throttling events that may never come?

Also, is this very useful on non-DT systems? Does this fail gracefully?

Brian

> +		if (err) {
> +			dev_err(dev,
> +				"Failed to register throttler subdevice %d\n",
> +				err);
> +			return err;
> +		}
> +	}
> +
>  	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
>  		err = devm_of_platform_populate(dev);
>  		if (err) {
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 
