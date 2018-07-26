Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D83B20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D83B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeGZIRa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:17:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41748 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbeGZIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:17:29 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fiaHj-0005Ok-8I
        for linux-kernel@vger.kernel.org; Thu, 26 Jul 2018 07:02:03 +0000
Received: by mail-pg1-f198.google.com with SMTP id x2-v6so512551pgp.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c2UXz0IhWiLlFua9siw3rlSGA+FRy/fwFDck+MvGCxs=;
        b=nW7X2SJyDPJWVrIyNc21qs2YMOtMKiX34BqeMIV8q1QRJEfwKEH3f7ji3S0HArdxTB
         UaBXOjtq/BgUd9V1wS/SUh3T1nSVfbJlT6cLe7PZ0BXGbzwUj/ZnIW2YF3McDoZN5UA8
         u/goNq+OGeDmUtHmandBwy7S+lVMRGqJAJ27k2mxGiZ0cIsPIdpc1uOHUbtTfzgQpJDx
         N2oy8r/F7Cs1oLc3BozUEx14NJ4UeifPBB2TCw1k9zcrW2zysCfsLY1QZpKupJSviv+f
         fAWfN5M8RfjVbF8vZWd3yzt3j9aAVngxGrypZv/v9+VP3LLAbUM6rIPgYerisfZJJax+
         SqTA==
X-Gm-Message-State: AOUpUlF++MojwWcn3fR8AOFXL6y8095ToSkFoJzXbhcNYN2csYmehvLT
        NIvZY/Y824y3vb43qTY7byjBnUZhW9Xw2uooewMhUJTH9suVsQzgEHNNaq1L14tNYAwgB1UAWaH
        VQCX6ZFcw//Jh7LCUNggfG/QRaGI1ndmNV2zOnl9CWQ==
X-Received: by 2002:a63:d401:: with SMTP id a1-v6mr776012pgh.414.1532588521933;
        Thu, 26 Jul 2018 00:02:01 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpfe6Fs2JBQHfxHrDVwc0LS/hqABiDkYrWQ76H2z/84pCZm+JQ3o31AzkBioB18Nb+HGF7FPTA==
X-Received: by 2002:a63:d401:: with SMTP id a1-v6mr775985pgh.414.1532588521629;
        Thu, 26 Jul 2018 00:02:01 -0700 (PDT)
Received: from [192.168.20.35] (1-161-137-98.dynamic-ip.hinet.net. [1.161.137.98])
        by smtp.gmail.com with ESMTPSA id w2-v6sm996926pge.44.2018.07.26.00.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:02:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 2/5] memstick: Prevent memstick host from getting runtime
 suspended during card detection
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1807251353550.1467-100000@iolanthe.rowland.org>
Date:   Thu, 26 Jul 2018 15:01:56 +0800
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <10942DC1-3F18-4A87-A662-B8CD073FFA14@canonical.com>
References: <Pine.LNX.4.44L0.1807251353550.1467-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2018Jul26, at 01:56, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Wed, 25 Jul 2018, Kai-Heng Feng wrote:
> 
>> We can use MEMSTICK_POWER_{ON,OFF} along with pm_runtime_{get,put}
>> helpers to let memstick host support runtime pm.
>> 
>> There's a small window between memstick_detect_change() and its queued
>> work, memstick_check(). In this window the rpm count may go down to zero
>> before the memstick host powers on, so the host can be inadvertently
>> suspended.
>> 
>> Increment rpm count before calling memstick_check(), and decrement rpm
>> count afterward, as now we are sure the memstick host should be
>> suspended or not.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/memstick/core/memstick.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
>> index 76382c858c35..944fe0c93fa7 100644
>> --- a/drivers/memstick/core/memstick.c
>> +++ b/drivers/memstick/core/memstick.c
>> @@ -18,6 +18,7 @@
>> #include <linux/delay.h>
>> #include <linux/slab.h>
>> #include <linux/module.h>
>> +#include <linux/pm_runtime.h>
>> 
>> #define DRIVER_NAME "memstick"
>> 
>> @@ -209,6 +210,7 @@ static int memstick_dummy_check(struct memstick_dev *card)
>>  */
>> void memstick_detect_change(struct memstick_host *host)
>> {
>> +	pm_runtime_get_noresume(host->dev.parent);
>> 	queue_work(workqueue, &host->media_checker);
>> }
>> EXPORT_SYMBOL(memstick_detect_change);
>> @@ -479,6 +481,8 @@ static void memstick_check(struct work_struct *work)
>> 		host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
>> 
>> 	mutex_unlock(&host->lock);
>> +
>> +	pm_runtime_put_noidle(host->dev.parent);
>> 	dev_dbg(&host->dev, "memstick_check finished\n");
>> }
> 
> This should be pm_runtime_put(), not _put_noidle().  The reason is
> because if this call causes the PM runtime usage count to drop to 0,
> you do want the device to go into runtime suspend.

Will update in next version, thanks!

Kai-Heng

> 
> Alan Stern

