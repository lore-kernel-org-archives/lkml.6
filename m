Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FC6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE9220836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550784791;
	bh=sA7VhBFf+IzaFqjsolIFDiXiFvP2LNW92/ovKseyWus=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=RmsyIxdrMNKyqwEYmFvKcyMQUN1LuKoImhRh/OX6QHp/ulYRWu/jYQibuXWhxjc66
	 74PlKzkWq9GgDzYCRY6p7G5vhMT5khvYvDF0YFY+AOTOuBwky8iCxYBX6NXfsVV0Ql
	 9UkN9wmLB6wb4DnnsI6Y9V5Ik2p6FxoTxNTeq8gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfBUVdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfBUVdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:33:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBA720818;
        Thu, 21 Feb 2019 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550784789;
        bh=sA7VhBFf+IzaFqjsolIFDiXiFvP2LNW92/ovKseyWus=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=CqTBnm1yyJ4F47xyYK4nu0S563a3rDP+0ij+o/g5ky3FiG0N06GQ61oeviAF3L7G0
         hp9h5/JdB1xwCeIJkqPd2PAhkU7iXK77AU/P2IwMV55NXlLrxfMfbuh3j+JgXSPKM0
         f0IH2w3lqBJOaD8qcR0VVshy4D5TfxNQYtq94y5U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] clk: samsung: exynos5: Fix possible NULL pointer exception on platform_device_alloc() failure
Message-ID: <155078478830.77512.13175629638067796591@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550749552-8133-1-git-send-email-krzk@kernel.org> <1550749552-8133-2-git-send-email-krzk@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550749552-8133-2-git-send-email-krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     stable@vger.kernel.org
Date:   Thu, 21 Feb 2019 13:33:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2019-02-21 03:45:51)
> During initialization of subdevices if platform_device_alloc() failed,
> returned NULL pointer will be later dereferenced.  Add proper error
> paths to exynos5_clk_register_subcmu().  The return value of this
> function is still ignored because at this stage of init there is nothing
> we can do.
>=20
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next

