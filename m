Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB62ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 02:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A58214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 02:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o4kdY6xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A58214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJTKNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 06:13:00 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:48544
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbeJTKM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 06:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMYO7ViwVw2q8HJ1TTd41Tijn7mljlEFPS3wyZSuiEU=;
 b=o4kdY6xvKSGejcDN7gbQmBua3gERtGlTCYcuOKT9GfMnbBniNgw85XyALoNZKsdtDgdtzLVc/z00ip//8YRJuQIgR2doEfZjYwLopYgSxFA/+HZsfYR3pRSIY+NDWV2zfcKoX8VhC3+UPbc041VUQwSg4NqABygHc9qrYf+KPeE=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4154.eurprd04.prod.outlook.com (52.135.130.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Sat, 20 Oct 2018 02:03:34 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::4bb:9505:f351:cad2]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::4bb:9505:f351:cad2%4]) with mapi id 15.20.1228.035; Sat, 20 Oct 2018
 02:03:34 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Topic: [PATCH] ARM: dts: imx6sx-sdb: Add flexcan support
Thread-Index: AQHUZ5AX9bFhc2fvBEqua6kfXbFzXaUmheaAgADbR4A=
Date:   Sat, 20 Oct 2018 02:03:34 +0000
Message-ID: <DB7PR04MB46185B34429D52D0D5F7465CE6FA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181019094031.22492-1-qiangqing.zhang@nxp.com>
 <CAOMZO5AqZrYmc474NjvG1nF94ZNvgHyv7Q3R+QxrLmSN6EhYDw@mail.gmail.com>
In-Reply-To: <CAOMZO5AqZrYmc474NjvG1nF94ZNvgHyv7Q3R+QxrLmSN6EhYDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [222.93.77.221]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4154;6:XfdLS0T8QlUyFVMGkmtDY3JH8SYbcfQTFHsKKuQIG57X+Mz2BIfmA+nkvO7ZLFfiWpmpK4eKU67CoWZlKs+rROcDhOdgtb6JXo8qBLjStHYstti8q/kFGvndl1929HdNMjqgW2xm6IY19H003DN3UzdkeLLglGH71ECdr42vliVTL5MtN9RY5jOJEsR+ISxQ2Yi6cU5nFp6q/mBkuTLB6/epOvYcfhJHGqksvZceJeEToInhOmwZS0I67uYWRDrl/QEpqvfP/G6KXSxO+0tTbs8LExMjv2Vw4ZhgM5dmVngjSypiWGgXMjdxBfMpP5f/dZlf1sxxRQ/V2V6YWFoftPAMtq3sA/+GEp/5E+2wTXbu1PSOIccULq4ssoAhVfSCwzwzTyK7oTORXQvysWuz7CqitmNV51X2dMZehvFcgYw1BDkz1+9QrjP/jrEsn2peEUAqKNLnD0QwPxxex5NG/A==;5:klVARNs/ehYYd3idYiMJKtPTsVi+oRto1fage/gUDVSQrbX+nu2kmNLVpgo63o6ZVf9qoix7tJbnMr5gSMI+ypvzg6Y1TOwOuct8PGU29sQaChRtkAltcGvZSlvmvmHsx3XeGzONOYJItyXwLoX4h1+lU4OpfD2vlhGF6Z9W4Yg=;7:QrNC6cdPZQgTJUAfPYVYs2venlr1om+dhCD9t9ZRW+X11ZOIxnplWudclvh1O4Kr7YykL7L87gKJzgt/X1baosipLQW9dVfbftHX6POYx5RHmJ3X9yqsK8Kh9hiQKNRUQWgduNyIo9td2FMHmj0H83roIwswA0LcxiBqZFGGxUcpOYAquFtjLwq2Xrd75MIvSOv/TLJW/PsuZ8cRpmy3ZxWkTIAp6MH+2n/t7F1+oaerktEHUnQHAIcLMj+U8GVw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9dc273b0-6377-4266-a99c-08d636303dfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4154;
x-ms-traffictypediagnostic: DB7PR04MB4154:
x-microsoft-antispam-prvs: <DB7PR04MB4154085D3E9C10F7E6EA470EE6FA0@DB7PR04MB4154.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(185117386973197)(180628864354917)(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4154;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4154;
x-forefront-prvs: 0831C25939
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(13464003)(81156014)(446003)(81166006)(66066001)(102836004)(8676002)(486006)(476003)(11346002)(186003)(26005)(6116002)(3846002)(8936002)(6916009)(5250100002)(2900100001)(53936002)(6246003)(5660300001)(86362001)(1411001)(478600001)(68736007)(2906002)(256004)(74316002)(305945005)(55016002)(229853002)(7696005)(14454004)(76176011)(9686003)(7736002)(99286004)(39060400002)(25786009)(97736004)(33656002)(316002)(106356001)(6436002)(71190400001)(71200400001)(53546011)(6506007)(105586002)(4326008)(54906003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4154;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 79+PnnHGtrMiTim8rBg/8vTD/Jw+Q/tawOTG8A9rCM2fcKhPgHNySf7Rd7NkQy+4wmAMP0l2JvTApYiwNS6DRQe79ItADbzrSVNFt0fb7q3WTZGAyNxtuNC/uO2pl5oqyuGFnDD/0xe6SfZHli8TlKEZEgQmJJiyZg3MX6RV+PwSOsIeVz6wqUVXdn6L5vGYenKSyqYXnztzHSrDjbhABbN62+wXTu9DY46zpo2ewq2XYkYoS85pWVUZnWpMZdzWlB3/vu9C5yDRUnCVQ//37ERy0zZ91SJvNHsPnw35rfnGje5MiwjpApdZyUY0HfLFjnnzaRHe1Q5+qExIjC2tzAC+mgH7FHPNcGYUoPimfUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc273b0-6377-4266-a99c-08d636303dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2018 02:03:34.4687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRv
OmZlc3RldmFtQGdtYWlsLmNvbV0gDQpTZW50OiAyMDE45bm0MTDmnIgxOeaXpSAyMDo1Mg0KVG86
IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQpDYzogU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRl
PjsgU2FzY2hhIEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxm
YWJpby5lc3RldmFtQG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
Um9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRs
YW5kQGFybS5jb20+OyBBLnMuIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgb3BlbiBsaXN0
Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0gQVJD
SElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQpTdWJqZWN0
OiBSZTogW1BBVENIXSBBUk06IGR0czogaW14NnN4LXNkYjogQWRkIGZsZXhjYW4gc3VwcG9ydA0K
DQpIaSBKb2FraW0sDQoNCk9uIEZyaSwgT2N0IDE5LCAyMDE4IGF0IDY6NDMgQU0gSm9ha2ltIFpo
YW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4gd3JvdGU6DQo+DQo+IEZyb206IERvbmcgQWlz
aGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+DQo+IENBTiB0cmFuc2NlaXZlciBpcyBkaWZm
ZXJlbnQgb24gUmV2QSBhbmQgUmV2QiBib2FyZC4NCj4gSXQncyBhY3RpdmUgaGlnaCBvbiBSZXZB
IHdoaWxlIGFjdGl2ZSBsb3cgb24gUmV2IEIuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERvbmcgQWlz
aGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFu
ZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnN4LXNkYi5kdHMgIHwgIDUgKysrKyAgDQo+IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC1z
ZGIuZHRzaSB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnN4LXNkYi5kdHMgDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LXNkYi5k
dHMNCj4gaW5kZXggNmRkOWJlYmZlMDI3Li4wOTJiOGRlMTQyYTggMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZzeC1zZGIuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZzeC1zZGIuZHRzDQo+IEBAIC0xMCw2ICsxMCwxMSBAQA0KPg0KPiAgLyB7DQo+ICAgICAg
ICAgbW9kZWwgPSAiRnJlZXNjYWxlIGkuTVg2IFNvbG9YIFNEQiBSZXZCIEJvYXJkIjsNCj4gKw0K
PiArICAgICAgIC8qIFRyYW5zY2VpdmVyIEVOL1NUQlkgaXMgYWN0aXZlIGxvdyBvbiBSZXZCIGJv
YXJkICovDQo+ICsgICAgICAgcmVnX2Nhbl9zdGJ5OiByZWd1bGF0b3ItY2FuLXN0Ynkgew0KPiAr
ICAgICAgICAgICAgICAgZ3BpbyA9IDwmZ3BpbzQgMjcgR1BJT19BQ1RJVkVfTE9XPjsNCg0KRG9u
J3Qgd2UgbmVlZCBhICBncGlvID0gPCZncGlvNCAyNyBHUElPX0FDVElWRV9ISUdIPjsgYW5kIGFs
c28gYSAiZW5hYmxlLWFjdGl2ZS1oaWdoIiBlbnRyaWVzIGluIHRoZSBpbXg2c3gtc2RiLXJldmEu
ZHRzPw0KDQpZZXMsIHlvdSBhcmUgcmlnaHQuIEkgd2lsbCBhZGQgdGhlIGVudHJ5IGluIHRoZSBp
bXg2c3gtc2RiLXJldmEuZHRzLiBUaGFua3MgYSBsb3QhIA0KDQpCUnMsDQpKYW9raW0gWmhhbmcN
Cg0K
