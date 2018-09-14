Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9BDC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286E62086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UR0rt7VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286E62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeINFu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:50:26 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:51790
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeINFu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tBg7/PrlGMTuiAOmdsRf5MOTt2BMjYgsNfUk0nnYgk=;
 b=UR0rt7VF3oa3LzOVg29GugAX5p2SMzmSv50ZaC39OP3qhDqhSY0E2NmTyatPhYcAcxiMLuqVRwp9F/tqvzjhhKUnqXCEqx1dWeCoDC4/DHuUxC9+EbYW+j2ZxVsoDQ4utRjij1Qxnht9rOZL735aEkrHo6GyjA0rlzKJMklmNzw=
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com (20.177.55.216) by
 VI1PR04MB4159.eurprd04.prod.outlook.com (52.133.15.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 14 Sep 2018 00:38:23 +0000
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::806e:6caa:e774:689f]) by VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::806e:6caa:e774:689f%4]) with mapi id 15.20.1122.021; Fri, 14 Sep 2018
 00:38:23 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>, Angus Ainslie <angus@akkea.ca>
CC:     Peter Chen <hzpeterchen@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: RE: [PATCH v3] usb: typec: get the vbus source and charge values from
  the devicetree
Thread-Topic: [PATCH v3] usb: typec: get the vbus source and charge values
 from  the devicetree
Thread-Index: AQHUS1JYxlnWFjVdqUGB7lFiUCPer6TueYIAgABnCwA=
Date:   Fri, 14 Sep 2018 00:38:23 +0000
Message-ID: <VI1PR04MB4558AD79C67A00CAF539476289190@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180911145931.32441-1-angus@akkea.ca>
 <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com>
 <9d7431e51aa069f288dd4bf39e9db9f1@www.akkea.ca>
 <20180912163259.GC3300@roeck-us.net>
 <CAL411-qmQ23=hfXX3s5Zo100rSASrByMWR70qLZ8cWqt9hPgSg@mail.gmail.com>
 <aa08abf87b945dc5c8268fab3cb55cbb@www.akkea.ca>
 <20180913173452.GA10115@roeck-us.net>
In-Reply-To: <20180913173452.GA10115@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4159;6:9hnXS+DrLtIQI+Yp+mLkp6+e321Nhy5xSXHjjIzqtilFecT8VKqbAbRLcWB3VRPnWm+m1uQqW+NhQaDwsaa+ITO/G0L5UFA4nJre67WZITJADdfbpwE9ZdQeIfMS0E/MlDZOedcrOwXbASC0jzE5s/xIHV3LwKq4zR2R1Rmi/FvenezIwEhPUi95x+N11A3I+ri3jZxquYJaOCvyYr4m8IYhmdkb5Ns87rtSqaBWfqefQF2J6ZhmT8fi8l8M7+xhzCGv/YoWhzg0pRaq96AmEMRsqVI2wHy/6J5mKpOMaH6073gvZiZZ3RrPpfOWDMb2xXqMKsj8LfTGbZnrHHneGVxM2bDY6pkXI6yVWFkgl+DGZTaD+Zk8LYSh9x9c4I5iikvxsSfz2Gkp7yRrcM3jEyojA1vT+pKbhRyfxr6aANQaDcSAddXOHOlQStxa5TTgEb3Hvav6Tnti4STXW/c7/g==;5:okpXMnk9cvOtiM6sgXlrLt8cXxY0xdLB7pIi5iK8OZDdeDBUMvj7jmS5AsTcWzrDgm0I0wCWmGZTX11qYwvLajMedqMqurjrlK/oLYKbdw9CyL+/WlA3YiTFG/HwwR2Qf28sYkG8G0KTDk7wkzLZEdYTmDFvdcuYp1nIgXRgE+Y=;7:SjYE5gtjPqtavUqvMpnX6eFXiBfmucuFZgH5FJSJVEfg7lmdCnTQ9VIHMkREuxtIdksql8r3GQ3IW89sgO4oyTGA33Glg6/sQLjT3QkN/nIt3EJ94/gyX2OV6VTm1rXeiDNmooMeK8FouzKH7bM6H2H6Vzaybv3x9Ya84ONDHngHdU3r4wg+/SaC08M1Q7SFzEhXS2RA1xDGrMAWXIxX4R3Xai8MYiljya67p8pwV8/vQ4PAPQMtim1HC5I1PrYY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 47ad2703-b189-40f8-8dfb-08d619da60bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4159;
x-ms-traffictypediagnostic: VI1PR04MB4159:
x-microsoft-antispam-prvs: <VI1PR04MB4159BDB2FD0B44A1D9BE0C2589190@VI1PR04MB4159.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:VI1PR04MB4159;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4159;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(45074003)(13464003)(199004)(189003)(2900100001)(44832011)(7696005)(102836004)(26005)(186003)(6346003)(53546011)(93886005)(76176011)(86362001)(5250100002)(4326008)(99286004)(6116002)(54906003)(3846002)(316002)(6506007)(476003)(446003)(106356001)(486006)(105586002)(5660300001)(25786009)(2906002)(11346002)(110136005)(478600001)(256004)(14454004)(68736007)(39060400002)(97736004)(53936002)(229853002)(74316002)(305945005)(7736002)(8936002)(8676002)(81156014)(33656002)(55016002)(9686003)(6246003)(81166006)(66066001)(6436002)(15583001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4159;H:VI1PR04MB4558.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-microsoft-antispam-message-info: S01RK3k+RKX52bJFxT9QYcRD/LC3bXJUw40mNnslv6A3ke4MiqKZIuQVgjpkQ5Sw5jvZrUJfH7AhAbgUBOM6w1Iyipazvy/RSoG8qF4pvTAfnGobtG4DWnSURM1EY3zQ5oMWDRLkcZk+iUQFfcWnFYvTOTUEYLBDTQKSNsnjfJE1YPWJ5BY9DmV/2ocBX4CVv8j1sIJcEpriQu/+ufisp3no4N4WhoNT4NuHl3AyCD8fTLw9e345JW52GSOfXZ6wQrMTnDfDvZ/+szz4WdFycbSG22VgAR8A/ApMC2lNuqRerwDMPmaCFstfXzLpJNv5VxvPVBHGEjjXHoLVfdSRfb6Iu/ZF5GMJkST6tIrUxnw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ad2703-b189-40f8-8dfb-08d619da60bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 00:38:23.4021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IDIw
MTjE6jnUwjE0yNUgMTozNQ0KPiBUbzogQW5ndXMgQWluc2xpZSA8YW5ndXNAYWtrZWEuY2E+DQo+
IENjOiBQZXRlciBDaGVuIDxoenBldGVyY2hlbkBnbWFpbC5jb20+OyBIZWlra2kgS3JvZ2VydXMN
Cj4gPGhlaWtraS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4N
Cj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgbGludXgtdXNiQHZnZXIua2VybmVsLm9y
ZzsgbGttbA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFBldGVyIENoZW4gPHBl
dGVyLmNoZW5AbnhwLmNvbT47IEp1biBMaQ0KPiA8anVuLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjNdIHVzYjogdHlwZWM6IGdldCB0aGUgdmJ1cyBzb3VyY2UgYW5kIGNoYXJn
ZSB2YWx1ZXMgZnJvbSB0aGUNCj4gZGV2aWNldHJlZQ0KPiANCj4gT24gVGh1LCBTZXAgMTMsIDIw
MTggYXQgMDU6MTA6MDlBTSAtMDYwMCwgQW5ndXMgQWluc2xpZSB3cm90ZToNCj4gPiA+DQo+ID4g
PnN0YWdpbmc6IHR5cGVjOiBkb24ndCBkbyB2YnVzIHNvdXJjZSBkaXNhYmxlIGZvciBkZWFkIGJh
dHRlcnkNCj4gPiA+DQo+ID4gPkluIFBUTjUxMTAgZGVzaWduLCBEaXNhYmxlU291cmNlVkJVUyBj
b21tYW5kIGFsc28gZGlzYWJsZXMgdGhlIHNpbmsNCj4gPiA+ZW5hYmxlIHNpZ25hbCBiZWNhdXNl
IHRoZSBFTl9TTksgY2FuIGJlIHVzZWQgdG8gc291cmNlIGhpZ2hlcg0KPiA+ID52b2x0YWdlLCBh
bmQsIHRoZXJlIGlzIG9ubHkgb25lIFRDUEMgY29tbWFuZCB0byBkaXNhYmxlIHNvdXJjaW5nDQo+
ID4gPnZvbHRhZ2Ugd2l0aG91dCB0ZWxsaW5nIHdoZXRoZXIgdG8gZGlzYWJsZSA1ViBvciB0aGUg
aGlnaCB2b2x0YWdlLA0KPiA+ID5hbmQgdG8ga2VlcCB0aGUgZGVzaWduIHNpbXBsZSB0aGV5IGRl
c2lnbmVkIHRoZSBQVE41MTEwIHRvIGRpc2FibGUNCj4gPiA+Ym90aC4gd2l0aCB0aGlzIGZhY3Qs
IHdlIHVzZSB0aGUgZmxhZyBkcml2ZV92YnVzIHRvIGNoZWNrIGlmIHRoZQ0KPiA+ID5zb3VyY2Ug
dmJ1cyBlbmFibGUgd2FzIGlzc3VlZCwgaWYgeWVzIHdlIHRoZW4gZG8gdmJ1cyBzb3VyY2UgZGlz
YWJsZSwNCj4gPiA+aW4gZGVhZCBiYXR0ZXJ5IGNhc2UsIHdlIG5ldmVyIGRpZCB2YnVzIHNvdXJj
ZSBlbmFibGUsIHNvIHdpbGwgbm90DQo+ID4gPmlzc3VlIHZidXMgc291cmNlIGRpc2FibGUgY29t
bWFuZC4NCj4gPiA+DQo+ID4NCj4gPiBUaGFua3MgUGV0ZXIsIHRoaXMgc291bmRzIGxpa2UgdGhl
IG1pc3NpbmcgcGllY2Ugb2YgaW5mb3JtYXRpb24gYW5kIEkNCj4gPiB0aGluayBzb21lIGZvcm0g
b2YgdGhlIGNvZGUgYmVsb3cgd2lsbCBmaXggdGhhdC4NCj4gPg0KPiA+IFRoZXJlIGlzIHN0aWxs
IHRoZSBpc3N1ZSB0aGF0IG15IGJvYXJkIHdpbGwgbmVlZCBzb21lIHdheSBvZg0KPiA+IGNvbnRy
b2xsaW5nIHRoZSBpbml0aWFsIHN0YXRlIG9mIHZidXMtc2luay4NCj4gPg0KPiA+IEBHdWVudGVy
OiB3b3VsZCBteSBpbml0aWFsIHBhdGNoIGJlIGFjY2VwdGFibGUgdG8gc2V0IHRoZSBkZWZhdWx0
DQo+ID4gc3RhdGUgb2YgdmJ1cy1zb3VyY2UgYW5kIHZidXMtc2luay4gV291bGQgeW91IGxpa2Ug
c29tZSBjb2RlIHRvIHNhbml0eQ0KPiA+IGNoZWNrIHRoYXQgYm90aCB3ZXJlIG5vdCBlbmFibGVk
IGF0IHRoZSBzYW1lIHRpbWUgPw0KPiA+DQo+IFNlZW1zIHRvIG1lIHRoaXMgaXMgaW5kZWVkIGEg
Y2hpcCBzcGVjaWZpYyBwcm9ibGVtLiBJIGRvbid0IHRoaW5rIGEgZml4IGJlbG9uZ3MgaW50byB0
aGUgdGNwbQ0KPiBjb2RlLiBBcyBtZW50aW9uZWQgYmVmb3JlLCB0aGUgY3VycmVudCBzdGF0dXMg
KGllIGRyaXZlX3ZidXMpIHNob3VsZCBiZSByZWFkYWJsZSBmcm9tIHRoZQ0KPiBjaGlwLiBJIGFt
IG5vdCBzdXJlIHRob3VnaCBpZiB3ZSBzaG91bGQgYWRkIGENCj4gUFRONTExMCBzcGVjaWZpYyBx
dWlyayB0byB0aGUgZHJpdmVyIHRvIGhhbmRsZSB0aGUgc2l0dWF0aW9uLiBJIGFtIGNvbmNlcm5l
ZCB0aGF0IGZpeGluZyB0aGlzDQo+IGFzIHN1Z2dlc3RlZCBiZWxvdyBmb3IgUFRONTExMCBtYXkg
Y2F1c2UgdHJvdWJsZSB3aXRoIG90aGVyIGNoaXBzLiBNYXliZSBub3QsIGJ1dCBJJ2QNCj4gcmF0
aGVyIGJlIGNhdXRpb3VzLg0KDQpZZXMsIHRoaXMgaXMgYSBjaGlwIHNwZWNpZmljIHByb2JsZW0s
IHRoZSByZWFzb24gRGlzYWJsZVNvdXJjZVZCVVMgY29tbWFuZCBhbHNvIGRpc2FibGVzDQp0aGUg
c2luayBlbmFibGUgc2lnbmFsIGJlY2F1c2UgdGhlIEVOX1NOSyBvZiBQVE41MTEwIGNhbiBiZSB1
c2VkIHRvIHNvdXJjZSBoaWdoZXIgdm9sdGFnZQ0KQW5kLCB0aGVyZSBpcyBvbmx5IG9uZSBUQ1BD
IGNvbW1hbmQgdG8gZGlzYWJsZSBzb3VyY2luZyB2b2x0YWdlIHdpdGhvdXQgdGVsbGluZyB3aGV0
aGVyIHRvDQpkaXNhYmxlIDVWIG9yIHRoZSBoaWdoIHZvbHRhZ2UsIGFuZCB0byBrZWVwIHRoZSBk
ZXNpZ24gc2ltcGxlLCBUUE41MTEwIGlzIGRlc2lnbmVkIHRvIGRpc2FibGUNCmJvdGguDQoNClRo
ZSBwYXRjaCBiZWxvdyBpcyB0byBub3QgaXNzdWUgYSB2YnVzIGRpc2FibGUgY29tbWFuZCBpZiBp
dCB3YXMgbm90IGVuYWJsZWQsDQpmcm9tIG15IHBvaW50IHZpZXcgaXQgc2hvdWxkIGJlIE9LIGFu
ZCBoYXMgdGhlIGJlbmVmaXQgdG8gc2F2ZSBvbmUgY29tbWFuZC4NCg0KTGkgSnVuDQo+IA0KPiBU
aGFua3MsDQo+IEd1ZW50ZXINCj4gDQo+ID4gPkFja2VkLWJ5OiBQZXRlciBDaGVuIDxwZXRlci5j
aGVuQG54cC5jb20+DQo+ID4gPlNpZ25lZC1vZmYtYnk6IExpIEp1biA8anVuLmxpQG54cC5jb20+
DQo+ID4gPi0tLQ0KPiA+ID4gZHJpdmVycy9zdGFnaW5nL3R5cGVjL3RjcGNpLmMgfCA1ICsrLS0t
DQo+ID4gPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+ID4NCj4gPiA+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy90eXBlYy90Y3BjaS5jDQo+
ID4gPmIvZHJpdmVycy9zdGFnaW5nL3R5cGVjL3RjcGNpLmMgaW5kZXggMmQ0ZmJiOGFhYzVlLi43
MzUyMjA3MjI0YjUNCj4gPiA+MTAwNjQ0DQo+ID4gPi0tLSBhL2RyaXZlcnMvc3RhZ2luZy90eXBl
Yy90Y3BjaS5jDQo+ID4gPisrKyBiL2RyaXZlcnMvc3RhZ2luZy90eXBlYy90Y3BjaS5jDQo+ID4g
PkBAIC0zODEsOSArMzgxLDggQEAgc3RhdGljIGludCB0Y3BjaV9zZXRfdmJ1cyhzdHJ1Y3QgdGNw
Y19kZXYgKnRjcGMsDQo+ID4gPmJvb2wgc291cmNlLCBib29sIHNpbmspDQo+ID4gPiAgc3RydWN0
IHRjcGNpICp0Y3BjaSA9IHRjcGNfdG9fdGNwY2kodGNwYyk7DQo+ID4gPiAgaW50IHJldDsNCj4g
PiA+DQo+ID4gPi0gLyogRGlzYWJsZSBib3RoIHNvdXJjZSBhbmQgc2luayBmaXJzdCBiZWZvcmUg
ZW5hYmxpbmcgYW55dGhpbmcgKi8NCj4gPiA+LQ0KPiA+ID4tIGlmICghc291cmNlKSB7DQo+ID4g
PisgLyogT25seSBkaXNhYmxlIHNvdXJjZSBpZiBpdCB3YXMgZW5hYmxlZCAqLyBpZiAoIXNvdXJj
ZSAmJg0KPiA+ID4rIHRjcGNpLT5kcml2ZV92YnVzKSB7DQo+ID4gPiAgcmV0ID0gcmVnbWFwX3dy
aXRlKHRjcGNpLT5yZWdtYXAsIFRDUENfQ09NTUFORCwNCj4gPiA+ICAgICBUQ1BDX0NNRF9ESVNB
QkxFX1NSQ19WQlVTKTsNCj4gPiA+ICBpZiAocmV0IDwgMCkNCj4gPg0KPiA+IFRoZSB2ZXJzaW9u
IG9mIHN0cnVjdCB0Y3BjaSBkb2Vzbid0IGhhdmUgYSBkcml2ZV92YnVzLiBXaGVyZSBzaG91bGQN
Cj4gPiBkcml2ZV92YnVzIGdldCBzZXQgYW5kIGNsZWFyZWQgPw0KPiA+DQo+ID4gSXMgdGhpcyBh
IG1vcmUgY29tcGxldGUgdmVyc2lvbiBvZiB3aGF0IHlvdSBpbnRlbmRlZCA/DQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvdHlwZWMvdGNwY2kuYyBiL2RyaXZlcnMvdXNiL3R5cGVj
L3RjcGNpLmMNCj4gPiBpbmRleCBhYzZiNDE4YjE1ZjEuLmQ2MTY4MTYzZGY3YiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy90Y3BjaS5jDQo+ID4gKysrIGIvZHJpdmVycy91c2Iv
dHlwZWMvdGNwY2kuYw0KPiA+IEBAIC0yOCw2ICsyOCw3IEBAIHN0cnVjdCB0Y3BjaSB7DQo+ID4g
ICAgICAgICBzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ID4NCj4gPiAgICAgICAgIGJvb2wgY29u
dHJvbHNfdmJ1czsNCj4gPiArICAgICAgIGJvb2wgZHJpdmVfdmJ1czsNCj4gPg0KPiA+ICAgICAg
ICAgc3RydWN0IHRjcGNfZGV2IHRjcGM7DQo+ID4gICAgICAgICBzdHJ1Y3QgdGNwY2lfZGF0YSAq
ZGF0YTsNCj4gPiBAQCAtMjc3LDcgKzI3OCw5IEBAIHN0YXRpYyBpbnQgdGNwY2lfc2V0X3ZidXMo
c3RydWN0IHRjcGNfZGV2ICp0Y3BjLA0KPiA+IGJvb2wgc291cmNlLCBib29sIHNpbmspDQo+ID4N
Cj4gPiAgICAgICAgIC8qIERpc2FibGUgYm90aCBzb3VyY2UgYW5kIHNpbmsgZmlyc3QgYmVmb3Jl
IGVuYWJsaW5nIGFueXRoaW5nDQo+ID4gKi8NCj4gPg0KPiA+IC0gICAgICAgaWYgKCFzb3VyY2Up
IHsNCj4gPiArICAgICAgIGlmICghc291cmNlICYmIHRjcGNpLT5kcml2ZV92YnVzKSB7DQo+ID4g
KyAgICAgICAgICAgICAgIHRjcGNpLT5kcml2ZV92YnVzID0gZmFsc2U7DQo+ID4gKw0KPiA+ICAg
ICAgICAgICAgICAgICByZXQgPSByZWdtYXBfd3JpdGUodGNwY2ktPnJlZ21hcCwgVENQQ19DT01N
QU5ELA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVENQQ19DTURfRElT
QUJMRV9TUkNfVkJVUyk7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+IEBA
IC0yOTIsNiArMjk1LDggQEAgc3RhdGljIGludCB0Y3BjaV9zZXRfdmJ1cyhzdHJ1Y3QgdGNwY19k
ZXYgKnRjcGMsDQo+ID4gYm9vbCBzb3VyY2UsIGJvb2wgc2luaykNCj4gPiAgICAgICAgIH0NCj4g
Pg0KPiA+ICAgICAgICAgaWYgKHNvdXJjZSkgew0KPiA+ICsgICAgICAgICAgICAgICB0Y3BjaS0+
ZHJpdmVfdmJ1cyA9IHRydWU7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICByZXQgPSByZWdt
YXBfd3JpdGUodGNwY2ktPnJlZ21hcCwgVENQQ19DT01NQU5ELA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVENQQ19DTURfU1JDX1ZCVVNfREVGQVVMVCk7DQo+ID4gICAg
ICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+IEBAIC01MDMsNiArNTA4LDcgQEAgc3RydWN0
IHRjcGNpICp0Y3BjaV9yZWdpc3Rlcl9wb3J0KHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2LCBzdHJ1
Y3QgdGNwY2lfZGF0YSAqZGF0YSkNCj4gPiAgICAgICAgIHRjcGNpLT5kZXYgPSBkZXY7DQo+ID4g
ICAgICAgICB0Y3BjaS0+ZGF0YSA9IGRhdGE7DQo+ID4gICAgICAgICB0Y3BjaS0+cmVnbWFwID0g
ZGF0YS0+cmVnbWFwOw0KPiA+ICsgICAgICAgdGNwY2ktPmRyaXZlX3ZidXMgPSBmYWxzZTsNCj4g
Pg0KPiA+ICAgICAgICAgdGNwY2ktPnRjcGMuaW5pdCA9IHRjcGNpX2luaXQ7DQo+ID4gICAgICAg
ICB0Y3BjaS0+dGNwYy5nZXRfdmJ1cyA9IHRjcGNpX2dldF92YnVzOw0KPiA+DQo+ID4NCj4gPg0K
