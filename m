Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4AEC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284F421526
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loZ327Yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284F421526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeHOMgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:36:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41101 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbeHOMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:36:36 -0400
Received: by mail-qt0-f195.google.com with SMTP id e19-v6so527351qtp.8;
        Wed, 15 Aug 2018 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xiA3IXeFmIVAiE8nMIICXJPLohZSS5xcXbI8b0Ce98E=;
        b=loZ327Yog5lf3dPoo58IiL124CuLFYBam6DF8Yrz3QPMc23H8Bmp7Go4hrIgeCbwpT
         UA+mERd0l19wbgOH0rndnLERYXzHHYvr7b2P7K7QHIv65dV52rGkKRA7LdV7Ze3brBqW
         R8dEWGEFRnC3vA2lcr8pS0tv+qKuIDHbWJxfBb0Hw9eaMXc+0A165FmhpeREpTzmuVqT
         GmafHrZk5i5RiQBdxXNvME3WZgbpmgGEv9iI8kKY8hQIa3IpOAVQg3Ika84ILyd+YAuM
         8P2x8VVsYB++wXDOCbedV8onBhBuddm7+hT7/PXLV2CFurIALd49MJxYL7ADD/ek4Eox
         pZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xiA3IXeFmIVAiE8nMIICXJPLohZSS5xcXbI8b0Ce98E=;
        b=rsVyfnCNVrEiWhCKqr1RMHhNl2T3F6y3jjAaA35m/c+3Is7oNoyqJXKIXqTMxsKS6J
         yBSfpNUS4kUnkkhmJLq7bH2KGbCQZ+iA6piR8r3RWXb077pM+kca+s12hbGlRFQbikfU
         vwnzMB4iohWmnGekY62uZ9tWPwRGj6JrMeKJNh5/HqTQOtQWryj2bZotKrymj+UQsCTq
         edRwbhfx2y4Yb8YMjjwbn+oqNp+Q5qCB5xi1ZHToLPlGgGgmn5TIQ1/bKxVj6/xEFP7E
         i7Ffm2gRYgxGK2OAQODr2u4dw7C4ua+j3HoaVy2/qoJtSVBStKnGOE8enF1C2Xzqo2Pi
         PSzQ==
X-Gm-Message-State: AOUpUlEVuxpj05qCd0shacocZLHIWT17xgM7iKY8SxEp0ZIksMYSkjYi
        cAjoeB75hJKKzeGPpkEZU28lKRyqPUyZgTi9IvqiGgJNfvE=
X-Google-Smtp-Source: AA+uWPxMFPqWLhj1PV4I00HyQ8oiDtFyvec0b69pt3gPCJUTlUviwoctF3y0AlUIPeSmw+QlVpI7exip5yyHIxHNNVk=
X-Received: by 2002:ac8:4312:: with SMTP id z18-v6mr24674507qtm.295.1534326307981;
 Wed, 15 Aug 2018 02:45:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 02:45:07
 -0700 (PDT)
In-Reply-To: <CAB4CAwedViX=U0DJNsZeUhJinQ1UBQ3KVTuhRJO7ni-xvqbJ3Q@mail.gmail.com>
References: <20180620144645.2084-1-chiu@endlessm.com> <CAB4CAwdCixoGj9t=1Nvcc52kAjmcMWobKt11pRa0vNyLdeA_rg@mail.gmail.com>
 <CAHp75VcvaJVuM=TL2AJaC=y5B9GRVbXO0DczfHWs+i03OJRXcw@mail.gmail.com> <CAB4CAwedViX=U0DJNsZeUhJinQ1UBQ3KVTuhRJO7ni-xvqbJ3Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Aug 2018 12:45:07 +0300
Message-ID: <CAHp75Veu9+vQPjq+1uWnaocobcHUBpkHKx6OfKW3-E_UeVtKfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Chris Chiu <chiu@endlessm.com>
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

On Wed, Aug 15, 2018 at 12:34 PM, Chris Chiu <chiu@endlessm.com> wrote:
> On Mon, Jul 2, 2018 at 8:10 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Jun 27, 2018 at 1:27 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>> On Wed, Jun 20, 2018 at 10:46 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>>> Make asus-wmi notify on hotkey kbd brightness changes, listen for
>>>> brightness events and update the brightness directly in the driver.
>>>> Create new do_kbd_led_set function for in-driver update, and leave
>>>> kbd_led_set for original led_classdev call path.
>>>>
>>>> Update the brightness by led_classdev_notify_brightness_hw_changed.
>>>> This will allow userspace to monitor (poll) for brightness changes
>>>> on the LED without reporting via input keymapping.
>>
>> LGTM, I'm about to push it to my review and testing queue, so, we will
>> have 1 day or so time to gather objections if any.
>> Thanks!
>>
>
> Gentle ping. How's the review so far? Maybe need more time for more info?

Sorry, I thought we have no objections and I pushed it to our for-next
quite time ago [1].
Should I do something differently?

[1]: http://git.infradead.org/linux-platform-drivers-x86.git/commitdiff/dbb3d78f61badeadc7448f9d88a070a76612860f

-- 
With Best Regards,
Andy Shevchenko
