Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeBFTrc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:47:32 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:45650 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeBFTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:47:30 -0500
X-Google-Smtp-Source: AH8x2241jCZ+tLILjn1UP1Yh18N4oPCsAG6twA5d1gWGp1VXnIAjfcSskkICXSDasM0X+HSc7D0qQPfBFUnc0k1kFR4=
MIME-Version: 1.0
In-Reply-To: <9ee7da52-d86a-7784-8c00-6e5b4ae3ed96@pressers.name>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name> <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
 <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name> <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
 <9ee7da52-d86a-7784-8c00-6e5b4ae3ed96@pressers.name>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2018 21:47:28 +0200
Message-ID: <CAHp75VeKq0=+BvK=n09iufsOSuMgE3CtJCiWSqRMGM2dcOiJVQ@mail.gmail.com>
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

On Sun, Feb 4, 2018 at 7:58 PM, Steven Presser <steve@pressers.name> wrote:

> I had a chance to sit back down with the machine.  I didn't take it all the
> way apart - there are pieces that I'm afraid of breaking without directions
> on how to properly disassemble them.

No need I think to go so-o deep.

> However, I did recover an exact chip ID - the chips in use are BMA255s [1].
> Rather than take the machine apart (and because the chips are 2mmx2mm), I
> queried the chip over SMBus.  On page 50 of the below document, you can see
> that register 0x00 is a read-only chip ID.  This chipID is unique per Bosch
> product.  So, using SMBus, I asked the chip for it's chip ID (0xFA, in this
> case) and then searched likely products until I found the matching chipID.

Thanks!

> Does this suffice to settle which chips are in use?  If not, I can finish
> taking the machine apart, I'd just prefer to avoid the risk of breaking
> something.

I think it's pretty much enough.

> As soon as I finish screwing everything back together, I'll grab the other
> software IDs asked for and build the branch referenced elsewhere.

I'm just waiting for your Tested-by in case my patch series works as
expected before I send it out.

-- 
With Best Regards,
Andy Shevchenko
