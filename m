Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69458C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119B02159F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Om0OeNiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119B02159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeHOMko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:40:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40824 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbeHOMko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:40:44 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so506905iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RibCa2SIj68p9R+yZaU2IHrj7wYIcVgDth1R9MpKxEg=;
        b=Om0OeNiRjP/sU2Q44WOBL63Ar12VJsNzm6+xqcOWFKVX5QmXn5pO9ZSXj1LRaJt+u5
         /IAlcNdbAGmBxu7VDV6rS0sYWSqQX+AbiOLf5ccVNaTKOpVgdFbciLAyw5DpGgxJbc9P
         iQD46chIFALfoBDiVderpM1QalbucJiHqNleeiMR2Z6DPMCE+BpLmLsh4Fi7R0Tm1Vg3
         5NQffwV8k7n1+LOa0uBaMRbByCH1s9Ep4wqPDaz6dDw7n/cKEAnTr9wSYDhx013uV/2Y
         gTQYCHFYtppBIXnOJPxQYJ6FTk4g55Rge0fMMSOoyQacFJ7GdFjnFchy3jZnM54A6fEn
         Huzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RibCa2SIj68p9R+yZaU2IHrj7wYIcVgDth1R9MpKxEg=;
        b=Lmy7TYoiRv7sk+kRJGxOWEUeLTgYSgNL/wRnB7uP+xIjXf8Kc+2qvQOaQf86wDqlb9
         m5navaZv5yqS7ktwXiWqkVBzg9LT2BfQrf01OaoJ6ccKiZf1mzBKrDBVumCFIDaknJCn
         +McBbSQf5uBJmC8zOYdG8rHRioWwX4yHxo+ZsrYxn5mGpySlrbEDnugKNedwCKEhfocd
         6TCHJj0scJigAEsSJfmGlpvpI1Ua149B1irnzRcRxl3AbUt5MyOxTfVCJw2rQcW86e84
         VgvirDYNytlDii7W9g2l5Gsyqnl38NAI82/qd36Vs8MYMOnozuNOzwRxgzzW78MwdYBw
         t/Gg==
X-Gm-Message-State: AOUpUlEPuGlp5nNn+VfGzbAzGJD/KqQDp+VYoJmyCQRzNBfESCPJVtpo
        kr2DVV01rZGwjUtdaiucLTFI4pJ60dmKJ2yYg+gafl60QhQ=
X-Google-Smtp-Source: AA+uWPwNWFCouGOENnnux+MBBqArWqP0eOStOxvuBe1+k0+3oxzTJ6gjf7ZLkEYLpwtNvry9fc54TFtjgwXZaWXMn2s=
X-Received: by 2002:a6b:b791:: with SMTP id h139-v6mr21124983iof.274.1534326555823;
 Wed, 15 Aug 2018 02:49:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8704:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 02:49:15
 -0700 (PDT)
In-Reply-To: <CAHp75Veu9+vQPjq+1uWnaocobcHUBpkHKx6OfKW3-E_UeVtKfA@mail.gmail.com>
References: <20180620144645.2084-1-chiu@endlessm.com> <CAB4CAwdCixoGj9t=1Nvcc52kAjmcMWobKt11pRa0vNyLdeA_rg@mail.gmail.com>
 <CAHp75VcvaJVuM=TL2AJaC=y5B9GRVbXO0DczfHWs+i03OJRXcw@mail.gmail.com>
 <CAB4CAwedViX=U0DJNsZeUhJinQ1UBQ3KVTuhRJO7ni-xvqbJ3Q@mail.gmail.com> <CAHp75Veu9+vQPjq+1uWnaocobcHUBpkHKx6OfKW3-E_UeVtKfA@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 15 Aug 2018 17:49:15 +0800
Message-ID: <CAB4CAwdZYAKEDeboMFVpp9fnKPbdNZWP=VqroOOPmvcYwinX3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 5:45 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Aug 15, 2018 at 12:34 PM, Chris Chiu <chiu@endlessm.com> wrote:
>> On Mon, Jul 2, 2018 at 8:10 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Wed, Jun 27, 2018 at 1:27 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>>> On Wed, Jun 20, 2018 at 10:46 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>>>> Make asus-wmi notify on hotkey kbd brightness changes, listen for
>>>>> brightness events and update the brightness directly in the driver.
>>>>> Create new do_kbd_led_set function for in-driver update, and leave
>>>>> kbd_led_set for original led_classdev call path.
>>>>>
>>>>> Update the brightness by led_classdev_notify_brightness_hw_changed.
>>>>> This will allow userspace to monitor (poll) for brightness changes
>>>>> on the LED without reporting via input keymapping.
>>>
>>> LGTM, I'm about to push it to my review and testing queue, so, we will
>>> have 1 day or so time to gather objections if any.
>>> Thanks!
>>>
>>
>> Gentle ping. How's the review so far? Maybe need more time for more info?
>
> Sorry, I thought we have no objections and I pushed it to our for-next
> quite time ago [1].
> Should I do something differently?
>
> [1]: http://git.infradead.org/linux-platform-drivers-x86.git/commitdiff/dbb3d78f61badeadc7448f9d88a070a76612860f
>
> --
> With Best Regards,
> Andy Shevchenko

It's good to know. Thank you.

Chris
