Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D76DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6F12080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="m1HuDM6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6F12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeJaB0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:26:36 -0400
Received: from mail-eopbgr720042.outbound.protection.outlook.com ([40.107.72.42]:52304
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbeJaB0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd915UloXNzP8eOIHue91K2eFpVNMxp/dNQhCdsvNPM=;
 b=m1HuDM6rhMMhr/mvg8sH5ukWY5Cfr30iGLvxryXDdIxATK0uZW9bQRIB0UpZAoIqSKFSHSWxh7GdKJQyaW7QHg/Bnilq5gfY0C2kfcAJcgNO22nfUiGGwKT0CqqpdVCtXF8+1jQXx4nxmgFhDz437A2FoJbdPcog941B4NBhK4M=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4695.namprd05.prod.outlook.com (52.135.233.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.9; Tue, 30 Oct 2018 16:32:22 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.018; Tue, 30 Oct 2018
 16:32:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
Thread-Topic: [PATCH v3 00/20] vmw_balloon: compaction, shrinker, 64-bit, etc.
Thread-Index: AQHUVc1A1pnRvXeeC0qBolVm1YmtjKU4MKcA
Date:   Tue, 30 Oct 2018 16:32:22 +0000
Message-ID: <E1B69BF2-458D-435C-8065-6944111A9EC6@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
In-Reply-To: <20180926191336.101885-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4695;20:6gmGEJy/Xz6xNCHM7VkIjOePda0XbWVmofsbCDWRpuAIAxLCtO3KneUQVMnFcP07zAx9Ovp4dqYDE7zW7rrXI7yU3WdYfxTjfbzWWPOcrc2M2cExfDWKT9o40dKSrbuZXtRFvg7gxt/ys9SAgJXjeVg9o3xj0oSA/+EcjGtlIk0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aa0e01ce-6482-4f86-0f48-08d63e8544c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4695;
x-ms-traffictypediagnostic: BYAPR05MB4695:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB4695761E8166C90E0F53AD4ED0CC0@BYAPR05MB4695.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4695;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4695;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(66066001)(8936002)(316002)(6116002)(36756003)(3846002)(6246003)(4326008)(476003)(256004)(186003)(26005)(102836004)(86362001)(446003)(71200400001)(71190400001)(2906002)(25786009)(83716004)(68736007)(14444005)(11346002)(2616005)(486006)(99286004)(82746002)(6486002)(305945005)(6436002)(229853002)(7736002)(105586002)(6506007)(8676002)(76176011)(106356001)(54906003)(6512007)(110136005)(81156014)(81166006)(53936002)(33656002)(53546011)(5250100002)(97736004)(2501003)(2900100001)(14454004)(478600001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4695;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F2huaI4zijVVJKRlDG7pf38wJ+by34MNyAGEcUs75M2aFdqHyGnK6GoH1/ACD5kgFL2gyIEX4GL9SzPvK7+cTX3sHK2l7eFeUWM1BwO300EYGLknNjwbmYAID/UoTbOsKgAXv6/pLuNZNr/vyJR6b0EaXILUNgEi6f1I/Wgmm6LUnfSGux1LoULUxRI2CVyebrkCXN56g5tMJdGf5CztmrsVIYxPN1VxRqYKFjLcBAXfIKK4rGJs3imLHOxKgLPAA30QRu+BSl/8lo+W3wmQNDEz/WnlVXQpEnef/b6a7bk8go1W2fTx5ftoACVLe3ulMlOu6Q07IkxTFxddmy9Lq9j3xfZ+NJbXhW6Kss3XlcA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB8410277155E24686666DFA454A1F55@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0e01ce-6482-4f86-0f48-08d63e8544c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 16:32:22.3294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmFkYXYgQW1pdA0KU2VudDogU2VwdGVtYmVyIDI2LCAyMDE4IGF0IDc6MTM6MTYgUE0g
R01UDQo+IFRvOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiwgZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmcNCj4gQ2M6IFhhdmllciBEZWd1aWxsYXJkIDx4ZGVndWlsbGFyZEB2bXdhcmUu
Y29tPiwgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4sIE5hZGF2IEFtaXQgPG5hbWl0QHZt
d2FyZS5jb20+LCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiwgSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4sIGxpbnV4LW1tQGt2YWNrLm9yZz4sIHZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAwMC8y
MF0gdm13X2JhbGxvb246IGNvbXBhY3Rpb24sIHNocmlua2VyLCA2NC1iaXQsIGV0Yy4NCj4gDQo+
IA0KPiBUaGlzIHBhdGNoLXNldCBhZGRzIHRoZSBmb2xsb3dpbmcgZW5oYW5jZW1lbnRzIHRvIHRo
ZSBWTXdhcmUgYmFsbG9vbg0KPiBkcml2ZXI6DQo+IA0KPiAxLiBCYWxsb29uIGNvbXBhY3Rpb24g
c3VwcG9ydC4NCj4gMi4gUmVwb3J0IHRoZSBudW1iZXIgb2YgaW5mbGF0ZWQvZGVmbGF0ZWQgYmFs
bG9vbmVkIHBhZ2VzIHRocm91Z2ggdm1zdGF0Lg0KPiAzLiBNZW1vcnkgc2hyaW5rZXIgdG8gYXZv
aWQgYmFsbG9vbiBvdmVyLWluZmxhdGlvbiAoYW5kIE9PTSkuDQo+IDQuIFN1cHBvcnQgVk1zIHdp
dGggbWVtb3J5IGxpbWl0IHRoYXQgaXMgZ3JlYXRlciB0aGFuIDE2VEIuDQo+IDUuIEZhc3RlciBh
bmQgbW9yZSBhZ2dyZXNzaXZlIGluZmxhdGlvbi4NCj4gDQo+IFRvIHN1cHBvcnQgY29tcGFjdGlv
biB3ZSB3aXNoIHRvIHVzZSB0aGUgZXhpc3RpbmcgaW5mcmFzdHJ1Y3R1cmUuDQo+IEhvd2V2ZXIs
IHdlIG5lZWQgdG8gbWFrZSBzbGlnaHQgYWRhcHRpb25zIGZvciBpdC4gV2UgYWRkIGEgbmV3IGxp
c3QNCj4gaW50ZXJmYWNlIHRvIGJhbGxvb24tY29tcGFjdGlvbiwgd2hpY2ggaXMgbW9yZSBnZW5l
cmljIGFuZCBlZmZpY2llbnQsDQo+IHNpbmNlIGl0IGRvZXMgbm90IHJlcXVpcmUgYXMgbWFueSBJ
UlEgc2F2ZS9yZXN0b3JlIG9wZXJhdGlvbnMuIFdlIGxlYXZlDQo+IHRoZSBvbGQgaW50ZXJmYWNl
IHRoYXQgaXMgdXNlZCBieSB0aGUgdmlydGlvIGJhbGxvb24uDQo+IA0KPiBCaWcgcGFydHMgb2Yg
dGhpcyBwYXRjaC1zZXQgYXJlIGNsZWFudXAgYW5kIGRvY3VtZW50YXRpb24uIFBhdGNoZXMgMS0x
Mw0KPiBzaW1wbGlmeSB0aGUgYmFsbG9vbiBjb2RlLCBkb2N1bWVudCBpdHMgYmVoYXZpb3IgYW5k
IGFsbG93IHRoZSBiYWxsb29uDQo+IGNvZGUgdG8gcnVuIGNvbmN1cnJlbnRseS4gVGhlIHN1cHBv
cnQgZm9yIGNvbmN1cnJlbmN5IGlzIHJlcXVpcmVkIGZvcg0KPiBjb21wYWN0aW9uIGFuZCB0aGUg
c2hyaW5rZXIgaW50ZXJmYWNlLg0KPiANCj4gRm9yIGRvY3VtZW50YXRpb24gd2UgdXNlIHRoZSBr
ZXJuZWwtZG9jIGZvcm1hdC4gV2UgYXJlIGF3YXJlIHRoYXQgdGhlDQo+IGJhbGxvb24gaW50ZXJm
YWNlIGlzIG5vdCBwdWJsaWMsIGJ1dCBmb2xsb3dpbmcgdGhlIGtlcm5lbC1kb2MgZm9ybWF0IG1h
eQ0KPiBiZSB1c2VmdWwgb25lIGRheS4NCj4gDQo+IHYyLT52MzogKiBNb3ZpbmcgdGhlIGJhbGxv
b24gbWFnaWMtbnVtYmVyIG91dCBvZiB1YXBpIChHcmVnKQ0KPiANCj4gdjEtPnYyOgkqIEZpeCBi
dWlsZCBlcnJvciB3aGVuIFRIUCBpcyBvZmYgKGtidWlsZCkNCj4gCSogRml4IGJ1aWxkIGVycm9y
IG9uIGkzODYgKGtidWlsZCkNCj4gDQoNCkdyZWcsDQoNCkkgcmVhbGl6ZSB5b3UgZGlkbuKAmXQg
YXBwbHkgcGF0Y2hlcyAxNy0yMC4gQW55IHJlYXNvbiBmb3IgdGhhdD8NCg0KVGhhbmtzLA0KTmFk
YXYNCg0KDQo=
