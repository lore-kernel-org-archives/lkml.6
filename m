Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C4820B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeLaVmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:42:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:16972 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbeLaVmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:42:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 13:42:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,424,1539673200"; 
   d="scan'208";a="102865064"
Received: from cfacero-mobl.amr.corp.intel.com (HELO [10.254.52.131]) ([10.254.52.131])
  by orsmga007.jf.intel.com with ESMTP; 31 Dec 2018 13:42:10 -0800
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk>
 <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
 <20181231193017.GN1846@sirena.org.uk>
 <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
 <d288e6cf-158f-e832-6096-17d3faf9e3e9@linux.intel.com>
 <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <765ab3a1-f1f1-3b29-aabb-0f3328abd631@linux.intel.com>
Date:   Mon, 31 Dec 2018 15:42:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/31/18 2:35 PM, Sinan Kaya wrote:
> On Mon, Dec 31, 2018 at 11:29 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> On 12/31/18 1:35 PM, Sinan Kaya wrote:
>>> On Mon, Dec 31, 2018 at 10:30 PM Mark Brown <broonie@kernel.org> wrote:
>>>> On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
>>>>> On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
>>>>>> I don't have the cover letter or anything for this series, what's going
>>>>>> on with dependencies?
>>>>> Here is the executive summary:
>>>>> I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
>>>>> used to select PCI. This is no longer true.
>>>>> You can build an ACPI system without any PCI devices.
>>>> So there's no dependency and I can just apply this?
>>> The plan is to apply this patchset via ACPI tree. Need an Acked-by per patch.
>> Anytime we change the Kconfig settings for audio, we get all kinds of
>> problems with randconfig and 0day/kbuild due to depend/select issues.
>> I'd like to give this a spin first, can you share a link to the entire
>> series? Thanks!
> Sure,
>
> You can find them here
>
> https://lore.kernel.org/patchwork/patch/1028330/
>
> Click related.

Something must be missing, I get compilation errors when PCI is not 
defined? And I see tons of references to pci stuff in drivers/acpi.

drivers/acpi/reboot.c: In function ‘acpi_reboot’:
drivers/acpi/reboot.c:37:10: error: implicit declaration of function 
‘pci_find_bus’; did you mean ‘pci_find_next_bus’? 
[-Werror=implicit-function-declaration]
    bus0 = pci_find_bus(0, 0);
           ^~~~~~~~~~~~
           pci_find_next_bus
drivers/acpi/reboot.c:37:8: warning: assignment makes pointer from 
integer without a cast [-Wint-conversion]
    bus0 = pci_find_bus(0, 0);
         ^
drivers/acpi/reboot.c:45:3: error: implicit declaration of function 
‘pci_bus_write_config_byte’; did you mean ‘pci_write_config_byte’? 
[-Werror=implicit-function-declaration]
    pci_bus_write_config_byte(bus0, devfn,
    ^~~~~~~~~~~~~~~~~~~~~~~~~
    pci_write_config_byte


