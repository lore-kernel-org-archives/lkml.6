Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeEJVh0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:37:26 -0400
Received: from mail-eopbgr20096.outbound.protection.outlook.com ([40.107.2.96]:5137
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752298AbeEJVhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:37:24 -0400
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
Subject: RE: [PATCH v5 2/2] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
Thread-Topic: [PATCH v5 2/2] mtd: rawnand: use bit-wise majority to recover
 the contents of ONFI parameter
Thread-Index: AQHT6Akyg7lRMIryBkioQPi9krQIN6Qo3amAgACenvA=
Date: Thu, 10 May 2018 21:37:19 +0000
Message-ID: <VI1PR07MB161596607D2DF2CE52DF01E881980@VI1PR07MB1615.eurprd07.prod.outlook.com>
References: <1525920400-11392-1-git-send-email-Jane.Wan@nokia.com>
 <20180510140311.02805561@bbrezillon>
In-Reply-To: <20180510140311.02805561@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-originating-ip: [131.228.32.160]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB3232;7:OBell9yZDxVltB+8UVjxYdxkzJjz8qUO1c5x8ywtQR4XF8XQWxA6rqPC2I+fIlZVIPUM+/YNnvymDqYRSOQi/iHAhAe78Xc1674EAlNkRQT0FGDs6K5cNrlmqM6p+t8D/ri6WfB25+FJKeF+uTGaV8pg1Q8fYgjNE76Qg+k33vhHcCN433hhjJgx8QM5QYgjTAB80TVGwaZOSLSWfc9eoR0Y4MG/kxWnK7D8qCExiwTX8s03il66O5wPDDliWq9Q
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(39380400002)(376002)(13464003)(54534003)(199004)(189003)(54906003)(76176011)(66066001)(478600001)(97736004)(86362001)(5250100002)(14454004)(305945005)(7736002)(33656002)(4326008)(3660700001)(102836004)(5660300001)(99286004)(8656006)(81156014)(316002)(7416002)(6916009)(25786009)(74316002)(7696005)(8676002)(446003)(8936002)(2900100001)(11346002)(26005)(81166006)(6506007)(59450400001)(105586002)(6116002)(6436002)(53936002)(3846002)(9686003)(186003)(486006)(53546011)(229853002)(2906002)(6246003)(3280700002)(107886003)(68736007)(476003)(6346003)(39060400002)(55016002)(106356001)(266184004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB3232;H:VI1PR07MB1615.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7193020);SRVR:VI1PR07MB3232;
x-ms-traffictypediagnostic: VI1PR07MB3232:
x-microsoft-antispam-prvs: <VI1PR07MB3232D16C8EC788533D69366A81980@VI1PR07MB3232.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(82608151540597)(85827821059158)(109105607167333)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3232;
x-forefront-prvs: 066898046A
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
x-microsoft-antispam-message-info: QaLFe/XZeMVCJHqZf8hqx7ZshXQiuohYqfRu/k7GH8HiHRq6q4shkQ1oWGAYWyj/JbvHo3mDaPNcisckdmiFreiDVj59eQHBm8Qur+F7NCJw0vj/em9Jyb/lItYTsZo4uVbFZJ+1pAdeuDbIkjdSof7EzV0mxktVm02kl0pkZIaNQEotjF/b9rIZxdeooCGarZ9mU1Pctmpd8s1RJpQFPu/wjHZJcjoemI65OdVdQNJy/zhtwiqrRSjEvZyhU6jM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a0d617b3-a75a-4776-0059-08d5b6be355f
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d617b3-a75a-4776-0059-08d5b6be355f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 21:37:19.6791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3232
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4ALbVnV017649

Hi Boris,

I've sent v6 of the patch based on your comments.

Thanks.
Jane

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, May 10, 2018 5:03 AM
> To: Wan, Jane (Nokia - US/Sunnyvale) <jane.wan@nokia.com>
> Cc: miquel.raynal@bootlin.com; dwmw2@infradead.org;
> computersforpeace@gmail.com; richard@nod.at; marek.vasut@gmail.com;
> yamada.masahiro@socionext.com; prabhakar.kushwaha@nxp.com;
> shawnguo@kernel.org; jagdish.gediya@nxp.com;
> shreeya.patel23498@gmail.com; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org; Bos, Ties (Nokia - US/Sunnyvale) <ties.bos@nokia.com>
> Subject: Re: [PATCH v5 2/2] mtd: rawnand: use bit-wise majority to recover the
> contents of ONFI parameter
> 
> Hi Jane,
> 
> Subject prefix should be "[PATCH v5] ...", the 2/2 is no longer valid since you only
> have one patch here.
> 
> On Wed,  9 May 2018 19:46:40 -0700
> Jane Wan <Jane.Wan@nokia.com> wrote:
> 
> > Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> > CRC values, the bit-wise majority may be used to recover the contents
> > of the parameter pages from the parameter page copies present.
> >
> > Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> > ---
> 
> There should be a changelog here describing what has changed in each version
> of the patch.

[Jane] Added the changelogs in v6.

> 
> >  drivers/mtd/nand/raw/nand_base.c |   46
> +++++++++++++++++++++++++++++++++-----
> >  1 file changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c
> > b/drivers/mtd/nand/raw/nand_base.c
> > index 72f3a89..a7c2507 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -5086,6 +5086,34 @@ static int
> nand_flash_detect_ext_param_page(struct nand_chip *chip,
> >  	return ret;
> >  }
> >
> > +#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
> 
> Not sure we need that macro, see below.

[Jane] Removed.

> 
> > +
> > +/*
> > + * Recover data with bit-wise majority  */ static void
> > +nand_bit_wise_majority(const void **srcbufs,
> > +				   void *dstbuf,
> > +				   unsigned int nbufs,
> > +				   unsigned int bufsize)
> 
> I'd prefer to have nbufs just after srcbufs and named nsrcbufs:
> 
> static void nand_bit_wise_majority(const void **srcbufs,
> 				   unsigned int nsrcbufs,
> 				   void *dstbuf,
> 				   unsigned int bufsize)

[Jane] changed as above in v6.

> 
> > +{
> > +	int i, j, k;
> > +	u8 v, m;
> > +	u8 *p;
> > +
> > +	p = *(u8 **)srcbufs;
> 
> Nope, I'd like to support the cases where srcbufs are not contiguous, so that
> does not work.

[Jane] Changed as you suggested to support non-contiguous srcbufs.

> 
> > +	for (i = 0; i < bufsize; i++) {
> > +		v = 0;
> 
> You can declare the v variable here, since its scope is limited to the for loop.
> BTW, v, m, can't we pick better names? I guess v is for val, but I'm not even sure
> what m stands for.

[Jane] changed the variables to cnt and val in v6.  The "m" was for majority, now changed to cnt (counts for 1s).

> 
> > +		for (j = 0; j < 8; j++) {
> > +			m = 0;
> > +			for (k = 0; k < nbufs; k++)
> > +				m += GET_BIT(j, p[k*bufsize + i]);
> 
> 			for (k = 0; k < nbufs; k++) {
> 				const u8 *srcbuf = srcbufs[j];
> 
> 				if (srcbuf[i] & BIT(k))
> 					m++;
> 			}
> 
> > +			if (m > nbufs/2)
> 
> Space between operands and operators please
> 
> 			if (m > nbufs / 2)

[Jane]  Changed as suggested in v6.  Thanks.

> 
> > +				v |= BIT(j);
> > +		}
> > +		((u8 *)dstbuf)[i] = v;
> > +	}
> > +}
> > +
> >  /*
> >   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
> >   */
> > @@ -5102,7 +5130,7 @@ static int nand_flash_detect_onfi(struct nand_chip
> *chip)
> >  		return 0;
> >
> >  	/* ONFI chip: allocate a buffer to hold its parameter page */
> > -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> > +	p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
> >  	if (!p)
> >  		return -ENOMEM;
> >
> > @@ -5113,21 +5141,29 @@ static int nand_flash_detect_onfi(struct
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
> 
> 		const void *srcbufs[3] = {p, p + 1, p + 2};
> 
> > -		pr_err("Could not find valid ONFI parameter page; aborting\n");
> > -		goto free_onfi_param_page;
> > +		pr_err("Could not find valid ONFI parameter page\n");
> > +		pr_info("Recover ONFI params with bit-wise majority\n");
> > +		nand_bit_wise_majority((const void **)&p, p, 3, sizeof(*p));
> 
> 		nand_bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), p,
> 				       sizeof(*p))

[Jane]  Changed in v6.  Thanks.

> 
> > +		if (onfi_crc16(ONFI_CRC_BASE, (u8 *)p, 254) !=
> > +				le16_to_cpu(p->crc)) {
> > +			pr_err("ONFI parameter recovery failed, aborting\n");
> > +			goto free_onfi_param_page;
> > +		}
> >  	}
> >
> >  	/* Check version */
> 
> Thanks,
> 
> Boris
