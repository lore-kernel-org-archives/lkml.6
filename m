Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A519CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C7320684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="HI9IDbad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C7320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeKSSqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:46:08 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:11971 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeKSSqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1542615788;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=huXH0DDkgqtIeTuuaOplh0n/TRRLlriFthavvxVJDPk=;
        b=HI9IDbadar/LKo4skSLVn6Qkp7bPK7ooHI+hspJMqNPgDLJ4ssBDo0z88ECOTFgpxg
        oQ3tgvqRIANr3xc/ONqiQfAS8TqLnrT7/mEwXThqVlZQMbXB/lAGax+io49NYRgnCpJY
        A6p5nYjzwJljpbEYZOkHN/v0jG0AQHhxLr17+IW3NE2B7DlH016JSaZr0wjqI4LO56dM
        863JTr72df+6EnJW3ZDDeCXG68dEVUy+ttOABUrCbLsOYl3Ut+04It0TXd0h0NKNy97F
        bzatJK4VB1EH8mx43kh3fOc8bmKSmyOs75oU1MBbql2YVw68Fky1c18NhCPRi3nE1h8t
        dYOw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zowDCvpOU="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.4 DYNA|AUTH)
        with ESMTPSA id c01a4cuAJ8N0AiF
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 19 Nov 2018 09:23:00 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH 0/5] gnss: sirf: add support for w2sg0004 + lna
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20181118215801.12280-1-andreas@kemnade.info>
Date:   Mon, 19 Nov 2018 09:22:59 +0100
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3487514B-E546-4F11-8C0A-F5B4A8114376@goldelico.com>
References: <20181118215801.12280-1-andreas@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 18.11.2018 um 22:57 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Here is another chapter of the story to get gta04 gnss power
> management into the mainline kernel.
> There is a w2sg0004 without wakeup line in there, so power state
> can only be determined indirectly by looking at the serial data lines.
> Then there as also an lna which needs to be powered for real gps
> reception. That part needs probably more discussion, since it might
> be an idea to have it more generalized since it has nothing todo
> with the chip itself.

On the other hand if we follow the "SoC is the spider in the net"
way of looking at DTS hierarchy, we have the uart as a child of the
SoC and the gnss receiver as a serdev child of the UART. The LNA
is even one step more distantly connected to the gnss. So it makes
sense to me to have it as a property/reference of the gnss chip's
DTS record which is a sibling of the compatible records. So the only
place where it can be reasonably processed is the driver.

> I marked the corresponding patches as RFC. The support for
> the w2sg0004 without wakeup can imho go in without the lna first
> because users of that chip without an additional lna power supply
> can already benefit from it if we should do more discussion first.
> I just kept them together so that the full picture can be seen.
>=20
> Andreas Kemnade (5):
>  gnss: sirf: write data to gnss only when the gnss device is open
>  gnss: sirf: power on logic for devices without wakeup signal
>  dt-bindings: gnss: add w2sg0004 compatible string
>  gnss: sirf: add a separate supply for a lna
>  dt-bindings: gnss: add lna-supply property
>=20
> .../devicetree/bindings/gnss/sirfstar.txt          |   2 +
> drivers/gnss/sirf.c                                | 126 =
+++++++++++++++------
> 2 files changed, 96 insertions(+), 32 deletions(-)
>=20
> --=20
> 2.11.0
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel

BR,
Nikolaus

