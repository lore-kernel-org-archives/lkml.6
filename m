Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B85BC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273E520892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kNY6HnDD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NsFBq78Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273E520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeG3JeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:34:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeG3JeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:34:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 780BB60264; Mon, 30 Jul 2018 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532937624;
        bh=LFCkaD6lsboIqyoMatnld8ZMOuyhAjD6EsOlc5MQocI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kNY6HnDD0genv4hQ0qEwdMG1kluS89wH+5jxTbMPrwkj2cxo0tbuwGms75+f7QG5g
         cW3qm/BJiilNTfXno0iGh0inGa5vIvsyS8/RB8RRXM4mNNTzzP5tNMtKjiUpfxjZ4g
         DjCfKA0LKqLKZlWlDM4PY0FyCwLvmjocyi+i0ZHo=
Received: from [10.206.24.124] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA26061603;
        Mon, 30 Jul 2018 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532937623;
        bh=LFCkaD6lsboIqyoMatnld8ZMOuyhAjD6EsOlc5MQocI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NsFBq78Z0GP9q35Sp4UQgMiuhW3lMiTViKEuFO79sVjZkSu653l6DPgdfm3hfdCC1
         FGgJovRnVw15Ft3IYYxCH6NxO4b5UlT+WH2DHg62iEeJodWjZnLpazoNS+g6lU7c3C
         oqMbD3dtV4LRPZcHzTlWNxreGXXe7ibhmtyisuYM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA26061603
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V6] scsi: ufs: Add configfs support for UFS provisioning
To:     Adrian Hunter <adrian.hunter@intel.com>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        riteshh@codeaurora.org
Cc:     linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <1531734237-27421-1-git-send-email-sayalil@codeaurora.org>
 <1531734237-27421-2-git-send-email-sayalil@codeaurora.org>
 <fc305cad-a0db-9c4b-9d5f-14e8e48a23b3@intel.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <ed53959d-8832-e2a0-4bf4-bf53ec8191ab@codeaurora.org>
Date:   Mon, 30 Jul 2018 13:30:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fc305cad-a0db-9c4b-9d5f-14e8e48a23b3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2018 6:36 PM, Adrian Hunter wrote:
> On 16/07/18 12:43, Sayali Lokhande wrote:
>> This patch adds configfs support to provision UFS device at
>> runtime. This feature can be primarily useful in factory or
>> assembly line as some devices may be required to be configured
>> multiple times during initial system development phase.
>> Configuration Descriptors can be written multiple times until
>> bConfigDescrLock attribute is zero.
>>
>> Configuration descriptor buffer consists of Device and Unit
>> descriptor configurable parameters which are parsed from vendor
>> specific provisioning file and then passed via configfs node at
>> runtime to provision ufs device.
>> CONFIG_CONFIGFS_FS needs to be enabled for using this feature.
>>
>> Usage:
>> 1) To read current configuration descriptor :
>>     cat /config/XXXX.ufshc/ufs_provision
>> 2) To provision ufs device:
>>     echo <config_desc_buf> > /config/XXXX.ufshc/ufs_provision
>>
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
>>   Documentation/ABI/testing/configfs-driver-ufs |  18 +++
>>   drivers/scsi/ufs/Kconfig                      |  10 ++
>>   drivers/scsi/ufs/Makefile                     |   1 +
>>   drivers/scsi/ufs/ufs-configfs.c               | 162 ++++++++++++++++++++++++++
>>   drivers/scsi/ufs/ufshcd.c                     |   2 +
>>   drivers/scsi/ufs/ufshcd.h                     |  19 +++
>>   6 files changed, 212 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
>>   create mode 100644 drivers/scsi/ufs/ufs-configfs.c
>>
>> diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
>> new file mode 100644
>> index 0000000..eeee499c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/configfs-driver-ufs
>> @@ -0,0 +1,18 @@
>> +What:		/config/ufshcd/ufs_provision
>> +Date:		Jun 2018
>> +KernelVersion:	4.14
>> +Description:
>> +		This file shows the current ufs configuration descriptor set in device.
>> +		This can be used to provision ufs device if bConfigDescrLock is 0.
>> +		For more details, refer 14.1.6.3 Configuration Descriptor and
>> +		Table 14-12 - Unit Descriptor configurable parameters from specs for
>> +		description of each configuration descriptor parameter.
>> +		Configuration descriptor buffer needs to be passed in space separated
>> +		format specificied as below:
>> +		echo <bLength> <bDescriptorIDN> <bConfDescContinue> <bBootEnable>
>> +		<bDescrAccessEn> <bInitPowerMode> <bHighPriorityLUN>
>> +		<bSecureRemovalType> <bInitActiveICCLevel> <wPeriodicRTCUpdate>
>> +		<0Bh:0Fh_ReservedAs_0> <bLUEnable> <bBootLunID> <bLUWriteProtect>
>> +		<bMemoryType> <dNumAllocUnits> <bDataReliability> <bLogicalBlockSize>
>> +		<bProvisioningType> <wContextCapabilities> <0Dh:0Fh_ReservedAs_0>
>> +		> /config/XXXX.ufshc/ufs_provision
>> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
>> index e27b4d4..34d89c2 100644
>> --- a/drivers/scsi/ufs/Kconfig
>> +++ b/drivers/scsi/ufs/Kconfig
>> @@ -100,3 +100,13 @@ config SCSI_UFS_QCOM
>>   
>>   	  Select this if you have UFS controller on QCOM chipset.
>>   	  If unsure, say N.
>> +
>> +config UFS_PROVISION
>> +	tristate "Runtime UFS Provisioning support"
>> +	depends on SCSI_UFSHCD_PLATFORM && CONFIGFS_FS
> Why SCSI_UFSHCD_PLATFORM instead of SCSI_UFSHCD?
SCSI_UFSHCD_PLATFORM in turn depends on SCSI_UFSHCD hence used it, no 
specific reason as such.
I will update it to SCSI_UFSHCD (as provisioning is meant for UFS device 
and scsi_ufshcd config ensures support for ufs devices).
>
> Also please cc me in future revisions.
will do.
