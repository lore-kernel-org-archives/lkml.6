Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEDCJV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:09:21 -0400
Received: from mail-db5eur01on0126.outbound.protection.outlook.com ([104.47.2.126]:52718
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751133AbeEDCJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:09:20 -0400
From: "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC: "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "Bos, Ties (Nokia - US/Sunnyvale)" <ties.bos@nokia.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jagdish.gediya@nxp.com" <jagdish.gediya@nxp.com>,
        "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>
Subject: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
Thread-Topic: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
Thread-Index: AdPjS6BOyzx+JncvRVev7BlGcLIb5g==
Date: Fri, 4 May 2018 02:09:12 +0000
Message-ID: <VI1PR07MB161553DA5D3EF35C9052B1CA81860@VI1PR07MB1615.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
x-originating-ip: [131.228.32.191]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB1630;7:5C5jYUMO5TqkNFRCcYOqAcP9Dtzz96lgpuTYZKRI1cMqiosbX68UXsBtDoQykP2oyV0J3khtazJiLEM15G7qzzcLVRiDPpmwa317iGOthIOTOEAZdG1zeSLpmmKxgMF9fg3xEM73IQSIWRUDNwcJTEZZ7S8k+q2PhHUsTXcZQH7lBkNG0OO2Tp6Lvfc23xLpZf+RxXkXQkM1Iuj8JDycN73rzCHVA+carVFYGxmtjcBVDjmJUL7MrBJSddSrI+F/
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(49563074)(7193020);SRVR:VI1PR07MB1630;
x-ms-traffictypediagnostic: VI1PR07MB1630:
x-microsoft-antispam-prvs: <VI1PR07MB16309108F8FDC94D9AFEC98F81860@VI1PR07MB1630.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(82608151540597)(85827821059158)(109105607167333)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(11241501184)(806099)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR07MB1630;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1630;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(396003)(346002)(39380400002)(13464003)(199004)(189003)(6116002)(3846002)(54906003)(14454004)(81166006)(5660300001)(186003)(110136005)(316002)(8676002)(66066001)(81156014)(25786009)(9686003)(68736007)(55016002)(2906002)(7736002)(305945005)(99936001)(478600001)(7416002)(6436002)(97736004)(53936002)(33656002)(74316002)(486006)(105586002)(8656006)(86362001)(5890100001)(5250100002)(7696005)(99286004)(53546011)(476003)(102836004)(3660700001)(3280700002)(2900100001)(8936002)(39060400002)(106356001)(6506007)(4326008)(26005)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1630;H:VI1PR07MB1615.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KeWEQrl1biby+MqdzF1Y4Fo3nKDfVHrO2qJYVWZ8zoalwv1ppFIIkQG3ZiGnKb0G0JaozrzMWIMXKv/Xpv3nve1dtbhUM1EXOnXCIGZ0Y9pd9SiGqqo8jubsbBbDvKRCP8eNX6O4ggU63yEnHOw1kOixIAofKvBsJ6PfCTRZ01LsTOZvtNDEsffL1a3I4IeHBl8zud96gkB1i5BvVver6eJxZEPtIQdqnVAELZeK4YyZ15ht9g+HjWt8TVnlCUeV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/mixed;
        boundary="_002_VI1PR07MB161553DA5D3EF35C9052B1CA81860VI1PR07MB1615eurp_"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 276d74d1-8a61-435a-57cb-08d5b16407c8
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276d74d1-8a61-435a-57cb-08d5b16407c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 02:09:12.6217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1630
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_VI1PR07MB161553DA5D3EF35C9052B1CA81860VI1PR07MB1615eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

The following is the reposting of patch with v2 version indication based on=
 comment on "[PATCH 1/2]" (also in the attachment).

Subject: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter

Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
CRC values, the bit-wise majority may be used to recover the contents of
the parameter pages from the parameter page copies present.

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
 drivers/mtd/nand/raw/nand_base.c |   36 ++++++++++++++++++++++++++++++----=
--
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_b=
ase.c
index 72f3a89..464c4fb 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5086,6 +5086,8 @@ static int nand_flash_detect_ext_param_page(struct na=
nd_chip *chip,
 	return ret;
 }
=20
+#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
+
 /*
  * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwi=
se.
  */
@@ -5094,7 +5096,8 @@ static int nand_flash_detect_onfi(struct nand_chip *c=
hip)
 	struct mtd_info *mtd =3D nand_to_mtd(chip);
 	struct nand_onfi_params *p;
 	char id[4];
-	int i, ret, val;
+	int i, ret, val, pagesize;
+	u8 *buf;
=20
 	/* Try ONFI for unknown chip or LP */
 	ret =3D nand_readid_op(chip, 0x20, id, sizeof(id));
@@ -5102,8 +5105,9 @@ static int nand_flash_detect_onfi(struct nand_chip *c=
hip)
 		return 0;
=20
 	/* ONFI chip: allocate a buffer to hold its parameter page */
-	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
+	pagesize =3D sizeof(*p);
+	buf =3D kzalloc((pagesize * 3), GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
=20
 	ret =3D nand_read_param_page_op(chip, 0, NULL, 0);
@@ -5113,7 +5117,8 @@ static int nand_flash_detect_onfi(struct nand_chip *c=
hip)
 	}
=20
 	for (i =3D 0; i < 3; i++) {
-		ret =3D nand_read_data_op(chip, p, sizeof(*p), true);
+		p =3D (struct nand_onfi_params *)&buf[i*pagesize];
+		ret =3D nand_read_data_op(chip, p, pagesize, true);
 		if (ret) {
 			ret =3D 0;
 			goto free_onfi_param_page;
@@ -5126,8 +5131,27 @@ static int nand_flash_detect_onfi(struct nand_chip *=
chip)
 	}
=20
 	if (i =3D=3D 3) {
-		pr_err("Could not find valid ONFI parameter page; aborting\n");
-		goto free_onfi_param_page;
+		int j, k, l;
+		u8 v, m;
+
+		pr_err("Could not find valid ONFI parameter page\n");
+		pr_info("Recover ONFI params with bit-wise majority\n");
+		for (j =3D 0; j < pagesize; j++) {
+			v =3D 0;
+			for (k =3D 0; k < 8; k++) {
+				m =3D 0;
+				for (l =3D 0; l < 3; l++)
+					m +=3D GET_BIT(k, buf[l*pagesize + j]);
+				if (m > 1)
+					v |=3D BIT(k);
+			}
+			((u8 *)p)[j] =3D v;
+		}
+		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) !=3D
+				le16_to_cpu(p->crc)) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			goto free_onfi_param_page;
+		}
 	}
=20
 	/* Check version */
--=20
1.7.9.5

Thanks.
Jane

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Wednesday, May 02, 2018 3:32 AM
> To: Wan, Jane (Nokia - US/Sunnyvale) <jane.wan@nokia.com>
> Cc: dwmw2@infradead.org; computersforpeace@gmail.com; Bos, Ties (Nokia -
> US/Sunnyvale) <ties.bos@nokia.com>; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] Use bit-wise majority to recover the contents of=
 ONFI
> parameter
>=20
> On Wed, 2 May 2018 12:25:45 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>=20
> > Hi Jane,
> >
> > On Thu, 26 Apr 2018 17:19:56 -0700
> > Jane Wan <Jane.Wan@nokia.com> wrote:
> >
> > > Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> > > ---
> > >  drivers/mtd/nand/nand_base.c |   35 +++++++++++++++++++++++++++++++-
> ---
> > >  1 file changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/nand_base.c
> > > b/drivers/mtd/nand/nand_base.c index c2e1232..161b523 100644
> > > --- a/drivers/mtd/nand/nand_base.c
> > > +++ b/drivers/mtd/nand/nand_base.c
> > > @@ -3153,8 +3153,10 @@ static int nand_flash_detect_onfi(struct
> mtd_info *mtd, struct nand_chip *chip,
> > >  					int *busw)
> > >  {
> > >  	struct nand_onfi_params *p =3D &chip->onfi_params;
> > > -	int i, j;
> > > -	int val;
> > > +	int i, j, k, len, val;
> > > +	uint8_t copy[3][256], v8;
> > > +
> > > +	len =3D (sizeof(*p) > 256) ? 256 : sizeof(*p);
> > >
> > >  	/* Try ONFI for unknown chip or LP */
> > >  	chip->cmdfunc(mtd, NAND_CMD_READID, 0x20, -1); @@ -3170,11
> > > +3172,36 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, s=
truct
> nand_chip *chip,
> > >  				le16_to_cpu(p->crc)) {
> > >  			break;
> > >  		}
> > > +		pr_err("CRC of parameter page %d is not valid\n", i);
> > > +		for (j =3D 0; j < len; j++)
> > > +			copy[i][j] =3D ((uint8_t *)p)[j];
> > >  	}
> > >
> > >  	if (i =3D=3D 3) {
> > > -		pr_err("Could not find valid ONFI parameter page; aborting\n");
> > > -		return 0;
> > > +		pr_err("Could not find valid ONFI parameter page\n");
> > > +		pr_info("Recover ONFI parameters with bit-wise majority\n");
> > > +		for (j =3D 0; j < len; j++) {
> > > +			if (copy[0][j] =3D=3D copy[1][j] ||
> > > +			    copy[0][j] =3D=3D copy[2][j]) {
> > > +				((uint8_t *)p)[j] =3D copy[0][j];
> > > +			} else if (copy[1][j] =3D=3D copy[2][j]) {
> > > +				((uint8_t *)p)[j] =3D copy[1][j];
> > > +			} else {
> > > +				((uint8_t *)p)[j] =3D 0;
> > > +				for (k =3D 0; k < 8; k++) {
> > > +					v8 =3D (copy[0][j] >> k) & 0x1;
> > > +					v8 +=3D (copy[1][j] >> k) & 0x1;
> > > +					v8 +=3D (copy[2][j] >> k) & 0x1;
> > > +					if (v8 > 1)
> > > +						((uint8_t *)p)[j] |=3D (1 << k);
> > > +				}
> > > +			}
> > > +		}
> >
> > I'd like this bit-wise majority algorithm to be generic and moved to
> > nand_base.c, because we might want to do the same in the core and make
> > it work for any number of repetitions of the PARAM page.
>=20
> Never mind, I thought you were implementing that in the FSL IFC driver, b=
ut
> you're actually modifying the core.

--_002_VI1PR07MB161553DA5D3EF35C9052B1CA81860VI1PR07MB1615eurp_
Content-Type: application/octet-stream;
	name="0002-mtd-rawnand-fsl_ifc-use-bit-wise-majority-to-recover.patch"
Content-Description: 0002-mtd-rawnand-fsl_ifc-use-bit-wise-majority-to-recover.patch
Content-Disposition: attachment;
	filename="0002-mtd-rawnand-fsl_ifc-use-bit-wise-majority-to-recover.patch";
	size=2894; creation-date="Fri, 04 May 2018 02:01:29 GMT";
	modification-date="Fri, 04 May 2018 01:04:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMTRlZDdkYzA4Mjk2YTUyZjgxZDE0NzgxZGVlMmY0NTVkZDkwYmJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW5lIFdhbiA8SmFuZS5XYW5Abm9raWEuY29tPgpEYXRlOiBN
b24sIDMwIEFwciAyMDE4IDE0OjA1OjQwIC0wNzAwClN1YmplY3Q6IFtQQVRDSCB2MiAyLzJdIG10
ZDogcmF3bmFuZDogZnNsX2lmYzogdXNlIGJpdC13aXNlIG1ham9yaXR5IHRvCiByZWNvdmVyIHRo
ZSBjb250ZW50cyBvZiBPTkZJIHBhcmFtZXRlcgoKUGVyIE9ORkkgc3BlY2lmaWNhdGlvbiAoUmV2
LiA0LjApLCBpZiBhbGwgcGFyYW1ldGVyIHBhZ2VzIGhhdmUgaW52YWxpZApDUkMgdmFsdWVzLCB0
aGUgYml0LXdpc2UgbWFqb3JpdHkgbWF5IGJlIHVzZWQgdG8gcmVjb3ZlciB0aGUgY29udGVudHMg
b2YKdGhlIHBhcmFtZXRlciBwYWdlcyBmcm9tIHRoZSBwYXJhbWV0ZXIgcGFnZSBjb3BpZXMgcHJl
c2VudC4KClNpZ25lZC1vZmYtYnk6IEphbmUgV2FuIDxKYW5lLldhbkBub2tpYS5jb20+Ci0tLQog
ZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMgfCAgIDM2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNl
LmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jhc2UuYwppbmRleCA3MmYzYTg5Li40NjRj
NGZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jhc2UuYworKysgYi9k
cml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jhc2UuYwpAQCAtNTA4Niw2ICs1MDg2LDggQEAgc3Rh
dGljIGludCBuYW5kX2ZsYXNoX2RldGVjdF9leHRfcGFyYW1fcGFnZShzdHJ1Y3QgbmFuZF9jaGlw
ICpjaGlwLAogCXJldHVybiByZXQ7CiB9CiAKKyNkZWZpbmUgR0VUX0JJVChiaXQsIHZhbCkgICAo
KCh2YWwpID4+IChiaXQpKSAmIDB4MDEpCisKIC8qCiAgKiBDaGVjayBpZiB0aGUgTkFORCBjaGlw
IGlzIE9ORkkgY29tcGxpYW50LCByZXR1cm5zIDEgaWYgaXQgaXMsIDAgb3RoZXJ3aXNlLgogICov
CkBAIC01MDk0LDcgKzUwOTYsOCBAQCBzdGF0aWMgaW50IG5hbmRfZmxhc2hfZGV0ZWN0X29uZmko
c3RydWN0IG5hbmRfY2hpcCAqY2hpcCkKIAlzdHJ1Y3QgbXRkX2luZm8gKm10ZCA9IG5hbmRfdG9f
bXRkKGNoaXApOwogCXN0cnVjdCBuYW5kX29uZmlfcGFyYW1zICpwOwogCWNoYXIgaWRbNF07Ci0J
aW50IGksIHJldCwgdmFsOworCWludCBpLCByZXQsIHZhbCwgcGFnZXNpemU7CisJdTggKmJ1ZjsK
IAogCS8qIFRyeSBPTkZJIGZvciB1bmtub3duIGNoaXAgb3IgTFAgKi8KIAlyZXQgPSBuYW5kX3Jl
YWRpZF9vcChjaGlwLCAweDIwLCBpZCwgc2l6ZW9mKGlkKSk7CkBAIC01MTAyLDggKzUxMDUsOSBA
QCBzdGF0aWMgaW50IG5hbmRfZmxhc2hfZGV0ZWN0X29uZmkoc3RydWN0IG5hbmRfY2hpcCAqY2hp
cCkKIAkJcmV0dXJuIDA7CiAKIAkvKiBPTkZJIGNoaXA6IGFsbG9jYXRlIGEgYnVmZmVyIHRvIGhv
bGQgaXRzIHBhcmFtZXRlciBwYWdlICovCi0JcCA9IGt6YWxsb2Moc2l6ZW9mKCpwKSwgR0ZQX0tF
Uk5FTCk7Ci0JaWYgKCFwKQorCXBhZ2VzaXplID0gc2l6ZW9mKCpwKTsKKwlidWYgPSBremFsbG9j
KChwYWdlc2l6ZSAqIDMpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIWJ1ZikKIAkJcmV0dXJuIC1FTk9N
RU07CiAKIAlyZXQgPSBuYW5kX3JlYWRfcGFyYW1fcGFnZV9vcChjaGlwLCAwLCBOVUxMLCAwKTsK
QEAgLTUxMTMsNyArNTExNyw4IEBAIHN0YXRpYyBpbnQgbmFuZF9mbGFzaF9kZXRlY3Rfb25maShz
dHJ1Y3QgbmFuZF9jaGlwICpjaGlwKQogCX0KIAogCWZvciAoaSA9IDA7IGkgPCAzOyBpKyspIHsK
LQkJcmV0ID0gbmFuZF9yZWFkX2RhdGFfb3AoY2hpcCwgcCwgc2l6ZW9mKCpwKSwgdHJ1ZSk7CisJ
CXAgPSAoc3RydWN0IG5hbmRfb25maV9wYXJhbXMgKikmYnVmW2kqcGFnZXNpemVdOworCQlyZXQg
PSBuYW5kX3JlYWRfZGF0YV9vcChjaGlwLCBwLCBwYWdlc2l6ZSwgdHJ1ZSk7CiAJCWlmIChyZXQp
IHsKIAkJCXJldCA9IDA7CiAJCQlnb3RvIGZyZWVfb25maV9wYXJhbV9wYWdlOwpAQCAtNTEyNiw4
ICs1MTMxLDI3IEBAIHN0YXRpYyBpbnQgbmFuZF9mbGFzaF9kZXRlY3Rfb25maShzdHJ1Y3QgbmFu
ZF9jaGlwICpjaGlwKQogCX0KIAogCWlmIChpID09IDMpIHsKLQkJcHJfZXJyKCJDb3VsZCBub3Qg
ZmluZCB2YWxpZCBPTkZJIHBhcmFtZXRlciBwYWdlOyBhYm9ydGluZ1xuIik7Ci0JCWdvdG8gZnJl
ZV9vbmZpX3BhcmFtX3BhZ2U7CisJCWludCBqLCBrLCBsOworCQl1OCB2LCBtOworCisJCXByX2Vy
cigiQ291bGQgbm90IGZpbmQgdmFsaWQgT05GSSBwYXJhbWV0ZXIgcGFnZVxuIik7CisJCXByX2lu
Zm8oIlJlY292ZXIgT05GSSBwYXJhbXMgd2l0aCBiaXQtd2lzZSBtYWpvcml0eVxuIik7CisJCWZv
ciAoaiA9IDA7IGogPCBwYWdlc2l6ZTsgaisrKSB7CisJCQl2ID0gMDsKKwkJCWZvciAoayA9IDA7
IGsgPCA4OyBrKyspIHsKKwkJCQltID0gMDsKKwkJCQlmb3IgKGwgPSAwOyBsIDwgMzsgbCsrKQor
CQkJCQltICs9IEdFVF9CSVQoaywgYnVmW2wqcGFnZXNpemUgKyBqXSk7CisJCQkJaWYgKG0gPiAx
KQorCQkJCQl2IHw9IEJJVChrKTsKKwkJCX0KKwkJCSgodTggKilwKVtqXSA9IHY7CisJCX0KKwkJ
aWYgKG9uZmlfY3JjMTYoT05GSV9DUkNfQkFTRSwgKHVpbnQ4X3QgKilwLCAyNTQpICE9CisJCQkJ
bGUxNl90b19jcHUocC0+Y3JjKSkgeworCQkJcHJfZXJyKCJPTkZJIHBhcmFtZXRlciByZWNvdmVy
eSBmYWlsZWQsIGFib3J0aW5nXG4iKTsKKwkJCWdvdG8gZnJlZV9vbmZpX3BhcmFtX3BhZ2U7CisJ
CX0KIAl9CiAKIAkvKiBDaGVjayB2ZXJzaW9uICovCi0tIAoxLjcuOS41Cgo=

--_002_VI1PR07MB161553DA5D3EF35C9052B1CA81860VI1PR07MB1615eurp_--
