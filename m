Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED46C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E7C214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E7C214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbeHBOMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:12:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5873 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbeHBOMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:12:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b62f7390000>; Thu, 02 Aug 2018 05:21:15 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Aug 2018 05:21:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Aug 2018 05:21:27 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Aug
 2018 12:21:22 +0000
Subject: Re: [PATCH 1/3] soc/tegra: pmc: set IO pad power state and voltage
 via pinctrl fw
To:     Venkat Reddy Talla <vreddytalla@nvidia.com>, <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <pdeschrijver@nvidia.com>,
        <vivek.gautam@codeaurora.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <mperttunen@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <avienamo@nvidia.com>, <talho@nvidia.com>, <ldewangan@nvidia.com>
References: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <76f4442e-842b-c08f-386d-a7062ed34a19@nvidia.com>
Date:   Thu, 2 Aug 2018 13:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/08/18 12:59, Venkat Reddy Talla wrote:
> The IO pins of Tegra SoCs are grouped for common control
> of IO interface like setting voltage signal levels and
> power state of the interface. These groups are referred
> to as IO pads.The power state and voltage control of IO pins
> can be done at IO pads level.
> 
> Tegra SoCs support powering down IO pads when they are
> not used even in the active state of system.
> This saves power from that IO interface. Also it supports
> multiple voltage level in IO pins for interfacing on
> some of pads. The IO pad voltage is automatically detected
> till Tegra124, hence SW need not to configure this.
> But from Tegra210, the automatic detection logic has been
> removed, hence SW need to explicitly set the IO pad
> voltage into IO pad configuration registers.
> 
> Add support to configure the power state and voltage level
> of the IO pads from client driver via pincontrol framework.
> 
> Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>

This appears to be a duplicate effort of the following which we have
been reviewing ...

https://marc.info/?l=linux-tegra&m=153295930808915&w=2

Cheers
Jon

-- 
nvpublic
