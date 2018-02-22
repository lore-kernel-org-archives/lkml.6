Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeBVQih (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:38:37 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36136 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933164AbeBVQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:38:35 -0500
X-Google-Smtp-Source: AH8x225C26WMXDsEIoa3JzM9E0WjwmmdQaobEnV3mg8AHXTnbHV7sAJajIq6HtckNm1tVcC6O7JztULQfu1bAW/18Lc=
MIME-Version: 1.0
In-Reply-To: <20171214165352.27902-1-malat@debian.org>
References: <20171214165352.27902-1-malat@debian.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:38:33 +0100
X-Google-Sender-Auth: jOJ4dpEeNc7burH3R1oZinS8fCk
Message-ID: <CAK8P3a1X3-kZ35aPLSn-rmHhCx2E+nBBj=57jeJtzgR5D6FrPQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: Remove leading 0x and 0s from bindings notation
To: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh+dt@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..."
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2017 at 5:53 PM, Mathieu Malaterre <malat@debian.org> wrote:
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

Applied to fixes, thanks!

       Arnd
