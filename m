Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB25C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4CA208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgB18nXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4CA208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeIYBwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:52:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36279 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeIYBwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:52:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so2103777pfo.3;
        Mon, 24 Sep 2018 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3T02Br/Kkh+c+8ZJYVOS9eh5FWbDUubUrZl9WhiQBA=;
        b=dgB18nXTysHafqOEsDmGePLfcBpzByfivj+LdKxGnCup3nrQVW+t+AEY6ZJSGaQAsc
         IJFPBucQr2Ye2q7ZsaSyJoKYB9CagDBqGY6ihCnbJpnQxUGUSfEhhDQwLQuFhezsbL5I
         2XcDtq2pK+14rVsXVTxDY0UGyjl3bU2yWwfkVcG6JvkKIAtmwSyvMpkf3BIUUq02WU1F
         jVF7v+ziWx27UtgZilzFbca832VHbm1K1mdgTTcaROyWmyp96QrG6WlO8w81YJal2V3+
         ojoDVhmcOZ9d6JU8bOAWUD9w2aAI5xFdcTqbQevRnhRtVrSRf2tL2zyYK/fMeOBe9/tc
         DD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3T02Br/Kkh+c+8ZJYVOS9eh5FWbDUubUrZl9WhiQBA=;
        b=gGYJ1ebqCbRwEi3sJkby9ECaIYORH+8LamWiKW0l/w9xr/v1xtdYEwnOmIvx7xnSFL
         qcquEEFESDbxyW0jz2aX1CVl5HH14ivG0bSIdyGii5bQC0umdhwBCKP4oJ6oR/jtzyOe
         8t4cIvfTnobxMaUZSaX/vGaiiBsi5IzK2W839AXdqRg+v9HMxN6IjLwq55GuU6S88aLM
         EL6fpwoVVpFt52N6G3Q+QBZAv5M9A9A5quSwrAfMnlhUjAfMkNZUPqarIzW0CM3Tz4/6
         Cx36Tqa3hTneuJVJ9lB7sOFyKnOzU2k+Yz72GVxujOMif2e+zg/eeBiEnpsqh7Njccl2
         MvBg==
X-Gm-Message-State: ABuFfogVOM8KmUwDrXLhwLXUossUf6+CWN7dQdjRLP5QB3u2uWCMSHhL
        JU76SBo+ID5ziK/XCMq1/w==
X-Google-Smtp-Source: ACcGV624zOk9GsCw9XfUw3g7OEeh4QkxCjVFZbQa4XIFlbOuplHBDv5Br6i3G6+jZIACm7uCgEiBTg==
X-Received: by 2002:a63:5353:: with SMTP id t19-v6mr243377pgl.199.1537818537908;
        Mon, 24 Sep 2018 12:48:57 -0700 (PDT)
Received: from arch (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.gmail.com with ESMTPSA id r64-v6sm172372pfk.157.2018.09.24.12.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 12:48:57 -0700 (PDT)
Date:   Mon, 24 Sep 2018 20:48:22 +0100
From:   Craig Tatlor <ctatlor97@gmail.com>
To:     Vijay Viswanath <vviswana@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
Message-ID: <20180924194412.GA27477@arch>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What socs have you tested this on? 
On sdm660 it seems to crash device
when writing pwr ctl.

On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
> With SDCC5, the MCI register space got removed and the offset/order of
> several registers have changed. Based on SDCC version used and the register,
> we need to pick the base address and offset.
> 
> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm"
> 
> Changes since RFC:
> 	Dropped voltage regulator changes in sdhci-msm
> 	Split the "Register changes for sdcc V5" patch
> 	Instead of checking mci removal for deciding which base addr to use,
> 	new function pointers are defined for the 2 variants of sdcc: 
> 		1) MCI present
> 		2) V5 (mci removed)
> 	Instead of string comparing with the compatible string from DT file,
> 	the sdhci_msm_probe will now pick the data associated with the
> 	compatible entry and use it to load variant specific address offsets
> 	and msm variant specific read/write ops.
> 
> Changes since V1:
> 	Removed unused msm_reab & msm_writeb APIs
> 	Changed certain register addresses from uppercase to lowercase hex
> 	letters
> 	Removed extra lines and spaces
> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
> 	one for Documentation and other for the driver changes.
> 
> Changes since V2:
> 	Used lower case for macro function defenitions
> 	Removed unused function pointers for msm_readb & msm_writeb
> 
> 
> Sayali Lokhande (3):
>   mmc: sdhci-msm: Define new Register address map
>   Documentation: sdhci-msm: Add new compatible string for SDCC v5
>   mmc: host: Register changes for sdcc V5
> 
> Vijay Viswanath (1):
>   mmc: sdhci-msm: Add msm version specific ops and data structures
> 
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
>  drivers/mmc/host/sdhci-msm.c                       | 511 ++++++++++++++++-----
>  2 files changed, 391 insertions(+), 127 deletions(-)
> 
> -- 
>  Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
