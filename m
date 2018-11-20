Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48641C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6E220671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDLVCs0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6E220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeKTT6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:58:44 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56000 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeKTT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:58:43 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so2335734itg.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pjRZ0FxO3QXbv2zYC/8xWUIkc6CGCIT/aoU9vJaW2gI=;
        b=HDLVCs0nt9q2lmhKUjmAT/A/0mU1Nbdv1Q/DdD0MeMvdAN0rxzKwUVALRFdADG+wqF
         oUFZ28qf3or9HJkJvGei98jXrmuCd1pIM8J7L6v/XGB3eRklR3ZRdPgxmo6p8QBBrbC3
         9t5Wbe5z9hZwZdEHLL1QdaJHLuBgTUGiBWuXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pjRZ0FxO3QXbv2zYC/8xWUIkc6CGCIT/aoU9vJaW2gI=;
        b=iEGwQN76kF1LgiHYNuMtzsVt/cae26XXjI9J2qLPBGXomgL5s8V5fEgHCp5PcuAXZi
         zOA2AIY48umAzYnxthkZK5183V7lRrhlEt6/ZnXtF+BGFSOXCpJrnYmzBMSkfBYQfqqa
         p5U6bGozSbhq/Yj3QRY9bhhQ6/LD4/UiZ6+vria5keoVDQ1RmT3K7+FLu2p2oFdLlU7E
         BCM2SoD7z3OADcOFTW8NSRfUItDD2lPDNYVZOpSY3vkMNb8Kh0dg6yPwIcSMWoKKmR1d
         lASpNdo+0Jtdnbuczu90SJd0t9HlTMKcm6zo5dMM+pCVoJ2mjy4J8bbxxqk6slm3wSOy
         Ox+g==
X-Gm-Message-State: AGRZ1gIEt2dOINCTwMEvZCtJ+jINoCFIjemZ4XoR7EmoOifoyB9Lhx2+
        lw5pB6juO9OEugu23dAOt8/xK+VxBCXI0t2nR4qKCQ==
X-Google-Smtp-Source: AJdET5cqJgPjwUCB1WycbORzmqYOnmTvsQCPF04nIL/PTqnlqPzhjACwBsm3DpzJlfwEhBDTBushXppkvBFHybpLl2E=
X-Received: by 2002:a24:d4:: with SMTP id 203-v6mr1452646ita.26.1542706233287;
 Tue, 20 Nov 2018 01:30:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 01:29:52
 -0800 (PST)
In-Reply-To: <1542005537-19154-1-git-send-email-vbadigan@codeaurora.org>
References: <1542005537-19154-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Nov 2018 10:29:52 +0100
Message-ID: <CAPDyKFq++isoJv75q+6uwrHwZSRJQ=WmxVihm1mKucJKB3Qzbg@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] Re-initialize DLL when MCLK is gated dynamically
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@google.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 November 2018 at 07:52, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
> On few SDHCI-MSM controllers, the host controller's clock tuning
> circuit may go out of sync if controller clocks are gated which
> eventually, result in data CRC and command CRC/timeout errors.
> To fix this issue, the DLL needs to be re-initialized and restored with
> its old settings once clocks are ungated. SDHC cotroller on SDM845 SOC
> has this limitation.
>
> Changes since V4:
>         - Exactly same as V3, posted multiple mails for V4.
>         So to avoid confusion updating it as V5.
>
> Changes since V3:
>         - Introduced SoC specific dt compatible string for sdhci-msm
>         controller
>         - Moved the condition which checks whether tuning is needed or
>         not, to a common function.
>
> Changes since V2:
>         - Removed an unused variable.
>         - Renamed the newly introduced flags to be more meaningful.
>         - Added new dt compatible string for SDM845 SOC.
>
> Changes since V1:
>         - Replaced dt flag with a dt compatible string to
>         indicate SHDCI-MSM controller varients which need this fix.
>         - Moved the DLL settings restoration logic from request
>         context to platform driver runtime pm context.
>
> Tested on: sdm845
> Veerabhadrarao Badiganti (2):
>   dt-bindings: mmc: sdhci-msm: Add SoC-specific compatible strings
>   mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt          | 21 ++++--
>  drivers/mmc/host/sdhci-msm.c                       | 78 +++++++++++++++++++---
>  2 files changed, 84 insertions(+), 15 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
