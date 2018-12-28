Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A100C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D701E20855
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546025833;
	bh=hWeuHkNMhjXGzVysfSCEvEiy2xj+fKZtovoQ7jH2J+E=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=0kzW+JAwdUXX8wut4UNXgETz8lE7Et8VknHO4cdKRA7eqM/EV8NiCskaLcDuJSlVO
	 sdxlD1G7+PrE+xfuvO4QDohZ+fTwqcPNSLBUWkAqkfvRv2hZ1ZZEIDhRQ3F3GQkS1X
	 c8itqJjmYIL0elHsF/aDzBW7vgY7bA+gEksFtqfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeL1ThN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387864AbeL1ThM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:37:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E3C20861;
        Fri, 28 Dec 2018 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546025831;
        bh=hWeuHkNMhjXGzVysfSCEvEiy2xj+fKZtovoQ7jH2J+E=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=Y1Xhbc6xLoOCnqHk8gmTGBGy9avBQBlRGGUbStVZ+7LY2BRb6aK/SIClECxnfT3Oc
         dK294lEN2Vkjpbf7vHk1XDMTBNEvrCrcEQSItYLlACKFK5Ho2eFZipLq415oZ6hRK+
         kgDP6nm7QCGjoZgRcW82hqN/j/4FmZO/36yrgKZ4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Message-ID: <154602583106.179992.17980601036225187687@swboyd.mtv.corp.google.com>
References: <20181226135716.5972-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: imx7d: fix refcount leak in imx7d_clocks_init()
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226135716.5972-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:37:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:57:16)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

