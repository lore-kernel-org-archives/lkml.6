Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeFBNsz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 09:48:55 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37424 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeFBNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 09:48:53 -0400
X-Google-Smtp-Source: ADUXVKLRI18RT4TLCEL3CPu03OPeQ+tHuI516pxYE4gmOBh7T2zdJOD7F3gOQNL3S//zekbmGLJVYPDjDmsIU4tO+fY=
MIME-Version: 1.0
In-Reply-To: <1439344955.9677.1526991935718@email.1und1.de>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com> <1439344955.9677.1526991935718@email.1und1.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 2 Jun 2018 10:48:52 -0300
Message-ID: <CAOMZO5BVhjwGpJ22qBihKcjWyvBkzNPU0cNtNY9HToLLEkYByA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>, Anson Huang <Anson.Huang@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Tue, May 22, 2018 at 9:25 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

>> --- a/include/dt-bindings/clock/imx6ul-clock.h
>> +++ b/include/dt-bindings/clock/imx6ul-clock.h
>> @@ -242,20 +242,25 @@
>>  #define IMX6UL_CLK_CKO2_PODF         229
>>  #define IMX6UL_CLK_CKO2                      230
>>  #define IMX6UL_CLK_CKO                       231
>> +#define IMX6UL_CLK_GPIO1             232
>> +#define IMX6UL_CLK_GPIO2             233
>> +#define IMX6UL_CLK_GPIO3             234
>> +#define IMX6UL_CLK_GPIO4             235
>> +#define IMX6UL_CLK_GPIO5             236
>
> this change looks like a breakage of devicetree ABI. You are changing the mean of the existing clock IDs on i.MX6ULL, which probably regress the combination of older DTBs with newer kernel.

Good point! I will send a fix for f5a4670de96678 ("clk: imx: Add new
clo01 and clo2 controlled
by CCOSR") which did the same reordering.

Thanks
