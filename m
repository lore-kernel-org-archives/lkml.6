Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964945AbeBMNgs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:36:48 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37635 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964775AbeBMNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:36:46 -0500
X-Google-Smtp-Source: AH8x224sE9FkW8OVLAlf9s19LUuQ/dsd1Nu9t0Hu+Wg0Hz/gyLS9Up+FMUtXl8p5lAWwT01Ym8qhNh1OYPi/24r2Z60=
MIME-Version: 1.0
In-Reply-To: <CANiq72m6bFYywFa30HhtiAxPP0sK+bWgsxwUhT+b-Sjh0baBCA@mail.gmail.com>
References: <20180209235012.4993-1-rabel@robertabel.eu> <20180209235012.4993-2-rabel@robertabel.eu>
 <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
 <20180210092003.GA20377@1wt.eu> <CANiq72m6bFYywFa30HhtiAxPP0sK+bWgsxwUhT+b-Sjh0baBCA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 15:36:45 +0200
Message-ID: <CAHp75VfQUNVB9qoxcM5DSWz7Peu40oqtVO6dQse8ASRQa5ufEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 11:41 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Sat, Feb 10, 2018 at 10:20 AM, Willy Tarreau <w@1wt.eu> wrote:
>> On Sat, Feb 10, 2018 at 09:58:44AM +0100, Miguel Ojeda wrote:
>>> On Sat, Feb 10, 2018 at 12:50 AM, Robert Abel <rabel@robertabel.eu> wrote:

>>> >                         shift ^= 4;
>>> >                         if (*esc >= '0' && *esc <= '9') {
>>> >                                 value |= (*esc - '0') << shift;
>>> > -                       } else if (*esc >= 'A' && *esc <= 'Z') {
>>> > +                       } else if (*esc >= 'A' && *esc <= 'F') {
>>> >                                 value |= (*esc - 'A' + 10) << shift;
>>> > -                       } else if (*esc >= 'a' && *esc <= 'z') {
>>> > +                       } else if (*esc >= 'a' && *esc <= 'f') {
>>>
>>> Willy, Geert: this seems obvious, but do you know if the broader range
>>> was intended for some reason?
>>
>> No, I think it was simply a brain fart from me 14 years ago, as I can
>> find it as well in the original 0.9.0 patch for kernel 2.4!

I understand that we have a huge and hopefully nice library in the
kernel, but the question still the same, what prevents a developer or
maintainer to look at it from time to time?

For, I dare to say, ages we have hex_to_bin() and hex2bin().
Can we use it?

-- 
With Best Regards,
Andy Shevchenko
