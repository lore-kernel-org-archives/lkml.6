Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA87DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A982208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Ic1K0E0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A982208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756852AbeFPPip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:38:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:34593 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754234AbeFPPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1529163519;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wrzhjqYZllJxiXXN/2w5PSi4xIcYKyqqGk7kpWRY+XI=;
        b=Ic1K0E0L9V8M7ReLZGNX9Zflh2esE/qdafyrRstbexC+dsp9Npap/TO3+A3a8gAzlm
        eI2Qen1FwsPAjx8aiMOEKXbaUj4EPLuAqu7bBRhvk0zMs922VPmfhx1q1HcHyX3UWB3q
        ECt4n/ghegBy7tWVdHGB70xdH/fE3izeYg/sHSD4Bnbm3NoppIA3xHM2y1w25HRcnMoD
        rBSl0M3HnxkueLSIsvSckNVkHiepzN2K3ulP+2aB3mhMwpcTON5GrISmw2VYgJascZjc
        XhtLmUHdsu/Pt6l+Q8Zu6yZNEIpD3areUY6sF/f610nzX0rpDLWnlWMowvdoOkuU5ryZ
        ccTA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WiuclqEj/wBQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id D025bfu5GFbx89s
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 16 Jun 2018 17:37:59 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 3/6] DTS: gta04: add uart2 child node for w2sg0004 GPS receiver
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180614194428.GA17808@amd>
Date:   Sat, 16 Jun 2018 17:37:59 +0200
Cc:     Johan Hovold <johan@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <23B66F6C-83A1-4666-A4E1-D127C6E3446B@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com> <9ebb28aed589aca8e9b5bc5c910f1d2f0d62669d.1525340143.git.hns@goldelico.com> <20180614194428.GA17808@amd>
To:     Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> Am 14.06.2018 um 21:44 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> On Thu 2018-05-03 11:35:48, H. Nikolaus Schaller wrote:
>> GTA04 has a W2SG0004 module connected to UART2 of the OMAP3
>> processor. A GPIO can pulse the on/off toggle switch.
>>=20
>> Note that there is no WAKEUP output from the W2SG0004,
>> hence we can't use the generic SirfStar binding.
>>=20
>> The VSIM regulator is used to power on/off the LNA of an
>> external active GPS antenna so that a driver can turn the
>> LNA off if GPS is not needed to save battery energy.
>=20
> This reads as if you did low->high->low to turn GPS on, then
> low->high->low to turn GPS off again. Is that correct?

Yes, it controls a toggle switch inside the gps module.

Data sheet (page 5, table 1):

	=
http://download.goldelico.com/gta04-hardware/Datasheets/W2SG0004_Datasheet=
_Rev1.81.pdf

Well, it says it wants a "Low going pulse (two RTC ticks), for power =
save".
So this indicates "high->low->high" and the chip responds on an =
unspecified edge.

If I speculate about the logic behind this, I think there was the =
concept of a
push-button at the navigator's console of a vessel (button is connected =
through
a single long wire and grounded at the console) to turn the receiver on =
or off.

Now the question is which edge turns it on or of. Pushing or releasing =
the button?
high->low or low->high? There is no hint in the data sheet.

If we assume it has not been changed in the w2sg0084i, we can look at =
page 9, figure 3

	=
https://www.mouser.com/ds/2/437/W2SG0084i_Datasheet_Rev1%2061-1114.pdf

to find that a rising edge changes the power state.

Experiments with manually controlling the w2sg0004 through =
/sys/class/gpio have
confirmed that that the rising edge is relevant.

Now on power-on there seems to be a special rule. If the on/off line is
permanently grounded (i.e. low), the module will turn on automatically =
at
power-on. So there is no need for any edge.

But since we don't want the module to be turned on at power-on (while =
U-Boot
is running) we have code there to initialize the gpio line to high.

Unfortunately you have not cited the code of the patch, so let me add it =
back:

> +		/* GPIO_145: trigger for on/off-impulse for w2sg0004 */
> +		enable-gpios =3D <&gpio5 17 GPIO_ACTIVE_HIGH>;

So there it is described as GPIO_ACTIVE_HIGH.

This might seem to contradict the data sheet which talks about a low =
going pulse,
but better reflects the active low->high edge.

I hope this answers your question completely.

BR and thanks,
Nikolaus


