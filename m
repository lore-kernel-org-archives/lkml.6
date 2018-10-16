Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C77C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECE821476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQxgfWTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECE821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJQCJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJQCJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:09:56 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE2721471;
        Tue, 16 Oct 2018 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539713896;
        bh=+WffOsf2pUut9WvCQiNvr1ZR9qXbVppjr6pz9EzH7LQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=qQxgfWTE4tJRGUW0Pb2GF2/rlwNe/qNi+oXArE3/CAMVaLb06opruk4aiPo8A1cZI
         HjLcP454iUX6xUMMHbpTRfw1WqzPbtTnhkVQatW8j+31I33Oo6Je0IeVdY3U+A9PnP
         mz9xsx5FzAI26ArqOQlUJZFysDrqbf/bQE9EMPWg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181016134144.12461-1-enric.balletbo@collabora.com>
Cc:     kernel@collabora.com, Michael Turquette <mturquette@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20181016134144.12461-1-enric.balletbo@collabora.com>
Message-ID: <153971389560.5275.17687261861802609299@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: rockchip: Fix static checker warning in
 rockchip_ddrclk_get_parent call
Date:   Tue, 16 Oct 2018 11:18:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enric Balletbo i Serra (2018-10-16 06:41:44)
> Fixes the signedness bug returning '(-22)' on the return type by removing=
 the
> sanity checker in rockchip_ddrclk_get_parent(). The function should return
> and unsigned value only and it's safe to remove the sanity checker as the
> core functions that call get_parent like clk_core_get_parent_by_index alr=
eady
> ensures the validity of the clk index returned (index >=3D core->num_pare=
nts).
> =

> Fixes: a4f182bf81f18 ("clk: rockchip: add new clock-type for the ddrclk")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

