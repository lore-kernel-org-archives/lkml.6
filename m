Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2221DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D065720873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JTsJFMRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D065720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeLLGoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:44:46 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19697 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLGop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:44:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c10ae590000>; Tue, 11 Dec 2018 22:44:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 11 Dec 2018 22:44:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 11 Dec 2018 22:44:44 -0800
Received: from [10.24.242.30] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 06:44:41 +0000
Subject: Re: [PATCH V2] kmemleak: Add config to select auto scan
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-tegra@vger.kernel.org>, <snikam@nvidia.com>,
        <vdumpa@nvidia.com>, <talho@nvidia.com>, <swarren@nvidia.com>,
        <treding@nvidia.com>
References: <1540231723-7087-1-git-send-email-prpatel@nvidia.com>
 <20181029104320.GC168424@arrakis.emea.arm.com>
From:   Prateek Patel <prpatel@nvidia.com>
Message-ID: <a51a7d4b-6366-ea10-f220-992525ec1d42@nvidia.com>
Date:   Wed, 12 Dec 2018 12:14:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181029104320.GC168424@arrakis.emea.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544597081; bh=9Ky/oj/z+AJ7tF2esDKmqv4eVtaSRuQsAjwXILNKMSM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=JTsJFMRhFZad8vHtnruHKCEjsLr/KP0tePagcGilfQpMF/02E2S3CB+rgBXnT0DrT
         6fbIJ9KrS3BVyDLkFqcyPbMKuTphbOxWPIgKPthYleErB/EyBaT3dNrizTROgI5rt4
         5V2FBaGHxDkyPvuGJPpAK5lT6Slhbo30BuretBEgq22153LFHRvmudHS+H65eMI8Ck
         YC745EVgCTH4MkPDfvMgUaRk1Yl4lrUaUvw1610gbO4mRASdtMfEhmfssMqeVY4sOc
         EKCoYT7+6d5w53jeMQTOV6C4dZ81DvGL0nFtvlQFxC95/sk3uZ0WPz1dydtDxhnLeS
         ADoR7wIRh16yQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Can you mark this patch as acknowledged so that it can be picked up by 
the maintainer.

Adding Andrew.

Thanks,

On 10/29/2018 4:13 PM, Catalin Marinas wrote:
> On Mon, Oct 22, 2018 at 11:38:43PM +0530, Prateek Patel wrote:
>> From: Sri Krishna chowdary <schowdary@nvidia.com>
>>
>> Kmemleak scan can be cpu intensive and can stall user tasks at times.
>> To prevent this, add config DEBUG_KMEMLEAK_AUTO_SCAN to enable/disable
>> auto scan on boot up.
>> Also protect first_run with DEBUG_KMEMLEAK_AUTO_SCAN as this is meant
>> for only first automatic scan.
>>
>> Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
>> Signed-off-by: Sachin Nikam <snikam@nvidia.com>
>> Signed-off-by: Prateek <prpatel@nvidia.com>
> Looks fine to me.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
