Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271DBC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF382086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsPJ8ynP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF382086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJQFcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQFcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:32:45 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095EA2086E;
        Tue, 16 Oct 2018 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539726025;
        bh=R6SRePrsalPo6P2ZGp8KtMpUueN/JTel6FmrLklnoeI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=AsPJ8ynPfnkQ47t8eMFyYmEV0cW0ZK0FuBfJ8iPhICJQnR18ls55lRyL6uR6vFKHD
         DkCZY6oJ5TK9+e3dTgU6YhIfwmYrfglcKMsSYu0HnPTMqnKKxUyXnfeds59YPEsPXv
         twC97wYt3DUz8NS3RgMuUxEcErQuenReqxSaJh9g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539109679-8964-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1539109679-8964-1-git-send-email-tdas@codeaurora.org>
 <1539109679-8964-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153972602440.5275.16863565217890442118@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Tue, 16 Oct 2018 14:40:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-09 11:27:59)
> Add support for the lpass clock controller found on SDM845 based devices.
> This would allow lpass peripheral loader drivers to control the clocks to
> bring the subsystem out of reset.
> LPASS clocks present on the global clock controller would be registered
> with the clock framework based on the device tree flag. Also do not gate
> these clocks if they are left unused, as the lpass clocks require the
> global clock controller lpass clocks to be enabled before they are
> accessed. During clk_disable_unused as these dependency cannot be
> maintained accessing these LPASS clocks would result in unclocked access.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

I still have open questions about the GCC clks and if they can be left
on all the time or turned on in this clk driver instead. Either way, the
DT binding should specify that this clock controller node uses the ones
provided by GCC. So I'm marking this as 'changes requested' to drop from
my queue.

