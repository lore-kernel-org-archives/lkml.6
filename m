Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D32C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2C4258BF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2C4258BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965629AbeGASMz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:12:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37987 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964927AbeGASMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:12:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 391A82079C; Sun,  1 Jul 2018 20:12:51 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id C365D20703;
        Sun,  1 Jul 2018 20:12:50 +0200 (CEST)
Date:   Sun, 1 Jul 2018 20:12:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: rawnand: mxc: remove __init qualifier from
 mxcnd_probe_dt
Message-ID: <20180701201250.5f93b70e@xps13>
In-Reply-To: <1530132464-8210-1-git-send-email-martin@kaiser.cx>
References: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
        <1530132464-8210-1-git-send-email-martin@kaiser.cx>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Kaiser <martin@kaiser.cx> wrote on Wed, 27 Jun 2018 22:47:44
+0200:

> Using the sysfs unbind, bind nodes, mxcnd_probe and mxcnd_probe_dt can
> potentially be called at any time. After the __init functions are cleaned,
> mxcnd_probe_dt is no longer available. Calling it anyway causes a crash.
> 
> mxcnd_probe used to be marked as __init, this was removed years ago.
> Remove the __init qualifier from from mxcnd_probe_dt as well.
> 
> Fixes: 06f255106923 ("mtd: remove use of __devinit")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---

Applied to nand/next, thanks!
Miquèl
