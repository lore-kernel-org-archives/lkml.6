Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFFBECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE26221531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZoSQDWkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE26221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbeITURE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:17:04 -0400
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:53703
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387659AbeITURE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqHF6BRNVLaCA1URSALQMajs8H+vpCWXXGyL9fxnA8U=;
 b=ZoSQDWkjhdJRMTEnXPgG4BhU8SBFDTYaGJSlA9km9v5VvfM9MMQ7NFUPSBiRt8NHIbJhzDlBwtK00qb3vBE61V2/AamlIupALlRkC0VrOic47OVmPLgtfCc8+BDwSGVzc2egeSmAbQJvcCombYqHxtmkiL/Xnc2ovzNCCjKScaA=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3461.eurprd04.prod.outlook.com (52.133.19.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.20; Thu, 20 Sep 2018 14:33:14 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764%2]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 14:33:14 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>
Subject: Re: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
Thread-Topic: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
Thread-Index: AQHUUBVdnVuE9WUMJk6OHUCevWlNC6T3mFcAgAAO0oCAAAUrgIABT78AgAATyoCAAC2vAA==
Date:   Thu, 20 Sep 2018 14:33:14 +0000
Message-ID: <bb973ba9-ca45-c9f1-38d6-67e9bc05e429@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <7d7646dc-9d0b-013d-75d7-a6cb4453f41f@arm.com>
 <fd8ab351-46aa-f73e-593b-502a57de1975@nxp.com>
 <39211e7a-034b-cdca-f182-1b6f6e5fbc53@arm.com>
 <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
 <c2acecc8-5357-6cbe-f93c-00d71470dff5@arm.com>
In-Reply-To: <c2acecc8-5357-6cbe-f93c-00d71470dff5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3461;6:jbcoFgqyuwIt0fCGzPsXrZ2mYKVpng/ENdDU1OpJqFnfCC4Ev8skIRcn6lxjKbkQI7TKZYI4EV5Q6mqz3/iNhJLHhmOIVgCPeHDtknbNM/5eryiyjX1Q9eRyTBV0HEV6Uck+9vvZty9+NhEtEkbnRxEqBLYL54mb8fsOsoI1a0rfipn3xg3T8a2WuMrrrkVKdys+lpDGxIqKNu6OThsZ2GxLdrrarXI111V87MTptOTVYuGS1KqPSUIIcgbRnPrakIC6p4jRxElVCd6iu+hFnghUMsuoE+5qpIQNC1RIzYpZkiAuSmUgQ0iffc/a83raB6Pvhoy/J8oG1JfKL8TLg1qFme7uN/BmzwKH/NQpearP2JPImfkd+oKQjSQJAk7dAFnXra9nPgoADnlzTGR0VJ8dS/+zIdhFSLu/17rigbUH4p7vVP7dHugSggUTU7kRJqjLihULswQ6mP/ap6/82A==;5:wUeDH0HjzLloDrSnjKtjjMDwW3PlfnH8fC27teWhf1YE/BkYQ6up2uF3pgdnTU2PFhaDqkdb78HJ651NLX+iUejOHgjQMybS30rfzsBIcD6yMGRLrytWOD1G+R82627BaZWr5MDeJYhW4w7ITYwOL/ztPnrIEyuwmSo/RJ2UNsc=;7:P8V29L1DtMku7qGyhCrzXuFd8ge3n/u1HRq+mz3FWERhWnARimD1v/WuswEe5eklz+/3jlehvPLy782X4uMjn0MAl5mDDup1Yi7ntj1UrCd3Cgo0pWmzurq6BLTkCm3KVKDao31/aiQdm8JvNiBAGKpoZ0x6coDLAzzdORLxvNz1whcuhYNY4A/h2Ncutdd+7r2eGzsxuMd8Euj/WsMTmuDHQwz1JIP8hXnovW/hXLNy9cEohoJmFPQ7IcXr9iPi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bef8ba17-f253-4097-c4c1-08d61f05ffaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3461;
x-ms-traffictypediagnostic: AM6PR0402MB3461:
x-microsoft-antispam-prvs: <AM6PR0402MB3461350F04322DE21A161D47EC130@AM6PR0402MB3461.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR0402MB3461;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3461;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(51914003)(105586002)(76176011)(2900100001)(7736002)(305945005)(31686004)(36756003)(186003)(102836004)(26005)(5660300001)(53546011)(44832011)(93886005)(486006)(68736007)(476003)(2616005)(99286004)(11346002)(446003)(478600001)(229853002)(6506007)(14454004)(53936002)(106356001)(6512007)(6436002)(2906002)(6486002)(66066001)(97736004)(8676002)(14444005)(6246003)(256004)(4326008)(71190400001)(71200400001)(2201001)(5250100002)(81166006)(81156014)(25786009)(31696002)(316002)(2501003)(8936002)(6116002)(3846002)(86362001)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3461;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Fw8R0+OGn+zAW6fGzqblXDFwyXe5ZopP1/MdTr0nvdHBPGoWnP+xS/VKMi52/97x+HhMN4aJU5q/wbc1EERr7gU3hSTpAEMbw/fTRaOawZ7dRWTGXNotSIvN8h2OxO2x0bk6BqKtQ6U4Cl6FyNaCD6T/n8zwHiscYNVzxL3IFn7rVH7vWtmE4a5n6BgpTAA8PgFHtMbLLsnowd5ZbYSsaX+x0KwzT/LmOMkRcTP0oiEMmU5VdGhmHHKmehY8ULWyZukIGZbxCZgQcPFqgjB2lfxj+1ITW5dzM6u2/NBaSX0gDHBKtZ0CLOOaImGcs5fIddB2YlNnANEppfXwWlYQZ8OtQ2IQa8fnQeLQiPjghng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3A76D8239CF594D9E5A186FBF43A245@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef8ba17-f253-4097-c4c1-08d61f05ffaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 14:33:14.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwLjA5LjIwMTggMTQ6NDksIFJvYmluIE11cnBoeSB3cm90ZToNCj4gT24gMjAvMDkv
MTggMTE6MzgsIExhdXJlbnRpdSBUdWRvciB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMTkuMDkuMjAx
OCAxNzozNywgUm9iaW4gTXVycGh5IHdyb3RlOg0KPj4+IE9uIDE5LzA5LzE4IDE1OjE4LCBMYXVy
ZW50aXUgVHVkb3Igd3JvdGU6DQo+Pj4+IEhpIFJvYmluLA0KPj4+Pg0KPj4+PiBPbiAxOS4wOS4y
MDE4IDE2OjI1LCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+Pj4+PiBIaSBMYXVyZW50aXUsDQo+Pj4+
Pg0KPj4+Pj4gT24gMTkvMDkvMTggMTM6MzUsIGxhdXJlbnRpdS50dWRvckBueHAuY29tIHdyb3Rl
Og0KPj4+Pj4+IEZyb206IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+
DQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIFNNTVUgc3VwcG9ydCBmb3Ig
TlhQIExTMTA0M0EgYW5kIExTMTA0NkEgY2hpcHMNCj4+Pj4+PiBhbmQgY29uc2lzdHMgbW9zdGx5
IGluIGltcG9ydGFudCBkcml2ZXIgZml4ZXMgYW5kIHRoZSByZXF1aXJlZCBkZXZpY2UNCj4+Pj4+
PiB0cmVlIHVwZGF0ZXMuIEl0IHRvdWNoZXMgc2V2ZXJhbCBzdWJzeXN0ZW1zIGFuZCBjb25zaXN0
cyBvZiB0aHJlZSANCj4+Pj4+PiBtYWluDQo+Pj4+Pj4gcGFydHM6DQo+Pj4+Pj4gwqDCoMKgIC0g
Y2hhbmdlcyBpbiBzb2MvZHJpdmVycy9mc2wvcWJtYW4gZHJpdmVycyBhZGRpbmcgaW9tbXUgDQo+
Pj4+Pj4gbWFwcGluZyBvZg0KPj4+Pj4+IMKgwqDCoMKgwqAgcmVzZXJ2ZWQgbWVtb3J5IGFyZWFz
LCBmaXhlcyBhbmQgZGVmZXJlZCBwcm9iZSBzdXBwb3J0DQo+Pj4+Pj4gwqDCoMKgIC0gY2hhbmdl
cyBpbiBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYV9ldGggZHJpdmVycw0KPj4+
Pj4+IMKgwqDCoMKgwqAgY29uc2lzdGluZyBpbiBtaXNjIGRtYSBtYXBwaW5nIHJlbGF0ZWQgZml4
ZXMgYW5kIHByb2JlIG9yZGVyaW5nDQo+Pj4+Pj4gwqDCoMKgIC0gYWRkaXRpb24gb2YgdGhlIGFj
dHVhbCBhcm0gc21tdSBkZXZpY2UgdHJlZSBub2RlIHRvZ2V0aGVyIHdpdGgNCj4+Pj4+PiDCoMKg
wqDCoMKgIHZhcmlvdXMgYWRqdXN0bWVudHMgdG8gdGhlIGRldmljZSB0cmVlcw0KPj4+Pj4+DQo+
Pj4+Pj4gUGVyZm9ybWFuY2UgaW1wYWN0DQo+Pj4+Pj4NCj4+Pj4+PiDCoMKgwqDCoMKgwqAgUnVu
bmluZyBpcGVyZiBiZW5jaG1hcmtzIGluIGEgYmFjay10by1iYWNrIHNldHVwIChib3RoIHNpZGVz
DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgIGhhdmluZyBzbW11IGVuYWJsZWQpIG9uIGEgMTBHQnBzIHBv
cnQgc2hvdyBhbiBpbXBvcnRhbnQNCj4+Pj4+PiDCoMKgwqDCoMKgwqAgbmV0d29ya2luZyBwZXJm
b3JtYW5jZSBkZWdyYWRhdGlvbiBvZiBhcm91bmQgJTQwICg5LjQ4R2Jwcw0KPj4+Pj4+IMKgwqDC
oMKgwqDCoCBsaW5lcmF0ZSB2cyA1LjQ1R2JwcykuIElmIHlvdSBuZWVkIHBlcmZvcm1hbmNlIGJ1
dCB3aXRob3V0DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgIFNNTVUgc3VwcG9ydCB5b3UgY2FuIHVzZSAi
aW9tbXUucGFzc3Rocm91Z2g9MSIgdG8gZGlzYWJsZQ0KPj4+Pj4+IMKgwqDCoMKgwqDCoCBTTU1V
Lg0KPiANCj4gSSBzaG91bGQgaGF2ZSBzYWlkIGJlZm9yZSAtIHRoYW5rcyBmb3IgdGhlIG51bWJl
cnMgdGhlcmUgYXMgd2VsbC4gQWx3YXlzIA0KPiBnb29kIHRvIGFkZCBhbm90aGVyIGRhdGFwb2lu
dCB0byBteSBjb2xsZWN0aW9uLiBJZiB5b3UncmUgaW50ZXJlc3RlZCANCj4gSSd2ZSBhZGRlZCBT
TU1VdjIgc3VwcG9ydCB0byB0aGUgIm5vbi1zdHJpY3QgbW9kZSIgc2VyaWVzIChvZiB3aGljaCBJ
IA0KPiBzaG91bGQgYmUgcG9zdGluZyB2OCBzb29uKSwgc28gaXQgbWlnaHQgYmUgZnVuIHRvIHNl
ZSBob3cgd2VsbCB0aGF0IA0KPiB3b3JrcyBvbiBNTVUtNTAwIGluIHRoZSByZWFsIHdvcmxkLg0K
DQpIbW0sIEkgdGhpbmsgSSBnYXZlIHRob3NlIGEgdHJ5IHNvbWUgd2Vla3MgYWdvIGFuZCB2YWd1
ZWx5IHJlbWVtYmVyIHRoYXQgDQpJIGRpZCBzZWUgaW1wcm92ZW1lbnRzLiBDYW4ndCByZW1lbWJl
ciB0aGUgbnVtYmVycyBvZmYgdGhlIHRvcCBvZiBteSANCmhlYWQgYnV0IEknbGwgcmUtdGVzdCB3
aXRoIHRoZSBsYXRlc3Qgc3BpbiBhbmQgdXBkYXRlIHRoZSBudW1iZXJzLg0KDQo+Pj4+Pj4NCj4+
Pj4+PiBVU0IgaXNzdWUgYW5kIHdvcmthcm91bmQNCj4+Pj4+Pg0KPj4+Pj4+IMKgwqDCoMKgwqDC
oCBUaGVyZSdzIGEgcHJvYmxlbSB3aXRoIHRoZSB1c2IgY29udHJvbGxlcnMgaW4gdGhlc2UgY2hp
cHMNCj4+Pj4+PiDCoMKgwqDCoMKgwqAgZ2VuZXJhdGluZyBzbWFsbGVyLCA0MC1iaXQgd2lkZSBk
bWEgYWRkcmVzc2VzIGluc3RlYWQgb2YgdGhlDQo+Pj4+Pj4gNDgtYml0DQo+Pj4+Pj4gwqDCoMKg
wqDCoMKgIHN1cHBvcnRlZCBhdCB0aGUgc21tdSBpbnB1dC4gU28geW91IGVuZCB1cCBpbiBhIHNp
dHVhdGlvbg0KPj4+Pj4+IHdoZXJlIHRoZQ0KPj4+Pj4+IMKgwqDCoMKgwqDCoCBzbW11IGlzIG1h
cHBlZCB3aXRoIDQ4LWJpdCBhZGRyZXNzIHRyYW5zbGF0aW9ucywgYnV0IHRoZSANCj4+Pj4+PiBk
ZXZpY2UNCj4+Pj4+PiDCoMKgwqDCoMKgwqAgZ2VuZXJhdGVzIHRyYW5zYWN0aW9ucyB3aXRoIGNs
aXBwZWQgNDAtYml0IGFkZHJlc3NlcywgdGh1cyANCj4+Pj4+PiBzbW11DQo+Pj4+Pj4gwqDCoMKg
wqDCoMKgIGNvbnRleHQgZmF1bHRzIGFyZSB0cmlnZ2VyZWQuIEkgZW5jb3VudGVyZWQgYSBzaW1p
bGFyDQo+Pj4+Pj4gc2l0dWF0aW9uIGZvcg0KPj4+Pj4+IMKgwqDCoMKgwqDCoCBtbWMgdGhhdCBJ
wqAgbWFuYWdlZCB0byBmaXggaW4gc29mdHdhcmUgWzFdIGhvd2V2ZXIgZm9yIFVTQiBJDQo+Pj4+
Pj4gZGlkIG5vdA0KPj4+Pj4+IMKgwqDCoMKgwqDCoCBmaW5kIGEgcHJvcGVyIHBsYWNlIGluIHRo
ZSBjb2RlIHRvIGFkZCBhIHNpbWlsYXIgZml4LiBUaGUgb25seQ0KPj4+Pj4+IMKgwqDCoMKgwqDC
oCB3b3JrYXJvdW5kIEkgZm91bmQgd2FzIHRvIGFkZCB0aGlzIGtlcm5lbCBwYXJhbWV0ZXIgd2hp
Y2gNCj4+Pj4+PiBsaW1pdHMgdGhlDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgIHVzYiBkbWEgdG8gMzIt
Yml0IHNpemU6ICJ4aGNpLWhjZC5xdWlya3M9MHg4MDAwMDAiLg0KPj4+Pj4+IMKgwqDCoMKgwqDC
oCBUaGlzIHdvcmthcm91bmQgaWYgZmFyIGZyb20gaWRlYWwsIHNvIGFueSBzdWdnZXN0aW9ucyBm
b3IgYSANCj4+Pj4+PiBjb2RlDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgIGJhc2VkIHdvcmthcm91bmQg
aW4gdGhpcyBhcmVhIHdvdWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuDQo+Pj4+Pg0KPj4+Pj4g
SWYgeW91IGhhdmUgYSBub21pbmFsbHktNjQtYml0IGRldmljZSB3aXRoIGENCj4+Pj4+IG5hcnJv
d2VyLXRoYW4tdGhlLW1haW4taW50ZXJjb25uZWN0IGxpbmsgaW4gZnJvbnQgb2YgaXQsIHRoYXQg
c2hvdWxkDQo+Pj4+PiBhbHJlYWR5IGJlIGZpeGVkIGluIDQuMTktcmMgYnkgYnVzX2RtYV9tYXNr
IHBpY2tpbmcgdXAgRFQgZG1hLXJhbmdlcywNCj4+Pj4+IHByb3ZpZGVkIHRoZSBpbnRlcmNvbm5l
Y3QgaGllcmFyY2h5IGNhbiBiZSBkZXNjcmliZWQgYXBwcm9wcmlhdGVseSAob3INCj4+Pj4+IGF0
IGxlYXN0IG1hc3NhZ2VkIHN1ZmZpY2llbnRseSB0byBzYXRpc2Z5IHRoZSBiaW5kaW5nKSwgZS5n
LjoNCj4+Pj4+DQo+Pj4+PiAvIHsNCj4+Pj4+IMKgwqAgwqDCoMKgwqAuLi4NCj4+Pj4+DQo+Pj4+
PiDCoMKgIMKgwqDCoMKgc29jIHsNCj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqAgcmFuZ2VzOw0K
Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoCBkbWEtcmFuZ2VzID0gPDAgMCAxMDAwMCAwPjsNCj4+
Pj4+DQo+Pj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgIGRldl80OGJpdCB7IC4uLiB9Ow0KPj4+Pj4N
Cj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqAgcGVyaXBoX2J1cyB7DQo+Pj4+PiDCoMKgIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmFuZ2VzOw0KPj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRtYS1yYW5nZXMgPSA8MCAwIDEwMCAwPjsNCj4+Pj4+DQo+Pj4+PiDCoMKgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZGV2XzQwYml0IHsgLi4uIH07DQo+Pj4+PiDCoMKgIMKgwqDCoMKgwqDC
oMKgIH07DQo+Pj4+PiDCoMKgIMKgwqDCoMKgfTsNCj4+Pj4+IH07DQo+Pj4+Pg0KPj4+Pj4gYW5k
IGlmIHRoYXQgZmFpbHMgdG8gd29yayBhcyBleHBlY3RlZCAoZXhjZXB0IGZvciBQQ0kgaG9zdHMg
d2hlcmUNCj4+Pj4+IGhhbmRsaW5nIGRtYS1yYW5nZXMgcHJvcGVybHkgc3RpbGwgbmVlZHMgc29y
dGluZyBvdXQpLCBwbGVhc2UgZG8gDQo+Pj4+PiBsZXQgdXMNCj4+Pj4+IGtub3cgOykNCj4+Pj4+
DQo+Pj4+DQo+Pj4+IEp1c3QgdG8gY29uZmlybSwgSXMgdGhpcyBbMV0gdGhlIGNoYW5nZSBJIHdh
cyBzdXBwb3NlZCB0byB0ZXN0Pw0KPj4+DQo+Pj4gTm90IHF1aXRlIC0gZG1hLXJhbmdlcyBpcyBv
bmx5IHZhbGlkIGZvciBub2RlcyByZXByZXNlbnRpbmcgYSBidXMsIHNvDQo+Pj4gcHV0dGluZyBp
dCBkaXJlY3RseSBpbiB0aGUgVVNCIGRldmljZSBub2RlcyBkb2Vzbid0IHdvcmsgKEZXSVcgdGhh
dCdzDQo+Pj4gd2h5IFBDSSBpcyBicm9rZW4sIGJlY2F1c2UgdGhlIHBhcnNlciBkb2Vzbid0IGV4
cGVjdCB0aGUNCj4+PiBidXMtYXMtbGVhZi1ub2RlIGNhc2UpLiBUaGF0J3MgdGVoIHBvaW50IG9m
IHRoYXQgaW50ZXJtZWRpYXRlIHNpbXBsZS1idXMNCj4+PiBub2RlIHJlcHJlc2VudGVkIGJ5ICJw
ZXJpcGhfYnVzIiBpbiBteSBleGFtcGxlIChzb3JyeSwgSSBzaG91bGQgaGF2ZSBwdXQNCj4+PiBj
b21wYXRpYmxlcyBpbiB0byBtYWtlIGl0IGNsZWFyZXIpIC0gb2Z0ZW4gdGhhdCdzIGFjdHVhbGx5
IHRydWUgdG8gbGlmZQ0KPj4+IChpLmUuICJzb2MiIGlzIHNvbWV0aGluZyBsaWtlIGEgQ0NJIGFu
ZCAicGVyaXBoX2J1cyIgaXMgc29tZXRoaW5nIGxpa2UNCj4+PiBhbiBBWEkgTklDIGdsdWluZyBh
IGJ1bmNoIG9mIGxvd2VyLWJhbmR3aWR0aCBETUEgbWFzdGVycyB0byBvbmUgb2YgdGhlDQo+Pj4g
Q0NJIHBvcnRzKSBidXQgYXQgd29yc3QgaXQncyBqdXN0IGEgbmVjZXNzYXJ5IGV2aWwgdG8gbWFr
ZSB0aGUgYmluZGluZw0KPj4+IGhhcHB5IChpZiBpdCBsaXRlcmFsbHkgb25seSByZXByZXNlbnRz
IHRoZSBwb2ludC10by1wb2ludCBsaW5rIGJldHdlZW4NCj4+PiB0aGUgZGV2aWNlIG1hc3RlciBw
b3J0IGFuZCBpbnRlcmNvbm5lY3Qgc2xhdmUgcG9ydCkuDQo+Pj4NCj4+DQo+PiBRdWljayB1cGRh
dGU6IHNvIEkgYWRqdXN0ZWQgdG8gZGV2aWNlIHRyZWUgYWNjb3JkaW5nIHRvIHlvdXIgZXhhbXBs
ZSBhbmQNCj4+IGl0IHdvcmtzIHNvIG5vdyBJIGNhbiBnZXQgcmlkIG9mIHRoYXQgbmFzdHkga2Vy
bmVsIGFyZyBiYXNlZCB3b3JrYXJvdW5kLA0KPj4geWV5ISA6LSkNCj4gDQo+IENvb2whIEluIGZh
Y3QsIGp1ZGdpbmcgYnkgdGhlIGJsb2NrIGRpYWdyYW1zIG9uIHRoZSB3ZWJzaXRlLCB0aGUgImJh
c2ljIA0KPiBwZXJpcGhlcmFscyBhbmQgaW50ZXJjb25uZWN0IiBzZWN0aW9uIGhhbmdpbmcgb2Zm
IHRoZSBzaWRlIG9mIHRoZSBDQ0kgDQo+IGltcGxpZXMgdGhhdCBwcm9iYWJseSBpcyB0cnVlIHRv
IHRoZSByZWFsIHRvcG9sb2d5IGFzIEkgaW1hZ2luZWQsIHNvIGl0IA0KPiBkb2Vzbid0IGV2ZW4g
Y291bnQgYXMgYSBob3JyaWJsZSBoYWNrIDopDQoNCkluZGVlZCwgb24gdGhpcyBjaGlwIHRoZXJl
J3MgYSBOb0MgbHVtcGluZyBiZWhpbmQgaXQgc2V2ZXJhbCBsb3ctc3BlZWQgDQpkZXZpY2VzIHN1
Y2ggYXMgdXNiLCBzYXRhLCBlc2RoYy4NCg0KPj4gVGhhbmtzIGEgbG90LCB0aGF0IHdhcyByZWFs
bHkgaGVscGZ1bC4NCj4gDQo+IE5vIHByb2JsZW0uIEZXSVcgaWYgeW91IGV2ZXIgY29tZSB0byBk
b2luZyBBQ1BJIHN1cHBvcnQgZm9yIHRoZXNlIFNvQ3MsIA0KPiB0aGUgZXF1aXZhbGVudCBpcyBt
ZXJlbHkgYSBjYXNlIG9mIHNldHRpbmcgdGhlIGRldmljZSBtZW1vcnkgYWRkcmVzcyANCj4gc2l6
ZSBsaW1pdCBmaWVsZCBhcHByb3ByaWF0ZWx5IGZvciBhbGwgdGhlIG5hbWVkIGNvbXBvbmVudHMu
DQo+IA0KDQpUaGFua3MsIEknbGwga2VlcCB0aGlzIGluIG1pbmQuIElmIGkgcmVtZW1iZXIgY29y
cmVjdGx5LCB0aGVyZSBhcmUgDQpwZW9wbGUgb3ZlciBoZXJlIHdvcmtpbmcgb24gVUVGSSArIEFD
UEkgc3VwcG9ydCBmb3Igc29tZSBMUyBjaGlwcyBidXQgDQpwcm9ncmVzcyBhcHBlYXJzIHRvIGJl
IHNsb3cuDQoNCi0tLQ0KQmVzdCBSZWdhcmRzLCBMYXVyZW50aXU=
