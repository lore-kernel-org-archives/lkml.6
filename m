Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE186C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659D42098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L43n30zU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R4QfvQZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659D42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJDObx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:31:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37912 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDObx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:31:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0D0C60CDD; Thu,  4 Oct 2018 07:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538638798;
        bh=qHOWRuJ6RPSPTOSpv4fsqpgVTdcJiwP8ZbThxQk8HoM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L43n30zUbV4fdIvL945Xw4WurQHc7y6WM762fDAW6RwJDYqjF0LAONT9fRMNkSLYn
         d9AFe7kln9u9wacsHfVcfcwps5e2noNVkNb5r3q3eYKgD600vGEivRZQTTDQ/Soqbb
         t8fOjiJdwAhRpR7OnUVJ0QS9gh1KonzptEdH3fyc=
Received: from [10.206.24.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E23B60D46;
        Thu,  4 Oct 2018 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538638795;
        bh=qHOWRuJ6RPSPTOSpv4fsqpgVTdcJiwP8ZbThxQk8HoM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R4QfvQZccq1EZbTD+22elx8sVzEr8r4ZHd8IxKXBu+mhC8i9VZfExfFFl4KR9q5/2
         s5gd6rAKqaMJI0RLxEuhLkjGl3wkrnSRAYEeIz949aak4ctktjJ6/IG7hCWGcDqB1x
         IfMXTW/E99Up8PI5Iqm5t9qzc3RNJwZqpYqO4SRg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E23B60D46
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V14 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
To:     Evan Green <evgreen@chromium.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, adrian.hunter@intel.com,
        Joel Becker <jlbec@evilplan.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org>
 <1537770516-28410-3-git-send-email-sayalil@codeaurora.org>
 <CAE=gft6dLW5zzrOg470kS=O8rMgPr02Nb4NL9pEtpymc83ms+w@mail.gmail.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <3b583d0a-8a14-9cd9-19d0-57948ab5a742@codeaurora.org>
Date:   Thu, 4 Oct 2018 13:09:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft6dLW5zzrOg470kS=O8rMgPr02Nb4NL9pEtpymc83ms+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,


On 10/3/2018 11:31 PM, Evan Green wrote:
> On Sun, Sep 23, 2018 at 11:29 PM Sayali Lokhande <sayalil@codeaurora.org> wrote:
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
>> CONFIG_CONFIGFS_FS and CONFIG_SCSI_UFS_PROVISION needs to be enabled
>> for using this feature.
>>
>> Usage:
>> 1) To read current configuration descriptor with index X
>>     (where index X can be 0/1/2/3) :
>>     cat /config/<device_name>/ufs_config_desc_X
>>
>> 2) To write configuration descriptor with index X :
>>     echo <config_desc_buf> > /config/<device_name>/ufs_config_desc_X
>>
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
>>   Documentation/ABI/testing/configfs-driver-ufs |  12 ++
>>   drivers/scsi/ufs/Kconfig                      |  10 ++
>>   drivers/scsi/ufs/Makefile                     |   1 +
>>   drivers/scsi/ufs/ufs-configfs.c               | 237 ++++++++++++++++++++++++++
>>   drivers/scsi/ufs/ufshcd.c                     |   3 +-
>>   drivers/scsi/ufs/ufshcd.h                     |  18 ++
>>   6 files changed, 280 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
>>   create mode 100644 drivers/scsi/ufs/ufs-configfs.c
>>
>> diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
>> new file mode 100644
>> index 0000000..6743ea9
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/configfs-driver-ufs
>> @@ -0,0 +1,12 @@
>> +What:          /config/*/ufs_config_desc_X
>> +Date:          Jun 2018
>> +KernelVersion: 4.20
>> +Description:
>> +               This file shows bytes of the current ufs configuration descriptor
>> +               with index X (where X = 0/1/2/3) set in device. This can be used to
>> +               provision ufs device if bConfigDescrLock is 0.
>> +               For more details, refer 14.1.6.3 Configuration Descriptor and
>> +               table 14-12 - Unit Descriptor configurable parameters from specs for
>> +               description and format of each configuration descriptor parameter.
>> +               Parameters of Configuration descriptor buffer for respective index
>> +               needs to be passed as bytes in space separated format.
>> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
>> index e27b4d4..6e7ff35 100644
>> --- a/drivers/scsi/ufs/Kconfig
>> +++ b/drivers/scsi/ufs/Kconfig
>> @@ -100,3 +100,13 @@ config SCSI_UFS_QCOM
>>
>>            Select this if you have UFS controller on QCOM chipset.
>>            If unsure, say N.
>> +
>> +config SCSI_UFS_PROVISION
>> +       bool "Runtime UFS Provisioning support"
>> +       depends on SCSI_UFSHCD && CONFIGFS_FS
>> +       help
>> +         This enables runtime UFS provisioning support. This can be used
>> +         primarily during assembly line as some devices may be required to
>> +         be configured multiple times during initial development phase.
>> +
>> +         If unsure, say N.
>> diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
>> index 918f579..09880b9 100644
>> --- a/drivers/scsi/ufs/Makefile
>> +++ b/drivers/scsi/ufs/Makefile
>> @@ -5,5 +5,6 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-d
>>   obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
>>   obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
>>   ufshcd-core-objs := ufshcd.o ufs-sysfs.o
>> +obj-$(CONFIG_SCSI_UFS_PROVISION) += ufs-configfs.o
> Hi Sayali,
> Can you try both of your patches with "make allmodconfig". There seem
> to be a few issues compiling in that configuration. Also, as it stands
> this file is either not compiled in, or baked into the kernel, where
> it really should go into the driver. Check out the patch below for how
> Guenter patched things up in our tree:
>
> shttps://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1255524
[Sayali] : the change pointed by you above looks good to me and will 
update it in my patch as well. ufs-configfs should be part of ufshcd-core.
I tried using "make allmodconfig".(basically updating like below for 
test) + include change pointed above and it works fine.
+CONFIG_CONFIGFS_FS=y

+CONFIG_SCSI_UFSHCD=m
+CONFIG_SCSI_UFSHCD_PLATFORM=m
+CONFIG_SCSI_UFS_PROVISION=y


