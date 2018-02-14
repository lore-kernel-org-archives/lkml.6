Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032289AbeBNQPg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:15:36 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36760 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032206AbeBNQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:15:33 -0500
X-Google-Smtp-Source: AH8x224npdf/tBuJ9Bm7clGgutXN7r6DNa8hZ7y8qHV/wr0G0Q3WOO7cJ9vuM8FvyGKH4XHyn3sWZw==
Subject: Re: [PATCH] PCI: qcom: use regulator bluk api for apq8064 supplies
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: stanimir.varbanov@linaro.org, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180214122315.2069-1-srinivas.kandagatla@linaro.org>
 <20180214153545.GA93895@bjorns-mbp-2.lan>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3b256b44-d3fe-9022-ed3b-b671ba5cadd1@linaro.org>
Date: Wed, 14 Feb 2018 16:14:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180214153545.GA93895@bjorns-mbp-2.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/18 15:35, Bjorn Andersson wrote:
>> +	res->supplies[1].supply = "vdda_phy";
>> +	res->supplies[1].supply = "vdda_refclk";
> 2
> 
>> +	ret = devm_regulator_bulk_get(dev, QCOM_PCIE_2_1_0_MAX_SUPPLY,
> Use ARRAY_SIZE(res->supplies) instead.
Thanks, Will fix it and send a new one.

--srini
> 
>> +				      res->supplies);
>> +	if (ret)
>> +		return ret;
>>   
> Other than that, this looks good.
