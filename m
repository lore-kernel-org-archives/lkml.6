Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1DECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766B220850
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2UN/moL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766B220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeGMQmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729788AbeGMQmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:42:52 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE3420840;
        Fri, 13 Jul 2018 16:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531499251;
        bh=Mkdfgg7wC0XSLQjFvBvifowAd/n8E2/iM3xWNOEWsW4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=O2UN/moLmv9tVfY1LrD4MMyrJEDdNS5x1nK+u5we6/w7CZsRt8NeDk9/1O7PDXuFq
         7574Nvaj+ktGjmXDWbq509SPl6OCvkfoal+YyGIIuntD8esOynxmEVcw76TBvjyr22
         awNn8RL5nM1Dzskw+iGbDq3OH9Dp9wbvoltFFKK0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531480400-7664-1-git-send-email-hofrat@osadl.org>
Cc:     Frank Li <Frank.Li@freescale.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <1531480400-7664-1-git-send-email-hofrat@osadl.org>
Message-ID: <153149925072.48062.9395649003513930129@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx6ul: fix missing of_node_put()
Date:   Fri, 13 Jul 2018 09:27:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Mc Guire (2018-07-13 04:13:20)
> of_find_compatible_node() is returning a device node with refcount
> incremented and must be explicitly decremented after the last use
> which is right after the us in of_iomap() here.
> =

> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 787b4271a6a0 ("clk: imx: add imx6ul clk tree support")

This is not how a Fixes line works. It doesn't have 'commit'. I'll
remove it when applying so no need to resend.

