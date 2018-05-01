Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeEAJjU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:39:20 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41192 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEAJjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:39:18 -0400
X-Google-Smtp-Source: AB8JxZoWBM2B45YwYGEIxKOP9NcsKw0CRoDRJ8cps78nV6fHcAdCUfNXXPwqrUzPadyJoiGlkN/zKQ==
Date: Tue, 1 May 2018 11:39:14 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] thermal: exynos: fix trips limit checking in
 get_th_reg()
Message-ID: <20180501093914.GG27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <1524743493-28113-7-git-send-email-b.zolnierkie@samsung.com>
 <20180430153431.GB27619@mai>
 <CGME20180430154830eucas1p20a5d8e1d4d50c60f8072ce022b6afb1d@eucas1p2.samsung.com>
 <26762578.lZtk787caq@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26762578.lZtk787caq@amdc3058>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 05:48:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday, April 30, 2018 05:34:31 PM Daniel Lezcano wrote:
> > On Thu, Apr 26, 2018 at 01:51:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > of_thermal_get_ntrips() may return value bigger than supported
> > > by a given SoC (i.e. on Exynos5422/5800) 
> > 
> > Can you elaborate a bit ?
> 
> Odroid-XU3 DTS file [1] define 6 thermal trip points (2 passive ones)
> while data->ntrip is 4, the current code works fine by accident as
> the threshold values for trip points 5 & 6 don't fit into 32-bits
> threshold value (however since they are passive ones this is okay).

Ah, I see. data->ntrip is the SoC specific tmu max value capping what is
defined in the DT, right ?

> Of course the code for handling passive trip points still needs to
> be fixed to properly handle all odd cases (which are not present in
> current DTS files).
> 
> [1] arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi

Yeah, it is definitively a good idea of cleaning up this driver :/


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
