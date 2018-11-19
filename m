Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4E7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1572C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5X4Rju6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1572C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeKTFTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:19:12 -0500
Received: from mail-eopbgr720078.outbound.protection.outlook.com ([40.107.72.78]:17856
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbeKTFTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cuqz2DrwodHABC0ZcT+HDl7CrjsITSdd5Iu0xXzG74s=;
 b=5X4Rju6ddyYnsv5jokKgq1ngl7A29dTb4p0d02DPo4ZsIydJGrH+kXei/AUfZ107UWDg5zAtg6neD0Qt8wrceDwUpv2RLMO6yDyVRBQuHfxwhi3PoFyQZi4HpKwagE1uUMXSWvObwCdLfrjALWkfdTy/0nMcXgD6ecah8Bq1d0M=
Received: from BY1PR12MB0406.namprd12.prod.outlook.com (10.162.146.27) by
 BY1PR12MB0405.namprd12.prod.outlook.com (10.162.146.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Mon, 19 Nov 2018 18:54:17 +0000
Received: from BY1PR12MB0406.namprd12.prod.outlook.com
 ([fe80::94cb:cedf:281:79f2]) by BY1PR12MB0406.namprd12.prod.outlook.com
 ([fe80::94cb:cedf:281:79f2%6]) with mapi id 15.20.1339.026; Mon, 19 Nov 2018
 18:54:15 +0000
From:   "Zuo, Jerry" <Jerry.Zuo@amd.com>
To:     Lyude Paul <lyude@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Li, Roman" <Roman.Li@amd.com>, "S, Shirish" <Shirish.S@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] drm/amd/dm: Don't forget to attach MST encoders
Thread-Topic: [PATCH 1/2] drm/amd/dm: Don't forget to attach MST encoders
Thread-Index: AQHUfgOWyt5HmDUVPUGZom7lCHrra6VXLz5ggABGmoCAAAAysA==
Date:   Mon, 19 Nov 2018 18:54:15 +0000
Message-ID: <BY1PR12MB040655F28BDD2A6FA397AAA7E5D80@BY1PR12MB0406.namprd12.prod.outlook.com>
References: <20181116232443.1709-1-lyude@redhat.com>
         <20181116232443.1709-2-lyude@redhat.com>
         <BY1PR12MB0406C1EC0BCD2F6A295CCE3AE5D80@BY1PR12MB0406.namprd12.prod.outlook.com>
 <6033a16ccbc6e1286b4bfd082f0de9f0d60594b7.camel@redhat.com>
In-Reply-To: <6033a16ccbc6e1286b4bfd082f0de9f0d60594b7.camel@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerry.Zuo@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR12MB0405;20:qcHujwJXQaTCsmDNPaqyLCLijrcm7vCBxGxiEZxQ0DI6X2C8A6S33x7wl4HdaBcgcfz6B+IhyNtBCmggZnyo/P7vH6afAVdYwu/fC5taezm1TEv0hmm2F8ZUOW6yVkDd2f3NHgiEj1VgFN1913lm1dFwQcQfpFnP4CjOrYxTfhvUIFiwmi5uvFi7v4gEEDOlvHvRtBkvgrmn1warwHq8Et3X0ytZ5FRRLksjE/4TOTbPECv5Pj1JTS00veGMoKL0
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(346002)(136003)(13464003)(189003)(199004)(256004)(5024004)(14444005)(81156014)(8676002)(81166006)(8936002)(4001150100001)(2501003)(68736007)(97736004)(551934003)(33656002)(476003)(11346002)(14454004)(486006)(71200400001)(71190400001)(2906002)(6116002)(446003)(3846002)(106356001)(105586002)(2900100001)(6246003)(55016002)(5660300001)(86362001)(76176011)(25786009)(26005)(53546011)(102836004)(93886005)(110136005)(54906003)(4326008)(6506007)(186003)(316002)(305945005)(66066001)(7736002)(229853002)(74316002)(99286004)(478600001)(7696005)(72206003)(53936002)(6436002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0405;H:BY1PR12MB0406.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: fee292ec-c14c-4583-ae9e-08d64e50674e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY1PR12MB0405;
x-ms-traffictypediagnostic: BY1PR12MB0405:
x-microsoft-antispam-prvs: <BY1PR12MB0405837C349B38EAE2215FB2E5D80@BY1PR12MB0405.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR12MB0405;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0405;
x-forefront-prvs: 08617F610C
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: azQPgz9RP7En/nWBuc0oPAfdiJoWYjcdK1LIDSb/AagnbVtzrM5irEkxoMsqQaehEGra8tqZ8uSHmRToO1hzFwhzhvv0NYgVOaVtnuyXdwOXCouKomM5pxw9v4c8pbZxtqpwxfOOwhTLhQPr8R/QJvsePg/uF+5OVdld70fguvI7vw30AiX5zel6QrfGWdc2rlDSwmju8gvT7y2hJKuesLyhEM3w93A05y8QV4pbt1MwjHf6sGHsBTroF2EWsae4S9NfoUfbqmvFEMeW6+W6Rj+mP5PzHJXFCcoH66ccy2yTEXGNRHs6z2oWwVOAHKL+GU0fyMOhhCor1KLp5qLPwV32AOve26n2ewmZLl27Ffg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee292ec-c14c-4583-ae9e-08d64e50674e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 18:54:15.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VyZSwgSSdsbCBkbyBpdC4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEx5
dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+IA0KU2VudDogTm92ZW1iZXIgMTksIDIwMTggMTo1
MiBQTQ0KVG86IFp1bywgSmVycnkgPEplcnJ5Llp1b0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCkNjOiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5j
b20+OyBMaSwgU3VuIHBlbmcgKExlbykgPFN1bnBlbmcuTGlAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaG91LCBEYXZpZChDaHVuTWluZykgPERhdmlkMS5a
aG91QGFtZC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+OyBMaSwgUm9tYW4g
PFJvbWFuLkxpQGFtZC5jb20+OyBTLCBTaGlyaXNoIDxTaGlyaXNoLlNAYW1kLmNvbT47IERhbmll
bCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BB
VENIIDEvMl0gZHJtL2FtZC9kbTogRG9uJ3QgZm9yZ2V0IHRvIGF0dGFjaCBNU1QgZW5jb2RlcnMN
Cg0KQ29vbCEgSWYgaXQgZGlkIGFjdHVhbGx5IGZpeCB0aG9zZSBwcm9ibGVtcywgd291bGQgeW91
IG1pbmQgbWFraW5nIHN1cmUgdGhpcyBnZXRzIENjJ2QgdG8gc3RhYmxlIHdoZW4gaXQgZ2V0cyBw
dXNoZWQgdXBzdHJlYW0/DQoNCk9uIE1vbiwgMjAxOC0xMS0xOSBhdCAxNTowMCArMDAwMCwgWnVv
LCBKZXJyeSB3cm90ZToNCj4gUmV2aWV3ZWQtYnk6IEplcnJ5IChGYW5nemhpKSBadW8gPEplcnJ5
Llp1b0BhbWQuY29tPg0KPiANCj4gVGhlIGNoYW5nZSBmaXhlZCBNU1QgKyBTU1QgZGFpc3kgY2hh
aW4gYW5kIFMzIHNjZW5hcmlvcy4gVGhlIGlzc3VlIA0KPiBzaG93cyBodWdlIGRlbGF5IGluIE1T
VCArIFNTVCBkYWlzeSBjaGFpbiwgYW5kIHNvZnQgaGFuZyBpbiBTMyByZXN1bWUuDQo+IA0KPiBU
aGUgYXV4IHNlcXVlbmNlIGlzIGNoYW5nZWQgYnkgZmFpbGVkIGl0ZXJhdGlvbiBzZWFyY2ggaW4g
DQo+IGRybV9jb25uZWN0b3JfZm9yX2VhY2hfcG9zc2libGVfZW5jb2RlcigpLg0KPiBUaGUgZmFp
bHVyZSBvZiBzZWFyY2hpbmcgZm9yIHRoZSBiZXN0IGVuY29kZXIgZm9yIHRoZSBjb25uZWN0b3Ig
ZHVlIHRvIA0KPiB0aGUgbWlzcyBvZiBhdHRhY2hlZCBlbmNvZGVyIGluIHRoZSBwcm9jZXNzIG9m
IGFkZGluZyBNU1QgY29ubmVjdG9yLiANCj4gVGhlIGl0ZXJhdGlvbiBzZWFyY2ggdGFrZXMgdGlt
ZSB0byBwdXNoIA0KPiBkcm1fZHBfc2VuZF9lbnVtX3BhdGhfcmVzb3VyY2VzKCkgYXV4IHRyYW5z
YWN0aW9uIGFmdGVyIHRoZSBtb2RlIA0KPiBwcm9iZSwgYW5kIGNhdXNlcyBjb25mbGljdCB0byBk
cm1fZHBfbXN0X2kyY194ZmVyKCksIGxlYWRpbmcgdG8gdGhlIGF1eCB0cmFuc2FjdGlvbiB0aW1l
b3V0Lg0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHl1ZGUgUGF1
bCA8bHl1ZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogTm92ZW1iZXIgMTYsIDIwMTggNjoyNSBQTQ0K
PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFp1bywgSmVycnkgPEpl
cnJ5Llp1b0BhbWQuY29tPjsgV2VudGxhbmQsIEhhcnJ5IA0KPiA8SGFycnkuV2VudGxhbmRAYW1k
LmNvbT4gOyBMaSwgU3VuIHBlbmcgKExlbykgPFN1bnBlbmcuTGlAYW1kLmNvbT47IA0KPiBEZXVj
aGVyLCBBbGV4YW5kZXIgPCBBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJp
c3RpYW4gDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaG91LCBEYXZpZChDaHVuTWlu
ZykgDQo+IDxEYXZpZDEuWmhvdUBhbWQuY29tPjsgRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4
LmllPiA7IExpLCBSb21hbiANCj4gPFJvbWFuLkxpQGFtZC5jb20+OyBTLCBTaGlyaXNoIDxTaGly
aXNoLlNAYW1kLmNvbT47IERhbmllbCBWZXR0ZXIgDQo+IDxkYW5pZWwudmV0dGVyQGZmd2xsLmNo
PjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgDQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDEvMl0gZHJtL2FtZC9kbTogRG9uJ3QgZm9y
Z2V0IHRvIGF0dGFjaCBNU1QgZW5jb2RlcnMNCj4gDQo+IERyaXZlLWJ5IGZpeCwgdGhpcyBpcyBi
b3VuZCB0byBjYXVzZSBwcm9ibGVtcyBzb21ld2hlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBM
eXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPg0KPiBDYzogSmVycnkgWnVvIDxKZXJyeS5adW9A
YW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbV9tc3RfdHlwZXMuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgDQo+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYw0KPiBpbmRleCBkMDJj
MzJhMTAzOWMuLjBjY2ExODA5ZmRjZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMNCj4g
QEAgLTM0Miw2ICszNDIsOCBAQCBkbV9kcF9hZGRfbXN0X2Nvbm5lY3RvcihzdHJ1Y3QgDQo+IGRy
bV9kcF9tc3RfdG9wb2xvZ3lfbWdyICptZ3IsDQo+ICAJCW1hc3Rlci0+Y29ubmVjdG9yX2lkKTsN
Cj4gIA0KPiAgCWFjb25uZWN0b3ItPm1zdF9lbmNvZGVyID0gZG1fZHBfY3JlYXRlX2Zha2VfbXN0
X2VuY29kZXIobWFzdGVyKTsNCj4gKwlkcm1fY29ubmVjdG9yX2F0dGFjaF9lbmNvZGVyKCZhY29u
bmVjdG9yLT5iYXNlLA0KPiArCQkJCSAgICAgJmFjb25uZWN0b3ItPm1zdF9lbmNvZGVyLT5iYXNl
KTsNCj4gIA0KPiAgCS8qDQo+ICAJICogVE9ETzogdW5kZXJzdGFuZCB3aHkgdGhpcyBvbmUgaXMg
bmVlZGVkDQotLQ0KQ2hlZXJzLA0KCUx5dWRlIFBhdWwNCg0K
