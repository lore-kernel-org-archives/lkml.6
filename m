Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCA3C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4832146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGpOFkpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4832146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLCTbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:31:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCTbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:31:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BC32081C;
        Mon,  3 Dec 2018 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543865503;
        bh=EpU8ahTAcUeE0VWeJAlpdwbWBlwtxLz63+h9P4QqtRw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=BGpOFkpvaybDGugOuPseg/zA7VCP9gSuVHrGZQaEtbKd2UUOG98BgLiiv74c/qd+U
         WpRtiiAIioC6K74jKqQeLWNUuTegtEfu4Lnq2DU6IGpwv2nH/5Qw8dNozRqOu/TwqZ
         ejX3DvMhBhbOW7BDgKQsLyE8XOGAmHYGsCW4QOUI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
Date:   Mon, 03 Dec 2018 11:31:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting A.s. Dong (2018-11-14 05:01:31)
> This patch series intends to add imx7ulp clk support.
> =

> i.MX7ULP Clock functions are under joint control of the System
> Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> modules, and Core Mode Controller (CMC)1 blocks
> =

> The clocking scheme provides clear separation between M4 domain
> and A7 domain. Except for a few clock sources shared between two
> domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> and and the Fast IRC clock (FIRCLK), clock sources and clock
> management are separated and contained within each domain.
> =

> M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> =

> Note: this series only adds A7 clock domain support as M4 clock
> domain will be handled by M4 seperately.
> =


I got:

drivers/clk/imx/clk-pllv4.c:152:15: warning: symbol 'imx_clk_pllv4' was not=
 declared. Should it be static?
drivers/clk/imx/clk-pfdv2.c:166:15: warning: symbol 'imx_clk_pfdv2' was not=
 declared. Should it be static?
drivers/clk/imx/clk-divider-gate.c:174:15: warning: symbol 'imx_clk_divider=
_gate' was not declared. Should it be static?
drivers/clk/imx/clk-composite-7ulp.c:22:15: warning: symbol 'imx7ulp_clk_co=
mposite' was not declared. Should it be static?

which I can fix easily by throwing in clk.h into each file.

