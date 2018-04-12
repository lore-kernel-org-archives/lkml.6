Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeDLM3F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:29:05 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:54225 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDLM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:29:03 -0400
X-Google-Smtp-Source: AIpwx494lLLSc802rH7nwwY5YzVSHKRG9dSbPrXVgI/zNzRadmcE39aYDmCcIRn+1tPZuvi9AxA1LUl8dsPNm3JgYHg=
MIME-Version: 1.0
In-Reply-To: <94aceb15-63a5-44a3-d0bc-f56adebc27d5@suse.de>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
 <20180404172258.7678-4-manivannan.sadhasivam@linaro.org> <CACRpkdZPOSDenSORGVLPuJKPP_iE97mZLXHJLcF2kH5wKPw=tg@mail.gmail.com>
 <94aceb15-63a5-44a3-d0bc-f56adebc27d5@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Apr 2018 14:29:01 +0200
Message-ID: <CACRpkdbizcaB-EfK_5k-=5GsoMJrtNoE2HBdiZOmA62NnPsZBA@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] pinctrl: actions: Add Actions S900 pinctrl driver
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3CCTA0I028243

On Thu, Apr 12, 2018 at 2:10 PM, Andreas Färber <afaerber@suse.de> wrote:
> Am 12.04.2018 um 11:04 schrieb Linus Walleij:
>> On Wed, Apr 4, 2018 at 7:22 PM, Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:
>>
>>> Add pinctrl driver for Actions Semi S900 SoC. The driver supports
>>> pinctrl, pinmux and pinconf functionalities through a range of registers
>>> common to both gpio driver and pinctrl driver.
>>>
>>> Pinmux functionality is available only for the pin groups while the
>>> pinconf functionality is available for both pin groups and individual
>>> pins.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Patch applied for v4.18
>>
>> GOOD WORK!
>>
>> We really need to get this in so that Andreas can work on S500
>> patches with this as a base.
>
> No, I refused to do that. If his patches get merged, Mani offered that
> he will take care of rebasing/rewriting S500 part.

OK then.

>> If any review comments still remain they can surely be addressed
>> with incremental improvement patches.
>
> My biggest problem was/is that Mani designed his structs totally
> different from mine, with no explanation why or how they correlate.

This kind of clashes happen all the time because of parallel work.
As much as we all hate to reimplement stuff just because
coordination is not perfect, it still invariably happens, it's just
a natural flaw to the way asynchronous development without
project managers work.

But what is important to keep in mind is that there is no bad
intent from anyone here, you are both enthusiastic contributors
and let's keep this friendly.

If Manivannan has already offered to update your patch, that's
great.

If you feel any kind of annoyance or aggression toward another
contributor, then I have a big problem as maintainer, and that
problem is hard to solve, scary to deal with and extremely
exhausting and diverting attention from important technical work,
so please help me as much as you can NOT to give me this
particular problem.

> Also I had protested against him defining fake pins for the drive
> strength. Since I did not have time to review the newer patches yet,
> please make sure that this is addressed _before_ merging. Changing the
> binding after the fact is a problem!

This is more of a technical issue and a bit of philosophical
debate on how to partition the hardware so as to be represented
in the binding.

Let's discuss it. Surely Manivannan can augment his DT
bindings if there is a problem.

With that in mind, I have a softer stance that some DT
fundamentalists out there: I do not consider the DT binding as
etched in stone because it was merged to the kernel tree. I
see the stone-etching as something that happens when a
mass-produced system is deployed with a DTB file
using these bindings in its boot partition. When sold to
end users.

That means that these bindings can still be augmented
as long as we are in prototype stage, and if we are just
talking about hobbyist work using attached device trees
or booting off media with DTB as a separate target image
but copied from the kernel tree, we can always augment
them.

I guess some will disagree with me on this stance.
But those are my principles.
If you don't like them, I have others. :D

Yours,
Linus Walleij
