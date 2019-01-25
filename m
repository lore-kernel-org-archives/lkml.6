Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FACC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CF4218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548426723;
	bh=CaGYXepgb9iCM2pjr4ZtGAEStNI0J5QQ+dKB8kAh/5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VwWBfAu1n0eJ6qNQ1fTgbCvQ44RM0Dx2Ox0PEZ4M2WHM0c21Q9N7EEV2a/hLvKKL0
	 jfMP4zb/UHIfQ0iwOPHG50tgYFZ67MLt97WKnLiJJMpOaL2WXDE5B0W87suF+zHAaM
	 BJ2e8Z2lYs8s13qsMDYtJfW1rlgcdoNbUy2Fy16U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfAYOcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:32:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40723 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:32:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so8529586lji.7;
        Fri, 25 Jan 2019 06:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bl28olHm22WN+bFTT+3YDy6j2/Cl90eudWoGeWUh7WI=;
        b=fWjscYHRd3PuHxUgFCJ0ujiNpw2RmSp8YtsCe99rOcoyRJ+4VdlOCCzGxhEF+51ksX
         v1JVvgPXSjE4i4M9vqH9zStVpTJ2jdGAACK42dlL57avHXhEXTOteawvxHBMll2OT3wX
         JFTyTUYlNazfFCrVOzhkfHVoAQYrwqBohFAofHlioKeWVzuKOoWo2FRAkVi6gyfLCnxX
         OPAKzxXECxc4i8dc6wT9bLePToq+3L2WXJ8ccruAUxTijXSALSxsrqstVDSoS+u2S5hX
         ZbwGYUxoHYnwK+zyEdO38PunmoL5Me652CwBm7OxPDVLhNxoqcUC+Q8gxrXiaJ6sj3tT
         /gvA==
X-Gm-Message-State: AJcUukeN1GwjhKDFJJYHjEuuYYT/22nH7WngvJnmDOYnSfIKes3G1d7V
        8fF+QWOCtg6mhaf/XlEUHCI=
X-Google-Smtp-Source: ALg8bN4ARGbd/kiNhEHBxnhrsd7lH6mzE/x9Fmk0g247pUlFTYPHDxfRKwwmDeoou0h6SQqvxrfROg==
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr9166456ljd.31.1548426718000;
        Fri, 25 Jan 2019 06:31:58 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m12sm1483761lfc.30.2019.01.25.06.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 06:31:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gn2WP-0005zu-Es; Fri, 25 Jan 2019 15:31:53 +0100
Date:   Fri, 25 Jan 2019 15:31:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] gnss: sirf: add support for configurations
 without wakeup signal
Message-ID: <20190125143153.GF3691@localhost>
References: <20190124063439.29897-1-andreas@kemnade.info>
 <20190124063439.29897-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124063439.29897-3-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 07:34:36AM +0100, Andreas Kemnade wrote:
> Some Wi2Wi devices do not have a wakeup output, so device state can
> only be indirectly detected by looking whether there is communication
> over the serial lines.
> This approach requires a report cycle set to a value less than 2 seconds
> to be reliable.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v4:
>  - was 3/6 earlier
>  - more cleanup
>  - separate no wakeup version for sirf_wait_for_power_state
>  - cleaned up optimisation for initial power off
> 
> Changes in v3:
>  - was 2/5 earlier
>  - changed commit headline
>  - more style cleanup
>  - split out initial power off as 2/6
>  - introduced SIRF_REPORT_CYCLE constant
>  - added documentation about limitations
>  - ignore first data after power state on so no
>    shutdown meassages are treated as power on success
>  - clearer logic in sirf_wait_for_power_state
> 
> Changes in v2:
>  - style cleanup
>  - do not keep serdev open just because runtime is active,
>    only when needed (gnss device is opened or state is changed)
>  - clearer timeout semantics
> 
>  drivers/gnss/sirf.c | 124 ++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 105 insertions(+), 19 deletions(-)

>  static int sirf_wait_for_power_state(struct sirf_data *data, bool active,
>  					unsigned long timeout)
>  {
>  	int ret;
>  
> +	if (!data->wakeup)
> +		return sirf_wait_for_power_state_nowakeup(data, active,
> +							  timeout);
> +
>  	ret = wait_event_interruptible_timeout(data->power_wait,
>  			data->active == active, msecs_to_jiffies(timeout));
>  	if (ret < 0)
> @@ -195,6 +267,12 @@ static int sirf_set_active(struct sirf_data *data, bool active)
>  	else
>  		timeout = SIRF_HIBERNATE_TIMEOUT;
>  
> +	if (!data->wakeup) {
> +		ret = sirf_serdev_open(data);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	do {
>  		sirf_pulse_on_off(data);
>  		ret = sirf_wait_for_power_state(data, active, timeout);
> @@ -202,12 +280,17 @@ static int sirf_set_active(struct sirf_data *data, bool active)
>  			if (ret == -ETIMEDOUT)
>  				continue;
>  
> -			return ret;
>  		}
> -
>  		break;
> +
>  	} while (retries--);

I noticed there were some odd white-space changes here after you
reverted the modified error handling from v3 which initially looked a
little out of place to me.

I decided to add those changed back in instead after looking at the end
result and noticing that the (retries < 0) check below also becomes
superfluous.

> +	if (!data->wakeup)
> +		sirf_serdev_close(data);
> +
> +	if (ret)
> +		return ret;
> +
>  	if (retries < 0)
>  		return -ETIMEDOUT;

Series now applied, good job!

Johan
