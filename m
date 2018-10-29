Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D9520824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D9520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJ3BXR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:23:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59085 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeJ3BXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:23:16 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gHASC-00054P-5T
        for linux-kernel@vger.kernel.org; Mon, 29 Oct 2018 16:31:48 +0000
Received: by mail-pl1-f198.google.com with SMTP id x17-v6so6994779pln.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F14bP7bItmtRHnWP9hhcVXpmsiXAezfiw786UQ7+w64=;
        b=EfWbwY7wgNAdSFk7oXoX/biCkyjCPFD4Jnj1JcP5f9i29GymEOSzLuZMgZax5hrwrD
         RRwFNRry+pvNy09vplZ2YNtDLyc938/NRzt3jG2tGybO67VVKW4qRzUMPntuENoTtlk2
         LckNqqnEn66nuYTPSk8C/tbiGuQi076l/opFDbo9/Mb+YARrjt9qbKhe0Cjo7BwT74gi
         Z9h56MDSiBXezi7Gxvi4VX/xttofmM3HUrNfECf62QyU3f74UzNzZE0AweGtukq8nBwB
         ddD6f9jC4TlOAkFphQL69P9ZqTp4BIaZkWBcTcT1d1wgDE7Alvb79JrbJntNUr36GDax
         WZPA==
X-Gm-Message-State: AGRZ1gLPUSsNv5ilgzvsEub8a+inVKX+sSc3bDanIonq7xakMhECsqoR
        3owYs4rybHB7I3pos3/cHbU15znbCkbI3nXII8H6B3KorPIURO1MKroAe7k48ScZ0wXvdAL5P0Y
        tlJw9ndqldn0Qpv0sWCjuT8LkCHehoFoxxZdoTDCZkA==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr14490772plb.6.1540830706707;
        Mon, 29 Oct 2018 09:31:46 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dnBJTXgRaj2EIpSPIY5RvGRtnvEmE8DC1uJWReJbkamd6iZHOzX8z3ZwSy3Dy+/mPvcys3Dw==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr14490752plb.6.1540830706237;
        Mon, 29 Oct 2018 09:31:46 -0700 (PDT)
Received: from 2001-b400-e2aa-fff2-195c-727f-f64f-66ec.emome-ip6.hinet.net (2001-b400-e2aa-fff2-195c-727f-f64f-66ec.emome-ip6.hinet.net. [2001:b400:e2aa:fff2:195c:727f:f64f:66ec])
        by smtp.gmail.com with ESMTPSA id l129-v6sm29487409pfc.155.2018.10.29.09.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:31:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 2/4 v5] memstick: Prevent memstick host from getting
 runtime suspended during card detection
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAPDyKFrtQeDUK0Dxu9Z3-eyyMbChHHb2He1AFq2My_7-cTY2FA@mail.gmail.com>
Date:   Tue, 30 Oct 2018 00:31:41 +0800
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E8BC3191-E48C-423C-B704-929F7FAC4930@canonical.com>
References: <20181024084958.4627-1-kai.heng.feng@canonical.com>
 <20181024084958.4627-3-kai.heng.feng@canonical.com>
 <CAPDyKFrtQeDUK0Dxu9Z3-eyyMbChHHb2He1AFq2My_7-cTY2FA@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 29, 2018, at 20:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> On 24 October 2018 at 10:49, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
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
>> index 76382c858c35..5f16a8826401 100644
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
>> +       pm_runtime_get_noresume(host->dev.parent);
>>        queue_work(workqueue, &host->media_checker);
>> }
>> EXPORT_SYMBOL(memstick_detect_change);
>> @@ -479,6 +481,8 @@ static void memstick_check(struct work_struct *work)
>>                host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
>> 
>>        mutex_unlock(&host->lock);
>> +
>> +       pm_runtime_put(host->dev.parent);
>>        dev_dbg(&host->dev, "memstick_check finished\n");
>> }
>> 
> 
> I am not sure this works, sorry.
> 
> More precisely, I don't think there is a guarantee that the calls to
> pm_runtime_get|put*() becomes properly balanced. In principle
> memstick_detect_change() could be called, without actually causing a
> new work to be scheduled if there is already such a work in the queue
> (depends on the workqueue configuration). Isn't it so?

You are right.

We can use test_and_set_bit() or alike to properly balance pm_runtime
helpers, but the most straightforward solution in my mind is to merge 
memstick_detect_change() and memstick_check() as one function.

memstick_detect_change() it’s the only user of memstick_check() anyway.

Or is there a better way in your mind?

Kai-Heng

> 
> Kind regards
> Uffe

