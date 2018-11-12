Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1522504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rlpfjsOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF1522504
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbeKMHtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:49:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37071 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:49:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so9434888oth.4;
        Mon, 12 Nov 2018 13:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUp9sMm8qe9GvTkEAUlTx+4hmy4MKaA1kKnzNemFxkw=;
        b=rlpfjsOHRz1iUF7hVGW0mWaOWPKkUqcVy91HYDxymw6SI5edpWxZt2N3A0D0uUOEga
         pG3BV4souHBOFTZaU1ERKdaNhYvGGrtG5Fh9A7nKwOPVgfbI/6C2xYTzDsGjyFxeUsko
         dbc0Gd4ldKOihpgzQgktcRjvOnoZqLEUvVTci/ySIMMsQhiWCufuh5a1VIbbpBBN/d3B
         Y7jsirpYskf0CsCpLJ8ZPLxWtQvZ+1UaH5vVGPJd0L3vXjtBvMKBqCvNpEMMEPLAc91q
         e3U8QlCVQEgore79e74PVBBVQKX70B06kdkt+m7YgxXYdvb1BKuHV7c6tJbU98zf57OW
         TrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUp9sMm8qe9GvTkEAUlTx+4hmy4MKaA1kKnzNemFxkw=;
        b=K295pR9fVXJsKrn3Aa8Lt8K1bA1bGAfFgXPySgHJgNA1U92iaX6oLjsecth3m9bl9U
         xxkxjtQG1WwUmYpnvIpbKMsZmAGkiyr0Hc71BS79KRsm8krqFsK7l0e7mDo80FSBNKP2
         9iXnY180Oq5CDwh1rv7+Af41FcfCzZZrBr21l8feZ70+tJMBR2UVI8GarCOpCRZFN4pf
         s10CHGcUDjQiABkNprsrFoiQr6otMva9/r28nzeDVUw303zBZADe8uCHmkZAZSYhGsPR
         LUvMoRxngqkEvpR8yHRD2WshrG8opCXgMlG8asyvSnGI4SQWk03G/825jDilTIz2Saa+
         wS5g==
X-Gm-Message-State: AGRZ1gKoazjewWDzb43OEQxguQNwYDrgpXrZyyS93MSUvZ1e9YB6ZUsQ
        ae0632bukof8VFkWeWLp+RWs7sS52DVWlY0Y0YU=
X-Google-Smtp-Source: AJdET5epauSt2qhuOSA08IW5TsARnvaX+wjjebpKUmzQzHBXP2PthPFYTiMRh+hvJRuUj7bjGjLeO0aLhC7/SPuO8l4=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr1643824otg.308.1542059636934;
 Mon, 12 Nov 2018 13:53:56 -0800 (PST)
MIME-Version: 1.0
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com> <20181109201307.GV5259@lunn.ch>
 <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com> <4330cb5b-b1a5-5004-af51-39199943639d@gmail.com>
 <c067d321-c69e-706d-304a-04e1e477b47c@gmail.com> <CAFBinCCmNYGp8kzy45ojjr27tEaPVs-QwMsLRrfXHCvw_taDOw@mail.gmail.com>
 <b6f0c1bb-9c0b-a02a-1571-b2804fcbcaa1@gmail.com>
In-Reply-To: <b6f0c1bb-9c0b-a02a-1571-b2804fcbcaa1@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 12 Nov 2018 22:53:45 +0100
Message-ID: <CAFBinCB3v3tWb5YEjeMe=gHK5Dsu-0ONzn4PEx0s4Y9zrrLA4g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
To:     hkallweit1@gmail.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
        richardcochran@gmail.com, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, khilman@baylibre.com,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 9:38 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 12.11.2018 21:32, Martin Blumenstingl wrote:
> > Hi Heiner,
> >
> > On Fri, Nov 9, 2018 at 9:56 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 09.11.2018 21:33, Florian Fainelli wrote:
> >>> On 11/9/18 12:22 PM, Heiner Kallweit wrote:
> >>>> On 09.11.2018 21:13, Andrew Lunn wrote:
> >>>>> Hi Heiner
> >>>>>
> >>>>>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
> >>>>>> +{
> >>>>>> +  return phydrv->config_intr || phydrv->ack_interrupt;
> >>>>>> +}
> >>>>>
> >>>>> Should this be && not || ? I thought both needed to be provided for
> >>>>> interrupts to work.
> >>>>>
> >>>>>        Andrew
> >>>>>
> >>>> I've seen at least one driver which configures interrupts in
> >>>> config_init and doesn't define a config_intr callback
> >>>> (ack_interrupt callback is there)
> >>>
> >>> That driver should probably be fixed, while it most likely does not make
> >>> any significant difference during probe/connect, since config_init() and
> >>> config_intr() are virtually happening at the same time, this is not
> >>> necessarily true when disconnecting from the PHY where we really want
> >>> config_intr() to effectively disable the interrupts and not leaving
> >>> something enabled that would now become unmaskable, because no more
> >>> driver attached.
> >>>
> >> Found the driver: It's the IP101A/G in icplus.c
> >> It should be easy to fix the behavior and move the interrupt config
> >> to a config_intr callback. But the last real changes to the driver
> >> have been done 6 years ago, so I'm not sure there's anybody out
> >> there who can test.
> > if you want I can take care of the IP101A/G code.
> > I have at least one board with an IP101A/G (PHY ID: 0x02430c54,
> > according to the schematics it's an IP101GR-GP) where the interrupt is
> > routed to the SoC.
> >
> > please let me know whether you'd like to work on it or if I should
> > give it a try.
> >
> I made the change already based on the datasheet of IP101A LF which
> is supposed to be register-compatible with IP101A/G.
> The patch is not applied yet, you can find it in the mailing
> list archive or in patchwork. Would be great if you could test it
> and report problems or add a Tested-by.
I will test it but I doubt it works out-of-the-box in my setup:
my board routes the RXER/INTR_32 pin of the IP101GR to the SoC. that
pin defaults to "RXER" (receive error signal). so I need to come up
with some extra patches which toggle the bit to output the interrupt
signal on that pin

in other words: I'll give your patches a try as soon as I have time
and give my Tested-by along with my extra patches on top of yours.


Regards
Martin
