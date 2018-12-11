Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFCDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA27E2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeLKFol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:44:41 -0500
Received: from muru.com ([72.249.23.125]:57314 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeLKFol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:44:41 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AB8E480F0;
        Tue, 11 Dec 2018 05:44:43 +0000 (UTC)
Date:   Mon, 10 Dec 2018 21:44:37 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Message-ID: <20181211054437.GK6707@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <87zhtcabc0.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhtcabc0.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181211 05:30]:
> 
> Hi Tony, again
> 
> > >  	mcbsp3_port: port {
> > > -		cpu_dai3: endpoint {
> > > +		cpu_dai3: endpoint@0 {
> > >  			dai-format = "dsp_a";
> > >  			frame-master = <&cpcap_audio_codec1>;
> > >  			bitclock-master = <&cpcap_audio_codec1>;
> > >  			remote-endpoint = <&cpcap_audio_codec1>;
> > >  		};
> > > +		cpu_dai_mdm: endpoint@1 {
> > > +			dai-format = "dsp_a";
> > > +			frame-master = <&cpcap_audio_codec1>;
> > > +			bitclock-master = <&cpcap_audio_codec1>;
> > > +			remote-endpoint = <&mot_mdm6600_audio_codec0>;
> > > +		};
> 
> audio-graph-scu-card and my posting merged audio-graph-card
> are assuming multi-endpoint will be used for DPCM purpose.
> 
> But, above endpoint connection seems you want to is
> not DPCM (?), I'm not sure.

Yes DPCM should work nicely here :)

So to recap, Sebastian already added the cpcap codec a while back,
please see arch/arm/boot/dts/omap4-droid4-xt894.dts for the soundcard
node. Then see the link below for an earlier email describing how the
various components are wired for TDM [0].

Hope that clarifies things a bit more,

Tony

[0] https://lkml.org/lkml/2018/3/28/405
