Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94949C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5866B20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppdJ3MXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5866B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeKJDHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbeKJDG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:06:59 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330E520825;
        Fri,  9 Nov 2018 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541784327;
        bh=64jkRqERJySVcWmUXw0AJES6FxXiNsluBrHirkZNkj8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ppdJ3MXAUv4HeSjgMRy1015AoNy91PdoKFCMMD4HzlhURPqwDN7PFnuo/b62oV3LN
         TXiRaCtxKq8krTiJkt5+1GVJrIZtlF2eL0Q1TzZ83WV7pWFH5DNsqlVlFiyvJkHHRf
         XfTbk8KXd1Qi+9cnCXJHNIM03yfReaqGgrfSetJw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>, kbuild test robot <lkp@intel.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <201811091832.kSh4BXdS%fengguang.wu@intel.com>
Cc:     kbuild-all@01.org, Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1541594266-16712-3-git-send-email-abel.vesa@nxp.com>
 <201811091832.kSh4BXdS%fengguang.wu@intel.com>
Message-ID: <154178432653.88331.17907414252177481094@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v12 2/5] clk: imx: add fractional PLL output clock
Date:   Fri, 09 Nov 2018 09:25:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kbuild test robot (2018-11-09 02:18:24)
> Hi Lucas,
> =

> I love your patch! Yet something to improve:
> =

> [auto build test ERROR on shawnguo/for-next]
> [also build test ERROR on v4.20-rc1 next-20181109]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
> =

> url:    https://github.com/0day-ci/linux/commits/Abel-Vesa/Add-i-MX8MQ-cl=
ock-driver/20181109-063930
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.gi=
t for-next
> config: arm-multi_v5_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Darm =

> =

> All errors (new ones prefixed by >>):
> =

>    drivers/clk/imx/clk-frac-pll.o: In function `clk_pll_recalc_rate':
> >> clk-frac-pll.c:(.text+0x74): undefined reference to `__aeabi_uldivmod'
>    drivers/clk/imx/clk-frac-pll.o: In function `clk_pll_round_rate':
>    clk-frac-pll.c:(.text+0xbc): undefined reference to `__aeabi_uldivmod'
> =


Why does the code do essentially:

	u64 val;

	do_div(val, div);
	val /=3D div2;

That should be using do_div() twice it seems.

