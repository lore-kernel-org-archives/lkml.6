Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BEA0BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D48B208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="rr65p/f0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D48B208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeFNG6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:58:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54286 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeFNG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:58:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so8554366wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xBMwJhu6BldoGoDpCKd46TdJwvpW/X8pGVB9bURSh78=;
        b=rr65p/f0hZ1baqmICBMAqIj3w6+l3fF6sazcn4a/j6FhEYvFfPNuQSDJnUG5ORZgHp
         a04dwpe8aYGqFgMh5IEknEoLbTn530KstLrq4hEEqzR+MlSpRte4ri99lFWZz/PiBusl
         joXg8ySCgr3PwdphshbOxDv7YWI3K4shy0xgYTsdvA5PFIUstu/ineQAOUTcGdejiwn8
         8Fab4EK9i7I1TX2GXUGO0qMFQasLUmEBOBbNbvS/i/wJwlxWObQx+FQSfnSvRanrkV5G
         rHtVMhbC+OcPC1N2O8YmZxX6tSUO25+0ErU2vOnAt7sIOfbCAv4PwuYBno48D1DmlzXs
         eaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xBMwJhu6BldoGoDpCKd46TdJwvpW/X8pGVB9bURSh78=;
        b=NIj2j6hHHvxjnbxEzih4iBreWuepJi8Asn5TLvPWMbKVRotoSAW5XsIhhBdue+XR/p
         JdofjjF84Mk3aWf0untC6LjarCea01EuMNSECUSYgSr7nEJ4jxdDOFuHtY8e+LPNymqp
         CC45gIWLUb5ffW3jj+n08E2XA1KCB6xZLv/l1Lazt/rGN0uDq2CdXUkyjq4jNirzXcLi
         4yAwtpkds4RoTNAOz+0B9PqnFAlHJjvvRFIMU/Ulklc2Gn7AB5ebIMxGYQ5HUvx3iVTh
         YsK2fMu4grxyOgAPxssVFIIOFJFhUwt53cmw5bu+pEjRwIn+Duj4Psls2Yxx90ycwIey
         jQ/g==
X-Gm-Message-State: APt69E3u3UNa6aRK3eJ/6k/BVhCu/4e44aAUauINpaHDek+T24oICuTn
        ObFsTC7gF7/aWn/b5p5qhDSX7vJxbxGQaqIiGIcpPw==
X-Google-Smtp-Source: ADUXVKKoVOt7O0H31L/1evpxQRaMWI/vaYE7dNRDI8H54wyba3/fhinlb2EAl6MwV9+/+2Yj1fWARZEz9HCHeoVIgwI=
X-Received: by 2002:aa7:d58d:: with SMTP id r13-v6mr1435456edq.176.1528959494548;
 Wed, 13 Jun 2018 23:58:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90d3:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 23:58:13
 -0700 (PDT)
In-Reply-To: <CAHp75VdfUO9rS-=nn+Ffe8bMEbCO-0xe8QBVqsJAZVFTMYkNxg@mail.gmail.com>
References: <20180611071838.47945-1-chiu@endlessm.com> <CAHp75VdfUO9rS-=nn+Ffe8bMEbCO-0xe8QBVqsJAZVFTMYkNxg@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 14 Jun 2018 14:58:13 +0800
Message-ID: <CAB4CAwdKJiuEiV1CtoyYTZTatRt73BQbRX5kyEtpqNj8STj5-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 8:49 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jun 11, 2018 at 10:18 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> Make asus-wmi notify on hotkey kbd brightness changes, listen for
>> brightness events and update the brightness directly in the driver.
>
>> For this purpose, bound check on brightness in kbd_led_set must be
>> based on the same data type to prevent illegal value been set.
>
>> @@ -497,9 +498,9 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>>
>>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>>
>> -       if (value > asus->kbd_led.max_brightness)
>> +       if ((int)value > (int)asus->kbd_led.max_brightness)
>>                 value = asus->kbd_led.max_brightness;
>> -       else if (value < 0)
>> +       else if ((int)value < 0)
>>                 value = 0;
>
> I didn't quite understand this part of the problem.
> Does it exist in the current code? Can it be split to a separate change?
>
> Can we avoid those ugly castings?
>

I'd like to remove the ugly castings but there's a concern I may need some
advices. I don't know whether if the bound check logic ever verified before.
Maybe the value passed via sysfs is already correctly bounded?

When the kbd_led_wk comes to -1, `if (value > asus->kbd_led.max_brightness)`
returns true and `if (value < 0)` return false which confused me. It
should relate
to the 2nd argument type is enum led_brightness which I consider it as integer.
The unexpected return value cause the KBD_BRTDWN cyclic, 3->2->0->-1
(3 again in kbd_led_set)->2->1. After applying the casting on both operands
`if ((int)value > (int)asus->kbd_led.max_brightness)`, the other
unexpected false
returned by `if (value < 0)` makes each KBD_BRTDOWN to be 3 -> 2 -> 1 -> 0 ->
-1 -> -2 -> -3 ->..... That's what the ugly casting for. I used to
tend to do boundary
limit before calling kbd_led_set as follows

kbd_led_set(&asus->kbd_led, MIN(asus->kbd_led_wk + 1,
asus->kbd_led.max_brightness);
and
kbd_led_set(&asus->kbd_led, MAX(asus->kbd_led_wk - 1, 0));

If so, the boundary limit logic would be totally redundant but I think
it may be still
useful to check the value passed from sysfs? Any suggestion which one would
be better?

Chris

> --
> With Best Regards,
> Andy Shevchenko
