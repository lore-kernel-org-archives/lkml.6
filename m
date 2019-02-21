Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2588C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB212083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550787362;
	bh=Hi47GsDWkrIEtUc1wOpXtU7yX3Q/A8ipCZbEVPsHnR0=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=DalVuLq1siBM6eAuXCSdDFzOzxFGf9V0WgkPp+/kHh2OhXKWIR09y+qJGQP0KyIKR
	 FZnzOvYNQCOXgJp6pyRS288JN33XlXj4Nhg/Wt626MTEEkc7MEyYbbDmNsge560NsM
	 iTZjgyCciX4lGGqTQuCgHgCjO4HMeS/uI7eq/Q64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBUWQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfBUWP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:15:59 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22BB220818;
        Thu, 21 Feb 2019 22:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550787359;
        bh=Hi47GsDWkrIEtUc1wOpXtU7yX3Q/A8ipCZbEVPsHnR0=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=vHq/LMn9pS3cZp0lCFQI3a4gd0iKAVaWbpjegE3wQxIxoGzZF6/Y+70zxRJQxuSJv
         cZwY5U1Y63V4A9TSIdLHPJKIKupAWlDKwe3HtRYGp8u945vOf7kPAVscxREyRA27YP
         LMGcJCsXqkYQJSfLWKCHvfZc6RLvZk5XnUW+Rarg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/7] clk: stm32mp1: remove unnecessary CLK_DIVIDER_ALLOW_ZERO flag
Message-ID: <155078735843.77512.7517600013226000262@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104047.1173-1-gabriel.fernandez@st.com> <20190214104047.1173-7-gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104047.1173-7-gabriel.fernandez@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        gabriel.fernandez@st.com
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Date:   Thu, 21 Feb 2019 14:15:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-14 02:40:46)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> The divisor of ethptp_k and ck_hse_rtc clocks is: 'value register
> plus one'.
> Then CLK_DIVIDER_ALLOW_ZERO flag has no effect and is useless here.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next

