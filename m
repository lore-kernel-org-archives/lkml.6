Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E4FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039732177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d60XzpJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfBSKYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:24:35 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18748 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfBSKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:24:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6bd9690000>; Tue, 19 Feb 2019 02:24:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Feb 2019 02:24:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Feb 2019 02:24:33 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 10:24:30 +0000
Subject: Re: [RFT/RFC][PATCH] driver core: Fix PM-runtime for links added
 during consumer probe
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <14371356.imFjPFOrCi@aspire.rjw.lan>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <eeaa7369-31bb-293e-e585-6014e4bcdd14@nvidia.com>
Date:   Tue, 19 Feb 2019 10:24:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <14371356.imFjPFOrCi@aspire.rjw.lan>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550571881; bh=mRbLdYa0YQ4hDOEbu97IECr+bQAxsEB6jgUkcv3H+Y4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=d60XzpJIwPamCwQggxdyiV4NDkcHBpSVY2nHwdVy3LUWKcF4q2uzY1SAsqq1yHOcQ
         SmhF/ArgdNnUXa2XsegtiC/wwGk2kf9Q6mr0z0KwpLh3dc8XHUoitO96WwXigX1YnC
         74sYe8YTTMATJiKy4aiCxAIGqq1lhFMhTlTpeDtMauLhKmDiZJu66jsTZyN6MlyPMq
         V1p9URaJMwKla1gD8s+cIsn6LpvaTVQp+2NVuyG+fWa9u4lgR7V84s+5Znxcips4Lo
         6H1vvNIj8n0524kg+x02x/yMb6k10BVkUU6a3/3CbmqFRVLiC9PPsQDIOf0CtRyU7T
         TowRP5Rai67FQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/02/2019 22:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
> counter imbalance") introduced a regression that causes suppliers
> to be suspended prematurely for device links added during consumer
> driver probe if the initial PM-runtime status of the consumer is
> "suspended" and the consumer is resumed after adding the link and
> before pm_runtime_put_suppliers() is called.  In that case,
> pm_runtime_put_suppliers() will drop the rpm_active refcount for
> the link by one and (since rpm_active is equal to two after the
> preceding consumer resume) the supplier's PM-runtime usage counter
> will be decremented, which may cause the supplier to suspend even
> though the consumer's PM-runtime status is "active".
> 
> For this reason, partially revert commit 4c06c4e6cf63 as the problem
> it tried to fix needs to be addressed somewhat differently, and
> change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
> that the latter only drops rpm_active references acquired by the
> former.  [This requires adding a new field to struct device_link,
> but I coulnd't find a cleaner way to address the issue that would
> work in all cases.]
> 
> Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of driver-core/driver-core-next.
> 
> Jon, Ulf, please test!

Thanks Rafael this works for me!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
