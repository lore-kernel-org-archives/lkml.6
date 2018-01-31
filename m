Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeAaMZT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:25:19 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:42491 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeAaMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:25:16 -0500
X-Google-Smtp-Source: AH8x227um8Y9SKtjvQ24NXMtG3BR6OqzxTBiTPaCOErHEJ/U2ogogozTP/JTeJa7/eLBVaY/6AEOnRoqBZ6c4aCrQ2A=
MIME-Version: 1.0
In-Reply-To: <9171d401-32de-b334-40da-5e80a00e24d9@redhat.com>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com> <9171d401-32de-b334-40da-5e80a00e24d9@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 14:25:14 +0200
Message-ID: <CAHp75Vc4JpQ7X9AEFgK0S8SZ89=Mbj8t-jqnWYuPg+LvW9cKWQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Hans de Goede <hdegoede@redhat.com>
Cc: Steve Presser <steve@pressers.name>, Hartmut Knaack <knaack.h@gmx.de>,
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

On Wed, Jan 31, 2018 at 1:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 01/30/2018 06:38 PM, Andy Shevchenko wrote:
>> On Tue, Jan 30, 2018 at 7:25 PM, Steve Presser <steve@pressers.name>
>> wrote:

>> Yep. See chapter 8.2. Isn't enough proof? Or you believe in two
>> accelerometers with off-by-one conflicting address on a cheap laptop
>> with left unused two magnetometers on the same time?

> This is not a cheap device, this has been seen on a Lenovo Yoga 11e,
> the yoga's typically have an accelerometer in both the base and the display
> and have no use for a magnetometer. Not saying that you're wrong,

Yep, Steve explained to me. Thanks!

> but my expectations are different. Anyways we need to find someone to
> test this, I asked Jeremy to write a patch for this because we had
> Yoga 11e user (Lars Kellogg-Stedman in the CC) asking question and
> Jeremy did ask that Lars to test.
>
> It looks like we will need to reach out to Lars and get some testing done
> to figure this out one way or the other.
>
> Lars if you're reading this can you please reply. If you've trouble
> building your own kernels for testing, would you be willing to install
> Fedora so that we can provide test kernels for you?

Have you chance a look at the branch I pushed yesterday?

> For reference here is the relevant DSDT blurb from the Yoga 11e:

Yes, I have googled something like this yesterday, but it doesn't
clarify what kind of devices behind this entry.

>             Device (ACC)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (_HID, "BOSC0200")  // _HID: Hardware ID
>                 Name (_CID, "BOSC0200")  // _CID: Compatible ID
>                 Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>                 Name (_UID, One)  // _UID: Unique ID
>                 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource
> Settings
>                 {
>                     Name (RBUF, ResourceTemplate ()
>                     {
>                         I2cSerialBusV2 (0x0019, ControllerInitiated,
> 0x00061A80,
>                             AddressingMode7Bit, "\\_SB.PCI0.I2C3",
>                             0x00, ResourceConsumer, , Exclusive,
>                             )
>                         I2cSerialBusV2 (0x0018, ControllerInitiated,
> 0x00061A80,
>                             AddressingMode7Bit, "\\_SB.PCI0.I2C3",
>                             0x00, ResourceConsumer, , Exclusive,
>                             )
>                     })
>                     Return (RBUF) /* \_SB_.PCI0.I2C3.ACC_._CRS.RBUF */
>
>                 }

-- 
With Best Regards,
Andy Shevchenko
