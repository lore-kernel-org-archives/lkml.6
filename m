Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83110C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D62F2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr5BgHvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D62F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeIFGYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeIFGYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:24:49 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E59112083E;
        Thu,  6 Sep 2018 01:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536198714;
        bh=SIxDu7IUVkMhpXE+ZGM35MKCy70NTIoE97makLdLPzc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Zr5BgHvxIsXdF7by6R3k1gyLPsrCqCgvbyLziWQri5BrycdwxDngPhTOyU65lVt7W
         szLwSaphA/4Xj2dolJGBsjjh+o1T06LFAFaQhy438/RNr4n0ialY8n40HeD1rc4NM6
         f3zl5U9oXjBSgsZdmYckBp4DtmhMLO54rEQ2tsOw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <15984aab-d815-56bb-af9c-7be9cfd9a103@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
References: <1533298874-22863-1-git-send-email-tdas@codeaurora.org>
 <1533298874-22863-3-git-send-email-tdas@codeaurora.org>
 <153540431524.129321.12826367247850332291@swboyd.mtv.corp.google.com>
 <15984aab-d815-56bb-af9c-7be9cfd9a103@codeaurora.org>
Message-ID: <153619871329.119890.8761547440925666785@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/2] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Wed, 05 Sep 2018 18:51:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-09-05 11:26:10)
> On 8/28/2018 2:41 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-08-03 05:21:14)
> >> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpas=
scc-sdm845.c
> >> new file mode 100644
> >> index 0000000..6f387f9
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
> > [...]
> >> +
> >> +/* CLK_OFF would not toggle until LPASS is not out of reset */
> > =

> > Can we change the branch ops to check for out of reset or not? Do the
> > clks even work when LPASS isn't out of reset? Why would the clk APIs
> > even be called on here if it hadn't taken LPASS out of reset?
> > =

> =

> The branches need to be turned ON before the LPASS is out of reset.
> But we would not be able to check the CLK_ENABLE bit.

Ok. Are the branches actually outputting any clk frequency when LPASS is
in reset? It sounds like the hardware is broken and we can't ever check
the halt bits?

