Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860DEC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B76920892
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RSSeJrmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B76920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJOUZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:25:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8741 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOUZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:25:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc48aa10000>; Mon, 15 Oct 2018 05:40:01 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Oct 2018 05:40:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Oct 2018 05:40:07 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 15 Oct
 2018 12:40:05 +0000
Subject: Re: [PATCH V2 0/5] Tegra xHCI genpd support
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6a7cda6b-2f2f-43ee-7a53-8b226fdcc88d@nvidia.com>
Date:   Mon, 15 Oct 2018 13:40:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539607201; bh=xB2azFjFz4vFvijKj9u5xeAcjYB91wPf4jdkt4EblPQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RSSeJrmiooVoVl1zt0RaILibcz9YldXJhioYWUdActbxy7Zdi0ANDVBiwpx9zRwjA
         RrhN1trUV61iQPAQ88x1P3yhW5EjDuTolhVWVr98jugUmW515gSa0Uns/gCe8IoBvf
         M49xcOV2nW6Y7fnhBj6rjgp1EdqRq7Mw+o7FsGf6AJQ2CwXLxyFJT2TeVQ0JR/DDIy
         IGoDKpNsJMqCLAGszYC4cUdTeEMflL2ikLzRb1jnC0Y6k0eVzmIC9UvmR7DwbwPVoh
         g26G9A+WzbLsacscJ16WXYLmTAKA8XHXaJWsM9PJa6GGmSIoZVUKF2sRN9sL+d8WoO
         9Hqkq1YJo0fwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 28/09/18 15:11, Jon Hunter wrote:
> This series add genpd support for the Tegra xHCI device that requires
> more than one power-domain to operate.
> 
> This series is making changes to more than one subsystem and at first
> glance may look like a maintainers nightmare. However, my proposal is
> this, once reviewed and people are happy ...
> 1. Patches 1-3 should be merged first. Patches 1 can go via the Tegra
>    tree and 2-3 via the USB tree.
> 2. Once patches 1-3 are accepted, then 4 and 5 can be merged via the
>    Tegra tree.
> 
> Changes since V1:
> - Dropped unneeded patch to export symbol for genpd API
> - Added patch to power-off XUSB domains
> - Slight re-work to Tegra xHCI driver changes to simplify clean-up path.
> 
> Jon Hunter (5):
>   dt-bindings: usb: xhci-tegra: Add power-domain details
>   usb: xhci: tegra: Power-off power-domains on removal
>   usb: xhci: tegra: Add genpd support
>   soc/tegra: pmc: Don't power-up XUSB power-domains
>   arm64: dts: tegra210: Add power-domains for xHCI

Let me know you are ok to pick up patches 2 and 3 for v4.20.

Cheers
Jon

-- 
nvpublic
