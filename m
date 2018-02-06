Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeBFShY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:37:24 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42743 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbeBFShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:37:14 -0500
X-Google-Smtp-Source: AH8x227VlKH/6zdePOBN0KrxFYouvnnqls40w489opXV4C8s16+9rkVZWDefcZZ2KT4dhisKDhD8XxPO2M/l55ITn88=
MIME-Version: 1.0
In-Reply-To: <20180126221808.GE28313@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org> <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Feb 2018 10:37:12 -0800
X-Google-Sender-Auth: QJFpQkdOZaqEUx5CLjJlyGPdGyM
Message-ID: <CAD=FV=WcCnQJc25=sKWtOi=ZWi=ium6DVsexuQnsLDL=aJE6-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 26, 2018 at 2:18 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/25, Rajendra Nayak wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>> new file mode 100644
>> index 000000000000..b97f99e6f4b4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>> @@ -0,0 +1,32 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +&tlmm {
>
> I'm not the maintainer, but I find this approach to the pins
> really annoying. I have to flip to another file to figure out how
> a board has configured the pins. And we may bring in a bunch of
> settings that we don't ever use on some board too. Why can't we
> put the settings in the board file directly?

I'm not so familiar with how things work with Qualcomm, but in general
I think putting this in the "board" file is a bad idea.  I'd be OK
with putting this directly in the SoC file (though it might get
unwieldy?), but not moving things to the board file as was done with
v2 of this patch.

Said another way: nearly board that uses SDM845 that uses UART2 will
have the same definitions for these pins so we shouldn't be
duplicating it across every board, right?

I'll also respond to the v2 patch so it's obvious there is feedback there...

-Doug
