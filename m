Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDLOji (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:39:38 -0400
Received: from muru.com ([72.249.23.125]:36470 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753393AbeDLOjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:39:36 -0400
Date: Thu, 12 Apr 2018 07:39:32 -0700
From: Tony Lindgren <tony@atomide.com>
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com,
        Russ.Dill@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, ssantosh@kernel.org,
        haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org,
        d-gerlach@ti.com
Subject: Re: [PATCH 11/14] gpio: omap: Restore power_mode configuration at
 resume time
Message-ID: <20180412143932.GA5700@atomide.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-12-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523505239-16229-12-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180412 03:56]:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Commit 2dc983c565e0 ("gpio/omap: cleanup prepare_for_idle and
> resume_after_idle") introduces omap2_gpio_prepare_for_idle and
> omap2_gpio_resume_after_idle to properly configure gpios that are used
> as wake sources. When entering off mode, omap2_gpio_prepare_for_idle
> can set a flag indicating off-mode entry is desired, however once this
> flag is set it is never cleared, so any additional calls to this
> function, regardless of the mode, have this flag set.
> 
> This patch restores the pwr_mode flag to 0 in
> omap2_gpio_resume_after_idle to ensure the flag is not misconfigured
> during non off-mode operation.

Seems like this should be applied as a fix, can you please add
a proper Fixes tag?

Regards,

Tony
