Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984ECC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2DC20818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ajadffEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2DC20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437993AbeKWCfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:35:46 -0500
Received: from casper.infradead.org ([85.118.1.10]:57840 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbeKWCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h4fTHgYL8K116RKWnCjpuHXl+2VUkLoWZ9Flz8Fi0Gc=; b=ajadffEu3LG0VDI5agUff7ocfS
        8XG8yyVVBCRN95gL+F3rQfxtoPEV+SnOHsg0pCuDLddHJ951SYrDT9Jji/XE0VDxklVFz/DYEiWuU
        RZFXfPG2T/B3S5EwsFGeDdHosUWjwJ/4ooiI0X9UDEPACYZ5oM6jahb7jCyDDHMaj4EKvJEWz8HBT
        B/i0OZAwZLQzPzmG0xEjRJfoz/N3tb0zquALBb67/zSnZsBqFLDqmf1Er3rNiF893Va7EIpx7a7wS
        hzdwC9RsVWqfyGO/b3LqvjDDx0WkLAgQa/P1greh13Aie3n/gkQGd2jvmxM9RHWV/TmhW8cPclnFG
        3KYQ/93A==;
Received: from 201.47.163.210.dynamic.adsl.gvt.net.br ([201.47.163.210] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPrKT-00058k-HE; Thu, 22 Nov 2018 15:55:45 +0000
Date:   Thu, 22 Nov 2018 13:55:39 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     stakanov <stakanov@eclipso.eu>, Takashi Iwai <tiwai@suse.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Message-ID: <20181122135539.158b3985@coco.lan>
In-Reply-To: <96849b97-3abb-b879-ed05-35bcd58b5e43@gmail.com>
References: <4e0356d6303c128a3e6d0bcc453ba1be@mail.eclipso.de>
        <20181120104217.5b487bcd@coco.lan>
        <1593929.t9Y74Rdlh1@roadrunner.suse>
        <20181120140855.29f5dc3f@coco.lan>
        <96849b97-3abb-b879-ed05-35bcd58b5e43@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 21 Nov 2018 21:20:35 +0000
Malcolm Priestley <tvboxspy@gmail.com> escreveu:

> On 20/11/2018 16:08, Mauro Carvalho Chehab wrote:
> > Em Tue, 20 Nov 2018 14:20:01 +0100  
> <snip>
> 
> > Ok. Now, min/max frequencies are at the same scale. For DVB-S, 
> > dvb_frontend_get_frequency_limits() returns both in kHz, so the frequency
> > range is now OK.
> > 
> > The tuning frequency is wrong through. 10,719,000 kHz - e. g. 10,719 MHz
> > seems to be the transponder frequency you're trying to tune, and not the
> > intermediate frequency used at the DVB-S board.
> > 
> > That sounds to me either a wrong LNBf setting or a bug at libdvbv5 or
> > at Kaffeine's side. What happens is that the typical European LNBFs are:
> > 
> > 1) the "old" universal one:
> > 
> > UNIVERSAL
> > 	Universal, Europe
> > 	Freqs     : 10800 to 11800 MHz, LO: 9750 MHz
> > 	Freqs     : 11600 to 12700 MHz, LO: 10600 MHz  
> I am pretty certain this type is obsolete it doesn't look right for 9750Mhz oscillator.
> 
> I am sure it was 10000Mhz or 96?? or something like that for old analogue transmissions of 
> 20 years ago

This is the first LNBf entry at dvb-tools. I'm pretty sure people
used it for years, but yeah, I won't doubt that this is an obsolete
entry.

Yet, people may still be using old antennas somewhere, so we can't
simply remove it or replace.

Maybe we could change its description to say that this is the
old universal standard.

> > 
> > 2) the "new" universal one, with seems to be used by most modern
> > satellite dishes in Europe nowadays:
> > 
> > EXTENDED
> > 	Astra 1E, European Universal Ku (extended)  
> This needs renaming as 1E has long gone.

Agreed.

> 
> Certainly this type is used for Astra 19.2 and 28.2.
> 
> Ideally we should use a default LNB type for each Satellite either in libdvbv5, Kaffeine or respective tables.

Neither libdvbv5 nor Kaffeine has a concept of "default". The default
varies from the region of the globe where you're sitting, and the
actual satellite to where an antenna system is pointed. Also, it
changes over time.

Thanks,
Mauro
