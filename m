Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88CF223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ShFMAOlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88CF223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbeKOTl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:41:26 -0500
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:2101
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbeKOTl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwhRVPJBRq3oXpj8eNPU+KjXqENf/YnnwyRNizIPKf0=;
 b=ShFMAOlI2fymtwSJfEbdQvW4KM4C+gaMRDiZ8qvEweNlpbe0Uq8+r8xcQhgwhcwL4+k88G9UIiQp0zvrhl3/s0JgIIaHmMHauKQYHtvXWrRyYFN0yqqc8au/KK/2r3QNNVCdFM+W6LEclsnSiT+tRBv5FcvUHfTu1Dfr1sZ40ec=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2559.namprd02.prod.outlook.com (10.168.205.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 15 Nov 2018 09:34:21 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c%6]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 09:34:16 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMg
Date:   Thu, 15 Nov 2018 09:34:16 +0000
Message-ID: <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2559;6:Dq7KSQq0TNAGmJMc3xC3mPWHwbJwA2g3swvdKe9sX7BsYizBuIjlyidNsUBGikKbtGWCGyzKGQD5+4ghY43k1py/jI4SJt9yIbcA6yRm8XgDMfEUOZYBf7duyHzCxl1ShvXjU3/WZg4/fjYT29pIHjagw2hwDMA5D4MxOFtwZl/IkWvyTokOSgt/VxlalM6O1sssAFjg6IZAbD3e+33IKpFrEg/1YTXhbOd11v/IUDJOl2eox+7fvezezCSKT/4N6hdPpAAREhXNTK5FA4SyC+mLcx+9kNB9EWkEjxAZ9ba9P69kJvqExDeGO0QDcUBu66/Zn5CIf0UExZt0seLtxHfmZqVTM1tCptXGUoyIABqlbiVhN9yQf/5CxmFOtovgy30slFLhNeVcOVZ9IGde2iNss3AoFEqw1VJRH+F+nQKURxzzQmHABO6S/lh3rl8nyv5re4Lskrui0Og9Y6/CXw==;5:0CHZ16iaH5zR7CrQe0d8QhnZGlyM7sm5nd7tQEVtb5cOapECRVlUYRiuj5dFBwGib4/gfOvfzzlhJ5TgFVKnK4sPwPH1VasS7R65ydmDHDPqxYPkzrNZ9287fPWt8yg7hMVf8SRUorGuMef2iLY/KkGMirQRvEEmSog4e/DH6qE=;7:TEHr2rxGh9loqtQhLclL0ra/Md8rAMifXwNS7wdeqYkq+rbbgWNNfKNGt/e5Iq51379hrjZ74nWr7Mz8J4YA/j8TqfZosOZ+m5Q9PpzQyAea6mUX4Q4Ma8W4NLwDV6MZ+YKXxY8SFAVJj7982PUyAw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(102836004)(2900100001)(7416002)(99286004)(33656002)(305945005)(5660300001)(3846002)(66066001)(6116002)(7736002)(229853002)(81166006)(74316002)(81156014)(8676002)(2906002)(8936002)(9686003)(6436002)(55016002)(86362001)(7696005)(76176011)(26005)(476003)(110136005)(446003)(186003)(2501003)(54906003)(106356001)(11346002)(105586002)(97736004)(53936002)(14454004)(6246003)(316002)(486006)(107886003)(39060400002)(6506007)(478600001)(217873002)(71190400001)(71200400001)(4326008)(68736007)(25786009)(2201001)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2559;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: bcac9274-6590-45e3-38fb-08d64add833f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2559;
x-ms-traffictypediagnostic: MWHPR02MB2559:
x-microsoft-antispam-prvs: <MWHPR02MB2559D0E59530CAA78BB14DD2AFDC0@MWHPR02MB2559.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2559;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2559;
x-forefront-prvs: 08572BD77F
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p6BwmY1Fac5LfSWo2y8Fnm1ZCxxgNR0xrv/y4t84DBnVJDvyhPMjr1UmH7J03SIZlnG2qmF3xPRkaYfcWuPCHxncNowmqT88pBXdPCJ/XsudeYizcpDPcY1Gi02BRiavGsvO1lbGpy+gFwE1R3iNlYQXlrh6d6dkbQji3w1iIHeBv8AtBTWsgS0jl9BX1p8MK17LYdXzOYOrIb+HaC3cb2XeoacA+RKrf5NuWyt2Pfp9IFlTGKEaV7W7Wn1zfDB/S9nsGy7WxK3dUXYFovMVIuZJZBf3JhX6EDF2GZjn0hnEP+pdb46vfhRYALpzyEkWPf4r+y6lFwUmCKMoo1L8WUG3bMJFXEOYfI3nPSKokzU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcac9274-6590-45e3-38fb-08d64add833f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 09:34:16.8399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris & Miquel,

I am updating the driver by addressing your comments, and I have one concer=
n,  especially in anfc_read_page_hwecc(),=20
there I am checking for erased pages bit flips.
Since Arasan NAND controller doesn't have multibit error detection beyond 2=
4-bit( it can correct up to 24 bit),
i.e. there is no indication from controller to detect uncorrectable error b=
eyond 24bit.
So I took some error count as default value(MULTI_BIT_ERR_CNT  16, I put th=
is based on the error count that=20
I got while reading erased page on Micron device).
And during a page read, will just read the error count register and compare=
 this value with the default error count(16) and if it is more=20
Than default then I am checking for erased page bit flips.
I am doubting that this will not work in all cases.
In my case it is just working because the error count that it got on an era=
sed page is 16.
Could you please suggest a way to do detect erased_page bit flips when read=
ing a page with HW-ECC?.

> +
> +/*
> + * Arasan NAND controller can't detect errors beyond 24-bit in BCH
> + * For an erased page we observed that multibit error count as 16
> + * with 24-bit ECC. so if the count is equal to or greater than 16
> + * then we can say that its an uncorrectable ECC error.
> + */
> +#define MULTI_BIT_ERR_CNT 16
> +
>=20
> +}
> +
> +static int anfc_read_page_hwecc(struct nand_chip *chip, u8 *buf,
> +				int oob_required, int page)
> +{
> +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u8 *ecc_code =3D chip->ecc.code_buf;
> +	u8 *p;
> +	int eccsize =3D chip->ecc.size;
> +	int eccbytes =3D chip->ecc.bytes;
> +	int stat =3D 0, i;
> +	u32 ret;
> +	unsigned int max_bitflips =3D 0;
> +	u32 eccsteps =3D chip->ecc.steps;
> +	u32 one_bit_err =3D 0, multi_bit_err =3D 0;
> +
> +	anfc_set_eccsparecmd(nfc, achip, NAND_CMD_RNDOUT,
> NAND_CMD_RNDOUTSTART);
> +	anfc_config_ecc(nfc, true);
> +
> +	ret =3D nand_read_page_op(chip, page, 0, buf, mtd->writesize);
> +	if (ret)
> +		return ret;
> +
> +	anfc_config_ecc(nfc, false);
> +	if (achip->strength) {
> +		/*
> +		 * In BCH mode Arasan NAND controller can correct ECC upto
> +		 * 24-bit Beyond that, it can't even detect errors.
> +		 */
> +		multi_bit_err =3D readl(nfc->base + ECC_ERR_CNT_OFST);
> +		multi_bit_err =3D ((multi_bit_err & PAGE_ERR_CNT_MASK) >> 8);
> +	} else {
> +		/*
> +		 * In Hamming mode Arasan NAND controller can correct ECC upto
> +		 * 1-bit and can detect upto 2-bit errors.
> +		 */
> +		one_bit_err =3D readl(nfc->base + ECC_ERR_CNT_1BIT_OFST);
> +		multi_bit_err =3D readl(nfc->base + ECC_ERR_CNT_2BIT_OFST);
> +		/* Clear ecc error count register 1Bit, 2Bit */
> +		writel(0x0, nfc->base + ECC_ERR_CNT_1BIT_OFST);
> +		writel(0x0, nfc->base + ECC_ERR_CNT_2BIT_OFST);
> +	}
> +
> +	if (oob_required)
> +		chip->ecc.read_oob(chip, page);
> +
> +	if (multi_bit_err >=3D MULTI_BIT_ERR_CNT) {
> +		if (!oob_required)
> +			chip->ecc.read_oob(chip, page);
> +
> +		mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
> +					   chip->ecc.total);
> +		p =3D buf;
> +		for (i =3D 0; eccsteps; eccsteps--, i +=3D eccbytes,
> +		     p +=3D eccsize) {
> +			stat =3D nand_check_erased_ecc_chunk(p,
> +							   chip->ecc.size,
> +							   &ecc_code[i],
> +							   eccbytes,
> +							   NULL, 0,
> +							   chip->ecc.strength);
> +			if (stat < 0) {
> +				mtd->ecc_stats.failed++;
> +			} else {
> +				mtd->ecc_stats.corrected +=3D stat;
> +				max_bitflips =3D max_t(unsigned int, max_bitflips,
> +						     stat);
> +			}
> +		}
> +	}
> +
> +	return max_bitflips;
> +}
> +
> +

Thanks,
Naga Sureshkumar Relli.
