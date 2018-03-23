Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeCWBAD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 21:00:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCWBAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 21:00:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81BE4607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
From: Timur Tabi <timur@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
 <b5dac2f7-eabb-6e09-2146-775b09d4eca8@codeaurora.org>
Message-ID: <59df3700-c0bd-6ee8-eeab-6a49cb92d1db@codeaurora.org>
Date: Thu, 22 Mar 2018 19:59:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b5dac2f7-eabb-6e09-2146-775b09d4eca8@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 07:23 PM, Timur Tabi wrote:
> 
> Also, you don't allocate chip->valid_mask anywhere.

So I see now where it's allocated, but something is fishy.  I have three 
TLMMs on my chip:

[   67.107018] gpiochip_init_valid_mask:351 gpiochip->need_valid_mask=1
[   67.153747] gpiochip_init_valid_mask:356 gpiochip->ngpio=72
[   67.195324] gpiochip_init_valid_mask:361 
gpiochip->valid_mask=0000000070b1a4b6
[   68.532992] gpiochip_init_valid_mask:356 gpiochip->ngpio=44
[   68.574496] gpiochip_init_valid_mask:361 
gpiochip->valid_mask=000000002f33b8a3
[   68.709378] msm_gpio_init_valid_mask:837 ret=44 max_gpios=44 
chip->valid_mask=000000002f33b8a3
[   69.726502] gpiochip_init_valid_mask:351 gpiochip->need_valid_mask=1
[   69.772960] gpiochip_init_valid_mask:356 gpiochip->ngpio=54
[   69.814084] gpiochip_init_valid_mask:361 
gpiochip->valid_mask=000000001a53c932

Are these normal addresses for kcalloc() to return?  They're not even 
word-aligned.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
