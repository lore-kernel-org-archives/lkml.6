Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88042082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G5VKJvxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88042082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLDJTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:19:01 -0500
Received: from mail-eopbgr700070.outbound.protection.outlook.com ([40.107.70.70]:23648
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbeLDJTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqtUm04srRCVkOde56VuyfXCGPBPrwfxw+LQmVutdGo=;
 b=G5VKJvxem+I+Cjkucezs7RTdFHwfVNlQ9MIC7EWl7RBQ3uwlvKaGj4Y9EqYxIFSL3yWsUlDGQp0ggUxfv2q2F8JJlfu6mz1w6ZwRetacBYBpe4UiHbkcQpo7qDKXM/bHrjrDXTMPR+clOlqwaWNCi1Kzsw9Bjns7HKlyo1MdaD8=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3247.namprd02.prod.outlook.com (10.164.133.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:18:54 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::95ca:9c47:8102:97b1]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::95ca:9c47:8102:97b1%4]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:18:53 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VY60OAgBWAFRA=
Date:   Tue, 4 Dec 2018 09:18:53 +0000
Message-ID: <MWHPR02MB2623DDF6C43BBBB99A52D5DFAFAF0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20181120172443.5fb0bc14@bbrezillon>
In-Reply-To: <20181120172443.5fb0bc14@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3247;6:mgaq898LMcEnUfGy4eoXjBm3LGL+xDy4+8iYU8ZbF41zboSufhMDuH9Jym+McY3r7h+UKkpTZE+1YKBDOYbibxZS1zmH09ugbstzi1rj3/HpyDqOav0BZtcQdCi4nm34TMjMx84v4Mzogf0uVtw8m2FURwFTGLQQRLiJshKunKL33Q2lFtqHMGbB6xKP7ESqAap1G8zv1Niyki2ZZ6inOs2uw8TSLYBinpwc49pPPkXXCO3qNUDAQs21VWnoKV4kDR/MqlQQuZNtsY9R+IQthexX9BfvBEtoqNc0/rjID17H5lmS6pnEymeCwQ/wxnqiejlYmwIZBQRlZL8knxn5H4ALoieuupCm47WHGnzBLO5coFEZTqSahySaInIv5r9dDxJiL8OXWY/4w355+YEjAWbwI9qSdWqw0UHYNPRiAOcHgmYgV3MQVqvciaX8VQ6lW5OUZCgmXQy+IquYnNRCYA==;5:Zc8yYwVlPOESPUyuWDNaDcEbIuxs1FkOyanEjhMmFTn7WEiyaHRsSQtOuPcPdjMO4RuDxC1Kq8JVIEYIyFFTkOJqJKucnzJzXgkk3grk2H6llp7IoFdNEw4hN6RjWZ7Fql2Pb3YZNMERdfSLhsK4DHKGShrCwv/mfdHKv7cERD4=;7:LAZdB7eSk6G2MXquDjtoBQLV8ZKIg8sJboi448Mp26vvc5sIvY9Pv3/Gr30CXq5pyC0QRV1KIvsDIySRqCfP/6CCfXhU67YbP6bBUAEUSn66RLnouQvtu2lXT0zzsrkS4zKWuHFHffbDdC+h7n1GAw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(199004)(189003)(13464003)(6506007)(26005)(53546011)(25786009)(102836004)(446003)(11346002)(476003)(74316002)(486006)(6916009)(39060400002)(4326008)(478600001)(53936002)(6246003)(7736002)(71200400001)(6436002)(5024004)(14444005)(71190400001)(256004)(229853002)(186003)(217873002)(2906002)(7416002)(5660300001)(54906003)(316002)(7696005)(76176011)(99286004)(305945005)(3846002)(6116002)(86362001)(81166006)(8676002)(81156014)(68736007)(97736004)(8936002)(66066001)(33656002)(14454004)(105586002)(106356001)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3247;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 4b6c66b3-a3b0-49b9-c83d-08d659c982e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3247;
x-ms-traffictypediagnostic: MWHPR02MB3247:
x-microsoft-antispam-prvs: <MWHPR02MB3247A1A824C56387D768F930AFAF0@MWHPR02MB3247.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB3247;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3247;
x-forefront-prvs: 0876988AF0
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D2YRBoru0XFYM7fWRfs4KMu6oxj5IcK0gIlOzFqb7W6oRXNiESSSzm8eTp0iQV52IH15VJ36fgSx5ufydBwfIDI2WQJn1jKuYz6XfZNg/hARdMZgS/qwjqQoiRrAO5SXjwYNtJ2vpiHvzuxueuDfr4ulnefkl6WPhZcRGh5RHG8Y/6tIw7pv5NSacmlpmCBoGn13OCrWJYj4lZWKkGnEVlHlXQVa67TUj58u6YIlX45hUbleMZdIDED3ImVZj75111bGYRS3pIU0JMftdBIybfG+AHkebQ5/r5dKTHmOyN1ZVmvqmDwYZKDNqyIewUttM7dWvuz6oumhK5XRGlQxAyaqxN6GGXIb2669KSUbE9A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6c66b3-a3b0-49b9-c83d-08d659c982e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:18:53.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, November 20, 2018 9:55 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; Michal Simek
> <michals@xilinx.com>; nagasuresh12@gmail.com; linux-mtd@lists.infradead.o=
rg; linux-
> kernel@vger.kernel.org; robh@kernel.org
> Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for =
Arasan
> NAND Flash Controller
>=20
> On Fri, 9 Nov 2018 10:30:41 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > +static int anfc_setup_data_interface(struct nand_chip *chip, int cslin=
e,
> > +				     const struct nand_data_interface *conf) {
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	int err;
> > +	const struct nand_sdr_timings *sdr;
> > +	u32 inftimeval;
> > +	bool change_sdr_clk =3D false;
> > +
> > +	if (csline =3D=3D NAND_DATA_IFACE_CHECK_ONLY)
> > +		return 0;
> > +
> > +	/*
> > +	 * If the controller is already in the same mode as flash device
> > +	 * then no need to change the timing mode again.
> > +	 */
> > +	sdr =3D nand_get_sdr_timings(conf);
> > +	if (IS_ERR(sdr))
> > +		return PTR_ERR(sdr);
> > +
> > +	if (sdr->mode < 0)
> > +		return -ENOTSUPP;
> > +
> > +	inftimeval =3D sdr->mode & 7;
> > +	if (sdr->mode >=3D 2 && sdr->mode <=3D 5)
> > +		change_sdr_clk =3D true;
> > +	/*
> > +	 * SDR timing modes 2-5 will not work for the arasan nand when
> > +	 * freq > 90 MHz, so reduce the freq in SDR modes 2-5 to < 90Mhz
>=20
> What's the freq for mode 0 and 1?
It is 100MHz in SDR mode 0 and 1.

>=20
> > +	 */
> > +	if (change_sdr_clk) {
> > +		clk_disable_unprepare(nfc->clk_sys);
> > +		err =3D clk_set_rate(nfc->clk_sys, SDR_MODE_DEFLT_FREQ);
>=20
> You should not change the clk rate here. It should be done when the chip =
is selected, so that,
> if you ever have 2 different chips connected to the same controller, you =
can adapt the rate
> when they are accessed.
Ok, got it. I will update.

>=20
> > +		if (err) {
> > +			dev_err(nfc->dev, "Can't set the clock rate\n");
> > +			return err;
> > +		}
> > +		err =3D clk_prepare_enable(nfc->clk_sys);
> > +		if (err) {
> > +			dev_err(nfc->dev, "Unable to enable sys clock.\n");
> > +			clk_disable_unprepare(nfc->clk_sys);
> > +			return err;
> > +		}
> > +	}
> > +	achip->inftimeval =3D inftimeval;
> > +
> > +	return 0;
> > +}
> > +
> > +static int anfc_nand_attach_chip(struct nand_chip *chip) {
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	u32 ret;
> > +
> > +	if (mtd->writesize <=3D SZ_512)
> > +		achip->spare_caddr_cycles =3D 1;
> > +	else
> > +		achip->spare_caddr_cycles =3D 2;
> > +
> > +	chip->ecc.calc_buf =3D kmalloc(mtd->oobsize, GFP_KERNEL);
> > +	chip->ecc.code_buf =3D kmalloc(mtd->oobsize, GFP_KERNEL);
>=20
> Those bufs are allocated but never freed (memleak). Also, are you sure yo=
u really need them.
These bufs are freed in nand_release(), which is calling from anfc_remove()=
.

And chip->ecc.code_buf, is used in anfc_read_page_hwecc().
What we are doing here is, extract ECC code from OOB and place it in ecv.co=
de_buf, and passing this info to nand_check_ecc_chunk(buf, chip->ecc.size, =
&ecc_code[i], eccbytes, NULL, 0,chip->ecc.strength).
i.e. just to store ECC code from OOB area.
=20
And chip->ecc.calc_buf is no where used in the driver, I will remove it.

Thanks,
Naga Sureshkumar Relli.

