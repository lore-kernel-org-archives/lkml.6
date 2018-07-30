Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2172B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BB120893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BB120893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbeG3Pj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:39:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6026 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeG3Pj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:39:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5f1af70000>; Mon, 30 Jul 2018 07:04:39 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Jul 2018 07:04:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Jul 2018 07:04:50 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 30 Jul
 2018 14:04:48 +0000
Subject: Re: [PATCH 2/4] ASoC: tegra: Add a TDM configuration callback
To:     Mark Brown <broonie@kernel.org>
CC:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        <lgirdwood@gmail.com>, <thierry.reding@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-kernel@lists.codethink.co.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
 <2392df6f-12bc-74fe-ec0f-50dbb7b9a33a@nvidia.com>
 <20180730101800.GF5789@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2a91268d-351b-d342-42bd-8ffbf33a316e@nvidia.com>
Date:   Mon, 30 Jul 2018 15:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730101800.GF5789@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/07/18 11:18, Mark Brown wrote:
> On Mon, Jul 30, 2018 at 10:31:16AM +0100, Jon Hunter wrote:
> 
>> It can be quite common for the fsync-width for DSP modes to be a single clock and so 
>> I am not sure that is makes sense to set this here always to the slot width. It maybe
>> worth considering add a DT property for specifying the fsync width.
> 
> DSP modes only care about the rising edge of the LRCLK, the pulse can be
> any width without causing interoperability problems.

OK, thanks I was not able to find a spec that defines this, but I saw a
lot of codecs use a single bit clock width. So then equally making the
default '1' should also be fine.

I still do not like configuring the fsync width in this function. The
fsync width needs to be configured for both DSP modes and normal I2S
modes and so it seems it would be more appropriate to do this in the
hw_params function for this driver.

Cheers
Jon

-- 
nvpublic
