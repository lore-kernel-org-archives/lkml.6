Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeAaO6u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:58:50 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35713 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeAaO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:58:47 -0500
X-Google-Smtp-Source: AH8x227SAuZ/PgbxImJQJmi7wmY0f9eWaYrnn4fHt/NKOqqPlua4dpSC7jvJZgwG60MHM2hKx0LQRw==
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for
 BOSC0200
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux>
 <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com>
 <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <9171d401-32de-b334-40da-5e80a00e24d9@redhat.com>
 <CAHp75Vc4JpQ7X9AEFgK0S8SZ89=Mbj8t-jqnWYuPg+LvW9cKWQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <84f1a817-60e8-774a-3fd8-78865e53608a@redhat.com>
Date: Wed, 31 Jan 2018 15:58:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc4JpQ7X9AEFgK0S8SZ89=Mbj8t-jqnWYuPg+LvW9cKWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-01-18 13:25, Andy Shevchenko wrote:
> Have you chance a look at the branch I pushed yesterday?

I assume you mean:

https://bitbucket.org/andy-shev/linux/branch/topic/iio-acpi

This looks very nice and a much better solution then what
Jeremy Cline posted, which is my fault as I suggested that
approach to Jeremy :)

I've not done a full review, only a quick look, from a quick
look this looks good. Especially from a code-design pov.

Regards,

Hans



> 
>> For reference here is the relevant DSDT blurb from the Yoga 11e:
> 
> Yes, I have googled something like this yesterday, but it doesn't
> clarify what kind of devices behind this entry.
> 
>>              Device (ACC)
>>              {
>>                  Name (_ADR, Zero)  // _ADR: Address
>>                  Name (_HID, "BOSC0200")  // _HID: Hardware ID
>>                  Name (_CID, "BOSC0200")  // _CID: Compatible ID
>>                  Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>>                  Name (_UID, One)  // _UID: Unique ID
>>                  Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource
>> Settings
>>                  {
>>                      Name (RBUF, ResourceTemplate ()
>>                      {
>>                          I2cSerialBusV2 (0x0019, ControllerInitiated,
>> 0x00061A80,
>>                              AddressingMode7Bit, "\\_SB.PCI0.I2C3",
>>                              0x00, ResourceConsumer, , Exclusive,
>>                              )
>>                          I2cSerialBusV2 (0x0018, ControllerInitiated,
>> 0x00061A80,
>>                              AddressingMode7Bit, "\\_SB.PCI0.I2C3",
>>                              0x00, ResourceConsumer, , Exclusive,
>>                              )
>>                      })
>>                      Return (RBUF) /* \_SB_.PCI0.I2C3.ACC_._CRS.RBUF */
>>
>>                  }
> 
