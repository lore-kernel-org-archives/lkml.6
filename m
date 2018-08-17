Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD98E21868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD98E21868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeHQLGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:06:55 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40291 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeHQLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:06:55 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so12634610oie.7;
        Fri, 17 Aug 2018 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25AqdTYalrHE2xnyefn4ffOVeaLDI4fuTF9VaaQmP+w=;
        b=n6Q8ttbnz/vk5f/ZI0kmk603RwhTMMjdGzAVyk8yGuCHfrqrHdSuglmBcAIDTVA1Zp
         +x1ur+lwi/E5Rve56kWgk+ThtXEfOaUCXpRTPqVUidiIK35h6Kt0MUp9K+46GJkNo+tz
         tzjbMptJKSR9EeOZn87JQ5CHJDy1tz0AYcZbbeE5xUajl+0vJOhfjxgY1+Bd9zNsjOTp
         1GzVWxnB4XdmXtuu7AlePgQ/6thGV0Cd+/WSCGEF3NLPgbdzdJ3Lj/n+brr0YU89dtDh
         156dieFnWisu63Ay0UpwgXEbNPh/sdkHYMfrPIvQR1Su7FBFnyuguu6h1pcPdVO12wVt
         4X+g==
X-Gm-Message-State: AOUpUlGOpxinZKomFJkMbHRlqlOAxLmGYPrP2N6BoJNxB5ODw9qdH3Sp
        flkyAu4PUFljghpHVu51aUK+YGFt7Cxl75ho5DY=
X-Google-Smtp-Source: AA+uWPwrC5RjdZKGkfBmVONDknXOiA2jf5ZjFUeDkxX5XkDoN8f5eAeva39SW1sjM9XG3zwUWXNAiMjei2dB6uvPGx8=
X-Received: by 2002:aca:1719:: with SMTP id j25-v6mr1520435oii.138.1534493070922;
 Fri, 17 Aug 2018 01:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
 <73029405.6ZXyByzer1@aspire.rjw.lan> <CAB4CAwcXg2ROwz17rZHzMpTEDYYfD1nteNgX=HE8EkOmyK3wag@mail.gmail.com>
 <1631276.bMiRmflJ7r@aspire.rjw.lan> <CAD8Lp45F1aDB64_oPg8jqiG3HmM=efQoDGdioX4f365NXoummQ@mail.gmail.com>
In-Reply-To: <CAD8Lp45F1aDB64_oPg8jqiG3HmM=efQoDGdioX4f365NXoummQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Aug 2018 10:04:19 +0200
Message-ID: <CAJZ5v0jWZYJ9V8xJ9vy+VDC2ysbwU=hRZC6G3VJSGDsWaj_xpw@mail.gmail.com>
Subject: Re: Built in PS2 keyboard in new ASUS/acer laptops can not wake up
 system after s2idle
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chris Chiu <chiu@endlessm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 4:29 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Mon, Aug 6, 2018 at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> 'echo enabled > /sys/devices/platform/i8042/serio0/power/wakeup' can get the
> >> keyboard wake up the system as expected. We considered to work out a DMI
> >> based quirk for this. But based on the information that EC would not signal SCI
> >> event for WiskyLake models, we'd like to know if there's any generic solution?
> >> Maybe a 'udev' rule to identify WiskyLake NoteBook then enable the keyboard
> >> wake up?
> >
> > A udev rule sounds like a good idea to me.
>
> What would the udev rule look like though?
>
> Match for Intel CPU generation (WhiskyLake) and laptop chassis type
> and then enable i8042 wakeups? While that seems like the most accurate
> reflection of the situation which we are seeing across multiple
> vendors, it doesn't feel right and seems unlikely to be accepted by
> systemd upstream.
>
> In previous designs, pressing a key while the system was in S3 sleep
> would cause a SCI interrupt due to the firing of the EC GPE, which
> effectively meant that keyboard wakeups were on by default and could
> not be disabled. Also USB keyboards have wakeups on by default (see
> usbhid_start()). Just these new platforms have this
> unfortunate/accidental behaviour change...
>
> Would it make sense to turn i8042 wakeups on by default on the kernel
> side? I don't know if any particular conditions are applied, but that
> would appear to be the default Win10 behaviour here.

Yes, it would, but that might prevent some systems from suspending at
all in theory if there are keyboard interrupts on them occurring
during system-wide suspend, for example.

Otherwise, it would just be a matter of calling device_wakeup_enable()
at init time for the keyboard port (as long as you know which one of
them is the keyboard).
