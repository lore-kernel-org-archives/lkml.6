Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF3320870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SbZxBBQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF3320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeKTRdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:33:40 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3104 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbeKTRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:33:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3b25d0000>; Mon, 19 Nov 2018 23:06:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Nov 2018 23:06:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Nov 2018 23:06:05 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 07:06:03 +0000
Subject: Re: [PATCH v2 0/3] Fixes for Tegra soctherm
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1542103567-5521-1-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <74076ba9-d563-b07e-5c52-23cc742d0449@nvidia.com>
Date:   Tue, 20 Nov 2018 15:06:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542103567-5521-1-git-send-email-wni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542697565; bh=aVn0K4Kcw3NJoiEaFlS/LLdvXzVAgVIpRuTOz5ATDVA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SbZxBBQOWIOhjIVzdIDKdBJN9lH8uj8fR4PM3EDa6/6r6Mb2PJbrFLibEtzY5XBZL
         8dleEr8bTTsj/qaVlrZ41R0bHpBNgC8QSeZxzvVi65FmPj+//xmqm6Qt0cwsQIldB4
         tGkmYZWKpfHmrZ/RB840rsG4AUInUBP1xULiI9dgtc1P0cnz8m7p2xXLWXtpSZAS9v
         M+DxgPNJ3mTvJtLCQj448GAyahs5nBdtHR0PEhJr3bfKVxwjRFP4FQaHqgIiG/cByj
         4uhKW7Ji5z8kK7uJmeE4PWHgCxxPup4ptX2WUC3Y20Nf0gb+o/PmdveDD67Rvp8Yzx
         kslLA7JjUPDEw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Do you have any comments on this serial?

Thanks.
Wei.

On 13/11/2018 6:06 PM, Wei Ni wrote:
> This series fixed some issues for Tegra soctherm
> 
> Main changes from v1:
> 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
> "thermal: tegra: fix memory allocation".
> 2. Print out the sensor name when register failed.
> 2. Remove patch "thermal: tegra: fix coverity defect"
> 
> Wei Ni (3):
>   thermal: tegra: continue if sensor register fails
>   thermal: tegra: remove unnecessary warnings
>   thermal: tegra: fix memory allocation
> 
>  drivers/thermal/tegra/soctherm.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
