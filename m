Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3206C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB3521A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="0duoC++d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB3521A03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeHFNQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:16:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41797 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeHFNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:15:59 -0400
Received: by mail-io0-f196.google.com with SMTP id g7-v6so358868ioq.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 04:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4qJkcs4HfzL51knKen5vWZTfKdLM4oBGlqsw37SpMq4=;
        b=0duoC++dUzj2rkMMh7bFeTf3UGlVSK9YS4bfKUsBleoTcn5n1xKxziAP3SqX3p3/2/
         Psyd11VO/nNK+S3JB4XZaQALbxYhLNIQXlPJ2zcXjr3NOGbg72C3nE66ytXYWCfDzYkm
         exgV+3nsY++2RDjic1cX3dTt6soSDR2RHGsWy3kTatabIT3UVix/175cyfycar1i0yQV
         uYynidr/8bMenweyW66tzWiPAtLMwZX9ywFSy2Yq3KCJPzZwutrsMHZajrM8wRTGd7NM
         MNHIEZI4SHDWBYkFj08WakVwPLSf//4HkwMxBiLkUS9GMAH6Y5sG82HMMSCywglSLk3W
         fuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4qJkcs4HfzL51knKen5vWZTfKdLM4oBGlqsw37SpMq4=;
        b=Kyttbe5kaCoekmT9/DNmpi+hG1gpFhYjWXQDyVn30G3ysAO0bQTAKVFQr11JuyGz6P
         QWlmN8jGUrQBAoHqUBTE+tM/AhiuN21lIg9lccIdUeSZWGRT08zju6BZM7Cx+BWxp5CK
         UuBqz7PK4hNwOHHrsDYSDzdydo0UGooaLvUVAjC9y32vW3fvagWWmIkvN3VdjuZWvaZq
         E1xK4RUmdYWicpZahRBQFzaPJwu88Yxr+DOqIcXizgRKlcGAg/+yaasGxNycMUaEHmi8
         xeFAHtKlb4wLzw0qeHjFZiUqLnmIUIKG/rYma/A5Yr8eIQDLM5dIlY+O7NU3f4kZR7DR
         s3sA==
X-Gm-Message-State: AOUpUlFdM5LsSR9wxXKJU7960BCtv+tE/ynoITdWtRdtDLyaldlxAGmv
        aGjwwUk8+FnQvZ/p3QzXOgjA1Z7KRXN22ur37AgE7A==
X-Google-Smtp-Source: AAOMgpclMwvYmmb69+bPgNJIck6dyg1EUkocv6I2vGTHB20p3zNivnWn2kMsltdU45u8fergJLd5sAYn6FBYRfrbyc4=
X-Received: by 2002:a6b:cd8f:: with SMTP id d137-v6mr14497853iog.154.1533553646269;
 Mon, 06 Aug 2018 04:07:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8704:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 04:07:25 -0700 (PDT)
In-Reply-To: <73029405.6ZXyByzer1@aspire.rjw.lan>
References: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
 <73029405.6ZXyByzer1@aspire.rjw.lan>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 6 Aug 2018 19:07:25 +0800
Message-ID: <CAB4CAwcXg2ROwz17rZHzMpTEDYYfD1nteNgX=HE8EkOmyK3wag@mail.gmail.com>
Subject: Re: Built in PS2 keyboard in new ASUS/acer laptops can not wake up
 system after s2idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 5:37 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, August 3, 2018 10:04:09 AM CEST Chris Chiu wrote:
>> Hi guys,
>>     We have some new laptops with Intel new Intel WiskyLake CPU come
>> in and they all have the same problem. They all have the so-called
>> "Modern Standby" feature which is s2idle in Linux.
>>
>>     The problem is the built-in keyboard no longer wake up the system
>> after it goes to s2idle. Only the power button can wake up. It's
>> different from the other laptops with old Intel CPUs (CoffeeLake,
>> KaybeLake...etc). We found the difference is that the EC (embedded
>> controller) no longer signals SCI event when in s2idle.
>>
>>     Confirmed with ASUS EC engineer, he also admits that the EC code
>> for signaling SCI event in modern standby has been removed on
>> WiskyLake models. Because the built-in PS2 keyboard can still wake up
>> the system on WisksyLake+Windows10 RS4 combination without EC
>> intervention.
>>
>>     Based on this information, we suspect that maybe the built-in
>> keyboard wakeup on Windows 10 RS4 in enabled by default (although we
>> don't know how to prove that). It's easy to simply do
>> 'device_set_wakeup_enable' and 'enable_irq_wake' for the i8042
>> keyboard port to wake up the system without EC, but it's nasty.
>>
>>     Any suggestion about how to achieve the keyboard wake up function
>> on these new laptops in a generic way? Thanks
>
> What about echoing "enabled" to the keyboard's power/wakeup file in sysfs?
>

'echo enabled > /sys/devices/platform/i8042/serio0/power/wakeup' can get the
keyboard wake up the system as expected. We considered to work out a DMI
based quirk for this. But based on the information that EC would not signal SCI
event for WiskyLake models, we'd like to know if there's any generic solution?
Maybe a 'udev' rule to identify WiskyLake NoteBook then enable the keyboard
wake up?

Chris
