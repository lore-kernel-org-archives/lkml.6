Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90334C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4119921536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ishz9JFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4119921536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeI0GFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:05:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38811 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeI0GFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:05:03 -0400
Received: by mail-it1-f193.google.com with SMTP id p129-v6so5346111ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ImcPsoj/C8Cvcsp4Zjw/V/2COKZLUUm9nf7B5SRT/ZM=;
        b=Ishz9JFh+C5Yq8y0gU/7lJche2z6w2/iX1DCY2pwGamPJ+J/HDhYZwm8NZjt/lMmvG
         51YWS4vnG/u9TJx8t5JYDrcofuJ2fPYJjiYZjkHNdoxoAuZylm/oDP1qzy+FbObo++nC
         fLDEAuw0P96HYEhJtjODX+xf6oSnBMFmhVGC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ImcPsoj/C8Cvcsp4Zjw/V/2COKZLUUm9nf7B5SRT/ZM=;
        b=UGontlxdmAyG0ISeFjyCK6IAn6ctGD6uWn+CvXnysf5dtwDoo3XwfYG4wTuQocxSOX
         DFzmz6F+0VPEMV4xCwte79vv8SL0q5p/4WE7AwOKm2d1KgbC+rcX3pseehvZEl0q2jYs
         Xmdc9ttm+zNQI3frdaHzqIEH35kBAtHLHUAzBCZmTBKttpJbhLzx4vCtyJMJ9yu5qW9I
         ZRrwW8NG7gNV3OytrioT7nriV2AFNwGv62fciDmSfoCX63vXptIRqwsAfmP4uPfxsamp
         CwvpuKaT8NUruSfFNnOhg3rW4WqCQRQ55XnCj4aoiSYq20o5JPBLOZc3n5yr4E87Q+B4
         ep3A==
X-Gm-Message-State: ABuFfoj4QOD3oI2/mDdNtYhIg9++lXws/uoV6qnySW5e/e7RxT3BFW+N
        KnZllWXoR8s9ZaOMXB4lNnUsW9WJ9dE5Mhlj0Pe/mw==
X-Google-Smtp-Source: ACcGV63vEBYIPQ6dmJWQbuz3ZHm6tOWJD/K2+BP2BPEGzHhWIuFA4yR3PjDGYlxp96+XoGb40K1ySCNG3Mp2kK8jEvw=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr7011410ita.64.1538005778894;
 Wed, 26 Sep 2018 16:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 16:48:58
 -0700 (PDT)
In-Reply-To: <20180923203924.68452-1-yuzhao@google.com>
References: <20180923203924.68452-1-yuzhao@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Sep 2018 01:48:58 +0200
Message-ID: <CAPDyKFqiUO-7O6bgrszuR3YKMkEoPT4976gvDKvUWpYuNp03ag@mail.gmail.com>
Subject: Re: [PATCH] mmc: add quirk for O2 Micro dev 0x8620 rev 0x01
To:     Yu Zhao <yuzhao@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 September 2018 at 22:39, Yu Zhao <yuzhao@google.com> wrote:
> This device reports SDHCI_CLOCK_INT_STABLE even though it's not
> ready to take SDHCI_CLOCK_CARD_EN. The symptom is that reading
> SDHCI_CLOCK_CONTROL after enabling the clock shows absence of the
> bit from the register (e.g. expecting 0x0000fa07 = 0x0000fa03 |
> SDHCI_CLOCK_CARD_EN but only observed the first operand).
>
> mmc1: Timeout waiting for hardware cmd interrupt.
> mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
> mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> mmc1: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000001
> mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
> mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> mmc1: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
> mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
> mmc1: sdhci: Cmd:       0x00000000 | Max curr: 0x005800c8
> mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> mmc1: sdhci: Host ctl2: 0x00000008
> mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> mmc1: sdhci: ============================================
>
> The problem happens during wakeup from S3. Adding a delay quirk
> after power up reliably fixes the problem.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 77e9bc4aaee9..3e5ecf7ce101 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -490,6 +490,8 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>                 break;
>         case PCI_DEVICE_ID_O2_SEABIRD0:
> +               if (chip->pdev->revision == 0x01)
> +                       chip->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>         case PCI_DEVICE_ID_O2_SEABIRD1:
>                 /* UnLock WP */
>                 ret = pci_read_config_byte(chip->pdev,
> --
> 2.19.0.444.g18242da7ef-goog
>
