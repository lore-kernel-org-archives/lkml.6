Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355EAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029142086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730547;
	bh=Yd4+V6QsfswL9G2h2zOMi1Wi7ST+UQDIqg0YP9GSBCw=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=TzcmakZwIQ5csOYMIkSz6EnismWceH6MoI4jcrDixqLKydlMchJ7fVHBnj8yYDDPb
	 CH64L7xOGVDQusMA6N1xz68upTKREwcP7X7S97t/RSZpQSR7+FiBrxlUBDYvpwnQQ5
	 mCpGmliLpilGoBqkTGf+2L0IwOWNyYCipRUImH1Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029142086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeLMTtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:49:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeLMTtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:49:05 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAC02086D;
        Thu, 13 Dec 2018 19:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730545;
        bh=Yd4+V6QsfswL9G2h2zOMi1Wi7ST+UQDIqg0YP9GSBCw=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=hnL1Qco9CJGC5FqRJ1odYtEQu1h9g0b4FhF9B+ISVWyk8+Fx+ptnW0s3EDEn8WxEz
         KShpOj8yzloiJvzSFOy2kfErjigiqLCK95ZOYrRmaTjvs1C8GdmvpOuARySEttqDmB
         6qUEuHjeZZO2AWNHDjo1sRvCUa7Jbrgsf3yHTQPg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181206215858.3880-3-sboyd@kernel.org>
Subject: Re: [PATCH 2/8] clk: st: Remove usage of CLK_IS_BASIC
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-3-sboyd@kernel.org>
Message-ID: <154473054441.19322.13547831673026320964@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Thu, 13 Dec 2018 11:49:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-12-06 13:58:52)
> This flag doesn't look to be used by any code, just set in various clk
> init structures and then never tested again. Remove it from these
> drivers as it doesn't provide any benefit.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

