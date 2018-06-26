Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED223C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DE326D49
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DE326D49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeFZPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:51:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19486 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeFZPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:51:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3261130000>; Tue, 26 Jun 2018 08:51:47 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Jun 2018 08:51:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Jun 2018 08:51:45 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Jun
 2018 15:51:42 +0000
Subject: Re: [GIT PULL] RTC for 4.18
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180610221645.GA26123@piout.net>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
Date:   Tue, 26 Jun 2018 16:51:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180610221645.GA26123@piout.net>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 10/06/18 23:16, Alexandre Belloni wrote:
> Hi Linus,
> 
> Here is the pull-request for the RTC subsystem for 4.18.
> 
> Setting the supported range from drivers for RTCs failing soon has
> started. A few fixes are developed along the way.
> Some drivers have been switched to SPDX by their maintainers.
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.18
> 
> for you to fetch changes up to e4302aec8a0646828a701443e303eb5ef48b37f5:
> 
>   rtc: pxa: fix probe function (2018-06-07 20:11:08 +0200)
> 
> ----------------------------------------------------------------
> RTC for 4.18
> 
> Subsystem:
>  - rework of the rtc-test driver which allows to test the core more thoroughly
>  - rtc_set_alarm() now fails early when alarms are not supported
> 
> Drivers:
>  - mktime is now replaced by mktime64
>  - RTC range added for 88pm80x, ab-b5ze-s3, at91rm9200, brcmstb-waketimer,
>    ds1685, ftrtc010, ls1x, mxc_v2, rx8581, sprd, st-lpc, tps6586x, tps65910 and
>    vr41xx
>  - Fixed a possible race condition in probe functions
>  - pxa: fix the probe function that is broken since v4.3
>  - stm32: now supports stm32mp1
> 
> ----------------------------------------------------------------
> Alexandre Belloni (49):

...

>       rtc: tps6586x: let the core handle rtc range

Sorry I am missing the original mail with the above change, but I
have noticed on v4.18-rc1 that rtc wake-ups from suspend are no
longer working on one of our Tegra boards. The bisect points to the
above change and reverting it fixes the problem. I have not had
chance to dig further, but if you have any thoughts, please let me
know.

Thanks!
Jon

-- 
nvpublic
