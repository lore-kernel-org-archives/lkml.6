Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFC3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515820879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025623;
	bh=JHmVdEzag9bGYUQ/noI5UKcAwmSF91tMsdILM3HM3p8=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=Io4lyf/A+pQqJRXeaU4CZGqA9fKZ08nYACqSf3j05pYp3A3fuR/+6EpxmIKZ9riV7
	 Ps5tfAR6igtovSZmqC17nyTyN4Ot47FPTtLYHH4v0KeprK2HZUzCj59YBU15dU/Nak
	 acE5aEEIbtt8/YOaP+aU7+CLyVyJdpw5XIec81OE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3515820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeLEQAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbeLEQAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:00:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C610220850;
        Wed,  5 Dec 2018 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544025619;
        bh=JHmVdEzag9bGYUQ/noI5UKcAwmSF91tMsdILM3HM3p8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=fgYbUecIJlVLILd/3d/dNq3r6EZeEQH2BjbQH4Mt+UXXGRjrMtr+ips9PFFVoyj6G
         85Hdp5VXD3+bj2hTWX0OiBdfBieX0ZotxmMyC6iAvvAGJSuzxRNPaLTZccE3/4sJav
         tlsTvnQnxmm2KqrJIMJla79113iO9t29KjhnMWxs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543996920-17029-1-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1543996920-17029-1-git-send-email-tdas@codeaurora.org>
Message-ID: <154402561913.88331.391864642069686842@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Remove LPASS_CC config for GCC lpass clocks
Date:   Wed, 05 Dec 2018 08:00:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-05 00:02:00)
> The GCC lpass clocks are updated as protected, so clean up the ifdefers.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Ok. But this will have to wait for a few months until everything is
merged together. Was that the intention of sending this now instead of
later?
