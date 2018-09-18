Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA34C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDBF21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="BNNKrKiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDBF21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeIRWQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:16:23 -0400
Received: from mail-eopbgr710067.outbound.protection.outlook.com ([40.107.71.67]:16928
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729447AbeIRWQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omvLTxG8QQQukTIrULt5Hldu4H/Vc4WT5PAWvzgcnAs=;
 b=BNNKrKiOL7h4vQsh9HDCDvvxfDvNkOagqfFDOX7SqA/0lFIWtWeQC/EYCirusyJF+MHHbGLTyzlRf/ujoq5bjWIr2VHCMZrrn4hBWKmedTqjjO6cjODiN1s0B1ryi3AUP4oAv00dPIiMGsFfuGRDaGDJj1Mq7gc2rPDpFGtzbso=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5143.namprd05.prod.outlook.com (20.177.231.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.12; Tue, 18 Sep 2018 16:42:57 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1cc9:412c:6f6b:e0ae]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1cc9:412c:6f6b:e0ae%4]) with mapi id 15.20.1164.014; Tue, 18 Sep 2018
 16:42:57 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 00/19] vmw_balloon: compaction, shrinker, 64-bit, etc.
Thread-Topic: [PATCH 00/19] vmw_balloon: compaction, shrinker, 64-bit, etc.
Thread-Index: AQHUTxp5rm7pw0H7Ik+DFMi05ah+baT197iAgABHWoA=
Date:   Tue, 18 Sep 2018 16:42:57 +0000
Message-ID: <B27D8BAC-28E2-4807-8D96-90A6938305F3@vmware.com>
References: <20180918063853.198332-1-namit@vmware.com>
 <20180918122729.GA13598@kroah.com>
In-Reply-To: <20180918122729.GA13598@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5143;20:IsQt2cKvscHMhVNdPoE2YwZb9WHpFp6DqqfasQ0w/vjujhLpj3ZvUDa4ZHU2/DoQCIjnpcSJjJOWHNJvCuy8Q/5abS0cOov1CHfndHmgxvNNdiIuCS//Ov6StY+eCkAXsE9IWpPKTu93U3E2jEG2FEWKh16y5bGCFgMJL+8GQ2Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 02b921f5-232e-4aa9-8d10-08d61d85c9e5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5143;
x-ms-traffictypediagnostic: BYAPR05MB5143:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB51436A5AFBA9B495C120D67FD01D0@BYAPR05MB5143.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:BYAPR05MB5143;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5143;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(2900100001)(8936002)(6116002)(3846002)(25786009)(105586002)(486006)(316002)(106356001)(229853002)(83716003)(81156014)(476003)(8676002)(99286004)(82746002)(7736002)(446003)(54906003)(11346002)(256004)(14444005)(305945005)(2906002)(36756003)(2616005)(33656002)(4326008)(14454004)(81166006)(6512007)(66066001)(86362001)(6916009)(26005)(5250100002)(478600001)(76176011)(6246003)(68736007)(6436002)(186003)(102836004)(97736004)(53936002)(5660300001)(6346003)(6486002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5143;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: bloFSy7Ip/y3WuzMEuSWKwHZCTyXIj1T8TZetflOgk1Ge3C+mSzoLvKL/ZzEfl8luarbjWEl/llq9X3DAag2/6eteVcBiCKLoGkxwepRXom8V2WrDT4qmIb25LDdQVHcxpgoob5GxkEOt0j2RXXKXu4V2WR5eNqDjRZ74g/Obg3HxJva54Q5kZYEw5qndA1MMON5bucQHwP0J02xQ590qbTWf6/60o16hZpj18eDqwpv/Az95hm04ELfBDAvMl8SEWfHIBgSVJQh10fOT4ex6MrycG3p8GIyhdMyBTqq8Nau1D0AxVC8HFBW54Pmme/FoWLfzBbRJSBJ6fpfQn925LuGWwGLXiJzg5FoRF32HFs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0DDE62851C5714E8E5C2F370CF0BEFA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b921f5-232e-4aa9-8d10-08d61d85c9e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 16:42:57.3061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNToyNyBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4gd3JvdGU6DQoNCj4gT24gTW9uLCBTZXAgMTcsIDIwMTggYXQgMTE6Mzg6MzRQTSAtMDcwMCwg
TmFkYXYgQW1pdCB3cm90ZToNCj4+IFRoaXMgcGF0Y2gtc2V0IGFkZHMgdGhlIGZvbGxvd2luZyBl
bmhhbmNlbWVudHMgdG8gdGhlIFZNd2FyZSBiYWxsb29uDQo+PiBkcml2ZXI6DQo+PiANCj4+IDEu
IEJhbGxvb24gY29tcGFjdGlvbiBzdXBwb3J0Lg0KPj4gMi4gUmVwb3J0IHRoZSBudW1iZXIgb2Yg
aW5mbGF0ZWQvZGVmbGF0ZWQgYmFsbG9vbmVkIHBhZ2VzIHRocm91Z2ggdm1zdGF0Lg0KPj4gMy4g
TWVtb3J5IHNocmlua2VyIHRvIGF2b2lkIGJhbGxvb24gb3Zlci1pbmZsYXRpb24gKGFuZCBPT00p
Lg0KPj4gNC4gU3VwcG9ydCBWTXMgd2l0aCBtZW1vcnkgbGltaXQgdGhhdCBpcyBncmVhdGVyIHRo
YW4gMTZUQi4NCj4+IDUuIEZhc3RlciBhbmQgbW9yZSBhZ2dyZXNzaXZlIGluZmxhdGlvbi4NCj4+
IA0KPj4gVG8gc3VwcG9ydCBjb21wYWN0aW9uIHdlIHdpc2ggdG8gdXNlIHRoZSBleGlzdGluZyBp
bmZyYXN0cnVjdHVyZS4NCj4+IEhvd2V2ZXIsIHdlIG5lZWQgdG8gbWFrZSBzbGlnaHQgYWRhcHRp
b25zIGZvciBpdC4gV2UgYWRkIGEgbmV3IGxpc3QNCj4+IGludGVyZmFjZSB0byBiYWxsb29uLWNv
bXBhY3Rpb24sIHdoaWNoIGlzIG1vcmUgZ2VuZXJpYyBhbmQgZWZmaWNpZW50LA0KPj4gc2luY2Ug
aXQgZG9lcyBub3QgcmVxdWlyZSBhcyBtYW55IElSUSBzYXZlL3Jlc3RvcmUgb3BlcmF0aW9ucy4g
V2UgbGVhdmUNCj4+IHRoZSBvbGQgaW50ZXJmYWNlIHRoYXQgaXMgdXNlZCBieSB0aGUgdmlydGlv
IGJhbGxvb24uDQo+PiANCj4+IEJpZyBwYXJ0cyBvZiB0aGlzIHBhdGNoLXNldCBhcmUgY2xlYW51
cCBhbmQgZG9jdW1lbnRhdGlvbi4gUGF0Y2hlcyAxLTEzDQo+PiBzaW1wbGlmeSB0aGUgYmFsbG9v
biBjb2RlLCBkb2N1bWVudCBpdHMgYmVoYXZpb3IgYW5kIGFsbG93IHRoZSBiYWxsb29uDQo+PiBj
b2RlIHRvIHJ1biBjb25jdXJyZW50bHkuIFRoZSBzdXBwb3J0IGZvciBjb25jdXJyZW5jeSBpcyBy
ZXF1aXJlZCBmb3INCj4+IGNvbXBhY3Rpb24gYW5kIHRoZSBzaHJpbmtlciBpbnRlcmZhY2UuDQo+
PiANCj4+IEZvciBkb2N1bWVudGF0aW9uIHdlIHVzZSB0aGUga2VybmVsLWRvYyBmb3JtYXQuIFdl
IGFyZSBhd2FyZSB0aGF0IHRoZQ0KPj4gYmFsbG9vbiBpbnRlcmZhY2UgaXMgbm90IHB1YmxpYywg
YnV0IGZvbGxvd2luZyB0aGUga2VybmVsLWRvYyBmb3JtYXQgbWF5DQo+PiBiZSB1c2VmdWwgb25l
IGRheS4NCj4gDQo+IGtidWlsZCBzZWVtcyB0byBub3QgbGlrZSB0aGlzIHBhdGNoIHNlcmllcywg
c28gSSdtIGdvaW5nIHRvIGRyb3AgaXQgZnJvbQ0KPiBteSBxdWV1ZSBhbmQgd2FpdCBmb3IgYSB2
MiByZXNwaW4gYmVmb3JlIGxvb2tpbmcgYXQgaXQuDQoNClN1cmUuIEnigJlsbCBzZW5kIHYyIGlu
IGEgZGF5IG9yIHR3by4NCg0KTmFkYXYgDQoNCg0K
