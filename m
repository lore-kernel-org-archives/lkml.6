Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6D5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EAF21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="naz1UnBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EAF21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbeIUNTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:19:52 -0400
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:60067
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389398AbeIUNTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPdjFpW5qo0e3DN1XTrReqDh3PFF81/Wv8vqMh0vJko=;
 b=naz1UnBqk+WgN32LlmDOmfMJQ6OKQ1defldyfrMG2EKgNFlO/CSFceNGY0/L8a3NdeiQjTS3fXM7zqr9bnvzOZp7uvTlynUtSBiuiRSBsA4meShcKx1AzV9aZ09reK1Ji9WvuboKiO2uKBgGMtSIu7eZKwEL4Dk7tftpr5NpzNQ=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3751.eurprd04.prod.outlook.com (52.133.29.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 07:32:12 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 07:32:12 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: RE: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
Thread-Topic: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
Thread-Index: AQHUUBVdnVuE9WUMJk6OHUCevWlNC6T3mFcAgAAO0oCAAAUrgIABT78AgACOAYCAAM9/4A==
Date:   Fri, 21 Sep 2018 07:32:12 +0000
Message-ID: <AM6PR0402MB386413FAA7E9A4E155E452B5EC120@AM6PR0402MB3864.eurprd04.prod.outlook.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <7d7646dc-9d0b-013d-75d7-a6cb4453f41f@arm.com>
 <fd8ab351-46aa-f73e-593b-502a57de1975@nxp.com>
 <39211e7a-034b-cdca-f182-1b6f6e5fbc53@arm.com>
 <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
 <CADRPPNTot7U6vARqtrRrw4XqhDQPSXP1QO9ZbGpNQByJPcU37Q@mail.gmail.com>
In-Reply-To: <CADRPPNTot7U6vARqtrRrw4XqhDQPSXP1QO9ZbGpNQByJPcU37Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3751;6:CBTLi+NgKXYR5TXWPuhUJzUDhZY+aRFy9FEwl9sd/QRqRLmEFg1z5SbuNP5KxialswvJrF1dnse+nn0JZ/UXa5XqSyAJQejekhjuB0YeF8lmrlp8s9yEW1MBmfHw2z+Y/7rikPMZflOD7sebTVq0d0VD/GJPZwcMbQjZLSui7/0GY6Nd4c91ozYOkkK43Me1jS8JEFhJA2YJqIQqxblqS4drxEK+IfOt3g14ZWUnLgOqOULT9J6XdAO7vBnl8vVpEXYWRcD1ZKWnNfO+A0DeGUMw0mLZRouhvYoAqtgzblKT1RuyIBer2Tltv4bf214oCkf5rp8tsi2ybO9PVL0c8DAxw4c9jAmpDQWTInyiUnakaTCSbq6Dz6HBGpUmIhlzOgRV6kXXBi7emBp7b5pVSSiO0iseGQKVNKntdpwdkWYWdUcUqH4bPfRaA6udZA+TO1hiZNFb30pwTuQkQ7zkcA==;5:uVQ2VbmqYRsvpjnCdW2i54GRFLTdNMt+tOTAVsLE0YJ1F2FyTqUySZfKq6FkhSJWztJysu4fatpplGeb/QopBUwx2ibm0eVvfv6gRGtaZ+bxcHE+DNL02VEmFUkMjCMxjzylKqzVLLr6VMC7fyoV8r2M5oph2SNybaqo3mLFtvQ=;7:ThaW5P9z+EfOtw+Hr+zjA8SMOENPHolQiBeg6VEquutFWJnwFKoz2RQ5qsMQKg1szDWCB2fOL20wAVlHVniAJT2vYiMjFi9b30mHPvcbp2UZg4G6xeuMkACYJFZrdh3aIOWGCW+M2Oe4i83jF7miMczoWRAjEQhpz4AH7iYepyXLpcUS9WS0xKTNDKMakr4FjDdVZGHVQrEgFP7aFLBdB/81BHdP1KbmqIXzTS2kmpSLL4z9/3vpn9IFOeolvjyQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7f226a99-4375-4d21-2c6d-08d61f945900
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3751;
x-ms-traffictypediagnostic: AM6PR0402MB3751:
x-microsoft-antispam-prvs: <AM6PR0402MB3751B43CD3EB7F9E5AFA3303EC120@AM6PR0402MB3751.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR0402MB3751;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3751;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(13464003)(8936002)(256004)(55016002)(476003)(5660300001)(4326008)(74316002)(6436002)(305945005)(68736007)(105586002)(486006)(11346002)(86362001)(6246003)(44832011)(71190400001)(6862004)(71200400001)(7736002)(6636002)(14444005)(5250100002)(53936002)(8676002)(66066001)(97736004)(2906002)(446003)(3846002)(14454004)(6506007)(478600001)(9686003)(33656002)(76176011)(26005)(25786009)(2900100001)(99286004)(6116002)(81166006)(81156014)(102836004)(229853002)(53546011)(7696005)(54906003)(316002)(93886005)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3751;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 445zmtoDovIZ/PjkgTY6cl+Hyp8h5gzJ9zuKQuvdvfj86dZG0A7AzeOp1mZ+EuihjhYtlfmvRY4vhBJ4ay6PdF6BE85BqO4ZoiSWjtGPTQwkS32AWFeWh4mL92XIOxI8jmn6zPnZsnyPttfaGxYrB4ML84xNdQ2J2nadGofFNu+bbJ7ME/E17UmZsSOKC9cS1GvBg8k/m2Rbos6kv1QfuapBiqSYxJVqNRXHh9dyqfZvGQUKsQfWJH1faYwyFlfMqK8yV1jb8cL3Au2Wz52NPQvnUFYqNSSRet5hvO2KTQ2evxCHT+nF5jBVxSISmMaFKXS8M+xlhvssVcJPbwXGkcehzn12sC6cGOUnIhQs/yQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f226a99-4375-4d21-2c6d-08d61f945900
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 07:32:12.7567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgWWFuZyBbbWFpbHRv
Omxlb3lhbmcubGlAbnhwLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMCwgMjAx
OCAxMDowNyBQTQ0KPiANCj4gT24gVGh1LCBTZXAgMjAsIDIwMTggYXQgNTozOSBBTSBMYXVyZW50
aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+DQo+
ID4NCj4gPiBPbiAxOS4wOS4yMDE4IDE3OjM3LCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+ID4gPiBP
biAxOS8wOS8xOCAxNToxOCwgTGF1cmVudGl1IFR1ZG9yIHdyb3RlOg0KPiA+ID4+IEhpIFJvYmlu
LA0KPiA+ID4+DQo+ID4gPj4gT24gMTkuMDkuMjAxOCAxNjoyNSwgUm9iaW4gTXVycGh5IHdyb3Rl
Og0KPiA+ID4+PiBIaSBMYXVyZW50aXUsDQo+ID4gPj4+DQo+ID4gPj4+IE9uIDE5LzA5LzE4IDEz
OjM1LCBsYXVyZW50aXUudHVkb3JAbnhwLmNvbSB3cm90ZToNCj4gPiA+Pj4+IEZyb206IExhdXJl
bnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+ID4gPj4+Pg0KPiA+ID4+Pj4g
VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBTTU1VIHN1cHBvcnQgZm9yIE5YUCBMUzEwNDNBIGFuZCBM
UzEwNDZBDQo+IGNoaXBzDQo+ID4gPj4+PiBhbmQgY29uc2lzdHMgbW9zdGx5IGluIGltcG9ydGFu
dCBkcml2ZXIgZml4ZXMgYW5kIHRoZSByZXF1aXJlZA0KPiBkZXZpY2UNCj4gPiA+Pj4+IHRyZWUg
dXBkYXRlcy4gSXQgdG91Y2hlcyBzZXZlcmFsIHN1YnN5c3RlbXMgYW5kIGNvbnNpc3RzIG9mIHRo
cmVlDQo+IG1haW4NCj4gPiA+Pj4+IHBhcnRzOg0KPiA+ID4+Pj4gICAgLSBjaGFuZ2VzIGluIHNv
Yy9kcml2ZXJzL2ZzbC9xYm1hbiBkcml2ZXJzIGFkZGluZyBpb21tdSBtYXBwaW5nDQo+IG9mDQo+
ID4gPj4+PiAgICAgIHJlc2VydmVkIG1lbW9yeSBhcmVhcywgZml4ZXMgYW5kIGRlZmVyZWQgcHJv
YmUgc3VwcG9ydA0KPiA+ID4+Pj4gICAgLSBjaGFuZ2VzIGluIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9kcGFhX2V0aCBkcml2ZXJzDQo+ID4gPj4+PiAgICAgIGNvbnNpc3RpbmcgaW4g
bWlzYyBkbWEgbWFwcGluZyByZWxhdGVkIGZpeGVzIGFuZCBwcm9iZQ0KPiBvcmRlcmluZw0KPiA+
ID4+Pj4gICAgLSBhZGRpdGlvbiBvZiB0aGUgYWN0dWFsIGFybSBzbW11IGRldmljZSB0cmVlIG5v
ZGUgdG9nZXRoZXIgd2l0aA0KPiA+ID4+Pj4gICAgICB2YXJpb3VzIGFkanVzdG1lbnRzIHRvIHRo
ZSBkZXZpY2UgdHJlZXMNCj4gPiA+Pj4+DQo+ID4gPj4+PiBQZXJmb3JtYW5jZSBpbXBhY3QNCj4g
PiA+Pj4+DQo+ID4gPj4+PiAgICAgICBSdW5uaW5nIGlwZXJmIGJlbmNobWFya3MgaW4gYSBiYWNr
LXRvLWJhY2sgc2V0dXAgKGJvdGggc2lkZXMNCj4gPiA+Pj4+ICAgICAgIGhhdmluZyBzbW11IGVu
YWJsZWQpIG9uIGEgMTBHQnBzIHBvcnQgc2hvdyBhbiBpbXBvcnRhbnQNCj4gPiA+Pj4+ICAgICAg
IG5ldHdvcmtpbmcgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gb2YgYXJvdW5kICU0MCAoOS40OEdi
cHMNCj4gPiA+Pj4+ICAgICAgIGxpbmVyYXRlIHZzIDUuNDVHYnBzKS4gSWYgeW91IG5lZWQgcGVy
Zm9ybWFuY2UgYnV0IHdpdGhvdXQNCj4gPiA+Pj4+ICAgICAgIFNNTVUgc3VwcG9ydCB5b3UgY2Fu
IHVzZSAiaW9tbXUucGFzc3Rocm91Z2g9MSIgdG8gZGlzYWJsZQ0KPiA+ID4+Pj4gICAgICAgU01N
VS4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBVU0IgaXNzdWUgYW5kIHdvcmthcm91bmQNCj4gPiA+Pj4+
DQo+ID4gPj4+PiAgICAgICBUaGVyZSdzIGEgcHJvYmxlbSB3aXRoIHRoZSB1c2IgY29udHJvbGxl
cnMgaW4gdGhlc2UgY2hpcHMNCj4gPiA+Pj4+ICAgICAgIGdlbmVyYXRpbmcgc21hbGxlciwgNDAt
Yml0IHdpZGUgZG1hIGFkZHJlc3NlcyBpbnN0ZWFkIG9mIHRoZQ0KPiA+ID4+Pj4gNDgtYml0DQo+
ID4gPj4+PiAgICAgICBzdXBwb3J0ZWQgYXQgdGhlIHNtbXUgaW5wdXQuIFNvIHlvdSBlbmQgdXAg
aW4gYSBzaXR1YXRpb24NCj4gPiA+Pj4+IHdoZXJlIHRoZQ0KPiA+ID4+Pj4gICAgICAgc21tdSBp
cyBtYXBwZWQgd2l0aCA0OC1iaXQgYWRkcmVzcyB0cmFuc2xhdGlvbnMsIGJ1dCB0aGUNCj4gZGV2
aWNlDQo+ID4gPj4+PiAgICAgICBnZW5lcmF0ZXMgdHJhbnNhY3Rpb25zIHdpdGggY2xpcHBlZCA0
MC1iaXQgYWRkcmVzc2VzLCB0aHVzDQo+IHNtbXUNCj4gPiA+Pj4+ICAgICAgIGNvbnRleHQgZmF1
bHRzIGFyZSB0cmlnZ2VyZWQuIEkgZW5jb3VudGVyZWQgYSBzaW1pbGFyDQo+ID4gPj4+PiBzaXR1
YXRpb24gZm9yDQo+ID4gPj4+PiAgICAgICBtbWMgdGhhdCBJICBtYW5hZ2VkIHRvIGZpeCBpbiBz
b2Z0d2FyZSBbMV0gaG93ZXZlciBmb3IgVVNCIEkNCj4gPiA+Pj4+IGRpZCBub3QNCj4gPiA+Pj4+
ICAgICAgIGZpbmQgYSBwcm9wZXIgcGxhY2UgaW4gdGhlIGNvZGUgdG8gYWRkIGEgc2ltaWxhciBm
aXguIFRoZQ0KPiBvbmx5DQo+ID4gPj4+PiAgICAgICB3b3JrYXJvdW5kIEkgZm91bmQgd2FzIHRv
IGFkZCB0aGlzIGtlcm5lbCBwYXJhbWV0ZXIgd2hpY2gNCj4gPiA+Pj4+IGxpbWl0cyB0aGUNCj4g
PiA+Pj4+ICAgICAgIHVzYiBkbWEgdG8gMzItYml0IHNpemU6ICJ4aGNpLWhjZC5xdWlya3M9MHg4
MDAwMDAiLg0KPiA+ID4+Pj4gICAgICAgVGhpcyB3b3JrYXJvdW5kIGlmIGZhciBmcm9tIGlkZWFs
LCBzbyBhbnkgc3VnZ2VzdGlvbnMgZm9yIGENCj4gY29kZQ0KPiA+ID4+Pj4gICAgICAgYmFzZWQg
d29ya2Fyb3VuZCBpbiB0aGlzIGFyZWEgd291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZC4NCj4g
PiA+Pj4NCj4gPiA+Pj4gSWYgeW91IGhhdmUgYSBub21pbmFsbHktNjQtYml0IGRldmljZSB3aXRo
IGENCj4gPiA+Pj4gbmFycm93ZXItdGhhbi10aGUtbWFpbi1pbnRlcmNvbm5lY3QgbGluayBpbiBm
cm9udCBvZiBpdCwgdGhhdCBzaG91bGQNCj4gPiA+Pj4gYWxyZWFkeSBiZSBmaXhlZCBpbiA0LjE5
LXJjIGJ5IGJ1c19kbWFfbWFzayBwaWNraW5nIHVwIERUIGRtYS0NCj4gcmFuZ2VzLA0KPiA+ID4+
PiBwcm92aWRlZCB0aGUgaW50ZXJjb25uZWN0IGhpZXJhcmNoeSBjYW4gYmUgZGVzY3JpYmVkIGFw
cHJvcHJpYXRlbHkNCj4gKG9yDQo+ID4gPj4+IGF0IGxlYXN0IG1hc3NhZ2VkIHN1ZmZpY2llbnRs
eSB0byBzYXRpc2Z5IHRoZSBiaW5kaW5nKSwgZS5nLjoNCj4gPiA+Pj4NCj4gPiA+Pj4gLyB7DQo+
ID4gPj4+ICAgICAgIC4uLg0KPiA+ID4+Pg0KPiA+ID4+PiAgICAgICBzb2Mgew0KPiA+ID4+PiAg
ICAgICAgICAgcmFuZ2VzOw0KPiA+ID4+PiAgICAgICAgICAgZG1hLXJhbmdlcyA9IDwwIDAgMTAw
MDAgMD47DQo+ID4gPj4+DQo+ID4gPj4+ICAgICAgICAgICBkZXZfNDhiaXQgeyAuLi4gfTsNCj4g
PiA+Pj4NCj4gPiA+Pj4gICAgICAgICAgIHBlcmlwaF9idXMgew0KPiA+ID4+PiAgICAgICAgICAg
ICAgIHJhbmdlczsNCj4gPiA+Pj4gICAgICAgICAgICAgICBkbWEtcmFuZ2VzID0gPDAgMCAxMDAg
MD47DQo+ID4gPj4+DQo+ID4gPj4+ICAgICAgICAgICAgICAgZGV2XzQwYml0IHsgLi4uIH07DQo+
ID4gPj4+ICAgICAgICAgICB9Ow0KPiA+ID4+PiAgICAgICB9Ow0KPiA+ID4+PiB9Ow0KPiA+ID4+
Pg0KPiA+ID4+PiBhbmQgaWYgdGhhdCBmYWlscyB0byB3b3JrIGFzIGV4cGVjdGVkIChleGNlcHQg
Zm9yIFBDSSBob3N0cyB3aGVyZQ0KPiA+ID4+PiBoYW5kbGluZyBkbWEtcmFuZ2VzIHByb3Blcmx5
IHN0aWxsIG5lZWRzIHNvcnRpbmcgb3V0KSwgcGxlYXNlIGRvIGxldA0KPiB1cw0KPiA+ID4+PiBr
bm93IDspDQo+ID4gPj4+DQo+ID4gPj4NCj4gPiA+PiBKdXN0IHRvIGNvbmZpcm0sIElzIHRoaXMg
WzFdIHRoZSBjaGFuZ2UgSSB3YXMgc3VwcG9zZWQgdG8gdGVzdD8NCj4gPiA+DQo+ID4gPiBOb3Qg
cXVpdGUgLSBkbWEtcmFuZ2VzIGlzIG9ubHkgdmFsaWQgZm9yIG5vZGVzIHJlcHJlc2VudGluZyBh
IGJ1cywgc28NCj4gPiA+IHB1dHRpbmcgaXQgZGlyZWN0bHkgaW4gdGhlIFVTQiBkZXZpY2Ugbm9k
ZXMgZG9lc24ndCB3b3JrIChGV0lXIHRoYXQncw0KPiA+ID4gd2h5IFBDSSBpcyBicm9rZW4sIGJl
Y2F1c2UgdGhlIHBhcnNlciBkb2Vzbid0IGV4cGVjdCB0aGUNCj4gPiA+IGJ1cy1hcy1sZWFmLW5v
ZGUgY2FzZSkuIFRoYXQncyB0ZWggcG9pbnQgb2YgdGhhdCBpbnRlcm1lZGlhdGUgc2ltcGxlLQ0K
PiBidXMNCj4gPiA+IG5vZGUgcmVwcmVzZW50ZWQgYnkgInBlcmlwaF9idXMiIGluIG15IGV4YW1w
bGUgKHNvcnJ5LCBJIHNob3VsZCBoYXZlDQo+IHB1dA0KPiA+ID4gY29tcGF0aWJsZXMgaW4gdG8g
bWFrZSBpdCBjbGVhcmVyKSAtIG9mdGVuIHRoYXQncyBhY3R1YWxseSB0cnVlIHRvDQo+IGxpZmUN
Cj4gPiA+IChpLmUuICJzb2MiIGlzIHNvbWV0aGluZyBsaWtlIGEgQ0NJIGFuZCAicGVyaXBoX2J1
cyIgaXMgc29tZXRoaW5nIGxpa2UNCj4gPiA+IGFuIEFYSSBOSUMgZ2x1aW5nIGEgYnVuY2ggb2Yg
bG93ZXItYmFuZHdpZHRoIERNQSBtYXN0ZXJzIHRvIG9uZSBvZiB0aGUNCj4gPiA+IENDSSBwb3J0
cykgYnV0IGF0IHdvcnN0IGl0J3MganVzdCBhIG5lY2Vzc2FyeSBldmlsIHRvIG1ha2UgdGhlIGJp
bmRpbmcNCj4gPiA+IGhhcHB5IChpZiBpdCBsaXRlcmFsbHkgb25seSByZXByZXNlbnRzIHRoZSBw
b2ludC10by1wb2ludCBsaW5rIGJldHdlZW4NCj4gPiA+IHRoZSBkZXZpY2UgbWFzdGVyIHBvcnQg
YW5kIGludGVyY29ubmVjdCBzbGF2ZSBwb3J0KS4NCj4gPiA+DQo+ID4NCj4gPiBRdWljayB1cGRh
dGU6IHNvIEkgYWRqdXN0ZWQgdG8gZGV2aWNlIHRyZWUgYWNjb3JkaW5nIHRvIHlvdXIgZXhhbXBs
ZSBhbmQNCj4gPiBpdCB3b3JrcyBzbyBub3cgSSBjYW4gZ2V0IHJpZCBvZiB0aGF0IG5hc3R5IGtl
cm5lbCBhcmcgYmFzZWQgd29ya2Fyb3VuZCwNCj4gPiB5ZXkhIDotKQ0KPiANCj4gR3JlYXQgdGhh
dCB3ZSBoYXZlIGEgZ2VuZXJpYyBzb2x1dGlvbiBsaWtlIEkgaG9wZWQgZm9yISAgU28geW91IHdp
bGwNCj4gc3VibWl0IGEgbmV3IHJldmlzaW9uIG9mIHRoZSBzZXJpZXMgdG8gaW5jbHVkZSB0aGVz
ZSBkdHMgdXBkYXRlcywNCj4gcmlnaHQ/DQo+IA0KDQpZZXMsIEkgYWxyZWFkeSBoYXZlIGl0IHBy
ZXBhcmVkLiBKdXN0IGRlbGF5aW5nIHRoZSB2MiBmb3IgYSBmZXcgZGF5cyBtYXliZSB0aGVyZSB3
aWxsIGJlIHNvbWUgbW9yZSBmZWVkYmFjay4NCg0KLS0tDQpCZXN0IFJlZ2FyZHMsIExhdXJlbnRp
dQ0K
