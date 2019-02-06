Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27496C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0BB2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="izAwfGLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfBFA6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:58:23 -0500
Received: from mail-eopbgr1320124.outbound.protection.outlook.com ([40.107.132.124]:13427
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfBFA6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOGH1JLFxgCluK7GlYWPllF01RDD/gnkdJcmY+iliD4=;
 b=izAwfGLZSdL3E3gywKqvDC4Uwrfe+W3YXu2Qy9oZKMCVl9HCo2WacOlQ4XAEZ3gLoUiWts+PKXwFp8Y5tNDnlIT28MNprVw9Wf7/50nw4+dtB8+ezvrWTQT/3r8QCI8wzAT6H+TiiiWXhIFg19PTKO6UqODWAZuTzMkgAUSQqCY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0204.APCP153.PROD.OUTLOOK.COM (52.133.194.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.5; Wed, 6 Feb 2019 00:57:49 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1622.006; Wed, 6 Feb 2019
 00:57:49 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
Thread-Topic: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM
 family
Thread-Index: AQHUu+TohgnD5hWBBUGGy2lRJKF6bKXOWb4AgAABhxCAABYTAIACWocAgACoJYCAAD5HUA==
Date:   Wed, 6 Feb 2019 00:57:48 +0000
Message-ID: <PU1P153MB01691648EF8354319EA0244CBF6F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
 <PU1P153MB0169BD9237F2DC1FA64721BABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4h0B0sBMjiAC=Tk=Mu58A4vZ5F9yUPQsXqf5jyYF37VCw@mail.gmail.com>
 <PU1P153MB0169F7C111EEC5890D3F840ABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4iMau=fvOfubDvK=cg5v5287TvXqBCm=p8nqbz2es6YEg@mail.gmail.com>
 <PU1P153MB0169997F36D28D8EA80923CFBF6E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4h6xBmsO+KrJas2YcsZRayn50UVGp1Sjs3nv4+_6XwGLA@mail.gmail.com>
In-Reply-To: <CAPcyv4h6xBmsO+KrJas2YcsZRayn50UVGp1Sjs3nv4+_6XwGLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-06T00:57:46.5681496Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f403b4d-3113-412a-87c9-205204dcb463;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:5896:cf8a:cefe:fd7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0204;6:MM75OjwrkhAlxDckfUP75fi9AHmPfmY82AWQowUVuJP2vr39NIEWKPkNjvDjcypPgnEzEEQkMWqzRFZXoGleDMbVvl1kuN2StCdJBkcgmlKcAvOpCpq0RuhNMGiCQ2OsGzoeZDbVbs1DFO99p7BoYjEQ5oXRQJbJX1wDd1CNXd7EqMvGCAMmn1eLjOprtF6P4jXE3snT9HEkouFor1lTes14lT5ZB+Wb/GxIdnElIGqHGjSSPC8dGVevZ+xgjb4n9h1aEKbJgdGwLXd5fa0b0uAeigwPcwkNFlabTtoxw/fncM5yj/NHKn3XTbBJhbD1AWyh5xIRu11kIR1+AmZW4GXUJj46y0WjUp3efM9DDErfeCgv/Xetffr5gJf050aK+aFigPTZNiWyRqPNnJvDwdiM5fdTUJ0re35lHz1H7miHM2EkJbSB24kGehVM07OMq2Wmo5wdMV2phu6hYN03fg==;5:CdWTLODId+c6Cq1DAxJRIvBfjVyQ/QQ1uhWe6afoAqNWlXd9xV4TFzkuS4ofxMcdb4xO5CifbfuLJbV/JcE7pxTxssmlvG6n5PUi9iOiWrwdL4DqEB0XUKOxIlMRI5MJMkfWve4a4OjpOju0hr7De5h9w3bM60gEbNo+9qBZ+Qk0dBggFP3xCWDs3+bc2OWuyDaEHgD9dWPiLzGJXCmOoA==;7:6Sv2yNwwYGfTyD+sWHibA1GlrPagVLVqqg1l/TaUu2v+7lTbH9Lf10yfExZn//ZdILbwgu4+F1HRd9g/M0wjVedK/eBPfch95KHzLEdvwBwBLLeEiMxNET9maillSLsg9w5ozrLN+xKWrnC/2FjG+A==
x-ms-office365-filtering-correlation-id: 4a650513-8788-41b2-d83e-08d68bce1d8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0204;
x-ms-traffictypediagnostic: PU1P153MB0204:
x-microsoft-antispam-prvs: <PU1P153MB020419173F9F5949661FE665BF6F0@PU1P153MB0204.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(189003)(69234005)(11346002)(446003)(25786009)(99286004)(53936002)(22452003)(33656002)(316002)(107886003)(4326008)(46003)(6246003)(9686003)(6436002)(76176011)(229853002)(7696005)(102836004)(186003)(55016002)(6506007)(53546011)(54906003)(86612001)(105586002)(14454004)(106356001)(86362001)(486006)(93886005)(71200400001)(2906002)(71190400001)(10290500003)(81156014)(478600001)(81166006)(6116002)(8936002)(97736004)(10090500001)(6916009)(8990500004)(305945005)(14444005)(256004)(68736007)(74316002)(8676002)(476003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0204;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZH497qRqI6lGQ2+AgWCcLNbk254NkJv00EgPyR3xHNZqPTIQNCdGQmEAC/Tvtfg+BVnDZis2ydGIYn31ypSAGQVQqcTGkfSl3rlS455AdI7saIU7d3MeZPYAZLj37Xi/hlEZ0V/JDn9IzedmiCUwTNZ9hoyVetP51va+B0/9mJ2W72kG0+/ydZ/nuzejAFol72ABGpJDHGMO4gqCF4VqPPC+E/ZFo0MYaeadAi2L47KgiJeRwYwRIUwt/vDHWLH07ysp7g17kOcHPOmqNSUU8cpXPgWpq/jakq7yLyC8uWFqTsjjcfIjBrUFOjTqC6tPcxo2s+q4yRBOtxik72xwBkWGceHUE2QFP3onDXCIzVK9Hjn6JJwSWX1L1qtpgbhi8Fvb/VFxdrKuF6VdGaSWuZF4rk/ye4eNmrwi4s6I2xA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a650513-8788-41b2-d83e-08d68bce1d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 00:57:49.0740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgRmVicnVhcnkgNSwgMjAxOSA5OjEyIEFNDQo+IE9uIFR1ZSwgRmViIDUsIDIwMTkg
YXQgODo1MyBBTSBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPg0K
PiA+ID4gRnJvbTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4g
PiBTZW50OiBTdW5kYXksIEZlYnJ1YXJ5IDMsIDIwMTkgMTE6MTQgQU0NCj4gPiA+ID4gLi4uDQo+
ID4gPiA+IEFzIEkgdW5kZXJzdGFuZCwgdGhlIGVzc2VuY2Ugb2YgdGhlIGlzc3VlIGlzOiBIeXBl
ci1WIGVtdWxhdGVzIHRoZQ0KPiA+ID4gPiBsYWJlbCBtZWNoYW5pc20gKGkuZS4gaXQgc3VwcG9y
dHMgX0xTSSBhbmQgTFNSKSwgYnV0IGRvZXNuJ3QgZG8gaXQNCj4gPiA+ID4gcmlnaHQgKGkuZS4g
aXQgZG9lc24ndCBzdXBwb3J0IF9MU1cpLg0KPiA+ID4gPg0KPiA+ID4gPiBUbyBtYW5hZ2UgdGhl
IG5hbWVzcGFjZXMsIExpbnV4IGNhbiBjaG9vc2UgdG8gdXNlIGxhYmVsIG9yIG5vdC4NCj4gPiA+
ID4NCj4gPiA+ID4gSWYgX0xTSS9fTFNSIGFyZSBzdXBwb3J0ZWQsIExpbnV4IGFzc3VtZXMgX0xT
VyBpcyBzdXBwb3J0ZWQgYXMgd2VsbA0KPiA+ID4gPiBhbmQgY2hvb3NlcyB0byB1c2UgbGFiZWwg
KGkuZS4gdGhlIGxhYmVsIG1vZGUpLCBidXQgc2luY2UgSHlwZXItViBkb2Vzbid0DQo+ID4gPiA+
IHN1cHBvcnQgX0xTVywgTGludXggZmFpbHMgdG8gY2hhbmdlIHRoZSBuYW1lc3BhY2UgY29uZmln
dXJhdGlvbi4NCj4gPiA+DQo+ID4gPiBObywgdGhhdCdzIG5vdCBxdWl0ZSByaWdodC4gVGhlIHJl
YXNvbiBMaW51eCBkb2VzIG5vdCBzZWUgdGhlIGZzZGF4DQo+ID4gPiBtb2RlIGNvbmZpZ3VyYXRp
b24gaXMgZHVlIHRvIHRoZSBtaXNzaW5nICJhZGRyZXNzIGFic3RyYWN0aW9uIEdVSUQiIGluDQo+
ID4gPiB0aGUgbGFiZWwgcHJvZHVjZWQgdGhlIGRlZmF1bHQgSHlwZXItViBjb25maWd1cmF0aW9u
Lg0KPiA+IEhpIERhbiwNCj4gPiBEbyB5b3UgbWVhbiBOVkRJTU1fREFYX0dVSUQ/DQo+IA0KPiBD
b3JyZWN0Lg0KRllJOiBpbiBjcmVhdGVfbmFtZXNwYWNlX3BtZW0oKSwgbGFiZWwwLT5hYnN0cmFj
dGlvbl9ndWlkIGlzIGd1aWRfbnVsbCBpbg0KdGhlIGNhc2Ugb2YgSHlwZXItViBOVkRJTU0uIEl0
IGxvb2tzIEh5cGVyLVYgZG9lcyd0IHVzZSB0aGUgZ3VpZC4NCg0KPiA+ID4gSW4gbGFiZWwtbGVz
cyBtb2RlIHRoZXJlIGlzIG5vICJhZGRyZXNzIGFic3RyYWN0aW9uIEdVSUQiIHRvIHZhbGlkYXRl
IHNvDQo+ID4gPiBpdCBmYWxscyBiYWNrIHRvIGp1c3QgdXNpbmcgdGhlIGluZm8tYmxvY2sgZGly
ZWN0bHkuDQo+ID4gSW4gdGhlIGNhc2Ugb2Ygbm90IHVzaW5nIGxhYmVsIHN0b3JhZ2UgYXJlYSwg
YXMgSSB1bmRlcnN0YW5kIHRoZSBpbmZvLWJsb2NrDQo+ID4gcmVzaWRlcyBpbiByZWd1bGFyIGRh
dGEgc3RvcmFnZSBhcmVhLiBDYW4geW91IHBsZWFzZSB0ZWxsIG1lIHdoZXJlIGV4YWN0bHkNCj4g
PiB0aGUgaW5mby1ibG9jayBpcyBhbmQgaG93IGl0cyBsb2NhdGlvbiBpcyBkZWNpZGVkPw0KPiA+
IEFuZCBJIHN1cHBvc2UgdGhlIGluZm8tYmxvY2sgY29udGFpbnMgdGhlIE5WRElNTV9EQVhfR1VJ
RD8NCj4gDQo+IFRoZSBpbmZvLWJsb2NrIGFsd2F5cyBsaXZlcyBpbiB0aGUgZGF0YS1zdG9yYWdl
IGFyZWEsIGV2ZW4gd2l0aA0KPiBsYWJlbHMuIEl0J3MgcGxhY2VkIGF0IG5hbWVzcGFjZSBiYXNl
IGFkZHJlc3MgKyA0Sy4NCj4NCj4gV2hlbiBsYWJlbHMgYXJlIHByZXNlbnQgdGhlIGxhYmVsIGdp
dmVzIHRoZSBuYW1lc3BhY2UgYSB1dWlkIGFuZCB0aGUNCj4gaW5mby1ibG9jayAicGFyZW50IHV1
aWQiIGZpZWxkIG11c3QgbWF0Y2ggdGhhdCB2YWx1ZS4gV2l0aG91dCBsYWJlbHMNCj4gdGhlICJw
YXJlbnQgdXVpZCIgZmllbGQgaXMgdW51c2VkIC8gZmlsbGVkIHdpdGggemVybydzLiBBbHNvIHdp
dGggdjEuMg0KPiBsYWJlbHMgdGhlIGFkZHJlc3MgYWJzdHJhY3Rpb24gdXVpZCBtdXN0IG1hdGNo
IHRoZSBpbmZvLWJsb2NrIHR5cGUuDQpUaGFua3MgZm9yIGVsYWJvcmF0aW5nIG9uIHRoaXMhDQoN
Ckl0IGxvb2tzIHRoZSBsYWJlbCBtZWNoYW5pc20gaXMgZm9yIGFkdmFuY2VkIHVzYWdlcywgZS5n
LiwgYSBQTUVNIG5hbWVzcGFjZQ0KY2FuIGNvbnNpc3Qgb2YgbXVsdGlwbGUgTlZESU1Ncywgb3Ig
YSBuYW1lc3BhY2Ugb25seSB1c2VzIHBhcnQgb2YgdGhlDQpjYXBhY2l0eSBvZiBhIE5WRElNTSwg
b3IgYSBOVkRJTU0gY29udGFpbnMgYm90aCBQTUVNIGFuZCBCbG9jay1Nb2RlDQpuYW1lc3BhY2Vz
Lg0KDQpGb3IgYSBzaW1wbGUgdXNhZ2UsIGUuZy4gaWYgYSBOVkRJTU0gb25seSBjb250YWlucyBv
bmUgUE1FTSBuYW1lc3BhY2Ugd2hpY2gNCmNvbnN1bWVzIGFsbCB0aGUgc3RvcmFnZSBzcGFjZSBv
ZiB0aGUgTlZESU1NLCBpdCBsb29rcyB0aGUgbmFtZXNwYWNlIGNhbg0KYmUgbm9ybWFsbHkgdXNl
ZCB3aXRoIHRoZSBoZWxwIG9mIHRoZSBpbmZvLWJsb2NrLCBhbmQgd2UgZG9uJ3QgcmVhbGx5IG5l
ZWQNCnRoZSBsYWJlbC4gSU1PIHRoaXMgaXMgdGhlIGNhc2Ugb2YgSHlwZXItViwgaS5lLiB3ZSBk
b24ndCB1c2UgdGhlIGxhYmVsIGF0IGFsbCwNCnNpbmNlIF9MU1cgaXMgbm90IGltcGxlbWVudGVk
Lg0KDQo+ID4gSSdtIGFza2luZyBiZWNhdXNlIEkgZm91bmQgSSBsb3NlIH41MDBNQnl0ZXMgb2Yg
dGhlIDMyR0J5dGVzIEh5cGVyLVYNCj4gPiBOVkRJTU0gZGV2aWNlLCB3aGVuIHRoZSBuYW1lc3Bh
Y2UgaXMgaW4gZnNkYXggbW9kZS4gV2hlbiBpdCdzIGluDQo+ID4gcmF3IG1vZGUsIEknbSBhYmxl
IHRvIHVzZSBhbGwgb2YgdGhlIDMyR0Igc3BhY2UuDQo+IA0KPiBZZXMuIEEgcG9ydGlvbiBvZiB0
aGUgY2FwYWNpdHkgaXMgcmVzZXJ2ZWQgZm9yIHBhZ2Ugc3RydWN0dXJlcy4NCkdvdCBpdC4gSXQg
bG9va3MgdGhlIHNpemUgb2YgdGhlIGluZm8tYmxvY2sgKGFuZCB0aGUgcmVsYXRlZCBwYWRkaW5n
PykgaXMgMk1CLA0KYW5kICJ0aGUgb3ZlcmhlYWQgaXMgNjQtYnl0ZXMgcGVyIDRLICgxNkdCIHBl
ciAxVEIpIG9uIHg4NiIsIHNvIHRoZSB0b3RhbA0Kb3ZlcmhlYWQgaW4gbXkgMzJHQiBjYXNlIGlz
OiAyTUIgKyAzMkdCLyg0MDk2LzY0KSA9IDUxNE1CLg0KDQpUaGFua3MgZm9yIHNoYXJpbmcgdGhl
IGxpbmshIE5vdyBJIHJlYWxpemVkIHdlIGNhbiB1c2UgdGhlIC1NIHBhcmFtZXRlcg0KdG8gbm90
IHN0b3JlIHRoZSBwYWdlIG1ldGFkYXRhIGluIHRoZSBOVkRJTU06IA0KDQotTTsgLS1tYXA9DQpB
IHBtZW0gbmFtZXNwYWNlIGluIOKAnGZzZGF44oCdIG9yIOKAnGRldmRheOKAnSBtb2RlIHJlcXVp
cmVzIGFsbG9jYXRpb24gb2YNCnBlci1wYWdlIG1ldGFkYXRhLiBUaGUgYWxsb2NhdGlvbiBjYW4g
YmUgZHJhd24gZnJvbSBlaXRoZXI6DQrigJxtZW3igJ06IHR5cGljYWwgc3lzdGVtIG1lbW9yeQ0K
4oCcZGV24oCdOiBwZXJzaXN0ZW50IG1lbW9yeSByZXNlcnZlZCBmcm9tIHRoZSBuYW1lc3BhY2UN
Cg0KVGhhbmtzLA0KLS1EZXh1YW4NCg0K
