Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeBAMQ6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:16:58 -0500
Received: from mail-he1eur01on0058.outbound.protection.outlook.com ([104.47.0.58]:44730
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752237AbeBAMQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:16:56 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fabio Estevam <fabio.estevam@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "lukas.auer@aisec.fraunhofer.de" <lukas.auer@aisec.fraunhofer.de>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "ryan.harkin@linaro.org" <ryan.harkin@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is already
 initialized
Thread-Topic: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is
 already initialized
Thread-Index: AQHTmjdOwMiIynBKwEGhPiBJHBZpZw==
Date: Thu, 1 Feb 2018 12:16:51 +0000
Message-ID: <VI1PR0402MB334297558BB1984131546B1D98FA0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
 <1517364040-27607-3-git-send-email-pure.logic@nexus-software.ie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3390;7:oYG0lTAtDeZMrFvLG/jCyiCvEXd1g1XZyS8LLACW3SL0SY6ZCCO04b3Iz/8Ttdpw+YFF2788VZjw9dy4QBnxMKrYeItP75BnNB7RNb3s0pTmyG8rqmTCS904YVMBF1euMg0pV1ITlDq5XB0pIonbzdJVEnoi1dymOdxnRzD3rwXKL9SfGf+WEMZu3ilCjHjiOsSuvT6+Qw2jxiiasTFnvx2Y6znV/KQlPthXhg9l1qJ+8gMd0xSSVlXCfuxNyIz2
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(7736002)(316002)(81166006)(6246003)(86362001)(74316002)(305945005)(478600001)(4326008)(53936002)(9686003)(25786009)(55016002)(14454004)(2501003)(97736004)(66066001)(2900100001)(3846002)(6116002)(54906003)(2201001)(5250100002)(110136005)(106356001)(8936002)(3280700002)(2906002)(68736007)(99286004)(53546011)(102836004)(6436002)(5660300001)(7696005)(33656002)(76176011)(186003)(3660700001)(26005)(8676002)(105586002)(81156014)(6506007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3390;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61335b6b-727f-482e-b332-08d5696dacea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3390;
x-ms-traffictypediagnostic: VI1PR0402MB3390:
x-microsoft-antispam-prvs: <VI1PR0402MB3390D1D58CBD1F871FEE8A5598FA0@VI1PR0402MB3390.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0402MB3390;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3390;
x-forefront-prvs: 0570F1F193
x-microsoft-antispam-message-info: 7mYlUtTExGFriJpGEbQ64M6cTTD2aJ+5lL+5lVq7vC/CZ+S1hQDfSlqnm99yupA8Zcc0u7RZdozW2H6kXlJ/AQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61335b6b-727f-482e-b332-08d5696dacea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 12:16:51.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3390
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11CH4Bk032662

On 1/31/2018 4:00 AM, Bryan O'Donoghue wrote:
> commit 1005bccd7a4a ("crypto: caam - enable instantiation of all RNG4 state
> handles") introduces a control when incrementing ent_delay which contains
> the following comment above it:
> 
> /*
>  * If either SH were instantiated by somebody else
>  * (e.g. u-boot) then it is assumed that the entropy
>  * parameters are properly set and thus the function
>  * setting these (kick_trng(...)) is skipped.
>  * Also, if a handle was instantiated, do not change
>  * the TRNG parameters.
>  */
> 
> This is a problem observed when sec_init() has been run in u-boot and
> and TrustZone is enabled. We can fix this by instantiating all rng state
> handles in u-boot but, on the Kernel side we should ensure that this
> non-terminating path is dealt with.
> 
> Fixes: 1005bccd7a4a ("crypto: caam - enable instantiation of all RNG4 state
> handles")
> 
> Reported-by: Ryan Harkin <ryan.harkin@linaro.org>
> Cc: "Horia Geantã" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
> Cc: <stable@vger.kernel.org> # 4.12+
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> ---
>  drivers/crypto/caam/ctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
> index 98986d3..0a1e96b 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -704,7 +704,10 @@ static int caam_probe(struct platform_device *pdev)
>  					 ent_delay);
>  				kick_trng(pdev, ent_delay);
>  				ent_delay += 400;
> +			} else if (ctrlpriv->rng4_sh_init && inst_handles) {
> +				ent_delay += 400;
>  			}
If both RNG state handles are initialized before kernel runs, then
instantiate_rng() should be a no-op and return 0, which is enough to exit the
loop: while ((ret == -EAGAIN) && (ent_delay < RTSDCTL_ENT_DLY_MAX))

If the loop cannot exit based on value of "ret" != -EAGAIN, then it means
caam_probe() will eventually fail due to ret == -EAGAIN:
	if (ret) {
		dev_err(dev, "failed to instantiate RNG");
		goto caam_remove;
	}

Please provide more details, so that the root cause is found and fixed.
For e.g. what is the value of RDSTA (RNG DRNG Status register @0x6C0):
-before & after u-boot initializes RNG
-as seen by kernel during caam_probe()
Also provide related error messages displayed during boot.

Thanks,
Horia
