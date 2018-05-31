Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750790AbeEaWOt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:14:49 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:36429 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750711AbeEaWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:14:47 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2914:3138:3139:3140:3141:3142:3352:3622:3867:3868:3872:4321:5007:7901:10004:10400:10848:11026:11473:11658:11914:12043:12296:12438:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21627:30046:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:37,LUA_SUMMARY:none
X-HE-Tag: nest32_80de51d23775a
X-Filterd-Recvd-Size: 1645
Message-ID: <f6df017094f9ebaa13e552a11584d33971f04b0f.camel@perches.com>
Subject: Re: [PATCH] staging: mt7621-spi: Fix Coding style issues reported
 by checkpatch.pl.
From: Joe Perches <joe@perches.com>
To: Sankalp Negi <sankalpnegi2310@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>
Date: Thu, 31 May 2018 15:14:43 -0700
In-Reply-To: <20180531185542.phhu2rkdoq2czkav@localhost>
References: <20180531185542.phhu2rkdoq2czkav@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 00:25 +0530, Sankalp Negi wrote:
> diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
[]
> @@ -164,9 +165,8 @@ static inline int mt7621_spi_wait_till_ready(struct spi_device *spi)
>  		u32 status;
>  
>  		status = mt7621_spi_read(rs, MT7621_SPI_TRANS);
> -		if ((status & SPITRANS_BUSY) == 0) {
> +		if ((status & SPITRANS_BUSY) == 0)
>  			return 0;
> -		}
>  		cpu_relax();
>  		udelay(1);
>  	}

It might also be more readable to avoid a status temporary
and use a direct compare instead:

	for (i = 0; i < RALINK_SPI_WAIT_MAX_LOOP; i++) {
		if (!(mt7621_spi_read(rs, MT7621_SPI_TRANS) & SPITRANS_BUSY))
			return 0;
		cpu_relax();
		udelay(1);
	}

	return -ETIMEDOUT;
}
