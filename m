Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D922190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550080196;
	bh=cJkEEUJfDsJG70f/ftFextRBK86+Ftm6yHbOz8glA24=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=oyYB8TJS+QuUlQYfZL3f/vOTeaeMZVgCyYCaTnQaCvDijO/G+8oWZU3sKx7Z0QlF4
	 G8rwnSShZE86vjk08h3bDppviYnh+U6f3UFs+vwTLcw+Bm9i1PWVIcPIOoDXIvpqHq
	 3OWqzNCbfOkR0gJ0pEvbHYkOPCLCON+373Eg+7YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393337AbfBMRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfBMRty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:49:54 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5534F2086C;
        Wed, 13 Feb 2019 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550080193;
        bh=cJkEEUJfDsJG70f/ftFextRBK86+Ftm6yHbOz8glA24=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=hcjJHQrzigTBYDVJMphJkXSvrcvgjLZQhybe0hIfhUWUAKUqRuNqsUXE7jJIZKW1o
         KmYX9JjK6X8bo8KwTOby2N78iR/e6vq5DGO6XXqG7/RN1OmglkR3RF0KmuoEaAUhSp
         vrEjImjrSE3AhIXGWRECiiqqPRYJBlGrnDr/29e4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        gabriel.fernandez@st.com
In-Reply-To: <20190212135154.2733-8-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 7/7] clk: stm32mp1: fix bit width of hse_rtc divider
Message-ID: <155008019257.115909.11448173462227251798@swboyd.mtv.corp.google.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com> <20190212135154.2733-8-gabriel.fernandez@st.com>
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 13 Feb 2019 09:49:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-12 05:51:54)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> This patch fixes the bit width of the hse rtc divider.

Fixes tag?

Also, commit text shouldn't be written with "this patch". It should say
something more like "Fix the bit width of the hse rtc divider because
it's off by one".

