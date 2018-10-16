Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED20FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17A92148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMp9qwii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17A92148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeJQGjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeJQGjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:39:47 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E670521471;
        Tue, 16 Oct 2018 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539730032;
        bh=KR2wmgrLMbtgF/jOWj1hD08ahRXGAivsMcJ6tfC12Y8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=EMp9qwiikRtjDmzIUP5OKX2m+zTOc/tMM7U7Ks/DF2Kw3q+ToG2Pz5mAg/ju3zcnk
         nZjtyvaNvEIAFzLkU4lMwrYulgSt+DPWgm6+lN7EhELfSGTgGyf69A8GnsScZrpZCu
         MPlZlr6fRjbrn0zuTXUyl86Oetc1SMdAC3ZKGSIA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Robert Yang <decatf@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180925214940.15188-1-decatf@gmail.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
References: <20180925214940.15188-1-decatf@gmail.com>
Message-ID: <153973003125.5275.211113451006447179@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2] clk: tegra: Return the exact clock rate from clk_round_rate
Date:   Tue, 16 Oct 2018 15:47:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Yang (2018-09-25 14:49:40)
> The current behavior is that clk_round_rate would return the same clock
> rate passed to it for valid PLL configurations. This change will return
> the exact rate the PLL will provide in accordance with clk API.
> =

> Signed-off-by: Robert Yang <decatf@gmail.com>
> ---

I'm waiting for someone from Nvidia/Tegra background to review this
change.

