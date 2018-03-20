Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbeCTQhc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:37:32 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:43927 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:37:29 -0400
X-Google-Smtp-Source: AG47ELtfnvnKZg+miR/OsdfFM8vZsORKlNswP/dx2ZKiScfPomddkMCzt2uroA30X1NXglRaOvUpdw==
MIME-Version: 1.0
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
 <1521193500-4696-5-git-send-email-mgautam@codeaurora.org> <CAE=gft6yM58dru2DnjASbi+YG_KanDbBhO2nCLBerZw4NjT-=g@mail.gmail.com>
 <5db561b9-0c39-14d3-f924-9e5db75f6600@codeaurora.org>
In-Reply-To: <5db561b9-0c39-14d3-f924-9e5db75f6600@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 20 Mar 2018 16:36:51 +0000
X-Gmail-Original-Message-ID: <CAE=gft7gsj8yKMw2mX7Tw_0pH8vwr-UmtqjyUXnHXr8YFBi_Og@mail.gmail.com>
Message-ID: <CAE=gft7gsj8yKMw2mX7Tw_0pH8vwr-UmtqjyUXnHXr8YFBi_Og@mail.gmail.com>
Subject: Re: [PATCH 4/6] phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for sdm845
To: Manu Gautam <mgautam@codeaurora.org>
Cc: kishon@ti.com, linux-arm-msm@vger.kernel.org,
        vivek.gautam@codeaurora.org, varada@codeaurora.org,
        weiyongjun1@huawei.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 12:00 AM Manu Gautam <mgautam@codeaurora.org> wrote:

> Hi,


> On 3/19/2018 11:21 PM, Evan Green wrote:
> > Hi Manu,
> >
> > On Fri, Mar 16, 2018 at 2:46 AM Manu Gautam <mgautam@codeaurora.org>
wrote:
> [snip]
> >> index d1c6905..5d78d43 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
> >> @@ -214,6 +214,8 @@
> >>   #define QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN            0x030
> >>   #define QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE    0x034
> >>   #define QSERDES_V3_RX_RX_TERM_BW                       0x07c
> >> +#define QSERDES_V3_RX_VGA_CAL_CNTRL1                   0x0bc
> > I noticed you add this definition, but never use it. Are you missing a
> > QMP_PHY_INIT_CFG line for this register in qmp_v3_usb3_uniphy_rx_tbl[],
or
> > is that register "don't care"? It looks important, and while its default
> > value out of reset might be valid, you never know what nutty value boot
> > firmware might set it to.
> >

> Yes POR value of this register is valid for this soc.
> QMP driver resets (asserts and de-asserts reset_control) in probe. So,
that should
> ensure that PHY registers are indeed set to POR value. Left the
definition there
> if different setting needed to be done for a different variant of h/w in
future.

Sounds good. Thanks, Manu.

Reviewed-by: Evan Green <evgreen@chromium.org>
