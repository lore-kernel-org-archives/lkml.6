Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F91218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AE3fusPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfB0GOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:14:55 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7001 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfB0GOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:14:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c762ade0000>; Tue, 26 Feb 2019 22:14:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Feb 2019 22:14:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Feb 2019 22:14:54 -0800
Received: from [10.24.44.186] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Feb
 2019 06:14:52 +0000
Subject: Re: [PATCH v2] ARM: tegra: enforce PM requirement
To:     Dmitry Osipenko <digetx@gmail.com>, <linux@armlinux.org.uk>,
        <jhogan@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <1551169537-17548-1-git-send-email-spujar@nvidia.com>
 <86293ce9-fb0d-3412-df9a-0ff380ab2eb6@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <d4aa4839-dfec-e4f0-a82d-7ed7d023c380@nvidia.com>
Date:   Wed, 27 Feb 2019 11:44:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <86293ce9-fb0d-3412-df9a-0ff380ab2eb6@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551248094; bh=Eb39lkOCkuavddsMzGvmWQ4pyOpLz3N6P0bsZKf4xfo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=AE3fusPIUva1bWDWYnhCgpkNynUbbh3Lv3a8q58Gs/tLE9JW5zcMkNB1NT5hCrkRj
         mkP2fe0CtQX7uomu5Om8Qzb6vOJCW2X3HocKpKj6R58zC8qLVNyxcEe+UmuBmA8p+c
         2JADyrZYJLMgkukKhknHlEt8zHzSxlLEAZZErVWXCquJj4cAIyDGfIOSr9SbEv/R5G
         /gwD43rnEAmXAg8efawx3d2PI1g9YjELpbNyGC/iLO2Uqh14JIk1GKaKn1XPcGcaVg
         vohspHEFa6iV9L/AiuV5ca3ipKdiYbeCMgmJX4G15U79q30VR7w1jF72KzaX1DrVyY
         2OLE8ZqRTfqCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/26/2019 8:16 PM, Dmitry Osipenko wrote:
> 26.02.2019 11:25, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> The requirement for this came while adding runtime PM support for HDA
>> driver. There were concerns about driver explicitly handling !PM case.
>> In general, drivers need to handle !PM case with work arounds for
>> managing clocks and power explicitly, which is not really necessary
>> when PM support on tegra is in good shape. In fact ARM 64-bit Tegra
>> platforms enforce PM support and there is no reason why this cannot be
>> done for 32-bit.
>>
>> More details with regards to above can be found in following patch,
>> http://patchwork.ozlabs.org/patch/1036645/
> I think you meant this: https://patchwork.ozlabs.org/patch/1031007/
my bad! Thanks for pointing.
