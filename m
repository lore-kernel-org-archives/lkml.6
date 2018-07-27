Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA318C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4184E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KDzRqcUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4184E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbeG0DLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:11:13 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:5024
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731988AbeG0DLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2GM2VE1bzoaKBFZZ5gYNB3jyHfp66c6IueQ0dKDsMw=;
 b=KDzRqcUmLKIhaU4F++WG+11wmmhJ5HgPwbAOTiiCCi/pK+Ao9nwteQtIVyd/0jYyWucj4QvIsX235/E0osUb1WYBAlknhmjt2x8g3Br0+xee+YMBPBCWeekIuKTsyJQOqJ/BleCh1nfRUOI4zMuwukPgt5k3gY2eiRdo5CJ4WGQ=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3159.eurprd04.prod.outlook.com (10.170.214.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 27 Jul 2018 01:51:35 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 01:51:35 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Thread-Topic: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Thread-Index: AQHUJMI388q4zA1ybU+fByMY2n4yEKShPSxQgAAjboCAAOXVUA==
Date:   Fri, 27 Jul 2018 01:51:35 +0000
Message-ID: <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
In-Reply-To: <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3159;6:VrzXl2uauD22DZs2ulnU4BUA0CrKQ2ROxK3DwtLMzdWISHP9cNSsQHCmP87NoV1oGb4POzY5+MZreBMIkf/wfbfZbg0iX6u3ykUiH3Qn7HHhJHhh/XFqgfW+iaACJwYiRFMmUM5ooBdyAS61xPAlVJCufudwz6rigQBE+jDSTQaVQhWllnbONfjDqO8gCZTDYzqmf7Ruf1VJ5PIcp/RsijXzpR2govvMXerkg/Mi7SeUM2jlRqodt+Ntwv59ojZZ/pfEhrEHMmKpo+pgJJ+u8Q4+vibSr9Ikaf3wfBwm3v+1bfzNqjQLIZcvJ9iiugcxRFB28SlO1U7VfxUEL9vdqdnugBgW85jzb5r0gaGQEyLgyAfrCUj4YvQvn7B+qcfU5Hdsm67Tl4eP4oI2o/4BSvTkCz4Ibp66T5sLuMTiJoW+gwkmtFDyX0SWC0dektyngS/Wo5u+FuLvJfkUiZbL3A==;5:FdqtAGbMN3H92cc89D2K6cdmd2d2ahEosZa7FZH9CEPpb6nS+GSsDFPG4skKbqYtpN2M+aHVEQCzfAg8EnDbWB6bKdpXBe+CU+I98DGD2JB8qulJVvbdh2w2DimTnuqt/1MT2WQN529gWC7qH1sYoCmh8PvdYZjgQSwl1rQeEQM=;7:VZucfSSjOtTVkdBEkAUsUEIMsIFEBKW73VsJH1Q05pY23Js/XljcQu8cUpLm3/tJy4OMIR+4VhMW4I/VTx/+H3i8fGLJyVE9vT6HQenq8PfecuvJh1isWR38rgiN7L7tsBf9lBkzsDvAtwNjVnvVERiFI4zjdmCbvl6uMmSkTm/fRb/IuIiyr6WIYFcbM1OD2+1jmoCac1yhMNnPFJPui0NLmMLbbjPwrSExkIku+bDH1N90drJaxT4aunpoopRu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bceee7b3-d1eb-4f1d-a483-08d5f3637c53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3159;
x-ms-traffictypediagnostic: DB6PR04MB3159:
x-microsoft-antispam-prvs: <DB6PR04MB3159DC660315C24BD5BDA691892A0@DB6PR04MB3159.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(21532816269658)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3159;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3159;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(136003)(346002)(199004)(13464003)(189003)(7696005)(26005)(55016002)(68736007)(2906002)(316002)(106356001)(25786009)(6246003)(9686003)(39060400002)(14454004)(110136005)(186003)(2900100001)(6116002)(3846002)(478600001)(229853002)(11346002)(14444005)(476003)(5660300001)(93886005)(7736002)(102836004)(66066001)(76176011)(74316002)(53546011)(54906003)(256004)(33656002)(53936002)(8936002)(6436002)(105586002)(5250100002)(97736004)(305945005)(81156014)(86362001)(81166006)(99286004)(7416002)(4326008)(8676002)(446003)(6506007)(486006)(32563001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3159;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uaG2/hvNK6/4fQSFXvnXcXECR2JNKo6WTsVoZNhqaVC3XB+dL8W7Sw1TVxwiH6MAjaxCbtu6xFdBqHHxZvj97jgV1QXVaM3DlswsfxTGO79s+EpTgjqGQ1SepMrP6YobgndOHv28x0qtK/YZG+7vxIgoSBGcXDALV9BBSyCEsbXuohhHnny7Hv/9ffBp7FNTyb1+cxOi7K4id+gj/AQ0Wqfg57gj86JbllO7Uj1hYWC80CfcnwZC5u5nAzulNm69rA3ZdL/9y/zHUiGGjM55UchpISYbCcqXIjO6ewz+Rz4D8d//yo7H+rjL1MLxU9RYPVbxSHnJvXL10w5aYb05vHIPjEaAZPLLm+3KuwNRSZc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bceee7b3-d1eb-4f1d-a483-08d5f3637c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 01:51:35.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBSZW1wZWwg
W21haWx0bzpvLnJlbXBlbEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogMjAxOMTqN9TCMjbI1SAx
OTozOA0KPiBUbzogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPjsgU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsNCj4gTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsg
UmFmYWVsIEouIFd5c29ja2kNCj4gPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiBDYzog
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbmRyZXcgTW9ydG9uIDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPjsNCj4gTGlhbSBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWls
LmNvbT47IExlb25hcmQgQ3Jlc3Rleg0KPiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBSb2Ig
SGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyaw0KPiBSdXRsYW5kIDxtYXJrLnJ1dGxh
bmRAYXJtLmNvbT47IE1pY2hhZWwgVHVycXVldHRlDQo+IDxtdHVycXVldHRlQGJheWxpYnJlLmNv
bT47IFN0ZXBoZW4gQm95ZCA8c2JveWRAY29kZWF1cm9yYS5vcmc+OyBGYWJpbw0KPiBFc3RldmFt
IDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az47DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBBLnMuIERvbmcgPGFp
c2hlbmcuZG9uZ0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDEvNl0gQVJNOiBp
bXg2cTogcHJvdmlkZSBkb2N1bWVudGF0aW9uIGZvciBuZXcNCj4gZnNsLHBtaWMtc3RieS1wb3dl
cm9mZiBwcm9wZXJ0eQ0KPiANCj4gSGksDQo+IA0KPiBPbiAyNi4wNy4yMDE4IDExOjUxLCBSb2Jp
biBHb25nIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogT2xla3NpaiBSZW1wZWwgW21haWx0bzpvLnJlbXBlbEBwZW5ndXRyb25peC5k
ZV0NCj4gPj4gU2VudDogMjAxOMTqN9TCMjbI1SAxNzoyMg0KPiA+PiBUbzogU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgTWFyayBCcm93bg0KPiA8YnJvb25pZUBrZXJuZWwub3JnPjsN
Cj4gPj4gUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiA+
PiBDYzogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPjsga2VybmVsQHBl
bmd1dHJvbml4LmRlOw0KPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBsaW51eC1jbGtAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbmRyZXcNCj4gPj4gTW9ydG9uIDxh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTGlhbSBHaXJkd29vZA0KPiA+PiA8bGdpcmR3b29k
QGdtYWlsLmNvbT47IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Ow0K
PiBSb2INCj4gPj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxt
YXJrLnJ1dGxhbmRAYXJtLmNvbT47DQo+ID4+IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRl
QGJheWxpYnJlLmNvbT47IFN0ZXBoZW4gQm95ZA0KPiA+PiA8c2JveWRAY29kZWF1cm9yYS5vcmc+
OyBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiA+PiBSdXNzZWxsIEtp
bmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az47IGRsLWxpbnV4LWlteA0KPiA+PiA8bGludXgtaW14
QG54cC5jb20+OyBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyBBLnMuIERvbmcNCj4g
Pj4gPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjggMS82XSBB
Uk06IGlteDZxOiBwcm92aWRlIGRvY3VtZW50YXRpb24gZm9yIG5ldw0KPiA+PiBmc2wscG1pYy1z
dGJ5LXBvd2Vyb2ZmIHByb3BlcnR5DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWog
UmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gPj4gQWNrZWQtYnk6IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4+IC0tLQ0KPiA+PiAgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2lteDZxLWNsb2NrLnR4dCB8IDggKysrKysrKysNCj4gPj4g
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg2cS1jbG9jay50eHQN
Cj4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14NnEtY2xv
Y2sudHh0DQo+ID4+IGluZGV4IGE0NWNhNjdhOWQ1Zi4uZTEzMDgzNDZlMDBkIDEwMDY0NA0KPiA+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14NnEtY2xv
Y2sudHh0DQo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9j
ay9pbXg2cS1jbG9jay50eHQNCj4gPj4gQEAgLTYsNiArNiwxNCBAQCBSZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KPiA+PiAgLSBpbnRlcnJ1cHRzOiBTaG91bGQgY29udGFpbiBDQ00gaW50ZXJydXB0DQo+
ID4+ICAtICNjbG9jay1jZWxsczogU2hvdWxkIGJlIDwxPg0KPiA+Pg0KPiA+PiArT3B0aW9uYWwg
cHJvcGVydGllczoNCj4gPj4gKy0gZnNsLHBtaWMtc3RieS1wb3dlcm9mZjogQ29uZmlndXJlIEND
TSB0byBhc3NlcnQgUE1JQ19TVEJZX1JFUQ0KPiA+PiArc2lnbmFsDQo+ID4+ICsgIG9uIHBvd2Vy
IG9mZi4NCj4gPj4gKyAgVXNlIHRoaXMgcHJvcGVydHkgaWYgdGhlIFNvQyBzaG91bGQgYmUgcG93
ZXJlZCBvZmYgYnkgZXh0ZXJuYWwNCj4gPj4gK3Bvd2VyDQo+ID4+ICsgIG1hbmFnZW1lbnQgSUMg
KFBNSUMpIHRyaWdnZXJlZCB2aWEgUE1JQ19TVEJZX1JFUSBzaWduYWwuDQo+ID4gUE1JQ19PTl9S
RVEgZGlkbid0IGNvbm5lY3QgdG8gYW55IHBpbiBvZiBQTUlDIGluIHlvdXIgY2FzZT8NCj4gDQo+
IE5vLiBGaXJzdCwgaXQgd2FzIG9ubHkgb25lIGN1c3RvbWVyIHNwZWNpZmljIGlzc3VlLiBBZnRl
ciBzb21lIHJlc2VhcmNoIEkgZm91bmQNCj4gZXZlbiBwdWJsaWNseSBhdmFpbGFibGUgYm9hcmRz
IChmb3IgZXhhbXBsZSBSaW9UYm9hcmQpIHdoaWNoIGhhcyBzYW1lL3NpbWlsYXINCj4gZGVzaWdu
LiBBZnRlciBzZWVpbmcgdGhpcyBpbiBpbXg2IGRvY3VtZW50YXRpb24gYXMgdmFsaWQgcG93ZXIg
b2ZmIHdheSwgSSBoYXZlDQo+IG5vIGRvdWJ0cyAtIHRoZXJlIHNob3VsZCBiZSBldmVuIG1vcmUg
ZGV2aWNlcyBkb2luIHRoaXMgaW4gdGhlIHdpbGQuDQpOb3Qgc3VyZSB3aHkgdGhlIGN1c3RvbWVy
IGRpZG4ndCBmb2xsb3cgcmVmZXJlbmNlIGRlc2lnbiwgc2luY2UgUE1JQ19PTl9SRVEgY2FuDQpw
cm92aWRlIHBvd2VyIG9mZi9vbiBmZWF0dXJlIGJ5IHByZXNzaW5nIE9OT0ZGIGtleSB3aGljaCBj
b25uZWN0ZWQgT05PRkYNCnBpbiBvZiBpLm14NihPTk9GRiB3aWxsIHRvZ2dsZSBQTUlDX09OX1JF
USB0byBwb3dlciBvZmYvb24gUE1JQykuIFRoZSBvZmZpY2lhbA0KcG93ZXIgb2ZmL29uIHdheSAo
UE1JQ19PTl9SRVEpIGNhbiBhbHNvIHBvd2VyIG9mZiBhbGwgcG93ZXIgcmFpbHMgb2YgUEZVWkUg
ZXhjZXB0DQpzbnZzIGFzIHlvdXIgcGF0Y2ggZGlkIG9uIFBNSUNfU1RCWV9SRVEuICBQTUlDX1NU
QllfUkVRIGlzIHVzZWQgdG8gbm90aWZ5IHBtaWMNCnN3aXRjaCBwb3dlciBtb2RlIChQRk0vQVBT
KSBvciBkZWNyZWFzZSB2b2x0YWdlIHRvIHNhdmUgcG93ZXIgaW4ga2VybmVsIHN1c3BlbmQsDQpu
b3QgcG93ZXIgb2ZmLi4uLkkgYW0gbm90IHN1cmUgaWYgd2UgbmVlZCB0aGlzIHBhdGNoc2V0IHRv
ICd3b3JrYXJvdW5kJyB0aGUgYm9hcmQgaXNzdWUuDQo+IA0KPiA+IERvbid0IHVuZGVyc3RhbmQN
Cj4gPiB3aHkgbm90IGZvbGxvdyBub3JtYWwgYm9hcmQgZGVzaWduIGd1aWRlIHRvIHBvd2VyIG9m
ZiBwbWljIGJ5DQo+IFBNSUNfT05fUkVRLg0KPiA+IEhvdyB0byBwb3dlciBvbiBib2FyZCBhZ2Fp
biB0aGVuPw0KPiANCj4gUG93ZXIgY3ljbGUuIFdpdGhvdXQgdGhpcyBwYXRjaCwgcG93ZXIgb2Yg
aXMgbm90IHJlYWwgcG93ZXIgb2ZmLiBTbywgcG93ZXIgY3ljbGUsDQo+IGlzIGV4cGVjdGVkIGJl
aGF2aW9yIGZvciB1c2VyIGludGVyYWN0aW9uLiBPbiB1c3VhbCBQQywgcmVzZXQgYnV0dG9uIHdp
bGwgbm90DQo+IGVuYWJsZSBQQyBhcyB3ZWxsLg0KWW91ciBib2FyZCBjYW4ndCBzdXBwb3J0IHdh
a2V1cCBieSBSVEMgYWxhcm0gaWYgbm90IHVzZSBQTUlDX09OX1JFUSB0byBwb3dlciBvZmYuDQpB
Z2Fpbiwgd2h5IHlvdXIgYm9hcmQgbm90IGZvbGxvdyB0aGUgZGVzaWduIGd1aWRlPw0K
