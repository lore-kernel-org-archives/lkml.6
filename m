Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbeBJJlg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 04:41:36 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44040 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeBJJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 04:41:35 -0500
X-Google-Smtp-Source: AH8x224KzQBJpM15fNqlJdfH6G31VXFhsEyJvU/B0AubbIGgsAc4/0p8n63w4zhyp145gSloSWyDook1eKm6Vl+dJME=
MIME-Version: 1.0
In-Reply-To: <20180210092003.GA20377@1wt.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu> <20180209235012.4993-2-rabel@robertabel.eu>
 <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com> <20180210092003.GA20377@1wt.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Feb 2018 10:41:34 +0100
Message-ID: <CANiq72m6bFYywFa30HhtiAxPP0sK+bWgsxwUhT+b-Sjh0baBCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
To: Willy Tarreau <w@1wt.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:20 AM, Willy Tarreau <w@1wt.eu> wrote:
> Hi Miguel,
>
> On Sat, Feb 10, 2018 at 09:58:44AM +0100, Miguel Ojeda wrote:
>> On Sat, Feb 10, 2018 at 12:50 AM, Robert Abel <rabel@robertabel.eu> wrote:
>> > The graphics command expects 16 hexadecimal literals, but would allow characters in range [0-9a-zA-Z] instead of [0-9a-fA-F].
>> >
>> > Signed-off-by: Robert Abel <rabel@robertabel.eu>
>> > ---
>> >  drivers/auxdisplay/charlcd.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
>> > index 642afd88870b..324d02f9f1c5 100644
>> > --- a/drivers/auxdisplay/charlcd.c
>> > +++ b/drivers/auxdisplay/charlcd.c
>> > @@ -441,9 +441,9 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
>> >                         shift ^= 4;
>> >                         if (*esc >= '0' && *esc <= '9') {
>> >                                 value |= (*esc - '0') << shift;
>> > -                       } else if (*esc >= 'A' && *esc <= 'Z') {
>> > +                       } else if (*esc >= 'A' && *esc <= 'F') {
>> >                                 value |= (*esc - 'A' + 10) << shift;
>> > -                       } else if (*esc >= 'a' && *esc <= 'z') {
>> > +                       } else if (*esc >= 'a' && *esc <= 'f') {
>>
>> Willy, Geert: this seems obvious, but do you know if the broader range
>> was intended for some reason?
>
> No, I think it was simply a brain fart from me 14 years ago, as I can
> find it as well in the original 0.9.0 patch for kernel 2.4!
>
> Ack from me on this patch.

Thanks Willy for the quick answer! Then:

Compile-tested.

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

>
> Willy
