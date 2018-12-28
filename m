Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E71C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7136820869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546026093;
	bh=4sgQjtBuVaUW2wJD0Sc8/z+ZaxQvKCYPeuCbQzPDMgY=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=JKwjTgmYxJ+TujQJQ05qb+r8HFsM/o/E5VQyDITupbsOUr4PY1jwyUE8zVe0QZwGH
	 OTRf7RzXsYiZNLNoFDLlKAiZB1tJaJSavp2mnXPaTti1K0oZridp3Ir0W9hwG/v/Uc
	 MoGPuuBwWcwYvsGv28GmjpPlXsoOR6T916ut+cR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbeL1Tlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbeL1Tlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:41:31 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1934720861;
        Fri, 28 Dec 2018 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546026091;
        bh=4sgQjtBuVaUW2wJD0Sc8/z+ZaxQvKCYPeuCbQzPDMgY=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=u6QgBe20a87FRI4YEOeXCet/TMRA/58pUw1IwewFwB91eDRzNX6CUSSMXhAo1+MRd
         VVYpPQj8RDK/aJSDnMSm4fZE13IKWQcN83nunLePJW1yeSHOW85HUhuw1DaH4oVJpG
         sb/31ZnV6RLiicH9TxaLYPuajpERVDU73tDWROdY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Message-ID: <154602609026.179992.8277021671264365569@swboyd.mtv.corp.google.com>
References: <20181226135936.6102-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: vf610: fix refcount leak in vf610_clocks_init()
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226135936.6102-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:41:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:59:36)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

