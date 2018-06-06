Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XAAqAIqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C74F60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbeFFP6E (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:58:04 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:32768
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932183AbeFFP6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:58:02 -0400
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on
 i.MX8x
Thread-Topic: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block
 on i.MX8x
Thread-Index: AQHT84pNMjdFhAI/vUSobBw7N99yZ6RS+0KAgAB6QGA=
Date: Wed, 6 Jun 2018 15:57:57 +0000
Message-ID: <HE1PR04MB3289F832BAC9F430241E394E89650@HE1PR04MB3289.eurprd04.prod.outlook.com>
References: <20180524180848.61844-1-shenwei.wang@nxp.com>
 <20180606083423.GE11810@ulmo>
In-Reply-To: <20180606083423.GE11810@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com;
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1420;7:YfEi0itfP+5W+g3HpvZe4aLyAGvAYMNQ7F67ppuGCGbgl4NZLaZMzkeumhdL7khQfEuNLrBnK5SwL2dIBvDECY3Co5Q1ZLoG6OrfJem1F6K3q98s4l4uasX0Hr6rAzuisItSdRMJnTBAJLluv8vTi5QvmrDPlcUELQl/3Y59IChFVJGmITfyGF9QWmwHItqQoEz+JGIT8co/hX6YoBs2E0uFQhDAQ+RPZuvQE6y1Oe6BBjLjBnGiDqAaiHvh698W
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1420;
x-ms-traffictypediagnostic: HE1PR04MB1420:
x-microsoft-antispam-prvs: <HE1PR04MB1420432DE318D9705225144C89650@HE1PR04MB1420.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1420;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1420;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(396003)(346002)(376002)(13464003)(199004)(189003)(9686003)(316002)(66066001)(6436002)(25786009)(486006)(44832011)(53936002)(345774005)(5660300001)(33656002)(2900100001)(106356001)(229853002)(8676002)(54906003)(8936002)(5250100002)(81156014)(81166006)(59450400001)(186003)(3280700002)(39060400002)(3660700001)(55016002)(305945005)(7736002)(99286004)(97736004)(4326008)(53546011)(86362001)(102836004)(6506007)(6916009)(76176011)(26005)(7696005)(6116002)(68736007)(476003)(105586002)(11346002)(2906002)(3846002)(478600001)(14454004)(74316002)(6246003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1420;H:HE1PR04MB3289.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YS9OSJpJGW72DwUPQJBEUc+LGwW5rDRfBurqs99RQmDna38pinrpKTA8UEiw8rgKMtQTeJNZCp9psg+wBIgVLCHnmUGyYZTKsIW62WKMkoWhVPT6Z/bGtOZuIqTrCLwg/JfnRhqo5+CvI2L39Sr6FyY6eInu5qC2L2Vm56k0VHNtu3DyeeJpqfAJ9cjvI+q7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3b086cb5-5a82-40c0-67e3-08d5cbc645e0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b086cb5-5a82-40c0-67e3-08d5cbc645e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 15:57:57.7215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1420
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Thank you for the detailed review. I was intending to avoid adding a new co=
mpatible string, and to limit the changes. But your comments make sense, an=
d I will split the commit and use the compatible string to identify the IP =
differences.

Thanks,
Shenwei

-----Original Message-----
From: Thierry Reding [mailto:thierry.reding@gmail.com]=20
Sent: Wednesday, June 6, 2018 3:34 AM
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: linux-pwm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-kern=
el@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block=
 on i.MX8x

On Thu, May 24, 2018 at 01:08:48PM -0500, shenwei.wang@nxp.com wrote:
> On the new i.MX8x SoC family, the following changes were made on the=20
> FTM
> block:
>=20
> 1. Need to enable the IPG clock before accessing any FTM registers.=20
> Because the IPG clock is not an option for FTM counter clock source,=20
> it can't be used as the ftm_sys clock.
>=20
> 2. An additional PWM enable bit was added for each PWM channel in=20
> register FTM_SC[16:23]. It supports 8 channels. Bit16 is for channel=20
> 0, and bit23 for channel 7.

Generally if you need to itemize changes in your commit message it is a goo=
d indication that you should be splitting up the patch into multiple logica=
l changes. In this case, one possibility would be to turn this into three p=
atches:

	1. Introduce the concept on an "interface" clock which is by
	   default the same as the ftm_sys clock.

	2. Add support for enable bits, based on some per-compatible
	   data structure (see for example pwm-tegra.c for an example of
	   how to do this).

	3. Enable support for the new SoC family by adding an instance
	   of the per-compatible structure for that compatible string.

> As the IP version information can not be obtained in any of the FTM=20
> registers, a property of "fsl,has-pwmen-bits" is added in the ftm pwm=20
> device node. If it has the property, the driver set the PWM enable bit=20
> when a PWM channel is requested.

I don't see a corresponding device tree bindings update for this change.
Also, I don't think doing this via a separate property is the right way, yo=
u can just derive this from the new compatible string which you need to add=
 anyway.

So to the above patches, add:

	0. Add DT bindings for new SoC family with a mention that they
	   need to provide the new IPG clock.

>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c=20
> index 557b4ea..0426458f 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -86,7 +86,9 @@ struct fsl_pwm_chip {
>  	struct regmap *regmap;
> =20
>  	int period_ns;
> +	bool has_pwmen;
> =20
> +	struct clk *ipg_clk;
>  	struct clk *clk[FSL_PWM_CLK_MAX];
>  };
> =20
> @@ -97,16 +99,31 @@ static inline struct fsl_pwm_chip=20
> *to_fsl_chip(struct pwm_chip *chip)
> =20
>  static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device=20
> *pwm)  {
> +	int ret;
>  	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
> =20
> -	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
> +	ret =3D clk_prepare_enable(fpc->ipg_clk);

This is confusing because it looks as if you're breaking existing drivers, =
until you realize that...

> +
> +	if ((!ret) && (fpc->has_pwmen)) {
> +		mutex_lock(&fpc->lock);
> +		regmap_update_bits(fpc->regmap, FTM_SC,
> +				BIT(pwm->hwpwm + 16), BIT(pwm->hwpwm + 16));
> +		mutex_unlock(&fpc->lock);
> +	}
> +
> +	return ret;
>  }
> =20
>  static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device=20
> *pwm)  {
>  	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
> =20
> -	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
> +	if (fpc->has_pwmen) {
> +		mutex_lock(&fpc->lock);
> +		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
> +		mutex_unlock(&fpc->lock);
> +	}
> +	clk_disable_unprepare(fpc->ipg_clk);
>  }
> =20
>  static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc, @@=20
> -363,7 +380,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)  {
>  	int ret;
> =20
> -	ret =3D clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
> +	ret =3D clk_prepare_enable(fpc->ipg_clk);
>  	if (ret)
>  		return ret;
> =20
> @@ -371,7 +388,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
>  	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
>  	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
> =20
> -	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
> +	clk_disable_unprepare(fpc->ipg_clk);
> =20
>  	return 0;
>  }
> @@ -428,6 +445,10 @@ static int fsl_pwm_probe(struct platform_device *pde=
v)
>  		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
>  	}
> =20
> +	fpc->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(fpc->ipg_clk))
> +		fpc->ipg_clk =3D fpc->clk[FSL_PWM_CLK_SYS];

... fpc->ipg_clk is actually the same as fpc->clk[FSL_PWM_CLK_SYS] for olde=
r chips. I think this could be made more obvious by splitting this patch in=
to several smaller ones as suggested above.

> +
>  	fpc->clk[FSL_PWM_CLK_FIX] =3D devm_clk_get(fpc->chip.dev, "ftm_fix");
>  	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
>  		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
> @@ -446,6 +467,8 @@ static int fsl_pwm_probe(struct platform_device *pdev=
)
>  	fpc->chip.of_pwm_n_cells =3D 3;
>  	fpc->chip.base =3D -1;
>  	fpc->chip.npwm =3D 8;
> +	fpc->has_pwmen =3D of_property_read_bool(pdev->dev.of_node,
> +						"fsl,ftm-has-pwmen-bits");

As I said earlier, I think this should be derived from the compatible strin=
g. That is, you could have a data structure such as:

	struct fsl_pwm_soc {
		bool has_enable_bits;
	};

	static const struct fsl_pwm_soc vf610_ftm_pwm =3D {
		.has_enable_bits =3D false,
	};

	/* up to here would be part of patch 2 */

	/* and this is part of patch 3, along with an entry in the OF
	 * match table */
	static const struct fsl_pwm_soc imx8x_ftm_pwm =3D {
		.has_enable_bits =3D true,
	};

Thierry
