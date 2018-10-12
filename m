Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1E6C67869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0145F20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Mbuck2Do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0145F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJLPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:07:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14744 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeJLPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:07:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc04ee50000>; Fri, 12 Oct 2018 00:36:05 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 00:36:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Oct 2018 00:36:15 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 07:36:13 +0000
Subject: Re: [PATCH V2 1/5] dt-bindings: usb: xhci-tegra: Add power-domain
 details
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-2-git-send-email-jonathanh@nvidia.com>
 <20181011164952.GC7393@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <57da6e07-1f21-5ebd-7708-c606ee33e8fa@nvidia.com>
Date:   Fri, 12 Oct 2018 08:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011164952.GC7393@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539329765; bh=f4vMIB31iJ+ckC/RrJtJUJgxv1tPCzyKojcJstodRZ0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Mbuck2DojC+KCJryxrhZ+GTXQbL5zEzVUJ33WVRALqlhKaIXu478YeLxOI7i7U8sX
         jYr4G+all0vdPKq1OKoZ8tWOSO+yXX1kcinoB7xrNnNMoVwjwQm/FeuUNYwjksynJM
         or9VH7g//0uuHfqyiruaNAoRD2XhCUyqFSa8xSZRNdpy+kjO1BSDRozsQaaXEa+ZhM
         FkXGOxbWeIXZW4/Qtp+Zfj4eN3N4LEpGiy2aaNGu4WTFxpb5pehdi6IzgnbcsWLjNI
         C173BA7GuWwacf0Tu57VRbZznngRszn91wGS9yzoxvJlpd9/8QFEgheCQWWsLWrDHw
         ItES180aHa4yQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/18 17:49, Thierry Reding wrote:
> On Fri, Sep 28, 2018 at 03:11:46PM +0100, Jon Hunter wrote:
>> Add details for power-domains to the Tegra xHCI bindings so that
>> generic power-domains can be used for inconjunction with the xHCI
>> driver.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
>> index 3eee9e505400..4156c3e181c5 100644
>> --- a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
>> +++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
>> @@ -59,6 +59,14 @@ For Tegra210:
>>  - avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
>>  - dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
>>  - hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8 V.
>> +- power-domains: A list of PM domain specifiers that reference each power-domain
>> +  used by the xHCI controller. This list must comprise of a specifier for the
>> +  XUSBA and XUSBC power-domains. See ../power/power_domain.txt and
>> +  ../arm/tegra/nvidia,tegra20-pmc.txt for details.
>> +- power-domain-names: A list of names that represent each of the specifiers in
>> +  the 'power-domains' property. Must include 'xusb_ss' and 'xusb_host' which
> 
> Total bike-shed comment: maybe call these "superspeed" and "host" or
> something. The xusb_ prefix is kind of redundent because of the context.
> On the other hand, those are the names by which the power partitions are
> referred to, so either way:

I choose these names because they align with what we already have for
clocks ...

- clock-names: Must include the following entries:
   - xusb_host
   - xusb_host_src
   - xusb_falcon_src
   - xusb_ss
   - xusb_ss_src
   - xusb_ss_div2
   - xusb_hs_src
   - xusb_fs_src
   - pll_u_480m
   - clk_m
   - pll_e

However, I don't have a strong preference.

> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks!
Jon

-- 
nvpublic
