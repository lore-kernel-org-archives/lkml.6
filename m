Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D321DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A435F20836
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfABOEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:04:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:37936 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfABOEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:04:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 06:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,431,1539673200"; 
   d="scan'208";a="113614933"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jan 2019 06:04:47 -0800
Subject: Re: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <Okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, faiz_abbas@ti.com,
        chunyan.zhang@unisoc.com, Jisheng.Zhang@synaptics.com,
        ludovic.barre@st.com, Arnd Bergmann <arnd@arndb.de>,
        alex.smith@imgtec.com, chris.brandt@renesas.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
 <20181223232521.11320-10-okaya@kernel.org>
 <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
 <CAK9iUCPqqyK7KMvchM4jY_FBgujnQm019J27TpDJjXUXvu5sjQ@mail.gmail.com>
 <CAJZ5v0hw_=Odpok=6qWVWAfJ0wG7Z8NjwzMCpaFgxYnEAreKcg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <21e732e8-84e4-72f9-4142-8e6af54f1346@intel.com>
Date:   Wed, 2 Jan 2019 16:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hw_=Odpok=6qWVWAfJ0wG7Z8NjwzMCpaFgxYnEAreKcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/18 11:40 AM, Rafael J. Wysocki wrote:
> On Sun, Dec 30, 2018 at 7:57 PM Sinan Kaya <Okaya@kernel.org> wrote:
>>
>> On Wed, Dec 26, 2018 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Mon, Dec 24, 2018 at 12:26 AM Sinan Kaya <okaya@kernel.org> wrote:
>>>>
>>>> Select IOSF_MBI only when PCI is set.
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>>>> ---
>>>>  drivers/mmc/host/Kconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index e26b8145efb3..4c5f037b246d 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -117,7 +117,7 @@ config MMC_RICOH_MMC
>>>>  config MMC_SDHCI_ACPI
>>>>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>>>>         depends on MMC_SDHCI && ACPI
>>>
>>> It should depend on PCI as well, shouldn't it?
>>>
>>
>> I don't think so. The PCI dependency is at IOSF_MBI code so code
>> should select IOSF_MBI only when x86 and pci is defined as below.
>>
>> This driver does not depend on PCI.
> 
> Are you sure?
> 
> Do you know any systems in which to use it without PCI?
> 

Qualcomm use it and I don't know if those systems have PCI.
AMD use it but probably also have PCI.  And yes Intel systems (just BYT and
CHT IIRC) that use this driver will always have PCI.
