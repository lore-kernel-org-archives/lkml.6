Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeCOKDG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:03:06 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:18817 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCOKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:03:03 -0400
Subject: Re: [PATCH v3 00/11] mmc: sdhci-omap: Add UHS/HS200 mode support
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20180307132020.30951-1-kishon@ti.com>
 <CAPDyKFrnPQs3B2QN7tf3UH0JYjqkpS1YDhq0s3scads3exPCCg@mail.gmail.com>
 <1b7e25b2-4949-5427-1c36-0b253c79ff8d@intel.com>
CC: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d6009c30-112f-eff9-4afe-5dd4c3a61baa@ti.com>
Date: Thu, 15 Mar 2018 15:32:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1b7e25b2-4949-5427-1c36-0b253c79ff8d@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 15 March 2018 02:22 PM, Adrian Hunter wrote:
> On 15/03/18 10:47, Ulf Hansson wrote:
>> On 7 March 2018 at 14:20, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> Add UHS/HS200 mode support in sdhci-omap. The programming sequence
>>> for voltage switching, tuning is followed from AM572x TRM
>>> http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf
>>> (Similar to all AM57x/DRA7x SoCs). The patch series also implements
>>> workaround for errata published in
>>> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf
>>>
>>> patches are created on top of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
>>>
>>> Patches in v2 already applied to mmc -next are dropped from the
>>> series.
>>>
>>> Changes from v2:
>>> *) Changed SW timeout logic as per Adrians's suggestion
>>> *) Validated SDIO with the current patches (added a couple of fixes
>>>    found while adding SDIO support).
>>> *) Used soc_device_match() instead of pdata-quirks as per Tony's
>>>    suggestions.
>>>
>>> Changes from v1:
>>> *) Only poll on DAT0 and DATI for card_busy status
>>> *) Cleanup iodelay patch as suggested by Tony.
>>> *) Added quirk to disable HW timeout
>>> *) Use the existing data timer but program a relatively accurate
>>>    SW timeout value (Impacts all platforms)
>>> *) Fix a bug in sdhci which was using data_timer for non data line
>>>    commands
>>>
>>> Kishon Vijay Abraham I (11):
>>>   mmc: sdhci-omap: Fix when capabilities are obtained from
>>>     SDHCI_CAPABILITIES reg
>>>   mmc: sdhci-omap: Remove setting ADMA capability in driver
>>>   mmc: sdhci-omap: Workaround for Errata i843
>>>   mmc: sdhci-omap: Invoke sdhci_get_of_property to read sdhci dt
>>>     properties
>>>   mmc: sdhci: Disable HS200 mode if controller can't support 1.8v
>>>   mmc: sdhci: Add quirk to disable HW timeout
>>>   mmc: sdhci: Program a relatively accurate SW timeout value
>>>   mmc: sdhci-omap: Workaround for Errata i834
>>>   dt-bindings: sdhci-omap: Add K2G specific binding
>>>   mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
>>>   mmc: sdhci-omap: Add sdhci_omap specific ops for enable_sdio_irq
>>>
>>>  .../devicetree/bindings/mmc/sdhci-omap.txt         |  2 +
>>>  drivers/mmc/host/sdhci-omap.c                      | 78 +++++++++++++++++++---
>>>  drivers/mmc/host/sdhci.c                           | 75 +++++++++++++++++----
>>>  drivers/mmc/host/sdhci.h                           | 15 +++++
>>>  4 files changed, 148 insertions(+), 22 deletions(-)
>>>
>>> --
>>> 2.11.0
>>>
>>
>> Overall this looks good to me, however it seems like we need to give
>> Adrian a little more time to comment.
>>
> 
> I will try to look at it today.

sure, thanks!

-Kishon
