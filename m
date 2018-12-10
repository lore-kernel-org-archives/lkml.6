Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82294C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CCA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544469046;
	bh=XteT7F2kIciui5UQsyAZKk96Oy25BajR/3kSJCR2j6o=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=SSmdfjDLGupgW4w+d2K2amzL0Gv1WgF09lkHl3MBaOXsXnTfMT+1c0QOfmrUE7DIT
	 2fCLR5ilBBA/Jz8I77FLKgC3ipXU4A/YVm5d0KOKjEAbeFnj2SrMWKpRYhWZKwq7Uf
	 4i8/Ifc6U5udyyVxmq9j8K63x8YzVbeLzgmgbiHg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CCA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeLJTKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:10:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbeLJTKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:10:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E1272082F;
        Mon, 10 Dec 2018 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544469039;
        bh=XteT7F2kIciui5UQsyAZKk96Oy25BajR/3kSJCR2j6o=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=ynDl++ppIQyuyentVpKJUdGDNQwj+ztBRSerLf8iQIlje//s0I8a+tBRMw2hWMW+G
         lvGhC6bhUmHOlgvJuUoCXR/sGmtI4GrZ3BhMaDMMYfZJZsKfaPX5FPkxevzSJsUeSj
         BMkv7+I8KzP0yN1VcRqllHjBKgOat/hUI8qgv5v8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1543832921-11661-2-git-send-email-jonathanh@nvidia.com>
Message-ID: <154446903833.17204.13305750659921013123@swboyd.mtv.corp.google.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH 2/2] clk: tegra30: Use Tegra CPU powergate helper function
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543832921-11661-1-git-send-email-jonathanh@nvidia.com> <1543832921-11661-2-git-send-email-jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Dec 2018 11:10:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jon Hunter (2018-12-03 02:28:41)
> Rather than using the tegra_powergate_is_powered() function for
> determining if a CPU is powered, use the tegra_pmc_cpu_is_powered()
> instead which was created to get the CPU power status. Internally
> tegra_pmc_cpu_is_powered() calls tegra_powergate_is_powered() and so
> is equivalent.
>=20
> The Tegra30 clock driver is the only public user of
> tegra_powergate_is_powered() and so by updating the Tegra30 clock
> driver to use tegra_pmc_cpu_is_powered(), we can then make
> tegra_powergate_is_powered() a non-public function.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---

Applied to clk-next

