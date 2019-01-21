Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED50C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DEE20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfAUHZV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:25:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55309 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfAUHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:25:14 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1glQB1-0005ka-FJ
        for linux-kernel@vger.kernel.org; Mon, 21 Jan 2019 03:23:07 +0000
Received: by mail-pf1-f197.google.com with SMTP id 74so14981587pfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 19:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hNsAa6wv+dSNeG8IKATINmSLaxs9oG/WprRcuUr87aM=;
        b=nfJFo+baUDBFT1RohC2OUyHkWTm0HJU2rb0jSG7soW9LpikC60G2Xo8UBH20FnCNuP
         Opx7D5bdKhDzN1U8vkd4b8gMT7+0gkK3duOOjzXrupuRtFDrR9QMYUsw66ID31JEezBb
         ND25PmXDwGO9zc3mxwqw/wydaGmiSDaPCq6znYEgYu0HyIH+X4ae/HwOBtmHkqxGokfi
         nMawXyLELG843fScnSo51lgKG9PqEYECwdihpjESF5kGSkgjCZrpqND1VLBTvPq4Cbsk
         EIVLfqnJpvy341gRrledMEPjcmQRqEr/7opkyNy8a3mt0fHnE0CWWPEwlTplYkWs543Z
         UB8g==
X-Gm-Message-State: AJcUukfDSUZVStOIriKGH6q/UTqqCuzcfa3gtH7ZcR6cGdk1QtuoTf2Z
        aL+0cG9Uoo5B/xuc8kj3gollX7DIV0TkOvZ07pGaXoBO6oiS4wUiTl1IrzAHVAnNWYRPRhYXMfU
        IKkzB3KkJN3+pwVxstPH8A6IvIjDNfFHvO0cN/swBtA==
X-Received: by 2002:a62:1542:: with SMTP id 63mr28395797pfv.230.1548040985238;
        Sun, 20 Jan 2019 19:23:05 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5gphZGliDZdFrQd86EYN51sJbMBgipnSQkWFjI4xwKRG03Dbewr3Fu0e0WXk9CTMzsPicTxA==
X-Received: by 2002:a62:1542:: with SMTP id 63mr28395778pfv.230.1548040984872;
        Sun, 20 Jan 2019 19:23:04 -0800 (PST)
Received: from 2001-b011-380f-13aa-3031-6e36-b157-234b.dynamic-ip6.hinet.net (2001-b011-380f-13aa-3031-6e36-b157-234b.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:3031:6e36:b157:234b])
        by smtp.gmail.com with ESMTPSA id h8sm12639097pgv.27.2019.01.20.19.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 19:23:04 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJ+OQAsJkJj2YRGOE=8NcXhS=XWwdfGSaLjY9Bdvcfn7BQ@mail.gmail.com>
Date:   Mon, 21 Jan 2019 11:23:01 +0800
Cc:     Hans de Goede <hdegoede@redhat.com>, anisse@astier.eu,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0FFF8A37-B386-46A6-B790-403288E91EB4@canonical.com>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
 <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
 <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com>
 <CAO-hwJLHm8b6X9kX1myz7xx1992VW2tVjdn6xw2n1MVX2dn0=g@mail.gmail.com>
 <1897F291-4EB4-4E4B-87AA-3C16EF321340@canonical.com>
 <CAO-hwJ+OQAsJkJj2YRGOE=8NcXhS=XWwdfGSaLjY9Bdvcfn7BQ@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2019, at 20:35, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Thu, Jan 17, 2019 at 12:41 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> 
>> 
>>> On Jan 17, 2019, at 16:06, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>>> 
>>> On Thu, Jan 17, 2019 at 6:02 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>> [snipped]
>>>> Goodix says the firmware needs at least 60ms to fully respond ON and
>>>> SLEEP command.
>>> 
>>> I was about to say that this is not conformant to the specification.
>>> But looking at 7.2.8 SET_POWER of
>>> https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)
>>> 
>>> They say:
>>> "The DEVICE must ensure that it transitions to the HOST specified
>>> Power State in under 1 second. "
>>> But in the RESPONSE paragraph: "The DEVICE shall not respond back
>>> after receiving the command. The DEVICE is mandated to enter that
>>> power state imminently."
>>> 
>>> My interpretation was always that the device has to be in a ready
>>> state for new commands "immediately".
>>> However, the first sentence may suggest that the driver would block
>>> any command to the device before the 1 second timestamp.
>>> 
>>>> 
>>>> I’ll see if an 200ms autosuspend can solve all Goodix, LG and Raydium
>>>> touchpanels.
>>> 
>>> We already have a I2C_HID_QUIRK_DELAY_AFTER_SLEEP quirk that delay
>>> operations after sleep by 20ms. Maybe we can keep the runtime PM but
>>> use the same timers to not confuse the hardware.
>> 
>> Yes, but wouldn’t use pm_*_autosuspend() helpers can both solve the issue
>> and make the code more cleaner?
> 
> You are probably correct :)
> 
> I am not too familiar with the details of the runtime PM API, but if
> you can make this a barrier to prevent the host to call too many
> suspends/resumes in a row, that would be nice.
> And we might be able to ditch I2C_HID_QUIRK_DELAY_AFTER_SLEEP and
> I2C_HID_QUIRK_NO_RUNTIME_PM.

Ok, using autosuspend helpers doesn’t really solve the issue.

Although it can cover the case like fast ON/SLEEP triggered by
quick transition of display manager -> desktop session, but once
it gets runtime suspended, we can never sure when it’ll get 
runtime resumed again. So a mleep() between each powering
commands is still needed.

So I think we should stick to I2C_HID_QUIRK_NO_RUNTIME_PM
for now.

Kai-Heng

> 
> Adding the involved people in the thread.
> 
> Cheers,
> Benjamin

