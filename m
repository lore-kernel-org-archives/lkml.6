Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0B0160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE43A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUJdHtd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE43A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeG3QlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:41:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33305 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeG3QlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:41:16 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so9580369itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KUkF0/5t4CdQswjLeDP3WROEaQupKWeUyYiJv8VBkPk=;
        b=KUJdHtd6nKRCMjZJbNvEBCC+cJ3O1y9ihJ/CCPV1T7IUZkParvJynodZ3c00BbxsO/
         nPfrCYvjQgpR6sfOQdULAwS63eMPGmaDmxeuCm4f5ba1EL3B6U34Z/X9nuxxDq/hO/G3
         m0VS/LKqQGbG9OxbzYMdWTSCsBq6GSZ6yYdwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KUkF0/5t4CdQswjLeDP3WROEaQupKWeUyYiJv8VBkPk=;
        b=krO+TjFHWX8r9V+Wf21kRb+lrqsxlhe+QCkrO1r7PXsmeAA6QM9yg5FQ6ufy71ZhaC
         TKlFBMzDF4gQGktxB5x7buW4Fa+LEUSf6w1ZpzpC8QxcQ09YqhOQNsM5RxY4zxiRPW2X
         XtETFuNHaNcPMi8bCIigQThHwn5+qe5inIXH/G8R/iKUzT1zV/e6HdxxakrJpmSwQWiB
         05qXmv1VSjjpt5KacVRdevyJZ3zjxC+FCnt98tqS9ZLJVI7fx/1LYREPWlucEJQTIM94
         h11FsJ/thV3K8XIBewNm7WltU4cSSrlezJ0habc90853uJ6U8ESKAt3VuRxJMyLR0hsb
         2oWw==
X-Gm-Message-State: AOUpUlEBgViQgmIO8gWuJ9efVUmkQw/MMXctfSqegpKKt2kxWxw8Mn2y
        kjeMh6x3flKycijR4O4hbTG7nwyd2xbBXb/jvldHCQ==
X-Google-Smtp-Source: AAOMgpd/q8+JT89Ol5o1hDEWEftfgXP44Ax0SqA2ckICQvI07WkCe6pIid9L0ndBfcFKcJOXROXRkG09Pzne+oBfncY=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr15758112itc.102.1532963151879;
 Mon, 30 Jul 2018 08:05:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:05:51
 -0700 (PDT)
In-Reply-To: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:05:51 +0200
Message-ID: <CAPDyKFpxP67XttkJxTKdwBSYiJePdw_1icwCVZWBwD5WJ5XBVA@mail.gmail.com>
Subject: Re: [PATCH V7 1/5] mmc: sdhci: Add support for O2 eMMC HS200 mode
To:     "ernest.zhang" <ernest.zhang@bayhubtech.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com,
        chevron.li@bayhubtech.com,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 July 2018 at 08:26, ernest.zhang <ernest.zhang@bayhubtech.com> wrote:
> When use eMMC as boot device, the eMMC signaling voltage is tied to 1.8v
> fixed output voltage, bios can set o2 sd host controller PCI configuration
> register 0x308 bit4 to 1 to let driver skip 3.3v signaling voltage and
> direct use 1.8v singling voltage in eMMC initialize process.
>
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>

Thanks, the series applied for next!

Kind regards
Uffe

> ---
> Changes in V7:
>         Move V6 change item 2 to a seperate patch file
>
> Changes in V6:
>         1.Move change log to correct place.
>         2.Change HS200 mode clock frequency from 208MHz to 200MHz to meet
>         Specification.
>
> Changes in V5:
>         Modify code format to pass checkpatch.pl check and add a summary
>         of what has changed in each version.
>
> Changes in V4:
>         Skip SDIO and SD initalization when register 0x308 bit 4 is set,
>         and modify some typo.
>
> Changes in V3:
>         Rebase the patch on the mmc tree 'next' branch.
>
> Changes in V2:
>         Modify code format, and delete unused code path.
>
> Changes in V1:
>         Check PCIe register 0x308 bit 4 and skip eMMC 3.3v initialization
>         process if it is set to 1.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 555970a29c94..ba59db6a126c 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -3,6 +3,7 @@
>   *
>   * Authors: Peter Guo <peter.guo@bayhubtech.com>
>   *          Adam Lee <adam.lee@canonical.com>
> + *          Ernest Zhang <ernest.zhang@bayhubtech.com>
>   *
>   * This software is licensed under the terms of the GNU General Public
>   * License version 2, as published by the Free Software Foundation, and
> @@ -39,6 +40,7 @@
>  #define O2_SD_MISC_CTRL4       0xFC
>  #define O2_SD_TUNING_CTRL      0x300
>  #define O2_SD_PLL_SETTING      0x304
> +#define O2_SD_MISC_SETTING     0x308
>  #define O2_SD_CLK_SETTING      0x328
>  #define O2_SD_CAP_REG2         0x330
>  #define O2_SD_CAP_REG0         0x334
> @@ -184,6 +186,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>         struct sdhci_pci_chip *chip;
>         struct sdhci_host *host;
>         u32 reg;
> +       int ret;
>
>         chip = slot->chip;
>         host = slot->host;
> @@ -197,6 +200,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>                 if (reg & 0x1)
>                         host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>
> +               if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
> +                       ret = pci_read_config_dword(chip->pdev,
> +                                                   O2_SD_MISC_SETTING, &reg);
> +                       if (ret)
> +                               return -EIO;
> +                       if (reg & (1 << 4)) {
> +                               pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
> +                                       mmc_hostname(host->mmc));
> +                               host->flags &= ~SDHCI_SIGNALING_330;
> +                               host->flags |= SDHCI_SIGNALING_180;
> +                               host->mmc->caps2 |= MMC_CAP2_NO_SD;
> +                               host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +                       }
> +               }
> +
>                 if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
>                         break;
>                 /* set dll watch dog timer */
> --
> 2.17.1
>
