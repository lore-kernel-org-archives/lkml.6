Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE78CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CAF20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I1GEomhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CAF20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeKIRAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:00:44 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13713 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeKIRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:00:44 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be535800000>; Thu, 08 Nov 2018 23:21:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Nov 2018 23:21:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Nov 2018 23:21:27 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Nov
 2018 07:21:25 +0000
Subject: Re: [PATCH v1 2/4] thermal: tegra: remove unnecessary warnings
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
 <1541410354-19090-3-git-send-email-wni@nvidia.com>
 <20181108124716.GE1340@ulmo>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <ec9e034a-2789-2433-aad7-8d493d2d67c8@nvidia.com>
Date:   Fri, 9 Nov 2018 15:21:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108124716.GE1340@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541748096; bh=Iiig5s98u9Xf5DK2oxUWZuYzaQeqcyDfdMuYIpLwGRE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I1GEomhlflpkgx2iVepRiNGUVwB8ndqH7BKaMgucTatLht53le2pQWB2QyP6kh/Ef
         M6+2NGaC01UTyN7HUVxOzmcZoBHxIoXxA+lSCqIcSpPjWU9KZYZJV6vz1Sy7Rm2Dkt
         OOUQsdsyqLirXEGrM3HmUts54KVVtUeKuD6nHmxT8Dzuhx3HdsjaY4E848R1y2eLv5
         wO+yB+27LWLKEEstC2K/aBaW8FPR4XREid/mwqNOeovXzyzxDvpYfWSqCSSd2uOBJO
         riJi/86v0A1E/lEbKYJJ2FegV4Azj18EbWWs8RQl/aH0LF8Q/sQkq3c/mrnc6f5a6K
         xO6YoGcrExb4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2018 8:47 PM, Thierry Reding wrote:
> On Mon, Nov 05, 2018 at 05:32:32PM +0800, Wei Ni wrote:
>> Convert warnings to info as not all platforms may
>> have all the thresholds and sensors enabled.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> This seems overly generalized to me. Shouldn't we be checking in a more
> fine-grained way for the absence of thresholds and/or sensors?
> 
> Otherwise, how are going to make the difference between the sensor not
> being enabled or the device tree just missing the information?
> 
The sensor being enabled or not is controlled by device tree, if the dts
have the corresponding nodes, then the sensors should be enabled. And
the thresholds for sensor are not necessary, so I think we just need to
print out them.
BTW, in my patch 1/4, I should print out the sensor name if the sensor
not enabled and register failed.
Will update it.

> Thierry
> 
