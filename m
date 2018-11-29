Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD742C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E89120834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="inn7xmpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E89120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeK2RsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:48:21 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4925 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeK2RsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:48:21 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bff8a870000>; Wed, 28 Nov 2018 22:43:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 28 Nov 2018 22:44:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 28 Nov 2018 22:44:02 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 29 Nov
 2018 06:43:59 +0000
Subject: Re: [PATCH v3 1/3] thermal: tegra: remove unnecessary warnings
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <1543383877-20555-1-git-send-email-wni@nvidia.com>
 <1543383877-20555-2-git-send-email-wni@nvidia.com>
 <20181128101227.GB20723@ulmo>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <65fd540d-f05c-ab53-1c14-b9f3679ec2a3@nvidia.com>
Date:   Thu, 29 Nov 2018 14:43:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128101227.GB20723@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543473799; bh=jBy5/85SYtj3fo/oMeZA3Cvvxoegd9ZS2okq8FXybfc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=inn7xmpOkF7IZqEuIlKan0LGCGh6z0injUtXHiyYf30DIxLcD+4VdLoBOa5CrBj9+
         dDh9SK4Hr9tGOV+d6Gusb3Bj7b+JFYs2IC9VnHV3ulBO17aeU1Prib9VgoxLECvj/B
         3QE04OvYc/6UdCt4S1ZAex7xBrVFCMuOSpszTIpsTS+J4obX5OH+pYrJzOafjuJuDR
         48ugkjwiCED6VwoOQ6IC3iwF+YWYvdfR2F2MhsntlOPD1fZQdZG8tEKRLXFnUTs5Em
         IK7pq3+RfFYc2PI/CjToBWU5iDlApRoRa+1xolPs7xF3c9XLCmBiBJQZxfYY6lv74c
         5zXNyP4W9pnQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/2018 6:12 PM, Thierry Reding wrote:
> On Wed, Nov 28, 2018 at 01:44:35PM +0800, Wei Ni wrote:
>> Convert warnings to info as not all platforms may
>> have all the thresholds and sensors enabled.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> If these are all optional anyway, why even keep the informational
> messages? While those may not show up as warnings in the log, they will
> still be unconditional noise in the kernel log. Do we really want that,
> or should we just trust that the DT is correct and shut up if optional
> thresholds and sensors are not present?
> 
> Thierry

I think we can trust the DT files, but these trip points are important,
it's better to notify user about these information. And user also can
change log level to control these messages.

Thanks.
Wei.
> 
