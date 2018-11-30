Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C81C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841CA2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaXYtILW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841CA2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeK3R6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbeK3R6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:58:30 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D637F2145D;
        Fri, 30 Nov 2018 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543560614;
        bh=uvbD7ONAjHKZogEDPFuxmFpPduuGqYSxQpj8/l1hj6E=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KaXYtILWKLJlvg4M64ESm9twD/iL7ft2+f77A/JTtdsjUUhQaUlSPWP1uQKBCt5wJ
         umGVb6YQHL8vw717L5fPU8wBmzJj/eFYsbQUNAdzriUx1Eox4FyXQ8Fzfo6Yic0Hgz
         mLx2SaCXcqZerWX0XObZFA0C049rf/jph/TuEOG4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matthias.bgg@gmail.com, matthias.bgg@kernel.org,
        mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181116180901.17737-3-matthias.bgg@kernel.org>
Cc:     jasu@njomotys.info, sean.wang@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
 <20181116180901.17737-3-matthias.bgg@kernel.org>
Message-ID: <154356061291.88331.179492557229227536@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: mediatek: Add flags to mtk_gate
Date:   Thu, 29 Nov 2018 22:50:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2018-11-16 10:09:00)
> From: Jasper Mattsson <jasu@njomotys.info>
> =

> This is required to mark gates as CLK_IS_CRITICAL.
> =

> Fixes: 96596aa06628 ("clk: mediatek: add clk support for MT6797")
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

These other two look ok to me. I'll apply them to the clk tree and wait
to merge to clk-next in case someone from Mediatek wants to review these
changes.

