Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeDKQBG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:01:06 -0400
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:49889 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752335AbeDKQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:01:05 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:4321:5007:7576:10004:10400:10848:11026:11232:11473:11658:11914:12043:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: goose81_436c11ed8d313
X-Filterd-Recvd-Size: 1773
Message-ID: <4690e30b3c4b97847123295f1994c6eafe4e0cbb.camel@perches.com>
Subject: Re: [PATCH 2/2] input: touchscreen mc13xxx: Add mc34708 support
From: Joe Perches <joe@perches.com>
To: Lukasz Majewski <lukma@denx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 11 Apr 2018 09:01:01 -0700
In-Reply-To: <20180411141340.30939-2-lukma@denx.de>
References: <20180411141340.30939-1-lukma@denx.de>
         <20180411141340.30939-2-lukma@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-11 at 16:13 +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has a different bit to enable pen detection. This
> adds the driver data and devtype necessary to probe the device
> and to distinguish between the mc13783 and the mc34708.

style trivia:

> diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
[]
> @@ -96,6 +135,10 @@ static void mc13783_ts_report_sample(struct mc13783_ts_priv *priv)
>  
>  	cr0 = (cr0 + cr1) / 2;
>  
> +	if (priv->drvdata->type == MC13XXX_TYPE_MC34708)
> +		if (cr0 > 4080)
> +			cr0 = 0;

For easy of reading, this multiple if block should either
use braces around the first if like:

	if (foo) {
		if (bar)
			single_statement;
	}

or be written

	if (foo && bar)
		single_statement;

I generally prefer the latter style.
