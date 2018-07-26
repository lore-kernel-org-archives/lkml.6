Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B545DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD3D206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqvcaYLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD3D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbeGZXY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbeGZXY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:24:29 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83384206B7;
        Thu, 26 Jul 2018 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532642742;
        bh=xNN8aMYBkk9BmsXDg3Xg08D3Mck/UDIGbdBaRYgDHmE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=EqvcaYLhwqHx3Yw2GGaLL1CAVhRezedgR5hTKP9SIwZRQcQkqPi5hmpdhksa0YxCK
         wLtoRPEXMfLWEg8xiJSAN9fM9is7kzAVMrHAiNDugz0+UgwAYzEVCL9Itk4DujWXgb
         huOJ58jjk5cHNEiYd9fkKfOYr9NAPrk+OMfPfrgI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1532343275-7027-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1532343275-7027-1-git-send-email-tdas@codeaurora.org>
 <1532343275-7027-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153264274182.48062.5474788613503562604@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5] clk: qcom: Add display clock controller driver for SDM845
Date:   Thu, 26 Jul 2018 15:05:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-23 03:54:35)
> Add support for the display clock controller found on SDM845
> based devices. This would allow display drivers to probe and
> control their clocks.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

This is fine to merge as long as you're ok with removing the no rate
cache flag. I can do that myself so you don't have to resend.

