Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755098AbeEaMr5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:47:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5531 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754943AbeEaMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:47:54 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 May 2018 05:47:53 -0700
Subject: Re: [PATCH v3 4/5] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Lucas Stach <dev@lynxeye.de>, Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
References: <20180531105959.14843-1-ulf.hansson@linaro.org>
 <20180531105959.14843-5-ulf.hansson@linaro.org>
 <5fc1d3ee51c8dbc264fb21edf33a879c7db4056b.camel@lynxeye.de>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <191ed832-3b15-f47d-c171-4039da665b36@nvidia.com>
Date: Thu, 31 May 2018 13:47:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5fc1d3ee51c8dbc264fb21edf33a879c7db4056b.camel@lynxeye.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/05/18 12:40, Lucas Stach wrote:
> Hi Ulf,
> 
> Am Donnerstag, den 31.05.2018, 12:59 +0200 schrieb Ulf Hansson:
>> To support devices being partitioned across multiple PM domains, let's
>> begin with extending genpd to cope with these kind of configurations.
>>
>> Therefore, add a new exported function genpd_dev_pm_attach_by_id(), which
>> is similar to the existing genpd_dev_pm_attach(), but with the difference
>> that it allows its callers to provide an index to the PM domain that it
>> wants to attach.
>>
>> Note that, genpd_dev_pm_attach_by_id() shall only be called by the driver
>> core / PM core, similar to how the existing dev_pm_domain_attach() makes
>> use of genpd_dev_pm_attach(). However, this is implemented by following
>> changes on top.
> 
> by_id() APIs are not really intuitive to use for driver writers. Other
> subsystems have solved this by providing a "-names" property to give
> the phandles a bit more meaning and then providing a by_name API. I
> would really appreciate if PM domains could move in the same direction.

As discussed here [0], there are plans to add that.

Cheers
Jon

[0] https://patchwork.ozlabs.org/patch/921938/

-- 
nvpublic
