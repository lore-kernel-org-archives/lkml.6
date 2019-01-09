Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48BCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AC42173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="OxMq7GM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfAILvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:51:43 -0500
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:48418
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729721AbfAILvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orxt7XJnN67yvGESDoELkpowy71t+OS4UnG/yfzKuQA=;
 b=OxMq7GM/OyloCirsRcqBPxYLpygk2q8L+xr6XvE9HABMMwtY3ewR78EwX3if5fmJ4p68jgUg/7AjPlsRJ2K8maIZUjs2y48QJamlUtaI4sXwQzLshLDcIMXdj3Sx7xFP5PsLbKVvQyQCiHoCTyWJgjXLUZ6ijyFDE9WK5sRIjD0=
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com (10.168.74.23) by
 DB6PR0501MB2645.eurprd05.prod.outlook.com (10.172.225.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 9 Jan 2019 11:51:37 +0000
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::c8ef:ad62:4125:3aba]) by DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::c8ef:ad62:4125:3aba%6]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 11:51:37 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "dev@pschenker.ch" <dev@pschenker.ch>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "coquelin.stm32@gmail.com" <coquelin.stm32@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v5 8/8] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Thread-Topic: [PATCH v5 8/8] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Thread-Index: AQHUmTOkvRPU3ioxhkizXPb6e2t+/6Wm8PEA
Date:   Wed, 9 Jan 2019 11:51:37 +0000
Message-ID: <fb969b4fb6ece5b9674ee47c35534c075e389620.camel@toradex.com>
References: <20181221134638.20600-1-dev@pschenker.ch>
         <20181221134638.20600-9-dev@pschenker.ch>
In-Reply-To: <20181221134638.20600-9-dev@pschenker.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.41.222.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2645;6:VmzjFMskRvXH7YxnVjkT+CnmNcikOGZVirN0ORaS1/GqlMRU2I+ypAhMMP5gicJmOOzXP013tViJXIX6jQgdTSTBn0tG+ZrjpUajkeOVYdDMlvDyZEcBGR66nGb5Q0d+Wsdtcl75xF1lpwCEFilSi8zNN0Ma2Z7X/hnBp6SL28j5iOTXxEttSDcZMIo4E9LLZ1HRr26hagOg3l2p0xsOb6oWCENFagYtbPzjzx3JI5u+jIciS3tyhPfTshCLxlm1iR5KrxE0DkbdTMYr4jQJq94i94RiU5MfafDc07ncgoq74+WAx+X4oysQ603QEn9+CEdZPBHTPhDUWaVh1fGrYxCnnp1fW3Js2BNAVFVxMnUiGv5eIkD99Ps5r6AZZ5MkgqeAVMI0gnKt5O7f2tNCRGtlfHQidK2ebLiNPwELVl1udcxghVqMea2KIk5yctLh3LEK2G/YCCz5qbLXDAqyFw==;5:Rbut45MGvEOFh7yungTxPcP7puESknvAJN16fuitUWhO7Ih4vLt+LStYUm+WXR5tpKm1y0Ml900CDRVN7sXo1IOmvt0N65zqCDo+o6yoYhS7OA+/zuYU1b2iqHQdnlwbwnZF6AiCvk7SEBJM4Q2NPxmC6k/UmD+D6UlDFA2Fy6Xvxbnq77J00Q7EqmfGEBL0vNOGDjwdCm1eBDASBNZRKQ==;7:+ffrR1t5a9i4BMVnEVeoXw5RULRAXf28WgJOf9VbruJC9KoFxYUmky9lEP0zA37+n6i2j/zDEb8BRe58VlHC3iQ72ix6kwLIzpeo3YjZQR/6Iofsf5eP/1z1UZjAD3lu23PBTRWfqNzMG+Rc04jP0A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39840400004)(396003)(376002)(189003)(199004)(36756003)(5660300001)(6246003)(3846002)(6116002)(4326008)(6512007)(39060400002)(478600001)(99286004)(97736004)(7416002)(14454004)(4001150100001)(118296001)(66066001)(53936002)(68736007)(26005)(186003)(102836004)(6346003)(7736002)(6486002)(486006)(2616005)(6436002)(76176011)(575784001)(86362001)(305945005)(2201001)(105586002)(256004)(14444005)(6506007)(81166006)(8676002)(81156014)(11346002)(476003)(44832011)(2501003)(446003)(8936002)(25786009)(106356001)(2906002)(71200400001)(71190400001)(316002)(54906003)(110136005)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0501MB2645;H:DB6PR0501MB2583.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: f98e1c82-2da5-4b1b-19d0-08d67628cf9c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2645;
x-ms-traffictypediagnostic: DB6PR0501MB2645:
x-microsoft-antispam-prvs: <DB6PR0501MB26459745548CDE8EF99F936BFB8B0@DB6PR0501MB2645.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0501MB2645;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2645;
x-forefront-prvs: 0912297777
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wznx4TWTZF0+mhMb1XTI404WEkhhu7ue2P5/CnW8z9JnORGM4XCc3vjZ6aw7WM4Q5jokiQMz1A0J6+71EqdpeM+UTO/+bYrdXrCv0qtQDEceF8MJ9Zo7URvdwBVo2LNIuQH9OcBkXXAHQoR+gtrR+H+zJveQtRI10ttPd6qGZ0FwrLLqhRd4HFLD8D20Wc1jhX0u228dgJw7xj2jRt7EBjxBPWu8OGVi5vqe+eCFRYNYnp8CB1ILrlGIO0L6fTsYnZQCVSzNJtZg/UmRDo+bOLpSakveyvkDXGhWVUTV/0NR2OnLwmwk/9Lsg9T/FoY4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F833CA3C044474481205527C129A88A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98e1c82-2da5-4b1b-19d0-08d67628cf9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 11:51:37.2696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEyLTIxIGF0IDE0OjQ2ICswMTAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXgu
Y29tPg0KPiANCj4gQWRkIHRoZSBzdG1wZS1hZGMgRFQgbm9kZSBhcyBmb3VuZCBvbiBUb3JhZGV4
IFQzMCBtb2R1bGVzDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhp
bGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoNCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIg
PG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4g
djU6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2NDoNCj4gIC0gTmV3IHNlcGFyYXRlIGNvbW1pdCB0byBo
b2xkIFQzMCBkZXZpY2V0cmVlIGNoYW5nZXMNCj4gDQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4g
Q2hhbmdlcyBpbiB2MjogTm9uZQ0KPiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtYXBh
bGlzLmR0c2kgIHwgMjIgKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9k
dHMvdGVncmEzMC1jb2xpYnJpLmR0c2kgfCAyMiArKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtYXBhbGlzLmR0c2kNCj4gYi9h
cmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWFwYWxpcy5kdHNpDQo+IGluZGV4IDdmMTEyZjE5MmZl
OS4uODUwYjBkMTM1NDlhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMw
LWFwYWxpcy5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtYXBhbGlzLmR0
c2kNCj4gQEAgLTk3NiwxMSArOTc2LDE4IEBADQo+ICAJCQlpZCA9IDwwPjsNCj4gIAkJCWJsb2Nr
cyA9IDwweDU+Ow0KPiAgCQkJaXJxLXRyaWdnZXIgPSA8MHgxPjsNCj4gKwkJCS8qIDMuMjUgTUh6
IEFEQyBjbG9jayBzcGVlZCAqLw0KPiArCQkJc3QsYWRjLWZyZXEgPSA8MT47DQo+ICsJCQkvKiAx
Mi1iaXQgQURDICovDQo+ICsJCQlzdCxtb2QtMTJiID0gPDE+Ow0KPiArCQkJLyogaW50ZXJuYWwg
QURDIHJlZmVyZW5jZSAqLw0KPiArCQkJc3QscmVmLXNlbCA9IDwwPjsNCj4gKwkJCS8qIEFEQyBj
b252ZXJzdGlvbiB0aW1lOiA4MCBjbG9ja3MgKi8NCj4gKwkJCXN0LHNhbXBsZS10aW1lID0gPDQ+
Ow0KPiArCQkJLyogZm9yYmlkIHRvIHVzZSBBREMgY2hhbm5lbHMgMy0wICh0b3VjaCkgKi8NCj4g
IA0KPiAgCQkJc3RtcGVfdG91Y2hzY3JlZW4gew0KPiAgCQkJCWNvbXBhdGlibGUgPSAic3Qsc3Rt
cGUtdHMiOw0KPiAtCQkJCS8qIDMuMjUgTUh6IEFEQyBjbG9jayBzcGVlZCAqLw0KPiAtCQkJCXN0
LGFkYy1mcmVxID0gPDE+Ow0KPiAgCQkJCS8qIDggc2FtcGxlIGF2ZXJhZ2UgY29udHJvbCAqLw0K
PiAgCQkJCXN0LGF2ZS1jdHJsID0gPDM+Ow0KPiAgCQkJCS8qIDcgbGVuZ3RoIGZyYWN0aW9uYWwg
cGFydCBpbiB6ICovDQo+IEBAIC05OTAsMTcgKzk5NywxNiBAQA0KPiAgCQkJCSAqIGN1cnJlbnQg
bGltaXQgdmFsdWUNCj4gIAkJCQkgKi8NCj4gIAkJCQlzdCxpLWRyaXZlID0gPDE+Ow0KPiAtCQkJ
CS8qIDEyLWJpdCBBREMgKi8NCj4gLQkJCQlzdCxtb2QtMTJiID0gPDE+Ow0KPiAtCQkJCS8qIGlu
dGVybmFsIEFEQyByZWZlcmVuY2UgKi8NCj4gLQkJCQlzdCxyZWYtc2VsID0gPDA+Ow0KPiAtCQkJ
CS8qIEFEQyBjb252ZXJzdGlvbiB0aW1lOiA4MCBjbG9ja3MgKi8NCj4gLQkJCQlzdCxzYW1wbGUt
dGltZSA9IDw0PjsNCj4gIAkJCQkvKiAxIG1zIHBhbmVsIGRyaXZlciBzZXR0bGluZyB0aW1lICov
DQo+ICAJCQkJc3Qsc2V0dGxpbmcgPSA8Mz47DQo+ICAJCQkJLyogNSBtcyB0b3VjaCBkZXRlY3Qg
aW50ZXJydXB0IGRlbGF5ICovDQo+ICAJCQkJc3QsdG91Y2gtZGV0LWRlbGF5ID0gPDU+Ow0KPiAg
CQkJfTsNCj4gKw0KPiArCQkJc3RtcGVfYWRjIHsNCj4gKwkJCQljb21wYXRpYmxlID0gInN0LHN0
bXBlLWFkYyI7DQo+ICsJCQkJc3Qsbm9yZXF1ZXN0LW1hc2sgPSA8MHgwRj47DQo+ICsJCQl9Ow0K
PiAgCQl9Ow0KPiAgDQo+ICAJCS8qDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy90
ZWdyYTMwLWNvbGlicmkuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAtY29saWJy
aS5kdHNpDQo+IGluZGV4IDM1YWYwM2NhOWU5MC4uMWY5MTk4YmIyNGZmIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWNvbGlicmkuZHRzaQ0KPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy90ZWdyYTMwLWNvbGlicmkuZHRzaQ0KPiBAQCAtODQ1LDExICs4NDUsMTggQEAN
Cj4gIAkJCWlkID0gPDA+Ow0KPiAgCQkJYmxvY2tzID0gPDB4NT47DQo+ICAJCQlpcnEtdHJpZ2dl
ciA9IDwweDE+Ow0KPiArCQkJLyogMy4yNSBNSHogQURDIGNsb2NrIHNwZWVkICovDQo+ICsJCQlz
dCxhZGMtZnJlcSA9IDwxPjsNCj4gKwkJCS8qIDEyLWJpdCBBREMgKi8NCj4gKwkJCXN0LG1vZC0x
MmIgPSA8MT47DQo+ICsJCQkvKiBpbnRlcm5hbCBBREMgcmVmZXJlbmNlICovDQo+ICsJCQlzdCxy
ZWYtc2VsID0gPDA+Ow0KPiArCQkJLyogQURDIGNvbnZlcnN0aW9uIHRpbWU6IDgwIGNsb2NrcyAq
Lw0KPiArCQkJc3Qsc2FtcGxlLXRpbWUgPSA8ND47DQo+ICsJCQkvKiBmb3JiaWQgdG8gdXNlIEFE
QyBjaGFubmVscyAzLTAgKHRvdWNoKSAqLw0KPiAgDQo+ICAJCQlzdG1wZV90b3VjaHNjcmVlbiB7
DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJzdCxzdG1wZS10cyI7DQo+IC0JCQkJLyogMy4yNSBNSHog
QURDIGNsb2NrIHNwZWVkICovDQo+IC0JCQkJc3QsYWRjLWZyZXEgPSA8MT47DQo+ICAJCQkJLyog
OCBzYW1wbGUgYXZlcmFnZSBjb250cm9sICovDQo+ICAJCQkJc3QsYXZlLWN0cmwgPSA8Mz47DQo+
ICAJCQkJLyogNyBsZW5ndGggZnJhY3Rpb25hbCBwYXJ0IGluIHogKi8NCj4gQEAgLTg1OSwxNyAr
ODY2LDE2IEBADQo+ICAJCQkJICogY3VycmVudCBsaW1pdCB2YWx1ZQ0KPiAgCQkJCSAqLw0KPiAg
CQkJCXN0LGktZHJpdmUgPSA8MT47DQo+IC0JCQkJLyogMTItYml0IEFEQyAqLw0KPiAtCQkJCXN0
LG1vZC0xMmIgPSA8MT47DQo+IC0JCQkJLyogaW50ZXJuYWwgQURDIHJlZmVyZW5jZSAqLw0KPiAt
CQkJCXN0LHJlZi1zZWwgPSA8MD47DQo+IC0JCQkJLyogQURDIGNvbnZlcnN0aW9uIHRpbWU6IDgw
IGNsb2NrcyAqLw0KPiAtCQkJCXN0LHNhbXBsZS10aW1lID0gPDQ+Ow0KPiAgCQkJCS8qIDEgbXMg
cGFuZWwgZHJpdmVyIHNldHRsaW5nIHRpbWUgKi8NCj4gIAkJCQlzdCxzZXR0bGluZyA9IDwzPjsN
Cj4gIAkJCQkvKiA1IG1zIHRvdWNoIGRldGVjdCBpbnRlcnJ1cHQgZGVsYXkgKi8NCj4gIAkJCQlz
dCx0b3VjaC1kZXQtZGVsYXkgPSA8NT47DQo+ICAJCQl9Ow0KPiArDQo+ICsJCQlzdG1wZV9hZGMg
ew0KPiArCQkJCWNvbXBhdGlibGUgPSAic3Qsc3RtcGUtYWRjIjsNCj4gKwkJCQlzdCxub3JlcXVl
c3QtbWFzayA9IDwweDBGPjsNCj4gKwkJCX07DQo+ICAJCX07DQo+ICANCj4gIAkJLyoNCg==
