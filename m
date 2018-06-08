Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 643lGKEoGlv4DQAAmS7hNA
	; Fri, 08 Jun 2018 06:56:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 360F6608C1; Fri,  8 Jun 2018 06:56:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="erCNidrB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D04F1607A4;
	Fri,  8 Jun 2018 06:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D04F1607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeFHG43 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:56:29 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:45956 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeFHG40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:56:26 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 412Cqr2Pmgz1XLFtc;
        Fri,  8 Jun 2018 08:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528440984;
        bh=HnZtfI+qlgCSIQOhj933rBXAAAD5wsI2lT39+BftndQ=; l=10;
        h=From:From:Reply-To:Sender;
        b=erCNidrBAVXokjyoPKyguqWYuAi8zmPZXuaVBvgbbL7jXi28N6tgWi4ZZPMohRh6b
         p8uQHxS/XkkAhyg185B1KMX+DH2EAIvDUBQa/Kpfit3AiV+LFXuORvhsPYi4x50jhF
         q7wYCbNS827TGQwo8SQwKAalZJQ1QbC5JzMgJdiA=
Received: from si0vm2083.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 412Cqr1zv3z1C6;
        Fri,  8 Jun 2018 08:56:24 +0200 (CEST)
X-AuditID: 0a3aad17-4fbff70000000e32-25-5b1a28990e34
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2083.rbesz01.com (SMG Outbound) with SMTP id E9.0E.03634.9982A1B5; Fri,  8 Jun 2018 08:56:25 +0200 (CEST)
Received: from FE-MBX2050.de.bosch.com (fe-mbx2050.de.bosch.com [10.3.231.60])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 412Cqq6ZlLzFNF3;
        Fri,  8 Jun 2018 08:56:23 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2050.de.bosch.com (10.3.231.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Fri, 8 Jun 2018 08:56:23 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Fri, 8 Jun 2018 08:56:23 +0200
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH 2/5] spi: implement companion-spi driver
Thread-Topic: [PATCH 2/5] spi: implement companion-spi driver
Thread-Index: AdP+9c7tVJL9o477ekeg9qEV2hoM0A==
Date: Fri, 8 Jun 2018 06:56:23 +0000
Message-ID: <bb9540ed90e944c7a8e27287e6df25d5@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf1CTdRzH+e55Np5tPPPZg7APIyyeNLoInJq2RDuv7nKdneWPy5S6emhP
        sGsM7nkGB5x3weWvmxxxJOgmknkyaaUw5Gwoga4uiermKRYgUndNmiiEqTEWcm0+4PZH/30+
        78/n9fn1vS+B0S5CS5gsVo63sGZGpsAVq0+mZdmf1ubqbCeW6G/Wfov0nuHfML1rqh7TXznb
        KNO3HjuA678/mqz3jyB980indB1haHL04oZOx/V4w53L15Dhkwc6w932RW9IdyjWGDmzqZTj
        l774nqKgbeBMfPERTdlfVVfxSnSMtiGCAOo5aJ3JsSEFQVOHJGA7+S8uOl0IfHcHZKJzG4Ht
        mw5MdHoQXApVSW1ITsio1bDX+WN8xF5IPQtVHa0PdYxyYjBwLTNiJ1Jr4NzstFTMWQv2j2vm
        7Gy42OvCI2Pg1GJoqVkakUkqB0Z390siNqLSoK3Nh4klNdA+OvUQBYqC412iDlQS3PxjVipu
        kw6Nh14S07NhoP6ATLQzwfn5LUwsr4Yf7H68FiU5Yqo6YhBHDOKIQY4i3IWSBJOutHC5Tr8i
        m8/jhArdsuz3iwrbkfh4Gg+652a9iCIQk0B2LdHm0lK2VCgv9KKVhIRJInt9Kbm0Kq/IWF7A
        CgXv8iVmTmC0JIqLi6MTH8lCSV6hSRBMRRYvAgJjFpKjTLgUaWTLKzi+SMS8KJXAGQ1Zbdy5
        g6byWSv3IccVc/x8NIcgGCC3ZYRBNc/lc2UfmMzW+TCTJvZMjo3EtpUQci9aQSSEe++OrEEK
        xWyhYMqfw1NEnJ5Xo2gfepm4vae6GqNxS5GF02pIaWQEKpJZUGJ5NIH2MTLjAuTSSTGBaJUx
        NIjCN0wkDRE4IfxHor2B9CQ2bqfVc2IUWt4cZqgGFfQMXkHwxdUJCbTOjmMwHNwlhXP/2OIh
        uKuagMCITw6ehj0K6On8WgHu5m4lHLePK6Hry6ASAvecJPQcrlPB/a9+VoFnekYFIXv9AvCe
        36cGz8GLaviptpKG4cGhZHCfmdRA0+wtgMDk+RSYGHKmwmDT6VRoabCngTv43SKonTidDvf3
        ORnw+C8z0DKz/8mx8GEl4cMasJTIYa2s9X8OO6dGt9NWojfXj/1quvS2eaPrhcnm5AB7du/6
        QMmWrPQTf/tr/HUZHeP5pq2nNmRuZPuHjMrNhysu9L9aZjj11A35K7z/4OMP+l6TD2/fuemJ
        0enrzZ91rnzr+b7gL92hteZtSj7L41MWb7iTt//TPxn3qk2TXGiqu+73wKqtNybWhTa/Lvto
        8diWhncYXChglz2D8QL7H8E1zEK9BAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

> > > > +               if (slave_is_not_busy(priv))
> > > > +                       return 0;
> > > > +
> > >
> > > > +               udelay(READY_POLL_US_GRAN);
> > >
> > > Should it be atomic?
> > > Can it use read_poll_* type of helpers instead?
> >
> > Yes, it shall be atomic because we need to reduce the latency at
> > detecting the de-assertion of the busy signal. We accept that this will
> > cost CPU time.
> >
> > In case the Companion itself is very busy and does not reply quickly we
> > are have second polling loop below which sleeps longer and is non-atomi=
c.
>=20
> I can confirm, this make huge impact on protocol performance. And this
> protocol is not really the speed runner.

The challenge is that the protocol is synchronous and without back to
back transfers.

> you can send dummy message to set CS.
> +	struct spi_transfer t =3D {
> +		.len =3D 0,
> +		.cs_change =3D 1,
> +	};
>=20
> +	/* send dummy to trigger CS */
> +	reinit_completion(&priv->fc_complete);
> +	spi_sync_locked(spi, &m);
>=20
> see my ancient unfinished code:
> https://patchwork.kernel.org/patch/9418511/

We will check it out.

> In general, this part of the code, can be provided as separate driver
> which should be called as "SPI 5wire protocol". 3 wires for data, 1 -
> chip select, 1 - busy state. Since, the slave cant fit to normal SPI
> requirements, and can't be ready within predictable time, busy signal is
> needed. Providing this as separate driver or part of SPI framework
> should reduce the code for many different drivers.
>=20
> The actual datagram on top of your spi companion should go to
> separate driver. There are similar (almost identical designs)
>=20
> can :+
> char:+
> dw:  +
> gpio:+--->some_multi_end_mux_protocol--->spi_5wire_protocol->spi--->
>=20
> In my knowledge, only data format on top of spi_5wire_protocol is
> different. See my notes for similar topics:
> https://github.com/olerem/icc
> https://github.com/olerem/spi-5wire

With 5-wire protocol you are referencing to CLK, MISO, MOSI, CS (all
standard SPI signals) and an extra BUSY signal. What we implemented is
a 6-wire protocol. There is an additional REQUEST line where the SPI
slave requests a transfer. It is like a level triggered interrupt
request.

Yes, for making it more generic the code in drivers/spi/companion
could be split into a generic 6-wire protocol driver and a multiplexing
protocol on top of it.

How does a slave signal that it has data to be picked up with the
5-wire protocol?

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
