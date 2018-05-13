Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeEMEju (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 00:39:50 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com ([40.107.2.133]:45289
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750850AbeEMEjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 00:39:48 -0400
From: "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jagdish.gediya@nxp.com" <jagdish.gediya@nxp.com>,
        "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bos, Ties (Nokia - US/Sunnyvale)" <ties.bos@nokia.com>
Subject: RE: [PATCH v6] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
Thread-Topic: [PATCH v6] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
Thread-Index: AQHT6KXo4TzuZarD/keG5+oMlQBfSqQrwu0AgAFUVsA=
Date: Sun, 13 May 2018 04:39:42 +0000
Message-ID: <VI1PR07MB1615A4F4FAF56D8064F173AA819D0@VI1PR07MB1615.eurprd07.prod.outlook.com>
References: <1525987717-31675-1-git-send-email-Jane.Wan@nokia.com>
 <20180512102040.3e5c2cbe@bbrezillon>
In-Reply-To: <20180512102040.3e5c2cbe@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-originating-ip: [2601:646:8281:8310:f08a:db2e:32f8:9890]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB4269;7:4pl/K5ipsoktV1F7Vx92npHZTxLAqi0gVN2oj/vjQsZ5DcfKaQAUxWsGoOaVDSWnCkjLheGCzEPSt+/sUkkutd5JFtYoOJl4ukMG5eflJVzeaa12AZZLBamHaqjrUefsOZp7ySH4m8irA6epxVz/MsELRDvTLpUleoPoqWdnCq0rTd2ZcZWGhZqHVqkZXzg4lTMOJaJ28LNqX3rNU9AyVLvClWt1isSO8/fx4lCLwSKpvDyiHRMOxVBc8u8LKSl9
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(39860400002)(346002)(366004)(199004)(189003)(13464003)(99286004)(59450400001)(7696005)(3280700002)(76176011)(8656006)(25786009)(6346003)(6506007)(186003)(102836004)(53546011)(7416002)(2906002)(74316002)(46003)(2900100001)(6246003)(86362001)(5250100002)(97736004)(68736007)(316002)(39060400002)(478600001)(5660300001)(3660700001)(9686003)(4326008)(107886003)(53936002)(55016002)(8676002)(81156014)(81166006)(33656002)(8936002)(54906003)(6436002)(105586002)(7736002)(229853002)(106356001)(305945005)(11346002)(446003)(486006)(476003)(6116002)(6916009)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4269;H:VI1PR07MB1615.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7193020);SRVR:VI1PR07MB4269;
x-ms-traffictypediagnostic: VI1PR07MB4269:
x-microsoft-antispam-prvs: <VI1PR07MB42699649FA40DC7C6EFA80C5819D0@VI1PR07MB4269.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(82608151540597)(85827821059158)(109105607167333)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(806099)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR07MB4269;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB4269;
x-forefront-prvs: 0671F32598
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
x-microsoft-antispam-message-info: xSBJfTqB1RhojSHIv7CrmiyZlyJrMK4/HiuoOd9OUaEijYzo1fOzSO/uqghMUOyzJpIcg9xVLvjxyP/Kqrc2Akgd6K4zrFtKMUhIZARFzR6GEP3KsO9WxBT6amht+NnbuEdV7bwhavrUAAeXmSeOhKsc2zES6ggatzRP7YkbUCecugBDOtcMMfnY5BKI1oVw0/sRH//j8y8cdvjek4aO5wQLKshdM5As4fscbk1ODLHNWq08x2iQZGVsUylRrQ58
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c1236444-871a-4d66-8932-08d5b88b8ba9
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1236444-871a-4d66-8932-08d5b88b8ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2018 04:39:42.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4269
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4D4e6Bo023812

Hi Boris,

I've sent v7 of the patch.

Thanks.
Jane

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Saturday, May 12, 2018 1:21 AM
> To: Wan, Jane (Nokia - US/Sunnyvale) <jane.wan@nokia.com>
> Cc: miquel.raynal@bootlin.com; dwmw2@infradead.org;
> computersforpeace@gmail.com; richard@nod.at; marek.vasut@gmail.com;
> yamada.masahiro@socionext.com; prabhakar.kushwaha@nxp.com;
> shawnguo@kernel.org; jagdish.gediya@nxp.com;
> shreeya.patel23498@gmail.com; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org; Bos, Ties (Nokia - US/Sunnyvale) <ties.bos@nokia.com>
> Subject: Re: [PATCH v6] mtd: rawnand: use bit-wise majority to recover the
> contents of ONFI parameter
> 
> On Thu, 10 May 2018 14:28:37 -0700
> Jane Wan <Jane.Wan@nokia.com> wrote:
> 
> > Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> > CRC values, the bit-wise majority may be used to recover the contents
> > of the parameter pages from the parameter page copies present.
> >
> > Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> > ---
> > v6: support the cases that srcbufs are not contiguous
> > v5: make the bit-wise majority functon generic
> > v4: move the bit-wise majority code in a separate function
> > v3: fix warning message detected by kbuild test robot
> > v2: rebase the changes on top of v4.17-rc1
> >
> >  drivers/mtd/nand/raw/nand_base.c |   52
> ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 47 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c
> > b/drivers/mtd/nand/raw/nand_base.c
> > index 72f3a89..acf905c 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -5087,6 +5087,35 @@ static int
> > nand_flash_detect_ext_param_page(struct nand_chip *chip,  }
> >
> >  /*
> > + * Recover data with bit-wise majority  */ static void
> > +nand_bit_wise_majority(const void **srcbufs,
> > +				   unsigned int nsrcbufs,
> > +				   void *dstbuf,
> > +				   unsigned int bufsize)
> > +{
> > +	int i, j, k;
> > +
> > +	for (i = 0; i < bufsize; i++) {
> > +		u8 cnt, val;
> > +
> > +		val = 0;
> > +		for (j = 0; j < 8; j++) {
> > +			cnt = 0;
> > +			for (k = 0; k < nsrcbufs; k++) {
> > +				const u8 *srcbuf = srcbufs[k];
> > +
> > +				if (srcbuf[i] & BIT(j))
> > +					cnt++;
> > +			}
> > +			if (cnt > nsrcbufs / 2)
> > +				val |= BIT(j);
> > +		}
> > +		((u8 *)dstbuf)[i] = val;
> > +	}
> > +}
> > +
> > +/*
> >   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
> >   */
> >  static int nand_flash_detect_onfi(struct nand_chip *chip) @@ -5102,7
> > +5131,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
> >  		return 0;
> >
> >  	/* ONFI chip: allocate a buffer to hold its parameter page */
> > -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> > +	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
> >  	if (!p)
> >  		return -ENOMEM;
> >
> > @@ -5113,21 +5142,34 @@ static int nand_flash_detect_onfi(struct
> nand_chip *chip)
> >  	}
> >
> >  	for (i = 0; i < 3; i++) {
> > -		ret = nand_read_data_op(chip, p, sizeof(*p), true);
> > +		ret = nand_read_data_op(chip, &p[i], sizeof(*p), true);
> >  		if (ret) {
> >  			ret = 0;
> >  			goto free_onfi_param_page;
> >  		}
> >
> > -		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) ==
> > +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)&p[i], 254) ==
> >  				le16_to_cpu(p->crc)) {
> > +			if (i)
> > +				memcpy(p, &p[i], sizeof(*p));
> >  			break;
> >  		}
> >  	}
> >
> >  	if (i == 3) {
> > -		pr_err("Could not find valid ONFI parameter page; aborting\n");
> > -		goto free_onfi_param_page;
> > +		const void *srcbufs[3] = {p, p + 1, p + 2};
> > +
> > +		pr_err("Could not find valid ONFI parameter page\n");
> 
> Maybe pr_warn() here
> 
> > +		pr_info("Recover ONFI params with bit-wise majority\n");
> 
> and maybe you can pack the 2 messages:
> 
> 		pr_warn("Could not find a valid ONFI parameter page, trying
> bit-wise majority to recover it");

[Jane] Changed as suggested.

> 
> > +
> > +		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
> > +				       sizeof(*p));
> > +
> > +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
> > +				le16_to_cpu(p->crc)) {
> > +			pr_err("ONFI parameter recovery failed, aborting\n");
> > +			goto free_onfi_param_page;
> > +		}
> >  	}
> >
> >  	/* Check version */
