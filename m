Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeDCSy3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:54:29 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:46242 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeDCSy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:54:27 -0400
Date: Tue, 3 Apr 2018 20:54:23 +0200
From: Ladislav Michl <ladis@linux-mips.org>
To: Joe Perches <joe@perches.com>
Cc: Colin King <colin.king@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
Message-ID: <20180403185423.GA8683@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180403134540.GA29017@lenoch>
 <1522770597.11653.49.camel@perches.com>
 <20180403173044.GA6031@lenoch>
 <1522779423.11653.63.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522779423.11653.63.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 11:17:03AM -0700, Joe Perches wrote:
> On Tue, 2018-04-03 at 19:30 +0200, Ladislav Michl wrote:
> > On Tue, Apr 03, 2018 at 08:49:57AM -0700, Joe Perches wrote:
> > > On Tue, 2018-04-03 at 15:45 +0200, Ladislav Michl wrote:
> > > > On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> > > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > Hello Colin,
> > > > 
> > > > > Trivial fix to spelling mistake in pr_debug message text
> > > > 
> > > > would you mind making this patch a bit less non-trivial and
> > > > change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?
> > > 
> > > Presumably, then all the pr_<foo> calls should be changed.
> > Yes, that's what non-trivial means here :)
> 
> More useful would be less specific originally.
> 
> > > diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> []
> > > @@ -1050,21 +1047,18 @@ static void asoc_ssc_exit(struct device *dev)
> > >  int atmel_ssc_set_audio(int ssc_id)
> > >  {
> > >  	struct ssc_device *ssc;
> > > -	int ret;
> > >  
> > >  	/* If we can grab the SSC briefly to parent the DAI device off it */
> > >  	ssc = ssc_request(ssc_id);
> > >  	if (IS_ERR(ssc)) {
> > >  		pr_err("Unable to parent ASoC SSC DAI on SSC: %ld\n",
> > > -			PTR_ERR(ssc));
> > > +		       PTR_ERR(ssc));
> > 
> > Well, these are usefull, but unrelated changes. But while there, above
> > pr_error deserves to be replaced with dev_err as well.
> 
> No  dai device.

As all call sites are already providing error message, so what about just
removing this one completely?
