Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB959C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D272133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gX++ufgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeLSIoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:44:24 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:8608
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbeLSIoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EDB9wEypZutysimhziXnmW8uj+Yv9jWeKFCTvn8qeY=;
 b=gX++ufgmDpbFTXyjkieWCzJ9Ydc9M4MYx5xQymcx7FGNtGdEpEk1W/NX1B6GDIylsSeNRBWdYU83UvoghuCOVU5PuVO0i40ouxtBOY6BxAoPQfsAwmqbEKhgHfGlBuy920hP1iQbRaeeSDZn5nI+D7RLYAzXfKshoHEMbr49ePs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 08:44:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 08:44:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx6sl: correct PWM ipg clock source
Thread-Topic: [PATCH] ARM: dts: imx6sl: correct PWM ipg clock source
Thread-Index: AQHUl11+amh7uXSlqkCpQPqjHNiM7qWFvTEAgAAASUA=
Date:   Wed, 19 Dec 2018 08:44:13 +0000
Message-ID: <DB3PR0402MB39160D8B04AE55D1E2829067F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1545197799-9082-1-git-send-email-Anson.Huang@nxp.com>
 <20181219083640.42jmibqzn2t3i4t2@pengutronix.de>
In-Reply-To: <20181219083640.42jmibqzn2t3i4t2@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3705;6:mV3XgHx3kA/eyiawutY3xi3Ws4wTAQJXAG5bZAClKy+D3OwDrhMUMnHo0PDE4+FWhgO6F7lIcyFd5+gxRM1gEbUhMWeSdWaA140JwdhfrHlluCWGuFXOGeKC70+z7vdq0whBJ3YtXc2/G5TFrrrn4Q0/EiWh/P0oMcxBCymobqALCf+Eslmp5RH7YyAPMJtBEx4HBo7KKtISV+fLcuYeYW0eWvjFA24LFsPwlG8MEOjyvOSFAD/5w372kCsiGT0BoN+O+p9vNFp8vjRwjaeKCpDgZ7oxn+S0f6CH9Ef+5G4WwECc5m7QxPDoOSMWI68IX9QWZYFUrTGNH5i9WMTq0XsSSpndFl2GZFUlJcfqfTlP7TitOqC4tyhlyKbC2t2iliW5i89WL7pWj0avgCvnbou+ty7z3ED8eXrgqrstGT2ZcJWnPP+nUALLXl3ZCK+YcWDoHyrR+tjowe8nn8AjSA==;5:NxV894GO1idWoOScLm8MROMH2uwruIU6hKcR0dUROudqwRbqltqUPej40u0lUf8LA97nHxvTABn+0l5QhvoHM3myrO5+CqMNPV6MDX8EKkYOrBkfgJedwxAGgmgrNB6sdVhL0tMHjFWUS5E0oClzvOV0OcV1Yh3JKjyTd20YzYc=;7:rSrV5cdp47a6SrHHUNIlSKSnojWepwVAcNS0ghn69OpxKRxglt+wUWMA1c2SlzRikN6IjE2AgxvJc5VAacMYdVx+8Hw9eY0Tap/wseSXjgdy7OhHifDib0UGI8Xwcrom0eOXlMuZAGSyiS25ohBVTw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 12d5d23a-da9d-4753-ed66-08d6658e26fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:
x-microsoft-antispam-prvs: <DB3PR0402MB37057EFB8015523A9A53290DF5BE0@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231475)(944501520)(4982022)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3705;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3705;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(13464003)(33656002)(446003)(99286004)(97736004)(7416002)(8676002)(54906003)(102836004)(6436002)(8936002)(4326008)(476003)(53546011)(6506007)(5660300001)(486006)(44832011)(6116002)(26005)(3846002)(6246003)(7736002)(74316002)(256004)(53936002)(186003)(14444005)(81166006)(81156014)(2906002)(71190400001)(11346002)(71200400001)(305945005)(6916009)(6306002)(316002)(86362001)(575784001)(7696005)(68736007)(105586002)(66574012)(25786009)(9686003)(106356001)(45080400002)(966005)(14454004)(55016002)(229853002)(76176011)(478600001)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +TGTfAh24cHLZ6nvcikx+rKZFZlVGfWrAyXd3WfY3E3T2oopTNmuDqhajrd1egU/wVMS4EbmM/Cz50c8hCII6wgEydeAgbEBl+Nq2RBWF676A//uu7MpMkahMosD7dUvHT4p3jiIUKsBtDQC3sFp2+qhwN+xWXZRS7X41OBwUlHXM4/pV3qkQprgqZuJcJ6ZQCr5jKVb5rdqBWl+ACDpQyQz0kSDKOfjcHmYT55B0GiUK/88kZvS4gT+qzYr7HTg0bEjSTE2i8qvK+dIE9BOeuMuwMJFdS+FpDgI1GH3fZmN4pHx1HD3YtC3Ui20Y3yn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d5d23a-da9d-4753-ed66-08d6658e26fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 08:44:13.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgW21haWx0bzp1LmtsZWluZS1rb2VuaWdA
cGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IDIwMTjlubQxMuaciDE55pelIDE2OjM3DQo+IFRvOiBB
bnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gRmFi
aW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0K
PiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LXB3bUB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDZzbDog
Y29ycmVjdCBQV00gaXBnIGNsb2NrIHNvdXJjZQ0KPiANCj4gW0NjOiArPSBsaW51eC1wd21dDQo+
IA0KPiBIZWxsbywNCj4gDQo+IE9uIFdlZCwgRGVjIDE5LCAyMDE4IGF0IDA1OjQxOjMxQU0gKzAw
MDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEZyb20gaS5NWDZTTCBSZWZlcmVuY2UgTWFudWFs
LCB0aGUgUFdNeCdzIGlwZyBjbG9jayBmb3IgcmVnaXN0ZXJzDQo+ID4gYWNjZXNzIGlzIGZyb20g
cGVyY2xrLCBjb3JyZWN0IHRoZW0uDQo+IA0KPiBJIGFzc3VtZSB0aGlzIGlzIHJlbGF0ZWQgdG8g
dGhlIHBhdGNoICJwd206IGlteDogYWRkIGlwZyBjbG9jayBvcGVyYXRpb24iPyBUaGlzDQo+IHBh
dGNoIGRvZXNuJ3QgZml4IGEgcmVhbCBwcm9ibGVtIGJlY2F1c2UgaW4gcHJhY3Rpc2UgcGVyY2xr
IGlzIGFscmVhZHkgZW5hYmxlZCwNCj4gcmlnaHQ/IChJIGRvbid0IHF1ZXN0aW9uIHRoZSBwYXRj
aCwganVzdCB3b25kZXIgaG93IHVyZ2VudCBpdCBpcy4pDQoNClllcywgSSBtZXQgdGhlIGtlcm5l
bCBib290IHVwIGhhbmcgb24gaS5NWDdEIGFuZCBsb29rIGludG8gdGhlIFBXTSBtb2R1bGUgYW5k
DQpmb3VuZCB0aGF0IHRoZSBpcGdfY2xrX3MgaXMgZm9yIHJlZ2lzdGVyIGFjY2VzcywgYnV0IGRp
ZmZlcmVudCBpLk1YIFNvQyBjb3VsZCBoYXZlDQpkaWZmZXJlbnQgaXBnX2Nsa19zIGNsb2NrIHNv
dXJjZSwgc3VjaCBhcyBvbiBpLk1YNlFETCwgaXQgaXMgZnJvbSBpcGcgY2xvY2ssIHRoZSByZXN0
DQphcmUgZnJvbSBwZXJjbGssIHRoZXkgYXJlIGFsd2F5cyBPTiwgc28gbm8gaXNzdWUsIGJ1dCBv
biBpLk1YN0QsIHRoZSBpcGdfY2xrX3Mgb2YNClBXTSBtb2R1bGUgaXMgY29udHJvbGxhYmxlIGlu
IENDTSBDQ0dSLCBzbyB3ZSBoYXZlIHRvIGFkZCB0aGUgaXBnIGNsb2NrIG9wZXJhdGlvbg0KYXMg
d2VsbCBhcyBwZXJjbGsuDQoNCmkuTVg2U0wgY3VycmVudCBzZXR0aW5nIGhhcyBubyBpc3N1ZSwg
YmVjYXVzZSB0aGUgaXBnX2Nsa19zIGlzIGZyb20gcGVyY2xrIHdoaWNoIGlzIGFsd2F5cw0KT04s
IGJ1dCBpdCBkb2VzIE5PVCBtYXRjaCB0aGUgY2xvY2sgaW5mbyBpbiByZWZlcmVuY2UgbWFudWFs
LCB3aGlsZSBvdGhlciBpLk1YNiBTb0NzDQphcmUgaGF2aW5nIGNvcnJlY3QgY2xvY2sgc2V0dGlu
Z3MgZm9yIFBXTSBJUEcgY2xvY2suIA0KDQpJdCBpcyBqdXN0IGFuIGltcHJvdmVtZW50LCBOT1Qg
Zml4IGEgcmVhbCBwcm9ibGVtLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9p
bXg2c2wuZHRzaSB8IDggKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9pbXg2c2wuZHRzaQ0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsLmR0c2kgaW5k
ZXggZTc1MjRlNy4uNGI0ODEzZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9p
bXg2c2wuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbC5kdHNpDQo+ID4g
QEAgLTMzOCw3ICszMzgsNyBAQA0KPiA+ICAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14NnNsLXB3
bSIsICJmc2wsaW14MjctcHdtIjsNCj4gPiAgCQkJCXJlZyA9IDwweDAyMDgwMDAwIDB4NDAwMD47
DQo+ID4gIAkJCQlpbnRlcnJ1cHRzID0gPDAgODMgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4g
LQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlNMX0NMS19QV00xPiwNCj4gPiArCQkJCWNsb2NrcyA9
IDwmY2xrcyBJTVg2U0xfQ0xLX1BFUkNMSz4sDQo+ID4gIAkJCQkJIDwmY2xrcyBJTVg2U0xfQ0xL
X1BXTTE+Ow0KPiA+ICAJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQo+IA0KPiBJdCdz
IGEgYml0IGlycml0YXRpbmcgdGhhdCBJTVg2U0xfQ0xLX1BFUkNMSyBpcyB1c2VkIGZvciB0aGUg
ImlwZyIgY2xrLCBub3QgdGhlDQo+ICJwZXIiIGNsay4gSXMgdGhpcyBjb3JyZWN0Pw0KDQpZZXMs
IHlvdSBjYW4gY2hlY2sgdGhlIGkuTVg2U0wgQ0NNIGNoYXB0ZXIgZm9yIFBXTSBjbG9ja3MsIHRo
ZSBpcGdfY2xrX3MNCmlzIGZyb20gcGVyY2xrIGFuZCBpdHMgZW5hYmxlZCBjb250cm9sIGlzIFZD
QyB3aGljaCBpcyBhbHdheXMgT04uIFRoZSAicGVyIg0KY2xvY2sgaXMgZm9yIFBXTSBmdW5jdGlv
biwgTk9UIHJlZ2lzdGVyIGFjY2VzcywgSSB0cmllZCBkaXNhYmxpbmcgdGhlIFBXTSBwZXIgY2xv
Y2ssDQpQV00gcmVnaXN0ZXJzIHN0aWxsIGNhbiBiZSBhY2Nlc3NlZC4NCg0KQW5zb24uDQoNCj4g
DQo+IEJlc3QgcmVnYXJkcw0KPiBVd2UNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IFV3ZSBLbGVpbmUtS8O2bmlnDQo+IHwNCj4gSW5kdXN0
cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6Ly9lbWVhMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3Lg0K
PiBwZW5ndXRyb25peC5kZSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAu
Y29tJTdDN2JmDQo+IGZjN2JhZDYxNTQ1ZmI1OTU1MDhkNjY1OGQxZDBmJTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTljNWMzMDE2MzUNCj4gJTdDMCU3QzAlN0M2MzY4MDgwNTQxNDE3MzM0MTcmYW1w
O3NkYXRhPWREdjJzcEl3YlFta3B1N21oRW0NCj4gOGJSSHlLS3ZpU08lMkJRMzNaVTduRDFiSlEl
M0QmYW1wO3Jlc2VydmVkPTAgIHwNCg==
