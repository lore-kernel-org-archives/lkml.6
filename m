Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B346C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 13:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563AD208A6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 13:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563AD208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754227AbeGHNeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 09:34:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33489 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753952AbeGHNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 09:34:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id k7-v6so8267550wrq.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 06:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJeXE+wEyJCgStpsWlPB+B/KBDqkYTRxcq1LdbPS2FM=;
        b=lXQhqvZ6EAboQ5c8r4SJ/skW67Opke+ZhN4NUrxaeiuvbOOJwLM3P/YoFshTQhYBPR
         LW/BGfMrqeSMQnKRnEJ0DnJ5y+EJlxtFtBfa1W0drtyqXM4dP6vC1b0L4w+0jtax9XG3
         qToRtuFR/yH9w0RLWLxjruFEGi+wXpo4WO4rO4GIfCq2t3dpo4PWOHKnDiz2qzmmixRl
         L3X19RIQx/YZjH3+GaEw7jitPrYxJsb7k0D52PnFEQolOcnxAYsimZA5hrG3oqB14abp
         CXHDsqsCrJu6RedxHWkbF550SpMewQWkFYjlhd9he33yiKr58F48pMlL9dMOy+inu0dM
         q60g==
X-Gm-Message-State: APt69E0qIJbrJXlbYByu0djeU3gW48k2dTtuI7ekSr+5q2vmS/eNrYsO
        mRLo2BalE6xHy5109bN4mzkuMA==
X-Google-Smtp-Source: AAOMgpcrcfgun7s6OOriPDkf8ycKvrK5Hp2iF9urgZgvdvYZX5QBxGXth16Mb+ik4Dol/rNcgB9t3A==
X-Received: by 2002:adf:92a5:: with SMTP id 34-v6mr13097265wrn.83.1531056845461;
        Sun, 08 Jul 2018 06:34:05 -0700 (PDT)
Received: from [172.20.4.104] (nat-wifi-invi.ual.es. [150.214.223.90])
        by smtp.gmail.com with ESMTPSA id j77-v6sm13290468wmd.19.2018.07.08.06.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 06:34:04 -0700 (PDT)
Subject: Re: [PATCH v3] driver core: add a debugfs entry to show deferred
 devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180708003256.15655-1-javierm@redhat.com>
 <20180708132107.GA25491@kroah.com> <20180708132213.GA29000@kroah.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <1a75bc99-29e1-4a48-3f8e-dd3d89064326@redhat.com>
Date:   Sun, 8 Jul 2018 15:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180708132213.GA29000@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/08/2018 03:22 PM, Greg Kroah-Hartman wrote:
> On Sun, Jul 08, 2018 at 03:21:07PM +0200, Greg Kroah-Hartman wrote:
>> On Sun, Jul 08, 2018 at 02:32:56AM +0200, Javier Martinez Canillas wrote:
>>> With Device Trees (DT), the dependencies of the devices are defined in the
>>> DT, then the drivers parse that information to lookup the needed resources
>>> that have as dependencies.
>>>
>>> Since drivers and devices are registered in a non-deterministic way, it is
>>> possible that a device that is a dependency has not been registered yet by
>>> the time that is looked up.
>>>
>>> In this case the driver that requires this dependency cannot probe and has
>>> to defer it. So the driver core adds it to a list of deferred devices that
>>> is iterated again every time that a new driver is probed successfully.
>>>
>>> For debugging purposes it may be useful to know what are the devices whose
>>> probe function was deferred. Add a debugfs entry showing that information.
>>>
>>>   $ cat /sys/kernel/debug/devices_deferred
>>>   48070000.i2c:twl@48:bci
>>>   musb-hdrc.0.auto
>>>   omapdrm.0
>>>
>>> This information could be obtained partially by enabling debugging, but it
>>> means that the kernel log has to be parsed and the probe deferral balanced
>>> with the successes. This can be error probe and has to be done in a ad-hoc
>>> manner by everyone who needs to debug these kind of issues.
>>>
>>> Since the information is already known by the kernel, just show it to make
>>> it easier to debug.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Reviewed-by: Mark Brown <broonie@kernel.org>
>>>
>>> ---
>>>
>>> Changes since RFC v1:
>>> - Remove unneeded ret variable from deferred_devs_show()
>>>
>>> Changes since RFC v2:
>>> - Use DEFINE_SHOW_ATTRIBUTE() macro.
>>> - Don't propagate debugfs_create_file() error.
>>> - Remove IS_ENABLED(CONFIG_DEBUG_FS) guards.
>>> - Drop RFC prefix.
>>>
>>> Changes since v1:
>>> - Better explain in the commit message why this patch is useful.
>>> - Rename deferred_devices entry to devices_deferred.
>>> - Add an exit function and remove the debugfs entry.
>>>
>>> Changes since v2:
>>> - Add Andy Shevchenko and Mark Brown Reviewed-by tag.
>>> - Rebase on top of Greg's driver-core-next branch.
>>>
>>>
>>>  drivers/base/dd.c | 30 ++++++++++++++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index 6ea9c5cece7..140f534ee9c 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -16,6 +16,7 @@
>>>   * Copyright (c) 2007-2009 Novell Inc.
>>>   */
>>>  
>>> +#include <linux/debugfs.h>
>>>  #include <linux/device.h>
>>>  #include <linux/delay.h>
>>>  #include <linux/dma-mapping.h>
>>> @@ -53,6 +54,8 @@ static DEFINE_MUTEX(deferred_probe_mutex);
>>>  static LIST_HEAD(deferred_probe_pending_list);
>>>  static LIST_HEAD(deferred_probe_active_list);
>>>  static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>>> +static struct dentry *deferred_devices;
>>> +static bool initcalls_done;
>>
>> Wait, why add this variable?  No one uses it that I can see in this
>> patch, doesn't it create a build warning?
>>

Argh, sorry about that. It was my bad when doing the conflict resolution. This
variable got removed by commit 0a50f61c4fb ("drivers: base: initcall_debug logs
for driver probe times") that made the patch to not apply cleanly anymore.

>> You did test-build this, right?
> 
> I just tested it, it causes a build warning, which implies that you did
> not test this :(
>

I did but missed the build warning.

> greg k-h
>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
