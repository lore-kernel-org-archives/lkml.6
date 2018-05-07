Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeEGQr0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:47:26 -0400
Received: from mail-eopbgr00094.outbound.protection.outlook.com ([40.107.0.94]:9056
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751923AbeEGQrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:47:24 -0400
From: "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>
To: "Boris.Brezillon@bootlin.com" <Boris.Brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
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
Subject: RE: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter
Thread-Topic: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter
Thread-Index: AQHT4+PD4xS4udvd2kWbK4UyscnOCaQg1r+AgAOlZrA=
Date: Mon, 7 May 2018 16:47:18 +0000
Message-ID: <VI1PR07MB161552E71A13EAE0318008D7819B0@VI1PR07MB1615.eurprd07.prod.outlook.com>
References: <1525464493-5006-2-git-send-email-Jane.Wan@nokia.com>
 <201805051646.R4HISEmo%fengguang.wu@intel.com>
In-Reply-To: <201805051646.R4HISEmo%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
x-originating-ip: [131.228.32.185]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB1727;7:GIOzj8bp2VSRoLs5bBsIwNs2gMNwrZhR+pSsiB7buXdk7DjHkCt6ImDfUQTCFAlgEGBx/9TVLMff/bUbaTc50RS5ulYbJ++zDhJTNIdrDq57n80M8VyXS8nz49sjPlIGzemBxWxhVHg0Tze0hV/POR0ZU1ryaSGiVsvoHbhhAXUM6LJTTkQ0dNyhmb2fOuFRzCybhr35g2YYNadJLJz5p6Xyjbj+dL2+qX+8jEPE1fg5+O9/vKM4k4zIJp2NIEQZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(189003)(199004)(13464003)(377424004)(97736004)(76176011)(102836004)(1720100001)(25786009)(4326008)(6116002)(107886003)(53546011)(39060400002)(478600001)(6246003)(59450400001)(7696005)(6506007)(4001150100001)(229853002)(11346002)(5890100001)(3280700002)(3660700001)(5250100002)(2501003)(486006)(99286004)(19625735003)(2900100001)(110136005)(476003)(446003)(8656006)(316002)(6436002)(54906003)(55016002)(105586002)(966005)(2906002)(106356001)(53936002)(86362001)(66066001)(6306002)(9686003)(3846002)(33656002)(575784001)(53946003)(8676002)(14454004)(81166006)(81156014)(74316002)(345774005)(305945005)(68736007)(7416002)(5660300001)(7736002)(8936002)(186003)(26005)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1727;H:VI1PR07MB1615.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7193020);SRVR:VI1PR07MB1727;
x-ms-traffictypediagnostic: VI1PR07MB1727:
x-microsoft-antispam-prvs: <VI1PR07MB1727042C4FBEF90053A6C3C6819B0@VI1PR07MB1727.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(22074186197030)(166708455590820)(9452136761055)(185117386973197)(82608151540597)(85827821059158)(109105607167333)(788757137089)(258649278758335)(183786458502308);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR07MB1727;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1727;
x-forefront-prvs: 066517B35B
x-microsoft-antispam-message-info: xUvKoyQOXG53lazRqRlBvhLfUUM+rifD45otwCavlYBvAhYhBCuAWae/E9NS/M61u9Ch67oF2O1Dy5hK6BbFHPbRb0YnYslyz2yQkuF2IJYXrYymMQUFA9YkAeh22MbG9dBBNZvUgFSTc8zpwYL7Snc60NuZFv3sjCOBrAWlbhgSleTkRiiINYriqWEWxnrlItOR8vobBKEu4yUkWlimjEsh3Og4p6Xr1GRPf9bXKBD5GKHZlEG9/N5NhWTl0+8D
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8e9fa7ef-55ff-462d-edc9-08d5b43a3206
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9fa7ef-55ff-462d-edc9-08d5b43a3206
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2018 16:47:18.1579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1727
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47GlUNM006113

Hi,

I've sent v3 of this patch through git send-email.  Please also see the inline answer.

Thanks.
Jane

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Saturday, May 05, 2018 1:59 AM
> To: Wan, Jane (Nokia - US/Sunnyvale) <jane.wan@nokia.com>
> Cc: kbuild-all@01.org; Boris.Brezillon@bootlin.com;
> miquel.raynal@bootlin.com; dwmw2@infradead.org;
> computersforpeace@gmail.com; richard@nod.at; marek.vasut@gmail.com;
> yamada.masahiro@socionext.com; prabhakar.kushwaha@nxp.com;
> shawnguo@kernel.org; jagdish.gediya@nxp.com;
> shreeya.patel23498@gmail.com; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org; Bos, Ties (Nokia - US/Sunnyvale)
> <ties.bos@nokia.com>; Wan, Jane (Nokia - US/Sunnyvale)
> <jane.wan@nokia.com>
> Subject: Re: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
> recover the contents of ONFI parameter
> 
> Hi Jane,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mtd/nand/next] [also build test WARNING on
> v4.17-rc3 next-20180504] [if your patch is applied to the wrong git tree, please
> drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jane-Wan/mtd-rawnand-
> fsl_ifc-fix-FSL-NAND-driver-to-read-all-ONFI-parameter-pages/20180505-
> 163132
> base:   git://git.infradead.org/linux-mtd.git nand/next
> config: x86_64-randconfig-x015-201817 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/mtd/nand/raw/nand_base.c: In function 'nand_scan_ident':
> >> drivers/mtd/nand/raw/nand_base.c:5247:2: warning: 'p' may be used
> >> uninitialized in this function [-Wmaybe-uninitialized]
>      kfree(p);
>      ^~~~~~~~
>    drivers/mtd/nand/raw/nand_base.c:5097:27: note: 'p' was declared here
>      struct nand_onfi_params *p;
>                               ^

 [Jane] the kfree() is fixed in v3 patch.  Thanks.
 
> 
> vim +/p +5247 drivers/mtd/nand/raw/nand_base.c
> 
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5090
> d1e1f4e42 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-08-30  5091
> /*
> 8b6e50c9e drivers/mtd/nand/nand_base.c     Brian Norris     2011-05-25  5092   *
> Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5093
> */
> 29a198a15 drivers/mtd/nand/nand_base.c     Boris Brezillon  2016-05-24  5094
> static int nand_flash_detect_onfi(struct nand_chip *chip)
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5095  {
> cbe435a18 drivers/mtd/nand/nand_base.c     Boris Brezillon  2016-05-24  5096
> 	struct mtd_info *mtd = nand_to_mtd(chip);
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5097  	struct nand_onfi_params *p;
> 97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5098
> 	char id[4];
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5099
> 	int i, ret, val, pagesize;
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5100
> 	u8 *buf;
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5101
> 7854d3f74 drivers/mtd/nand/nand_base.c     Brian Norris     2011-06-23  5102
> 	/* Try ONFI for unknown chip or LP */
> 97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5103
> 	ret = nand_readid_op(chip, 0x20, id, sizeof(id));
> 97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5104
> 	if (ret || strncmp(id, "ONFI", 4))
> 97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5105
> 		return 0;
> 97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5106
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5107  	/* ONFI chip: allocate a buffer to hold its parameter page */
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5108
> 	pagesize = sizeof(*p);
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5109
> 	buf = kzalloc((pagesize * 3), GFP_KERNEL);
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5110
> 	if (!buf)
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5111  		return -ENOMEM;
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5112
> 97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5113
> 	ret = nand_read_param_page_op(chip, 0, NULL, 0);
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5114  	if (ret) {
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5115  		ret = 0;
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5116  		goto free_onfi_param_page;
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5117  	}
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5118
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5119
> 	for (i = 0; i < 3; i++) {
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5120
> 		p = (struct nand_onfi_params *)&buf[i*pagesize];
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5121
> 		ret = nand_read_data_op(chip, p, pagesize, true);
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5122  		if (ret) {
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5123  			ret = 0;
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5124  			goto free_onfi_param_page;
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5125  		}
> 97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5126
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5127
> 		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) ==
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5128
> 				le16_to_cpu(p->crc)) {
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5129
> 			break;
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5130
> 		}
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5131
> 	}
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5132
> c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5133
> 	if (i == 3) {
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5134
> 		int j, k, l;
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5135
> 		u8 v, m;
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5136
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5137
> 		pr_err("Could not find valid ONFI parameter page\n");
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5138
> 		pr_info("Recover ONFI params with bit-wise majority\n");
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5139
> 		for (j = 0; j < pagesize; j++) {
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5140
> 			v = 0;
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5141
> 			for (k = 0; k < 8; k++) {
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5142
> 				m = 0;
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5143
> 				for (l = 0; l < 3; l++)
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5144
> 					m += GET_BIT(k, buf[l*pagesize + j]);
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5145
> 				if (m > 1)
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5146
> 					v |= BIT(k);
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5147
> 			}
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5148
> 			((u8 *)p)[j] = v;
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5149
> 		}
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5150
> 		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) !=
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5151
> 				le16_to_cpu(p->crc)) {
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5152
> 			pr_err("ONFI parameter recovery failed, aborting\n");
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5153  			goto free_onfi_param_page;
> c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5154
> 		}
> 2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5155
> 	}
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5156
> 8b6e50c9e drivers/mtd/nand/nand_base.c     Brian Norris     2011-05-25  5157
> 	/* Check version */
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5158
> 	val = le16_to_cpu(p->revision);
> b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5159
> 	if (val & (1 << 5))
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5160  		chip->parameters.onfi.version = 23;
> b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5161
> 	else if (val & (1 << 4))
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5162  		chip->parameters.onfi.version = 22;
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5163
> 	else if (val & (1 << 3))
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5164  		chip->parameters.onfi.version = 21;
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5165
> 	else if (val & (1 << 2))
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5166  		chip->parameters.onfi.version = 20;
> b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5167
> 	else if (val & (1 << 1))
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5168  		chip->parameters.onfi.version = 10;
> b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5169
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5170  	if (!chip->parameters.onfi.version) {
> 20171642e drivers/mtd/nand/nand_base.c     Ezequiel Garcia  2013-11-25  5171
> 		pr_info("unsupported ONFI version: %d\n", val);
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5172  		goto free_onfi_param_page;
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5173  	} else {
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5174  		ret = 1;
> b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5175
> 	}
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5176
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5177
> 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5178
> 	sanitize_string(p->model, sizeof(p->model));
> f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5179  	strncpy(chip->parameters.model, p->model,
> f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5180  		sizeof(chip->parameters.model) - 1);
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5181
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5182
> 	mtd->writesize = le32_to_cpu(p->byte_per_page);
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5183
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5184
> 	/*
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5185
> 	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5186
> 	 * (don't ask me who thought of this...). MTD assumes that these
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5187
> 	 * dimensions will be power-of-2, so just truncate the remaining area.
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5188
> 	 */
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5189
> 	mtd->erasesize = 1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5190
> 	mtd->erasesize *= mtd->writesize;
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5191
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5192
> 	mtd->oobsize = le16_to_cpu(p->spare_bytes_per_page);
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5193
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5194
> 	/* See erasesize comment */
> 4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5195
> 	chip->chipsize = 1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
> 637957551 drivers/mtd/nand/nand_base.c     Matthieu CASTET  2012-03-19
> 5196  	chip->chipsize *= (uint64_t)mtd->erasesize * p->lun_count;
> 13fbd1794 drivers/mtd/nand/nand_base.c     Huang Shijie     2013-09-25  5197
> 	chip->bits_per_cell = p->bits_per_cell;
> e2985fc1d drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5198
> 34da5f5f3 drivers/mtd/nand/nand_base.c     Zach Brown       2017-01-10  5199
> 	chip->max_bb_per_die = le16_to_cpu(p->bb_per_lun);
> 34da5f5f3 drivers/mtd/nand/nand_base.c     Zach Brown       2017-01-10  5200
> 	chip->blocks_per_die = le32_to_cpu(p->blocks_per_lun);
> 34da5f5f3 drivers/mtd/nand/nand_base.c     Zach Brown       2017-01-10  5201
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5202  	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
> 29a198a15 drivers/mtd/nand/nand_base.c     Boris Brezillon  2016-05-24  5203
> 		chip->options |= NAND_BUSWIDTH_16;
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5204
> 10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5205
> 	if (p->ecc_bits != 0xff) {
> 10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5206
> 		chip->ecc_strength_ds = p->ecc_bits;
> 10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5207
> 		chip->ecc_step_ds = 512;
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5208  	} else if (chip->parameters.onfi.version >= 21 &&
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5209  		(le16_to_cpu(p->features) &
> ONFI_FEATURE_EXT_PARAM_PAGE)) {
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5210
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5211
> 		/*
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5212
> 		 * The nand_flash_detect_ext_param_page() uses the
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5213
> 		 * Change Read Column command which maybe not supported
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5214
> 		 * by the chip->cmdfunc. So try to update the chip->cmdfunc
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5215
> 		 * now. We do not replace user supplied command function.
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5216
> 		 */
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5217
> 		if (mtd->writesize > 512 && chip->cmdfunc == nand_command)
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5218
> 			chip->cmdfunc = nand_command_lp;
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5219
> 6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5220
> 		/* The Extended Parameter Page is supported since ONFI 2.1. */
> cbe435a18 drivers/mtd/nand/nand_base.c     Boris Brezillon  2016-05-24  5221
> 		if (nand_flash_detect_ext_param_page(chip, p))
> c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5222
> 			pr_warn("Failed to detect ONFI extended param
> page\n");
> c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5223
> 	} else {
> c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5224
> 		pr_warn("Could not retrieve ONFI ECC requirements\n");
> 10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5225
> 	}
> 10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5226
> f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5227  	/* Save some parameters from the parameter page for future use */
> 789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5228  	if (le16_to_cpu(p->opt_cmd) & ONFI_OPT_CMD_SET_GET_FEATURES) {
> f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5229  		chip->parameters.supports_set_get_features = true;
> 789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5230  		bitmap_set(chip->parameters.get_feature_list,
> 789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5231  			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
> 789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5232  		bitmap_set(chip->parameters.set_feature_list,
> 789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5233  			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
> 789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5234  	}
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5235  	chip->parameters.onfi.tPROG = le16_to_cpu(p->t_prog);
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5236  	chip->parameters.onfi.tBERS = le16_to_cpu(p->t_bers);
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5237  	chip->parameters.onfi.tR = le16_to_cpu(p->t_r);
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5238  	chip->parameters.onfi.tCCS = le16_to_cpu(p->t_ccs);
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5239  	chip->parameters.onfi.async_timing_mode =
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5240  		le16_to_cpu(p->async_timing_mode);
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5241  	chip->parameters.onfi.vendor_revision =
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5242  		le16_to_cpu(p->vendor_revision);
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5243  	memcpy(chip->parameters.onfi.vendor, p->vendor,
> a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5244  	       sizeof(p->vendor));
> f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5245
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5246  free_onfi_param_page:
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> @5247  	kfree(p);
> bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19
> 5248  	return ret;
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5249  }
> 6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5250
> 
> :::::: The code at line 5247 was first introduced by commit
> :::::: bd0b64340c2d66c0fe1aa99b0b23159d7e0c21f2 mtd: rawnand: get rid of
> the ONFI parameter page in nand_chip
> 
> :::::: TO: Miquel Raynal <miquel.raynal@bootlin.com>
> :::::: CC: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
