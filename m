Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbeBMPdU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933451AbeBMPdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:33:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8525A217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x226tHzKV+omAV9Sec3WBDF167+c0S1uMDPb9zHiC/5uTEMmf7vWI91H5mDNhoRQ22VqWWLk4KPt7oiQKgfpBJf0=
MIME-Version: 1.0
In-Reply-To: <20171214165352.27902-1-malat@debian.org>
References: <20171214165352.27902-1-malat@debian.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 13 Feb 2018 09:32:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyv5io+iXWnzmUhZ1r=PBnA=MdZet8idJDmL8XphxThA@mail.gmail.com>
Message-ID: <CAL_JsqLyv5io+iXWnzmUhZ1r=PBnA=MdZet8idJDmL8XphxThA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: Remove leading 0x and 0s from bindings notation
To: Mathieu Malaterre <malat@debian.org>,
        ARM-SoC Maintainers <arm@kernel.org>
Cc: Wei Xu <xuwei5@hisilicon.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2017 at 10:53 AM, Mathieu Malaterre <malat@debian.org> wrote:
> Improve the DTS files by removing all the leading "0x" and zeros to fix the
> following dtc warnings:
>
> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
>
> and
>
> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
>
> Converted using the following command:
>
> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -E -i -e "s/@0x([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" -e "s/@0+([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" {} +
>
> For simplicity, two sed expressions were used to solve each warnings separately.
>
> To make the regex expression more robust a few other issues were resolved,
> namely setting unit-address to lower case, and adding a whitespace before the
> the opening curly brace:
>
> https://elinux.org/Device_Tree_Linux#Linux_conventions
>
> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
>
> Reported-by: David Daney <ddaney@caviumnetworks.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 +-
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi       | 2 +-
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi   | 6 +++---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi          | 6 +++---
>  4 files changed, 8 insertions(+), 8 deletions(-)

Arnd, Olof, Looks like this got missed. Can you pick up for 4.16.

There's some arm32 ones too, but most of them need to be respun to
mention upper to lower case fixes.

Rob
