Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeCZKlq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:41:46 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:45692 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeCZKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:41:41 -0400
X-Google-Smtp-Source: AIpwx4853zURODhU6rQPxKQINNgjpbbhWwCbgbscPA+qPEJiEs2PzR5N1qzS2LrsUQHtenwiRL8CAM7jes2d7gP/Qds=
MIME-Version: 1.0
In-Reply-To: <1699CE87DE933F49876AD744B5DC140FA58798@DGGEMM506-MBS.china.huawei.com>
References: <20180213101412.5717-1-liwei213@huawei.com> <20180213101412.5717-3-liwei213@huawei.com>
 <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
 <1699CE87DE933F49876AD744B5DC140FA584ED@DGGEMM506-MBS.china.huawei.com>
 <CAK8P3a3NdHLDf2vOMyZ1qcWNW1Jg5T47qR0qWhWEeDn+90S4ug@mail.gmail.com> <1699CE87DE933F49876AD744B5DC140FA58798@DGGEMM506-MBS.china.huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 12:41:40 +0200
X-Google-Sender-Auth: aSMTeOhfxv9iy8DglR9wB3HWyns
Message-ID: <CAK8P3a29sDaEj=iTkru-3mc9NpjNvZos3Z+h5UsT1cAeULoGHw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0ggdjggMi81XSBkdC1iaW5kaW5nczogc2NzaQ==?=
        =?UTF-8?B?OiB1ZnM6IGFkZCBkb2N1bWVudCBmb3IgaGlzaS11ZnM=?=
To: "liwei (CM)" <liwei213@huawei.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "xuwei (O)" <xuwei5@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Riku Voipio <riku.voipio@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Eric Anholt <eric@anholt.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        zangleigang <zangleigang@hisilicon.com>,
        Gengjianfeng <gengjianfeng@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Fengbaopeng (kevin, Kirin Solution Dept)"
        <fengbaopeng@hisilicon.com>,
        Yaniv Gardi <ygardi@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2QAfqYA022491

On Mon, Mar 26, 2018 at 12:26 PM, liwei (CM) <liwei213@huawei.com> wrote:
> 发件人: arndbergmann@gmail.com [mailto:arndbergmann@gmail.com] 代表 Arnd Bergmann
> > 主题: Re: 答复: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs
> > On Fri, Mar 23, 2018 at 3:22 AM, liwei (CM) <liwei213@huawei.com> wrote:
> >> The clock names sound generic enough, should we have both in the generic binding?
> >>
> >> Do you mean that add a "phy_clk" to ufshcd-pltfrm 's bindings?
> >> At present, it seems that in the implementation of generic code, apart
> >> from "ref_clk" may have special processing, other clk will not have special processing and
> >> simply parse and enable; Referring to ufs-qcom binding, I think "phy_clk" can be named
> >> "iface_clk", this "iface_clk" exists in ufshcd-pltfrm bindings;If so, "ref_clk", "iface_clk" are
> >> both in the generic binding,we will remove them here. Is that okay?
>
> > I'm looking at the generic binding again, and it seems we never quite managed to fix some
> > minor problems with it. See below for a possible way to clarify it.
>
> phy_clk is actually given to the phy. But as previously mentioned , we do not have a
> separate phy to configure ; The clks in the patch you give appear to be unsuitable for
> describing this .
> Here we can't describe phy_clk in the node "ufsphy1: ufsphy@fc597000" like qcom.
> So can we put it here in our own binding like this?

I think the concept of having a phy clk is generic enough that it's
better to have
that in the common part, others will surely have the same thing, and
in this case,
qcom would be the exception that does not use one.

There are apparently a couple of things related to the phy that may or may not
require a clk:

- ref_clk: The reference clock on the mipi bus, this is what qcom
have, this would
  be the 19.2 MHz clock signal.
- one clock to drive the logic block for the PHY itself, if it is
included within
  the same logical portion of an SoC as the ufshcd, but uses a separate clock.
- Looking at the Android kernel as distributed by google/qualcomm, they have
  four separate clocks described as

    PHY to controller symbol synchronization clocks:
        "rx_lane0_sync_clk" - RX Lane 0
        "rx_lane1_sync_clk" - RX Lane 1
        "tx_lane0_sync_clk" - TX Lane 0
        "tx_lane1_sync_clk" - TX Lane 1

Which of the above would your phy_clk refer to?

       Arnd

[1] https://android.googlesource.com/kernel/msm/+/android-msm-bullhead-3.10-marshmallow-dr/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt?autodive=0%2F%2F%2F%2F%2F
