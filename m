Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12CCECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF2921526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF2921526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeJQQvy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:51:54 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:10460 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbeJQQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:51:54 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id B9/2B-09000-469F6CB5; Wed, 17 Oct 2018 08:57:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRWlGSWpSXmKPExsVy8IPnUd2Un8e
  iDc6u4bb4/mABu8W8z7IW869cY7WYO3sSo8XSg+tZLF4d3sVocXnXHDaLz71HGC22vnzHZPF4
  xVt2iycP+9gcuD0mntX12DnrLrvH4j0vmTzuXNvD5jHvZKDHtzMTWTw+b5ILYI9izcxLyq9IY
  M3YfUWnYJ1gxZEttg2Mx/m6GLk4hASWMUo0//jK3MXIycEmYCgx7817RhBbRGAqk0T/9HSQIm
  aBs0wS33dOAEsIC8RJtBx6wARRFC/xbulONgjbSOLbm6NgcRYBVYm+441ANgcHr0CAxIEdySB
  hIYE8idlXToPt4hSwlbhxYj0LiM0oICvxpXE1WJxZQFzi1pP5YGMkBAQkluw5zwxhi0q8fPyP
  FcJWkNj3ayUbhG0v8freOxaQVRIC+hJ9jcUQYUOJVdMOsEDY5hJz27sYIcbrSCzY/YkNwtaWW
  LbwNdh4XgFBiZMzn7BMYBSfheSKWUhaZiFpmYWkZQEjyypGi6SizPSMktzEzBxdQwMDXUNDI1
  1DS1NdI2MLvcQq3US91FLd8tTiEl1DvcTyYr3iytzknBS9vNSSTYzAhJBScPjdDsZLy9MPMUp
  yMCmJ8k7/cSxaiC8pP6UyI7E4I76oNCe1+BCjDAeHkgQvI0hOsCg1PbUiLTMHmJpg0hIcPEoi
  vEogad7igsTc4sx0iNQpRl2OtqfXZzALseTl56VKifPagRQJgBRllObBjYClyUuMslLCvIwMD
  AxCPAWpRbmZJajyrxjFORiVhHnLQabwZOaVwG16BXQEE9AR7rZHQI4oSURISTUwhhUZ1gSb+8
  9d9jHzw9/kwO53Z5bOOLq/dJPL7CWeWxerVaa0rwttvqW0xbR1XVCLfsvFw0dWrLlYWRnfMK8
  ppmpXpevDIP5tzq8DLxw1+ftsEuc9zu87k1e82v+07otQ5Sk1uTMWkRt2XXi7wsx17ZWOm9Gu
  71r//Z4z+5znGt2b525Ped5mv1qJpTgj0VCLuag4EQDg31EVjgMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-24.tower-268.messagelabs.com!1539766627!553123!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19615 invoked from network); 17 Oct 2018 08:57:08 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-24.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 17 Oct 2018 08:57:08 -0000
Received: from SW-EX-MBX02.diasemi.com ([169.254.4.108]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0382.000; Wed,
 17 Oct 2018 09:57:05 +0100
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access
 during system suspend
Thread-Topic: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access
 during system suspend
Thread-Index: AQHUYhXnLkN7Q/V/6kGq9xgKC5zdxKUjJhXg
Date:   Wed, 17 Oct 2018 08:57:05 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7021C4CCFCB@SW-EX-MBX02.diasemi.com>
References: <20181012072017.10765-1-geert+renesas@glider.be>
 <20181012072017.10765-4-geert+renesas@glider.be>
In-Reply-To: <20181012072017.10765-4-geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 17/10/2018 07:16:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Many thanks for looking at this.

On 12 October 2018 08:20 Geert Uytterhoeven wrote:

> Subject: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access during
> system suspend
> 
> The workqueue used for monitoring the hardware may run while the device
> is already suspended.  Fix this by using the freezable system workqueue
> instead, cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from
> happening during system suspend").

My thinking was:  this device is a PMIC and it will power the system. So when
the device is turned off, the S/W will also not be running.

Although my assumption only works if the PMIC device is the primary system
power -- this has always been the case so far. And although I don't have any
evidence this will change, it may become untrue in the future of course.

> Fixes: 608567aac3206ae8 ("thermal: da9062/61: Thermal junction temperature
> monitoring driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Untested due to lack of hardware.

So, I have not been able to make any time to test this patch yet -- and with
current workloads this might take a bit of time before I get to it.

Regards,
Steve

> v2:
>   - No changes.
> ---
>  drivers/thermal/da9062-thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-
> thermal.c
> index dd8dd947b7f0737c..01b0cb9944577851 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -106,7 +106,7 @@ static void da9062_thermal_poll_on(struct work_struct
> *work)
>  					   THERMAL_EVENT_UNSPECIFIED);
> 
>  		delay = msecs_to_jiffies(thermal->zone->passive_delay);
> -		schedule_delayed_work(&thermal->work, delay);
> +		queue_delayed_work(system_freezable_wq, &thermal->work,
> delay);
>  		return;
>  	}
> 
> @@ -125,7 +125,7 @@ static irqreturn_t da9062_thermal_irq_handler(int irq,
> void *data)
>  	struct da9062_thermal *thermal = data;
> 
>  	disable_irq_nosync(thermal->irq);
> -	schedule_delayed_work(&thermal->work, 0);
> +	queue_delayed_work(system_freezable_wq, &thermal->work, 0);
> 
>  	return IRQ_HANDLED;
>  }
> --
> 2.17.1

