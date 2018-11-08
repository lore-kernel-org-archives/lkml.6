Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1465DC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAD520892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAD520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeKHVfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:35:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43571 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:35:53 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKizI-0006Nc-SR; Thu, 08 Nov 2018 13:00:41 +0100
Date:   Thu, 8 Nov 2018 13:00:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm64 + ARM64_64K_PAGES=y
Message-ID: <20181108120040.pzupzyqnsxeuv5ne@linutronix.de>
References: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ab7ee03-64fe-384a-c88f-f6d519b965db@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-06 15:34:55 [-0600], Grygorii Strashko wrote:
> Hi All,
Hi,

> Do anybody tried to use ARM64 RT with 76K pages enabled?

75 would be an off by one but this :)

> My attempt shows that enabling  CONFIG_ARM64_64K_PAGES=y increases latencies by ~30%
> 
> cyclictest -n -m -Sp98 -q -D2m with CONFIG_ARM64_64K_PAGES=y
> 
> 
> T: 0 (  772) P:98 I:1000 C: 120000 Min:      7 Act:   13 Avg:   10 Max:      85
> T: 1 (  773) P:98 I:1500 C:  79998 Min:      7 Act:   13 Avg:   10 Max:      71
> T: 2 (  774) P:98 I:2000 C:  59997 Min:      7 Act:   11 Avg:   11 Max:      64
> T: 3 (  775) P:98 I:2500 C:  47996 Min:      7 Act:   14 Avg:   12 Max:      66
> 
> 
> cyclictest -n -m -Sp98 -q -D2m with CONFIG_ARM64_64K_PAGES=n
> 
> 
> T: 0 (  697) P:98 I:1000 C: 120000 Min:      7 Act:   10 Avg:    9 Max:      38
> T: 1 (  698) P:98 I:1500 C:  79987 Min:      7 Act:   10 Avg:   10 Max:      32
> T: 2 (  699) P:98 I:2000 C:  59981 Min:      7 Act:   14 Avg:   11 Max:      46
> T: 3 (  700) P:98 I:2500 C:  47977 Min:      6 Act:   11 Avg:   10 Max:      45

So this is an idle system?
The Kconfig help says "faster TLB lookup". Interesting.
Are the 16k pages in between (latency wise) by any chance?

> -- 
> regards,
> -grygorii

Sebastian
