Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeCLJkO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:40:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55743 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:40:13 -0400
Subject: Re: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
To: Bich HEMON <bich.hemon@st.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Mario Huettel <mario.huettel@gmx.net>, Faiz Abbas <faiz_abbas@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Franklin S Cooper Jr <fcooper@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1520844745-5865-1-git-send-email-bich.hemon@st.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <1628648a-55b6-101a-795c-3d43b46c278b@pengutronix.de>
Date: Mon, 12 Mar 2018 10:39:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520844745-5865-1-git-send-email-bich.hemon@st.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VWn3ObWPZSwuHqJOok9nOvpYNzbP7K0ob"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VWn3ObWPZSwuHqJOok9nOvpYNzbP7K0ob
Content-Type: multipart/mixed; boundary="OEPYOkZrrzZVAM1aujhOc0gWwy7B6obvp";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bich HEMON <bich.hemon@st.com>, Wolfgang Grandegger <wg@grandegger.com>,
 Mario Huettel <mario.huettel@gmx.net>, Faiz Abbas <faiz_abbas@ti.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Franklin S Cooper Jr <fcooper@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <1628648a-55b6-101a-795c-3d43b46c278b@pengutronix.de>
Subject: Re: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
References: <1520844745-5865-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1520844745-5865-1-git-send-email-bich.hemon@st.com>

--OEPYOkZrrzZVAM1aujhOc0gWwy7B6obvp
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 03/12/2018 09:52 AM, Bich HEMON wrote:
> Make sure to apply the correct pin state in suspend/resume callbacks.
> Putting pins in sleep state saves power.
>=20
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---

Doesn't compile:

>   CHECK   /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can=
=2Ec
> /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can.c:1703:9:=
 error: undefined identifier 'pinctrl_pm_select_sleep_state'
> /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can.c:1715:9:=
 error: undefined identifier 'pinctrl_pm_select_default_state'
> /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can.c:1703:38=
: warning: call with no type!
> /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can.c:1715:40=
: warning: call with no type!
>   CC [M]  drivers/net/can/m_can/m_can.o
> /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can.c: In fun=
ction 'm_can_suspend':
> /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can.c:1703:2:=
 error: implicit declaration of function 'pinctrl_pm_select_sleep_state' =
[-Werror=3Dimplicit-function-declaration]
>   pinctrl_pm_select_sleep_state(dev);
>   ^
> /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can.c: In fun=
ction 'm_can_resume':
> /srv/work/frogger/socketcan/linux/drivers/net/can/m_can/m_can.c:1715:2:=
 error: implicit declaration of function 'pinctrl_pm_select_default_state=
' [-Werror=3Dimplicit-function-declaration]
>   pinctrl_pm_select_default_state(dev);
>   ^

Fixed while applying the patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OEPYOkZrrzZVAM1aujhOc0gWwy7B6obvp--

--VWn3ObWPZSwuHqJOok9nOvpYNzbP7K0ob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqmSu8ACgkQk9IU1zQo
ZfE6awf/depsl9voaLAIhRDe1M+vZX2p5BYYTtTNvc0hrzFszGJJxMCJewerNkr0
I2WPcX6Yh0nOoRnNqf0pnHp/PXHv5slh36AucmXPpGmu1en3zJTwUt3Ge+c6YUzs
CbVfoROHagEnKYeDtj2Gi7ZO3lgBqDt01z59mEb/owheAkN2+QthvxQ0c94cfAGc
P/wsAMi5UVmEocq8nuy6EshuE59st+L0TJX7SOvkRcvftlA7RXpS+ZYEFrSM3vKO
qi88EZjx+6TJdNGZDTlIq/OUId8uLXHWp8hYPbf/MmzzZOYAld2y5L/ZHhPxqE+L
yGXirHo4SoVjAJNXtqnzKzojgAWA/w==
=PWjX
-----END PGP SIGNATURE-----

--VWn3ObWPZSwuHqJOok9nOvpYNzbP7K0ob--
