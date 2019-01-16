Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A5C20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfAPUGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:06:45 -0500
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:55272 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727511AbfAPUGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:06:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id CA36A21FA;
        Wed, 16 Jan 2019 20:06:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shoe85_1d87b57448e31
X-Filterd-Recvd-Size: 1214
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Jan 2019 20:06:42 +0000 (UTC)
Message-ID: <39a7f5c0177dc72033cb6f43a16d93407db7e182.camel@perches.com>
Subject: Re: [PATCH 5/6] spi: ath79: Remove some useless includes
From:   Joe Perches <joe@perches.com>
To:     Alban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Date:   Wed, 16 Jan 2019 12:06:41 -0800
In-Reply-To: <20190116185549.23295-5-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
         <20190116185549.23295-5-albeu@free.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 19:55 +0100, Alban Bedel wrote:
> Several include are not needed, remove them to keep the list clean.
[]
> diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
[]
> @@ -12,15 +12,12 @@
>   *
>   */
>  
> -#include <linux/kernel.h>

I think it's not a good idea to remove kernel.h
just because module.h indirectly #includes it via
moduleparam.h


