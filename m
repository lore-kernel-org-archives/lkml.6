Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66241C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DF320989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol0nviXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DF320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeK2I1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:27:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeK2I1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:27:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931E32081B;
        Wed, 28 Nov 2018 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543440282;
        bh=4Igdg2EppaVjbzQms+X9136MlgdNKZfcnpLTs3gmAvc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Ol0nviXXr4IYGlCeutgq1lKf1C5NQp8i87J/QGlUB4zTyK1t9/Y8XiADQZAT2p+sI
         UATD9JeyPJ9OF73SukXNOtrVPUjQqTaAGbRqDlI39HeDGIbNFDmX7FzjeYmxHfHYXX
         tcsyE7cKhfBaPxzPUxbTc9HwA77D1Qx/xqGdZCTY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181128184859.70476-1-dianders@chromium.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20181128184859.70476-1-dianders@chromium.org>
Message-ID: <154344028193.88331.7749727366219598152@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: gpu_cc_gmu_clk_src has 5 parents, not 6
Date:   Wed, 28 Nov 2018 13:24:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-11-28 10:48:59)
> In an earlier version of commit 453361cdd757 ("clk: qcom: Add graphics
> clock controller driver for SDM845") there were 6 listed parents for
> "gpu_cc_gmu_clk_src".  In the version that landed there were 5.
> ...but "num_parents" was still left at 6.  On my system this goes boom
> at bootup.
> =

> Fixes: 453361cdd757 ("clk: qcom: Add graphics clock controller driver for=
 SDM845")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied to clk-next

