Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeBBAre (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 19:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeBBAr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 19:47:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0706E217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 08:47:15 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux@armlinux.org.uk,
        viresh.kumar@linaro.org, rafael@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 2/2] cpufreq: imx6q: add 696MHz operating point for
 i.mx6ul
Message-ID: <20180202004713.GC20833@dragon>
References: <1515235360-1628-1-git-send-email-Anson.Huang@nxp.com>
 <1515235360-1628-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515235360-1628-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2018 at 06:42:40PM +0800, Anson Huang wrote:
> Add 696MHz operating point for i.MX6UL, only for those
> parts with speed grading fuse set to 2b'10 supports
> 696MHz operating point, so, speed grading check is also
> added for i.MX6UL in this patch, the clock tree for each
> operating point are as below:
> 
> 696MHz:
>     pll1                       696000000
>        pll1_bypass             696000000
>           pll1_sys             696000000
>              pll1_sw           696000000
>                 arm            696000000
> 528MHz:
>     pll2                       528000000
>        pll2_bypass             528000000
>           pll2_bus             528000000
>              ca7_secondary_sel 528000000
>                 step           528000000
>                    pll1_sw     528000000
>                       arm      528000000
> 396MHz:
>     pll2_pfd2_396m             396000000
>        ca7_secondary_sel       396000000
>           step                 396000000
>              pll1_sw           396000000
>                 arm            396000000
> 198MHz:
>     pll2_pfd2_396m             396000000
>        ca7_secondary_sel       396000000
>           step                 396000000
>              pll1_sw           396000000
>                 arm            198000000
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
