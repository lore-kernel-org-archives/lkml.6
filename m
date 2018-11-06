Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D65C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F3120869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xHSVuv9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F3120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbeKGDKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389581AbeKGDKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:10:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C97CC20827;
        Tue,  6 Nov 2018 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541526224;
        bh=fLA6URN/xCTbhNRuu1YJynjMvg6ZcI40LvCIi7Q0rfE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=xHSVuv9jKpVzZemkcN0sG6tmlbuQfxWqD217pDyDhsYCz+AX4D14bCKssVJqI1zLj
         osez+283p+tOwdWUNo3xBqgOTgI7qCqR5p5IzqeJ29AP530AhTjiJ0AVjsg3aifBRs
         oORp43BugyQa8hHB6MpbbYIN+tfaYk4Vw4SFY92I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sangbeom Kim <sbkim73@samsung.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1540619262-22681-7-git-send-email-Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540619262-22681-7-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <154152622426.88331.17363838226504925494@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 6/8] clk: s2mps11: constify clk_ops structure
Date:   Tue, 06 Nov 2018 09:43:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julia Lawall (2018-10-26 22:47:40)
> The clk_ops structure is only stored in the ops fields of
> clk_init_data structures.  This field is const, so the clk_ops
> structure can be const as well.
> =

> Identified and transformed using Coccinelle.
> =

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> =

> ---

Applied to clk-next

