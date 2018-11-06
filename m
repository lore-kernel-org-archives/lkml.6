Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA3C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1593920862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPvCvF/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1593920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbeKGCmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389426AbeKGCmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:42:25 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A14320862;
        Tue,  6 Nov 2018 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541524573;
        bh=7RRIaf/9LnYYHwmQwIaloGyYebWArkYNu5lG737LAAI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=LPvCvF/Gha7D+yvnHCvZh6rAx61lWrZ8s40XoO8avS34af+BCWnVZI3WEfkiZFWQp
         Uxi98XzCM60UmDfMUG3A2dAb7Q7tuKjz12mcCMPzfYH84kAQlDclHvdN0zSWWR5kiB
         IOhtReEIhtltl3UyRhAl1WSmoHlY7rRnxOm7UUiI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <8d495713-d601-dcc8-23ee-dc31185e6a7c@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1540712140-26913-1-git-send-email-tdas@codeaurora.org>
 <1540712140-26913-2-git-send-email-tdas@codeaurora.org>
 <154117671164.88331.752297297364277275@swboyd.mtv.corp.google.com>
 <8d495713-d601-dcc8-23ee-dc31185e6a7c@codeaurora.org>
Message-ID: <154152457264.88331.5152287370260040686@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Tue, 06 Nov 2018 09:16:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-02 20:16:20)
> On 11/2/2018 10:08 PM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-10-28 00:35:40)
> > =

> =

> How about moving the QSPI clocks too under this qcom property? Later =

> could add the support?

Yes the plan would be to have QSPI clks there too. Bjorn has sent the
patch now.

 https://lkml.kernel.org/r/20181106055013.11271-1-bjorn.andersson@linaro.org
