Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A135621757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A135621757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbeHGQZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:25:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42123 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbeHGQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:25:56 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1fn2hj-0008S8-U1; Tue, 07 Aug 2018 16:11:20 +0200
Received: from [IPv6:2001:470:7eea:1122:6c91:b8f:4e84:18d1] (unknown [IPv6:2001:470:7eea:1122:6c91:b8f:4e84:18d1])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A278034EA0A;
        Tue,  7 Aug 2018 14:11:17 +0000 (UTC)
Subject: Re: [PATCH v4] can: sja1000: plx_pci: add support for ASEM CAN raw
 device
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <53dae6d6-c25b-71d5-b43f-1d444d9c352b@pengutronix.de>
 <1533626239-4065-1-git-send-email-f.suligoi@asem.it>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJabjnbBQkK/nszAAoJECte4hHF
 iupU7UUQAIMmYURs8mpBKFKOFhWZczuCRt7vueMkyj9voaipD/vrbeYBVFr4dvFeoodQCKSi
 4/cHN3LIC8j1n0JGyQ8LsV2cHbZUd3Wcdw4KMsDMSVk9unAjahfX1MyB7qPgUDlW1jYrapFm
 eTNE1hp1+TAKL8W/E4rahhf3fdJxlS3h1CSnbfEavBQXBUi8jKX3G6mub2BSJUe3smAEb8JC
 3Td3+jzgCDK+dPwMeusxjU/JT5j/gCUbmGAGojex/P1dSfrMjLX2MhQpd6b/K28mymb1Zr34
 TGetLHn6eE5yvW5XXYX9p1zpwhdhQ+bsnOo6HhlPzWsEkd/fK9InyfBN+yflJBnROv6Uk34O
 nsh3TaX5hdIcCfOqpvSETY23quJKsL9Sng0xJ6jdCW6diIr6Kl154ijdOkPtYNKYTdDX3CYy
 Jc0WjG0lh6q5zOUGdm0SuRLi9fGTyhUUmR862XVX0XqZjxllWwk+UI5I6bge2AUpKP+7zxr5
 0OLBHHGkCq/NYJS/6lt34qrbHcoRgUDOk/ZSIRNQQdsHEsuKTyrJxmpXFJMxx3LKdZ1z4xqP
 9Gm9Ifrbdx8bD8KhwN6CFnUBylI9BawAH3egnD5HpOU3dLcFT2mPY/E15WSA/8Pn0QllCZ0/
 CYTcepOVHv1SWTSemA4I5sFMMhkmAFWdIdSRX1oZXJKcuQENBFpuQT4BCAC1d43/wNxcuZEr
 FCxRQCTxyFHkAdOETPThyBuGIbTCOk94R6whDwEPUnpKqdaTuNChTbFxZEthXBJiAhD9nDoU
 o5gBxZJWoqnLyzfQANIfjYFEw+j/T9Sx3Z96p3/KDaDDAXryt97taTX8czWBqYdQfG6UwjTK
 cMw5yQ2WzgO0hKkFDLyRXZAoP7jIiVm8JVNNdnQXH0MzQIRAcAS0JNYSC/Vppx3w84GvxAD6
 cx95aByHNnR5gbyciq4pHuUsqw1YC0Wakd2f2L6HnaYYvtFypHLNO8a1YVfsY+1h6D2ul7P6
 AGUbUQghaf5khgYpBfTi4YbQgKyxOZoYYfh8ssPVABEBAAGJAjwEGAEKACYWIQTBQAugs5ie
 b7x9W1wrXuIRxYrqVAUCWm5BPgIbDAUJAeXlcgAKCRArXuIRxYrqVL9ZD/oD+32+N0ijZQ8p
 /RaRjPtSnAs6irNRGE1ZKcKpiM76eRFJrN7HvfFiDFmUpSh+8bDyM5kc/Z1AXhXlf0VBT24N
 ZLBXXaFl/M4HKkJTc+PA3yYgb06ChfMWst5h8rfa7htqAhLUby2MTyfJ0xcAptCWTnW0OCGj
 EL4ZKr8Ml/fjKYP7hp37iBXwwQF3lSSdjMsEjMT/9/9Ip2+uJ559F8pCmFV5wNgHRH+jnxII
 iUILoQMDn42cygozxfh14GwCqUSPW+EqBb7YOWreWA3D3kbXtIwV7/ZXT7L0n/0OTx9pK9K/
 C2jleQxaep8bHmHqTEEqkrC0rNhocTcrnOYviEO0TkHvSqtNMaM3KnOL3Nsb6rgqDpj2BVWk
 rIqMPi0aXfBu/ArZsAios/0QHB56Id3BshIbs1A2VNmFgrxkhKjwJ8A7geD5PXn0cur08byy
 64Kk7ii0iwbJZasPfVLPLmMEVjiSOgZv4hbKyecWVwtlMh3k4rkMuSVDDr+2E9KQXS2REfe7
 jTF9WUzFhm0HYiYSiiQyHuZPLc6t/L9OqvrNVTdYaEkBsm/LVv6h6rqpklJLQhU/2KtLbImH
 8IQK6+7up2rtwyqeehbNdsiqyDA6Sso5eKCoxKKbAFM7PtEYMC2Kv6wAca5SqEOUtRHU/6jK
 eO1yNpD5UgI9bzazBn1mwrkBDQRabkElAQgA2DC6TvbKcisVld/bvetQmVseRAjC38ccfMim
 N4Be5XG18y6STUlbpCVAjKx8944bJiEQb0AId1drMfsD/yGtIB3gxuGnzgm/bAaMd8U/XP/l
 j7AwbgdcZYt1o/BYb9RUd1nj8nFhpn2HjxGz8NgK92OQvlKQYCZF4x0fCPYfs6N8qpR9rISj
 9sfJa/HnpOu6WCke0xW99+j3GmNPizKMELbsRJweg61emL8GnU4l5lq3nKEYgcjHiWiVeu0/
 7LmK2g13ih7f7htRNLbXVz4FNKQ5Tqd/DjHhYMFZTRArRQn/wvEYzAWadULy6paxqoLk4nHO
 MNixgVGAfM/c3q4t4wARAQABiQNyBBgBCgAmFiEEwUALoLOYnm+8fVtcK17iEcWK6lQFAlpu
 QSUCGwIFCQHl5YsBQAkQK17iEcWK6lTAdCAEGQEKAB0WIQQ2sKd2UH9WcARa4fmT0hTXNChl
 8QUCWm5BJQAKCRCT0hTXNChl8V6ECADMpDZNCd1ssogUiPdOlOxOOysj/9vclhsoId8Xtb7T
 PmMFjEFdnqJuAHdZ6WkXc/aot5xhhEwJCOQrfsgNAji2KCVOg1pxAeOoIsoAx145xuPsz7Fc
 7wTYNSlkFeaJ8F0eKpCJH6BEQebo5C9oLq5JvAg/4oKJ9AxZgh7Dup6BAiP2sKRclTfm046A
 eDjEYli+M5FRXZ7PVzil4x9VYkk9KII1xBdHSt178HvRHEUB91CDXSvOgWI9+OTmsmAYls8M
 IY2Xia6fLwBUspdg6m5BF7OTOTj5mSSWo5EsGsecQkkhGwiP0r1Gr5qbKmXlXPbIkjlxsvAu
 ohKIpEWK2M5OaRkP/iDSpREo5/StBenBUv+2QrhLP+uZJKiz5xbQ9Meo1l9z+bK1/5AGKca5
 5M1APub2n0awP3MMDGMETTYK2RANsuuLxpD7uohzZf7m4iGz9V9EIBqkunuCpHHNhiZDK04R
 Oc5TMmKWFUvlXdFGwUOAydu8j/JcT+09GGU3vku2uHXHddI5vqe9Z/8JofC/XYviHIquo7P1
 THmpjsGLIbBUq+mJ6xJgNLJcwNP9JbFZMXunFLlp7ZTVTiuTYhC/dBIfTJGIMjNClpWqHHn9
 bGYsrNPtOmvNjwodRTQx2kengSL7ANk9BbA6DReFpWmPKLR/QJ8ucSJ9/np4Yn074rpxkWQD
 LTTOv87eT2ypBZaEDCGt3K7OBuknECovWTvkOTnMrb78QS8QqXvbVuiR+iITkIrMLG2FdGzy
 6mXwwCEJxn5s9Y5Y31hPGlQnYDPAuYMrDVBRsIQVwAsWpV83vKjp4WFP4wC1LEYj+j/Oorqv
 ALsMRq49WSclOMvqDdh//wmfSAbkyn3EA6EMv9mxJHJvKW7PMXvO0Mk1uP/+VR3FudMXhZzz
 MUYlqpO3B/RmA7lPoMY5+Km8c4/6L9Bn0vcbGMH4piH0IuEK0px64oXtKfti47XrCX+EDpSn
 ZwhEnNjCKyAJTaangebRpvOwJUZUWVh+hpM5FMcwJGKvVXNmrmSj
Message-ID: <e5e06710-0304-0cf9-67fb-1e29f0678c86@pengutronix.de>
Date:   Tue, 7 Aug 2018 16:11:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1533626239-4065-1-git-send-email-f.suligoi@asem.it>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GwWPbA1u80iYaHjL2q9fKQUIlT9lgCxnc"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GwWPbA1u80iYaHjL2q9fKQUIlT9lgCxnc
Content-Type: multipart/mixed; boundary="YMltpOcnnVXokJmyjd0BdYxRNxTpQ71yV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Flavio Suligoi <f.suligoi@asem.it>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <e5e06710-0304-0cf9-67fb-1e29f0678c86@pengutronix.de>
Subject: Re: [PATCH v4] can: sja1000: plx_pci: add support for ASEM CAN raw
 device
References: <53dae6d6-c25b-71d5-b43f-1d444d9c352b@pengutronix.de>
 <1533626239-4065-1-git-send-email-f.suligoi@asem.it>
In-Reply-To: <1533626239-4065-1-git-send-email-f.suligoi@asem.it>

--YMltpOcnnVXokJmyjd0BdYxRNxTpQ71yV
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/07/2018 09:17 AM, Flavio Suligoi wrote:
> This patch adds support for ASEM opto-isolated dual channels
> CAN raw device (http://www.asem.it)
>=20
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>=20
> v2: - rename ASEM_... constants to reduce space size;
>     - remove "else" in "plx_pci_reset_asem_dual_can_raw" function to av=
oid=20
>       strings breaking
> v3: - fix wrong comment for PLX_LINT2_POL
>     - put string into just one line in "plx_pci_reset_asem_dual_can_raw=
"
>       function
> v4: - remove unnecessary variable "reset_bar" in=20
>       "plx_pci_reset_asem_dual_can_raw" function
>=20
>  drivers/net/can/sja1000/Kconfig   |  1 +
>  drivers/net/can/sja1000/plx_pci.c | 66 +++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 66 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/=
Kconfig
> index 1e65cb6..f6dc899 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -88,6 +88,7 @@ config CAN_PLX_PCI
>  	   - TEWS TECHNOLOGIES TPMC810 card (http://www.tews.com/)
>  	   - IXXAT Automation PC-I 04/PCI card (http://www.ixxat.com/)
>  	   - Connect Tech Inc. CANpro/104-Plus Opto (CRG001) card (http://www=
=2Econnecttech.com)
> +	   - ASEM CAN raw - 2 isolated CAN channels (www.asem.it)
> =20
>  config CAN_TSCAN1
>  	tristate "TS-CAN1 PC104 boards"
> diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja100=
0/plx_pci.c
> index f8ff25c..79fc327 100644
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -46,7 +46,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "=

>  			"esd CAN-PCIe/2000, "
>  			"Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
>  			"IXXAT PC-I 04/PCI, "
> -			"ELCUS CAN-200-PCI")
> +			"ELCUS CAN-200-PCI, "
> +			"ASEM DUAL CAN-RAW")
>  MODULE_LICENSE("GPL v2");
> =20
>  #define PLX_PCI_MAX_CHAN 2
> @@ -70,7 +71,9 @@ struct plx_pci_card {
>  					 */
> =20
>  #define PLX_LINT1_EN	0x1		/* Local interrupt 1 enable */
> +#define PLX_LINT1_POL	(1 << 1)	/* Local interrupt 1 polarity */
>  #define PLX_LINT2_EN	(1 << 3)	/* Local interrupt 2 enable */
> +#define PLX_LINT2_POL	(1 << 4)	/* Local interrupt 2 polarity */
>  #define PLX_PCI_INT_EN	(1 << 6)	/* PCI Interrupt Enable */
>  #define PLX_PCI_RESET	(1 << 30)	/* PCI Adapter Software Reset */
> =20
> @@ -92,6 +95,9 @@ struct plx_pci_card {
>   */
>  #define PLX_PCI_OCR	(OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL)
> =20
> +/* OCR setting for ASEM Dual CAN raw */
> +#define ASEM_PCI_OCR	0xfe
> +
>  /*
>   * In the CDR register, you should set CBP to 1.
>   * You will probably also want to set the clock divider value to 7
> @@ -145,10 +151,20 @@ struct plx_pci_card {
>  #define MOXA_PCI_VENDOR_ID		0x1393
>  #define MOXA_PCI_DEVICE_ID		0x0100
> =20
> +#define ASEM_RAW_CAN_VENDOR_ID		0x10b5
> +#define ASEM_RAW_CAN_DEVICE_ID		0x9030
> +#define ASEM_RAW_CAN_SUB_VENDOR_ID	0x3000
> +#define ASEM_RAW_CAN_SUB_DEVICE_ID	0x1001
> +#define ASEM_RAW_CAN_SUB_DEVICE_ID_BIS	0x1002
> +#define ASEM_RAW_CAN_RST_REGISTER	0x54
> +#define ASEM_RAW_CAN_RST_MASK_CAN1	0x20
> +#define ASEM_RAW_CAN_RST_MASK_CAN2	0x04
> +
>  static void plx_pci_reset_common(struct pci_dev *pdev);
>  static void plx9056_pci_reset_common(struct pci_dev *pdev);
>  static void plx_pci_reset_marathon_pci(struct pci_dev *pdev);
>  static void plx_pci_reset_marathon_pcie(struct pci_dev *pdev);
> +static void plx_pci_reset_asem_dual_can_raw(struct pci_dev *pdev);
> =20
>  struct plx_pci_channel_map {
>  	u32 bar;
> @@ -269,6 +285,14 @@ static struct plx_pci_card_info plx_pci_card_info_=
moxa =3D {
>  	 /* based on PLX9052 */
>  };
> =20
> +static struct plx_pci_card_info plx_pci_card_info_asem_dual_can =3D {
> +	"ASEM Dual CAN raw PCI", 2,
> +	PLX_PCI_CAN_CLOCK, ASEM_PCI_OCR, PLX_PCI_CDR,
> +	{0, 0x00, 0x00}, { {2, 0x00, 0x00}, {4, 0x00, 0x00} },
> +	&plx_pci_reset_asem_dual_can_raw
> +	/* based on PLX9030 */
> +};
> +
>  static const struct pci_device_id plx_pci_tbl[] =3D {
>  	{
>  		/* Adlink PCI-7841/cPCI-7841 */
> @@ -375,6 +399,20 @@ static const struct pci_device_id plx_pci_tbl[] =3D=
 {
>  		0, 0,
>  		(kernel_ulong_t)&plx_pci_card_info_moxa
>  	},
> +	{
> +		/* ASEM Dual CAN raw */
> +		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> +		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID,
> +		0, 0,
> +		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
> +	},
> +	{
> +		/* ASEM Dual CAN raw -new model */
> +		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> +		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS,
> +		0, 0,
> +		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
> +	},
>  	{ 0,}
>  };
>  MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
> @@ -524,6 +562,32 @@ static void plx_pci_reset_marathon_pcie(struct pci=
_dev *pdev)
>  	}
>  }
> =20
> +/* Special reset function for ASEM Dual CAN raw card */
> +static void plx_pci_reset_asem_dual_can_raw(struct pci_dev *pdev)
> +{
> +	void __iomem *bar0_addr;
> +	u8 tmpval;
> +
> +	plx_pci_reset_common(pdev);
> +
> +	bar0_addr =3D pci_iomap(pdev, 0, 0);
> +	if (!bar0_addr) {
> +		dev_err(&pdev->dev, "Failed to remap reset space %d (BAR%d)\n",
> +			0, 0);

I've put both 0 directly into the string while applying the patch.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--YMltpOcnnVXokJmyjd0BdYxRNxTpQ71yV--

--GwWPbA1u80iYaHjL2q9fKQUIlT9lgCxnc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltpqIIACgkQk9IU1zQo
ZfFNjQgAtJMhIkhXfNMoBFhqWm+C+xyu1EYKzHHl0HmnCBHK86JesbnZ+OqYmfnG
W7NlFa1wzT4Yufl6eT4j4OZjUSVMsztO6qYq0j4tI9QbOQMIilsNP5GCnyH1k+yV
DVmyo8JSvM/D2FVcQi3lPJn4Lj/jWaj9meNPmtOYMtwyNjAXEVK4wdd58mbv6B9A
5Ppjc2u39iTOdAJicvsOHaSrrAvZG6plBkcswI09e+VoGMLyON1nifNpjga5AN8d
Ld8kfplLA4c/2J7miz+FBKCU7rzAQnM/yg6YLk5ceY3YsoHNd/are36p/BcNkh4r
lAJavzmpJblhmkdWGC9D+vC4WcHz/A==
=i/vG
-----END PGP SIGNATURE-----

--GwWPbA1u80iYaHjL2q9fKQUIlT9lgCxnc--
