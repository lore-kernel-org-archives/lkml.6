Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A9920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ+atQxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A9920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbeKGByI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:54:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387685AbeKGByI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:54:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A71BB2085B;
        Tue,  6 Nov 2018 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541521689;
        bh=scVBmvd5Re+3bUo4QVUeTjypCCfACAcBZGrr4S/dZUs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=WJ+atQxpXls/SFr5Hj6kDeC4MmoqmZCZgj7h4Zfd/sYzTcbkJIY0S8glzw3LSreCA
         RHPZHQ7KWmCso/29vtJ7AynBf9o32QkYpKJ2HsKtW7HdhxsZ0NUZCEOdop36pFXvbY
         CVy95yrPZ9CNTko/X1QluZ2YwSC2HATzagYoE0H0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alan Tull <atull@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181101131549.24497-1-ricardo.ribalda@gmail.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
References: <20181101131549.24497-1-ricardo.ribalda@gmail.com>
Message-ID: <154152168898.88331.11071008378087302384@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: fixed-factor: fix of_node_get-put imbalance
Date:   Tue, 06 Nov 2018 08:28:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ricardo Ribalda Delgado (2018-11-01 06:15:49)
> When the fixed factor clock is created by devicetree,
> of_clk_add_provider is called.  Add a call to
> of_clk_del_provider in the remove function to balance
> it out.
> =

> Reported-by: Alan Tull <atull@kernel.org>
> Fixes: 971451b3b15d ("clk: fixed-factor: Convert into a module platform d=
river")
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---

Applied to clk-fixes

