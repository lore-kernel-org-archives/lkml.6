Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeCNSnE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:43:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49607 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeCNSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:42:59 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180314183043.GX18510@minitux>
Date: Wed, 14 Mar 2018 19:42:56 +0100
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
Content-Transfer-Encoding: 8BIT
Message-Id: <D999852D-E9A7-41D2-9878-A93CB4D43D0C@holtmann.org>
References: <20180314155514.3374-1-thierry.escande@linaro.org>
 <20180314155514.3374-3-thierry.escande@linaro.org>
 <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
 <20180314183043.GX18510@minitux>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjoern,

>>> +		bt-disable-n-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>> 
>> can we use a common name here. I think that Nokia and Broadcom drivers
>> define one. And if this is the enable/shutdown GPIO, we should name it
>> consistently across all manufacturers. It essentially does the same on
>> Bluetooth UART chips no matter what chip is behind them.
>> 
> 
> Broadcomm has a device-wakup-gpios and Nokia has bluetooth-wakup-gpios.
> It might be that these behave in the same way, but from the description
> they only trigger the wakeup.

that is something that we might need to start fixing. I really prefer if we name the GPIOs a bit more consistent.

> The reason for the proposed naming here is that the pin is named
> "BT_DISABLE_N" in the datasheet.

That is not a reason I buy. So the next board comes around that labels it in the data sheet BT_DISABLE_YEAH_SUPER_GREAT and you send me a patch to the driver to look for that name. If the GPIO does the same thing, I couldn’t care less what the data sheet says. That might be a comment in the DT file, but it should not pollute the driver code.

A new board should not require driver changes, you just ship a new DT for that board and an existing driver hopefully just does the job. No matter how someone named a GPIO in a piece of paper.

Regards

Marcel
