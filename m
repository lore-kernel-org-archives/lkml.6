Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3291FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B06208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B06208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391971AbeHPSYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:24:33 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1508 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbeHPSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:24:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b75975c0003>; Thu, 16 Aug 2018 08:25:16 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 Aug 2018 08:25:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 16 Aug 2018 08:25:11 -0700
Received: from [10.2.160.104] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 16 Aug
 2018 15:25:20 +0000
Subject: Re: [RFC PATCH] ASoC: core: Optimise suspend/resume of DAPM widgets
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <1533301025-19980-1-git-send-email-jonathanh@nvidia.com>
 <20180803163605.GD6591@sirena.org.uk>
 <7ba86328-5bb6-5280-df6f-9937173fb2ab@nvidia.com>
 <20180814144004.GD5810@sirena.org.uk>
 <e1bc40ec-de7e-2b77-d7f6-ec6b3066aeec@nvidia.com>
 <20180816105135.GZ2414@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b263b31d-6fcb-2ea6-f548-3db2b00846ab@nvidia.com>
Date:   Thu, 16 Aug 2018 16:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816105135.GZ2414@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/08/18 11:51, Mark Brown wrote:
> On Wed, Aug 15, 2018 at 07:48:47PM +0100, Jon Hunter wrote:
> 
>> So then I made the following change to avoid scheduling the function
>> calls unnecessarily (which I think should be fine) ...
> 
>> Please note that I am just using ktime_get() to log the time on entry
>> and exit from dapm_power_widgets() and so yes the time may not be
>> purely the time take to execute this function if we are preempted,
>> but I am measuring in the same way in both cases and so it does seem
>> to show some improvement.
> 
> That seems like a simple and useful optimization, will you send a patch?

Yes I will send a patch for this.

Cheers
Jon

-- 
nvpublic
