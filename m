Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10434C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D002120989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W6zc69Ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfAUJ1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:27:05 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3275 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfAUJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:27:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4590570000>; Mon, 21 Jan 2019 01:26:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 21 Jan 2019 01:27:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 21 Jan 2019 01:27:03 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 21 Jan
 2019 09:27:01 +0000
Subject: Re: [PATCH v1 00/12] Add some functionalities for Tegra soctherm
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-2-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <ce989feb-e179-98d1-59d4-e7619ceff26a@nvidia.com>
Date:   Mon, 21 Jan 2019 17:26:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545118484-23641-2-git-send-email-wni@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548062807; bh=9Ed1taDw9K8vdKI5A5qjdPsrC5D5SPJ/1srptDqHpNw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W6zc69Ak49/8Ng7XJyKAXbZLIOydM9NdHybRvP7mKnhmDaZYfYAOaqQkjI1Nt7/W0
         Dz+nyJlK+mxSk+M9ELzTW/S9xC8nhxvzBH6u6KvbVs9/wmtSxN4VdLnne0iVEg0za+
         vz5Rx55WQv69f0kgI3s/F4K0a0Mw2LYeowKmIpTkF+7E3AG7Qinrva4ywdTJyOFXEg
         GbC2vfa7BL3k8B3Xozh+KEf86/0RNDKq1PVKvcVDZl5lRblPUB1gQJ3Eydfc6E3L0f
         A9ncBM05M73QGtXsP1P8i3DtodPEicxKsk+t4P+cbCWiKUqENYc9pvTfwZNGBWRGdm
         bWegwOvV8eDgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,
Could you please take a look this serial?

Thanks.
Wei.

On 18/12/2018 3:34 PM, Wei Ni wrote:
> Move the hw/sw shutdown patches into this serial. There already have
> some discussion for it in https://lkml.org/lkml/2018/12/7/225.
> Support GPU HW throttle, thermal IRQ, set_trips(), EDP IRQ and OC
> hw throttle.
> 
> Wei Ni (12):
>   of: Add bindings of thermtrip for Tegra soctherm
>   thermal: tegra: support hw and sw shutdown
>   arm64: dts: tegra210: set thermtrip
>   of: Add bindings of gpu hw throttle for Tegra soctherm
>   thermal: tegra: add support for gpu hw-throttle
>   arm64: dts: tegra210: set gpu hw throttle level
>   thermal: tegra: add support for thermal IRQ
>   thermal: tegra: add set_trips functionality
>   thermal: tegra: add support for EDP IRQ
>   arm64: dts: tegra210: set EDP interrupt line
>   of: Add bindings of OC hw throttle for Tegra soctherm
>   thermal: tegra: enable OC hw throttle
> 
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  63 +-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  20 +-
>  drivers/thermal/tegra/soctherm.c                   | 959 +++++++++++++++++++--
>  drivers/thermal/tegra/soctherm.h                   |  16 +
>  drivers/thermal/tegra/tegra124-soctherm.c          |   7 +-
>  drivers/thermal/tegra/tegra132-soctherm.c          |   7 +-
>  drivers/thermal/tegra/tegra210-soctherm.c          |  15 +-
>  include/dt-bindings/thermal/tegra124-soctherm.h    |  22 +-
>  8 files changed, 1033 insertions(+), 76 deletions(-)
> 
