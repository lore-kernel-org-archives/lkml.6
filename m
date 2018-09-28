Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B380FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E620657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8E620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeI2CsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:48:17 -0400
Received: from muru.com ([72.249.23.125]:57694 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeI2CsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:48:17 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B1A2E80C0;
        Fri, 28 Sep 2018 20:27:17 +0000 (UTC)
Date:   Fri, 28 Sep 2018 13:22:51 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Maciej Purski <m.purski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
Message-ID: <20180928202251.GM5662@atomide.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
 <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Osipenko <digetx@gmail.com> [180928 20:13]:
> Tony, could you please give a try to the patch below?
> 
> Do the following:
> 
> 1) git cherry-pick 696861761a58d8c93605b5663824929fb6540f16
> 2) git cherry-pick 456e7cdf3b1a14e2606b8b687385ab2e3f23a49a
> 3) Apply this patch:

Seems to be getting closer, system boots up and starts
init, but then I start getting tons of this on beagle-x15:

[   17.089059] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
[   17.096342] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
[   17.103275] cpufreq: __target_index: Failed to change cpu frequency: -22
[   17.118139] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
[   17.125078] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
[   17.132105] cpufreq: __target_index: Failed to change cpu frequency: -22
[   17.148187] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
[   17.155265] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
[   17.162355] cpufreq: __target_index: Failed to change cpu frequency: -22
[   17.171111] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
[   17.178156] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
[   17.185240] cpufreq: __target_index: Failed to change cpu frequency: -22
[   17.197636] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
[   17.204597] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
[   17.211621] cpufreq: __target_index: Failed to change cpu frequency: -22
[   17.227466] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
[   17.234428] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
[   17.241467] cpufreq: __target_index: Failed to change cpu frequency: -22
...

Regards,

Tony
