Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A8C208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1PHhfT85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A8C208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbeG0SSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388760AbeG0SSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:18:38 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6521F208B0;
        Fri, 27 Jul 2018 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532710554;
        bh=XHoGXdJ81a9DKZFayEsDnwTru4GGxig9aON/qi7lqvs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=1PHhfT85a+3ZajN4mJaX98Dw4txL9lDTPWCtvejOZxtp54s7I7kDQABvisjqg0Jlp
         IEysVeuveFAOs02XZHvOxVcfbZyQ2iXV3KKvNMtCHBai58CoK3xPTlVbNJhvjb8/Qm
         EEdG75ROMz15rd07eUGooEN/z0KfBZfqzneXXx08=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anders Roxell <anders.roxell@linaro.org>,
        gregory.clement@bootlin.com, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180726222721.5787-1-anders.roxell@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
References: <20180726222721.5787-1-anders.roxell@linaro.org>
Message-ID: <153271055369.48062.7965396244056342743@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Remove unused var num_parents
Date:   Fri, 27 Jul 2018 09:55:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anders Roxell (2018-07-26 15:27:21)
> When building armada-37xx-periph, num_parents isn't used in function
> clk_pm_cpu_get_parent:
> drivers/clk/mvebu/armada-37xx-periph.c: In function =E2=80=98clk_pm_cpu_g=
et_parent=E2=80=99:
> drivers/clk/mvebu/armada-37xx-periph.c:419:6: warning: unused variable =
=E2=80=98num_parents=E2=80=99 [-Wunused-variable]
>   int num_parents =3D clk_hw_get_num_parents(hw);
>       ^~~~~~~~~~~
> Remove the declaration of num_parents to dispose the warning.
> =

> Fixes: 616bf80d381d ("clk: mvebu: armada-37xx-periph: Fix wrong return va=
lue in get_parent")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

Applied to clk-next

