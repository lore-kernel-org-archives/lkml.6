Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7179DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3B420833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmAAeXvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3B420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbeIRUec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:34:32 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36559 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbeIRUeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:34:31 -0400
Received: by mail-ua1-f68.google.com with SMTP id c12-v6so1041513uan.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bT+Al7guonHNoJYaJS4t0/s/SL2mKF9hxIlk0OZuBiY=;
        b=YmAAeXvLkr1L7h5fTPmCx7VXC6o5j/M2fyWGofko8aBFhO6lGYffpIH7RKqpEanV/7
         pfUEVnljp86vcBz0AzIo/Xea5QiPlI+dzCckiFnuYHpOIZ2D4RkTvIIsAC54R5MJFqY+
         DXLQ/S2mpKV2qNgmOtX+hA4Q4F6lKWn4pPl8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bT+Al7guonHNoJYaJS4t0/s/SL2mKF9hxIlk0OZuBiY=;
        b=Ht0dBtbxGVa7Bjhzg1QNaAz1Vkredj8jv9HKwZDSWNGsg8W8BqFhk9Kcnl933jgFJJ
         RuBEjfZKC/zj6fNZuVC9TdaGJtDp0L39cJwyui5IQ8iEKe/LmiESaTm+dzmMMeuu4F3C
         hB9mRj6RLPbFG3n10BNrxM55crsEqrbO8ws2Pt5t5Fhy3xNkUUJaxpR8VZ+qIBENzXZY
         6B0qkkk/5cpTBfatwCwbo4b4TDZUz1sQskl0MOM2zbDjOHxR44U0cDfeNFZrJfN2G5mW
         wBPTUC1At4tPmgF33dO1hVRspzUSiWbLtssF5volQfERtg1k5UysWL2Ltv7stZd9MDSz
         dvtg==
X-Gm-Message-State: APzg51AtBIrGBMhndvfCvWQKJW22tO8ncSeELa6fXrzn2h6vAzgb/w4y
        lxGkns7gEa6U18Fs8Aqxvn2tjlpw8tJC9pIuwCuPR8byaGY=
X-Google-Smtp-Source: ANB0VdZ03/rVb5BFkzaLDT8S5DE8sx/86HYyuh1VHp/H/0lrp5gkSpSkXCx7DtH3mz/u7I2+Buq7GwFqfjPgBT8ZDbQ=
X-Received: by 2002:ab0:3e9:: with SMTP id 96-v6mr9023569uau.40.1537282891704;
 Tue, 18 Sep 2018 08:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 18 Sep 2018 08:01:20 -0700
Message-ID: <CAHLCerMknG771sdXwPkU4RUg33nuSCNx2HA+1LHmbz_SkzD5Pg@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Another round of tsens cleanups
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo, Andy,

On Wed, Sep 12, 2018 at 2:53 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> This is another series of tsens cleanups before we add interrupt support. This applies on top of 4.19-rc2.
>
> Patches [1-6] can directly be applied by Eduardo.
> Patches [9-16] can directly be applied by Andy.
> Patches [7-8] introduce a new check and needs review and can then be
> applied completely separately by Eduardo.
>
> There is a *dependency* however. Patch 1 should be applied to the tree
> before the DT changes in patches 9 and 10.

To clarify here, it might be easier if Eduardo acks patches 9 and 10
so that they can be merged through Andy's tree before the rest of the
DT patches. That would remove the need to create any immutable trees
or having to worry about the ordering of the patches.

Just a suggestion.

> In this series, I've collected all outstanding tsens patches by combining
> the patches from the v2 posting with 3 DT patches for sdm845 thermal zones
> and msm8916 camera and gpu thermal zones. Details are as follows:
>
> - splitup 8916 and 8974 register address spaces for SROT and TM
> - cleanups: move to spdx, dead code removal, removal of id field
> - Add support to map the SROT address space for DTs that list it separately
> - Check if TSENS IP is enabled in firmware by querying the SROT space
> - Add myself as maintainer of tsens
> - Add one-off patches adding sdm845 thermal zones and msm8916 gpu and
>   camera thermal zones to this series.
>
> Changes since v2:
> - Split up changes to code and dt and within dt, split into arm and arm64
>   patches
> - Rearrange the sequence of patches so that the thermal maintainer can pick
>   up the first part and the platform maintainer can pick up the latter part
>   of the series
> - Drop patch 09/11 because it causes some issues on systems with
>   non-contiguous enabled sensors e.g. db410c
> - Drop patch 10/11 because reg-name property isn't encouraged
> - Fix a bug on msm8916 to check if IP is enabled in firmware. This was due
>   to the register being at a different offset on msm8916. Fixed by coding
>   this information as private data.
>
> Changes since v1:
> - Split up changes that split the address space and added qcom,sensors
>   property into two separate patches
> - Remove brackets in typo correction patch
>
> Amit Kucheria (16):
>   thermal: tsens: Prepare 8916 and 8974 tsens to use SROT and TM address
>     space
>   thermal: tsens: Add SPDX license identifiers
>   thermal: tsens: Get rid of dead code
>   thermal: tsens: Rename map field in order to add a second address map
>   thermal: tsens: Add the SROT address map
>   MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers
>   thermal: tsens: Pass register offsets as private data
>   thermal: tsens: Check if the IP is correctly enabled by firmware
>   arm: dts: msm8974: thermal: split address space into two
>   arm64: dts: msm8916: thermal: split address space into two
>   arm: dts: msm8974: thermal: Add "qcom,sensors" property
>   arm64: dts: msm8916: thermal: Add "qcom,sensors" property
>   dt-bindings: thermal: Fix a typo in documentation
>   arm64: dts: msm8916: Add gpu thermal zone
>   arm64: dts: msm8916: Add camera thermal zone
>   arm64: dts: sdm845: enable tsens thermal zones
>
>  .../devicetree/bindings/thermal/thermal.txt   |   2 +-
>  MAINTAINERS                                   |   7 +
>  arch/arm/boot/dts/qcom-msm8974.dtsi           |   6 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  47 ++++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 170 ++++++++++++++++++
>  drivers/thermal/qcom/tsens-8916.c             |  12 +-
>  drivers/thermal/qcom/tsens-8960.c             |  41 ++---
>  drivers/thermal/qcom/tsens-8974.c             |  12 +-
>  drivers/thermal/qcom/tsens-common.c           |  62 ++++---
>  drivers/thermal/qcom/tsens-v2.c               |   8 +-
>  drivers/thermal/qcom/tsens.c                  |  19 +-
>  drivers/thermal/qcom/tsens.h                  |  23 +--
>  12 files changed, 309 insertions(+), 100 deletions(-)
>
> --
> 2.17.1
>
