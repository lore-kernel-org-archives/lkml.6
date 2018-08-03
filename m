Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9098C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DEA216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gF2SA5BD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gF2SA5BD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DEA216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeHCJOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:14:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeHCJOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:14:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E691460B12; Fri,  3 Aug 2018 07:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533280774;
        bh=v/pdw6BYcjW7SCRw0uPqPaR4/7dPnKwClGrtLTouMoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gF2SA5BDzEMVBBdAA36cQKi8zUQgSWclquKRKozDVRy5ee34zVOHvlyp8k4CSsdkM
         +Vax+4zhzUp/crf5TimXUJWUC6YexKmlafNTpPUIlCf3rLEUKe2ldXvScGdwEt58l2
         ay0a1lMuYp8U/MYshN0AMu2SnFuA9VQbwbtoHWnM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1E163600ED;
        Fri,  3 Aug 2018 07:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533280774;
        bh=v/pdw6BYcjW7SCRw0uPqPaR4/7dPnKwClGrtLTouMoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gF2SA5BDzEMVBBdAA36cQKi8zUQgSWclquKRKozDVRy5ee34zVOHvlyp8k4CSsdkM
         +Vax+4zhzUp/crf5TimXUJWUC6YexKmlafNTpPUIlCf3rLEUKe2ldXvScGdwEt58l2
         ay0a1lMuYp8U/MYshN0AMu2SnFuA9VQbwbtoHWnM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Aug 2018 12:49:34 +0530
From:   kgunda@codeaurora.org
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V4 0/8] backlight: qcom-wled: Support for QCOM wled driver
In-Reply-To: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
Message-ID: <519913ec490934931b1c0b3a4539c283@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Can you please help review this patch series ?

Pavel, Rob, Daniel reviewed the series except the "auto string 
detection" patch.

Thanks,
Kiran

On 2018-07-09 15:52, Kiran Gunda wrote:
> This patch series renames the pm8941-wled.c driver to qcom-wled.c to 
> add
> the support for multiple PMICs supported by qualcomm. This patch series
> supports both PM8941 and PMI8998 WLED. The PMI8998 WLED has the support
> to handle the OVP (over voltage protection) and the SC (short circuit
> protection)
> interrupts. It also has the auto string detection algorithm support to
> configure the right strings if the user specified string configuration
> is in-correct. These three features are added in this series for 
> PMI8998.
> 
> changes from v1:
>    - Fixed the commit message for
>    - backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
> 
> Changes from v2:
>    - Fixed bjorn and other reviewer's comments
>    - Seperated the device tree bindings
>    - Splitted out the WLED4 changes in seperate patch
>    - Merged OVP and auto string detection patch
> 
> Changes from v3:
>   - Added Reviewed-by/Acked-by tags
>   - Fixed comments from Bjorn/Vinod/Rob
>   - Splitting the "backlight: qcom-wled: Add support for WLED4 
> peripheral" patch
>     to seperate the WLED3 specific restructure.
> 
> Kiran Gunda (8):
>   backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
>   backlight: qcom-wled: restructure the qcom-wled bindings
>   backlight: qcom-wled: Add new properties for PMI8998
>   backlight: qcom-wled: Rename PM8941* to WLED3
>   backlight: qcom-wled: Restructure the driver for WLED3
>   backlight: qcom-wled: Add support for WLED4 peripheral
>   backlight: qcom-wled: add support for short circuit handling
>   backlight: qcom-wled: Add auto string detection logic
> 
>  .../bindings/leds/backlight/pm8941-wled.txt        |   42 -
>  .../bindings/leds/backlight/qcom-wled.txt          |  150 +++
>  drivers/video/backlight/Kconfig                    |    8 +-
>  drivers/video/backlight/Makefile                   |    2 +-
>  drivers/video/backlight/pm8941-wled.c              |  432 -------
>  drivers/video/backlight/qcom-wled.c                | 1298 
> ++++++++++++++++++++
>  6 files changed, 1453 insertions(+), 479 deletions(-)
>  delete mode 100644
> Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
>  create mode 100644
> Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>  delete mode 100644 drivers/video/backlight/pm8941-wled.c
>  create mode 100644 drivers/video/backlight/qcom-wled.c
