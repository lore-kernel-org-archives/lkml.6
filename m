Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A136DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70297205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="oIZ8ofcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbfAOVLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:11:41 -0500
Received: from mail.horus.com ([78.46.148.228]:51915 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732985AbfAOVLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:11:41 -0500
Received: from lenny.lan (62-47-205-132.adsl.highway.telekom.at [62.47.205.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl Lenny", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id 2D0A164137;
        Tue, 15 Jan 2019 22:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1547586698;
        bh=Oz2MYHFzHbvzb/4uDMVUcPJLGRSFPdyJJ/XTEX/Si80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oIZ8ofcPd1dPvMazLIlVMzRNZHxuzIi5PAhdGvb9UuNcdVsYO2NwGwwO7VTyHTql1
         H6u0q/jbjSSVhvqLLAv88Bsh8FGWB4vPgCD77sgrpi3uV3lgRxL5EjGwq+igeV6/b4
         9m6yDt/k0tZYTeL0DBJNf9ZgE+XFTomn0r/YdEMY=
Received: by lenny.lan (Postfix, from userid 1000)
        id 8F958100068; Tue, 15 Jan 2019 22:11:37 +0100 (CET)
Date:   Tue, 15 Jan 2019 22:11:37 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, rohkumar@qti.qualcomm.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, rohkumar@qti.qualcomm.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 01:35:07PM -0600, Pierre-Louis Bossart wrote:
> 
> On 1/14/19 6:06 PM, Mark Brown wrote:
> > On Fri, Jan 11, 2019 at 03:49:08PM -0600, Pierre-Louis Bossart wrote:
> > 
> > > Adding some traces I can see that the the platform name we use doesn't seem
> > > compatible with your logic. All the Intel boards used a constant platform
> > > name matching the PCI ID, see e.g. [1], which IIRC is used to bind
> > > components. Liam, do you recall in more details if this is really required?
> > That's telling me that either snd_soc_find_components() isn't finding
> > components in the same way that we do when we bind things which isn't
> > good or we're binding links without having fully matched everything on
> > the link which also isn't good.
> > 
> > Without a system that shows the issue I can't 100% confirm but I think
> > it's the former - I'm fairly sure that those machines are relying on the
> > component name being initialized to fmt_single_name() in
> > snd_soc_component_initialize().  That is supposed to wind up using
> > dev_name() (which would be the PCI address for a PCI device) as the
> > basis of the name.  What I can't currently see is how exactly that gets
> > bound (or how any of the other links avoid trouble for that matter).  We
> > could revert and push this into cards but I would rather be confident
> > that we understand what's going on, I'm not comfortable that we aren't
> > just pushing the breakage around rather than fixing it.  Can someone
> > with an x86 system take a look and confirm exactly what's going on with
> > binding these cards please?
> 
> Beyond the fact that the platform_name seems to be totally useless,
> additional tests show that the patch ('ASoC: soc-core: defer card probe
> until all component is added to list') adds a new restriction which
> contradicts existing error checks.
> 
> None of the Intel machine drivers set the dailink "cpu_name" field but use
> the "cpu_dai_name" field instead. This was perfectly legit as documented by
> the code at the end of soc_init_dai_link()

This should be fixed by the patch
"ASoC: core: Don't defer probe on optional, NULL components" which Mark
already applied to his tree. See
http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144323.html

Maybe the defer card probe logic needs to be extended to also check if
dai_link_name had already been registered (either cpu or cpu_dai_name
needs to be set), not 100% sure which problem the defer card probe patch
was trying to solve.

so long,

Hias

> 
>     /*
>      * At least one of CPU DAI name or CPU device name/node must be
>      * specified
>      */
>     if (!link->cpu_dai_name &&
>         !(link->cpu_name || link->cpu_of_node)) {
>         dev_err(card->dev,
>             "ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for
> %s\n",
>             link->name);
>         return -EINVAL;
>     }
> 
> The code contributed by Qualcomm only checks for cpu_name, which prevents
> the init from completing.
> 
> So if we want to be consistent, the new code should be something like:
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b680c673c553..2791da9417f8 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1154,7 +1154,7 @@ static int soc_init_dai_link(struct snd_soc_card
> *card,
>          * Defer card registartion if cpu dai component is not added to
>          * component list.
>          */
> -       if (!soc_find_component(link->cpu_of_node, link->cpu_name))
> +       if (!link->cpu_dai_name && !soc_find_component(link->cpu_of_node,
> link->cpu_name))
>                 return -EPROBE_DEFER;
> 
>         /*
> 
> or try to call soc_find_component with both cpu_name or cpu_dai_name, if
> this makes sense?
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
