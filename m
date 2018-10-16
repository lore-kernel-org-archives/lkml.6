Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A3CC5ACCD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06842148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty1TEPzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06842148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJQHoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbeJQHoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:44:07 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3A12148C;
        Tue, 16 Oct 2018 23:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539733878;
        bh=KAjQLG4gba45Z89y69IXYD4/VU7gmuJ8Jb7gk8YMbC0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ty1TEPzlTr8NdpBkTx/1F94tLIUAPCRPD4mu0eEh3gYzHktTgXmMHUzH2Gy5TJu4j
         nLvzmxn9EAiHXW5NCR7bEReiZj4xKkxOLLvoEqZghJz0oJsvw0++pxmWYPmSpKm9Jz
         P61EGB78v/XkoO1nUPmvOYM7e6oKdpQG4G+9mAFA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181010181838.26923-1-gregory.clement@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20181010181838.26923-1-gregory.clement@bootlin.com>
Message-ID: <153973387816.5275.3801197644507437368@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: mvebu: armada-37xx-tbg: Switch to clk_get and balance it
 in probe
Date:   Tue, 16 Oct 2018 16:51:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-10-10 11:18:38)
> The parent clock is get only to have its name, and then the clock is no
> more used, so we can safely free it using clk_put. Furthermore as between
> the successful devm_clk_get() and the devm_clk_put() call we don't exit
> the probe function in error so I can use non managed version of clk_get()
> and clk_put().
> =

> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Applied to clk-next

