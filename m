Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA850C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A412B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551203716;
	bh=X5OVCzrsQAnuNCeXkl+OnEMMckqJHX7xniL91R3UZ3I=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=YEm3vj2Nl6Z+YH/hsGJmSzD1Cr1IWnW68fCxkbwPqhVqiLvZoTEnrRT6zpYXZ++3P
	 lgwnc8PHa6o8basOWY/SjmIkh+8qebGwF3g0St1Y8Qr7CzvtRDwxpNmuUGz3BKuyDx
	 sMv/lLOlUBmZhpskAAJKHKtyFDmNof+vlEUH1u2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfBZRzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfBZRzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:55:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112912173C;
        Tue, 26 Feb 2019 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551203714;
        bh=X5OVCzrsQAnuNCeXkl+OnEMMckqJHX7xniL91R3UZ3I=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=uTp+PCq0LQf7VAOSSO4ajmylbRf3pTVnNhDal66Aprct+bXoa1iLUExK008wDPgwM
         GSP02jEkxfcElA/Gj1u4WwYWChorVWYEW+z/7C0JeVgNbd7su7NvwxnU6C+lUaSytq
         xrimVfTPV9w0Adqz7iODnysevam+sUnjAIOmhhG4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com,
        matthias.bgg@kernel.org, mturquette@baylibre.com
References: <20190214163242.26259-1-matthias.bgg@kernel.org>
Message-ID: <155120371334.260864.14503820089028591730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 3/3] clk: mediatek: Mark bus and DRAM related clocks as critical
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214163242.26259-1-matthias.bgg@kernel.org>
Date:   Tue, 26 Feb 2019 09:55:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2019-02-14 08:32:42)
> From: Jasper Mattsson <jasu@njomotys.info>
>=20
> Currently, DRAM-related clocks are not marked with CLK_IS_CRITICAL
> for MT6797. This causes memory corruption when the system is
> booted without clk_ignore_unused.
> This patch marks MUX ddrphycfg_sel as well as gates infra_dramc_f26m
> and infra_dramc_b_f26m as CLK_IS_CRITICAL.
>=20
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied to clk-next

Would be nice to get someone from mediatek to ack it, but I can't wait
forever.

