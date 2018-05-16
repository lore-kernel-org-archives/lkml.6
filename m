Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeEPT5n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:57:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:20420 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:57:41 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WivdN1GDmY"
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 2/3] gpio: pca953x: define masks for addressing common and extended registers
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHp75VcadghXsqu66NmrfbEPpgqusEUuzSkrE8PSJjAV0avntQ@mail.gmail.com>
Date: Wed, 16 May 2018 21:57:36 +0200
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Message-Id: <3E4522A9-A649-4D01-AE2A-57B9C8ED8851@goldelico.com>
References: <cover.1526490085.git.hns@goldelico.com> <314df7f911fda8f5584cc4384a26074848a2673b.1526490085.git.hns@goldelico.com> <CAHp75VcadghXsqu66NmrfbEPpgqusEUuzSkrE8PSJjAV0avntQ@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GJvo4n000973


> Am 16.05.2018 um 21:50 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> 
> On Wed, May 16, 2018 at 8:01 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> These mask bits are to be used to map the extended register
>> addreseses (which are defined for an unsupported 8-bit pcal chip)
>> to 16 and 24 bit chips (pcal6524).
>> 
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/gpio/gpio-pca953x.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
>> index 2b667166e855..c0eb679e60d4 100644
>> --- a/drivers/gpio/gpio-pca953x.c
>> +++ b/drivers/gpio/gpio-pca953x.c
>> @@ -56,6 +56,10 @@
>> #define PCAL6524_DEBOUNCE      0x2d
>> 
>> #define PCA_GPIO_MASK          0x00FF
>> +
>> +#define PCAL_GPIO_MASK         GENMASK(4, 0)
>> +#define PCAL_PINCTRL_MASK      (~PCAL_GPIO_MASK)
>> +
> 
> I give second thought about it, and think
> either plain values, or second converted to its own explicit GENMASK
> would be better.
> 
> (most confusing part to me is unknowness of the side of PINCTRL part
> in the mask)

I see.

Then, I'd also prefer plain values.

If ok, I can send a v7 tomorrow.

BR,
Nikolaus
