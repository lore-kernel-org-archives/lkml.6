Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AC2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5625A2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5625A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIES2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:28:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50389 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeIES2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:28:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 361B4208AE; Wed,  5 Sep 2018 15:57:53 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id C328E20763;
        Wed,  5 Sep 2018 15:57:42 +0200 (CEST)
Date:   Wed, 5 Sep 2018 15:57:41 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 11/13] nvmem: add support for cell lookups from machine
 code
Message-ID: <20180905155741.22b7d0ef@bbrezillon>
In-Reply-To: <20180905095738.26406-12-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
        <20180905095738.26406-12-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Sep 2018 11:57:36 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

>  
> +struct nvmem_cell_lookup {
> +	const char		*nvmem_name;
> +	const char		*dev_id;

Shouldn't we have a con_id here?

> +	const char		*cell_id;
> +	struct list_head	node;
> +};
