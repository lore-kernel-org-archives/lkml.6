Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA41C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4798720870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4798720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeLMAkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:40:14 -0500
Received: from muru.com ([72.249.23.125]:57892 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeLMAkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:40:13 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E3108809F;
        Thu, 13 Dec 2018 00:40:15 +0000 (UTC)
Date:   Wed, 12 Dec 2018 16:40:09 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [alsa-devel] [PATCH 0/2] Graph fixes for using multiple
        endpoints per port
Message-ID: <20181213004009.GK6707@atomide.com>
References: <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
 <20181211141649.GL6707@atomide.com>
 <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
 <20181212001950.GX6707@atomide.com>
 <877egf33m9.wl-kuninori.morimoto.gx@renesas.com>
 <87k1kfs0u5.wl-kuninori.morimoto.gx@renesas.com>
 <20181212152725.GE6707@atomide.com>
 <87imzy2sh1.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imzy2sh1.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181213 00:24]:
> (snip)
> > foo = <&ep 0>;
> > bar = <&ep 1>;
> 
> Ahh, it looks nice idea !
> but hmm..., it seems dtc doesn't allow us to use #address-cells = <2>
> for "remote-endpoint".

OK. Yeah let's scrap that then, it does not suit for
endpoints it seems. Thanks for checking.

> According to OF graph maintainer, he said that
> counting port / endpoint are not guaranteed,
> and we need to use "reg".
> (It is the reason of b6f3fc005a2c8b425d7a0973b43bef05890bf479)
> 
> If you could double checked, and we could agreed
> that "reg" is the solution for us.
> I will post patches.

OK yes your "reg" proposal works for me.

Regards,

Tony
