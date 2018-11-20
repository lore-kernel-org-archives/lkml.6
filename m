Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F190C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FD020851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FD020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eclipso.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeKTSfu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:35:50 -0500
Received: from mail.eclipso.de ([217.69.254.104]:45405 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeKTSfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:35:50 -0500
Received: from roadrunner.suse (p5B318D4A.dip0.t-ipconnect.de [91.49.141.74])
        by mail.eclipso.de with ESMTPS id 04EAA638
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:07:59 +0100 (CET)
X-ESMTP-Authenticated-User: 0001F234
From:   stakanov <stakanov@eclipso.eu>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Date:   Tue, 20 Nov 2018 09:07:57 +0100
Message-ID: <3267610.1jAA2Txdp3@roadrunner.suse>
In-Reply-To: <20181119215841.0a3abd37@coco.lan>
References: <s5hbm6l5cdi.wl-tiwai@suse.de> <1837109.xExTbI5ikD@roadrunner.suse> <20181119215841.0a3abd37@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In data martedì 20 novembre 2018 00:58:41 CET, Mauro Carvalho Chehab ha 
scritto:
> Em Tue, 20 Nov 2018 00:19:54 +0100
> 
> stakanov <stakanov@eclipso.eu> escreveu:
> > In data martedì 20 novembre 2018 00:08:45 CET, Mauro Carvalho Chehab ha
> > 
> > scritto:
> > >  uname -a
> > >  
> > > > Linux silversurfer 4.20.0-rc3-1.g7e16618-default #1 SMP PREEMPT Mon
> > > > Nov 19
> > > > 18:54:15 UTC 2018 (7e16618) x86_64 x86_64 x86_64 GNU/Linux
> >  
> >  uname -a
> >  
> > > Linux silversurfer 4.20.0-rc3-1.g7e16618-default #1 SMP PREEMPT Mon Nov
> > > 19
> > > 18:54:15 UTC 2018 (7e16618) x86_64 x86_64 x86_64 GNU/Linux
> > 
> > from https://download.opensuse.org/repositories/home:/tiwai:/bsc1116374/
> > standard/x86_64/
> > 
> > So I booted this one, should be the right one.
> > sudo dmesg | grep -i b2c2   should give these additional messages?
> > 
> > If Takashi is still around, he could confirm.
> 
> Well, if the patch got applied, you should  now be getting messages similar
> (but not identical) to:
> 
> 	dvb_frontend_get_frequency_limits: frequencies: tuner: 9150000...2150000,
> frontend: 9150000...2150000 dvb_pll_attach: delsys: 5, frequency range:
> 9150000..2150000
> 
> > _________________________________________________________________
> > ________________________________________________________
> > Ihre E-Mail-Postfächer sicher & zentral an einem Ort. Jetzt wechseln und
> > alte E-Mail-Adresse mitnehmen! https://www.eclipso.de
> Thanks,
> Mauro


My bad. 
With just dmesg:

[   89.399887] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[   95.020149] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[   95.152049] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[   95.152058] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0 
frequency 1880000 out of range (950000..2150)
[   98.356539] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[   98.480372] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[   98.480381] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0 
frequency 1587500 out of range (950000..2150)
[  100.016823] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[  100.140619] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[  100.140629] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0 
frequency 1353500 out of range (950000..2150)
[  105.361166] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[  105.492972] dvb_frontend_get_frequency_limits: frequencies: tuner: 
950000...2150000, frontend: 950000000...2150000000
[  105.492977] b2c2_flexcop_pci 0000:06:06.0: DVB: adapter 0 frontend 0 
frequency 1944750 out of range (950000..2150)


Which is, I guess the info you need?



_________________________________________________________________
________________________________________________________
Ihre E-Mail-Postfächer sicher & zentral an einem Ort. Jetzt wechseln und alte E-Mail-Adresse mitnehmen! https://www.eclipso.de


