Return-Path: <madalin.bucur@nxp.com>
X-Google-Smtp-Source: AG47ELumQhKoYtX/cjj5E047SSbxprHKuz+Qh/v1VJDsN/HrcEaA95jbDajx+uPkUazWHe9f+SjO
ARC-Seal: i=1; a=rsa-sha256; t=1521437242; cv=none;
        d=google.com; s=arc-20160816;
        b=D+tL3cZy7afEBEdSRTsifGaUq4EAWj/wRZBHsfKvWKp4vIo81wItvKd309x9uoSQnZ
         Qab8fyJP08cI+56CEKTE0Sg1uvgmb8VbRPKpc/yK3dIsyHyxQhsxkBWiCiEmoKjaYxDv
         ir3lyWH+cEJ7DKhqs2XmZ51yvPhppkA/Euv9oCkOLtjylw1dAmb+1+DXDskOYWaluSMU
         IYApr3AFb/Om67PwZ0JpvGLip5WDQIBh3wmOucTE11GBHizNdv5e8NANi3Zi6YYyIIKf
         DzOaJgV8QlMydntWhJaedIrEMfOIl+YBBLr53DaDj6AJwVYCt4ZYkQWNaJCsr1OlClfF
         sxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Y2C8EH69TwLc2NUa9fzJhAZlCgKvPST/G/k126jyD8Y=;
        b=ToTKvh63pVuzZa5y4hqHckfetGDUPo1rIcudPDzExz0Ov2qvFEXnLdRaKePPPH4S//
         f+jp05fli4TogYvRl3nwIPZUpq+rScXuULve2/aSyzBY0CPhjBgmsA97+owMyoXgH0XO
         vv7xtE6f6jIskoY2OgeCMdUnUaT19ch/mspjdzddsKBZQ5L+Wf+aiZDVbUNs2CLakBRb
         GFHbMJB2oQh2LODrOWHf0HX9VCmLUcAHuXWyGeVF9552VpKCqFJC+gHuMMId1lvbO+pM
         VJeDOErpeur7B3D7dpawOfb8QCQhSzRw6BXbutediqduBQpevqSZkmgzgyrCnexNAfTo
         u41Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=eq6MW/X0;
       spf=pass (google.com: domain of madalin.bucur@nxp.com designates 104.47.0.43 as permitted sender) smtp.mailfrom=madalin.bucur@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=eq6MW/X0;
       spf=pass (google.com: domain of madalin.bucur@nxp.com designates 104.47.0.43 as permitted sender) smtp.mailfrom=madalin.bucur@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "James E . J . Bottomley"
	<jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Mark
 Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo
	<tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>,
	Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan
 Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling
	<mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, David
 Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen
	<cyrille.pitchen@wedev4u.fr>, Boris Brezillon
	<boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
	Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn
 Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan
 Wahren <stefan.wahren@i2se.com>
CC: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux1394-devel@lists.sourceforge.net"
	<linux1394-devel@lists.sourceforge.net>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-remoteproc@vger.kernel.org"
	<linux-remoteproc@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devel@driverdev.osuosl.org"
	<devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 10/21] lightnvm: Remove depends on HAS_DMA in case of
 platform dependency
Thread-Topic: [PATCH v2 10/21] lightnvm: Remove depends on HAS_DMA in case of
 platform dependency
Thread-Index: AQHTvTbO3Fftc0MO9kygVrbe1wAP/aPXCvPA
Date: Mon, 19 Mar 2018 05:27:16 +0000
Message-ID: <AM5PR04MB3267989AB6A81639F61AB165ECD40@AM5PR04MB3267.eurprd04.prod.outlook.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-11-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1521208314-4783-11-git-send-email-geert@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
x-originating-ip: [5.12.214.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR04MB3298;7:bLmoim5jZIV0JNynrlAIp1OacylTpscoTL5TBedb/4D70q7iNo5Q3pD46BOWiFq67JGCp/jVCPheVeAy6Zdl60b454ZIW2mZPDqegQlbNf6LA2BUaMsoIOdc9DJQZPceS9hfMJK10SNq5oQBlEDbqSJ8mD3w/njOJlKv4RY/BNeKV/YG3U/3vpTs3aIixNK9+jnTxL8U9Z3VvqKHdrlVHJwzh4HXof3bqgkhLIBZHlkgABpcQPcx/l6iYA/J1UCN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9def5907-190c-49e3-3497-08d58d5a13fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3298;
x-ms-traffictypediagnostic: AM5PR04MB3298:
x-microsoft-antispam-prvs: <AM5PR04MB3298C5E1B8C4B4178F8CAB41ECD40@AM5PR04MB3298.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(143289334528602)(180628864354917)(9452136761055)(85827821059158)(258649278758335)(42262312472803)(58145275503218)(104084551191319)(146099531331640)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR04MB3298;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3298;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39860400002)(396003)(366004)(189003)(199004)(57704003)(13464003)(5660300001)(2900100001)(74316002)(97736004)(8676002)(54906003)(110136005)(81156014)(81166006)(7736002)(305945005)(8936002)(14454004)(59450400001)(26005)(53546011)(68736007)(6506007)(6436002)(7366002)(7416002)(7406005)(3660700001)(186003)(102836004)(478600001)(71446004)(53936002)(99286004)(66066001)(2906002)(2950100002)(9686003)(7696005)(6246003)(3280700002)(105586002)(76176011)(5250100002)(6116002)(55016002)(39060400002)(86362001)(229853002)(4326008)(3846002)(33656002)(106356001)(111086002)(316002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3298;H:AM5PR04MB3267.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: VK9CN+fvvtL3xdJ2wRkfu1Wi8p3LnG7QfDeP4k6en8RsfUhLkxC+f9SKlg6oV/aTS27qiXMbwqtObcBX9DXrFJMMKLxbnbRXjw6q1I+HPPka/t6DBpk/H5f3LOTHdlARHvjNEqwKFjyITFWj0cbcUJdWGhkEvW1BxQzCQV2v72eCtskhoDnxNBqnZoaGqoJ9lgpKczO7+3bCQ6pMuHWcsVNIr7oUP5FHFZeEDYZPY8nip0ArK/rZtgAbMiPjruh9MEoW4KwsihqtAyX2sRKZzWxHDpCmc4ZL+DwxWn/iRHdQuk7PyrVkNPZuH8bAe9anyeDgxObQ8IxDudFkAF207w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9def5907-190c-49e3-3497-08d58d5a13fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 05:27:16.2696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3298
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595106489861540942?=
X-GMAIL-MSGID: =?utf-8?q?1595342578161515433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
> On Behalf Of Geert Uytterhoeven
> Sent: Friday, March 16, 2018 3:52 PM
> To: Christoph Hellwig <hch@lst.de>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Robin Murphy <robin.murphy@arm.com>;
> Felipe Balbi <balbi@kernel.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; James E . J . Bottomley
> <jejb@linux.vnet.ibm.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; Andrew Morton <akpm@linux-
> foundation.org>; Mark Brown <broonie@kernel.org>; Liam Girdwood
> <lgirdwood@gmail.com>; Tejun Heo <tj@kernel.org>; Herbert Xu
> <herbert@gondor.apana.org.au>; David S . Miller <davem@davemloft.net>;
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>; Stefan Richter
> <stefanr@s5r6.in-berlin.de>; Alan Tull <atull@kernel.org>; Moritz Fischer
> <mdf@kernel.org>; Wolfram Sang <wsa@the-dreams.de>; Jonathan Cameron
> <jic23@kernel.org>; Joerg Roedel <joro@8bytes.org>; Matias Bjorling
> <mb@lightnvm.io>; Jassi Brar <jassisinghbrar@gmail.com>; Mauro Carvalho
> Chehab <mchehab@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; David
> Woodhouse <dwmw2@infradead.org>; Brian Norris
> <computersforpeace@gmail.com>; Marek Vasut <marek.vasut@gmail.com>;
> Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Boris Brezillon
> <boris.brezillon@free-electrons.com>; Richard Weinberger <richard@nod.at>=
;
> Kalle Valo <kvalo@codeaurora.org>; Ohad Ben-Cohen <ohad@wizery.com>;
> Bjorn Andersson <bjorn.andersson@linaro.org>; Eric Anholt <eric@anholt.ne=
t>;
> Stefan Wahren <stefan.wahren@i2se.com>
> Cc: iommu@lists.linux-foundation.org; linux-usb@vger.kernel.org; linux-
> scsi@vger.kernel.org; alsa-devel@alsa-project.org; linux-ide@vger.kernel.=
org;
> linux-crypto@vger.kernel.org; linux-fbdev@vger.kernel.org; linux1394-
> devel@lists.sourceforge.net; linux-fpga@vger.kernel.org; linux-
> i2c@vger.kernel.org; linux-iio@vger.kernel.org; linux-block@vger.kernel.o=
rg;
> linux-media@vger.kernel.org; linux-mmc@vger.kernel.org; linux-
> mtd@lists.infradead.org; netdev@vger.kernel.org; linux-
> remoteproc@vger.kernel.org; linux-serial@vger.kernel.org; linux-
> spi@vger.kernel.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; Geert Uytterhoeven <geert@linux-m68k.org>
> Subject: [PATCH v2 10/21] lightnvm: Remove depends on HAS_DMA in case of
> platform dependency
>=20
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on
> another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
>=20
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
>=20
> This simplifies the dependencies, and allows to improve compile-testing.
>=20
> Notes:
>   - FSL_FMAN keeps its dependency on HAS_DMA, as it calls set_dma_ops(),
>     which does not exist if HAS_DMA=3Dn (Do we need a dummy? The use of
>     set_dma_ops() in this driver is questionable),

Hi,

The set_dma_ops() is no longer required in the fsl/fman, I'll send a patch =
to remove it.

Thanks

>   - SND_SOC_LPASS_IPQ806X and SND_SOC_LPASS_PLATFORM loose their
>     dependency on HAS_DMA, as they are selected from
>     SND_SOC_APQ8016_SBC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/lightnvm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index 10c08982185a572f..9c03f35d9df113c6 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -4,7 +4,7 @@
>=20
>  menuconfig NVM
>  	bool "Open-Channel SSD target support"
> -	depends on BLOCK && HAS_DMA && PCI
> +	depends on BLOCK && PCI
>  	select BLK_DEV_NVME
>  	help
>  	  Say Y here to get to enable Open-channel SSDs.
> --
> 2.7.4
