Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754843AbeEaL4A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:56:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754221AbeEaLz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:55:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FCBD605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
 <20180531114553.GB11598@kroah.com>
 <d2ed4f7c-f97c-ba51-6f33-d329da69dbc6@dd-wrt.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <510e5f2c-718a-de42-8274-9345d13e7797@codeaurora.org>
Date: Thu, 31 May 2018 06:55:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d2ed4f7c-f97c-ba51-6f33-d329da69dbc6@dd-wrt.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/18 6:53 AM, Sebastian Gottschall wrote:
>>
> i checked initially 4.9 with latest patches and 4.14 and reverted this 
> line to get back to the old behaviour but a which view in the current 
> 4.17 tree shows
> that the same patch has been included in 4.17. it was introduced in the 
> kernel mainline on 12.feb 2018
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pinctrl/qcom/pinctrl-msm.c?h=v4.17-rc7&id=a7aa75a2a7dba32594291a71c3704000a2fd7089

I believe that this patch should not be applied to *any* stable kernel.

It completely breaks legacy GPIO numbering, and it does so 
intentionally.  That may be okay for future kernels, but IMHO it's wrong 
for older kernels.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
