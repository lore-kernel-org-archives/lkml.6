Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeDXRYB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:24:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751419AbeDXRX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:23:59 -0400
Date: Tue, 24 Apr 2018 18:23:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Javier Arteaga <javier@emutex.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc128s052: allow driver to be matched using
 ACPI
Message-ID: <20180424182330.000061a5@huawei.com>
In-Reply-To: <20180421204157.y3zoejow7gfl3pj3@localhost>
References: <20180419132036.27493-1-javier@emutex.com>
        <20180419132036.27493-2-javier@emutex.com>
        <20180421165441.0c64415d@archlinux>
        <20180421204157.y3zoejow7gfl3pj3@localhost>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.229]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2018 21:41:57 +0100
Javier Arteaga <javier@emutex.com> wrote:

> Hi Jonathan,
> 
> On Sat, Apr 21, 2018 at 04:54:41PM +0100, Jonathan Cameron wrote:
> > I don't really see the connection between the change in here
> > and what the description says...  
> 
> I think you're right, we didn't make our intent clear here.
> 
> > If you are probing from ACPI then there is no need to ensure
> > a valid of table is supplied (even if we aren't building with OF)
> > which is what I think this patch is trying to do...  
> 
> The patch enables ACPI _DSD to reuse existing DT "compatible" strings,
> as described in Documentation/acpi/enumeration.txt, even without OF.
> This kind of patch has some precedent, like for example:
> 
>     01427fe7c4b9 ("Input: adxl34x - make it enumerable in ACPI environment")
> 
> To clarify, for the UP2 board we don't actually need this patch as we
> have an ACPI _HID - just thought it would might be an improvement for
> others.
> 
> I'll improve the description and perhaps reorder this patch last for v2.
> Or I can send separately if you prefer.
> 
> Thanks for your review!
Unless we know of ACPI firmwares out there that are doing this, drop the
patch for now.  I don't want to see a flood of these based on a 'you can
do it that' way argument.

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
