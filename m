Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31050C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF87826361
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF87826361
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933946AbeF0JB6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:01:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60995 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933529AbeF0JB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:01:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7ECDB20741; Wed, 27 Jun 2018 11:01:54 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id E5DF620876;
        Wed, 27 Jun 2018 11:01:14 +0200 (CEST)
Date:   Wed, 27 Jun 2018 11:01:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: mxc: remove __init qualifier from
 mxcnd_probe_dt
Message-ID: <20180627110115.490a2477@xps13>
In-Reply-To: <1530089557-30918-1-git-send-email-martin@kaiser.cx>
References: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
        <1530089557-30918-1-git-send-email-martin@kaiser.cx>
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

On Wed, 27 Jun 2018 10:52:37 +0200, Martin Kaiser <martin@kaiser.cx>
wrote:

> Using the sysfs unbind, bind nodes, mxcnd_probe and mxcnd_probe_dt can
> potentially be called at any time. After the __init functions are cleaned,
> mxcnd_probe_dt is no longer available. Calling it anyway causes a crash.
> 
> mxcnd_probe used to be marked as __init, this was removed years ago.
> Remove the __init qualifier from from mxcnd_probe_dt as well.
> 
> Fixes: 06f2551 ("mtd: remove use of __devinit")

Nitpick: the Fixes tag should use at least the 12 first characters of
the SHA-1 ID, see:

https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html#describe-your-changes

Thanks,
Miquèl
