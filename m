Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeEPWr0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:47:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeEPWrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:47:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F9D160209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH] regulator: core: Allow for regulators that can't be read
 at bootup
To: Douglas Anderson <dianders@chromium.org>, broonie@kernel.org
Cc: mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <20180515220717.254950-1-dianders@chromium.org>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <4547e1cb-a39c-decd-9384-4e2c6d28f64d@codeaurora.org>
Date: Wed, 16 May 2018 15:47:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180515220717.254950-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 03:07 PM, Douglas Anderson wrote:
> As discussed in the patches to try to support the RPMh regulators [1],
> the fact that regulators are write-only means that its driver's
> get_voltage_sel() should return an error code if it's called before
> any calls to set_voltage_sel().  This causes problems in
> machine_constraints_voltage() when trying to apply the constraints.

This problem specifically arises in the latest RPMh regulator patch [1] if
regulator-min-microvolt and regulator-max-microvolt are specified for a
VRM managed RPMh regulator device but the qcom,regulator-initial-microvolt
property is not provided.  Therefore, listing
qcom,regulator-initial-microvolt is a way to avoid regulator registration
issues.


> In this patch I propose the error code -ENOTRECOVERABLE.  In errno.h
> this error is described as "State not recoverable".

I'm fine with this constant.  Hopefully Mark is as well.


> If this patch is accepted then we'll need to update the latest RPMh
> regulator patch to return it.  The current patch returns -EINVAL which
> means that the regulator always fails.

I'll make this modification if needed.

Take care,
David

[1] https://lkml.org/lkml/2018/5/11/703

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
