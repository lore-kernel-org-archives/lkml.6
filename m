Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA7DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022E82086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022E82086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeJPSrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:47:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:34730 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPSrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:47:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 03:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="78396519"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2018 03:57:11 -0700
Subject: Re: [PATCH V2 0/5] Tegra xHCI genpd support
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <6a7cda6b-2f2f-43ee-7a53-8b226fdcc88d@nvidia.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <b41a6528-f36f-1d12-3785-95474b00cf97@intel.com>
Date:   Tue, 16 Oct 2018 14:00:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6a7cda6b-2f2f-43ee-7a53-8b226fdcc88d@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.2018 15:40, Jon Hunter wrote:
> Hi Mathias,
> 
> On 28/09/18 15:11, Jon Hunter wrote:
>> This series add genpd support for the Tegra xHCI device that requires
>> more than one power-domain to operate.
>>
>> This series is making changes to more than one subsystem and at first
>> glance may look like a maintainers nightmare. However, my proposal is
>> this, once reviewed and people are happy ...
>> 1. Patches 1-3 should be merged first. Patches 1 can go via the Tegra
>>     tree and 2-3 via the USB tree.
>> 2. Once patches 1-3 are accepted, then 4 and 5 can be merged via the
>>     Tegra tree.
>>
>> Changes since V1:
>> - Dropped unneeded patch to export symbol for genpd API
>> - Added patch to power-off XUSB domains
>> - Slight re-work to Tegra xHCI driver changes to simplify clean-up path.
>>
>> Jon Hunter (5):
>>    dt-bindings: usb: xhci-tegra: Add power-domain details
>>    usb: xhci: tegra: Power-off power-domains on removal
>>    usb: xhci: tegra: Add genpd support
>>    soc/tegra: pmc: Don't power-up XUSB power-domains
>>    arm64: dts: tegra210: Add power-domains for xHCI
> 
> Let me know you are ok to pick up patches 2 and 3 for v4.20.
> 

Patches 2 and 3 look good to me.
I'll resend them to Greg

-Mathias
