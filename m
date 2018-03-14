Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeCNTF1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:05:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41970 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeCNTFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:05:25 -0400
X-Google-Smtp-Source: AG47ELv3rlrDU6sJ6oPDl8d7JId9hsl8ue823c838DlEiRRmIloDPgK6j56TMbm/xyNh5xmjK5EZIg==
Date: Wed, 14 Mar 2018 12:05:22 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Thierry Escande <thierry.escande@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180314190522.GY18510@minitux>
References: <20180314155514.3374-1-thierry.escande@linaro.org>
 <20180314155514.3374-3-thierry.escande@linaro.org>
 <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
 <20180314183043.GX18510@minitux>
 <D999852D-E9A7-41D2-9878-A93CB4D43D0C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D999852D-E9A7-41D2-9878-A93CB4D43D0C@holtmann.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 11:42 PDT 2018, Marcel Holtmann wrote:

> Hi Bjoern,
> 
> >>> +		bt-disable-n-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> >> 
> >> can we use a common name here. I think that Nokia and Broadcom drivers
> >> define one. And if this is the enable/shutdown GPIO, we should name it
> >> consistently across all manufacturers. It essentially does the same on
> >> Bluetooth UART chips no matter what chip is behind them.
> >> 
> > 
> > Broadcomm has a device-wakup-gpios and Nokia has bluetooth-wakup-gpios.
> > It might be that these behave in the same way, but from the description
> > they only trigger the wakeup.
> 
> that is something that we might need to start fixing. I really prefer
> if we name the GPIOs a bit more consistent.
> 
> > The reason for the proposed naming here is that the pin is named
> > "BT_DISABLE_N" in the datasheet.
> 
> That is not a reason I buy. So the next board comes around that labels
> it in the data sheet BT_DISABLE_YEAH_SUPER_GREAT and you send me a
> patch to the driver to look for that name. If the GPIO does the same
> thing, I couldn’t care less what the data sheet says. That might be
> a comment in the DT file, but it should not pollute the driver code.
> 

BT_DISABLE_N is the name of this pin in the datasheet of the QCA chip,
not on the board, so this name is the same regardless of what you name
the line or gpio your board connect it to.

> A new board should not require driver changes, you just ship a new DT
> for that board and an existing driver hopefully just does the job. No
> matter how someone named a GPIO in a piece of paper.
> 

I totally agree with the fact that the board should not affect the
naming of the gpio in the driver. But I do enjoy when we refer to pins
by their real name - instead of having to guess which pin in the _chip_
specification the driver actually refer to.


That said, what name would you prefer for this?

Afaict this is not "wakeup" and there are a few extra steps between the
disabled state and "bluetooth is enabled", so "enable" feels slightly
wrong. And it probably should be "bluetooth" and not just "device" as
this refers to a pin on a WiFi/BT combo chip.

Regards,
Bjorn
