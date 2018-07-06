Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434DF24075
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHSL32jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434DF24075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeGFIrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:47:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41193 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeGFIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:47:33 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so22058160oiw.8;
        Fri, 06 Jul 2018 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CPQ96/UJ6fepOM7uRZ0M/QRvTPu/AeBjaqDfFJAxpog=;
        b=EHSL32jwOHsxkIgy0PD1pYlEhu6aQgIlX50K5hnZgWQRa7Dxvhz3ndOP9AWoLMUXDS
         +LJWaDo5vr11ZNguohY48mwEFmimYLMxjcYcJWuH1SfpecAxqs+bo2+K02HKVHF7g0tq
         9JmimHxweWCndPcs+04dm48rEuQzDFmvks6ZkL2YgXrDd+lWE43GlL2KGtL66b+XnqWR
         dtKlRjMArzB0fSBGRWdDFA5KEcxBEEmTNelylAqPrQTjh9NGa1wXm1yreMYXmuTISWE/
         T1iXXIu67fPyjXpZ6i7R/oEtywQFdmSDdzdlgJqXxKFawT+A3TpJk5U5FE3to+DOZy0s
         7hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CPQ96/UJ6fepOM7uRZ0M/QRvTPu/AeBjaqDfFJAxpog=;
        b=j9fziZSd1QzErZjWkzQ3tXOHRtkBdLNxO2V4r/rX71XnYwgGypQdUxlf5xBbZ+Pqoe
         uXV7PhGkclaT4jBhsgh49PGer4pugG3/DYCVoAGPxbWnw1Mnk9gtgDirJX7V/0/d2ecA
         KVrUhOoRdfadrnmefIkpPB+G8ljYOzq1+ROYikslNzBKUa1dkfwz1qyFIidIY/B3osBN
         ebXVlpiCO7xxLRLWBikh/bHRnRE4ZOOW3giLa3kD2kB5o5UQ5183McJg3KXKiy4Wv8m9
         mQ59btFT1cee55NfaoN78sUqClV9SSXyGUxAp1DJF1H0GU9WAa47mOewuW3F9IHSt5/F
         K/LQ==
X-Gm-Message-State: APt69E0CdqjSaKHj1tbF3Pw0LfHCZsqh4pW6mUqKBbClLOGWotlV8AZx
        XuDLCukP4RqyvZyBgmAscH71+Uq6jP3EZEJqWsw=
X-Google-Smtp-Source: AAOMgpeub/7txXBjkY8TraoZeMEolj1MLjwbf9GhcgY1KD1Vj0UqYUkLP1U++/3ounKmbAmrlCwVTvIe9xnIi0v9nNo=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr9547253oia.154.1530866853028;
 Fri, 06 Jul 2018 01:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 01:47:32 -0700 (PDT)
In-Reply-To: <20180706083603.GA9063@wunner.de>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan> <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com> <20180706083603.GA9063@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Jul 2018 10:47:32 +0200
X-Google-Sender-Auth: 7qsTURJhRZHSHKhmTDf2YL4NsOI
Message-ID: <CAJZ5v0j6+m8NGMneG45tF9L1s6ahtFo91wPCO=3YOTEyAOL+VQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 10:36 AM, Lukas Wunner <lukas@wunner.de> wrote:
> [cc += Kishon Vijay Abraham]
>
> On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
>> OK, so calling devices_kset_move_last() from really_probe() clearly is
>> a mistake.
>>
>> I'm not really sure what the intention of it was as the changelog of
>> commit 52cdbdd49853d doesn't really explain that (why would it be
>> insufficient without that change?)
>
> It seems 52cdbdd49853d fixed an issue with boards which have an MMC
> whose reset pin needs to be driven high on shutdown, lest the MMC
> won't be found on the next boot.
>
> The boards' devicetrees use a kludge wherein the reset pin is modelled
> as a regulator.  The regulator is enabled when the MMC probes and
> disabled on driver unbind and shutdown.  As a result, the pin is driven
> low on shutdown and the MMC is not found on the next boot.
>
> To fix this, another kludge was invented wherein the GPIO expander
> driving the reset pin unconditionally drives all its pins high on
> shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
> (commit adc284755055, "gpio: pcf857x: restore the initial line state
> of all pcf lines").
>
> For this kludge to work, the GPIO expander's ->shutdown hook needs to
> be executed after the MMC expander's ->shutdown hook.
>
> Commit 52cdbdd49853d achieved that by reordering devices_kset according
> to the probe order.  Apparently the MMC probes after the GPIO expander,
> possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
> available yet, see mmc_regulator_get_supply().
>
> Note, I'm just piecing the information together from git history,
> I'm not responsible for these kludges.  (I'm innocent!)

Sure enough. :-)

In any case, calling devices_kset_move_last() in really_probe() is
plain broken and if its only purpose was to address a single, arguably
kludgy, use case, let's just get rid of it in the first place IMO.

> @Pingfan Liu, if you just remove the call to devices_kset_move_last()
> from really_probe(), does the issue go away?

I would think so from the description of the problem (elsewhere in this thread).

Thanks,
Rafael
