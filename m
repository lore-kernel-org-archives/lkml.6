Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D8B1625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B5B20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B5B20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbeG3TQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:16:01 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46204 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeG3TQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:16:01 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fkC9A-0003nV-Hq; Mon, 30 Jul 2018 18:39:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Jul 2018 18:39:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org
Subject: Re: [Linux-kernel] [PATCH 2/4] ASoC: tegra: Add a TDM configuration
 callback
In-Reply-To: <20180730150749.GK5789@sirena.org.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
 <2392df6f-12bc-74fe-ec0f-50dbb7b9a33a@nvidia.com>
 <20180730101800.GF5789@sirena.org.uk>
 <2a91268d-351b-d342-42bd-8ffbf33a316e@nvidia.com>
 <20180730150749.GK5789@sirena.org.uk>
Message-ID: <a1289d568db3a5008ab11006b4c04952@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-30 16:07, Mark Brown wrote:
> On Mon, Jul 30, 2018 at 03:04:46PM +0100, Jon Hunter wrote:
>> On 30/07/18 11:18, Mark Brown wrote:
> 
>> > DSP modes only care about the rising edge of the LRCLK, the pulse can be
>> > any width without causing interoperability problems.
> 
>> OK, thanks I was not able to find a spec that defines this, but I saw 
>> a
>> lot of codecs use a single bit clock width. So then equally making the
>> default '1' should also be fine.
> 
> There's not really a spec for this, it's just what tends to be
> implemented.
> 
>> I still do not like configuring the fsync width in this function. The
>> fsync width needs to be configured for both DSP modes and normal I2S
>> modes and so it seems it would be more appropriate to do this in the
>> hw_params function for this driver.
> 
> You *could* just always use the I2S width, it's going to look odd when
> people use a scope but it will work most of the time.

We did this as we were dealing with a legacy system in which we didn't
know if this was important setting or not, so we tried to make the
settings as close as possible to the original nvidia supplied source.

-- 
Ben
