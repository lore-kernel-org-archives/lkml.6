Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26638ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3F520854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RJsk+oQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3F520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeGWKfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:35:14 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:47428
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388080AbeGWKfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzqlcMeRQ/fFVznUXen9oKuggY5dOhOgdg3XNr4lr0o=;
 b=RJsk+oQ4CE3ysXLgfLfcLugY1+a0wp338U+E2P3ZsL8xp3uo6v0JZDW1lrbLiEyVLsiilQ2ryHQOKZoEuozl0Un1m8g4dcktGXfuqlhR/J8PqwsVIaax1WfNGjIXXlikRtIWh7Uvo74T/tx/8qHWodgc/kNcMeg4tn5KVVt6z5A=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB4479.namprd02.prod.outlook.com (52.135.121.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 09:34:51 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7%4]) with mapi id 15.20.0973.018; Mon, 23 Jul 2018
 09:34:50 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk
 related functions
Thread-Topic: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk
 related functions
Thread-Index: AQHUHohACUqoSGDu+k+D+GLGKg0iRaSWwVMAgAMgLoCAArHT8A==
Date:   Mon, 23 Jul 2018 09:34:50 +0000
Message-ID: <SN6PR02MB4959F2ABE80C54242B8BF0C9C1560@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
        <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
        <f4b8e687-217f-15b1-b0b1-b95dbc3dcc2a@metafoo.de>
 <20180721172423.11efb5ea@archlinux>
In-Reply-To: <20180721172423.11efb5ea@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4479;6:662oPAExV+q1gQ5dZ12LnVE5ye7RN/LjndUZzI0wn470/+GDS8JFzgEwJU5/cPGYdV6N46j4mAjtLE0OJkRSqhsKUwAF5XRiKNVyLkLmyPbvoaih6DtxbUknniVzRVXNioLjq/h5XLPtCUWRyFPDqcfRQHbWOga2ImAjM02m/MSEAEk7S84a31PCyGg90L0E5AxuyYj6RswqxbUzEX1bTeKfHKRQMgWoVKrG+RIvNr5xOMtZ5JU07mSg1C1es8t67irs42krAAxzyJsqSmNgwNIkaSuXkYI3CKMm8NH/5Q4UEPeUh5d62IyPc5iIeqSAsRn1ZLzdpOwKr4sly+eIObhor1XHrxwvjvH7LUg1eT645Cz8Kl0ePVg2UwRz0Isv+lqG4bu7R16Kie9Qd7L054bX4rd7i9A67D0bClKHHOSSUTnBuSNsQiso7U7PwvWqhPbY364ezwkreoRx4PtMqg==;5:6iq8ZQCAw3fuYLbUTyWFAjkMWeyIFhpNgb1Bo6W3jXV214fP6oSmEG6+jvnOnqMYlcNItUP2TC5FluK/NlBfrnfbuV65tBuSzW/lPmLKLNj6JDq+Vgap8BKXUrLk0PYQ9vvUTedZuwux80orLRqiOvMJDJjUSL41Dvbr0DGU9c8=;7:glSf1BGC3c9rfuK5n+8Nz/5iq8342wXOCLMOnb2TXwRdqG1jPfFOv7I7J0OwM0K+pw+5nhke0Df9pxgaZuaxyWZ4Gj/eL5JHz9RJk9YjBDsI/kvuTodZ21V0yRF5xCW+NIgCJ4KF7/LkPbYGlYCFDBxL9nUpJARQmoYjITWn6rP8h9E+PVDf9B8kNFQ9d7MiFPJgVhcdfegxdFClKEEuEP2S9IS2uEVZzt0nlaXP56APKVLGCiuEctTmvcGvfknX
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(376002)(136003)(13464003)(199004)(189003)(74316002)(53936002)(2900100001)(6116002)(3846002)(55236004)(305945005)(7736002)(186003)(6506007)(53546011)(102836004)(33656002)(6246003)(5250100002)(26005)(478600001)(81166006)(81156014)(256004)(6436002)(8936002)(8676002)(486006)(476003)(229853002)(55016002)(66066001)(446003)(11346002)(14444005)(5660300001)(86362001)(99286004)(106356001)(72206003)(97736004)(25786009)(105586002)(14454004)(7696005)(54906003)(76176011)(316002)(93886005)(110136005)(9686003)(107886003)(68736007)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4479;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: bab79464-4f8a-487d-f8c1-08d5f07f89d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4479;
x-ms-traffictypediagnostic: SN6PR02MB4479:
x-microsoft-antispam-prvs: <SN6PR02MB447962816CE77EC9227AAEE1C1560@SN6PR02MB4479.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4479;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4479;
x-forefront-prvs: 0742443479
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BZEN0SCSVrH3J1ePjfCw/W7NOBwuihhNV7jz7uaELpkCWbRuLPbSLrox33acr17vdHekb1rEBNf9i/IBYw65Jursyuyc5yUUZrYVSiN3Ddkuy265emHreooP0cJ9Uj5Nkj1JWw44a5jwfLMaroa4RAMXetc+07y30zb7P/x5khxXwy5VFN4DyX2jjtXeQXE+Sn/CTHdLqoVE+BIbUWf9DwJwbGA4zs0143wAKtBBFXlfN58Av3tp0Bgpn6JyuExzweZGkCX9BSdoXjZgs1g34Vi5kGw4xHeRZgAqOawuzlpLbltdaV/Kty/OOOGVlpeEfli3xnQto9F+nVSr3GMSjIHYV1WHETfjPw0V9R/OZIw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab79464-4f8a-487d-f8c1-08d5f07f89d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 09:34:50.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for your comments.

> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Saturday, July 21, 2018 9:54 PM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Manish Narani <MNARANI@xilinx.com>; knaack.h@gmx.de;
> pmeerw@pmeerw.net; Michal Simek <michals@xilinx.com>; linux-
> iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Anirudha Sarangi <anirudh@xilinx.com>; Srinivas
> Goud <sgoud@xilinx.com>
> Subject: Re: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk=
 related
> functions
>=20
> On Thu, 19 Jul 2018 18:40:26 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>=20
> > On 07/18/2018 01:12 PM, Manish Narani wrote:
> > > This patch adds check for return values from clock related functions.
> > > This was reported by static code analysis tool.
> >
> > This patch seems to do something else.
> Indeed, definitely doing two things only one of which is mentioned.
> Please break it up and resend.
I will break it up and resend.

>=20
> Jonathan
>=20
> >
> > >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  drivers/iio/adc/xilinx-xadc-core.c | 24 ++++++++++++++++++++++--
> > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/xilinx-xadc-core.c
> > > b/drivers/iio/adc/xilinx-xadc-core.c
> > > index 248cffa..47eb364 100644
> > > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > > @@ -322,6 +322,7 @@ static irqreturn_t
> > > xadc_zynq_interrupt_handler(int irq, void *devid)
> > >
> > >  #define XADC_ZYNQ_TCK_RATE_MAX 50000000  #define
> > > XADC_ZYNQ_IGAP_DEFAULT 20
> > > +#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
> > >
> > >  static int xadc_zynq_setup(struct platform_device *pdev,
> > >  	struct iio_dev *indio_dev, int irq) @@ -332,6 +333,7 @@ static int
> > > xadc_zynq_setup(struct platform_device *pdev,
> > >  	unsigned int div;
> > >  	unsigned int igap;
> > >  	unsigned int tck_rate;
> > > +	int ret;
> > >
> > >  	/* TODO: Figure out how to make igap and tck_rate configurable */
> > >  	igap =3D XADC_ZYNQ_IGAP_DEFAULT;
> > > @@ -341,6 +343,13 @@ static int xadc_zynq_setup(struct
> > > platform_device *pdev,
> > >
> > >  	pcap_rate =3D clk_get_rate(xadc->clk);
> > >
> > > +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> > > +		ret =3D clk_set_rate(xadc->clk,
> > > +				   (unsigned
> long)XADC_ZYNQ_PCAP_RATE_MAX);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	if (tck_rate > pcap_rate / 2) {
> > >  		div =3D 2;
> > >  	} else {
> > > @@ -366,6 +375,12 @@ static int xadc_zynq_setup(struct platform_devic=
e
> *pdev,
> > >  			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE
> |
> > >  			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
> > >
> > > +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> > > +		ret =3D clk_set_rate(xadc->clk, pcap_rate);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -887,6 +902,9 @@ static int xadc_write_raw(struct iio_dev *indio_d=
ev,
> > >  	unsigned long clk_rate =3D xadc_get_dclk_rate(xadc);
> > >  	unsigned int div;
> > >
> > > +	if (!clk_rate)
> > > +		return -EINVAL;
> > > +
> > >  	if (info !=3D IIO_CHAN_INFO_SAMP_FREQ)
> > >  		return -EINVAL;
> > >
> > > @@ -1239,8 +1257,10 @@ static int xadc_probe(struct platform_device
> *pdev)
> > >  		goto err_free_irq;
> > >
> > >  	/* Disable all alarms */
> > > -	xadc_update_adc_reg(xadc, XADC_REG_CONF1,
> XADC_CONF1_ALARM_MASK,
> > > -		XADC_CONF1_ALARM_MASK);
> > > +	ret =3D xadc_update_adc_reg(xadc, XADC_REG_CONF1,
> XADC_CONF1_ALARM_MASK,
> > > +				  XADC_CONF1_ALARM_MASK);
> > > +	if (ret)
> > > +		goto err_free_irq;
> > >
> > >  	/* Set thresholds to min/max */
> > >  	for (i =3D 0; i < 16; i++) {
> > >
> >

Thanks,
Manish Narani
