Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1E2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ED72148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546000990;
	bh=h1cg1oZR2SrnRKR+KwTMz/5jvRmrED8/uJeZh3vBwKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1cpTwWjHategDSL20kYrmjCWUWbqBzweYhoWsYnaZoIciSeFjqWFDg/96QQfgFE5Q
	 N7eGdGHwhj3tjCqLeeya3NgpNLtflWKxMXej1dov/iZh/WDGWWhLOU2lSloZIbSIru
	 BHQ3IUUC4tolwXI0NMOEXmzA2JY66lIqZYAKCbdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeL1MnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:43:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50769 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeL1MnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:43:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so18893517wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yz/MRyM50Rm0JKta6ljqXzp6dErvqEjEqax0ToTJL6k=;
        b=Ss0ZzM03qNnT8S0jXUE1JvvTX0Vh4KCHFTbvnwiQzjYMAgoNvYPeGgNZMzdb+bUWeO
         f2PwdWEXw3D+0BgMZkXMAjJH1bixSuYCNOuTpRZHnMVnDLD+//LVMHadfWdg/KF52G14
         FQVSiNNAMiSxXLq/TdxWAjTvz2tBhVDVHLee8NDYLt5Je3YrslZ+XPIixlxDNSj1/qVO
         VyWBzz6aZrYF1UapHY/JcG3hSjqkryzSNVRDrg/dQ7wz5wfwjlaqGokv638tNfN/Mc7w
         XHqIFbgG4ooUXEI4DQsw7RumFGHG++uK6BidmTCIzZsQ0EwzzDvvlNnwNVMjBjDMfXhZ
         +zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yz/MRyM50Rm0JKta6ljqXzp6dErvqEjEqax0ToTJL6k=;
        b=i2jaaTw5ntDf0Char3Lk+n5aPr/7cn/hbjPXu1+jbPFWXSocrZ//QZoMuqp73GVwoG
         E9vaZLVS93EwPEPFjxhaRFr4ePFYYSpULPax33b8Qx9w5+pE1jl5WM7nbzhO1BImct12
         BRtwu/+guwFppc11vCNceXhWPm+ABX4qzwLwubTUpT8XnPamObT9UMXN72+PrjLshMlE
         jsqHFwcDaPZ6wzsR4oPuKlJIuyASsbPFgaYm+caTOxexer1ghfmBd17fd9R/73bJXpi7
         RHXxsOxTE7YpnPNUtFIqyzdb+3pcVrJbPzgoPcSpPwXSNRZ9xLghJuvGPxMMZyuy5zp4
         aT5A==
X-Gm-Message-State: AA+aEWYt0K6e3DT2z1wPhBhxDybydiRRDHvNx6dXWg5e+7PrQlCtglCh
        LF5l0z6fHR02Crjd4Gt2Rfc=
X-Google-Smtp-Source: ALg8bN5xK2Vl4VCvq4zqoLuqMlVVVujf2w1PbSqKPOp0CZBKCoexBagQc7ueObIHtorQuOE1Kt9k5g==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr24726819wmg.51.1546000986467;
        Fri, 28 Dec 2018 04:43:06 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f130sm21863273wme.41.2018.12.28.04.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 04:43:05 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:43:03 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 4.21
Message-ID: <20181228124303.GA16558@gmail.com>
References: <s5hk1k48ayx.wl-tiwai@suse.de>
 <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Dec 20, 2018 at 7:38 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-4.21-rc1
> 
> Hmm.
> 
> It turns out that commit c337104b1a16 ("ALSA: HD-Audio: SKL+: abort
> probe if DSP is present and Skylake driver selected") causes my laptop
> (XPS13 9350) to no longer suspend.

Just a wild guess, I can see two ways in which that commit could make a 
difference on your setup:

1)

If any of these is not set in your .config:

+       select SND_HDA_INTEL_DSP_DETECTION_SKL if SND_SOC_INTEL_SKL
+       select SND_HDA_INTEL_DSP_DETECTION_APL if SND_SOC_INTEL_APL
+       select SND_HDA_INTEL_DSP_DETECTION_KBL if SND_SOC_INTEL_KBL
+       select SND_HDA_INTEL_DSP_DETECTION_GLK if SND_SOC_INTEL_GLK
+       select SND_HDA_INTEL_DSP_DETECTION_CNL if SND_SOC_INTEL_CNL
+       select SND_HDA_INTEL_DSP_DETECTION_CFL if SND_SOC_INTEL_CFL

I.e. I'd enable all of the SND_SOC_INTEL_* options to cover this angle.

2)

There's the added logic of checking whether the DSP is enabled:

+       /* check if this driver can be used on SKL+ Intel platforms */
+       if ((pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) &&
+           pci->class != 0x040300)
+               return -ENODEV;
+

if pci->class is not 0x040300 the driver could end up not detecting the 
device while previously it would.

That code goes through several transformations later on - but the hack 
below should make the commit an invariant. I think. Totally untested 
though.

Thanks,

	Ingo


==============>

 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e42cc2230977..f9e9c87f6d15 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2056,7 +2056,7 @@ static int azx_probe(struct pci_dev *pci,
 	if (pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) {
 		switch (skl_pci_binding) {
 		case SND_SKL_PCI_BIND_AUTO:
-			if (pci->class != 0x040300) {
+			if (0 && pci->class != 0x040300) {
 				dev_info(&pci->dev, "The DSP is enabled on this platform, aborting probe\n");
 				return -ENODEV;
 			}

