Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeBUSct (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:32:49 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38896 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbeBUScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:32:47 -0500
X-Google-Smtp-Source: AH8x224Eymerm9I1vb1WwPx0i+x30LnKwsyH/d40Mlnwo6p27f85qsEpfHhK1omWnWh8JnFL4kQsBl//kIpX0j9pKJE=
MIME-Version: 1.0
In-Reply-To: <CANEr7oX_V1vchZA+J2ia5GkZf6jZiVN0ByWK2G4jTp0EFXphqg@mail.gmail.com>
References: <20180221125512.8265-1-delroth@google.com> <CAEnQRZB_76YjK14-V7PngVVNhAO2osdntYe6ieD7iMqBVuH+Bw@mail.gmail.com>
 <CANEr7oX_V1vchZA+J2ia5GkZf6jZiVN0ByWK2G4jTp0EFXphqg@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 21 Feb 2018 20:32:45 +0200
Message-ID: <CAEnQRZAStm4-hPWXd2Nsx2JqLU+mVgiXuwyo46jTfGKxLyJD4w@mail.gmail.com>
Subject: Re: [PATCH] iio: light: add driver for bh1730fvc chips
To: "Pierre Bourdon (delroth)" <delroth@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 6:15 PM, Pierre Bourdon (delroth)
<delroth@google.com> wrote:
> Hi Daniel,
>
> On Wed, Feb 21, 2018 at 4:31 PM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>> On Wed, Feb 21, 2018 at 2:55 PM, Pierre Bourdon <delroth@google.com> wrote:
>>> Ambient light sensor that supports visible light and IR measurements and
>>> configurable gain/integration time.
>>>
>>
>> Can you have a quick look to existing ROHM light sensor support.
>> Perhaps your sensor
>> is similar enough with existing code.
>>
>> I'm talking about:
>>
>> drivers/iio/light/{bh1750.c  bh1780.c }
>
> bh1750 does things sufficiently different in its protocol that the
> amount of common code would be fairly small. Unlike bh1730/bh1780 it's
> not fully SMBus compatible for example.
>
> bh1780 could probably be implemented as a subset of bh1730. It's
> basically a simplified bh1730 with less knobs. But there is still a
> significant amount of differences that make common code difficult to
> extract. For example, bh1780 reads lux values directly from the chip,
> whereas bh1730 has two raw channels that need to be combined in
> software to get a processed lux value. It could be done, but my gut
> feeling is that writing a "HAL" for this is going to make things more
> complicated, not simpler.
>

I only had a very quick look at existing ROHM sensors drivers. So, sure
if it doesn't makes sense then we can have bh1730 as a standalone driver.

<snip>

>>
>> Usually the devicetree binding part should be sent as a separate patch
>>  with device-tree mailing list and maintainer at CC.
>>
>> Use ./scripts/get_maintainer.pl to find the exact emails.
>>
>> Mind that you should sent a patchseries:
>>
>> 1/2 - driver code
>> 2/2 - documentation
>
> Will do. Should the of_match_table in the driver code be part of 1/2
> (driver) or 2/2 (dt-bindings)?
>

Should be part of 1/2. 2/2 should only containt the patch for Documentation.


> I'll send a v2 with this + the other changes you've suggested.

Great thanks!

Any idea how to make my gmail not to wrap the lines in plain text mode? :D
It drives me crazy when I reread my emails.

thanks,
Daniel.
