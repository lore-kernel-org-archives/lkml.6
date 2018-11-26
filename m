Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1BAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D961220664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="NcbvtWd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D961220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeKZR7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:59:46 -0500
Received: from mail-eopbgr1400104.outbound.protection.outlook.com ([40.107.140.104]:39264
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726153AbeKZR7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYWEV1HBssw2lfQYJAk9ilM7C55iQSjCPkXBs3HklvA=;
 b=NcbvtWd05xnPLgkduxPT8KDVK8yNpfpVYBxjXUwdUQdBwWAADFdNRcEWHxbEOEwAKdOcw6Z/+J5f0UDggtmESPiC0schIXlgl3e9fJXhR8dTobJMtPCXmGixsbvkMl4jOoKxZrKDZQti10xDdVFUWehTHdER5+Z7SwwJYb4I/Os=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB1511.jpnprd01.prod.outlook.com (52.134.225.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 26 Nov 2018 07:05:52 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::c070:7362:375f:74c5]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::c070:7362:375f:74c5%4]) with mapi id 15.20.1339.032; Mon, 26 Nov 2018
 07:05:52 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] phy: renesas: rcar-gen3-usb2: follow the hardware manual
 procedure
Thread-Topic: [PATCH] phy: renesas: rcar-gen3-usb2: follow the hardware manual
 procedure
Thread-Index: AQHUgXGduWh7Uy6zz0qMrwqNmf6bZ6VdAN6AgASj9dA=
Date:   Mon, 26 Nov 2018 07:05:52 +0000
Message-ID: <OSBPR01MB22935C64D5F0D06DA7391AB5D8D70@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1542787663-32142-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <f9a22d1d-6b40-0182-0be2-976494c95063@ti.com>
In-Reply-To: <f9a22d1d-6b40-0182-0be2-976494c95063@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.131]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1511;20:a5rOOjxKAYLMS4cW9RTddiwYltRf39hc/VPS0QO02zg2ihmjcnn9CFpMPjCrM1f17ED8hKPmt9TmbIi6enKg3aQfvJ97ozAWjir3tFCvTzep/480Y1PEErqC4zGu/WJFvzbNqf0FqQagzx1BtHeNp538xjJ9cesHuCNdAcXB/es=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4c9c52fd-0c29-47e8-e4de-08d6536d9a32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1511;
x-ms-traffictypediagnostic: OSBPR01MB1511:
x-microsoft-antispam-prvs: <OSBPR01MB151127FB770C03D6CC84E73CD8D70@OSBPR01MB1511.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB1511;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1511;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(26005)(76176011)(11346002)(66066001)(966005)(3846002)(6116002)(102836004)(186003)(476003)(7696005)(53546011)(478600001)(6506007)(6436002)(33656002)(256004)(99286004)(14454004)(486006)(575784001)(6246003)(6916009)(68736007)(6306002)(9686003)(5660300001)(7736002)(316002)(8676002)(81166006)(71200400001)(446003)(97736004)(25786009)(74316002)(4326008)(86362001)(54906003)(105586002)(305945005)(229853002)(81156014)(55016002)(106356001)(8936002)(71190400001)(53936002)(2906002)(299355004);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1511;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rMPc16PIa/LAiehxa2QZ8BAVo8c+duv9P3+kOi5PNK6LLITosT98BkQCObeYqNkb107scduKYfCaJF1fU6YKQGh5y7gpkurJ5HzoW1/kk6Vf8ijZS0fkFQXgGw8SINrPuvagoNBX2bljJBNEpXHkyOqi72o/4aqdyawKSokerZN0LPAQv3aD9PDVB9azKM/YcG/N8eB345f+NSX5/nDdTybCek3hvqifsTovC480J4LB5DK/S3Np2sdpo2j198PQMMqjboRDGNVKz+Szc48AeYjnaLENh58UdJA8R3eAaWKa6uSOj2/dxKsu0fTBXZtTIJDTY1Xer8mQ68dG4DC/OqXyJ3TQB0hUuN3B6Wmhqwc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9c52fd-0c29-47e8-e4de-08d6536d9a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 07:05:52.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLXNhbiwNCg0KPiBGcm9tOiBLaXNob24gVmlqYXkgQWJyYWhhbSBJLCBTZW50OiBG
cmlkYXksIE5vdmVtYmVyIDIzLCAyMDE4IDQ6NTUgUE0NCj4gDQo+IEhpLA0KPiANCj4gT24gMjEv
MTEvMTggMTo0MCBQTSwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBt
b2RpZmllcyByY2FyX2dlbjNfaW5pdF9vdGcoKSBwcm9jZWR1cmUgdG8gZm9sbG93IEZpZ3VyZQ0K
PiA+IDczLjQgb2YgIlItQ2FyIFNlcmllcywgM3JkIEdlbmVyYXRpb24gVXNlcidzIE1hbnVhbDog
SGFyZHdhcmUgUmV2LjEuMDAiLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNo
aW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBU
aGlzIHBhdGNoIGlzIGJhc2VkIG9uIHRoZSBsYXRlc3QgbGludXgtcGh5IC8gbmV4dCBicmFuY2gN
Cj4gPiAoY29tbWl0IGlkID0gMGViODZmYTc3ZjBmMGM4MTYzMWEwMzBmMTA2NzlhNDVjMDVkZjMz
YSkuDQo+IA0KPiBUaGlzIHBhdGNoIGhhcyBzb21lIHdlaXJkIGNoYXJhY3RlcnMgd2hpY2ggSSBz
YXcgd2hpbGUgYXBwbHlpbmcuDQo+IA0KPiBZb3UgY2FuIHNlZSAiPTIwIiwgPTNEIGluIHRoZSBy
YXcgZm9ybWF0DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTU0Mjc4NzY2My0zMjE0
Mi0xLWdpdC1zZW5kLWVtYWlsLXlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tL3Jhdw0K
PiANCj4gUGxlYXNlIGZpeCBhbmQgcmVwb3N0IHRoZSBwYXRjaC4NCg0KSSBndWVzcyB0aGlzIGlz
c3VlIHNlZW1zIG91ciBjb21wYW55J3MgZW1haWwgc2VydmVyIGlzc3VlLi4NCg0KLSBGcm9tIHRo
aXMgbW9udGgsIG91ciBlbWFpbHMgYWRkICJDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiBxdW90
ZWQtcHJpbnRhYmxlIiBpbiB0aGUgaGVhZGVyLg0KIC0tPiBTbywgd2UgY2FuIHNlZSAiPTIwIiBh
bmQgIj0zRCIgb24gbXkgZW1haWxzLi4uIA0KLSBFdmVuIGlmIEkgdHJpZWQgdG8gdXNlIHNvbWUg
b3B0aW9ucyBbMV0gb24gZ2l0IHYyLjE5LjIsIHRoZSBlbmNvZGluZyBpcyBzdGlsbCAicXVvdGVk
LXByaW50YWJsZSIuDQoNCkknbSBhc2tpbmcgb3VyIElUIHRlYW0gYWJvdXQgdGhpcyBiZWhhdmlv
ciBub3cuIEJ1dCwgSSBndWVzcyBpdCBuZWVkcyBtb3JlIHRpbWUuLi4NClNvLCBpZiBwb3NzaWJs
ZSwgd291bGQgeW91IHVzZSBtYm94IGZvcm1hdCBbMl0gdG8gYXBwbHkgdGhpcyBwYXRjaD8NCg0K
WzFdDQogY2FzZSAxOg0KICAgLS10cmFuc2Zlci1lbmNvZGluZz03Yml0DQogY2FzZSAyOg0KICAg
LS10cmFuc2Zlci1lbmNvZGluZz03Yml0IC0tY29tcG9zZS1lbmNvZGluZz11cy1hc2NpaQ0KDQpb
Ml0NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA2OTIwOTEvbWJveC8NCg0K
QmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiBUaGFua3MNCj4gS2lzaG9uDQo+
ID4NCj4gPiAgZHJpdmVycy9waHkvcmVuZXNhcy9waHktcmNhci1nZW4zLXVzYjIuYyB8IDE3ICsr
KysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3JlbmVzYXMv
cGh5LXJjYXItZ2VuMy11c2IyLmMgYi9kcml2ZXJzL3BoeS9yZW5lc2FzL3BoeS1yY2FyLWdlbjMt
dXNiMi5jDQo+ID4gaW5kZXggZDBmNDEyYy4uYTllNTNlOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3BoeS9yZW5lc2FzL3BoeS1yY2FyLWdlbjMtdXNiMi5jDQo+ID4gKysrIGIvZHJpdmVycy9w
aHkvcmVuZXNhcy9waHktcmNhci1nZW4zLXVzYjIuYw0KPiA+IEBAIC0zMDcsMTYgKzMwNywyMSBA
QCBzdGF0aWMgdm9pZCByY2FyX2dlbjNfaW5pdF9vdGcoc3RydWN0IHJjYXJfZ2VuM19jaGFuICpj
aCkNCj4gPiAgCXZvaWQgX19pb21lbSAqdXNiMl9iYXNlID0gY2gtPmJhc2U7DQo+ID4gIAl1MzIg
dmFsOw0KPiA+DQo+ID4gKwlyY2FyX2dlbjNfc2V0X2xpbmVjdHJsKGNoLCAwLCAxKTsNCj4gPiAr
CXZhbCA9IHJlYWRsKHVzYjJfYmFzZSArIFVTQjJfTElORUNUUkwxKTsNCj4gPiArCXdyaXRlbCh2
YWwgfCBVU0IyX0xJTkVDVFJMMV9EUFJQRF9FTiB8IFVTQjJfTElORUNUUkwxX0RNUlBEX0VOLA0K
PiA+ICsJICAgICAgIHVzYjJfYmFzZSArIFVTQjJfTElORUNUUkwxKTsNCj4gPiArDQo+ID4gIAl2
YWwgPSByZWFkbCh1c2IyX2Jhc2UgKyBVU0IyX1ZCQ1RSTCk7DQo+ID4gIAl3cml0ZWwodmFsIHwg
VVNCMl9WQkNUUkxfRFJWVkJVU1NFTCwgdXNiMl9iYXNlICsgVVNCMl9WQkNUUkwpOw0KPiA+IC0J
d3JpdGVsKFVTQjJfT0JJTlRfQklUUywgdXNiMl9iYXNlICsgVVNCMl9PQklOVFNUQSk7DQo+ID4g
LQlyY2FyX2dlbjNfY29udHJvbF9vdGdfaXJxKGNoLCAxKTsNCj4gPiAgCXZhbCA9IHJlYWRsKHVz
YjJfYmFzZSArIFVTQjJfQURQQ1RSTCk7DQo+ID4gIAl3cml0ZWwodmFsIHwgVVNCMl9BRFBDVFJM
X0lEUFVMTFVQLCB1c2IyX2Jhc2UgKyBVU0IyX0FEUENUUkwpOw0KPiA+IC0JdmFsID0gcmVhZGwo
dXNiMl9iYXNlICsgVVNCMl9MSU5FQ1RSTDEpOw0KPiA+IC0JcmNhcl9nZW4zX3NldF9saW5lY3Ry
bChjaCwgMCwgMCk7DQo+ID4gLQl3cml0ZWwodmFsIHwgVVNCMl9MSU5FQ1RSTDFfRFBSUERfRU4g
fCBVU0IyX0xJTkVDVFJMMV9ETVJQRF9FTiwNCj4gPiAtCSAgICAgICB1c2IyX2Jhc2UgKyBVU0Iy
X0xJTkVDVFJMMSk7DQo+ID4gKw0KPiA+ICsJbXNsZWVwKDIwKTsNCj4gPiArDQo+ID4gKwl3cml0
ZWwoVVNCMl9PQklOVF9CSVRTLCB1c2IyX2Jhc2UgKyBVU0IyX09CSU5UU1RBKTsNCj4gPiArDQo+
ID4gKwlyY2FyX2dlbjNfY29udHJvbF9vdGdfaXJxKGNoLCAxKTsNCj4gPg0KPiA+ICAJcmNhcl9n
ZW4zX2RldmljZV9yZWNvZ25pdGlvbihjaCk7DQo+ID4gIH0NCj4gPg0K
