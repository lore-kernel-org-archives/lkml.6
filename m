Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966114AbeEXJgn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:36:43 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6350 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeEXJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:36:41 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 24 May 2018 02:36:43 -0700
Subject: Re: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Rajendra Nayak <rnayak@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-tegra@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
 <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com>
 <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
 <5a79d3a2-d090-645b-da69-524b7e7a4d90@nvidia.com>
 <51f7de26-579a-8b9e-4e79-f4eee923ab38@codeaurora.org>
 <CAPDyKFo_69kSS6UzdsJeyeiiED=S=chsdkP+R43qMHDEbZ8n_A@mail.gmail.com>
 <3838f17a-2ac8-bf3f-f0b1-f69bbe17629c@nvidia.com>
 <CAPDyKFo8e5FMrxF2ggxVZ+HQjw4s1Wtx-tMf5ka67knJpZMQcA@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1687797a-93f1-7e5c-6060-01c12c070964@nvidia.com>
Date: Thu, 24 May 2018 10:36:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo8e5FMrxF2ggxVZ+HQjw4s1Wtx-tMf5ka67knJpZMQcA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL102.nvidia.com (172.18.146.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/18 08:04, Ulf Hansson wrote:

...

>> Any reason why we could not add a 'boolean' argument to the API to indicate
>> whether the new device should be linked? I think that I prefer the API
>> handles it, but I can see there could be instances where drivers may wish to
>> handle it themselves.
> 
> Coming back to this question. Both Tegra XUSB and Qcom Camera use
> case, would benefit from doing the linking themselves, as it needs
> different PM domains to be powered on depending on the current use
> case - as to avoid wasting power.
> 
> However, I can understand that you prefer some simplicity over
> optimizations, as you told us. Then, does it mean that you are
> insisting on extending the APIs with a boolean for linking, or are you
> fine with the driver to call device_link_add()?

I am fine with the driver calling device_link_add(), but I just wonder 
if we will find a several drivers doing this and then we will end up 
doing this later anyway.

The current API is called ...

* genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
* @dev: Device to attach.
* @index: The index of the PM domain.

This naming and description is a bit misleading, because really it is 
not attaching the device that is passed, but creating a new device to 
attach a PM domain to. So we should consider renaming and changing the 
description and indicate that users need to link the device.

Finally, how is a PM domain attached via calling 
genpd_dev_pm_attach_by_id() detached?

Cheers
Jon

-- 
nvpublic
