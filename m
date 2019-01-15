Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F85C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8065820859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="Q9VSrr5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbfAOSHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:07:21 -0500
Received: from mail.horus.com ([78.46.148.228]:53137 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387562AbfAOSHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:07:20 -0500
Received: from [192.168.1.20] (62-47-205-132.adsl.highway.telekom.at [62.47.205.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id 313CB6412E;
        Tue, 15 Jan 2019 19:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1547575638;
        bh=9YmzKlyIHpJwOTa85+9jd5RRQkR42ul7pCdFJrK5ctA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9VSrr5Wc1jmCyZ/SpUcjJ75cLTOumjh698XOaP/U4M4paippoiI0XQPOpsPn2trQ
         mmWQW67p52bmDboYYSkHMJuD+msv+KFlnv1cWj1Hbg3lOpB90jPGv3Fwwfs608mPq5
         hgq5g95LP+60L7wA+oRByIA+ko8Qlx4YtwUyDiC4=
Received: by camel2.lan (Postfix, from userid 1000)
        id 44BD11C72A2; Tue, 15 Jan 2019 19:07:17 +0100 (CET)
Date:   Tue, 15 Jan 2019 19:07:17 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name
 vs. of_node assignement
Message-ID: <20190115180716.55a6uvdrfhb7b7ux@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Jon Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel@ziswiler.com>
References: <52f5f2cf-9260-f9c5-f73d-3c3d5debc86b@nvidia.com>
 <20190109141439.GE10405@sirena.org.uk>
 <875zuxb9uy.wl-kuninori.morimoto.gx@renesas.com>
 <a2068291-e554-cc4f-9af9-0022f3c4de34@nvidia.com>
 <871s5kqb43.wl-kuninori.morimoto.gx@renesas.com>
 <dfdc497f-9e52-99d7-208c-d8eef31fe61d@nvidia.com>
 <87h8efpoxh.wl-kuninori.morimoto.gx@renesas.com>
 <ea6b6a3a-b4eb-1d29-51fd-330b2b170005@nvidia.com>
 <20190114230255.GK11073@sirena.org.uk>
 <312f8e32-36ed-cadb-77cb-54267680fefb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <312f8e32-36ed-cadb-77cb-54267680fefb@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:26:42PM +0000, Jon Hunter wrote:
> 
> On 14/01/2019 23:02, Mark Brown wrote:
> > On Fri, Jan 11, 2019 at 09:15:42AM +0000, Jon Hunter wrote:
> >> On 11/01/2019 08:51, Kuninori Morimoto wrote:
> > 
> >>> So, can you agree about these ?
> >>> 1) Add enough information/documentation about legacy/modern style and its plan.
> >>> 2) Add dirty pointer fixup patch as workaround
> >>> 3) switch to modern style as much as possible
> > 
> >> I think that Mark needs to decided on whether use your 'dirty pointer'
> >> fix or not.
> > 
> > I've gone ahead with Curtis' version of Morimoto-san's patch just now -
> > hopefully that's fine for v5.0.  Like we've been saying neither approach
> > is ideal, thanks Jon and Morimoto-san for your efforts analyzing this
> > and your proposals.
> 
> Thanks! Works for me.

Thanks alot, works here, too on 4.20 and 5.0-rc2!

so long,

Hias
