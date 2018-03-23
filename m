Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeCWQZj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:25:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeCWQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:25:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A751F60131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
To: Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
 <1521804964.23017.96.camel@linux.intel.com>
 <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <9edb00e7-51e3-68f7-c606-333b7d57d602@codeaurora.org>
Date: Fri, 23 Mar 2018 11:25:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 11:21 AM, Stephen Boyd wrote:
> I'll send the updated patches now.

Thanks.

BTW, I just discovered that the static globals in pinctrl-msm are 
breaking the ability to support more than one TLMM:

static struct pinctrl_desc msm_pinctrl_desc = {

static struct irq_chip msm_gpio_irq_chip = {

static struct msm_pinctrl *poweroff_pctrl;

I'm going to have to fix all of these.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
