Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65313C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216DD2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiUH7nL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216DD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeLCOoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:44:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46795 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeLCOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:44:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12434630wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 06:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZs0JCfowqjDk703izLtsDX/StW0OerYl900mykPvWo=;
        b=CiUH7nL5b7ANvZmP2KDAtDDGltfk1FDBVbq5NtlezT9FDRtYfQyN4T8mj9rKfdm3sv
         q28kQ6pFdU+rf1zviXWrTPmN708PNiPsFpzzIcpuRYahrlHLqXCBD4Hw30aP7W8fNADo
         JRbCoSwcwz1BJlYMRv7mGT5hpxL8xThTnoGoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZs0JCfowqjDk703izLtsDX/StW0OerYl900mykPvWo=;
        b=B81AwhYtD3PP/Cvk7txEsDacezpyl1FP+VXfP1VouVjKF6AzZd2+LUzZGBfpjPeGw2
         2DQqpGgtEjdK0HBdvL7Rsp14vstOJ/Kt2NAFkboSvdfIqqPqDclU3swy/gBuUIYTvZPG
         6XepooCT762NPBw+vsBo2AmNuQM3Q5GlRPJTTyAzyRGJd9G72EXAcyYTRYFlF2c+oKFk
         Aftx1uGZm0fpR1yHPiTXiYbzjZx4IqlSe5WMzA4duH3hRQ+BNUyhhYIC4b+qFlJQI/fm
         pzpnW0muvbaKROcahb4gm3zfwEjeMaDKrdI300e+VgeKO+8wRYsf1Q+b6IZOgv4ndnjP
         UUlQ==
X-Gm-Message-State: AA+aEWYFledcN+McD+0EWpl+pdx3rTpWT1OcMfuPRFSYkkex8scNgenp
        tstFY6aHNC1rmc/qV+DOq/3eUg==
X-Google-Smtp-Source: AFSGD/V/2gB+hgGqgEq8Q1KTHqQDhzCnntGbYx/z5yjjSAZk1g+i/V7zafwNEzEUkQj7NmVoKVvSug==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr13784402wrc.0.1543848163460;
        Mon, 03 Dec 2018 06:42:43 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id i9sm15923015wrs.34.2018.12.03.06.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 06:42:42 -0800 (PST)
Subject: Re: v4.14 fix for Hikey 960 unbalanced IRQ enablement
To:     Greg KH <gregkh@linuxfoundation.org>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     sashal@kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
 <20181203141442.GA19335@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dc468512-7a73-3d69-fe9e-d660db85ee5b@linaro.org>
Date:   Mon, 3 Dec 2018 15:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203141442.GA19335@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 15:14, Greg KH wrote:
> On Mon, Dec 03, 2018 at 11:31:02AM -0200, Rafael David Tinoco wrote:
>> Sasha, could you consider including this cherry-picked patchset in v4.14.
>>
>> Kernel v4.14 might suffer from the following unbalanced enablement for the board Hikey 960:
>>
>> Nov  5 12:02:54 hikey kernel: [   22.148194] Unbalanced enable for IRQ 44
>> Nov  5 12:02:54 hikey kernel: [   22.152193] ------------[ cut here ]------------
>> Nov  5 12:02:54 hikey kernel: [   22.156872] WARNING: CPU: 2 PID: 509 at /home/inaddy/work/sources/linux/stable/stable-linux-4.14.y/kernel/irq/manage.c:525 __enable_irq+0x78/0x80
>> Nov  5 12:02:54 hikey kernel: [   22.249606] CPU: 2 PID: 509 Comm: kworker/2:2 Not tainted 4.14.79 #1
>> Nov  5 12:02:54 hikey kernel: [   22.255975] Hardware name: HiKey Development Board (DT)
>> Nov  5 12:02:54 hikey kernel: [   22.261248] Workqueue: events_freezable thermal_zone_device_check
>> Nov  5 12:02:54 hikey kernel: [   22.267368] task: ffff8000616e0e00 task.stack: ffff00000b5f0000
>> Nov  5 12:02:54 hikey kernel: [   22.273312] PC is at __enable_irq+0x78/0x80
>> Nov  5 12:02:54 hikey kernel: [   22.277516] LR is at __enable_irq+0x78/0x80
>> Nov  5 12:02:54 hikey kernel: [   22.281718] pc : [<ffff00000813e010>] lr : [<ffff00000813e010>] pstate: 000001c5
>> Nov  5 12:02:54 hikey kernel: [   22.289129] sp : ffff00000b5f3c80
>> Nov  5 12:02:54 hikey kernel: [   22.292457] x29: ffff00000b5f3c80 x28: 0000000000000000 
>> Nov  5 12:02:54 hikey kernel: [   22.297804] x27: ffff80005c139e38 x26: ffff000008a71870 
>> Nov  5 12:02:54 hikey kernel: [   22.303148] x25: 0000000000000000 x24: 0000000000000002 
>> Nov  5 12:02:54 hikey kernel: [   22.308492] x23: ffff00000b5f3d9c x22: ffff80005d565e88 
>> Nov  5 12:02:54 hikey kernel: [   22.313836] x21: 000000000000f980 x20: 000000000000002c 
>> Nov  5 12:02:54 hikey kernel: [   22.319181] x19: ffff800061726000 x18: 0000000000000010 
>> Nov  5 12:02:54 hikey kernel: [   22.324524] x17: 0000000000000000 x16: 0000000000000000 
>> Nov  5 12:02:54 hikey kernel: [   22.329868] x15: ffffffffffffffff x14: ffff000009269c08 
>> Nov  5 12:02:54 hikey kernel: [   22.335213] x13: ffff00008940678f x12: ffff000009406797 
>> Nov  5 12:02:54 hikey kernel: [   22.340558] x11: ffff000009290000 x10: ffff00000b5f3980 
>> Nov  5 12:02:54 hikey kernel: [   22.345902] x9 : 00000000ffffffd0 x8 : ffff00000862c298 
>> Nov  5 12:02:54 hikey kernel: [   22.351246] x7 : 6c62616e65206465 x6 : 00000000000001b2 
>> Nov  5 12:02:54 hikey kernel: [   22.356589] x5 : 0000000000000000 x4 : 0000000000000000 
>> Nov  5 12:02:54 hikey kernel: [   22.361931] x3 : 0000000000000000 x2 : ffff800063e824c8 
>> Nov  5 12:02:54 hikey kernel: [   22.367275] x1 : 000080005af95000 x0 : 000000000000001c 
>> Nov  5 12:02:54 hikey kernel: [   22.372618] Call trace:
>> Nov  5 12:02:54 hikey kernel: [   22.375088] Exception stack(0xffff00000b5f3b40 to 0xffff00000b5f3c80)
>> Nov  5 12:02:54 hikey kernel: [   22.381560] 3b40: 000000000000001c 000080005af95000 ffff800063e824c8 0000000000000000
>> Nov  5 12:02:54 hikey kernel: [   22.389417] 3b60: 0000000000000000 0000000000000000 00000000000001b2 6c62616e65206465
>> Nov  5 12:02:54 hikey kernel: [   22.397276] 3b80: ffff00000862c298 00000000ffffffd0 ffff00000b5f3980 ffff000009290000
>> Nov  5 12:02:54 hikey kernel: [   22.405136] 3ba0: ffff000009406797 ffff00008940678f ffff000009269c08 ffffffffffffffff
>> Nov  5 12:02:54 hikey kernel: [   22.412994] 3bc0: 0000000000000000 0000000000000000 0000000000000010 ffff800061726000
>> Nov  5 12:02:54 hikey kernel: [   22.420852] 3be0: 000000000000002c 000000000000f980 ffff80005d565e88 ffff00000b5f3d9c
>> Nov  5 12:02:54 hikey kernel: [   22.428710] 3c00: 0000000000000002 0000000000000000 ffff000008a71870 ffff80005c139e38
>> Nov  5 12:02:54 hikey kernel: [   22.436569] 3c20: 0000000000000000 ffff00000b5f3c80 ffff00000813e010 ffff00000b5f3c80
>> Nov  5 12:02:54 hikey kernel: [   22.444426] 3c40: ffff00000813e010 00000000000001c5 0000000000000000 0000000000000000
>> Nov  5 12:02:54 hikey kernel: [   22.452286] 3c60: ffffffffffffffff ffff800061800618 ffff00000b5f3c80 ffff00000813e010
>> Nov  5 12:02:54 hikey kernel: [   22.460144] [<ffff00000813e010>] __enable_irq+0x78/0x80
>> Nov  5 12:02:54 hikey kernel: [   22.465394] [<ffff00000813e058>] enable_irq+0x40/0x78
>> Nov  5 12:02:54 hikey kernel: [   22.470493] [<ffff000000e228a8>] hisi_thermal_get_temp+0x1b0/0x1d8 [hisi_thermal]
>> Nov  5 12:02:54 hikey kernel: [   22.478008] [<ffff0000087121a8>] of_thermal_get_temp+0x38/0x50
>> Nov  5 12:02:54 hikey kernel: [   22.483869] [<ffff000008711790>] thermal_zone_get_temp+0x58/0x80
>> Nov  5 12:02:54 hikey kernel: [   22.489903] [<ffff00000870e7bc>] thermal_zone_device_update.part.4+0x2c/0x1a8
>> Nov  5 12:02:54 hikey kernel: [   22.497066] [<ffff00000870e9c8>] thermal_zone_device_check+0x40/0x50
>> Nov  5 12:02:54 hikey kernel: [   22.503457] [<ffff0000080f1674>] process_one_work+0x19c/0x3d0
>> Nov  5 12:02:54 hikey kernel: [   22.509236] [<ffff0000080f18f4>] worker_thread+0x4c/0x428
>> Nov  5 12:02:54 hikey kernel: [   22.514664] [<ffff0000080f84fc>] kthread+0x134/0x138
>> Nov  5 12:02:54 hikey kernel: [   22.519659] [<ffff000008085154>] ret_from_fork+0x10/0x1c
>> Nov  5 12:02:54 hikey kernel: [   22.524988] ---[ end trace 328d4bb2d9b066a0 ]---
>>
>> This issue was solved when "hisi_thermal_alarm_irq" function was removed so only
>> "hisi_thermal_alarm_irq_thread" would exist. This has fixed the issue for the
>> unbalanced enablement since there is no more:
>>
>> 	disable_irq_nosync(irq);
>> 	data->irq_enabled = false;
>>
>> logic being done in parallel to the threaded handler AND the
>> thermal_zone_device_update() call only happens now if the temperature is already
>> above the threshold.
>>
> 
> So should we revert a patch instead of taking these new ones?  Would
> that be easier and is this a "real" issue or just an annoying warning
> splat in the kernel log?

Actually, this warning is introduced with the driver and all the
plumbers around to fix an irq bouncing. There is no patch to revert
without removing the driver.

What the log in the series does not tell is the driver was initially
built around a supposed issue with the thermal sensor, that is multiple
interrupts firing for the same event.

Those happen when a specific threshold is reached (down to up and up to
down) and a hysteresis should have been specified in the register in
order to prevent multiple interrupts firing when the limit is crossed.

All the code in the driver was built to overcome this issue because the
root cause was not spotted: the hysteresis register was not correctly
set and it was reset at every update. The driver 'workarounded' that by
creating some kind of irq enabled flag, a sensor reset every time it was
read and other hacks to make it work (it results in a worst temperature
measurement accuracy also because the temperature buffer on the chip is
flushed).

These 5 patches not only fixes the irq issue but also sanitize the
driver. There is no longer a reset of the sensor, no irq bouncing and no
5ms delay when the sensor is read.








-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

