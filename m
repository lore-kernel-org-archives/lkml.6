Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeBFSCY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:02:24 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:37562 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbeBFSB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:01:59 -0500
X-Google-Smtp-Source: AH8x227s520x6iqiqdJrqyI2QlcTciftNGUxTvHtsRLO/JHLvE5XgseX7pTB7A/x6RcI9/lbaZp0Kg/mZ2WBMnMgLFo=
MIME-Version: 1.0
In-Reply-To: <1517919923.6726.13.camel@synopsys.com>
References: <20180206110810.9093-1-brgl@bgdev.pl> <1517919923.6726.13.camel@synopsys.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 6 Feb 2018 19:01:57 +0100
Message-ID: <CAMRc=MfgLA2KDMFLM_GrbSb6MfQeAdHfVJXbnx-ss+S4xm72uw@mail.gmail.com>
Subject: Re: [PATCH v2] arc: dts: use 'atmel' as manufacturer for at24 in axs10x_mb
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-06 13:25 GMT+01:00 Alexey Brodkin <Alexey.Brodkin@synopsys.com>:
> Hi Bartosz,
>
> On Tue, 2018-02-06 at 12:08 +0100, Bartosz Golaszewski wrote:
>> Using compatible strings without the <manufacturer> part for at24 is
>> deprecated since commit 6da28acf745f ("dt-bindings: at24: consistently
>> document the compatible property"). Use a correct 'atmel,<model>'
>> value.
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> So my further input might be a bit unexpected :)
>
> I took a look at the real board and understood that we specified in .dts
> wrong ICs. Those Atmel parts are not connected to the CPU at all (used by some
> external device) and instead I2C EEPROM we really have connected (but not yet
> obviously used in the Linux kernel) is NXP's PCF8594C-2.
>
> That said we may accept your change because it doesn't break anything
> and then I'll send an update to axs10x_mb.dts with replacement of EEPROM nodes.
> Or we may drop your change at all since I'm going to replace corresponding nodes.
>
> -Alexey

Looks like PCF8594C-2 is compatible with atmel,24c04 - when you'll be
submitting this patch, please extend the at24 DT bindings with a new
naming exception (just like the one for renesas).

Feel free to drop this patch if you plan to submit the fix soon -
otherwise, apply it if it may take some time.

Thanks,
Bartosz
