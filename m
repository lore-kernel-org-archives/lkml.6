Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C023C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC75F214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Km9SyMDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC75F214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeHVNMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:12:23 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39867 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeHVNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:12:23 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so963299iok.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rDbfUJAH1z7xafdkIjuXRgk2G5RzlrMPkqNZIlmHivQ=;
        b=Km9SyMDjaqAvaI5qJNmXpL2XicUdFsedrK4WvBB6h0WjHoLvs/rPRqikXRPoFcysQw
         8YF9IFLwpdzunxmd2YorQapKR/g088rPRVekWrd2LHpLgqNUpsH2iCvtMhParMChBIkG
         XetPnvlT84Lt1/bKnGpNF5uq09OslMYMbE3Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rDbfUJAH1z7xafdkIjuXRgk2G5RzlrMPkqNZIlmHivQ=;
        b=eheWbuKO3Hmem/QQTg8pxouKzz7yH5BRiaKEbUIV04gQHtOQil/M4aVlLZYoqLdli2
         a2cGL8zZIvhEQUVq5s3KDCy9dazdGXC9m4rrNif9DtDw9Qp8vFJh2lsUCeOYnaCuyth2
         uVlw6EWkAv5yQC2sKj+m9i9dRqXvRQGGQneDcGLNTyKtgFoQ3LyqyNT5O5n7OYIMMPg0
         aub64Av6rZJOmlb6Sj/nOe4H34c1Xnd2I0hJA8wTPJgM4/WXrLoqBJTD+gyOtkGg+OTE
         R8aK+baTCqJzZBXe/Ds+v5U3JvkHszKAsy09uW4rYxwPCeKWn99SPulcZEVHk0HWAJJg
         K/Sw==
X-Gm-Message-State: APzg51DTdpn/6WNLlxewx0bz3MYuLUHsjohSUbGoe3knarqLm5BC2VGC
        Q9h8XUfmxFjPxVGt6sFgNA5BAah43Y5Ps1WVnlqJIg==
X-Google-Smtp-Source: ANB0VdYrth4FpH150apbQ86E9cSl0gFqea9DEcpx6Ttyfg1BWjDvAcqMcgbL58pGZr6GbnVhlM+zWfaz1LTstTNOZTQ=
X-Received: by 2002:a6b:e410:: with SMTP id u16-v6mr5598142iog.131.1534931294375;
 Wed, 22 Aug 2018 02:48:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 02:48:14
 -0700 (PDT)
In-Reply-To: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
References: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Aug 2018 11:48:14 +0200
Message-ID: <CAPDyKFq1u55-9WCXm_AJOqW=1_1ivg57Mgzp8D=ixAE2SAkpdg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add ACPI support to IPROC SDHCI
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        vikram.prakash@broadcom.com,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 August 2018 at 09:52, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> This patch series adds
>   - Feature to get generic device properties in the
>     place of DT properties.
>   - ACPI support to IPROC SDHCI varients
>
> This patch series is based off v4.18-rc3
>
> Changes from v3:
>   - Replaced separate device tree and ACPI get match data APIs
>     with single device_get_match_data API.
>
> Changes from v2:
>   - Added patch "Convert DT properties to generic device properties"
>     given by Adrian Hunter to this patch series because
>     "Add ACPI support to IPROC SDHCI" patch is depends on this.
>
> Changes from v1:
>   - Removed sdhci_iproc_data array change and add directly
>     into of and acpi id tables.
>   - Add a change to get match data directly.
>   - Removed clock-frequency property read change.
>   - Used sdhci_get_property to get properties.
>   - Verified with patch given by Adrian Hunter
>     mmc: sdhci-pltfm: Convert DT properties to generic device properties
>
> Adrian Hunter (1):
>   mmc: sdhci-pltfm: Convert DT properties to generic device properties
>
> Srinath Mannam (1):
>   mmc: host: iproc: Add ACPI support to IPROC SDHCI
>
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci-iproc.c | 59 ++++++++++++++++++++++++------------
>  drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
>  drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
>  4 files changed, 87 insertions(+), 48 deletions(-)
>
> --
> 2.7.4
>

Thanks, queued for v4.20!

Kind regards
Uffe
