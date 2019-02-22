Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC617C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DD02077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550859451;
	bh=0GcixBsDImIdeWgKwa4LPLprC+UfjDL1uPhEnosRslw=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=XGis0ok1TA+ESBXsXHmbM90Z3nCB0bT/I20KMe5qOt1ehVjzzipUae28qOSEKImvV
	 I70olKsclXFERFJYbiLgiEhPel5/vIUXvFsrlNdW2U3TygtEfS7klo2Cbe0QOwohSm
	 Lwm8eRQPu7FaT1Eeh+J/s0IYf2Ttba05monRD6cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfBVSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVSRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:17:30 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A2F206B6;
        Fri, 22 Feb 2019 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550859449;
        bh=0GcixBsDImIdeWgKwa4LPLprC+UfjDL1uPhEnosRslw=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=kEORTDLCj7M2BTKHhIYTe76mQrl++GtqqCFnZeEkC+zvT2YAcsaru2wSDmyFvDe6i
         js5QM41w2Qxa2YLxhcntLLz8Gu97cKDCzVAbJSLe669Y6RizIA8WKaj1UjU9Nz8oNC
         K77aG4OhCLQLJRnTDcBWmTZQH9K06/h0kCK1xhnE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] clk: ingenic: Fix round_rate misbehaving with non-integer dividers
Message-ID: <155085944882.77512.7360345623017019976@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190128020921.16309-1-paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128020921.16309-1-paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Date:   Fri, 22 Feb 2019 10:17:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-01-27 18:09:20)
> Take a parent rate of 180 MHz, and a requested rate of 4.285715 MHz.
> This results in a theorical divider of 41.999993 which is then rounded
> up to 42. The .round_rate function would then return (180 MHz / 42) as
> the clock, rounded down, so 4.285714 MHz.
>=20
> Calling clk_set_rate on 4.285714 MHz would round the rate again, and
> give a theorical divider of 42,0000028, now rounded up to 43, and the
> rate returned would be (180 MHz / 43) which is 4.186046 MHz, aka. not
> what we requested.
>=20
> Fix this by rounding up the divisions.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Maarten ter Huurne <maarten@treewalker.org>
> Cc: <stable@vger.kernel.org>
> ---

Applied to clk-next

