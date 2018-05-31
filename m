Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755480AbeEaPKA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:10:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755420AbeEaPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:09:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FBD560591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
 <20180531114553.GB11598@kroah.com>
 <d2ed4f7c-f97c-ba51-6f33-d329da69dbc6@dd-wrt.com>
 <510e5f2c-718a-de42-8274-9345d13e7797@codeaurora.org>
 <20180531121251.GA13561@kroah.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <2898aafa-e185-8ad5-5f7f-9b81d4a36a8f@codeaurora.org>
Date: Thu, 31 May 2018 10:09:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531121251.GA13561@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/18 7:12 AM, Greg Kroah-Hartman wrote:
> Why is it somehow ok for "future" kernels?  You can't break the api in
> the future for no reason.
> 
> So this needs to be the same everywhere.  If it is broken in 4.17-rc, it
> needs to be reverted.

This was discussed here:

https://www.spinics.net/lists/linux-arm-msm/msg32572.html

The code can't program the value to 0 *and* support multiple TLMM 
devices at the same time.  Prior to 4.18, it is not possible to support 
multiple TLMMs anyway, so blindly setting the base to -1 in the 4.17 
kernel just breaks existing user-space code that uses the legacy GPIO API.

(This patch in 4.18 is what provides support for multiple TLMMs: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/pinctrl/qcom?id=f265e8b91bb50c7a732a171ddaeb0eef143bacd9)

So you can see in the thread that I proposed a compromise:

https://www.spinics.net/lists/linux-arm-msm/msg32596.html

but that was rejected

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
