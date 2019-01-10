Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DDBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CCE2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547122244;
	bh=j7XNvxumB1SLZcjxT2Wa7DZ9r6ZX9vTRJyLyHH/IFIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2GmJ95z/DxjwwL1DWTWdsSZDCGQpashG2IWZo2sVh5AiRoh6RAnOzf7Z9AUttURkQ
	 beOQh+NMB/NXtFje+d5ESUosexs46jbicJkwPctiw2dFUmGfDK7fUJ+u0mX66PwPYp
	 XW6CXXe0PZGdQobgU2hTVN4aqxz1uKFxrELizb4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfAJMKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:10:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35899 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfAJMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:10:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so8143608lfg.3;
        Thu, 10 Jan 2019 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B67JMFK7QjS+nWsFFO1hjxpe6ltTVmlHI7rWQFmU0y8=;
        b=VvGwHph5EupjvtNT8hg/8fMABWfWau7w5/RfHED88Pv/TkyoQrt/uNFJL4+gCoPh5C
         nQOvrSQilX2jgOsU8FRc2J7tnUzq1U5kkrIFkXfn1sj5P8g0f0rH0PBF9T8u4YiOVzNE
         ibhLAohhFfbFR2PRqD0b7SI+dSzmwnPpRbtobVsdg6I18J+Mi+eIQx7YyEuSrhDQUpYV
         vaPwpKlY0pxmQt5SXeGqfOZAuHvc/IQWCcBG8r5+IIMzs8S4qU7p2RKBc6n+e6JuTe9A
         LC5OsckChyYkaw8pAnLp17LEfh8x86zB2fIUVz/IxNc6DIf8uDQBFvSi9CRzrqCdsZXV
         Hk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B67JMFK7QjS+nWsFFO1hjxpe6ltTVmlHI7rWQFmU0y8=;
        b=lXvZeKLEqlcwXYEoQqZqnJYxe63vvX2DNNt3K/eE7YvVMmKpDqfJg4l4G/GIQlPoIl
         Ze8t1x1DISesBb/r858HwzsY4FEtBEq15nhiUg86PdgpHlTYzOIz8SDmqwE54EnR35yY
         qxtLS8ly9ed5IBTtSixbBMA942q8NgWJcFfhU3vDYvPkKzugN2wP5yMW19FpIGA3Nmge
         ocAwNqdZQGdfRVDW5xHqRQOWu+hhXhBR3lIlDCb0eNT8yBNoE+z7QF+4tgEcNR6cJXvU
         InkIBz+vjgseNNMoM2BsA+asLMbssQXtKsnGBQp4+ULSkCenxahkUzJMuL/HZWU+zC8k
         zKUg==
X-Gm-Message-State: AJcUuke50ktbl4Wb4jF8+O8YIZFzSsglTI/3lnSGakVQ7Gs6KNSnSwXs
        NdfyR0byFbwB/MaEqNF1DYoGXhJY
X-Google-Smtp-Source: ALg8bN5+x9v07paZKTUnALDJN76URbEYXlUAbR4agxl8VA/EOy1nZz13+lVwEzMjkFitSmXxXSNbzQ==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr5993450lfi.19.1547122239227;
        Thu, 10 Jan 2019 04:10:39 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o88sm14391897lfk.38.2019.01.10.04.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:10:38 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghZAU-0002j5-1d; Thu, 10 Jan 2019 13:10:38 +0100
Date:   Thu, 10 Jan 2019 13:10:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 2/5] gnss: sirf: power on logic for devices without
 wakeup signal
Message-ID: <20190110121038.GA9725@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209195150.5192-3-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please change the commit summary to something more descriptive like

	gnss: sirf: add support for configurations without wakeup signal

On Sun, Dec 09, 2018 at 08:51:47PM +0100, Andreas Kemnade wrote:
> Some Wi2Wi devices do not have a wakeup output, so device state can
> only be indirectly detected by looking whether there is communitcation
> over the serial lines.

> Additionally it checks for the initial state of the device during
> probing to ensure it is off.

Is this really needed? If so, it should probably go in a separate patch.

> Timeout values need to be increased, because the reaction on serial line
> is slower and are in line  with previous patches by

I don't think this is an accurate description, but more on that below.

> Neil Brown <neilb@suse.de> and  H. Nikolaus Schaller <hns@goldelico.com>.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
>  - style cleanup
>  - do not keep serdev open just because runtime is active,
>    only when needed (gnss device is opened or state is changed)
>  - clearer timeout semantics
> 
>  drivers/gnss/sirf.c | 114 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 91 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index ba663de1db49..c64369494afb 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -23,8 +23,13 @@
>  
>  #define SIRF_BOOT_DELAY			500
>  #define SIRF_ON_OFF_PULSE_TIME		100
> +/* activate till reaction of wakeup pin */
>  #define SIRF_ACTIVATE_TIMEOUT		200
> +/* activate till reception of data */
> +#define SIRF_ACTIVATE_TILL_OUTPUT_TIMEOUT	1000
>  #define SIRF_HIBERNATE_TIMEOUT		200
> +/* If no data arrives for this time, we expect the chip to be off. */
> +#define SIRF_MIN_SILENCE	1000

You only need to add one new define for the no-wakeup case and it should
reflect the report cycle (e.g. name it SIRF_NOWAKEUP_REPORT_CYCLE).
Specifically, it is the time we must wait in order to infer that a
device has failed to be activated, or succeeded to hibernate.

In pseudo code we have:

  activate:
   - toggle on-off
   - wait(data-received, ACTIVATE_TIMEOUT + REPORT_CYCLE)
     - reception: success
     - timeout: failure

  hibernate:
   - toggle on-off
   - sleep(HIBERNATE_TIMEOUT)
   - wait(data-received, REPORT_CYCLE)
     - reception: failure
     - timeout: success

A problem with your implementation, is that you assume a report cycle
of one second, but this need to be the case. Judging from a quick look
at the sirf protocols (sirf nmea and sirf binary) report cycles can be
configured to be as long as 30s (sirf binary) or even 255s (sirf nmea).
[ To make things worse these numbers can be even higher in some
low-power modes it seems. ]

Adding just a one-second timeout (the minimum supported cycle length)
seems way too low, even if whatever value we choose will be reflected
directly in the time it takes to hibernate (suspend) the device.

And since this is configurable at runtime, the only safe value would be
the maximum one...

Perhaps we can say that no-wakeup support depends on having reasonably
short report cycles, but this needs to be documented.

>  struct sirf_data {
>  	struct gnss_device *gdev;
> @@ -41,9 +46,44 @@ struct sirf_data {
>  	 */
>  	struct mutex gdev_mutex;
>  	bool opened;
> +	int serdev_usecount;

Rename serdev_count.

> +	/*
> +	 * serdev will be opened for power state changing and when userspace
> +	 * needs it, so we have a usecount and need locking.
> +	 */

Too verbose to have here. And see if you can reuse the mutex protecting
open (opened).

> +	struct mutex serdev_mutex;
>  	wait_queue_head_t power_wait;
>  };
>  
> +static int sirf_dev_get(struct sirf_data *data)

Rename to the more descriptive sirf_serdev_open().

> +{
> +	int ret = 0;
> +
> +	mutex_lock(&data->serdev_mutex);
> +	data->serdev_usecount++;

Move increment inside conditional.

> +	if (data->serdev_usecount == 1) {
> +		ret = serdev_device_open(data->serdev);
> +		if (ret)
> +			data->serdev_usecount--;
> +
> +		serdev_device_set_baudrate(data->serdev, data->speed);
> +		serdev_device_set_flow_control(data->serdev, false);

You will crash here if open failed above.

> +	}
> +

No newline (or add one after mutex_lock() above).

> +	mutex_unlock(&data->serdev_mutex);

Newline before return please.

> +	return ret;
> +}
> +
> +static void sirf_dev_put(struct sirf_data *data)
> +{
> +	mutex_lock(&data->serdev_mutex);
> +	data->serdev_usecount--;
> +	if (data->serdev_usecount == 0)
> +		serdev_device_close(data->serdev);
> +
> +	mutex_unlock(&data->serdev_mutex);
> +}

Similar comments as for open above.

> +
>  static int sirf_open(struct gnss_device *gdev)
>  {
>  	struct sirf_data *data = gnss_get_drvdata(gdev);
> @@ -51,13 +91,10 @@ static int sirf_open(struct gnss_device *gdev)
>  	int ret;
>  
>  	data->opened = true;
> -	ret = serdev_device_open(serdev);
> +	ret = sirf_dev_get(data);
>  	if (ret)
>  		return ret;

You're leaving opened set when returning here.

>  
> -	serdev_device_set_baudrate(serdev, data->speed);
> -	serdev_device_set_flow_control(serdev, false);
> -
>  	ret = pm_runtime_get_sync(&serdev->dev);
>  	if (ret < 0) {
>  		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
> @@ -69,7 +106,7 @@ static int sirf_open(struct gnss_device *gdev)
>  	return 0;
>  
>  err_close:
> -	serdev_device_close(serdev);
> +	sirf_dev_put(data);
>  
>  	return ret;
>  }
> @@ -78,9 +115,7 @@ static void sirf_close(struct gnss_device *gdev)
>  {
>  	struct sirf_data *data = gnss_get_drvdata(gdev);
>  	struct serdev_device *serdev = data->serdev;
> -

Keep the newline after the declarations.

> -	serdev_device_close(serdev);
> -
> +	sirf_dev_put(data);
>  	pm_runtime_put(&serdev->dev);
>  	mutex_lock(&data->gdev_mutex);
>  	data->opened = false;
> @@ -118,12 +153,16 @@ static int sirf_receive_buf(struct serdev_device *serdev,
>  	struct gnss_device *gdev = data->gdev;
>  	int ret = 0;
>  
> +	if (!data->wakeup && !data->active) {
> +		data->active = true;
> +		wake_up_interruptible(&data->power_wait);
> +	}
> +
>  	/*
> -	 * we might come here everytime when runtime is resumed
> -	 * and data is received. Two cases are possible
> -	 * 1. device is opened during initialisation
> -	 * 2. kernel is compiled without runtime pm
> -	 *    and device is opened all the time
> +	 * We might come here everytime when runtime is resumed
> +	 * and data is received. Two cases are possible:
> +	 * 1. during power state change
> +	 * 2. userspace has opened the gnss device
>  	 */

Drop this comment.

>  	mutex_lock(&data->gdev_mutex);
>  	if (data->opened)
> @@ -161,6 +200,24 @@ static int sirf_wait_for_power_state(struct sirf_data *data, bool active,
>  {
>  	int ret;
>  
> +	if (!data->wakeup && !active && data->active) {

Should you really check data->active here?

> +		/* Wait for the chip to turn off. */
> +		msleep(timeout);
> +		data->active = false;
> +		/* Now check if it is really off. */
> +		ret = wait_event_interruptible_timeout(data->power_wait,
> +			data->active,
> +			msecs_to_jiffies(SIRF_MIN_SILENCE));

Continuation lines should be indented at least two tabs further.

> +

No no newline.

> +		if (ret < 0)
> +			return ret;
> +
> +		/* We are still getting data. -> state change timeout */
> +		if (ret > 0)
> +			return -ETIMEDOUT;

Add newline.

> +		return 0;
> +	}
> +
>  	ret = wait_event_interruptible_timeout(data->power_wait,
>  			data->active == active, msecs_to_jiffies(timeout));
>  	if (ret < 0)
> @@ -189,13 +246,23 @@ static int sirf_set_active(struct sirf_data *data, bool active)
>  	int ret;
>  
>  	if (active)
> -		timeout = SIRF_ACTIVATE_TIMEOUT;
> +		timeout = data->wakeup ?
> +			SIRF_ACTIVATE_TIMEOUT :
> +			SIRF_ACTIVATE_TILL_OUTPUT_TIMEOUT;

Add the report cycle length to the timeout in
sirf_wait_for_power_state() also for the activation case.

>  	else
>  		timeout = SIRF_HIBERNATE_TIMEOUT;
>  
>  	do {
> +		/* Open the serdev of wakeup-less devices to check for input. */

I'd drop this comment.

> +		if (!data->wakeup) {
> +			ret = sirf_dev_get(data);
> +			if (ret)
> +				return ret;
> +		}

And move this outside of the retry loop. No need to reopen for every
retry, right?

>  		sirf_pulse_on_off(data);
>  		ret = sirf_wait_for_power_state(data, active, timeout);
> +		if (!data->wakeup)
> +			sirf_dev_put(data);
>  		if (ret < 0) {
>  			if (ret == -ETIMEDOUT)
>  				continue;
> @@ -301,6 +368,7 @@ static int sirf_probe(struct serdev_device *serdev)
>  	data->gdev = gdev;
>  
>  	mutex_init(&data->gdev_mutex);
> +	mutex_init(&data->serdev_mutex);
>  	init_waitqueue_head(&data->power_wait);
>  
>  	serdev_device_set_drvdata(serdev, data);
> @@ -327,15 +395,6 @@ static int sirf_probe(struct serdev_device *serdev)
>  		if (IS_ERR(data->wakeup))
>  			goto err_put_device;
>  
> -		/*
> -		 * Configurations where WAKEUP has been left not connected,
> -		 * are currently not supported.
> -		 */
> -		if (!data->wakeup) {
> -			dev_err(dev, "no wakeup gpio specified\n");
> -			ret = -ENODEV;
> -			goto err_put_device;
> -		}
>  	}
>  
>  	if (data->wakeup) {
> @@ -365,6 +424,14 @@ static int sirf_probe(struct serdev_device *serdev)
>  	if (IS_ENABLED(CONFIG_PM)) {
>  		pm_runtime_set_suspended(dev);	/* clear runtime_error flag */
>  		pm_runtime_enable(dev);
> +		/*
> +		 * Device might be enabled at boot, so lets first enable it,
> +		 * then disable it to bring it into a clear state.
> +		 */
> +		ret = pm_runtime_get_sync(dev);
> +		if (ret)
> +			goto err_disable_rpm;
> +		pm_runtime_put(dev);

As mentioned above, this seems unrelated to the rest of the patch, so
break it out.

I'm not sure why it is even needed though. And you should probably just
call sirf_set_active(false) directly, if anything.


>  	} else {
>  		ret = sirf_runtime_resume(dev);
>  		if (ret < 0)

Johan
