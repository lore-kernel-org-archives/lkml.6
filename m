Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E202C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CDD2082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 23:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CDD2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJ2Htd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:49:33 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:33139 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725984AbeJ2Htc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:49:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1F414181D3417;
        Sun, 28 Oct 2018 23:03:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: slave90_75577ab4d521e
X-Filterd-Recvd-Size: 1769
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 28 Oct 2018 23:03:26 +0000 (UTC)
Message-ID: <db30f8d56061f5cfec82e75e986149ac76f1ef11.camel@perches.com>
Subject: Re: [PATCH 2/9] w1: improve coding style by following strict 80
 column line limit
From:   Joe Perches <joe@perches.com>
To:     Steffen Vogel <post@steffenvogel.de>, linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>
Date:   Sun, 28 Oct 2018 16:03:25 -0700
In-Reply-To: <20181028220927.56227-3-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
         <20181028220927.56227-3-post@steffenvogel.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-28 at 23:09 +0100, Steffen Vogel wrote:
> This satisfies a checkpatch warning

Perhaps run your patches through checkpatch with --strict

> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
[]
> @@ -85,7 +85,8 @@ static void w1_slave_release(struct device *dev)
>  	sl->master->slave_count--;
>  }
>  
> -static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t name_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)

atypical alignment.

> []

> @@ -170,7 +173,9 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
>  	block->msg->len = 0;
>  	block->msg->status = (u8)-error;
>  	if (req_cmd) {
> -		struct w1_netlink_cmd *cmd = (struct w1_netlink_cmd *)block->msg->data;
> +		struct w1_netlink_cmd *cmd =
> +			(struct w1_netlink_cmd *) block->msg->data;

unnecessary space after cast


