Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8826720835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8826720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeJKQmz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:42:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43305 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeJKQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:42:54 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gAX53-0003HD-DK
        for linux-kernel@vger.kernel.org; Thu, 11 Oct 2018 09:16:29 +0000
Received: by mail-pf1-f200.google.com with SMTP id k1-v6so7226718pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 02:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4bHisaanRM1rgpxhqDAaO+0rU7SKkZGiEGEu9zges4k=;
        b=QJO0nHpqT1243nU6x78v86i6dClf/P++HxbVvhrNFDDoBTLTD4y84KeWjMJLGMVOc6
         YZtgL+ADTeTys84DPmxSJmjYL+4ttQ2kFjF6NO7tw8jyofxT09ulLXLQ42ypXRzIZmDd
         fjDol50Mktg3zHfd0XTOAqofyrasgmmrIxSte7sp2INagdJ+he9AV27KhYPz/CBwaliI
         q0yjzIPdsDuBUla+BHwwZUO9J719tcuMHBL3NeUVVQqLG5HDXthOoiaahCLOQQftq9m3
         lyocCtTiG6KmoSiUbSf+e1jygFWfy+luEu30UjPt7bYciIPchY1Ns37MA4ibprymjqT8
         5oHA==
X-Gm-Message-State: ABuFfog9eB2Qv9Lh08qqx3rMWZBDvEDyW60L/1mY7YHKqjFAmx/U00MF
        HFaU3F8pi4u+kFEKa99VAJRoUQq+uftNA3hzCiuQue3ZYJRlJ0l0+JAsPaQHAxCtAItMuGVAex+
        8hDapenkWiUbStRze3lyjRE6AoAKm3canYArkl0s05g==
X-Received: by 2002:a62:1b45:: with SMTP id b66-v6mr765510pfb.94.1539249388156;
        Thu, 11 Oct 2018 02:16:28 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62kvVm4IgMT1jVC48QOQHghRi+/h0iLwiWCHj3ZAw2vOyZ5UAbxPRTcPipgOwW5AgFsWx12Aw==
X-Received: by 2002:a62:1b45:: with SMTP id b66-v6mr765483pfb.94.1539249387716;
        Thu, 11 Oct 2018 02:16:27 -0700 (PDT)
Received: from 2001-b011-380f-17e9-b9dd-55f4-723a-525a.dynamic-ip6.hinet.net (2001-b011-380f-17e9-b9dd-55f4-723a-525a.dynamic-ip6.hinet.net. [2001:b011:380f:17e9:b9dd:55f4:723a:525a])
        by smtp.gmail.com with ESMTPSA id q24-v6sm24600428pff.83.2018.10.11.02.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 02:16:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] HID: usbhid: Add quirk for Redragon/Dragonrise Seymur 2
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJJkB=u44_kJNjOSL=8pgnXDkvda12_g8p39DeZ0JybqWQ@mail.gmail.com>
Date:   Thu, 11 Oct 2018 17:16:24 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3941E373-A385-4080-ADCC-BAEBC862809A@canonical.com>
References: <20181011075633.18868-1-kai.heng.feng@canonical.com>
 <CAO-hwJJkB=u44_kJNjOSL=8pgnXDkvda12_g8p39DeZ0JybqWQ@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

> On Oct 11, 2018, at 16:34, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> Hi Kai-Heng,
> 
> On Thu, Oct 11, 2018 at 9:56 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> Redragon Seymur 2 stops working since commit 190d7f02ce8e ("HID: input:
>> do not increment usages when a duplicate is found").
>> 
>> Use quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE suggested by the commit
>> can solve the issue.
> 
> Before we take the hammer, could you share the report descriptors (or
> I'll request those in the kernel BZ)?

Feel free to do so!

I send the patch because seems like the user doesn’t know how to upstream patches.

Kai-Heng

> In the kernel BZ, it's clear that the report descriptor is wrong at
> assigning axes, but I'd like to double check if applying the quirk
> will be OK and will not pollute other axes.
> 
> Cheers,
> Benjamin
> 
>> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200995
>> BugLink: https://bugs.launchpad.net/bugs/1793846
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/hid/hid-ids.h    | 1 +
>> drivers/hid/hid-quirks.c | 1 +
>> 2 files changed, 2 insertions(+)
>> 
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index bc49909aba8e..0e0aa7f0e6fc 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -342,6 +342,7 @@
>> #define USB_DEVICE_ID_DMI_ENC          0x5fab
>> 
>> #define USB_VENDOR_ID_DRAGONRISE               0x0079
>> +#define USB_DEVICE_ID_REDRAGON_SEYMUR2         0x0006
>> #define USB_DEVICE_ID_DRAGONRISE_WIIU          0x1800
>> #define USB_DEVICE_ID_DRAGONRISE_PS3           0x1801
>> #define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR    0x1803
>> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>> index 249d49b6b16c..52c3b01917e7 100644
>> --- a/drivers/hid/hid-quirks.c
>> +++ b/drivers/hid/hid-quirks.c
>> @@ -70,6 +70,7 @@ static const struct hid_device_id hid_quirks[] = {
>>        { HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
>>        { HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
>>        { HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
>> +       { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_REDRAGON_SEYMUR2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
>>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR), HID_QUIRK_MULTI_INPUT },
>>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1), HID_QUIRK_MULTI_INPUT },
>>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3), HID_QUIRK_MULTI_INPUT },
>> --
>> 2.17.1
>> 

