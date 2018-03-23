Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeCWAQe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:16:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbeCWAQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:16:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 755FC60246
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
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
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
Date: Thu, 22 Mar 2018 19:16:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321165848.89751-4-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 11:58 AM, Stephen Boyd wrote:
> +static int msm_gpio_init_valid_mask(struct gpio_chip *chip,
> +				    struct msm_pinctrl *pctrl)
> +{
> +	int ret;
> +	unsigned int len, i;
> +	unsigned int max_gpios = pctrl->soc->ngpios;
> +
> +	/* The number of GPIOs in the ACPI tables */
> +	ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
> +	if (ret > 0 && ret < max_gpios) {

This needs to be ret <= max_gpios, otherwise it will fail if every GPIO 
is available.

And it should print an error message and return an error code if ret > 
max_gpios.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
