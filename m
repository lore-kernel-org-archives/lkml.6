Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeDDLo3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:44:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:16290 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbeDDLo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:44:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="39291904"
Subject: Re: [PATCH 0/3] mmc: add support for sdhci 4.0
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
 <CAG2=9p8y9bMsZ8u0gaumW9B7t3GEAhJ6ChQcE8qg_to_T7wwXg@mail.gmail.com>
 <CAPDyKFp_MYRTQmLcfkrZe+Ux9ZBZQgsAaZSzzLteVYS7sW0VCw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3099c108-6acc-fd54-2aa4-dc323f566291@intel.com>
Date: Wed, 4 Apr 2018 14:43:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp_MYRTQmLcfkrZe+Ux9ZBZQgsAaZSzzLteVYS7sW0VCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/18 13:17, Ulf Hansson wrote:
> On 4 April 2018 at 11:05, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>> Hi Ulf,
>>
>> Do you have some comments on this patch-set?
> 
> No objections from my side of the series, however I am relying on
> Adrian's ack before I pick any of the patches.

We don't have any drivers that enable v4 mode.  Really we need that, so that
we are supporting features that are actually in use.  Equally some evidence
of testing would be expected.

> 
> Kind regards
> Uffe
> 
>>
>> Thanks,
>> Chunyan
>>
>> On 20 March 2018 at 16:36, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>>> From the SD host controller version 4.0 on, SDHCI implementation either
>>> is version 3 compatible or version 4 mode. This patch-set covers those
>>> changes which are common for SDHCI 4.0 version, regardless of whether
>>> they are used with SD or eMMC storage devices.
>>>
>>> Chunyan Zhang (3):
>>>   mmc: sdhci: add sd host v4 mode
>>>   mmc: sdhci: made changes for System Address register of SDMA
>>>   mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
>>>
>>>  drivers/mmc/host/sdhci.c | 66 +++++++++++++++++++++++++++++++++++++-----------
>>>  drivers/mmc/host/sdhci.h | 29 +++++++++++++++++----
>>>  2 files changed, 75 insertions(+), 20 deletions(-)
>>>
>>> --
>>> 2.7.4
>>>
> 
