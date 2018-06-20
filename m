Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D775CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5C020652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5C020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbeFTJKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:10:42 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38707 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbeFTIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:36:31 -0400
Received: by mail-qk0-f193.google.com with SMTP id y4-v6so1393133qka.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ea2Saduz3/i0CuckPbHDlxZq1C2OYPZ/DtEMH8TMsZk=;
        b=gaepPJl/sP+CYxspt1e1ap5PxcjiKUqfrCB7gB8QU3E2C38nENiYzPSfdAKtgPvFZ5
         7ztiZGU/Z7JXnD2sTnMZUb+jYUnF7BSva3RdG/1gDMwGA26kznljEOzQ1zMQWmq1wuob
         izZmbF2ax/VF2wQuqOCY/Z70bYv7nicckvYFnMYhtj8uq7H803Xi+SY5FGtq68WFf6fD
         /d2IviR5jywxXR5zF9WJpXOzHwShJlcTVM4A+U+iYElEGU2QJboF3vrx8Je/YJ2xru/v
         bO99IiOVH4OOD0sTGBd6S70LCY8EjDHN/iZmgj/rb1eGc2+jsbXsm8BwfQiOvbZxkhKq
         W6ZA==
X-Gm-Message-State: APt69E2D8z8Cj67jBwPew+tRLkcsUKfbaeUTw6zE13o/ONOIIemy8CN4
        V7pLM7OPiVdDmkBn8aUXb8RyArz4KmZ/KXu55XjfeA==
X-Google-Smtp-Source: ADUXVKL7WQk+qHWTmg/lI3XSZNxfSv0W07JubcvN0HTAJWF4cEF4ewvltsRnHcse+iqDqjKGpisYI4AwkHv6K2kyX8A=
X-Received: by 2002:a37:9d13:: with SMTP id g19-v6mr16346972qke.217.1529480148396;
 Wed, 20 Jun 2018 00:35:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2bc7:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 00:35:47
 -0700 (PDT)
In-Reply-To: <nycvar.YFH.7.76.1806200913420.6203@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1806191356280.6203@cbobk.fhfr.pm>
 <CA+55aFx1o8+ZTAqVQNH7Wq8tm90XYTUEx5By2wWo3KJDR3g2MQ@mail.gmail.com>
 <nycvar.YFH.7.76.1806200611290.6203@cbobk.fhfr.pm> <b952c1f6-5866-d25e-32c2-ac0ded1812e2@redhat.com>
 <CA+55aFwCt9WZoBHEbsR65h=BRJ-GhqwWgU87wd2o4A_TzxQW2Q@mail.gmail.com> <nycvar.YFH.7.76.1806200913420.6203@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 20 Jun 2018 09:35:47 +0200
Message-ID: <CAO-hwJLkOx-12HAG3YEEFjOsiQScSgetVoF6gi+KSCpXyGXeGw@mail.gmail.com>
Subject: Re: [GIT PULL] HID fixes
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Julian Sax <jsbc@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 9:15 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 20 Jun 2018, Linus Torvalds wrote:
>
>> But what is the *source* of this binary crud?
>>
>> Because no way in hell do we take binary crud from random places, and
>> then add it to the kernel.
>>
>> NOT EVEN IF IT WENT THROUGH SOME "hidrd-convert" PHASE!
>>
>> And yes, now that I google for that hidrd-convert pattern, I see that
>> we already have other broken chunks like this.
>>
>> Not ok. At least some of them seem to mention where the data comes from,
>> eg
>>
>>    "This is the original report descriptor as reported by lsusb -vd 046d:c294"
>>
>> but this one has no such information.
>>
>> So guys, you need to think about where things come from, and document
>> how some random garbage came to be. Not just add it to the kernel.
>
> Well, at least for the ones I've done myself in the past, those are
> hand-written from scratch.
>
> It's not really a firmware / code, it's just a description of the data in
> the reports, so that HID parser can interpret it properly.
>

In case it matters, I have an open-source python script that parses
those blobs and output the same level of human description here:
https://gitlab.freedesktop.org/libevdev/hid-tools/ (the script
parse_rdesc.py).

As Jiri said, this is all standardized and documented in the HID
protocol[1], and this 'just' describes the data that will be sent over
the transport layer.

In this particular case, the descriptors were extracted from the
Windows driver, not by looking at the binaries, but by looking at the
data that was transmitted from the "device". The thing is the data is
not stored on the device chip itself but on a third party driver from
the vendor. However, from a windows point of view, the third party
driver intercepts the I2C commands and supply the information when
needed. So it is as if the device answered. Blame the vendor here that
decided to reduce the costs and save a few KB on the chip :/

Cheers,
Benjamin

[1] http://www.usb.org/developers/hidpage/HID1_11.pdf
