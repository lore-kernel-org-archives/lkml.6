Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C28ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344A12084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPShQutX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344A12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeGRThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:37:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37528 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbeGRThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:37:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id a19-v6so3898077wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xWUFkZ48aG/mxRnSo2WwwDnIW+wkkxqz1UbKj+U103Q=;
        b=hPShQutXapYfgHEFi8gMLQ6PbnLGnJqItYXMQXidGpHMAjFW7PN/UVewIzOVjVhokc
         NL7+CbRfOEXWwXfaUYlPZ2iiBvB8AkXhqYyleUVnMUKwUHGrVbbVwV924XmCvZtvjyaY
         DCAwIypjvcVGxeE8DzIQt3xIbTapcbGgf+wPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xWUFkZ48aG/mxRnSo2WwwDnIW+wkkxqz1UbKj+U103Q=;
        b=AvwVppOfftySO6TFtbpl++VLlNY5zfLHi8tS79IxsCWLtaSW2ie5zt1H68RX0pCbCX
         LFCb0sUFaVyE7C+ob+iuacqFY/ujdrrim20ogtOteWq3nOBNz1hLeOfw01kVNwvs5TGj
         Nkxe6223U7ZJXTnU9zMGJRkU1fy8rLrGLDHb1izyii4j9k/YcOa02ruyFoUkDkjvNQGp
         oT9YWjYRG1qSk0d3pYZhZgyLTToE4QaR606o/33tkJDghPhN3Y4lbBQGiDlpFDVc15iZ
         J6UU30ZolKkHF31d4LsPeZ4mnnOgHNz4ArZ9QE4KeutTEavPhTOZmZGb0Qv0Wx/V4aSw
         8vDg==
X-Gm-Message-State: AOUpUlEvExDotHszOCbd4zsLsAtRK7EnYg51x9/I5/KfYAx0rAEw/DUr
        IohMYZs0d7fL6fjnJ2E8HuHIazakVipuDsf/3FbtNA==
X-Google-Smtp-Source: AAOMgpfgrSuzPKOQakBhnn1iyTqldXMYPdf5rKtpYMkW5gVDh5G22aZn7Z7ya0Luzpf6X5pDsmUNFH937ubps5ogTik=
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr2254147wma.101.1531940287220;
 Wed, 18 Jul 2018 11:58:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 11:58:06
 -0700 (PDT)
In-Reply-To: <20180717093659.103263-1-liwei213@huawei.com>
References: <20180717093659.103263-1-liwei213@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 18 Jul 2018 11:58:06 -0700
Message-ID: <CALAqxLVgRCCPJhjdpqG9TejtdNzHbyasxBytObgrS5_LrQnTtw@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] [RESEND] scsi: ufs: add ufs driver code for
 Hisilicon Hi3660 SoC
To:     Li Wei <liwei213@huawei.com>, martin.petersen@oracle.com,
        Vinayak Holikatti <vinholikatti@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, jejb@linux.vnet.ibm.com,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        yamada.masahiro@socionext.com,
        Riku Voipio <riku.voipio@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-scsi@vger.kernel.org, zangleigang@hisilicon.com,
        gengjianfeng@hisilicon.com,
        "Sunzhaosheng Sun(Zhaosheng)" <sunzhaosheng@hisilicon.com>,
        Ian Rickards <ian.rickards@arm.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Feng Chen <puck.chen@hisilicon.com>,
        "Fengbaopeng (kevin, Kirin Solution Dept)" 
        <fengbaopeng@hisilicon.com>, Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 2:36 AM, Li Wei <liwei213@huawei.com> wrote:
> This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.
>
> Li Wei (4):
>   scsi: ufs: add Hisilicon ufs driver code
>   dt-bindings: scsi: ufs: add document for hisi-ufs
>   arm64: dts: add ufs dts node
>   arm64: defconfig: enable configs for Hisilicon ufs
>
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  41 ++
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  10 +-
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  18 +
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/scsi/ufs/Kconfig                           |   9 +
>  drivers/scsi/ufs/Makefile                          |   1 +
>  drivers/scsi/ufs/ufs-hisi.c                        | 619 +++++++++++++++++++++
>  drivers/scsi/ufs/ufs-hisi.h                        | 115 ++++
>  8 files changed, 811 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
>  create mode 100644 drivers/scsi/ufs/ufs-hisi.c
>  create mode 100644 drivers/scsi/ufs/ufs-hisi.h


Martin/Vinayak: Wanted to nudge either of you to see if you had any
further feedback or objections on this patchset? Its been a long slow
slog for this patch-set and getting it upstream will make the HiKey960
board much more useful for testing mainline kernels.

If you don't have objections, would you consider merging the scsi
driver and Acked dt-bindings via the scsi tree?   Including the dts
changes too if Wei Xu (now cc'ed) acks it, would be helpful as well
(but that can go separately later if necessary).

The defconfig change isn't as important, so I suspect can be re-pushed
through the ARM maintainers later.

thanks
-john
