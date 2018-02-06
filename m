Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeBFUgd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753050AbeBFUgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:36:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFE321788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x225T91SQk2tCdJlyIfTUpWkq4O7GYhCsrEkgS0+u7wKaIVGWGb1+Lils0Ye1qtCktu3j7u/ApedXxTo/GbfV/qA=
MIME-Version: 1.0
In-Reply-To: <20180126221808.GE28313@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org> <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Feb 2018 14:36:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKEgYLMEbSj37rNV-Zu+vd7pEPQJm4pD3zP8atZBR03aw@mail.gmail.com>
Message-ID: <CAL_JsqKEgYLMEbSj37rNV-Zu+vd7pEPQJm4pD3zP8atZBR03aw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 4:18 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
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

FYI, there's a pending dtc change to allow deleting unreferenced nodes
which can solve the bloat problem.

Rob
