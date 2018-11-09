Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB848C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA26720825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA26720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeKJGX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:23:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:49782 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeKJGX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:23:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 12:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,484,1534834800"; 
   d="scan'208";a="106817634"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2018 12:41:14 -0800
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH 0/4] Add SOCFPGA System Manager
To:     Lee Jones <lee.jones@linaro.org>
Cc:     peppe.cavallaro@st.com, dinguyen@kernel.org, linux@armlinux.org.uk,
        alexandre.torgue@st.com, joabreu@synopsys.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, arnd@arndb.de, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1537826946-18942-1-git-send-email-thor.thayer@linux.intel.com>
 <021aaa02-1138-e538-3d02-ff639541d0f3@linux.intel.com>
 <a095071e-bd46-e440-fc01-7e2bbaf5964a@linux.intel.com>
 <20181019061635.GH4939@dell>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <c08bf646-bf9f-5dad-acc8-6975acd6cff3@linux.intel.com>
Date:   Fri, 9 Nov 2018 14:43:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019061635.GH4939@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 10/19/18 1:16 AM, Lee Jones wrote:
> On Wed, 17 Oct 2018, Thor Thayer wrote:
> 
> 
>> On 10/10/2018 09:42 AM, Thor Thayer wrote:
>>> Hi
>>> On 09/24/2018 05:09 PM, thor.thayer@linux.intel.com wrote:
>>>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>>>
>>>> Add MFD driver for ARM64 SOCFPGA System Manager to steer
>>>> System Manager calls appropriately.
>>>> The SOCFPGA System Manager includes registers from several
>>>> SOC peripherals.
>>>>
>>>> On ARM32, syscon handles this aggregated register grouping.
>>>> Redirect System Manager calls to syscon for ARM32 SOCFPGA
>>>> systems.
>>>>
>>>> The ARM64 System Manager can only be accessed from priority
>>>> level EL3 so this new MFD driver handles the calls to EL3.
>>>>
>>>> Thor Thayer (4):
>>>>     mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
>>>>     ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
>>>>     arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
>>>>     net: stmmac: socfpga: Convert to shared System Manager driver
>>>>
>>>>    MAINTAINERS                                        |   6 +
>>>>    arch/arm/configs/socfpga_defconfig                 |   1 +
>>>>    arch/arm64/configs/defconfig                       |   1 +
>>>>    drivers/mfd/Kconfig                                |   9 +
>>>>    drivers/mfd/Makefile                               |   1 +
>>>>    drivers/mfd/altera-sysmgr.c                        | 310
>>>> +++++++++++++++++++++
>>>>    .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   4 +-
>>>>    include/linux/mfd/altera-sysmgr.h                  | 113 ++++++++
>>>>    8 files changed, 444 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/mfd/altera-sysmgr.c
>>>>    create mode 100644 include/linux/mfd/altera-sysmgr.h
>>>>
>>> Gentle ping.
>>
>> Gentle ping again...
>>
>> Any comments on this patch series?
> 
> "Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> Sending content free pings just adds to the mail volume (if they are
> seen at all) and if something has gone wrong you'll have to resend the
> patches anyway so resending with any comments addressed is generally a
> much better approach."
> 
> In this case, the we are too late in the series to have these
> applied.  Maintainers are generally preparing their submissions for
> the merge-window.  The MFD component of this set is marked as "To
> Review" and I will get around to it when time is more abundant.
> 

Gentle ping now that the merge window is over.

I'm not clear on the scolding for content free pings.

Other pings I've seen just reference the patch series summary instead of 
each patch individually. It seems like pings for each patch would add 
more to the mail volume than the summary but perhaps I'm 
misunderstanding something.  I'm happy to ping each patch separately if 
that is preferable.

Series can be found here:
https://patchwork.kernel.org/cover/10612891/

[PATCH 1/4] mfd: altera-sysmgr: Add SOCFPGA System Manager
[PATCH 2/4] ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
[PATCH 3/4] arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
[PATCH 4/4] net: stmmac: socfpga: Use shared System Manager driver

Thanks,

Thor
