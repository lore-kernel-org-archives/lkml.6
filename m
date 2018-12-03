Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566E8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B10208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCP7j4Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B10208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLCRq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:46:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbeLCRq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:46:26 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B36B208A3;
        Mon,  3 Dec 2018 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543859183;
        bh=v/T+7jkygn4kfU/K+q3LuInUPbcNrknnlfN8+2Wd84Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=MCP7j4Ajgfzk7TN6KSq6eEvLjPI9M7urz8NMyEFhsM93CSHFbrjkGtStxnPo53j1L
         7SOL2Uu0zwVwBKBqRczVW78Ah1sUT3D76PMJmBCjFdOMSWG3mKKf+lOQyGkqa7/MFY
         Y/FDwyfyDyMcO44rIteBShIZrYoWX7dmtWvi+BG8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543602089-21086-4-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1543602089-21086-1-git-send-email-tdas@codeaurora.org>
 <1543602089-21086-4-git-send-email-tdas@codeaurora.org>
Message-ID: <154385918289.88331.2422777226771408623@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 3/3] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Mon, 03 Dec 2018 09:46:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-30 10:21:29)
> Add support for the lpass clock controller found on SDM845 based devices.
> This would allow lpass peripheral loader drivers to control the clocks to
> bring the subsystem out of reset.
> LPASS clocks present on the global clock controller would be registered
> with the clock framework based on the protected-clock flag. Also do not
> gate these clocks if they are left unused, as the lpass clocks require
> the global clock controller lpass clocks to be enabled before they are
> accessed. Mark the GCC lpass clocks as CRITICAL, for the LPASS clock
> access.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next + added another #ifdef around unused clks to silence
unused warning.

