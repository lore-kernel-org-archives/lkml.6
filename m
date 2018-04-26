Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeDZHUE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:20:04 -0400
Received: from thoth.sbs.de ([192.35.17.2]:44562 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeDZHUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:20:03 -0400
Subject: Re: [PATCH 6/6] arm: Allow to enable PCI_DOMAINS manually
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <4b97c00b9cd72f508aa27f0b58711d73de2cd397.1524582822.git.jan.kiszka@siemens.com>
 <20180425175446.GC21628@e107981-ln.cambridge.arm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Openpgp: preference=signencrypt
Message-ID: <ed0e7c92-6ee1-53a9-4448-a679aed8f613@siemens.com>
Date: Thu, 26 Apr 2018 09:19:37 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180425175446.GC21628@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-25 19:54, Lorenzo Pieralisi wrote:
> On Tue, Apr 24, 2018 at 05:13:42PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Required when running over Jailhouse, and there is already a physical
>> host controller that Jailhouse does not intercept and rather adds a
>> virtual one. That is the case for the Tegra TK1, e.g.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm/Kconfig | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a7f8e7f4b88f..5f8190cb057d 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1248,8 +1248,13 @@ config PCI
>>  	  VESA. If you have PCI, say Y, otherwise N.
>>  
>>  config PCI_DOMAINS
>> -	bool
>> +	bool "Support for multiple PCI domains"
>>  	depends on PCI
>> +	help
>> +	  Automatically enabled if the platform supports multiple PCI host
>> +	  controllers. Say Y if running over a hypervisor like Jailhouse that
>> +	  dynamically adds further host controllers while the system is
>> +	  running. Say N otherwise.
> 
> Alternatively, you could select it under PCI_HOST_GENERIC if that's all
> you need in Jailhouse. Actually that's a change that makes sense anyway
> I think.

If that's preferred - will switch!

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
