Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA38C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F7B20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F7B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeKKVde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:33:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39391 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeKKVde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:33:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so2618440edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 03:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQUjfeO5EvjMpSjaS21n/gQhWKHYdRmyWxPHMwgiUwk=;
        b=tGBZzeqqvpNwTI9h8i9+GNHMdE22vc2VRilIlkY6UBfLIi3Y6zFJY3uiQZ62UIha1w
         b1uL7e2vooVCoxgNTndFzqvqLa15QAtmg+VNQW83RrUqiq6cxteF3PkOjOB9qq4QunF8
         fPM+zoDfgUE4tT0ftVos0IaikJGwuCq1MOdMR1tTuufnBxuV6PlpHQu0nVOZ0tZ2ca+g
         CeQLgLCCgk46hYLZ1U7yzrNgJ4Muus01aEQbQM8bBEzh36aBJ7wlwnu1Mgi70NS7FK+L
         YCkFiexPCD1bnNk+BF+rO8USBmRRpUQJzDDOy2XpNNEzNZgsRA0o+lUDMoywncda3YE4
         DpSw==
X-Gm-Message-State: AGRZ1gINiceT9PIOx0E9ZcxC075KkkujQJp+f+ZtyqWqfPI0JANga4Y/
        tKO6SAngQbLaUE8lk7klLvmQow==
X-Google-Smtp-Source: AJdET5ct0+I8PIPmVFm+s0kl0kjcIFv6ckS2Od61/NDGXgYLdD84Hp3ZFXJ/H9UHljCiP4J0a1N1Fw==
X-Received: by 2002:a50:ad9a:: with SMTP id a26-v6mr9413962edd.60.1541936711198;
        Sun, 11 Nov 2018 03:45:11 -0800 (PST)
Received: from dhcp-45-79.space.revspace.nl ([2a01:4f8:1c0c:6c86:74cc:2527:1001:2c5e])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1907653ejz.30.2018.11.11.03.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 03:45:10 -0800 (PST)
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Grant Likely <grant.likely@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <20181110182622.GA32657@kroah.com>
 <20181110183629.GE10650@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dda29b24-035f-eb0b-fd07-dce6680e8912@redhat.com>
Date:   Sun, 11 Nov 2018 12:45:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181110183629.GE10650@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/10/18 7:36 PM, Andy Shevchenko wrote:
> On Sat, Nov 10, 2018 at 10:26:22AM -0800, Greg Kroah-Hartman wrote:
>> On Sat, Nov 10, 2018 at 08:10:57PM +0200, Andy Shevchenko wrote:
>>> Consider the following scenario.
>>>
>>> There are two independent devices coupled together by functional dependencies:
>>>   - USB OTG (dwc3-pci)
>>>   - extcon (tested with extcon-intel-mrfld, not yet in upstream)
>>>
>>> Each of the driver services a corresponding device is built as a module. In the
>>> Buildroot environment the modules are probed by alphabetical ordering of their
>>> modaliases. The latter comes to the case when USB OTG driver will be probed
>>> first followed by extcon one.
>>>
>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>> we will get deferred probe of USB OTG, because of ordering.
>>>
>>> Now, a cherry on top of the cake, the deferred probing list contains
>>> the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
>>> values in the local_trigger_count and deferred_trigger_count are not the same,
>>> and thus provokes deferred probe triggering again and again.
>>>
>>> ...
>>> [   20.678332] platform dwc3.0.auto: Retrying from deferred list
>>> [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>> [   20.701254] platform dwc3.0.auto: Added to deferred list
>>> [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
>>> [   20.713732] platform dwc3.0.auto: Retrying from deferred list
>>> [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>> [   20.736540] platform dwc3.0.auto: Added to deferred list
>>> [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
>>> [   20.748991] platform dwc3.0.auto: Retrying from deferred list
>>> [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>> [   20.771914] platform dwc3.0.auto: Added to deferred list
>>> [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
>>> ...
>>>
>>> Deeper investigation shows the culprit commit 58b116bce136
>>> ("drivercore: deferral race condition fix") which was dedicated to fix some
>>> other issue while bringing a regression.
>>>
>>> This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
>>> we will have better solution.
>>>
>>> Cc: Grant Likely <grant.likely@linaro.org>
>>> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Felipe Balbi <balbi@kernel.org>
>>> Cc: Andrzej Hajda <a.hajda@samsung.com>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>   drivers/base/dd.c | 27 ++-------------------------
>>>   1 file changed, 2 insertions(+), 25 deletions(-)
>>
>> Shouldn't there be a "Fixes:" line and cc: stable here?
> 
> I'm not sure (yet). I would like to hear from people first, especially from
> Grant (I spoke to him already for the matters at ELCE in Edinburg).
> 
> Perhaps, Hans can have a chance to test this and comment on.

I'm currently hitting a regression in 4.20-rc1 which causes it to not
boot on my Cherry Trail test devices (sdhci driver times out so it
cannot find its root filesystem).

I'm currently debugging this (it looks like I need todo a full bisect to
find the cause) once I've that working, if I hit something which look
likes you've described I will give this patch a test. But currently I
cannot reproduce the problem you describe.

As for patches 2-55, they look good to me:

Ackeed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

