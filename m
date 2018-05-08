Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756011AbeEHV0k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:26:40 -0400
Received: from mail-he1eur01on0115.outbound.protection.outlook.com ([104.47.0.115]:57280
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755975AbeEHV0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:26:37 -0400
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
Subject: RE: [PATCH v3 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter
Thread-Topic: [PATCH v3 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter
Thread-Index: AQHT5iFM6au6Hr/JoEiTOkjp4NR4i6QljCIAgADNGFA=
Date: Tue, 8 May 2018 21:26:31 +0000
Message-ID: <VI1PR07MB1615C323E5C3404A14D5A734819A0@VI1PR07MB1615.eurprd07.prod.outlook.com>
References: <1525710855-8159-1-git-send-email-Jane.Wan@nokia.com>
 <20180508110858.7b1432f5@bbrezillon>
In-Reply-To: <20180508110858.7b1432f5@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-originating-ip: [131.228.32.185]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB1615;7:M6Ka76eyKK9Ab+MrzOzWm2iA1/rqWpZ8b/B78hUKGmUrMmVsj4YQ7ly3J5WYcX1ett/AEDNX37s5aOvdTmowZ+3GTAQRzo7/7Ivmr7f/ARMByrAyO/Yf1/YyU07fGgUEobSsBKAVhXGs5M31YQPlX018Evz+VTg1Dm7SKseL/g8TDpeyEr1K9erU1CjvUVxnbMNXIH3ZVnM0A3pUpFUpHtW/scIUHB2suPjSPAwBHHIHvDK4Opan/A6gT9u8Yzfo
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(376002)(39860400002)(39380400002)(346002)(189003)(199004)(13464003)(51914003)(6506007)(68736007)(107886003)(54906003)(9686003)(7416002)(97736004)(316002)(8936002)(6916009)(6346003)(7736002)(74316002)(39060400002)(86362001)(81166006)(476003)(8656006)(102836004)(59450400001)(33656002)(7696005)(76176011)(305945005)(186003)(53936002)(106356001)(53546011)(81156014)(55016002)(26005)(105586002)(99286004)(8676002)(6246003)(446003)(5660300001)(6436002)(5250100002)(66066001)(229853002)(14454004)(478600001)(486006)(2900100001)(11346002)(3280700002)(4326008)(6116002)(3846002)(2906002)(25786009)(3660700001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1615;H:VI1PR07MB1615.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7193020);SRVR:VI1PR07MB1615;
x-ms-traffictypediagnostic: VI1PR07MB1615:
x-microsoft-antispam-prvs: <VI1PR07MB1615089B9C21FC2A96355C09819A0@VI1PR07MB1615.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(82608151540597)(85827821059158)(109105607167333)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB1615;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1615;
x-forefront-prvs: 0666E15D35
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
x-microsoft-antispam-message-info: jht5IHysU/PsYtkwJgGkDtA3DkWMcYumxQBkMwpeuyk9vhZgpbL2G6ioGhOKGxzGGOBuURAyp7Z6gZfzj8cv4hADRx0PlHKegJ4nZsMDK7b+uxrz3peIK1f3gbnQ/JoWdEryf0EdxZ5didF/YisN1TucIJut9qO4jC0ZV9hqxAbwFpHEstJJoGnbyVjnJvgTmiA+OuGxUSmAresE9eDlboOFLGXft9eRTxSPEsB1vpSEIveFZkqag7kjH9py5kUh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 462a5ede-7d42-41c5-46ab-08d5b52a5e07
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462a5ede-7d42-41c5-46ab-08d5b52a5e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 21:26:31.2171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1615
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48LRD46013567

Hi Boris,

I've sent v4 of the patches based on the comments.

Thanks.
Jane

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, May 08, 2018 2:09 AM
> To: Wan, Jane (Nokia - US/Sunnyvale) <jane.wan@nokia.com>
> Cc: miquel.raynal@bootlin.com; dwmw2@infradead.org;
> computersforpeace@gmail.com; richard@nod.at; marek.vasut@gmail.com;
> yamada.masahiro@socionext.com; prabhakar.kushwaha@nxp.com;
> shawnguo@kernel.org; jagdish.gediya@nxp.com;
> shreeya.patel23498@gmail.com; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org; Bos, Ties (Nokia - US/Sunnyvale) <ties.bos@nokia.com>
> Subject: Re: [PATCH v3 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
> recover the contents of ONFI parameter
> 
> On Mon,  7 May 2018 09:34:15 -0700
> Jane Wan <Jane.Wan@nokia.com> wrote:
> 
> > Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> > CRC values, the bit-wise majority may be used to recover the contents
> > of the parameter pages from the parameter page copies present.
> >
> > Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> 
> I never received patch 1 of this series. When you fix something in a commit,
> please resend the whole patchset, even if other patches haven't changed.

 [Jane] Thanks for the info.  I've sent both patches on v4.

> 
> > ---
> >  drivers/mtd/nand/raw/nand_base.c |   41
> ++++++++++++++++++++++++++++++--------
> >  1 file changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c
> > b/drivers/mtd/nand/raw/nand_base.c
> > index 72f3a89..48f2dec 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -5086,15 +5086,18 @@ static int
> nand_flash_detect_ext_param_page(struct nand_chip *chip,
> >  	return ret;
> >  }
> >
> > +#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
> > +
> >  /*
> >   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
> >   */
> >  static int nand_flash_detect_onfi(struct nand_chip *chip)  {
> >  	struct mtd_info *mtd = nand_to_mtd(chip);
> > -	struct nand_onfi_params *p;
> > +	struct nand_onfi_params *p = NULL;
> >  	char id[4];
> > -	int i, ret, val;
> > +	int i, ret, val, pagesize;
> > +	u8 *buf = NULL;
> >
> >  	/* Try ONFI for unknown chip or LP */
> >  	ret = nand_readid_op(chip, 0x20, id, sizeof(id)); @@ -5102,8 +5105,9
> > @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
> >  		return 0;
> >
> >  	/* ONFI chip: allocate a buffer to hold its parameter page */
> > -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> > -	if (!p)
> > +	pagesize = sizeof(*p);
> > +	buf = kzalloc((pagesize * 3), GFP_KERNEL);
> 
> Not sure why you have to add a new buf variable here, and pagesize is not
> needed either, just use sizeof(*p) directly.

[Jane] Removed buf in v4.

> 
> > +	if (!buf)
> >  		return -ENOMEM;
> >
> >  	ret = nand_read_param_page_op(chip, 0, NULL, 0); @@ -5113,7
> +5117,8
> > @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
> >  	}
> >
> >  	for (i = 0; i < 3; i++) {
> > -		ret = nand_read_data_op(chip, p, sizeof(*p), true);
> > +		p = (struct nand_onfi_params *)&buf[i*pagesize];
> > +		ret = nand_read_data_op(chip, p, pagesize, true);
> >  		if (ret) {
> >  			ret = 0;
> >  			goto free_onfi_param_page;
> > @@ -5126,8 +5131,27 @@ static int nand_flash_detect_onfi(struct nand_chip
> *chip)
> >  	}
> >
> >  	if (i == 3) {
> > -		pr_err("Could not find valid ONFI parameter page; aborting\n");
> > -		goto free_onfi_param_page;
> > +		int j, k, l;
> > +		u8 v, m;
> > +
> > +		pr_err("Could not find valid ONFI parameter page\n");
> > +		pr_info("Recover ONFI params with bit-wise majority\n");
> > +		for (j = 0; j < pagesize; j++) {
> > +			v = 0;
> > +			for (k = 0; k < 8; k++) {
> > +				m = 0;
> > +				for (l = 0; l < 3; l++)
> > +					m += GET_BIT(k, buf[l*pagesize + j]);
> > +				if (m > 1)
> > +					v |= BIT(k);
> > +			}
> > +			((u8 *)p)[j] = v;
> > +		}
> 
> Can you move the bit-wise majority code in a separate function?

[Jane] Done as suggested in v4.

> 
> > +		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) !=
> > +				le16_to_cpu(p->crc)) {
> > +			pr_err("ONFI parameter recovery failed, aborting\n");
> > +			goto free_onfi_param_page;
> > +		}
> >  	}
> >
> >  	/* Check version */
> > @@ -5220,7 +5244,8 @@ static int nand_flash_detect_onfi(struct nand_chip
> *chip)
> >  	       sizeof(p->vendor));
> >
> >  free_onfi_param_page:
> > -	kfree(p);
> > +	if (buf != NULL)
> > +		kfree(buf);
> 
> kfree() already handles the buf == NULL case, no need to check it here.

[Jane]  Removed the check.  Thanks.
 
> 
> >  	return ret;
> >  }
> >
