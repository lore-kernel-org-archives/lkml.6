Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC7BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EFD24633
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EFD24633
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeGDHR0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:17:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35887 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752810AbeGDHRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:17:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C732E20732; Wed,  4 Jul 2018 09:17:22 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 92422206DE;
        Wed,  4 Jul 2018 09:17:22 +0200 (CEST)
Date:   Wed, 4 Jul 2018 09:17:22 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] gpiolib: Defer on non-DT find_chip_by_name() failure
Message-ID: <20180704091722.29f86ae3@bbrezillon>
In-Reply-To: <20180703221819.1825-1-jmkrzyszt@gmail.com>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
        <20180703221819.1825-1-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Jul 2018 00:18:19 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Avoid replication of error code conversion in non-DT GPIO consumers'
> code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> identified by its label in a registered lookup table is not ready.
> 
> See https://lkml.org/lkml/2018/5/30/176 for example case.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changelog
> v2: fix typo (latar -> later) - thanks Boris and Andy for catching this
> 
> I'm not sure if adding both Suggested-by: and Reviewed-by: heades both
> with the same person name is in line with good practices, please remove
> one if not.

I don't think that's a problem. Suggesting a solution and agreeing on
the implementation are 2 different things, so both are not mutually
exclusive IMO.
