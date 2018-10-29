Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF0EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC5C2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="y2eLLhtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC5C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJ3Am1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:42:27 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:49560
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727520AbeJ3Am1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk3XKBn89IlCKTGYDL9gKfBHJXSOGo0K3NBbf2G1x5Q=;
 b=y2eLLhtLxBG1HTNalSCQ2RB9XdsbSQNEQHdjMDqdh/RWbsMIPyTxHtGCl2VktTDHHdvYuOaqALskqytdJvfLLTfcybcd5/BvwABBfDr+TezWfAS50Vs2QtS0PPkxiyXBOimJS4hx5wLtwBkH+2lgoH0rVNIRCcLQd9+Wvq7pfqg=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB3964.eurprd04.prod.outlook.com (52.134.107.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Mon, 29 Oct 2018 15:53:10 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 15:53:10 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>
Subject: =?utf-8?B?UmU6IFtSQ0bCoFBBVENIIHYyIDIvMl0gcHdtOiBpbXg6IENvbmZpZ3VyZSBv?=
 =?utf-8?Q?utput_to_GPIO_in_disabled_state?=
Thread-Topic: =?utf-8?B?W1JDRsKgUEFUQ0ggdjIgMi8yXSBwd206IGlteDogQ29uZmlndXJlIG91dHB1?=
 =?utf-8?Q?t_to_GPIO_in_disabled_state?=
Thread-Index: AQHUYHxLNWnXvPuyf0G4S0CzwIUtnqUbyHWAgBq1iwA=
Date:   Mon, 29 Oct 2018 15:53:10 +0000
Message-ID: <a350dd95-3ad6-fc6e-551d-56ebcef8f73d@ysoft.com>
References: <1539163920-9442-1-git-send-email-michal.vokac@ysoft.com>
 <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012160037.GH31561@ulmo>
In-Reply-To: <20181012160037.GH31561@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0006.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::19) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB3964;6:oDbLQ52dXAH9Cu9qbDS0RiTsri/ZOF1VZBuUulTMi7eZGUNSQyXQxTEo27KjFCepZhIretmKGi4qU7TMKjXcGlUbGT7JvZSu/N5SHOxxdRUyke9WiNHUtxJZ6ADZIWhjAKychiW17hmE9tl1vvTcIuGM9S1lRDOzUQA8IeG0DczUp4C2vDQvQCxjkPZ0wFXyNbplIez8X/NHP4+Gg+AxS5aWr3A6duYkpFQ9zZUiy9U6LaDHCvx5rJxPLEh9YXgZ8FDw1mZVXTG4KDRY4z1qWZK7FXG2/to5SH7ma9ZBIQ7t2IqUvkY9UfOR/bQbMof/3jTnbxoo/M21e3dXfp9Lcyr89wVt37JM+2vmbMCeSZkRr6jW3us/bOJhDlYFO2V0c2l7ruHo2jF13NqaPBTjnl61Hx+cm8mcazib0P9+pjgFw5r5DlfayuSJLVgE9QiPJnHcXQSFDFLh3L93m/mOMQ==;5:0odgvo/0CJ+0dE/2JCY1SlDRHYxt7KB+ULrA0HeU5csMOnq1xbKgOw4gpA4VdUqPypGFGJcuxkhaTFH17ZEOVvJtHgpdUaOh3raLlAWPwS14CpqFOSWURZEtrjMcOpVh+p30b7ILxYV2uS5umbvcqf7aDa1QnNA56d5CwJq553c=;7:FY9LgTl5+LLGwTTZ4gSedhPRnWjGN0fZ7864rfAOZnarjAa4eyuDniJfHy7cRN1xVPEb29srzF7XW+zCUtsfsLtczfgs8IJnJNofcBvFx0K4JfSRNia+7M8IureEiF7kk5IGv9M+ZJG01VAQnWVgFQ==
x-ms-office365-filtering-correlation-id: 893742fd-a7d3-4ec2-0d0d-08d63db6a01e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB3964;
x-ms-traffictypediagnostic: DB7PR04MB3964:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-microsoft-antispam-prvs: <DB7PR04MB396497A5890D441615431BC89EF30@DB7PR04MB3964.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB3964;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB3964;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39850400004)(396003)(189003)(199004)(81166006)(99286004)(6506007)(386003)(53546011)(72206003)(31696002)(11346002)(106356001)(476003)(6486002)(478600001)(86362001)(81156014)(105586002)(14454004)(2900100001)(316002)(26005)(486006)(85182001)(71190400001)(66066001)(186003)(102836004)(446003)(76176011)(8936002)(2616005)(4326008)(7736002)(54906003)(6436002)(52116002)(71200400001)(305945005)(6246003)(14444005)(6512007)(256004)(25786009)(53936002)(68736007)(97736004)(5250100002)(39060400002)(36756003)(229853002)(2906002)(6116002)(3846002)(5660300001)(6916009)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3964;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hBUYRF6U5wWT5jKUNRHprnklPA1lizSvv2MaaG38UTobhe3IZwrmf8mtQlwdo0BFOsGxud8yC0CPLR8lJA0jt4W68HuccACAzkw+ZsTi16k/t9l3fxqKuOcWrdUhqSz3RltuQ8yxIOfxaCsn8cuornO9K2HQZoUJyEWadM526u+hUuZtsOGQhzQK23xvkZZPsn05z/e+2D2POmogQicrGVKFL+G+ZnhVKCJoSpN35FWEGx+j7D+hVecyNNrrWPIlOHodiOGQaOFQ7Yyn0kfHuLa6NrYX9U2HS08LI3ipkDhh9o23Ig9WE/pnc1LhNoTFE+Vl8SrPSZYAbFVtr5h5MmLfAhaqgMP/JSTdw63Nswc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7A17BC31F985A4B934684AF617CC003@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893742fd-a7d3-4ec2-0d0d-08d63db6a01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 15:53:10.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMTAuMjAxOCAxODowMCwgVGhpZXJyeSBSZWRpbmcgd3JvdGU6DQo+IE9uIFdlZCwgT2N0
IDEwLCAyMDE4IGF0IDA5OjMzOjI2QU0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0KPj4g
Tm9ybWFsbHkgdGhlIFBXTSBvdXRwdXQgaXMgaGVsZCBMT1cgd2hlbiBQV00gaXMgZGlzYWJsZWQu
IFRoaXMgY2FuIGNhdXNlDQo+PiBwcm9ibGVtcyB3aGVuIGludmVydGVkIFBXTSBzaWduYWwgcG9s
YXJpdHkgaXMgbmVlZGVkLiBXaXRoIHRoaXMgYmVoYXZpb3INCj4+IHRoZSBjb25uZWN0ZWQgY2ly
Y3VpdCBpcyBmZWQgYnkgMTAwJSBkdXR5IGN5Y2xlIGluc3RlYWQgb2YgYmVpbmcgc2h1dC1vZmYu
DQo+Pg0KPj4gQWxsb3cgdXNlcnMgdG8gZGVmaW5lIGEgImdwaW8iIGFuZCBhICJwd20iIHBpbmN0
cmwgc3RhdGVzLiBUaGUgcHdtIHBpbmN0cmwNCj4+IHN0YXRlIGlzIHRoZW4gc2VsZWN0ZWQgd2hl
biBQV00gaXMgZW5hYmxlZCBhbmQgdGhlIGdwaW8gcGluY3RybCBzdGF0ZSBpcw0KPj4gc2VsZWN0
ZWQgd2hlbiBQV00gaXMgZGlzYWJsZWQuIEFsc28gYWRkIGEgbmV3IHB3bS1ncGlvcyBHUElPIHRo
YXQgaXMgdXNlZA0KPj4gdG8gZHJpdmUgdGhlIG91dHB1dCBpbiB0aGUgZ3BpbyBzdGF0ZS4NCj4+
DQo+PiBJZiBhbGwgdGhlIHBpbmN0cmwgc3RhdGVzIGFuZCB0aGUgcHdtLWdwaW9zIGFyZSBub3Qg
Y29ycmVjdGx5IHNwZWNpZmllZA0KPj4gaW4gRFQgdGhlIGxvZ2ljIHdpbGwgd29yayBhcyBiZWZv
cmUuDQo+Pg0KPj4gQXMgYW4gZXhhbXBsZSwgd2l0aCB0aGlzIHBhdGNoIGEgUFdNIGNvbnRyb2xs
ZWQgYmFja2xpZ2h0IHdpdGggaW52ZXJzZWQNCj4+IHNpZ25hbCBwb2xhcml0eSBjYW4gYmUgdXNl
ZCBpbiBmdWxsIGJyaWdodG5lc3MgcmFuZ2UuIFdpdGhvdXQgdGhpcyBwYXRjaA0KPj4gdGhlIGJh
Y2tsaWdodCBjYW4gbm90IGJlIHR1cm5lZCBvZmYgYXMgYnJpZ2h0bmVzcyA9IDAgZGlzYWJsZXMg
dGhlIFBXTQ0KPj4gYW5kIHRoYXQgaW4gdHVybiBzZXQgUFdNIG91dHB1dCBMT1csIHRoYXQgaXMg
ZnVsbCBicmlnaHRuZXNzLg0KPj4NCj4+IE91dHB1dCBvZiB0aGUgUFdNIHdpdGggImRlZmF1bHQi
IHBpbmN0cmwgYW5kIHdpdGggInB3bSIrImdwaW8iIHBpbmN0cmw6DQo+Pg0KPj4gKy0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKw0KPj4gfCBBZnRlciByZXNldCAgfCBCb290bG9hZGVyIHwgTGludXggcGluY3RybCB8
IFVzZXIgKHN5c2ZzLCBiYWNrbGlnaHQuLikgfA0KPj4gfCAxMDBrIHB1bGwtdXAgfCAobm90IHVz
ZWQpIHwgICAgICAgICAgICAgICB8ICAgZW5hYmxlICAgIHwgICBkaXNhYmxlICAgfA0KPj4gKy0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKw0KPj4gICBfX19fX19fX19fX19fX19fX19fX19fX19fX18gICAgZGVmYXVs
dCAgICAgICAgXyAgIF8gICBfDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHxfX19f
X19fX19fX19fX19fX3wgfF98IHxffCB8X3xfX19fX19fX19fX19fDQo+Pg0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBwd20gKyBncGlvDQo+PiAgIF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18gICBfICAgXyAgIF8gICBfX19fX19fX19fX19fDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8X3wgfF98IHxf
fCB8X3wNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2Fj
QHlzb2Z0LmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+ICAgLSBVdGlsaXplIHRo
ZSAicHdtIiBhbmQgImdwaW8iIHBpbmN0cmwgc3RhdGVzLg0KPj4gICAtIFVzZSB0aGUgcHdtLWdw
aW9zIHNpZ25hbCB0byBkcml2ZSB0aGUgb3V0cHV0IGluICJncGlvIiBwaW5jdHJsIHN0YXRlLg0K
Pj4gICAtIFNlbGVjdCB0aGUgcmlnaHQgcGluY3RybCBzdGF0ZSBpbiBwcm9iZS4NCj4+DQo+PiAg
IGRyaXZlcnMvcHdtL3B3bS1pbXguYyB8IDg2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgODYgaW5zZXJ0aW9u
cygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20taW14LmMgYi9kcml2ZXJz
L3B3bS9wd20taW14LmMNCj4+IGluZGV4IDZjZDNiNzIuLjM1MDIxMjMgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL3B3bS9wd20taW14LmMNCj4+ICsrKyBiL2RyaXZlcnMvcHdtL3B3bS1pbXguYw0K
Pj4gQEAgLTEwLDExICsxMCwxMyBAQA0KPj4gICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+PiAg
ICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+
PiArI2luY2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4
L2lvLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4+ICAgI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4+ICAgI2luY2x1ZGUg
PGxpbnV4L29mX2RldmljZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVy
Lmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4+ICAgI2luY2x1
ZGUgPGxpbnV4L3B3bS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPj4gQEAgLTky
LDEwICs5NCw0NSBAQCBzdHJ1Y3QgaW14X2NoaXAgew0KPj4gICAJdm9pZCBfX2lvbWVtCSptbWlv
X2Jhc2U7DQo+PiAgIA0KPj4gICAJc3RydWN0IHB3bV9jaGlwCWNoaXA7DQo+PiArDQo+PiArCXN0
cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0KPj4gKwlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluY3Ry
bF9waW5zX2dwaW87DQo+PiArCXN0cnVjdCBwaW5jdHJsX3N0YXRlICpwaW5jdHJsX3BpbnNfcHdt
Ow0KPj4gKwlzdHJ1Y3QgZ3Bpb19kZXNjICpwd21fZ3Bpb2Q7DQo+PiAgIH07DQo+PiAgIA0KPj4g
Kw0KPj4gICAjZGVmaW5lIHRvX2lteF9jaGlwKGNoaXApCWNvbnRhaW5lcl9vZihjaGlwLCBzdHJ1
Y3QgaW14X2NoaXAsIGNoaXApDQo+PiAgIA0KPj4gK3N0YXRpYyBpbnQgaW14X3B3bV9pbml0X3Bp
bmN0cmxfaW5mbyhzdHJ1Y3QgaW14X2NoaXAgKmlteF9jaGlwLA0KPj4gKwkJc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4+ICt7DQo+PiArCWlteF9jaGlwLT5waW5jdHJsID0gZGV2bV9w
aW5jdHJsX2dldCgmcGRldi0+ZGV2KTsNCj4+ICsJaWYgKCFpbXhfY2hpcC0+cGluY3RybCB8fCBJ
U19FUlIoaW14X2NoaXAtPnBpbmN0cmwpKSB7DQo+IA0KPiBUaGlzIGlzIG5vdCBjb3JyZWN0LiBG
aXJzdCwgSSBkb24ndCB0aGluayBkZXZtX3BpbmN0cmxfZ2V0KCkgd2lsbCBldmVyDQo+IHJldHVy
biBOVUxMLCBzbyB0aGUgIWlteF9jaGlwLT5waW5jdHJsIGlzIHVzZWxlc3MuIEFuZCBpZiBpdCBk
aWQgcmV0dXJuDQo+IE5VTEwgYW5kIGlteF9jaGlwLT5waW5jdHJsIGNvdWxkIHRoZXJlZm9yZSBi
ZSBOVUxMLCB0aGVuLi4uDQo+IA0KPj4gKwkJZGV2X2luZm8oJnBkZXYtPmRldiwgImNhbiBub3Qg
Z2V0IHBpbmN0cmxcbiIpOw0KPj4gKwkJcmV0dXJuIFBUUl9FUlIoaW14X2NoaXAtPnBpbmN0cmwp
Ow0KPiANCj4gLi4uIHRoaXMgaXMgcnViYmlzaCBiZWNhdXNlIGl0IHJldHVybnMgUFRSX0VSUihO
VUxMKSB3aGljaCBpcyAwIGFuZCB0aGF0DQo+IHJlcHJlc2VudHMgc3VjY2Vzcy4NCg0KR29vZCBj
YXRjaCEgQWdhaW4sIHRoaXMgY29kZSBpcyBhY3R1YWxseSBhbiBleGFjdCBjb3B5IGZyb20gaTJj
LWlteC5jLg0KSSBjYW4gc2VuZCBhIHBhdGNoIHRvIEkyQyBmb2xrcyB3aXRoIGZpeCBxdW90aW5n
IHlvdXIgY29tbWVudCBpZiB5b3UgZG8NCm5vdCBtaW5kLg0KDQo+IFdoaWxlIGF0IGl0LCBkZXZf
aW5mbygpIC0+IGRldl9lcnIoKSBtaWdodCBiZSBtb3JlIGFwcHJvcHJpYXRlIGhlcmUuIE9yDQo+
IGlmIHlvdSB3YW50IHRvIG1ha2UgcGluY3RybCBzdXBwb3J0IG9wdGlvbmFsIG1ha2UgdGhpcyBk
ZXZfZGJnKCkgbGlrZQ0KPiB0aGUgbWVzc2FnZSBmdXJ0aGVyIGJlbG93Lg0KDQpJIHByZWZlciB0
byBtYWtlIHRoZSBwaW5jdHJsIHN1cHBvcnQgb3B0aW9uYWwgc28gZGV2X2RiZygpIHNlZW1zIE9L
Lg0KDQo+PiArCX0NCj4+ICsNCj4+ICsJaW14X2NoaXAtPnBpbmN0cmxfcGluc19wd20gPSBwaW5j
dHJsX2xvb2t1cF9zdGF0ZShpbXhfY2hpcC0+cGluY3RybCwNCj4+ICsJCQkicHdtIik7DQo+PiAr
CWlteF9jaGlwLT5waW5jdHJsX3BpbnNfZ3BpbyA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGlteF9j
aGlwLT5waW5jdHJsLA0KPj4gKwkJCSJncGlvIik7DQo+PiArCWlteF9jaGlwLT5wd21fZ3Bpb2Qg
PSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAicHdtIiwNCj4+ICsJCQlHUElP
RF9JTik7DQo+PiArDQo+PiArCWlmIChQVFJfRVJSKGlteF9jaGlwLT5wd21fZ3Bpb2QpID09IC1F
UFJPQkVfREVGRVIpIHsNCj4+ICsJCXJldHVybiAtRVBST0JFX0RFRkVSOw0KPj4gKwl9IGVsc2Ug
aWYgKElTX0VSUihpbXhfY2hpcC0+cHdtX2dwaW9kKSB8fA0KPj4gKwkJICAgSVNfRVJSKGlteF9j
aGlwLT5waW5jdHJsX3BpbnNfcHdtKSB8fA0KPj4gKwkJICAgSVNfRVJSKGlteF9jaGlwLT5waW5j
dHJsX3BpbnNfZ3BpbykpIHsNCj4+ICsJCWRldl9kYmcoJnBkZXYtPmRldiwgIlBXTSBwaW5jdHJs
IGluZm9ybWF0aW9uIGluY29tcGxldGVcbiIpOw0KPiANCj4gQW5vdGhlciBvcHRpb24gd291bGQg
YmUgdG8gbWFrZSB0aGlzIChhbmQgdGhlIGFib3ZlKSBkZXZfd2FybigpIHNpbmNlIHdlDQo+IGRv
IHdhbnQgcGVvcGxlIHRvIHVwZGF0ZSB0aGUgRFRCIGlmIGF0IGFsbCBwb3NzaWJsZS4gV2l0aG91
dCB0aGUgRFRCIHRoZQ0KPiBQV00gY291bGQgYmUgc3VzY2VwdGlibGUgdG8gdGhlIGlzc3VlIHRo
YXQgd2UncmUgdHJ5aW5nIHRvIGZpeC4NCg0KSSBkbyBub3QgdGhpbmsgZGV2X3dhcm4oKSBpcyBh
cHByb3ByaWF0ZSBoZXJlLiBJTUhPIHRoZSBpc3N1ZSBpcyBvbmx5DQpyZWxldmFudCBpZiB5b3Ug
d2FudCBnZW5lcmF0ZSBpbnZlcnNlZCBQV00gc2lnbmFsLiBPbmx5IHRoZW4geW91IG5lZWQNCnRv
IHNwZWNpZnkgYWxsIHRoZSBwaW5jdHJsIHJlbGF0ZWQgYmluZGluZy4gRm9yIG5vcm1hbCBwb2xh
cml0eSBpdCBpcw0KYWxtb3N0IHVzZWxlc3MgSSB0aGluay4gSXQgY2FuIHN0aWxsIGJlIHVzZWQg
b2YgY291cnNlIGJ1dCB5b3Ugd291bGQNCndhbnQgdG8gY29uZmlndXJlIHRoZSBwaW4gd2l0aCBw
dWxsLWRvd24gYW5kIGFzIGEgR1BJT19BQ1RJVkVfSElHSCBpbg0KR1BJTyBzdGF0ZS4NCg0KQW5k
IHRoYXQgY2FzZSB3b3VsZCBuZWVkIGFkZGl0aW9uYWwgZG9jdW1lbnRhdGlvbi4gSXQgc2VlbXMg
bGl0dGxlIGJpdA0KcmVkdW5kYW50IHRvIG1lLiBJIGFtIG9wZW4gdG8gZG8gaXQgdGhhdCB3YXkg
KHVzZSBkZXZfd2FybigpIGFuZCBwdXNoDQpEVFMgYXV0aG9ycyB0byB1c2UgdGhlIGFkZGl0aW9u
YWwgcGluY3RybCBiaW5kaW5nIGluIGFsbCBjYXNlcykgaWYgeW91DQp0aGluayBpdCBpcyBzYW5l
Lg0KDQpNaWNoYWwNCg0K
