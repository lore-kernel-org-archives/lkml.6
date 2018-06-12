Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 70AE3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FB720693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRkAnC/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FB720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbeFLHr2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:47:28 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41129 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbeFLHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:47:26 -0400
Received: by mail-io0-f195.google.com with SMTP id t5-v6so26945750ioa.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 00:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sf9KP5zuJQrE8WSz2jvQolWUUUetxzF/z4fyltHeno8=;
        b=bRkAnC/SJ9ryV0/i46PXTrjtnvyVNuJfex8YrspoH9uEJB1WOgFmEBhm8MnRAsx4kh
         2vQee0ZNZlgnuzvISyTsrez4koSoqt4i8MWGQDV0UYfNrZbf04HAQQm2yrKZ0fJfBEcB
         qeq+Nc7R1thfyqqP1UkBZZwXfTAv5mZz7FTfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sf9KP5zuJQrE8WSz2jvQolWUUUetxzF/z4fyltHeno8=;
        b=lUn6HvFXc6+u0z7T6Tmgd+KBwN5vdAIwrmmE9YjWwJJCJIqX4MLi7rHbVNuOowYAC6
         3a0jLDPOJ7sVi775mUMWA5o8acm/uj2l3e+67rZW+bt+mDm9DJomWsDg3gw4ohhQ3OrM
         BSc/0jaw6J9wz8VYngW6Of/uMWNu0MeVUGF5Wq+PkQCGz9+/HJ1IxG6wRk7bRBUFstHc
         JoCsoA9AqWVoUb5+cj381iquGCMJLWNYfhfyn2MontZnAWsRuGw5sCRf0xfuwM70eNLZ
         ZFmlqpU6nrbFziGsf5FJbkoq5o6r+BIaPw7AvxdVM7IedJgScC1DxvYbtWsQTDqIWbuN
         1HEA==
X-Gm-Message-State: APt69E38rR8R1mAJtGE4fWJkK8bpvi+tFt1dlJCVl65QRZe1LM9znwLf
        MH5B72V3m+MThTAfXdvFv5MaoEytpumKO6Pc4NKVAA==
X-Google-Smtp-Source: ADUXVKJLPIWex2riuo2C9k2IDTSZpHC9fqFqpbjLl71e6sePF2OVofsDdJXj0ZpGCznB6+uCTWwV5T4oErM31WbWCl4=
X-Received: by 2002:a6b:c6c9:: with SMTP id w192-v6mr2205605iof.131.1528789645470;
 Tue, 12 Jun 2018 00:47:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 00:47:25
 -0700 (PDT)
In-Reply-To: <20180612044052.4402-1-rnayak@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jun 2018 09:47:25 +0200
Message-ID: <CAPDyKFppkycq0d53eiBVErHh5C6TwGcUrqaiagY_165Xcpux7w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Add powerdomain driver for corners on msm8996/sdm845
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, collinsd@codeaurora.org,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 06:40, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Changes in v3:
> * Bindings split into seperate patches
> * Bindings updated to remove duplicate OPP table phandles
> * DT headers defining macros for Power domain indexes and OPP levels
> * Optimisations to use rpmh_write_async() whereever applicable
> * Fixed up handling of ACTIVE_ONLY/WAKE_ONLY/SLEEP voting for RPMh
> * Fixed the vlvl to hlvl conversions in set_performance
> * Other minor fixes based on review of v2
> * TODO: This series does not handle the case where all VDD_MX votes
> should be higher than VDD_CX from APPs, as pointed out
> by David Collins in v2. This needs support at genpd to propogate performance
> state up the parents, if we model these as Parent/Child to handle the
> interdependency.
>
> Changes in v2:
> * added a powerdomain driver for sdm845 which supports communicating to RPMh
> * dropped the changes to sdhc driver to move over to using OPP
> as there is active discussion on using OPP as the interface vs
> handling all of it in clock drivers
> * Other minor binding updates based on review of v1
>
> With performance state support for genpd/OPP merged, this is an effort
> to model a powerdomain driver to communicate corner/level
> values for qualcomm platforms to RPM (Remote Power Manager) and RPMh.
>
> Rajendra Nayak (7):
>   dt-bindings: power: Add qcom rpm power domain driver bindings
>   soc: qcom: rpmpd: Add a Power domain driver to model corners
>   soc: qcom: rpmpd: Add support for get/set performance state
>   arm64: dts: msm8996: Add rpmpd device node
>   dt-bindings: power: Add qcom rpmh power domain driver bindings
>   soc: qcom: Add RPMh Power domain driver
>   soc: qcom: rpmpd/rpmhpd: Add a max vote on all corners at init
>
>  .../devicetree/bindings/power/qcom,rpmhpd.txt |  65 +++
>  .../devicetree/bindings/power/qcom,rpmpd.txt  |  49 ++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
>  drivers/soc/qcom/Kconfig                      |  18 +
>  drivers/soc/qcom/Makefile                     |   2 +
>  drivers/soc/qcom/rpmhpd.c                     | 437 ++++++++++++++++++
>  drivers/soc/qcom/rpmpd.c                      | 356 ++++++++++++++
>  include/dt-bindings/power/qcom-rpmhpd.h       |  31 ++
>  include/dt-bindings/power/qcom-rpmpd.h        |  16 +
>  9 files changed, 1008 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>  create mode 100644 drivers/soc/qcom/rpmhpd.c
>  create mode 100644 drivers/soc/qcom/rpmpd.c
>  create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
>  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

For the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
