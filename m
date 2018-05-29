Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967876AbeE2XQw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 19:16:52 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37091 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964853AbeE2XQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 19:16:51 -0400
X-Google-Smtp-Source: ADUXVKJn9uqOOFXi2DM+X7jQtaPEcxN6kZlQmn3922RbPxPySQvSon91Lfq2PTiJwRjv6imHKM0mE2Lbxz3sBI38Pb0=
MIME-Version: 1.0
In-Reply-To: <0e0690c89b24b4b028e4a0dab63334af4b37fdd3.camel@nxp.com>
References: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com> <0e0690c89b24b4b028e4a0dab63334af4b37fdd3.camel@nxp.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 29 May 2018 16:16:49 -0700
Message-ID: <CAHQ1cqE9dpL3DB351UbjWvh+g=BG62NP31iqoOsPm_9_tKS0sQ@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpcv2: correct PGC offset
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Linux-imx@nxp.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Richard Liu <xuegang.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 7:02 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> On Tue, 2018-05-29 at 16:02 +0800, Anson Huang wrote:
>> Correct MIPI/PCIe/USB_HSIC's PGC offset based on
>> design RTL, the value on Reference Manual are incorrect.
>>
>> The correct offset should be as below:
>>
>> -#define PGC_MIPI                     4
>> -#define PGC_PCIE                     5
>> -#define PGC_USB_HSIC                 8
>> +#define PGC_MIPI                     16
>> +#define PGC_PCIE                     17
>> +#define PGC_USB_HSIC                 20
>>  #define GPC_PGC_CTRL(n)                      (0x800 + (n) * 0x40)
>>  #define GPC_PGC_SR(n)                        (GPC_PGC_CTRL(n) + 0xc)
>
> This gpcv2 driver is currently only used for PCI, it probably only
> works because domains happen to be turned on by default?
>

That'd be my guess as well. I just tried commenting all of the code
related to GPC_PGC_CTRL in gpcv2 drive and PCIe still worked on my
SabreSD board.

> On imx7d upstream platform suspend is not yet supported but even doing
> device-level suspend causes a hang on resume somewhere in PCI on first
> read. This patch fixes that immediate hang.
>
> After suspend/resume lspci is broken (device doesn't properly resume),
> that probably requires more imx pci patches and unrelated to pgc.
>

Yeah, suspend of any kind was not a part of the use-case for me when I
was working on this driver, so it's not surprising to hear that it
doesn't work very well.

Thanks,
Andrey Smirnov
