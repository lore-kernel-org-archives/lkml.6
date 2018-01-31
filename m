Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeAaK4R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:56:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753199AbeAaK4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:56:08 -0500
Date: Wed, 31 Jan 2018 10:55:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Steven Presser <steve@pressers.name>,
        Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Jeremy Cline <jeremy@jcline.org>,
        "Jonathan Cameron" <jic23@jic23.retrosnub.co.uk>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <20180131105542.00002a79@huawei.com>
In-Reply-To: <CAHp75VfPBP0TVt-==0wjcK6Oxg1kVN4mQf5Ji50RBy=SXf6yFw@mail.gmail.com>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
        <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
        <20180114104330.2aa7c1fd@archlinux>
        <20180128094021.572ab366@archlinux>
        <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
        <20180130160107.000006df@huawei.com>
        <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
        <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
        <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
        <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
        <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name>
        <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
        <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name>
        <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
        <CAHp75VfPBP0TVt-==0wjcK6Oxg1kVN4mQf5Ji50RBy=SXf6yFw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018 23:20:28 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jan 30, 2018 at 10:12 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jan 30, 2018 at 9:27 PM, Steven Presser <steve@pressers.name> wrote:  
> >> On 01/30/2018 02:05 PM, Andy Shevchenko wrote:  
> >>> On Tue, Jan 30, 2018 at 8:34 PM, Steven Presser <steve@pressers.name>
> >>> wrote:  
> 
> > Let's do this way. Create a bug on kernel bugzilla, attach output of
> >
> > % acpidump -o tables.dat # tables.dat file
> > % grep -H 15 /sys/bus/acpi/devices/*/status
> > % dmidecode
> >
> > and share the number here. I will take it.  
> 
> Here [1] is the branch with another approach. Can you test it and tell
> if it fixes the issue?
> 
> [1]: https://bitbucket.org/andy-shev/linux/branch/topic/iio-acpi
> It's based on linux-next + compiletest branch of IIO subsystem.
> 

Thanks Andy - this is much nicer.  I really don't like having
these 'hacks' make it into the driver so very keen on doing it
this way.

Now we get to find out what devices have this broken in other
ways ;)

Jonathan
