Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD82C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A272214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550691598;
	bh=UpCIB5DxIgOdyYfTGrgBOO8ecoUMG4vfVQYUA5wsPRM=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=mlS4RvtiKG7U5IzaILRXlKintkt99iuTRlkbrj7mhWuJAKgmfLJgfqK7CSB6J6ITC
	 WuhvgHVn08rNKcIVPt4jDnwSDDuQLWnoOQHsGcpdy1fhnXjTIaqoxibd+dfinaoZON
	 B9psIfPjI+R8UD8wCHcNmCyTqc8mtMq2AgE7U1hA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfBTTj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:39:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfBTTj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:39:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B89452147A;
        Wed, 20 Feb 2019 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550691595;
        bh=UpCIB5DxIgOdyYfTGrgBOO8ecoUMG4vfVQYUA5wsPRM=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=APZ9VYW+OLfjPr80aw+jolixGLTau/tRn3+Vt0wfAojrDXCIDosByJFzWA/EHnAC3
         +aIPi4ZWQvZD9ZKdKBA7/lG8C2K2iLhBix/WYWtl3rMWkzZiCiVlPCv+onqxJHHD4Q
         BI2hUVYvOi7TZtIQWOEmPQgEpilg1Z02rE+BjK7U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Message-ID: <155069159403.77512.7641579336199123274@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Date:   Wed, 20 Feb 2019 11:39:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-02-19 08:51:14)
> nck() looks at the last id in an array and unfortunately,
> at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
> number of peripheral clocks is 1 instead of a maximum of 31.
>=20
> Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-fixes

