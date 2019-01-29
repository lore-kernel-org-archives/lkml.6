Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF945214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aoq3/Eks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfA2Il7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:41:59 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1267 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfA2Il7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:41:59 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5011d70000>; Tue, 29 Jan 2019 00:41:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 00:41:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 00:41:58 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:41:57 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id C71E342960; Tue, 29 Jan 2019 10:41:55 +0200 (EET)
Date:   Tue, 29 Jan 2019 10:41:55 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Joseph Lo <josephl@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
Message-ID: <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com>
 <20190128150908.GB31317@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190128150908.GB31317@ulmo>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548751319; bh=18ujcK4X8+ABSQsap+FuXCbW+XgBeYw4vdjXGHfSnGE=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=aoq3/EksUH7+w14UrUvym6zauD2YE+vHsZ3WM9/os19lJiT2UbwMf4gO/qtWv2kUf
         n5KPwWv7XxgBicmvYadP+6bbhKaxiVysWjJGHQ0E3hMSSZWon7DPhO5YfEqvulu7Uw
         SWrkYn/O/NTIrbCD4ixwi2KbvhEj4EFn9UhswrbPQt9JULphGGmxOwKEORsIYliLDn
         0cBeM2f0nTZjFzsqCE8VKQnZIbOfNZwOwPFFkom7+99tXlgfSgJISdg4+ohBfaNNx5
         onJnCrGOrlrB6LYB5IKqj3s80S6U0MlBHZeN2qvTGMia9ZwcpbbCXCtfDgtE5oTu3O
         tCbWS5mz9MjNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:09:08PM +0100, Thierry Reding wrote:

...

> 
> Up to here this is a duplicate of timer-tegra20.c. And a lot of
> tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
> we unify the two drivers instead?
> 
> The power cycle restrictions of the architected timer, do they not apply
> to chips earlier than Tegra210 either? So don't we need all of these
> additional features on the timer-tegra20.c driver as well? If so that

No. Chips prior to Tegra114 do not have an arch timer and the arch timer
does work correctly on Cortex-A15 so Tegra114 and Tegra124 can use it.
It's broken on Cortex-A57 though, so we can't use it as a wakeup source
on Tegra210.

Peter.

