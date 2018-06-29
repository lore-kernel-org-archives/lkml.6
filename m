Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C9BC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992B827BC0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6MW7a2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992B827BC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936246AbeF2Soh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935054AbeF2Sog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:44:36 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D07AF27BC5;
        Fri, 29 Jun 2018 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530297875;
        bh=ZH0Uny51oK51lnDkxhHmRgxJZMe6GKHqEDtUTkooyD8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=q6MW7a2LDM7nrqzcAwGeOiWFOc5+dEdXXWTM7QwdXi6yTZRnYATVGKlQWdJ19Aril
         Oo7iQlhrT2ez2x6JWsYuy+PskQRtVS7dyYfry2lKY6mI2JnAT8ULDatj2fdMkwM9iF
         gpApAhuxDoLj/zmJf9unzZsTioXLqLQjkf9Nk3yo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Anson Huang <Anson.Huang@nxp.com>, fabio.estevam@nxp.com,
        kernel@pengutronix.de, mturquette@baylibre.com, shawnguo@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528074406-11735-4-git-send-email-Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
 <1528074406-11735-4-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153029787526.143105.9890407619664364865@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 4/4] clk: imx6ul: remove clks_init_on array
Date:   Fri, 29 Jun 2018 11:44:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-06-03 18:06:46)
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

