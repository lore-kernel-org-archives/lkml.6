Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeBTQmu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:42:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeBTQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:42:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A87A160712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH] pinctrl: msm: Use dynamic GPIO numbering
To: Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180129005948.7714-1-bjorn.andersson@linaro.org>
 <CACRpkdb0OWQzeJZ7K1bXrdNPwu0GhygW1p04Xoyf9WjTg7+=BQ@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <e1d9fa6b-ac53-4392-de0f-0a16c4012e4b@codeaurora.org>
Date: Tue, 20 Feb 2018 10:42:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb0OWQzeJZ7K1bXrdNPwu0GhygW1p04Xoyf9WjTg7+=BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2018 07:52 AM, Linus Walleij wrote:
> OK I put this in devel for v4.17, let's see if something explodes
> in linux-next else we can go with this.
> 
> Otherwise we need something that conserves base 0 for singular
> TLMM drivers and make it -1 for newer platforms with several
> instances.

I don't see this patch in linusw/linux-gpio.git anywhere.  Do you want 
me to submit another patch that implements this:

     static int base = 0;

     chip->base = base;
     base = -1;

This preserves existing behavior for current drivers.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
