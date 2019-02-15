Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE1BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AB021B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392602AbfBOJZI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:25:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59000 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfBOJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:25:05 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1guZjy-0007ma-Fi
        for linux-kernel@vger.kernel.org; Fri, 15 Feb 2019 09:25:02 +0000
Received: by mail-pg1-f197.google.com with SMTP id t26so6387893pgu.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BJoGR3Jqu9tA0XPgH2mLolLr0PGFn7j/pRWqd1Fbzbk=;
        b=mi7IiMSECh7WJiGPTjXniI5y+qKO0tms1WwCQMPF8w4pyMWm9kxQR47JECqGpDJv3w
         hOUmgaMHr+pKCMlsZ3pm91SvNyLF0QwR23naX+DK8m9EczIQwBeDDplmatuO0IuCs2+p
         G7KILkDlQqUAXA445hfLADRbEgFpkz7Z0fO05YUyirdBhdHnZxohb6DDeRomh+wqU6ds
         tUYfoTTQyKOIVdEHJSCE+WXp9DQC4q2ZPfc7aPwLtUQolZYRgAfjg4Z97B2CEwUCF3vf
         G7EEBzrHnPe2mLZoBHHEaJzGfVJkN52ucRhxyIIxA1AqBregih4BWSBPhEgqvv8HcF/y
         lqxQ==
X-Gm-Message-State: AHQUAuYEn2RY2jc5Nuq7q+4GHQAGitgecyo9VqD4WjSct6JbIf7OUjg+
        oyiGRmjCd5LbSR5Ib8G114FzO6ixa4UgBdlC+MlBWKq0rwqjCh2C871FHeFnTDSuA9LVssqMIWH
        T2fYMR5gbzMmufKyCAy6t+iesGQ+XDzhYf1XtdmZqPg==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr8794989plq.278.1550222701200;
        Fri, 15 Feb 2019 01:25:01 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYcsTwso7bijU5uvgyxc6s126KXbPhayDZ1FykbHSOOaXhz0373LCCozrWXrkTQ3igiZtGprA==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr8794967plq.278.1550222700789;
        Fri, 15 Feb 2019 01:25:00 -0800 (PST)
Received: from 2001-b011-380f-39c7-759a-ff6b-a5f3-69c6.dynamic-ip6.hinet.net (2001-b011-380f-39c7-759a-ff6b-a5f3-69c6.dynamic-ip6.hinet.net. [2001:b011:380f:39c7:759a:ff6b:a5f3:69c6])
        by smtp.gmail.com with ESMTPSA id 125sm6067365pfg.39.2019.02.15.01.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 01:24:59 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Fix resume for ELAN2097 touchscreen.
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <nycvar.YFH.7.76.1902150834180.11598@cbobk.fhfr.pm>
Date:   Fri, 15 Feb 2019 17:24:57 +0800
Cc:     Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6280CE2E-0820-48DA-ABA1-621D107511CF@canonical.com>
References: <20190211070040.4569-1-jbroadus@gmail.com>
 <nycvar.YFH.7.76.1902140036400.11598@cbobk.fhfr.pm>
 <CAKgEEwteam5TCWAUtgQKxQpTzTk3+_DktmqwxZTLa=w3xt5i8Q@mail.gmail.com>
 <nycvar.YFH.7.76.1902150834180.11598@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>, james broadus <jbroadus@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri and James,

> On Feb 15, 2019, at 15:35, Jiri Kosina <jikos@kernel.org> wrote:
> 
> On Thu, 14 Feb 2019, james broadus wrote:
> 
>>> This should be fixed in hid.git#for-5.1/i2c-hid already by commit
>>> 1475af255e18f. Could you please confirm that?
>>> 
>> 
>> Hi Jiri. That change mutes the log messages, but I'm still counting 
>> around 35000 interrupts per second after resume and touch does not work. 
>> With the reset, the device works properly.
> 
> Ah, I see. Should your patch then actually replace 1475af255e18f?

Sorry for the late reply, was off because of Lunar new year.

Commit 1475af255e18f is to silence the message when using the touchpad, so it’s different to this patch.

I’ve seen similar bugs happens on new platforms that defaults S2Idle (Modern Standby), but user uses S3 instead.
On those systems, S3 was never tested, so the BIOS doesn’t cut the touchpad’s power off during S3, and the IRQ line wasn’t getting properly reset.

So if the platform defaults to S2Idle but user wants to use S3, this issue happens.
If that’s the case, maybe it’s better to report to the platform vendor.

Kai-Heng

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

