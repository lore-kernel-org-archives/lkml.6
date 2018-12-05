Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B4AC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECB7214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3+4jDFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECB7214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeLEVYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:24:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41366 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeLEVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:24:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so15847457lfj.8;
        Wed, 05 Dec 2018 13:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wn43OcYXYkyPfhaEdm23GByIZBWJc64RXquDSTyxtKA=;
        b=G3+4jDFyYEwm/2d5a6DOnAAjdEysMkPQ0Ys0aH9Zf3qaWrGqzQIb5/T67qtC8wE8Iu
         JZHgdhscPSjSk4JdNd3XJRZflCTTu/Z4hbCRS0gvI+J++stpnbASE9WiDWJnjg3+9hNx
         rsmpUN+G8uXxW892KverkCA+FQfQbmPj8IT+o5ucwWH5nlE+RooN1c64DCQInI9OKiz3
         qQmA9nxPFv8amd1HEQ1KOBgj5Nx79+cDInJ/XptCYGKTMY9Nq00rDbijqCc6qgmsbTuC
         J9AVDAnd7YVPKISF8QoYXbNzLGkJjEVL6fgLfG5LScPqiOlYQFL1X3Z3ltj8641tlcoy
         /S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wn43OcYXYkyPfhaEdm23GByIZBWJc64RXquDSTyxtKA=;
        b=ce9EXhalfY8/zhZ9WOrySQaSXsApiMDPXo3f4Z6NnWPwibp+Ba1V/GH3kDZXKOfdDY
         Eb/icy6ePI79/d8mOVXEL0+QM05SmnE1DE65tD55c8eEeG/oOJj+0OPHZZcwb2HNAJmo
         MZSE99D6BMySQqizU1/tT8XUEXprN3tMO6BrT9yExbPzP4ko8E8QdTTxSG3mhFveCwzR
         6Lr/OP5bzoQnwcBUbtlpfJI0OyvnIGMEadgQJN8g3enL5+i9UNy8lYZw+KNQPK6KwPCJ
         9HaAvUdKg3+LBfzMzqgAPKR5Ap9refCT8v6A7xFTr6tW95Ue5ykGnlHsUdLorYivOT/g
         Ftkg==
X-Gm-Message-State: AA+aEWY4GU5Xm0YVVwgfcyBkDOroaSFDy9NN/y27p9M2Ee44KkBd/KE0
        Tq32WJ4wMSnayN+YZrBper4=
X-Google-Smtp-Source: AFSGD/X28R0+aAvaKPeAgFoQUlGpbTl/iN4r8ThW5YhJPtny1l0rB2idlNyiFzvarjwSrVPxrzfUyg==
X-Received: by 2002:a19:a086:: with SMTP id j128mr14503125lfe.93.1544045081297;
        Wed, 05 Dec 2018 13:24:41 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:41e8:260c:942a:b736])
        by smtp.gmail.com with ESMTPSA id p23sm3802765lfh.47.2018.12.05.13.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 13:24:40 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Handle specific unknown packets after firmware loading
Date:   Wed, 05 Dec 2018 22:24:39 +0100
Message-ID: <73529966.IuFOuslu9h@acerlaptop>
In-Reply-To: <BBB949C2-B1CB-478E-9BBF-E39FCA7271EF@holtmann.org>
References: <20181205194538.8074-1-pawel.mikolaj.chmiel@gmail.com> <BBB949C2-B1CB-478E-9BBF-E39FCA7271EF@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia =C5=9Broda, 5 grudnia 2018 22:02:30 CET Marcel Holtmann pisze:
> Hi Pawel,
>=20
> > The Broadcom controller on aries S5PV210 boards sends out a couple of
> > unknown packets after the firmware is loaded.  This will cause
> > logging of errors such as:
> > 	Bluetooth: hci0: Frame reassembly failed (-84)
> >=20
> > This is probably also the case with other boards, as there are related
> > Android userspace patches for custom ROMs such as
> > https://review.lineageos.org/#/c/LineageOS/android_system_bt/+/142721/
> > Since this appears to be intended behaviour, treated them as diagnostic
> > packets.
> >=20
> > Note that this is another variant of commit 01d5e44ace8a=20
> > ("Bluetooth: hci_bcm: Handle empty packet after firmware loading")
> >=20
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > drivers/bluetooth/hci_bcm.c | 32 +++++++++++++++++++++++++++-----
> > 1 file changed, 27 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> > index ddbd8c6a0ceb..ae271836dc26 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -51,6 +51,12 @@
> > #define BCM_LM_DIAG_PKT 0x07
> > #define BCM_LM_DIAG_SIZE 63
> >=20
> > +#define BCM_UNKNOWN_PKT 0x31
> > +#define BCM_UNKNOWN_SIZE 0
> > +
> > +#define BCM_UNKNOWN2_PKT 0x34
> > +#define BCM_UNKNOWN2_SIZE 0
> > +
>=20
> lets use BCM_TYPE49_ and BCM_TYPE52_
>=20
> > #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
> >=20
> > /**
> > @@ -561,12 +567,28 @@ static int bcm_setup(struct hci_uart *hu)
> > 	.lsize =3D 0, \
> > 	.maxlen =3D BCM_NULL_SIZE
> >=20
> > +#define BCM_RECV_UNKNOWN \
> > +	.type =3D BCM_UNKNOWN_PKT, \
> > +	.hlen =3D BCM_UNKNOWN_SIZE, \
> > +	.loff =3D 0, \
> > +	.lsize =3D 0, \
> > +	.maxlen =3D BCM_UNKNOWN_SIZE
> > +
> > +#define BCM_RECV_UNKNOWN2 \
> > +	.type =3D BCM_UNKNOWN2_PKT, \
> > +	.hlen =3D BCM_UNKNOWN2_SIZE, \
> > +	.loff =3D 0, \
> > +	.lsize =3D 0, \
> > +	.maxlen =3D BCM_UNKNOWN2_SIZE
>=20
> Same here, BCM_RECV_TYPE49 and BCM_RECV_TYPE52.
>=20
> > +
> > static const struct h4_recv_pkt bcm_recv_pkts[] =3D {
> > -	{ H4_RECV_ACL,      .recv =3D hci_recv_frame },
> > -	{ H4_RECV_SCO,      .recv =3D hci_recv_frame },
> > -	{ H4_RECV_EVENT,    .recv =3D hci_recv_frame },
> > -	{ BCM_RECV_LM_DIAG, .recv =3D hci_recv_diag  },
> > -	{ BCM_RECV_NULL,    .recv =3D hci_recv_diag  },
> > +	{ H4_RECV_ACL,       .recv =3D hci_recv_frame },
> > +	{ H4_RECV_SCO,       .recv =3D hci_recv_frame },
> > +	{ H4_RECV_EVENT,     .recv =3D hci_recv_frame },
> > +	{ BCM_RECV_LM_DIAG,  .recv =3D hci_recv_diag  },
> > +	{ BCM_RECV_NULL,     .recv =3D hci_recv_diag  },
> > +	{ BCM_RECV_UNKNOWN,  .recv =3D hci_recv_diag  },
> > +	{ BCM_RECV_UNKNOWN2, .recv =3D hci_recv_diag  },
> > };
> >=20
> > static int bcm_recv(struct hci_uart *hu, const void *data, int count)
>=20
> Regards
>=20
> Marcel
>=20
Hi
=46ixed in v2 version of patch.

Thanks for review.



