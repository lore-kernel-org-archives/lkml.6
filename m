Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D045AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FAD2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfC8vaIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FAD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeGRVfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:35:42 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38163 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeGRVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:35:41 -0400
Received: by mail-qk0-f196.google.com with SMTP id 126-v6so1535239qke.5;
        Wed, 18 Jul 2018 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ik3/lfGnAk+Q47RyrEVdoD84t0WmGxzBjEMSD0QQbhw=;
        b=bfC8vaIW83HSMy8gjVJ7qYHqevVHAMyqpeN7wrSY0GVvpVZWdKXEs7DHAOwrvuuk19
         zNv3gVsT1H9RhY0y3ODiDt2aWVgWyGlL+EPP4IxylhMZA/+2Oi/NmdWek7e0SwFEveiL
         fE+rTosauDy4YTWAAoCGVmLoD5MPBJaVlQURDD4EsNTSCJO9wdVp7fOYSlit5a4bZYUv
         kajzfClYoI3vFYTrU9FIzdPOPQmHzd4QxYU5OyQ4CBe0Eup7a+5Vt/NOGXt8oviinhL2
         kfgNJuoNr+X9rCBVpqUjV9AHnac3KSkC9zZjNJvRDY8YMqlV7VHdwiL3RewAfUo2XiZg
         UrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ik3/lfGnAk+Q47RyrEVdoD84t0WmGxzBjEMSD0QQbhw=;
        b=gMKtXjOtmNst8qw5bBvENoc+J6SQXBRnLNXH0mtzgvZU8f8PmMUwedJhpzaWYMkP9F
         eqKuBIQqJhPrWw13DbHHLji+AoZdFXJTOL9s60DJGl8xaFu6i5CQls18fOIOdj18YAGg
         FcsWxenQ8eaKrh7PEMT0NZvn34Z/rSTvuDbLQyQcL9ss3A6yvdT2oCyVJ2+4DD4Mme0R
         IugRvImTOePzppsvb5wBjPgllSyvTfvMUki66P8Wl4B3cIxO3ypoy/vLANbEAblSlrqJ
         zy8v62jqqhIEmss+3zeuHSLLk9G99yfF+HqLN+q8EI95Bb24MAM7rkpVDxyqclWVrXyB
         KULw==
X-Gm-Message-State: AOUpUlHPt6HA077eAFnvcvxpTm1D16s++Xl07G0FC1NuIuHvzjgBIMbN
        rzkCLeX0l98eDegCA3rV9bMJM1n8k5wY7ZpuVcYbdw==
X-Google-Smtp-Source: AAOMgpcjEN7G+TuOLbiib7seq5PUiYbdfjIvbjzOygCmV/MO3SrX9kKVwzpfm3gDwRdO5CcrKZ7As0l4Opo+tYav3K0=
X-Received: by 2002:a37:c40d:: with SMTP id d13-v6mr6708808qki.190.1531947362050;
 Wed, 18 Jul 2018 13:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
 <20180713161841.11202-4-gregory.clement@bootlin.com> <20180713191720.GA17271@n2100.armlinux.org.uk>
 <87tvow8sho.fsf@bootlin.com>
In-Reply-To: <87tvow8sho.fsf@bootlin.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Wed, 18 Jul 2018 13:55:50 -0700
Message-ID: <CAA93jw4ygBN9dLVL_rRr23+ZEFabEHiHBpDExQLj9V4E2LtekA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/7] net: mvneta: increase number of buffers
 in RX and TX queue
To:     gregory.clement@bootlin.com
Cc:     linux@armlinux.org.uk, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        andrew@lunn.ch, jason@lakedaemon.net, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, nadavh@marvell.com,
        yelena@marvell.com, thomas.petazzoni@bootlin.com,
        miquel.raynal@bootlin.com, Marcin Wojtas <mw@semihalf.com>,
        dima@marvell.com, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 8:39 AM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Hi Russell King,
>
>  On ven., juil. 13 2018, Russell King - ARM Linux <linux@armlinux.org.uk>=
 wrote:
>
> > On Fri, Jul 13, 2018 at 06:18:37PM +0200, Gregory CLEMENT wrote:
> >> From: Yelena Krivosheev <yelena@marvell.com>
> >>
> >> The initial values were too small leading to poor performance when usi=
ng
> >> the software buffer management.
> >
> > What does this do to latency when a large transfer is also ongoing
> > (iow, the classic bufferbloat issue) ?
>
> IXIA latency test had been done without seeing any differences for long
> traffic (routing).

IXIA's tests in the latency under load area are pure rubbish. try
irtt, netperf, + flent (which wraps those)

https://github.com/heistp/irtt - with good one way delay measurements,
has been coming along nicely of late.

> These new values offer better performance for the main usage of this SoC
> (NAS applications), however both Rx and TX queues size can be change by
> ethtool.

BQL was added to this driver as of commit
a29b6235560a1ed10c8e1a73bfc616a66b802b90, with typical latencies below
2ms range. Is that not still the case? at a gbit, 1500 byte packets,
non-gso, that's a ring buffer size of ~155. So I can imagine that your
proposed larger ring buffer size for smaller packets might help, (was
your test using smaller packets?) and the usage of BQL should obscure
any change of latency seen by increasing the limit.

(in other words, assuming bql is working, go right ahead, increase tx
descriptors)

bqlmon can be used to monitor the state of bql.

as for rx, are you seeing drops under load due to overflowing it? When
I last looked at this
driver (in the pre-bql era), it did a lot of bulky processing in rx.

>
> Gregory
>
> >
> >>
> >> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
> >> [gregory: extract from a larger patch]
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> ---
> >>  drivers/net/ethernet/marvell/mvneta.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ether=
net/marvell/mvneta.c
> >> index f4e3943a745d..c22df28b07c8 100644
> >> --- a/drivers/net/ethernet/marvell/mvneta.c
> >> +++ b/drivers/net/ethernet/marvell/mvneta.c
> >> @@ -295,10 +295,10 @@
> >>  #define MVNETA_RSS_LU_TABLE_SIZE    1
> >>
> >>  /* Max number of Rx descriptors */
> >> -#define MVNETA_MAX_RXD 128
> >> +#define MVNETA_MAX_RXD 512
> >>
> >>  /* Max number of Tx descriptors */
> >> -#define MVNETA_MAX_TXD 532
> >> +#define MVNETA_MAX_TXD 1024
> >>
> >>  /* Max number of allowed TCP segments for software TSO */
> >>  #define MVNETA_MAX_TSO_SEGS 100
> >> --
> >> 2.18.0
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> > --
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630k=
bps up
> > According to speedtest.net: 13Mbps down 490kbps up
>
> --
> Gregory Clement, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com



--=20

Dave T=C3=A4ht
CEO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-669-226-2619
