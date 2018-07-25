Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E2C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542BB20890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbexxuKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542BB20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeGYHbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbeGYHbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:31:13 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7890A20671;
        Wed, 25 Jul 2018 06:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532499664;
        bh=ebZ/fkv+ldar5Tj3LjQqmqTe+9AKDymjNmDKaPZyGLA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=sbexxuKYx8hzVmVoHBxImdklizsKXHCidORWxRq4dN7p7O/S8k/Vz6wBSXwgOTe5U
         eRuiBiKRUGmmS/3WBTX5ZfXY1YlJa4K33Z7sj7G6kIk6TcGWySvJs0mk6HEYnvIY91
         88p2ZpQFZ1ACClnwXBhho2r9GeCTcCP5ZYXRYjEc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CADHB5bAns1PmTvq=fG8Rc2S6orEh7wf5XYAGQONTKMsoYv-UTg@mail.gmail.com>
Cc:     mark.rutland@arm.com, support@cubietech.com,
        Laisa Costa - LSI-TEC <laisa.costa@lsitec.org.br>,
        linux@cubietech.com, darren@cubietech.com,
        =?utf-8?q?Guilherme_G=2E_Sim=C3=B5es?= 
        <guilherme.simoes@lsitec.org.br>, catalin.marinas@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, mkzuffo@lsi.usp.br,
        linux@armlinux.org.uk, will.deacon@arm.com,
        jeff.chen@actions-semi.com, robh+dt@kernel.org,
        thomas liau <thomas.liau@actions-semi.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        pn@denx.de, =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mp-cs@actions-semi.com
References: <CADHB5bAns1PmTvq=fG8Rc2S6orEh7wf5XYAGQONTKMsoYv-UTg@mail.gmail.com>
Message-ID: <153249966379.48062.8866967540355341765@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 01/04] clk: actions: Add Actions Semi S500 SoC clock support
Date:   Tue, 24 Jul 2018 23:21:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Edgar Bernardi Righi (2018-07-18 08:32:34)
> Add Actions Semi S500 SoC clock support.
> Basic clock support for S500 SoC was implemented using the Actions
> Semi Owl clock driver.
> Tested on a Lemaker Guitar board.
> =

> This patch depends on patch "[PATCH v6 1/5] clk: actions: Add missing
> REGMAP_MMIO dependency" by Saravanan Sekar.
> This patch depends on patch "[PATCH] clk: actions: Add custom delay
> option to Actions Semi OWL pll clock driver" by Edgar Bernardi Righi.

The depends list can be left out of the commit text and go below a
triple dash '---' after the sign-off chain.

> =

> File(s) created: "/drivers/clk/actions/owl-s500.c"
> File(s) updated: "/drivers/clk/actions/Makefile", "/drivers/clk/actions/K=
config"

Please remove these "Files created" messages from your patches.
Preferably use git to format your patches before sending too, but using
diff is OK too I guess.

> =

> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> =

> diff -uprN -X vanilla/Documentation/dontdiff
> vanilla/drivers/clk/actions/Kconfig linux/drivers/clk/actions/Kconfig
