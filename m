Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D3EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B952083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="DvZkai51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B952083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965060AbeFSHJO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:09:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51978 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755616AbeFSHJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:09:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so18005203wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 00:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=APt0PvZu7ZmlxqqAw9tyeWK+TuDbQ94fn8j2wR4tetE=;
        b=DvZkai51m26blz4NBrllOiBNfSpxM0hcvlkOJO+Y8ShjciGfTLLmeZGjm3t7i9uJVv
         ch0RHdYE4wSvbQKQ9KdcmzQurk4AQ9Ybcd/wdQjj1RFPGtJ8QQdwUmQtsNjNuz/pLLsb
         HIo+T07v2j5rFj0E112zA/+8hInN3J5t3oNEnPZmKfe6MsTtBdw7k+eZPTNbQ/HOIoYI
         g3rb7F/oOHtVnj2Cxs3t/zmlXGviEN2wE52bxOV6XdHDq2gxfAIphEZa8ilpJdKvol1C
         223wqVJHl3AszzNbLFevj10CXMyzXM2CUzchUASZJYu463sHw42Zkz3k+AtRvhQDonLQ
         PPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=APt0PvZu7ZmlxqqAw9tyeWK+TuDbQ94fn8j2wR4tetE=;
        b=Je48YMBHWr5z/f5F41vUgVnZoZsx4NXzZLrqeq3yUidDmWNPaYyKi4aj0SEpF+wAXZ
         AbQumfHtSXaUsxQkT0OE5clO2ihpZPfS73R81IuHWWmfeKVR+nnFIdfWFhDbi5s8aJ0N
         CTEAVc+2eljc8Fch06b0PLrOWxkyCBwc1UCvUv4ikO6zFyfeyJWEGdaNwJJa0TuyE1tY
         bxcVSTJoGbFBTtFI9E7QKi4rvoUgROep1SuVyJGD1LrI+zcK+yHY5wKbtRI1pXaoO+sP
         AufkZY+Qp94NOdNlOPm0uYx5Ugtksl3CPCyejEesXP73/aubVHUm7uQT0T/UnCj7ZyT2
         9AwQ==
X-Gm-Message-State: APt69E01z0b+yOe9XqzOE6j0FZ4AOfW+4p1mdcP4OHnInMoR8v7Aectk
        bT/8yImD4NAardgSA4DeVltDoeOiJamyrTZD+jyRoA==
X-Google-Smtp-Source: ADUXVKIoDd20u8a3zNqhjO8zENZYpeUxTPG7OGo1G51vTV+uFJ/lgvUyBJ2x5U4osHKOJ5Davf1rDnJjs4XISjibrOo=
X-Received: by 2002:a50:c8cd:: with SMTP id k13-v6mr13539372edh.47.1529392151301;
 Tue, 19 Jun 2018 00:09:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90d3:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 00:09:10
 -0700 (PDT)
In-Reply-To: <CAB4CAwdKJiuEiV1CtoyYTZTatRt73BQbRX5kyEtpqNj8STj5-w@mail.gmail.com>
References: <20180611071838.47945-1-chiu@endlessm.com> <CAHp75VdfUO9rS-=nn+Ffe8bMEbCO-0xe8QBVqsJAZVFTMYkNxg@mail.gmail.com>
 <CAB4CAwdKJiuEiV1CtoyYTZTatRt73BQbRX5kyEtpqNj8STj5-w@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 19 Jun 2018 15:09:10 +0800
Message-ID: <CAB4CAweu0z5XjH0hTB9t=RA37KSRLsLGSAAeJLupLNcyV6LVBg@mail.gmail.com>
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

On Thu, Jun 14, 2018 at 2:58 PM, Chris Chiu <chiu@endlessm.com> wrote:
> On Wed, Jun 13, 2018 at 8:49 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Jun 11, 2018 at 10:18 AM, Chris Chiu <chiu@endlessm.com> wrote:
>>> Make asus-wmi notify on hotkey kbd brightness changes, listen for
>>> brightness events and update the brightness directly in the driver.
>>
>>> For this purpose, bound check on brightness in kbd_led_set must be
>>> based on the same data type to prevent illegal value been set.
>>
>>> @@ -497,9 +498,9 @@ static void kbd_led_set(struct led_classdev *led_cdev,
>>>
>>>         asus = container_of(led_cdev, struct asus_wmi, kbd_led);
>>>
>>> -       if (value > asus->kbd_led.max_brightness)
>>> +       if ((int)value > (int)asus->kbd_led.max_brightness)
>>>                 value = asus->kbd_led.max_brightness;
>>> -       else if (value < 0)
>>> +       else if ((int)value < 0)
>>>                 value = 0;
>>
>> I didn't quite understand this part of the problem.
>> Does it exist in the current code? Can it be split to a separate change?
>>
>> Can we avoid those ugly castings?
>>
>
> I'd like to remove the ugly castings but there's a concern I may need some
> advices. I don't know whether if the bound check logic ever verified before.
> Maybe the value passed via sysfs is already correctly bounded?
>
> When the kbd_led_wk comes to -1, `if (value > asus->kbd_led.max_brightness)`
> returns true and `if (value < 0)` return false which confused me. It
> should relate
> to the 2nd argument type is enum led_brightness which I consider it as integer.
> The unexpected return value cause the KBD_BRTDWN cyclic, 3->2->0->-1
> (3 again in kbd_led_set)->2->1. After applying the casting on both operands
> `if ((int)value > (int)asus->kbd_led.max_brightness)`, the other
> unexpected false
> returned by `if (value < 0)` makes each KBD_BRTDOWN to be 3 -> 2 -> 1 -> 0 ->
> -1 -> -2 -> -3 ->..... That's what the ugly casting for. I used to
> tend to do boundary
> limit before calling kbd_led_set as follows
>
> kbd_led_set(&asus->kbd_led, MIN(asus->kbd_led_wk + 1,
> asus->kbd_led.max_brightness);
> and
> kbd_led_set(&asus->kbd_led, MAX(asus->kbd_led_wk - 1, 0));
>
> If so, the boundary limit logic would be totally redundant but I think
> it may be still
> useful to check the value passed from sysfs? Any suggestion which one would
> be better?
>
> Chris
>
>> --
>> With Best Regards,
>> Andy Shevchenko

Gentle ping.

Cheers.

Chris
