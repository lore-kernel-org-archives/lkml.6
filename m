Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ABBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5F1206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfAQAVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:21:04 -0500
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:35886 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727397AbfAQAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:21:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9DCDA1802E2D4;
        Thu, 17 Jan 2019 00:21:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: roll44_432cf94083b0b
X-Filterd-Recvd-Size: 1829
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Jan 2019 00:21:01 +0000 (UTC)
Message-ID: <e9c1698dcf0ef40eb15035cfb32d9b3456f197d6.camel@perches.com>
Subject: Re: [PATCH] sb1000: fix a couple of indentation issues
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Jan 2019 16:20:59 -0800
In-Reply-To: <20190117001301.29948-1-colin.king@canonical.com>
References: <20190117001301.29948-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 00:13 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an if statement and a return statement that are incorrectly
> indented. Fix these.
[]
> diff --git a/drivers/net/sb1000.c b/drivers/net/sb1000.c
[]
> @@ -540,12 +540,12 @@ sb1000_activate(const int ioaddr[], const char* name)
>  	if ((status = card_send_command(ioaddr, name, Command1, st)))
>  		return status;
>  	if (st[3] != 0xf1) {
> -    	if ((status = sb1000_start_get_set_command(ioaddr, name)))
> +		if ((status = sb1000_start_get_set_command(ioaddr, name)))

Probably better to remove the assignment in the if at the same time.

		status = sb1000_start_get_set_command(ioaddr, name);
		if (status)

>  			return status;
>  		return -EIO;
>  	}
>  	udelay(1000);
> -    return sb1000_start_get_set_command(ioaddr, name);
> +	return sb1000_start_get_set_command(ioaddr, name);
>  }
>  
>  /* get SB1000 firmware version */

