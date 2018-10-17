Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB4EECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8EE21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8EE21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeJQVxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:53:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:36434 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJQVxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:53:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 06:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="82180156"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2018 06:57:14 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH 0/4] Add SOCFPGA System Manager
From:   Thor Thayer <thor.thayer@linux.intel.com>
To:     lee.jones@linaro.org, peppe.cavallaro@st.com, dinguyen@kernel.org,
        linux@armlinux.org.uk, alexandre.torgue@st.com,
        joabreu@synopsys.com
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org, arnd@arndb.de,
        aisheng.dong@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
 <021aaa02-1138-e538-3d02-ff639541d0f3@linux.intel.com>
Message-ID: <a095071e-bd46-e440-fc01-7e2bbaf5964a@linux.intel.com>
Date:   Wed, 17 Oct 2018 08:59:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <021aaa02-1138-e538-3d02-ff639541d0f3@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping again...

Any comments on this patch series?

On 10/10/2018 09:42 AM, Thor Thayer wrote:
> Hi
> On 09/24/2018 05:09 PM, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add MFD driver for ARM64 SOCFPGA System Manager to steer
>> System Manager calls appropriately.
>> The SOCFPGA System Manager includes registers from several
>> SOC peripherals.
>>
>> On ARM32, syscon handles this aggregated register grouping.
>> Redirect System Manager calls to syscon for ARM32 SOCFPGA
>> systems.
>>
>> The ARM64 System Manager can only be accessed from priority
>> level EL3 so this new MFD driver handles the calls to EL3.
>>
>> Thor Thayer (4):
>>    mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
>>    ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
>>    arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
>>    net: stmmac: socfpga: Convert to shared System Manager driver
>>
>>   MAINTAINERS                                        |   6 +
>>   arch/arm/configs/socfpga_defconfig                 |   1 +
>>   arch/arm64/configs/defconfig                       |   1 +
>>   drivers/mfd/Kconfig                                |   9 +
>>   drivers/mfd/Makefile                               |   1 +
>>   drivers/mfd/altera-sysmgr.c                        | 310 
>> +++++++++++++++++++++
>>   .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   4 +-
>>   include/linux/mfd/altera-sysmgr.h                  | 113 ++++++++
>>   8 files changed, 444 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mfd/altera-sysmgr.c
>>   create mode 100644 include/linux/mfd/altera-sysmgr.h
>>
> Gentle ping.
> 
> Thor

