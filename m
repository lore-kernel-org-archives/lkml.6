Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F9CC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC50920881
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCgwCbDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC50920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbeKGDH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730688AbeKGDH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:07:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D912081D;
        Tue,  6 Nov 2018 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541526100;
        bh=+uqiS88Key1qTjAYVbF2B5tSwsshmQMH6iQGUSfoTi0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=QCgwCbDvVM4VcK/7uo5qNbRNS06sglEllnTeSv81P0SK/Hw55eYOUTzZlXqnkgpsn
         yy9GGCU6WNTpUxMFBu/yxs1qhH0ffSL06FyZjDyrAll43SCdQPGXy02KgIYGbk2+/c
         3yIXIad/d9YsndMkY7EqBjVkbFMRMD8ycQHorjxc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1540619262-22681-2-git-send-email-Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540619262-22681-2-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <154152609937.88331.11993895406323284065@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/8] clk: max77686: constify clk_ops structure
Date:   Tue, 06 Nov 2018 09:41:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julia Lawall (2018-10-26 22:47:35)
> The clk_ops structure is only stored in the ops field of a
> clk_init_data structure.  This field is const, so the clk_ops
> structure can be const as well.
> =

> Identified and transformed using Coccinelle.
> =

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> =

> ---

Applied to clk-next

