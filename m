Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD43C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BC520657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfAQLlU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:41:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37844 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfAQLlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:41:19 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gk62u-0004My-W5
        for linux-kernel@vger.kernel.org; Thu, 17 Jan 2019 11:41:17 +0000
Received: by mail-pl1-f200.google.com with SMTP id v12so5875077plp.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 03:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IPxrqQnKcrHuHratqjWNtQBiUH385900csiixktheXo=;
        b=dLCiyBIT90YPopiAdG8ra+zmlhREdQ0sqIwSyZXfGpzhUkl2cGPYA+mpHY6QusuIQL
         wMWY7E18G/n5eDc7BqYr2qsgbC49LX8La/Cxjz/AoD2Z4BEw0HwhZhWGar1U91j5vaTZ
         3wQtT+715zMKhwH7+P00GvevCKuYqpMl3/wcYKNr1c1IRBrLdysQZc/H3oM7fcAw4taC
         +erzZ8Xua02KywVMlp7k8Gz5bBiPjrKxx1GL4aO02lm/4FiLK4U05MazZLUnAk+XH4qM
         MqfdFCvfC6ZDryV6LlDJ8Q7TgWITqYhZK0r2IBgswsUmvxL20/zIDxYmuM9O+dWWJjou
         iKYQ==
X-Gm-Message-State: AJcUukeh0MW++11+99BGRVL/0UHtFkKXfqmQJUFxJ+yQTVMV+tdOVYZd
        Bzsy7/2f7qW9OCLSuvvq9etgabtcHfK5wed7x9vqCyxf4Y9XrOSkBqFBASKHevQtNlQam6zyGxY
        LPnNc0K+w/V56V+TQ9vs/8uZufFsPReIpODlHX+IzLQ==
X-Received: by 2002:a62:46d0:: with SMTP id o77mr14670188pfi.172.1547725275469;
        Thu, 17 Jan 2019 03:41:15 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6209Tcv0xZ5TSPJykZW8lETjgv2V9A7fiYF5C+PqAoHlHyuliQKNG9BJBHlzszv/LaExuILA==
X-Received: by 2002:a62:46d0:: with SMTP id o77mr14670171pfi.172.1547725275192;
        Thu, 17 Jan 2019 03:41:15 -0800 (PST)
Received: from 2001-b011-380f-13aa-ed95-5ef5-fa2b-0d58.dynamic-ip6.hinet.net (2001-b011-380f-13aa-ed95-5ef5-fa2b-0d58.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:ed95:5ef5:fa2b:d58])
        by smtp.gmail.com with ESMTPSA id y71sm2970806pfi.123.2019.01.17.03.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 03:41:14 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJLHm8b6X9kX1myz7xx1992VW2tVjdn6xw2n1MVX2dn0=g@mail.gmail.com>
Date:   Thu, 17 Jan 2019 19:41:12 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1897F291-4EB4-4E4B-87AA-3C16EF321340@canonical.com>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
 <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
 <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com>
 <CAO-hwJLHm8b6X9kX1myz7xx1992VW2tVjdn6xw2n1MVX2dn0=g@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2019, at 16:06, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Thu, Jan 17, 2019 at 6:02 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
[snipped]
>> Goodix says the firmware needs at least 60ms to fully respond ON and
>> SLEEP command.
> 
> I was about to say that this is not conformant to the specification.
> But looking at 7.2.8 SET_POWER of
> https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)
> 
> They say:
> "The DEVICE must ensure that it transitions to the HOST specified
> Power State in under 1 second. "
> But in the RESPONSE paragraph: "The DEVICE shall not respond back
> after receiving the command. The DEVICE is mandated to enter that
> power state imminently."
> 
> My interpretation was always that the device has to be in a ready
> state for new commands "immediately".
> However, the first sentence may suggest that the driver would block
> any command to the device before the 1 second timestamp.
> 
>> 
>> I’ll see if an 200ms autosuspend can solve all Goodix, LG and Raydium
>> touchpanels.
> 
> We already have a I2C_HID_QUIRK_DELAY_AFTER_SLEEP quirk that delay
> operations after sleep by 20ms. Maybe we can keep the runtime PM but
> use the same timers to not confuse the hardware.

Yes, but wouldn’t use pm_*_autosuspend() helpers can both solve the issue
and make the code more cleaner?

Kai-Heng

> 
> Cheers,
> Benjamin

