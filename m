Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F45AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D3220645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gG8UFadz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gG8UFadz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D3220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIFAho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:37:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIFAho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:37:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DEE0A602AE; Wed,  5 Sep 2018 20:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536177958;
        bh=FbEsqBrDykACgRjXbWe3NURTxzxE0ndeuhLjiWlJI2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gG8UFadzer/FhVgVtkWTCod8Vz4YAPflVMZSziZycXuZ9+oqrMpPOEWQTu/SoatXy
         gEzqU5BgCY8Q4G5LfjU2RVU/A0nIHDP4V//XPazH4zjjT46rDfpScQHwK4o5dFuKdh
         nRJFnWYhvKbp6sUKwU/BvWlqD6sl9cuhts9Ofdb0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D877A602AE;
        Wed,  5 Sep 2018 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536177958;
        bh=FbEsqBrDykACgRjXbWe3NURTxzxE0ndeuhLjiWlJI2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gG8UFadzer/FhVgVtkWTCod8Vz4YAPflVMZSziZycXuZ9+oqrMpPOEWQTu/SoatXy
         gEzqU5BgCY8Q4G5LfjU2RVU/A0nIHDP4V//XPazH4zjjT46rDfpScQHwK4o5dFuKdh
         nRJFnWYhvKbp6sUKwU/BvWlqD6sl9cuhts9Ofdb0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D877A602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 5 Sep 2018 14:05:57 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH v2 0/6] drivers/qcom: add additional functionality to RPMH
Message-ID: <20180905200557.GC28215@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen, Doug,

Would you have some time to take a look at this series?

Thanks,
Lina

On Fri, Jul 27 2018 at 04:04 -0600, Raju P L S S S N wrote:
>From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>
>Changes in v1:
>- Remove unnecessary EXPORT_SYMBOL in rpmh-rsc
>
>This set of patches add additional functionality to RPMH drivers[1].
>
>PM drivers can choose to disallow idle modes when RSC controller is busy
>sending or processing requests. The patches add necessary functions to
>query the controller status.
>
>The controllers may be in 'solver' state, where they could be in autonomous
>mode executing low power modes for their hardware and as such are not
>available for sending active votes. Functionality to get notified about
>such state and disallow requests for state change in that case is added
>in these patches.
>
>The Power Domain Controller can be programmed to wakeup the RSC and
>setup the resources back in the active state, before the processor is
>woken up by a timer interrupt. The wakeup value from the timer hardware
>can be copied to the PDC which has its own timer and is in an always-on
>power domain. Programming the wakeup value is done through a separate
>register on the RSC. Functions necessary to program wakeup is added in
>the patches.
>
>Please consider reviewing this patchset.
>
>v1:https://lkml.org/lkml/2018/7/19/213
>
>
>
>[1] https://lkml.org/lkml/2018/6/20/519
>
>Lina Iyer (5):
>  drivers: qcom: rpmh-rsc: return if the controller is idle
>  drivers: qcom: rpmh: export controller idle status
>  drivers: qcom: rpmh: disallow active requests in solver mode
>  drivers: qcom: rpmh-rsc: write PDC data
>  drivers: qcom: rpmh: write PDC data
>
>Raju P.L.S.S.S.N (1):
>  drivers: qcom: rpmh-rsc: clear active mode configuration for waketcs
>
> drivers/soc/qcom/rpmh-internal.h |   6 ++
> drivers/soc/qcom/rpmh-rsc.c      | 132 ++++++++++++++++++++++++++++++---------
> drivers/soc/qcom/rpmh.c          | 100 +++++++++++++++++++++++++++++
> include/soc/qcom/rpmh.h          |  16 +++++
> 4 files changed, 225 insertions(+), 29 deletions(-)
>
>--
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
>
