Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965579AbeBMREs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:04:48 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:46533 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965481AbeBMRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:39 -0500
X-Google-Smtp-Source: AH8x224pbYAGErnd7qKzstLm7i0Y98itBk3t9QfspREspoda/6IX3/bwXw6G5tKlD6jZhaKzZebJPPHZ0MwwSVva04A=
MIME-Version: 1.0
In-Reply-To: <20180213165023.xmzovx7fd3gdljxw@pali>
References: <20180127133209.28995-1-pali.rohar@gmail.com> <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali> <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
 <20180131120348.azy25aqvn5wrdkeh@pali> <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
 <20180212153012.vffvjmz26ifyxbj5@pali> <CAHp75VfF+qwCXcr3yuayE-Z+UG9wuMOKfGzLhdyPk79daEi9gQ@mail.gmail.com>
 <20180213150004.5d2v7y7wwuure4io@pali> <CAHp75VfxgbFiDxyrqyMRE8s85L1_EzkVvrA1NGYA5_su=5oGVQ@mail.gmail.com>
 <20180213165023.xmzovx7fd3gdljxw@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 19:01:37 +0200
Message-ID: <CAHp75Vc9T8umLVtBuBCK+HgAga9=ZKBhBTjA8Nmbvaw1zyVLng@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Steven Honeyman <stevenhoneyman@gmail.com>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Jochen Eisinger <jochen@penguin-breeder.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mario Limonciello <Mario_Limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1DH4qjE023262

On Tue, Feb 13, 2018 at 6:50 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Tuesday 13 February 2018 17:06:19 Andy Shevchenko wrote:
>> On Tue, Feb 13, 2018 at 5:00 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
>> > On Tuesday 13 February 2018 16:55:00 Andy Shevchenko wrote:
>> >> On Mon, Feb 12, 2018 at 5:30 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
>> >> > On Wednesday 31 January 2018 14:27:51 Andy Shevchenko wrote:

>> >> > Following table already exists in dell-smo8800.c file:
>> >> > Can we reuse it?

>> >> >  Maybe moving array smo8800_ids[] into some header file
>> >> > (which one?) and statically inline it?
>> >>
>> >> Bad idea.
>> >>
>> >> > Or having it only in
>> >> > dell-smo8800.c file and exporting its symbol?
>> >>
>> >> Even worse.
>> >>
>> >> > Or is there better idea?
>> >> >
>> >> > For sure I do not want to copy paste this table into another module and
>> >> > maintaining two copies of this list.
>> >>
>> >> The copy is fine. Can you guarantee that those two lists would be
>> >> always the same? I'm not.
>> >
>> > Me neither.
>> >
>> >> And besides that explicitly over implicitly  is a really good thing. I
>> >> would not like to grep for an ID followed by grepping include line and
>> >> check each files to check if it uses it or not.
>> >
>> > So what do you suggest now?
>>
>> Copy'n'paste and maintain two lists.
>> Yes, it's not the ideal, but working solution.
>>
>> You may put a comment before each list to explain what the second does
>> and tell a contributor to look at it and update if needed.
>
> I'm not maintainer of i2c-i801.ko, Jean Delvare & Wolfram Sang are.
> Therefore instructing future contributors would be up to them.

Right. But from ACPI prospective the proposed change is not okay by my opinion.

How can I see what drivers are binding / relying on certain ACPI ID?

More precisely,

% git grep -n -w SMO8800

would be useless until one gets an idea to match against partial strings.

> Jean, it is OK?

>> > Having one file where it would be defined is a bad idea for you.
>>
>> Not just "one file", but "one *header* file". Or "exporting a symbol"
>> which is basically not supposed to be exported.
>> ID tables are part of the actual drivers, neither headers, nor libraries.
>
> But this is exactly what is needed. This ACPI ID table contains ACPI
> names which says if accelerometer is present or not.

In case of dell-smo8800.c the driver actually *binds* to these IDs.
Your change just provide another table to match and answer to the
question if XYZ is present on a such platform or not.

Similar approach is used in spi-pxa2xx.c (check pxa2xx_spi_pci_compound_match).

-- 
With Best Regards,
Andy Shevchenko
