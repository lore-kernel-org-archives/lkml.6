Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeCMRoP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:44:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36263 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeCMRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:44:14 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <e6864131-adab-382b-617b-35e9329f00d0@pengutronix.de>
Date: Tue, 13 Mar 2018 18:44:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VoNNt82vJAiWRv9Cth82PUhrZk8z853rx"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VoNNt82vJAiWRv9Cth82PUhrZk8z853rx
Content-Type: multipart/mixed; boundary="v04uIy06ALT0GyZf2zb5UyickMgiUKJK6";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <e6864131-adab-382b-617b-35e9329f00d0@pengutronix.de>
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
In-Reply-To: <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>

--v04uIy06ALT0GyZf2zb5UyickMgiUKJK6
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 03/13/2018 06:35 PM, Jakob Unterwurzacher wrote:

[...]

Please mark all multibyte values going over the USB as either le or be.

> +struct ucan_ctl_cmd_start {
> +	u16 mode;            /* oring any of UCAN_MODE_* */
> +} __packed;
> +
> +struct ucan_ctl_cmd_set_bittiming {
> +	u32 tq;		     /* Time quanta (TQ) in nanoseconds */
> +	u16 brp;	     /* TQ Prescaler */
> +	u16 sample_point;    /* Samplepoint on tenth percent */
> +	u8 prop_seg;	     /* Propagation segment in TQs */
> +	u8 phase_seg1;	     /* Phase buffer segment 1 in TQs */
> +	u8 phase_seg2;	     /* Phase buffer segment 2 in TQs */
> +	u8 sjw;		     /* Synchronisation jump width in TQs */
> +} __packed;
> +
> +struct ucan_ctl_cmd_device_info {
> +	u32 freq;   /* Clock Frequency for tq generation */
> +	u8 tx_fifo; /* Size of the transmission fifo */
> +	u8 sjw_max;   /* can_bittiming fields... */
> +	u8 tseg1_min;
> +	u8 tseg1_max;
> +	u8 tseg2_min;
> +	u8 tseg2_max;
> +	u16 brp_inc;
> +	u32 brp_min;
> +	u32 brp_max; /* ...can_bittiming fields */
> +	u16 ctrlmodes; /* supported control modes */
> +	u16 hwfilter;  /* Number of HW filter banks */
> +	u16 rxmboxes;  /* Number of receive Mailboxes */
> +} __packed;
> +
> +struct ucan_ctl_cmd_get_protocol_version {
> +	u32 version;
> +} __packed;
> +
> +union ucan_ctl_payload {
> +	/***************************************************
> +	 * Setup Bittiming
> +	 * bmRequest =3D=3D UCAN_COMMAND_START
> +	 ***************************************************/

Please use standard 'net' comment style:

/* this is a multiline
 * comment
 */

> +	struct ucan_ctl_cmd_start cmd_start;
> +	/***************************************************
> +	 * Setup Bittiming
> +	 * bmRequest =3D=3D UCAN_COMMAND_SET_BITTIMING
> +	 ***************************************************/
> +	struct ucan_ctl_cmd_set_bittiming cmd_set_bittiming;
> +	/***************************************************
> +	 * Get Device Information
> +	 * bmRequest =3D=3D UCAN_COMMAND_GET; wValue =3D UCAN_COMMAND_GET_INF=
O
> +	 ***************************************************/
> +	struct ucan_ctl_cmd_device_info cmd_get_device_info;
> +	/***************************************************
> +	 * Get Protocol Version
> +	 * bmRequest =3D=3D UCAN_COMMAND_GET;
> +	 * wValue =3D UCAN_COMMAND_GET_PROTOCOL_VERSION
> +	 ***************************************************/
> +	struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;
> +
> +	u8 raw[128];
> +} __packed;

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--v04uIy06ALT0GyZf2zb5UyickMgiUKJK6--

--VoNNt82vJAiWRv9Cth82PUhrZk8z853rx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqoDeIACgkQk9IU1zQo
ZfEKdAgAq3DuiJJZVCoJrgqLTTsWAR08OSJ8KNzjGLdHvg+I2yesxaxbFRmkBN4K
fKNAK1RZCsgdkC1dyD8bsobYeA0ESHu6wBxu20UD4l3Dt6PGd+waG0Ktp/5JXJ4q
1Xb04j0/JXnxmFS3pJo2ulpfkPU/WHcIqnHOflpcvFo0d95NRDcfcYRT6RpL6MHO
Hnow3qYX0ZnshJg2PSFZM5JLZtHetf9F9uCETt6W7YJkHYt7HR7ox2hxOvXQXllO
d0ifvsZYFv9sWuuNLaFnoSgxvCnwWSEHERQHJWMd6ircwz9TfZlLS405JdpJ0Ma4
4+dajT+6zD4McAZoZ4dUFO1mmMrCKg==
=9Zbk
-----END PGP SIGNATURE-----

--VoNNt82vJAiWRv9Cth82PUhrZk8z853rx--
