Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeCXMWK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 08:22:10 -0400
Received: from sauhun.de ([88.99.104.3]:40826 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbeCXMWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 08:22:08 -0400
Date: Sat, 24 Mar 2018 13:22:06 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Major code reorganization to make all i2c
 transfers working
Message-ID: <20180324122206.c4loxtob5o3lm7al@ninjato>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g656d5a55zjvfkaz"
Content-Disposition: inline
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g656d5a55zjvfkaz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 06:44:49PM +0530, Abhishek Sahu wrote:
> * v2:
>=20
> 1. Address review comments in v1
> 2. Changed the license to SPDX
> 3. Changed commit messages for some of the patch having more detail
> 4. Removed event-based completion and changed transfer completion
>    detection logic in interrupt handler
> 5. Removed dma_threshold and blk_mode_threshold from global structure
> 6. Improved determine mode logic for QUP v2 transfers
> 7. Fixed function comments
> 8. Fixed auto build test WARNING =E2=80=98idx' may be used uninitialized
>    in this function
> 9. Renamed tx/rx_buf to tx/rx_cnt
>=20
> * v1:
>=20
> The current driver is failing in following test case
> 1. Handling of failure cases is not working in long run for BAM
>    mode. It generates error message =E2=80=9Cbam-dma-engine 7884000.dma: =
Cannot
>    free busy channel=E2=80=9D sometimes.
> 2. Following I2C transfers are failing
>    a. Single transfer with multiple read messages
>    b. Single transfer with multiple read/write message with maximum
>       allowed length per message (65K) in BAM mode
>    c. Single transfer with write greater than 32 bytes in QUP v1 and
>       write greater than 64 bytes in QUP v2 for non-DMA mode.
> 3. No handling is present for Block/FIFO interrupts. Any non-error
>    interrupts are being treated as the transfer completion and then
>    polling is being done for available/free bytes in FIFO.
>=20
> To fix all these issues, major code changes are required. This patch
> series fixes all the above issues and makes the driver interrupt based
> instead of polling based. After these changes, all the mentioned test
> cases are working properly.
>=20
> The code changes have been tested for QUP v1 (IPQ8064) and QUP
> v2 (IPQ8074) with sample application written over i2c-dev.
>=20
> Abhishek Sahu (13):
>   i2c: qup: fix copyrights and update to SPDX identifier
>   i2c: qup: fixed releasing dma without flush operation completion
>   i2c: qup: minor code reorganization for use_dma
>   i2c: qup: remove redundant variables for BAM SG count
>   i2c: qup: schedule EOT and FLUSH tags at the end of transfer
>   i2c: qup: fix the transfer length for BAM RX EOT FLUSH tags
>   i2c: qup: proper error handling for i2c error in BAM mode
>   i2c: qup: use the complete transfer length to choose DMA mode
>   i2c: qup: change completion timeout according to transfer length
>   i2c: qup: fix buffer overflow for multiple msg of maximum xfer len
>   i2c: qup: send NACK for last read sub transfers
>   i2c: qup: reorganization of driver code to remove polling for qup v1
>   i2c: qup: reorganization of driver code to remove polling for qup v2

Applied to for-next, thanks! Also thanks to the reviewers!


--g656d5a55zjvfkaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq2Qu4ACgkQFA3kzBSg
KbZ4zg/+J/sTd2ozEwrsjkkq/RoRlC4lONS5SuYX+mh/MYJ3bXhNH4M6adFgXZez
eBq3iHgWaahOhowh/vUuCBsgVPq+1n3a8Ctg9guj7tQL0rVdGRbMYhdJudwTWmZq
VcCtUDSnztWsAMjx6WVvSaHWH1u2fP3RSp0GMjT43GDMg2UwDStbQoDpIADhm8jI
FBRSTwmN3WYERxDxe3JoTkWXJOgumWfTifWkH/KIPjKpzLbLydyZhgmIlvip7Ljg
Yy2EECuavKHtH0dop85X5n6loK+gPVcU5Dl8YIuCPqB+Nn4tjKvUKcgXjtwea3Ip
lGdovQtD9gM8nEto4B/ccbe1zy4Z9iQUSI+9SwEjz5oH9ovelREi3VtAW/0hvPa9
YaXSJOHIxEpooTK+jYVj8CmFxUWVY8/YjfDrwWFDa4d5fLaGRF9aTvcy77Chw236
TN4tp07vFfeblSFCZz9QIRRiEt194537KJCuFlN2iBwaL6dIg+KXjgWvUXbFaIkj
iM/sCWT7uwTq/mEMASyWs6fhXt+ESw+Tqbr5JdAcuSjRhynqoTCTO2W6EMYV7WvC
qzLJFLV2cCs3j8B3cENjtsVPnq3ga1GAvJKp3wAMjxTxYfaXFzHLWQ2RtYjPZBRz
7vb8vY/BZJ4qWj10v/GFQPOM4H6pFZB4JzfVJdR4W/+9nqUkzXs=
=o5Rv
-----END PGP SIGNATURE-----

--g656d5a55zjvfkaz--
