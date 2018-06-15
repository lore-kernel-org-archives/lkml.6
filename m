Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D62B6C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA48208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA48208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965794AbeFOL3V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:29:21 -0400
Received: from muru.com ([72.249.23.125]:47412 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965641AbeFOL3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:29:20 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id ACBF28076;
        Fri, 15 Jun 2018 11:31:57 +0000 (UTC)
Date:   Fri, 15 Jun 2018 04:29:16 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Maciej Purski <m.purski@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] regulator: core: Enable voltage balancing
Message-ID: <20180615112916.GK112168@atomide.com>
References: <20180605044554.GC5738@atomide.com>
 <CGME20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d@eucas1p1.samsung.com>
 <1528886026-9457-1-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528886026-9457-1-git-send-email-m.purski@samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Maciej Purski <m.purski@samsung.com> [180613 10:39]:
> Call regulator_balance_voltage() instead of set_voltage_rdev()
> in set_voltage_unlocked() and in enabling and disabling functions,
> but only if the regulator is coupled.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> 
> ---
> Changes in v2:
> - fix compile errors
> - make debug messages more informative

Thanks for updating it. This series still hangs after loading
modules on beagleboard-x15:

[   26.679749] smps12: regulator_set_voltage: 3381
[   26.684529] smps12: regulator_set_voltage_unlocked:  3045
[   26.695616] smps12: _regulator_do_set_voltage: 2912
[   26.701275] smps12: regulator_set_voltage: 3381
[   26.706002] smps12: regulator_set_voltage_unlocked:  3045
[   26.712349] smps12: _regulator_do_set_voltage: 2912
[   26.719329] abb_mpu: regulator_set_voltage: 3381
[   26.724105] abb_mpu: regulator_set_voltage_unlocked:  3045

So it seems to be the abb_mpu where it hangs?

Regards,

Tony
