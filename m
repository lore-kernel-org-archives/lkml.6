Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF34C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAEF20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546025770;
	bh=HI0MlmzvQaNx/p+epLEZS4z9ohv5lyMuIwJbvWPMrBo=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=QuRQnfndovH50Y9OGOuTVQ+ptTCJ5dKYDVpAq+uEGEhYK/H7UxeHJojuBbj21XPla
	 PdgfqRlaUZ8W2VTQWfR5HK0xfE1b7kbkENwHKCYIOj3N2XDg5VpXp8uKfG84PTlWQ5
	 WDHPCSjC8XoLnOV8kpwmbsHoDjkRkSLtDvRZyU3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbeL1TgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbeL1TgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:36:09 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC7420861;
        Fri, 28 Dec 2018 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546025768;
        bh=HI0MlmzvQaNx/p+epLEZS4z9ohv5lyMuIwJbvWPMrBo=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=TXysDoEdicttPwLvir3cJI4Czn3qI6jcgV/PLtlnEzudToAcY9m2LUabZzUvyRLYR
         isO2SMgUhdukiuqMYHHEaeLvVQc3dDq5MZPvbi3KMFT6OjmwFxPof7PRbc1GS49Bza
         XhFPiswi/nGqRsdbS1z323KDnhJAJ1hSJBbODIBs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Message-ID: <154602576790.179992.5065715622934818332@swboyd.mtv.corp.google.com>
References: <20181226135300.5710-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] clk: imx6q: fix refcount leak in imx6q_clocks_init()
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <20181226135300.5710-1-tiny.windzz@gmail.com>
Date:   Fri, 28 Dec 2018 11:36:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-12-26 05:53:00)
> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

