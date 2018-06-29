Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB21C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCD527BFD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eveDopd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCD527BFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936541AbeF2SrM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754024AbeF2SrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:47:10 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10CEA27BF8;
        Fri, 29 Jun 2018 18:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530298030;
        bh=Yy6COPgFAOF50e4C51ZH/f5IpUtle296CEn7PED/bxM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=eveDopd5gwJsA3qkd0K5NBG/IZQrK/PklaMiEwh78OSylV9Uua0OLQBn4jaQ050d7
         b1jgyzjuzlJ2akpPMWINZaMKeHO824Upx7sj3tDWRAZhh6HHXwiAhjeV2jk4+qyOxw
         l+nVxBemN9RBSbh9l9P5CV4X6iV2O5oDK/1Y6Rd8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Philipp Puschmann <pp@emlix.com>, shawnguo@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180608101924.31195-1-pp@emlix.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, pp@emlix.com,
        linux-kernel@vger.kernel.org, fabio.estevam@nxp.com,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20180608101924.31195-1-pp@emlix.com>
Message-ID: <153029802935.143105.13959674411016503894@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
Date:   Fri, 29 Jun 2018 11:47:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philipp Puschmann (2018-06-08 03:19:24)
> q/dl datasheets list the 5th selection value for ck01_sel as
> video_27M_clk_root.
> =

> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
> as parent for IMX6QDL_CLK_CKO1_SEL.
> =

> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> ---

Applied to clk-next

