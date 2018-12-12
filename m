Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC1FC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E43920672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E43920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLLATz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:19:55 -0500
Received: from muru.com ([72.249.23.125]:57540 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbeLLATz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:19:55 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1FB0B8027;
        Wed, 12 Dec 2018 00:19:57 +0000 (UTC)
Date:   Tue, 11 Dec 2018 16:19:50 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Message-ID: <20181212001950.GX6707@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
 <20181211141649.GL6707@atomide.com>
 <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181211 23:16]:
> 
> Hi Tony
> 
> > The issue I have with that it does not then follow the binding doc :)
> > 
> > See this part in Documentation/devicetree/bindings/graph.txt:
> > 
> >  "If a single port is connected to more than one remote device, an
> >  'endpoint' child node must be provided for each link."
> > 
> > Isn't the I2C TDM case the same as "single port connecected to
> > more than one remote device" rather than multiple ports?
> > 
> > To me it seems we're currently only handling the multiple ports
> > case, and not multiple endpoints for a port. Other than fixing
> > that, things should work just as earlier with my two patches.
> > That is unless I accidentally broke something.
> > 
> > So just trying to correct the binding usage. Or am I missing
> > something?
> 
> I'm not 100% sure your "I2C TDM case", but you can check
> multi-endpoint sample on "Example: Multi DAI with DPCM" below.
> "pcm3168a" is using multi-endpoint.
> Does this help you ?
> 
> 	https://patchwork.kernel.org/patch/10712877/

Hmm, so do you have multiple separate ports at the "&sound" node
hardware? If so then yeah multiple ports make sense.

But if you only a single physical (I2S?) port at the
"&sound" node hardware, then IMO you should only have one
port and multiple endpoints there according to the graph.txt
binding doc.

In my McBSP case there is only a single physical I2S port
that can be TDM split into timeslots.

Regards,

Tony
