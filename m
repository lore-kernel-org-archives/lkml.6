Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeEBMhK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:37:10 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:14455 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeEBMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:37:08 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN2EzqY"
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 4/7] gpio: pca953x: define masks for addressing common and extended registers
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHp75Ve37aARbNZ8qu5W9C-fFG5Kf9GRE_VR4aRLFpX61zviyg@mail.gmail.com>
Date: Wed, 2 May 2018 14:36:54 +0200
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Message-Id: <FA9DBCAF-2EA5-4317-BBA3-E2D6A9EAC5D4@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <3df974ea890116d759844e56362dc0786388869a.1524933096.git.hns@goldelico.com> <CAHp75Ve37aARbNZ8qu5W9C-fFG5Kf9GRE_VR4aRLFpX61zviyg@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42CbHga014158


> Am 02.05.2018 um 14:29 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> 
> On Sat, Apr 28, 2018 at 7:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> These mask bits are to be used to map the extended register
>> addreseses (which are defined for an unsupported 8-bit pcal chip)
>> to 16 and 24 bit chips (pcal6524).
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/gpio/gpio-pca953x.c | 3 +++
>> 1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
>> index 2b667166e855..fc863faa3ce4 100644
>> --- a/drivers/gpio/gpio-pca953x.c
>> +++ b/drivers/gpio/gpio-pca953x.c
>> @@ -56,6 +56,9 @@
>> #define PCAL6524_DEBOUNCE      0x2d
>> 
>> #define PCA_GPIO_MASK          0x00FF
> 
> + empty line (the above is about contents, not addresses)

ok.

> 
>> +#define PCAL_GPIO_MASK         GENMASK(4, 0)
>> +#define PCAL_PINCTRL_MASK      (~PCAL_GPIO_MASK)
> 
> I'm not sure which would be better here
> 
> 1) to follow existing style
> 0x1F
> 0xE0

I have also thought about this.

> 
> 2) to use GENMASK() in both definitions
> 
> 3) as it in this patch.
> 
> 
> Whatever Linus prefers.

Ok, waiting for his suggestion.

> 
>> +
>> #define PCA_INT                        0x0100
>> #define PCA_PCAL               0x0200
>> #define PCA_LATCH_INT (PCA_PCAL | PCA_INT)
>> --
>> 2.12.2
>> 

BR and thanks,
Nikolaus
