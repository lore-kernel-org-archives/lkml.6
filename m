Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeFEBXu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:23:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52180 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbeFEBXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:23:49 -0400
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To: Greg KH <greg@kroah.com>, Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
 <20180529183917.GA10618@kroah.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9713a0b2-1450-7783-712f-ba27f8a09b2b@infradead.org>
Date: Mon, 4 Jun 2018 18:23:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529183917.GA10618@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 11:39 AM, Greg KH wrote:
> On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
>> Implement a skeleton framework for debugfs support in the
>> AMD IOMMU. Add a hidden boolean to Kconfig that is defined
>> for the AMD IOMMU when general IOMMY DebugFS support is
>> enabled.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>  drivers/iommu/Kconfig             |    4 ++++
>>  drivers/iommu/Makefile            |    1 +
>>  drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>  drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>  drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>  drivers/iommu/amd_iommu_types.h   |    5 +++++
>>  6 files changed, 59 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index f9af25ac409f..ec223f6f4ad4 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -137,6 +137,10 @@ config AMD_IOMMU
>>  	  your BIOS for an option to enable it or if you have an IVRS ACPI
>>  	  table.
>>  
>> +config AMD_IOMMU_DEBUGFS
>> +	def_bool y
> 
> Why default y?  Can you not boot a box without this?  If not, it should
> not be Y.
> 
>> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
>> +
>>  config AMD_IOMMU_V2
>>  	tristate "AMD IOMMU Version 2 driver"
>>  	depends on AMD_IOMMU

Gary,

By far, most driver-debugfs additions are optional and include a user Kconfig prompt
so that user's can choose whether to enable it or not.

I suggest that the way forward is to fix Greg's debugfs_() api comments
and to add a prompt string to AMD_IOMMU_DEBUGFS.


-- 
~Randy
