Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C0F218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mnSCuDYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfB0GRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:17:06 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18387 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfB0GRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:17:06 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c762b5c0002>; Tue, 26 Feb 2019 22:17:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Feb 2019 22:17:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Feb 2019 22:17:05 -0800
Received: from [10.24.44.186] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 06:17:03 +0000
Subject: Re: [PATCH v2] ARM: tegra: enforce PM requirement
To:     Dmitry Osipenko <digetx@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     <jhogan@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>
References: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
 <20190226091308.ycruijz2lcziv5gt@shell.armlinux.org.uk>
 <562c4307-74ad-fd9d-74e7-36ac19315d0b@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <92ca8288-3b57-0683-83fa-445e2be42086@nvidia.com>
Date:   Wed, 27 Feb 2019 11:47:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <562c4307-74ad-fd9d-74e7-36ac19315d0b@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551248221; bh=W8vsZ2Kifl5T5G9AeWtPcKM6+uv18ftpyIdzfFUQvA0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=mnSCuDYw2UopLOeRbZQrZrHGeY3BLp7vqP2XklrQU9QeMv/C2JwRlTqtBQXwU1T3H
         GfGaAhBIuzew9YgK+gaV8sP/ID+gRiSNP7IiLjnx5ztyppIfDbHTpOtY22t/fDe4Kf
         /5PGmcK21jJu+nt+ecm016JjJP874D0dHbluyIQZ94QmFVvd9Bh9aGEvpF+wroHD3v
         K5L2mFsbDQnOdaJaptjK4FuKWjtSsdggpBug11Pco5cKNREeKGiF6BeXhniOm0yEEU
         tTZbu1gQqRB9t4by4FfQfVE4+ideCQG4uFbzslXFb8UZUEN8rjmXls3B/OWedKO4Mw
         Mm3G2V5k4x/JQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/26/2019 10:22 PM, Dmitry Osipenko wrote:
> 26.02.2019 12:13, Russell King - ARM Linux admin =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
>> On Tue, Feb 26, 2019 at 01:55:37PM +0530, Sameer Pujar wrote:
>>> The requirement for this came while adding runtime PM support for HDA
>>> driver. There were concerns about driver explicitly handling !PM case.
>>> In general, drivers need to handle !PM case with work arounds for
>>> managing clocks and power explicitly, which is not really necessary
>>> when PM support on tegra is in good shape. In fact ARM 64-bit Tegra
>>> platforms enforce PM support and there is no reason why this cannot be
>>> done for 32-bit.
>>>
>>> More details with regards to above can be found in following patch,
>>> http://patchwork.ozlabs.org/patch/1036645/
>>>
>>> This patch selects PM unconditionally and drivers can rely on runtime
>>> PM framework for clock and power management.
>> What if the drivers are re-used on another SoC IP?  Doesn't this lead
>> to unexpected failures?
>>
>> If you want to do this, maybe also make those drivers depend on PM as
>> well?
> The commit message is inaccurate, it is intended for the Tegra HDA driver=
 and not for some generic driver. The overall final intent is to remove dep=
endency on the PM availability for all of Tegra drivers to "make Tegra main=
tainers life easier".
Wanted to convey that finally it would be the case for all Tegra=20
drivers. I will update commit message to make it more clear.
