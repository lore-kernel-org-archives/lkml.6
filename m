Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbeDQM4G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:56:06 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33109 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeDQM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:56:04 -0400
X-Google-Smtp-Source: AIpwx4/rQp3r7Fa03FtnyhHy8E7cs0LIcEuH+3nbmkzVN7BwwbDWEr9aK53vOw+GPgu+4uWRa3zZtPSfJJ7pCQYx4Y4=
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1804171410360.28129@cbobk.fhfr.pm>
References: <20171208142818.15156-1-benjamin.tissoires@redhat.com>
 <20171208142818.15156-3-benjamin.tissoires@redhat.com> <20171210222926.GB11027@jelly>
 <20180416235156.GE77055@dtor-ws> <nycvar.YFH.7.76.1804171410360.28129@cbobk.fhfr.pm>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 17 Apr 2018 14:56:03 +0200
Message-ID: <CAO-hwJKQRFBP8g_o5rZ68k1XGG3DPHoeaM64gNoDeF9ngYE9rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: input: do not increment usages when a
 duplicate is found
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 2:11 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Mon, 16 Apr 2018, Dmitry Torokhov wrote:
>
>> So what is happening with this series? I think we should get it them
>> in; there is really no reason for bumping ABS_MISC till it gets into
>> ABS_MT_* range on some devices that are out there.
>>
>> FWIW
>>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Sorry, I somehow lost this one. Now queued for 4.18.

Thanks Jiri, and thanks Dmitry for the reminder.

Jiri, BTW, I have 2 patch locally that should mitigate the negative
impact from this patch if there is any,

While trying to merging hid-multitouch into hid-core, I came to
realize that hid-generic should probably split the HID collections by
applications. If a device has a joystick and a mouse collection, there
is no point merging these two collections together. This is the most
common use case for reusing the same ABS_X value in one device.

I'll try to post the patches today, though I have some internal deadline :(

Cheers,
Benjamin
