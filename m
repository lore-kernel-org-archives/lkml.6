Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDUUmH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 16:42:07 -0400
Received: from bert.emutex.com ([91.103.1.109]:53905 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753208AbeDUUmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 16:42:05 -0400
Date: Sat, 21 Apr 2018 21:41:57 +0100
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc128s052: allow driver to be matched using
 ACPI
Message-ID: <20180421204157.y3zoejow7gfl3pj3@localhost>
References: <20180419132036.27493-1-javier@emutex.com>
 <20180419132036.27493-2-javier@emutex.com>
 <20180421165441.0c64415d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180421165441.0c64415d@archlinux>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi Jonathan, On Sat, Apr 21, 2018 at 04:54:41PM +0100, Jonathan
    Cameron wrote: > I don't really see the connection between the change in
   here > and what the description says... I think you're right, we didn't make
    our intent clear here. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 21, 2018 at 04:54:41PM +0100, Jonathan Cameron wrote:
> I don't really see the connection between the change in here
> and what the description says...

I think you're right, we didn't make our intent clear here.

> If you are probing from ACPI then there is no need to ensure
> a valid of table is supplied (even if we aren't building with OF)
> which is what I think this patch is trying to do...

The patch enables ACPI _DSD to reuse existing DT "compatible" strings,
as described in Documentation/acpi/enumeration.txt, even without OF.
This kind of patch has some precedent, like for example:

    01427fe7c4b9 ("Input: adxl34x - make it enumerable in ACPI environment")

To clarify, for the UP2 board we don't actually need this patch as we
have an ACPI _HID - just thought it would might be an improvement for
others.

I'll improve the description and perhaps reorder this patch last for v2.
Or I can send separately if you prefer.

Thanks for your review!
