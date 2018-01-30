Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeA3UMi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:12:38 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35327 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeA3UMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:12:36 -0500
X-Google-Smtp-Source: AH8x226r68uavjwpY1DooIT6EAC3gPiOnyy+172ODWE0oasZT4QrbLLbBdeqEd7xoj7UeK6KDRiPNQTcSN0xKsQuwrc=
MIME-Version: 1.0
In-Reply-To: <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name> <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
 <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 22:12:35 +0200
Message-ID: <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Steven Presser <steve@pressers.name>
Cc: Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Jeremy Cline <jeremy@jcline.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 9:27 PM, Steven Presser <steve@pressers.name> wrote:
> On 01/30/2018 02:05 PM, Andy Shevchenko wrote:
>> On Tue, Jan 30, 2018 at 8:34 PM, Steven Presser <steve@pressers.name>
>> wrote:

>>> First, I believe the "bmc150" in the subject line is in some way a
>>> misnomer.
>>> You'd have to ask Jeremy for more details on what he intended it to refer
>>> to.  However, I believe the device in question is actually the bma250[1],
>>> which does not have a magnetometer component.  I'm unfortunately away
>>> from
>>> my notes, but I can check later if you need me to verify the exact chip.
>>
>> Please do, I would really be on the safe side here.
>
> Will do.  My digital notes indicate I worked from what was exposed back to
> what chip matched.  If you can give me through Friday evening, I'll crack it
> and do a visual verification.  (Alas, I'm traveling and won't be back to it
> until then).

We are in the merge window anyway, so, no hurry.

I'm looking right now in the clean solution. Looks promising.

>> Bad, bad Lenovo. (DMI strings might help here)
> What particular DMI strings would be helpful?  All of them?

Let's do this way. Create a bug on kernel bugzilla, attach output of

% acpidump -o tables.dat # tables.dat file
% grep -H 15 /sys/bus/acpi/devices/*/status
% dmidecode

and share the number here. I will take it.

-- 
With Best Regards,
Andy Shevchenko
