Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA55C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B9023E44
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDZfDtVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B9023E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeGFN4S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:56:18 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36103 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933467AbeGFN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:56:10 -0400
Received: by mail-io0-f196.google.com with SMTP id k3-v6so10927538iog.3;
        Fri, 06 Jul 2018 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=299tzB+yU7udKPdjIrgoz13qPZlrizs1rwt+oxX5M6o=;
        b=kDZfDtVUsBQL0zpcWGOJRw/ZmKJVL0fDeAOUvreJqtFr2wC2rimpJeVShbu+wvcjh0
         3jBnZYg9Rs3w/nz6+UW2jLLwqEqwYOFSL5RfuhSJ5Wb8uWPYpI9SdjgoWhtQ6TexZeHd
         EpCml2+E170Wa9fBr/MgoZhNFus2x0rRB/7Bgzu6FEo+mLziAdwZeo7Y0zFkEGkFuu8W
         ODV7ewQZ9oOjl787ZI5a1736u7IG7G9zAiCnIHr8DcWG8CMcXNzC7dO4NChlAWAdulEX
         aRuGx21Kzt8w7/w8zbf7Y41fY/Rd2VKGSDxGGbxAXoGWcoEI8GDryNUnoIQYfNbbam5k
         rbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=299tzB+yU7udKPdjIrgoz13qPZlrizs1rwt+oxX5M6o=;
        b=kerVr9EzPLF4CAXEexN156cUcHMJjrwHYwYf0M2ZoPS7EOgTfwqYhkFSnC6DQZt9ba
         Q3V9nrn9rxfl8FVluXf/l+ilIv5hOdbUfKMcxXLltk/PdsEHMwiCrMaRJv68AXTuKCwd
         b2r6GgOYXWMMyIYBC8MNwo3yRu/wA0MWad0n6HTbsLuNXZTb1aXO+6HdPBRiTD/kAd1U
         aGv6hLuLaVsQTUCO2LUiOeUMeEVspvqmFFZY2hy7rCvrGhe56joc37ZTmhPcmM64yEcd
         1O16X7LfSrN2YgSz9Aj6jUg+Ac7yTG/RkcB/kR+ZPQ4rpfiqGMGaiFYJv6KS0b6M8wVR
         /VVQ==
X-Gm-Message-State: APt69E1JErD8odAasd7XL1zTY1v1JyDSfVA81/ZnCzVPKMLrojLo6ML4
        AAsjqUy36tmp47R743OYzs948VwDTgOpsQ1mXQ==
X-Google-Smtp-Source: AAOMgpd1qBzaE/N4nEvagWZigaiZOxplyNtmIOfrLLaD7MNYudY+ufWgmHspnibruLTssY52STqIixx90Fq0vjIISjI=
X-Received: by 2002:a6b:980e:: with SMTP id a14-v6mr8893076ioe.238.1530885369650;
 Fri, 06 Jul 2018 06:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan> <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
 <20180706083603.GA9063@wunner.de> <CAJZ5v0j6+m8NGMneG45tF9L1s6ahtFo91wPCO=3YOTEyAOL+VQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j6+m8NGMneG45tF9L1s6ahtFo91wPCO=3YOTEyAOL+VQ@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 6 Jul 2018 21:55:57 +0800
Message-ID: <CAFgQCTugu5XO06_xXb4ihkdfGJxtFX0813g2J-Jk2JeYtPP1vA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     rafael@kernel.org
Cc:     lukas@wunner.de, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org,
        kishon@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 4:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jul 6, 2018 at 10:36 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > [cc += Kishon Vijay Abraham]
> >
> > On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
> >> OK, so calling devices_kset_move_last() from really_probe() clearly is
> >> a mistake.
> >>
> >> I'm not really sure what the intention of it was as the changelog of
> >> commit 52cdbdd49853d doesn't really explain that (why would it be
> >> insufficient without that change?)
> >
> > It seems 52cdbdd49853d fixed an issue with boards which have an MMC
> > whose reset pin needs to be driven high on shutdown, lest the MMC
> > won't be found on the next boot.
> >
> > The boards' devicetrees use a kludge wherein the reset pin is modelled
> > as a regulator.  The regulator is enabled when the MMC probes and
> > disabled on driver unbind and shutdown.  As a result, the pin is driven
> > low on shutdown and the MMC is not found on the next boot.
> >
> > To fix this, another kludge was invented wherein the GPIO expander
> > driving the reset pin unconditionally drives all its pins high on
> > shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
> > (commit adc284755055, "gpio: pcf857x: restore the initial line state
> > of all pcf lines").
> >
> > For this kludge to work, the GPIO expander's ->shutdown hook needs to
> > be executed after the MMC expander's ->shutdown hook.
> >
> > Commit 52cdbdd49853d achieved that by reordering devices_kset according
> > to the probe order.  Apparently the MMC probes after the GPIO expander,
> > possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
> > available yet, see mmc_regulator_get_supply().
> >
> > Note, I'm just piecing the information together from git history,
> > I'm not responsible for these kludges.  (I'm innocent!)
>
> Sure enough. :-)
>
> In any case, calling devices_kset_move_last() in really_probe() is
> plain broken and if its only purpose was to address a single, arguably
> kludgy, use case, let's just get rid of it in the first place IMO.
>
Yes, if it is only used for a single use case.

> > @Pingfan Liu, if you just remove the call to devices_kset_move_last()
> > from really_probe(), does the issue go away?
>
> I would think so from the description of the problem (elsewhere in this thread).
>
Yes.

Thanks,
Pingfan
