Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB33C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307BE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XEjl/NQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307BE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeJLQNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:13:01 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16092 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbeJLQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:13:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc05e460000>; Fri, 12 Oct 2018 01:41:42 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 01:41:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 12 Oct 2018 01:41:39 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 08:41:37 +0000
Subject: Re: [PATCH V2 3/5] usb: xhci: tegra: Add genpd support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-4-git-send-email-jonathanh@nvidia.com>
 <20181011164753.GA7393@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <248afd79-1a7d-7342-5939-6fa998d04d5b@nvidia.com>
Date:   Fri, 12 Oct 2018 09:41:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011164753.GA7393@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539333702; bh=baFBWpbS77dsiKXVFG2f6UMSu2EP9TPkylSpkvyCZw8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XEjl/NQ775UxZVQYUv1kuu7u2kR6vWtXU3a63baSPITrMFN2xmmz/f0+dHVqiQH5F
         Vfr/KIlXo7HIqLuPdqwJRd4daVQcQatFUm992k0Ae+Iej+f/rg/2uKR9TNt+pJfWgf
         SWB8b3EBkcRgEeSsARHky7ZaKZuKLtsH/mbc80lHri/pxIO6aU0Kg5leI8fcPUqeHr
         B0sRb6dDVMifhT0aFEryBkz/ModxgsTWw7zn19WO3+xrkiteQ/jtfXEPuPSvZdVa6H
         QvkaDUGYVFHvtef3Zb5CDaATGOGC8MIQ92t5y/PgNfXzbXbPMXxUsx3Dp21CSiKJim
         eYrsnRX8lY/yQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/18 17:47, Thierry Reding wrote:
> On Fri, Sep 28, 2018 at 03:11:48PM +0100, Jon Hunter wrote:
>> The generic power-domain framework has been updated to allow devices
>> that require more than one power-domain to create a new device for
>> each power-domain required and then link these new power-domain
>> devices to the consumer device.
>>
>> Update the Tegra xHCI driver to use the new APIs provided by the
>> generic power-domain framework so we can use the generic power-domain
>> framework for managing the xHCI controllers power-domains. Please
>> note that to maintain backward compatibility with older device-tree
>> blobs these new generic power-domain APIs are only used if the
>> 'power-domains' property is present and otherwise we fall back to
>> using the legacy Tegra APIs for managing the power-domains.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/usb/host/xhci-tegra.c | 89 +++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 77 insertions(+), 12 deletions(-)
> 
> It'd be nice if we could eventually get rid of the legacy Tegra APIs,
> but that's a separate issue, and this patch looks fine as-is:

Unfortunately, I don't think it is possible as it will break DT backward
compatibility. However, one way to do it would be to force on all power
domains on boot if PM is not supported.

> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks!
Jon

-- 
nvpublic
