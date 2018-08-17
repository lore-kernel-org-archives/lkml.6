Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6012FC04AB9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DBB208FC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="vqP4e5Kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DBB208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbeHQFbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 01:31:16 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34697 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeHQFbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 01:31:15 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so11650671ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 19:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3xAZxOAFo0UqRNdimb9YklHhNzn+2NYfBiJYDQ1hRx4=;
        b=vqP4e5KvaNUOU94z/RBc+WZEBo6E+3qpxy4SbPby8jXnVx23tofNyd78b43W+zJw0w
         1hSSuFLPPxnfYiiZq880y6MQ4aOLAEru6Jc9pzDgtbwMuP8VMnI4Tto3GbTzqVgaL4BO
         fR2cAHrV/Ak5YqhTVFCaR5l/9t27HI1XiJ0SG/czn/bbVcFvhpFrHvnYfL0CDOu9NkPt
         KZeMLxXpJd5Ivd6X6ITge1B/tZRffAVOBGOiVvdkvwEZA+WWtJNloT+WvUcGmsGIOmqY
         /QABrg4H43OrxREXvc8ZfGRwbe1B4MhQlZiwZtzjMM3haTQDGWpupOaAjoXadOFWaEoD
         /U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3xAZxOAFo0UqRNdimb9YklHhNzn+2NYfBiJYDQ1hRx4=;
        b=ejFubGQpGHGuWnz2SSn0BQv3jvzeSCOuYuVtaGhqS9QCM4FVZlCITPoe+MKfQXkAAt
         yc/sToa92ptVIwNuQt+O91tX4nTtLGTSpjxbmxuJKCrzusCT+wEOq2tgW7Ff5eWS3Svt
         SjFnQ/r4Jtv+IGACGz32G5bD+5LozvRguUG8akkSj7FqHWULomNBnlBYpeESdC+ebRcy
         HNOT3vhrgAclATFVxYjYqmIdyTcf9MOfzWgifVem7fD695QtrB+J+H7tv0pWwD5cFTxN
         SZzyWfkcH3V0Si0mvwbQjxZQDhFuAo8LB9zHb7xfe4owpSXuzeiMFmC6s+OWsA1aDGK0
         uFTg==
X-Gm-Message-State: AOUpUlEMeib+CHZm98wltXBOUgW1pQn0lfptP2kzQ0mEL667fhNI+Jk4
        4+sM31OxWupdWNGZ66W35jnndvFpoA01HW11bD5Qmw==
X-Google-Smtp-Source: AA+uWPyTrUtLGypE4iL07Mnk7J/hqaGi4D8L5mm8LE7f8XgPjsQFvwRW9Cmz510gDqYkH9o+o8nXmlmJaLEwXCD1B0Q=
X-Received: by 2002:aca:5754:: with SMTP id l81-v6mr650654oib.100.1534472985088;
 Thu, 16 Aug 2018 19:29:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3e18:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 19:29:44
 -0700 (PDT)
In-Reply-To: <1631276.bMiRmflJ7r@aspire.rjw.lan>
References: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
 <73029405.6ZXyByzer1@aspire.rjw.lan> <CAB4CAwcXg2ROwz17rZHzMpTEDYYfD1nteNgX=HE8EkOmyK3wag@mail.gmail.com>
 <1631276.bMiRmflJ7r@aspire.rjw.lan>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 17 Aug 2018 10:29:44 +0800
Message-ID: <CAD8Lp45F1aDB64_oPg8jqiG3HmM=efQoDGdioX4f365NXoummQ@mail.gmail.com>
Subject: Re: Built in PS2 keyboard in new ASUS/acer laptops can not wake up
 system after s2idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Chris Chiu <chiu@endlessm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> 'echo enabled > /sys/devices/platform/i8042/serio0/power/wakeup' can get the
>> keyboard wake up the system as expected. We considered to work out a DMI
>> based quirk for this. But based on the information that EC would not signal SCI
>> event for WiskyLake models, we'd like to know if there's any generic solution?
>> Maybe a 'udev' rule to identify WiskyLake NoteBook then enable the keyboard
>> wake up?
>
> A udev rule sounds like a good idea to me.

What would the udev rule look like though?

Match for Intel CPU generation (WhiskyLake) and laptop chassis type
and then enable i8042 wakeups? While that seems like the most accurate
reflection of the situation which we are seeing across multiple
vendors, it doesn't feel right and seems unlikely to be accepted by
systemd upstream.

In previous designs, pressing a key while the system was in S3 sleep
would cause a SCI interrupt due to the firing of the EC GPE, which
effectively meant that keyboard wakeups were on by default and could
not be disabled. Also USB keyboards have wakeups on by default (see
usbhid_start()). Just these new platforms have this
unfortunate/accidental behaviour change...

Would it make sense to turn i8042 wakeups on by default on the kernel
side? I don't know if any particular conditions are applied, but that
would appear to be the default Win10 behaviour here.

Daniel
