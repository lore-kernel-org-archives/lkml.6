Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeCCKAa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 05:00:30 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33250 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCCKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 05:00:29 -0500
X-Google-Smtp-Source: AG47ELsXvWy8QSJ0rmTgFsMwqNfwEBzE+S1/YhKQwfVUAtHYAz/BLyu1yD3E03J0IoL5ekl/rnyxr0kKXJHuVx6vybw=
MIME-Version: 1.0
In-Reply-To: <20180303092417.GA30917@amd>
References: <CA+Y=x3=U_zheHBxeNSzL9nSdXOZB7rs-JDNr36323uJ9Uhx0Hg@mail.gmail.com>
 <CA+Y=x3=+kPXJRNYo91i4yJiqqVHDsMhn2pAwkmAH2LV3usd7Hg@mail.gmail.com> <20180303092417.GA30917@amd>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 3 Mar 2018 11:00:28 +0100
X-Google-Sender-Auth: P4n038nPgO9bouGA5G0OZX1zJPQ
Message-ID: <CAJZ5v0iVmE0jwRW1f6hnohSVzKsZbLr0axi+VKoR+FQcHM+_7w@mail.gmail.com>
Subject: Re: 4.16-rc3 fails to resume on MacBookPro10,1 -
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Worsley <amworsley@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, 844788@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 3, 2018 at 10:24 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> On Sat 2018-03-03 17:27:36, Andrew Worsley wrote:
>> On 3 March 2018 at 16:41, Andrew Worsley <amworsley@gmail.com> wrote:
>> > Basically hangs on resuming after decompressing. The last statement
>> > displayed is "resume: Image successfully loaded"
>> >  - I attach a photo as I can't get access to it
>> ....
>> > Bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=844788
>> >
>> > I couldn't get anything from the function keys with this latest kernel.
>> ...
>>
>> By plugging in a USB keyboard I can get sysrq stuff to work - but
>> stupidly the kernel disables all the useful ones so I will have to
>> compile a new kernel with it set to 1 so I can get some traces.
>> Really annoyed by this default setting, presumably from debian?
>> Wished there was a boot command line option to configure the allowed
> options.
>
> So hibernation is broken on x86-64?
>
> Ideas for debugging:
>
> 1) get that sysrq to work, backtrace where it is hung would be very
> useful.
>
> 2) try v4.15.

That one works for me FWIW.

> 3) try without KPTI enabled. Probably noone knows how it interacts
> with that...
>
> (And 4), we should really start doing some periodic testing of hibernation).

I do that, but the period is not particularly short ...
