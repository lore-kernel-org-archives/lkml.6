Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED2C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1FA218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbfAWUyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:54:47 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:16953 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfAWUyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:54:47 -0500
Received: from belgarion ([86.206.19.74])
        by mwinf5d65 with ME
        id Twuk1z0091btlZA03wukSC; Wed, 23 Jan 2019 21:54:45 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 23 Jan 2019 21:54:45 +0100
X-ME-IP: 86.206.19.74
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 -next] mtd: docg3: Fix a possible memory leak of mtd->name
References: <20190123092819.5020-1-yuehaibing@huawei.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 23 Jan 2019 21:54:44 +0100
In-Reply-To: <20190123092819.5020-1-yuehaibing@huawei.com> (YueHaibing's
        message of "Wed, 23 Jan 2019 17:28:19 +0800")
Message-ID: <87r2d3yu0b.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> In case DOC_CHIPID_G3, mtd->name is not freed in err handling path,
> which is alloced by kasprintf(). Fix this by using devm_kasprintf().
>
> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: use devm_kasprintf
> ---
>  drivers/mtd/devices/docg3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
