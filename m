Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FBFC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E34827B77
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2aEyZltj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E34827B77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936027AbeF2SnW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935928AbeF2SnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:43:20 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D54927B85;
        Fri, 29 Jun 2018 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530297800;
        bh=rzT0CPHfZ15HV4qDVJ9qouCZguHm8Q19/mrUwl55qwU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=2aEyZltjnehZagGXSYWkR1a1MlNpZPY9R7SaTmmzQ5YaOrXJAYAAKzlJ29uPApnlh
         hk58itV5E/M2TA5QkOY41RvCbooX0wk+mMA4Xks88WJLn1m2S52vZLB78VmZMH/UlT
         ELmNfWlFz/mHKfz+cS9G+FlMEj+nDRsoUj4+oEYk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anson Huang <Anson.Huang@nxp.com>, fabio.estevam@nxp.com,
        kernel@pengutronix.de, mturquette@baylibre.com, shawnguo@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153029779960.143105.8299429804541348750@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 1/4] clk: imx6q: remove clks_init_on array
Date:   Fri, 29 Jun 2018 11:43:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-06-03 18:06:43)
> Clock framework will enable those clocks registered
> with CLK_IS_CRITICAL flag, so no need to have
> clks_init_on array during clock initialization now.
> =

> ARM clock is busy divider type which has the
> CLK_IS_CRITICAL flag set by default when registered.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

