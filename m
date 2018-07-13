Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C3BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA432083B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA432083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeGMQ6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:58:08 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:45164 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbeGMQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:58:08 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 8D8F35C0F8B; Fri, 13 Jul 2018 16:41:10 +0000 (UTC)
Date:   Fri, 13 Jul 2018 16:41:10 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Frank Li <Frank.Li@freescale.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: imx6ul: fix missing of_node_put()
Message-ID: <20180713164110.GA27943@osadl.at>
References: <1531480400-7664-1-git-send-email-hofrat@osadl.org>
 <153149925072.48062.9395649003513930129@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153149925072.48062.9395649003513930129@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:27:30AM -0700, Stephen Boyd wrote:
> Quoting Nicholas Mc Guire (2018-07-13 04:13:20)
> > of_find_compatible_node() is returning a device node with refcount
> > incremented and must be explicitly decremented after the last use
> > which is right after the us in of_iomap() here.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: commit 787b4271a6a0 ("clk: imx: add imx6ul clk tree support")
> 
> This is not how a Fixes line works. It doesn't have 'commit'. I'll
> remove it when applying so no need to resend.
>
sorry - guess I got that wrong on a whole set of patches - fill fix that
for future patches and thanks for fixing it here 

thx!
hofrat 
