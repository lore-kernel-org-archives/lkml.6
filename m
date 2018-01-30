Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeA3SIW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:08:22 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45968 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbeA3SIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:08:20 -0500
X-Google-Smtp-Source: AH8x224JF6dMMsD73lnKcZMo96hBV3bgRmzSsjA+Zy/B2AQ0zj8NqZh48V7E8UcZOzRjnUvxyIr4WDoAOkHfoDuz0wo=
MIME-Version: 1.0
In-Reply-To: <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com> <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 20:08:19 +0200
Message-ID: <CAHp75Vd3pDFk5NnJrak_smS-AeHh+d-GXaOwp-8mHtyaK+y0jg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Steve Presser <steve@pressers.name>
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

On Tue, Jan 30, 2018 at 7:38 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jan 30, 2018 at 7:25 PM, Steve Presser <steve@pressers.name> wrote:
>> Andy,
>>
>> Where did the assertion the second device is a magnetometer come from? Just
>> the data sheet?
>
> Yep. See chapter 8.2. Isn't enough proof? Or you believe in two
> accelerometers with off-by-one conflicting address on a cheap laptop
> with left unused two magnetometers on the same time?
>
> And we have a driver for magnetometer separately.
>
> So, it looks like we need to move ACPI ID to a new "kinda I2C mfd" IIO
> driver under drivers/iio/imu/bmc150_i2c.c

Even Kconfig for one of the driver states so.

Looking more to it, I think the patch should be reverted and new
driver is created instead.

I'm on it.

>> Steve
>>
>>
>> On Tue, Jan 30, 2018, 12:05 PM Andy Shevchenko <andy.shevchenko@gmail.com>
>> wrote:
>>>
>>> On Tue, Jan 30, 2018 at 6:40 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>> > On Tue, Jan 30, 2018 at 6:01 PM, Jonathan Cameron
>>> > <Jonathan.Cameron@huawei.com> wrote:
>>> >> On Mon, 29 Jan 2018 16:07:02 +0200
>>> >> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> >
>>> >>> > But that would take much longer.  Feel free to propose it and a
>>> >>> > patch
>>> >>> > removing the ifdef fun if you like!
>>> >
>>> >>> Where can I see the patch?
>>> >
>>> >> Doh. I clearly forgot to push out.  Should be able to push to
>>> >> iio.git on kernel.org later.
>>> >
>>> > Thanks, I can see it now.
>>> >
>>> > This patch almost wrong. Not by functionality it brings, but by style.
>>>
>>> Oy vey, the second device is *not* accelerometer, it is a magnetometer
>>> [1].
>>>
>>> [1]: https://www.mouser.com/ds/2/783/BST-BMC150-DS000-04-786477.pdf
>>>
>>> > I'll send soon a series of fixes to the driver (compile tested only)
>>> > to provide my view on the matters.
>>> >
>>> > P.S. In the future (I have some kind of deja vu I have told this
>>> > already to someone), please, Cc one or more of Rafael, Mika and/or me
>>> > for ACPI matters.
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
