Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id stOHNZckHVvvaAAAmS7hNA
	; Sun, 10 Jun 2018 13:16:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BE6BF607E7; Sun, 10 Jun 2018 13:16:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 55CA8606DD;
	Sun, 10 Jun 2018 13:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55CA8606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeFJNQE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 09:16:04 -0400
Received: from botnar.kaiser.cx ([176.28.20.183]:51210 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753466AbeFJNQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 09:16:03 -0400
Received: from martin by botnar.kaiser.cx with local (Exim 4.72)
        (envelope-from <martin@botnar.kaiser.cx>)
        id 1fS0B6-0002oC-JP; Sun, 10 Jun 2018 15:14:40 +0200
Date: Sun, 10 Jun 2018 15:14:40 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: mxc: set spare area size register
 explicitly
Message-ID: <20180610131440.GA10544@botnar.kaiser.cx>
References: <1528025495-14443-1-git-send-email-martin@kaiser.cx>
 <20180607171911.7a7ee649@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607171911.7a7ee649@xps13>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Thus wrote Miquel Raynal (miquel.raynal@bootlin.com):

> > Usually, this register is updated from settings in the IIM fuses when
> > the system is booting from nand flash. For other boot media, however,

> s/nand/NAND

ok

> > +	/* spare area size in 16bit words */

> I thought I understood the problem with your commit message but
> then I don't get this comment. What's the link between 16-bit buses? Is
> this preset valid for both 8 and 16-bit bus width?

The register value is unrelated to the bus width.

> > +	writew(mtd->oobsize >> 1, NFC_V21_RSLTSPARE_AREA);
> > +

> If this is for dividing per two oobsize value,

That's exactly what I wanted to do: mtd->oobsize is in bytes, the
register value must be in 16bit words (the specification uses the term
half-words, I'll update the comment while at it).

> I would really prefer a '/ 2' and let the compiler optimize things.
> Unless the spec is explicit about some shifting of course.

Ok, I'll  use / 2 and resend the patch shortly.

Best regards,
Martin
