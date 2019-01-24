Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAD6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C75A217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359297;
	bh=hUqTa21bLX778Lsa3+rWu7OXNXuJoqhQ2OILhGQE42A=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=mFlPLjy9IF3Gng+OYJJoH7Jsmp7nSINm/5OQxo/QnXy2wpCKHag9h89/0tn4p3Is1
	 Z4LtcSWP7uhqCVahhJfxMG0630y+vsaqltA4L5HoJl2r9yleDhuEyXVULfeafBci7Y
	 xaqRzQlu3Bkfv4LD9S9tFDU4fHkGoffhEzl3Np/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbfAXTsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733246AbfAXTmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:42:17 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E46218A2;
        Thu, 24 Jan 2019 19:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358936;
        bh=hUqTa21bLX778Lsa3+rWu7OXNXuJoqhQ2OILhGQE42A=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=BDugm4KXJbH4/M3rFgYt69DXGA2+iNiJ6q1EOIbpm63LSSCtSEeM2+AFlET2WgtkP
         jsV5AFEEm8aQuTuP1zIwcikt2cmT8ReW9NPFu4LGngGpA+3+lG+rrbDLM+1v3jTnZm
         tFtPNd0/ZxDrDlYBDxdkQgJEKw2yiruu5p28qmLc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] clk: qcom: gcc: Use active only source for CPUSS clocks
References: <1545157181-27095-1-git-send-email-tdas@codeaurora.org>
User-Agent: alot/0.8
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1545157181-27095-1-git-send-email-tdas@codeaurora.org>
Message-ID: <154835893585.136743.15387541783447066348@swboyd.mtv.corp.google.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 24 Jan 2019 11:42:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-18 10:19:41)
> The clocks of the CPUSS such as "gcc_cpuss_ahb_clk_src" is a CRITICAL
> clock and needs to vote on the active only source of XO, so as to keep the
> vote as long as CPUSS is active. Similar rbcpr_clk_src is also has the sa=
me
> requirement.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-fixes + added a Fixes tag.

