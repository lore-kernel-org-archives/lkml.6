Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeBSJ5e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:57:34 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:47021 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeBSJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:57:32 -0500
X-Google-Smtp-Source: AH8x226dfW8bn8Sted7H6cy31n9JczFnUOAbBUZdbZvD7l4V1tgZlUpMTtugyiOsQRinoWC22Uh6Lc1YXyEcocWTF20=
MIME-Version: 1.0
In-Reply-To: <20180213101412.5717-3-liwei213@huawei.com>
References: <20180213101412.5717-1-liwei213@huawei.com> <20180213101412.5717-3-liwei213@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Feb 2018 10:57:30 +0100
X-Google-Sender-Auth: RNNxwvkRaL32D878LitCzPWH5eU
Message-ID: <CAK8P3a2b3rLHyM+vMppCkAR3VYbhw-b0LpuWfLCqjs7z9n+hyw@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] dt-bindings: scsi: ufs: add document for hisi-ufs
To: Li Wei <liwei213@huawei.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
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
        linux-scsi <linux-scsi@vger.kernel.org>, zangleigang@hisilicon.com,
        gengjianfeng@hisilicon.com, Guodong Xu <guodong.xu@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Fengbaopeng (kevin, Kirin Solution Dept)"
        <fengbaopeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 11:14 AM, Li Wei <liwei213@huawei.com> wrote:
> add ufs node document for Hisilicon.
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt


I'm pretty sure we've discussed it before, but can you make this so that
the generic properties are part of the ufshcd binding, and you refer to it
from here, only describing in what ways the hisi ufs binding differs from
the standard?

> diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> new file mode 100644
> index 000000000000..0d21b57496cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> @@ -0,0 +1,37 @@
> +* Hisilicon Universal Flash Storage (UFS) Host Controller
> +
> +UFS nodes are defined to describe on-chip UFS hardware macro.
> +Each UFS Host Controller should have its own node.
> +
> +Required properties:
> +- compatible        : compatible list, contains one of the following -
> +                                       "hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
> +                                       host controller present on Hi36xx chipset.
> +- reg               : should contain UFS register address space & UFS SYS CTRL register address,
> +- interrupt-parent  : interrupt device
> +- interrupts        : interrupt number
> +- clocks               : List of phandle and clock specifier pairs
> +- clock-names       : List of clock input name strings sorted in the same
> +                                       order as the clocks property. "ref_clk", "phy_clk" is optional

The clock names sound generic enough, should we have both in the
generic binding?

> +- resets            : reset node register, one reset the clk and the other reset the controller
> +- reset-names       : describe reset node register

This looks incomplete. What is the name of the reset line supposed to be?
I'd also suggest you document it in the ufshcd binding instead.

      Arnd
