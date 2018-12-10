Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFEC2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544469040;
	bh=3unglAccUj5JwCzmdrV/ptHDARWQs2ni8Jxc9gi0dgw=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=rg2SIk9z6Mf18gjQMWiunXqnCpqkof5sq4jjlXsF4NXHExEMsZKpfDBz1zgwrd0wZ
	 /Cg7T8LncJTGfQqDfxCclI4QXgvJd4WLkmfWfQXH+6e2SxOa+Q4OXpDSu63ixxKP6a
	 keMtCCla7bBeqr3MaWgdM8tBPxPFJL2592E9rb74=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFEC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeLJTKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbeLJTKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:10:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B06D2082F;
        Mon, 10 Dec 2018 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544469036;
        bh=3unglAccUj5JwCzmdrV/ptHDARWQs2ni8Jxc9gi0dgw=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=GU31rFtc+o26QTxUuwp4ZmvLZrwAHMl9ZrvcZPFxAUCvM4j5NQ6hZ0q8DT2MSvyax
         x4lwnHou6DuQQMrsgxAJRNTuOeW8VM46eiL7pvAwLlBqEk5Z3q2xVTiREgcYv5uwI5
         /H41bTDfXb9KP8gKtjqo8N37dJAuoRgojtNVB8I4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1543832921-11661-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <154446903563.17204.4474332644824804669@swboyd.mtv.corp.google.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH 1/2] clk: tegra: Fix maximum audio sync clock for Tegra124/210
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543832921-11661-1-git-send-email-jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Dec 2018 11:10:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jon Hunter (2018-12-03 02:28:40)
> The maximum frequency supported for I2S on Tegra124 and Tegra210 is
> 24.576MHz (as stated in the Tegra TK1 data sheet for Tegra124 and the
> Jetson TX1 module data sheet for Tegra210). However, the maximum I2S
> frequency is limited to 24MHz because that is the maximum frequency of
> the audio sync clock. Increase the maximum audio sync clock frequency
> to 24.576MHz for Tegra124 and Tegra210 in order to support 24.576MHz
> for I2S.
>=20
> Update the tegra_clk_register_sync_source() function so that it does
> not set the initial rate for the sync clocks and use the clock init
> tables to set the initial rate instead.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---

Applied to clk-next

