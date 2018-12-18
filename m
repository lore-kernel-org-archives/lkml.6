Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB92C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB055217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Hr3VV34j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLRHui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:50:38 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19227 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeLRHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:50:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c18a6c70000>; Mon, 17 Dec 2018 23:50:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Dec 2018 23:50:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Dec 2018 23:50:37 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 07:50:34 +0000
Subject: Re: [PATCH v1 00/12] Add some functionalities for Tegra soctherm
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>, <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <42b0cd92-ebf3-4e92-dda9-c9e2e4f88d3c@nvidia.com>
Date:   Tue, 18 Dec 2018 15:50:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545118484-23641-1-git-send-email-wni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545119431; bh=2R3kZSs7zNqJJzoK1IZxUILbD55KhpZfqTJjYV0vRBA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Hr3VV34jMY2AdX+Ou2dimUwW+zEzNwdTIR5kjk0xXcWtZxssolENlXBoDr+TJ4O0b
         Tbx5oBHH1kykxbXJG6PK5VzDMmy0L8J5/hNxsSKfP/Q4DaXXwiTLb8FJFBQhq+vEHH
         kcF+vWK+18n8MzOTDAYX6fvqun5R5MrTa/6oFTeWXQ5t1GGeLvyGFiOgm9Axou6XhJ
         IwpNE6cxv518D8/zO9n3TKKIhFlR5wJJjjb4uLht5LwS2REn6KwQ0OmMR3Q8gsZism
         BlXSffUfpAboli45b9rXYBGGdsNefue3uQADBJpo9Vk0QyNECtgKBTQ+yae/AqgI56
         TU5VFHwmjGmhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this cover-letter.

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
>  drivers/thermal/tegra/soctherm.c                   | 955 +++++++++++++++++++--
>  drivers/thermal/tegra/soctherm.h                   |  16 +
>  drivers/thermal/tegra/tegra124-soctherm.c          |   7 +-
>  drivers/thermal/tegra/tegra132-soctherm.c          |   7 +-
>  drivers/thermal/tegra/tegra210-soctherm.c          |  15 +-
>  include/dt-bindings/thermal/tegra124-soctherm.h    |  22 +-
>  8 files changed, 1029 insertions(+), 76 deletions(-)
> 
