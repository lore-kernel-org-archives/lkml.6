Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03152084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544469100;
	bh=70ky5jNiENNjxK7v/TPaMDr6GZk2DOehXnQlMX8dGXw=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=khjzACsmPYelkngce9ofF8RJ9UUmu6SPHAi7s37i13tvjWCb+JHS629gBd87UKW76
	 /OF9Rmm26RZbiqBSbdt/oWhzkGmyyUYzbFF/vXHvHiCMwMmallp4GgIcwtpt1n2KTt
	 ub5ngg99FVdsVCVzrMXVKx98n+BzLv/GlQt1vsMQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03152084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeLJTLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeLJTLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:11:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557552082F;
        Mon, 10 Dec 2018 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544469098;
        bh=70ky5jNiENNjxK7v/TPaMDr6GZk2DOehXnQlMX8dGXw=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=ZZHr7Hnk6h3goHXph1Q4TIZ36NBzFzsMPwyvwjIqORdO1QdLEPKaB9o+s9zFh4yY1
         asCTFF05U9FsEJduS4835sbBzQ47YOd9w8Rwh34SCL2dxqWTFZKneg71Ac46ew6s0B
         mTu3LZSbhJYShBDU4foxpNGAs3kGWi+FcuM05S6w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180925214940.15188-1-decatf@gmail.com>
Message-ID: <154446909759.17204.16576704793216207531@swboyd.mtv.corp.google.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Robert Yang <decatf@gmail.com>
Subject: Re: [PATCH V2] clk: tegra: Return the exact clock rate from clk_round_rate
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20180925214940.15188-1-decatf@gmail.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Date:   Mon, 10 Dec 2018 11:11:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Yang (2018-09-25 14:49:40)
> The current behavior is that clk_round_rate would return the same clock
> rate passed to it for valid PLL configurations. This change will return
> the exact rate the PLL will provide in accordance with clk API.
>=20
> Signed-off-by: Robert Yang <decatf@gmail.com>
> ---

Applied to clk-next

