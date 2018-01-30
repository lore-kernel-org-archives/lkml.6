Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeA3QBh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:01:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751858AbeA3QBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:01:36 -0500
Date: Tue, 30 Jan 2018 16:01:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Jeremy Cline <jeremy@jcline.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        "Steven Presser" <steve@pressers.name>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <20180130160107.000006df@huawei.com>
In-Reply-To: <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
        <20171210182152.70ad8fbf@archlinux>
        <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
        <20180114104330.2aa7c1fd@archlinux>
        <20180128094021.572ab366@archlinux>
        <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.48.115]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018 16:07:02 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jan 28, 2018 at 11:40 AM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> > On Sun, 14 Jan 2018 10:43:30 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:  
> >> On Tue, 9 Jan 2018 21:24:01 +0000
> >> Jeremy Cline <jeremy@jcline.org> wrote:  
> >> > On 12/10/2017 12:21 PM, Jonathan Cameron wrote:  
> >> > > On Wed, 6 Dec 2017 17:52:34 +0000
> >> > > Jeremy Cline <jeremy@jcline.org> wrote:  
> 
> >> > >> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
> >> > >> device. Check for a companion device and handle a second i2c_client
> >> > >> if it is present.  
> 
> >> > I didn't see this land anywhere (I was looking in
> >> > git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git, maybe that's not
> >> > the right place?) and I just wanted to make sure this didn't get lost in
> >> > the holiday shuffle.  
> >> It did indeed get lost - thanks for the reminder.  Now applied to the
> >> togreg branch of iio.git.  However, unfortunately we may be too near
> >> to the merge window opening for it to make it.  Depends on what Linus
> >> says later today when rc8 comes out.  
> >
> > I've added some #ifdef CONFIG_ACPI defenses against the case
> > of no ACPI support being compiled in.  Alternative would be to add
> > stubs for those functions that don't have them...
> >
> > probably just acpi_device_hid.
> >
> > But that would take much longer.  Feel free to propose it and a patch
> > removing the ifdef fun if you like!  
> 
> Where can I see the patch?
> 

Doh. I clearly forgot to push out.  Should be able to push to
iio.git on kernel.org later.

Jonathan
