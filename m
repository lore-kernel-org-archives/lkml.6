Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756462AbeEJCwH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 22:52:07 -0400
Received: from mail-db5eur01on0108.outbound.protection.outlook.com ([104.47.2.108]:23045
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756118AbeEJCwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 22:52:05 -0400
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
Subject: RE: [PATCH v4 2/2] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
Thread-Topic: [PATCH v4 2/2] mtd: rawnand: use bit-wise majority to recover
 the contents of ONFI parameter
Thread-Index: AQHT5xJwEDIRXNUdfkG1jib9vw/7OKQnc1UAgADRt5A=
Date: Thu, 10 May 2018 02:52:01 +0000
Message-ID: <VI1PR07MB1615E6A80F9EB20DCCABE2DC81980@VI1PR07MB1615.eurprd07.prod.outlook.com>
References: <1525814394-30067-1-git-send-email-Jane.Wan@nokia.com>
        <1525814394-30067-2-git-send-email-Jane.Wan@nokia.com>
 <20180509161928.149a42a7@bbrezillon>
In-Reply-To: <20180509161928.149a42a7@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-originating-ip: [131.228.32.185]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB1053;7:YEdBBsmzwgYhCzAE3CFFbHIIOUwQl5pRVDS/gvpPvpRn4dC+iYt31lIMYdQifUxTY23tH2mtBIbiKxJ8/Vn2AiIPS5563VozAEtLdBsmZ4GIA6gJYfwJXN+o9NyKf8jyRB6YvstliVUiwSrN4y/AuMTojocGKbU8LiSvXGiXB7Eg8XcZ0HnuBgak1mVSXJRfF6dOA3jSGmBbnNXlxVpSvaI2cKvmPPl/m0KcNwbHblHP/6+QkpZTUr5ycpHxBzbk
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(979002)(39860400002)(376002)(346002)(39380400002)(366004)(396003)(13464003)(199004)(189003)(102836004)(305945005)(5250100002)(3846002)(76176011)(446003)(86362001)(2906002)(3660700001)(7416002)(11346002)(476003)(3280700002)(6116002)(486006)(9686003)(8936002)(4326008)(7736002)(5660300001)(8656006)(74316002)(55016002)(6246003)(81156014)(107886003)(8676002)(53546011)(99286004)(26005)(53936002)(54906003)(186003)(6506007)(7696005)(316002)(59450400001)(39060400002)(81166006)(97736004)(33656002)(66066001)(105586002)(25786009)(229853002)(106356001)(6436002)(6916009)(14454004)(2900100001)(68736007)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1053;H:VI1PR07MB1615.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7193020);SRVR:VI1PR07MB1053;
x-ms-traffictypediagnostic: VI1PR07MB1053:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
x-microsoft-antispam-prvs: <VI1PR07MB1053B85AE9F3DBF8048081C581980@VI1PR07MB1053.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(82608151540597)(85827821059158)(109105607167333)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB1053;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1053;
x-forefront-prvs: 066898046A
x-microsoft-antispam-message-info: 6cqscf1g97/n4eYpbsuduXM/N3cokLSUNAetDjHE6lJ//GBfNmhrwJxKMXq5meVM2PpatJqoapjHUFTHRiyiifinpgc/McU4t9Ho+jU9MGCkAqRmTVMmen6tzp2jA9lKF/LcryQnsqh7ppCaIOh+0Vr7Y+JnsNvZj1GnKR1whQlvNntIEQNs2Dc+d10K0I+wot+GEfCxeaecqWqBFE6J7LCygi63Wuw2pFxpZVlMQncCvzszpCBNraSf++FI1xG+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c1f03ff4-f6a0-46a6-0923-08d5b621012a
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f03ff4-f6a0-46a6-0923-08d5b621012a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 02:52:01.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4A2qDjO028097

Hi Boris,

I've sent v5 of the patch based on your comment.

Thanks.
Jane

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Wednesday, May 09, 2018 7:19 AM
> To: Wan, Jane (Nokia - US/Sunnyvale) <jane.wan@nokia.com>
> Cc: miquel.raynal@bootlin.com; dwmw2@infradead.org;
> computersforpeace@gmail.com; richard@nod.at; marek.vasut@gmail.com;
> yamada.masahiro@socionext.com; prabhakar.kushwaha@nxp.com;
> shawnguo@kernel.org; jagdish.gediya@nxp.com;
> shreeya.patel23498@gmail.com; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org; Bos, Ties (Nokia - US/Sunnyvale) <ties.bos@nokia.com>
> Subject: Re: [PATCH v4 2/2] mtd: rawnand: use bit-wise majority to recover the
> contents of ONFI parameter
> 
> On Tue,  8 May 2018 14:19:54 -0700
> Jane Wan <Jane.Wan@nokia.com> wrote:
> 
> > Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> > CRC values, the bit-wise majority may be used to recover the contents
> > of the parameter pages from the parameter page copies present.
> >
> > Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c |   49
> ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 44 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c
> > b/drivers/mtd/nand/raw/nand_base.c
> > index 72f3a89..dfc341c 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -5086,6 +5086,38 @@ static int
> nand_flash_detect_ext_param_page(struct nand_chip *chip,
> >  	return ret;
> >  }
> >
> > +#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
> > +
> > +/*
> > + * Recover NAND parameter page with bit-wise majority  */ static int
> > +onfi_recover_param(struct nand_onfi_params *p, int pages)
> 
> I had something more generic in mind:
> 
> static void nand_bit_wise_majority(const void **srcbufs,
> 				   void *dstbuf,
> 				   unsigned int nbufs,
> 				   unsigned int bufsize)
> {
> 	...
> }
> 
> And then you do the crc check in nand_flash_detect_onfi().
> 
> The reason I'm asking that is because I'm almost sure we'll re-use this functions
> for extended param pages, and also for vendor specific data (we already have a
> byte-wise majority check in the hynix driver, so I wouldn't be surprised if other
> vendors decided to use a bit-wise approach for some of their OTP area).

[Jane] Modified the function as suggested in v5.

> 
> > +{
> > +	int i, j, k;
> > +	u8 v, m;
> > +	u8 *buf;
> > +
> > +	buf = (u8 *)p;
> > +	for (i = 0; i < sizeof(*p); i++) {
> > +		v = 0;
> > +		for (j = 0; j < 8; j++) {
> > +			m = 0;
> > +			for (k = 0; k < pages; k++)
> > +				m += GET_BIT(j, buf[k*sizeof(*p) + i]);
> > +			if (m > pages/2)
> > +				v |= BIT(j);
> > +		}
> > +		((u8 *)p)[i] = v;
> > +	}
> > +
> > +	if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) ==
> > +			le16_to_cpu(p->crc)) {
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
> >   */
> > @@ -5102,7 +5134,7 @@ static int nand_flash_detect_onfi(struct nand_chip
> *chip)
> >  		return 0;
> >
> >  	/* ONFI chip: allocate a buffer to hold its parameter page */
> > -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> > +	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
> >  	if (!p)
> >  		return -ENOMEM;
> >
> > @@ -5113,21 +5145,28 @@ static int nand_flash_detect_onfi(struct
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
> > +		pr_err("Could not find valid ONFI parameter page\n");
> > +		pr_info("Recover ONFI params with bit-wise majority\n");
> > +		ret = onfi_recover_param(p, 3);
> > +		if (ret == 0) {
> > +			pr_err("ONFI parameter recovery failed, aborting\n");
> > +			goto free_onfi_param_page;
> > +		}
> >  	}
> >
> >  	/* Check version */
