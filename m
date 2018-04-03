Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeDCSRJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:17:09 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:52045 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752246AbeDCSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:17:07 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3872:3873:3874:4250:4321:4605:5007:6119:7576:8531:8828:10004:10400:10848:11026:11232:11658:11914:12043:12296:12740:12760:12895:13069:13095:13255:13311:13357:13439:14180:14181:14659:14721:21080:21433:21627:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: cloud82_3dcab21ad9a54
X-Filterd-Recvd-Size: 2584
Message-ID: <1522779423.11653.63.camel@perches.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
From: Joe Perches <joe@perches.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Colin King <colin.king@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Date: Tue, 03 Apr 2018 11:17:03 -0700
In-Reply-To: <20180403173044.GA6031@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
         <20180403134540.GA29017@lenoch> <1522770597.11653.49.camel@perches.com>
         <20180403173044.GA6031@lenoch>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-03 at 19:30 +0200, Ladislav Michl wrote:
> On Tue, Apr 03, 2018 at 08:49:57AM -0700, Joe Perches wrote:
> > On Tue, 2018-04-03 at 15:45 +0200, Ladislav Michl wrote:
> > > On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Hello Colin,
> > > 
> > > > Trivial fix to spelling mistake in pr_debug message text
> > > 
> > > would you mind making this patch a bit less non-trivial and
> > > change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?
> > 
> > Presumably, then all the pr_<foo> calls should be changed.
> Yes, that's what non-trivial means here :)

More useful would be less specific originally.

> > diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
[]
> > @@ -1050,21 +1047,18 @@ static void asoc_ssc_exit(struct device *dev)
> >  int atmel_ssc_set_audio(int ssc_id)
> >  {
> >  	struct ssc_device *ssc;
> > -	int ret;
> >  
> >  	/* If we can grab the SSC briefly to parent the DAI device off it */
> >  	ssc = ssc_request(ssc_id);
> >  	if (IS_ERR(ssc)) {
> >  		pr_err("Unable to parent ASoC SSC DAI on SSC: %ld\n",
> > -			PTR_ERR(ssc));
> > +		       PTR_ERR(ssc));
> 
> Well, these are usefull, but unrelated changes. But while there, above
> pr_error deserves to be replaced with dev_err as well.

No  dai device.
