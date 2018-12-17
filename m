Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9055C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD36206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbeLQLqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:46:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50831 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeLQLqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:46:19 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id e369d3b58aea1374; Mon, 17 Dec 2018 12:46:17 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kevin Hilman <khilman@baylibre.com>, Thomas Meyer <thomas@m3y3r.de>
Cc:     khilman@kernel.org, nm@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / AVS: SmartReflex: NULL check before some freeing functions is not needed.
Date:   Mon, 17 Dec 2018 12:45:53 +0100
Message-ID: <1792812.5VpxBR0bW8@aspire.rjw.lan>
In-Reply-To: <7hy38vuc8e.fsf@baylibre.com>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de> <1543760930051-514988180-4-diffsplit-thomas@m3y3r.de> <7hy38vuc8e.fsf@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 11, 2018 7:53:05 PM CET Kevin Hilman wrote:
> Thomas Meyer <thomas@m3y3r.de> writes:
> 
> > NULL check before some freeing functions is not needed.
> >
> > Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
> > ---
> >
> > diff -u -p a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> > --- a/drivers/power/avs/smartreflex.c
> > +++ b/drivers/power/avs/smartreflex.c
> > @@ -1010,8 +1010,7 @@ static int omap_sr_remove(struct platfor
> >  
> >  	if (sr_info->autocomp_active)
> >  		sr_stop_vddautocomp(sr_info);
> > -	if (sr_info->dbg_dir)
> > -		debugfs_remove_recursive(sr_info->dbg_dir);
> > +	debugfs_remove_recursive(sr_info->dbg_dir);
> >  
> >  	pm_runtime_disable(&pdev->dev);
> >  	list_del(&sr_info->node);
> 

Patch applied, thanks!

