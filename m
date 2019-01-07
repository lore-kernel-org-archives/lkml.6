Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8ABC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FBA218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfAGMnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:44188 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfAGMnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 04:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="132255973"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jan 2019 04:43:44 -0800
Subject: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>,
        Philip Elcan <pelcan@codeaurora.org>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-10-okaya@kernel.org>
 <CAJZ5v0gXM3d0uuaQPyeafVS3S1tNbo0gY5TMskpQptNGvmVKzA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <39fa9438-8928-5a1b-2a86-617df39e4c73@intel.com>
Date:   Mon, 7 Jan 2019 14:42:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gXM3d0uuaQPyeafVS3S1tNbo0gY5TMskpQptNGvmVKzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/01/19 1:17 PM, Rafael J. Wysocki wrote:
> On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
>> specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
>> on PCI. For this reason, add a direct dependency to CONFIG_PCI here.
>>
>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>  drivers/mmc/host/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index e26b8145efb3..1b9401fe94c0 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -116,7 +116,7 @@ config MMC_RICOH_MMC
>>
>>  config MMC_SDHCI_ACPI
>>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>> -       depends on MMC_SDHCI && ACPI
>> +       depends on MMC_SDHCI && ACPI && PCI
>>         select IOSF_MBI if X86
>>         help
>>           This selects support for ACPI enumerated SDHCI controllers,
>> --
> 
> Any objections against this one from anyone?

+ QCOM and AMD contributors
