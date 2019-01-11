Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F093CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9A42084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NRsDEmB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfAKCjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:39:02 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12744 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfAKCjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:39:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c37fd710000>; Thu, 10 Jan 2019 18:20:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 18:20:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Jan 2019 18:20:51 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 02:20:49 +0000
Subject: Re: [PATCH v7 0/3] Fixes for Tegra soctherm
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <28d197f9-9b72-78ad-0769-7514d329b3c4@nvidia.com>
Date:   Fri, 11 Jan 2019 10:20:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1546510369-28491-1-git-send-email-wni@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547173233; bh=/Lx902UbF/vDxwf1WgCy40MUrdwKsvQxe2PEaqzlcW4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NRsDEmB0U+fi6H48j7ymVSLhL6FddIk8kjrm9khKpw46lP91GoaUsZoWjP+4gZ3QX
         5T2WU6X/vd3p0qh1VcvIAS4L7s/YARGXlmXLHuleB/1UOQcXMo1joRKNAwMZDuLyo9
         9yyDJkBSZ8tVy/gfHl8kfUBXOI/+e981Ite4bs3HptBmhLERpv7ne7rOV1IUmajv0n
         FOwi37d7+BvBFXEeY2s6Hk24EB6dQIiV4lTnNRJgw+8LRQA2f+XVevdNpzt0rZiC3t
         k5nEbloAst6CGOjZjCxv2XTc7kj1QTaCu1TUiPLwHAyJo7zLNIEm9dWojR+pCa0lzD
         hoxsmIDP2+6kA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,
Do you have any more comments, will you take this serial?

Thanks.
Wei.

On 3/1/2019 6:12 PM, Wei Ni wrote:
> This series fixed some issues for Tegra soctherm,
> and add get_trend().
> 
> Main changes from v6:
> 1. Per Eduardo's comment, we can remove the change:
> "thermal: tegra: parse sensor id before sensor register"
> 
> Main changes from v5:
> 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
> into this serial.
> 
> Main changes from v4:
> 1. fixed for the parsing sensor id.
> 2. keep warning for missing critical trips.
> 
> Main changes from v3:
> 1. updated codes for parsing sensor id, per Thierry's comments
> 
> Main changes from v2:
> 1. add codes to parse sensor id to avoid registration
> failure.
> 
> Main changes from v1:
> 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
> "thermal: tegra: fix memory allocation".
> 2. Print out the sensor name when register failed.
> 2. Remove patch "thermal: tegra: fix coverity defect"
> 
> Wei Ni (3):
>   thermal: tegra: remove unnecessary warnings
>   thermal: tegra: fix memory allocation
>   thermal: tegra: add get_trend ops
> 
>  drivers/thermal/tegra/soctherm.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
