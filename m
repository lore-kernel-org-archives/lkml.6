Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B213C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2084320852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEEwwSVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2084320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGYWlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbeGYWlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:41:52 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9922E20843;
        Wed, 25 Jul 2018 21:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532554099;
        bh=am6AxJxKoOG4xPcp6eLHtOfZqvteTHoalIF43L6Uq2g=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=WEEwwSVU28N4gS2RK9gADkAyzZAyexMfRreQyLfdlNAzuhiopV5RQuVKfDxz34FCD
         ZTmqs3/pqCHSU2BHbh6UcRYa7mF+kTZx62WytPVcTWA4WmTrfhSGdTS/EiWij5rJ+3
         8QX8gEQKXqYwC4V7RH2x40mI34H/7P8nr9eFbkq4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531396382-5579-4-git-send-email-avienamo@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
References: <1531396382-5579-1-git-send-email-avienamo@nvidia.com>
 <1531396382-5579-4-git-send-email-avienamo@nvidia.com>
Message-ID: <153255409888.48062.18427465027530245711@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 3/4] clk: tegra: Add sdmmc mux divider clock
Date:   Wed, 25 Jul 2018 14:28:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aapo Vienamo (2018-07-12 04:53:01)
> From: Peter De-Schrijver <pdeschrijver@nvidia.com>
> =

> Add a clock type to model the sdmmc switch divider clocks which have paths
> to source clocks bypassing the divider (Low Jitter paths). These
> are handled by selecting the lj path when the divider is 1 (ie the
> rate is the parent rate), otherwise the normal path with divider
> will be selected. Otherwise this clock behaves as a normal peripheral
> clock.
> =

> Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---

Applied to clk-next

