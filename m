Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A94FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0223B21529
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zngArmU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0223B21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJQX6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbeJQX6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:58:39 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA1E2150D;
        Wed, 17 Oct 2018 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539792138;
        bh=Wnlh6Qbhj6qrE+t+gWX5CHnjWXNObO5T3HkAIHuE1nU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=zngArmU3ZZV2ZNQ1G2TdntIuda0Nc1kWf97JpuNnckMVCwPyOZiD3/0Uj39XiP7xS
         9rx7X55nAOrHTQp4ls8SskjjjBskRvjYZsgU3axZOJgI4fl1OSl/CA20DWxAz3ZlBF
         V5Oxg220Rqu1SH9o1qSYBfpFDkKnTnAFnzo5dcas=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180910120144.163788-1-lkundrak@v3.sk>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Lubomir Rintel <lkundrak@v3.sk>
References: <20180910120144.163788-1-lkundrak@v3.sk>
Message-ID: <153979213728.5275.12061988775256493614@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mmp2: fix the clock id for sdh2_clk and sdh3_clk
Date:   Wed, 17 Oct 2018 09:02:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2018-09-10 05:01:44)
> A typo that makes it impossible to get the correct clocks for
> MMP2_CLK_SDH2 and MMP2_CLK_SDH3.
> =

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next and added a fixes tag.

