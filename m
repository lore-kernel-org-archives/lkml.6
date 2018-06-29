Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B9CC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B90324CB4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9iG27Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B90324CB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937200AbeF2RSu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935093AbeF2RSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:18:49 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B36B924417;
        Fri, 29 Jun 2018 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530292728;
        bh=ljQcZzQo5Cv3M6pSQgdoM5lip3Z/nIvHtIIRoGh+CZo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Y9iG27WrtAZON3dfQUn2DXQ9dL4w+oQObiYixwtI3PnzWXJ7lcASzbKaDHfoogvgK
         eIVqziw54m8u6rErJlGAy4LqUuF2WoRtSgZbbNPND1rLpn20B4YE5HPaxb6c4/gay/
         epPZpmyeFpIFTbix5IzPBKPGDS4S4kvy7GlqaxGc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
Message-ID: <153029272800.143105.1065337298977850107@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clkdev: Remove duplicated negative index check from
 __of_clk_get()
Date:   Fri, 29 Jun 2018 10:18:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2018-05-18 03:58:40)
> __of_clk_get() calls of_parse_phandle_with_args(), which rejects
> negative indices since commit bd69f73f2c81eed9 ("of: Create function for
> counting number of phandles in a property").
> =

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next

