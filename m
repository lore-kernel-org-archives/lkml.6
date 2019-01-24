Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9915FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6946B218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357433;
	bh=ZLFhZYGAWQxoijbUQverY9nPQj8pPfraJAtyQg9ynUQ=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=Qak65FhoqyqLJk8KoMM25BZUmgctw2/vzOXgkUYVwSTDYDOr7Zx893a/f5vXuZdAs
	 Ib4i5utcbogWn67y0JUvyw/4sq4d5A1GPVTzjXCfi0JtX1dvRTBau22VcqwgQI0FBZ
	 q/RZeHHvE98lb8xj/4S9BzQBBhFzu8dCRjZyVOrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfAXTRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:17:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfAXTRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:17:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602A0218CD;
        Thu, 24 Jan 2019 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357430;
        bh=ZLFhZYGAWQxoijbUQverY9nPQj8pPfraJAtyQg9ynUQ=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=VdenfzovZ3Pi8+sDp8MxgZBhU0L+7icUmYilA0F3sKtdrGwK/dvrr9kjbFe93fjHz
         HJytTznee4ePPcYQUlUaJqGcpUBBLj0qukdY90KX/l2WU1D2wEPoKLe60QJyPRKZ5Z
         oDH9BB3pK5fhW2PLt3bzOJVcFHDfayQxDwrpd4bo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: Remove global clk traversal on fetch parent index
References: <20181221003100.157581-1-dbasehore@chromium.org>
User-Agent: alot/0.8
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181221003100.157581-1-dbasehore@chromium.org>
Message-ID: <154835742949.136743.9149540159914235850@swboyd.mtv.corp.google.com>
To:     Derek Basehore <dbasehore@chromium.org>, mturquette@baylibre.com
Date:   Thu, 24 Jan 2019 11:17:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Derek Basehore (2018-12-20 16:31:00)
> It's not required to traverse the entire clk tree when the parents
> array contains a NULL value. You already have the parent clk_core
> pointer, so you can just compare the parent->name and parent_names[i]
> pointers.
>=20
> In cases where clk names are never registered, this can be
> a substantial power improvement since a mux having an unregistered
> parent name will traverse the clk tree on every set_rate. This can
> happen hundreds of times a second on CPU clks.
>=20
> Change-Id: I85499d2e576249568ff508e424ca8d5009e6e2b1
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---

Applied to clk-fixes + some commit text and comment updates.

