Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD8C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1669B2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1669B2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJCXu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:50:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45368 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbeJCXu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:50:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB34820719; Wed,  3 Oct 2018 19:01:41 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4746F206A1;
        Wed,  3 Oct 2018 19:01:31 +0200 (CEST)
Date:   Wed, 3 Oct 2018 19:01:30 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 8/8] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
Message-ID: <20181003190130.4c9e509f@bbrezillon>
In-Reply-To: <20181001124351.31615-8-ricardo.ribalda@gmail.com>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
        <20181001124351.31615-8-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 14:43:51 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> +static int gpio_flash_probe_gpios(struct platform_device *pdev,
> +				  struct async_state *state)
> +{
> +	struct physmap_flash_data *pdata;
> +	struct device_node *dn;
> +	struct resource *gpios = NULL;
> +	int i;
> +
> +	dn = pdev->dev.of_node;
> +	if (dn) {
> +		state->gpios = devm_gpiod_get_array(&pdev->dev, NULL,
> +						    GPIOD_OUT_LOW);

Did you consider using gpiod_set_array_value() to update the gpio vals
instead of having your own update loop (the for loop in the
gf_set_gpios() func)?
