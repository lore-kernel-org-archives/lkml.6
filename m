Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeDMV53 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:57:29 -0400
Received: from mail-db5eur01on0065.outbound.protection.outlook.com ([104.47.2.65]:39160
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751042AbeDMV52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:57:28 -0400
From: Han Xu <han.xu@nxp.com>
To: Stefan Agner <stefan@agner.ch>,
        "boris.brezillon@free-electrons.com"
        <boris.brezillon@free-electrons.com>
CC: "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: rawnand: gpmi: add support for specific ECC
 strength
Thread-Topic: [PATCH v2 1/2] mtd: rawnand: gpmi: add support for specific ECC
 strength
Thread-Index: AQHTs/Q84wpDmjjkQE6xK0KKiElbF6P/fOQA
Date: Fri, 13 Apr 2018 21:57:24 +0000
Message-ID: <a82587cc-cccc-40f6-3d27-23a20b3f72c7@nxp.com>
References: <20180304200602.11475-1-stefan@agner.ch>
In-Reply-To: <20180304200602.11475-1-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB1997;7:/uMKRHUNdutUhF9qKy2SqPNIp2o1lEWruPJD3nEKhtXv77Ro50N+d3x9Ed9Do3g5OHfrP23I4yYwGvZHO0Y3GryWthkmniKp1nHy8WIqkO8Q8kdiFwdd2OuaO+SGV1FKG34AJVWydOnKtxoe+Y6jpjWBS22EAZQJleCbxCr9TTwy+hLmNOMxOQSHMEJelbch8xABSUfUkBZshDpeCvZNNfqhjXpcEx4k00Tg8Uy8TBAes2wASPUeVC28DjIdg329
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB1997;
x-ms-traffictypediagnostic: VI1PR0401MB1997:
x-microsoft-antispam-prvs: <VI1PR0401MB1997C825BEA809C384811C2897B30@VI1PR0401MB1997.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0401MB1997;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB1997;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(346002)(366004)(199004)(189003)(486006)(3846002)(6512007)(446003)(26005)(186003)(478600001)(6246003)(53546011)(11346002)(3280700002)(8676002)(3660700001)(25786009)(5660300001)(44832011)(102836004)(31686004)(2501003)(97736004)(5250100002)(105586002)(2900100001)(2906002)(39060400002)(81156014)(8936002)(6506007)(81166006)(4326008)(53936002)(6436002)(316002)(86362001)(36756003)(76176011)(305945005)(31696002)(68736007)(6486002)(110136005)(99286004)(2616005)(476003)(7736002)(6116002)(14454004)(229853002)(106356001)(66066001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB1997;H:VI1PR0401MB2221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TXGc3XRK1qVUYRMUZbC0KkJnwL6TJUpvKMiMx4bcOYX7/obNZE/NFijrkJJrGAn9ofClWM09zKH9WUE/kSTRqM1dxf/wc6blTBGQfUU0koKuL8Tt4xoeD54QECUp9/DB9d/TvPPNoBzUthwKr+7jNUATTWMReapY4pHjcxP4VOCKjaQE9RvlsEreVD1lgqr7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B69A6AE8D13EB4AB49159FE9EB9C566@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fe0521d8-b8f9-4da2-4c5c-08d5a1898a7d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0521d8-b8f9-4da2-4c5c-08d5a1898a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 21:57:24.7914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1997
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3DLvYmF027994



On 03/04/2018 02:06 PM, Stefan Agner wrote:
> Add support for specified ECC strength/size using device tree
> properties nand-ecc-strength/nand-ecc-step-size.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>   drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 61fdd733492f..d04754289c03 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -198,17 +198,16 @@ static inline bool gpmi_check_ecc(struct gpmi_nand_data *this)
>    *
>    * We may have available oob space in this case.
>    */
> -static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
> +static int set_geometry_by_ecc_info(struct gpmi_nand_data *this,
> +				    unsigned int ecc_strength,
> +				    unsigned int ecc_step)
>   {
>   	struct bch_geometry *geo = &this->bch_geometry;
>   	struct nand_chip *chip = &this->nand;
>   	struct mtd_info *mtd = nand_to_mtd(chip);
>   	unsigned int block_mark_bit_offset;
>   
> -	if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
> -		return -EINVAL;
> -
> -	switch (chip->ecc_step_ds) {
> +	switch (ecc_step) {
>   	case SZ_512:
>   		geo->gf_len = 13;
>   		break;
> @@ -221,8 +220,8 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>   			chip->ecc_strength_ds, chip->ecc_step_ds);
>   		return -EINVAL;
>   	}
> -	geo->ecc_chunk_size = chip->ecc_step_ds;
> -	geo->ecc_strength = round_up(chip->ecc_strength_ds, 2);
> +	geo->ecc_chunk_size = ecc_step;
> +	geo->ecc_strength = round_up(ecc_strength, 2);
>   	if (!gpmi_check_ecc(this))
>   		return -EINVAL;
>   
> @@ -230,7 +229,7 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>   	if (geo->ecc_chunk_size < mtd->oobsize) {
>   		dev_err(this->dev,
>   			"unsupported nand chip. ecc size: %d, oob size : %d\n",
> -			chip->ecc_step_ds, mtd->oobsize);
> +			ecc_step, mtd->oobsize);
>   		return -EINVAL;
>   	}
>   
> @@ -423,9 +422,20 @@ static int legacy_set_geometry(struct gpmi_nand_data *this)
>   
>   int common_nfc_set_geometry(struct gpmi_nand_data *this)
>   {
> +	struct nand_chip *chip = &this->nand;
> +
> +	if (chip->ecc.strength > 0 && chip->ecc.size > 0)
> +		return set_geometry_by_ecc_info(this, chip->ecc.strength,
> +						chip->ecc.size);
> +
>   	if ((of_property_read_bool(this->dev->of_node, "fsl,use-minimum-ecc"))
> -				|| legacy_set_geometry(this))
> -		return set_geometry_by_ecc_info(this);
> +				|| legacy_set_geometry(this)) {
> +		if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
> +			return -EINVAL;
> +
> +		return set_geometry_by_ecc_info(this, chip->ecc_strength_ds,
> +						chip->ecc_step_ds);
> +	}
>   
>   	return 0;
>   }
> 

Acked-by: Han Xu <han.xu@nxp.com>
