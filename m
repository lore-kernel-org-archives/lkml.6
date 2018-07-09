Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA5BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F84D20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GAOb5XB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F84D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeGIKhq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:37:46 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:16339
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932431AbeGIKho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0m1LrDcNa8DYJDf36gPr392aiviawyAPVJdkLBpvdc=;
 b=GAOb5XB3XAjvo3vragQ8LGPvZ9M3BBvbQyy0l3OoibLoKjlKd09mtfHrsBGxI1R+LWfAi+G3lMM+xFOKt/U1sLn/W8BCFukFKjy1rU6eE2SE59V/BlncCDM2gv8UFe2ofPXU868rD+WwTVl7x3X3V5NUynF6u8rl8/iFVm7WVHc=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3574.eurprd04.prod.outlook.com (52.133.20.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 10:37:41 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::ec30:550b:5843:9788]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::ec30:550b:5843:9788%5]) with mapi id 15.20.0930.022; Mon, 9 Jul 2018
 10:37:41 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Thread-Topic: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Thread-Index: AQHUFJgugrRDr4B2tUKtnWJv03FCZKSGuIgA
Date:   Mon, 9 Jul 2018 10:37:41 +0000
Message-ID: <119c6fc6-a32d-45a5-96ea-f6e9959b1e74@nxp.com>
References: <20180705194113.16256-1-roy.pledge@nxp.com>
 <20180705194113.16256-2-roy.pledge@nxp.com>
In-Reply-To: <20180705194113.16256-2-roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3574;7:9SFzb0I0jWRrGPG5SdQv34C8g+qF0xCFxBaTW5kMhGleZa7uKfdEtiXPNBmMrloWicEE06gOSU9oCDOYz2YS3i86A7cu1sXz7wzcjhbJZJGrHkncSvI0Ik364xc8NmMnmcOqkNKHSex1z4/mlEsufeq31zqtecnvUnCcMnawjv4CM7C+y3msLuZIDEg630TYa/CPFPA3tqq3qMwhlbEel0VQqrwKkLUUJC2Hu7Lp/ALyVLLFwWPZhZSmUIeukbTg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b03f40fe-1958-44c3-8394-08d5e587ffb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3574;
x-ms-traffictypediagnostic: AM6PR0402MB3574:
x-microsoft-antispam-prvs: <AM6PR0402MB3574BF1FA1B2FEEE4826409FEC440@AM6PR0402MB3574.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM6PR0402MB3574;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3574;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(189003)(199004)(5250100002)(25786009)(316002)(14444005)(105586002)(97736004)(256004)(31686004)(81156014)(106356001)(110136005)(2906002)(86362001)(8936002)(8676002)(6246003)(54906003)(81166006)(31696002)(6512007)(53936002)(305945005)(476003)(7736002)(486006)(2616005)(44832011)(446003)(66066001)(11346002)(2501003)(2201001)(3846002)(6486002)(5660300001)(102836004)(6506007)(53546011)(478600001)(14454004)(6116002)(6436002)(2900100001)(68736007)(76176011)(4326008)(26005)(36756003)(99286004)(6636002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3574;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Mvh+PyvmmQOCDrjhnzkTrBzOBEEpzsNHJ7eqBetjDdCu/cEodccr3VhCrHx6v4eudMXNfFe7I9FblGUJjU+qwxJCU3sQFGbH38RR8qCTBa3j92QuRYW9SxPET9Y9ka/Yk54yMUyh1W4QYorfc3++0AlJJTykDdZGEvZnSQM9tEAvNcROJQNhItmkWxngIBBjSVmh6uqpjj2P4cT5b8p4c5HOgbuoHpPbMjp9Dc9WRbCOyzQOflGwK8NZjZzezgeqS7XvevZyfhZJ7IYp3QobHCkwWc3poAt22kCiBevgsBBs0MBXqmiS6rWeo3DE8VsaPiTlpXo/t9iEvdv2cUA6rzOfZOBQbY5ciMBIc/v82xQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2323B01B6801B8469505342C448BC684@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03f40fe-1958-44c3-8394-08d5e587ffb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 10:37:41.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm95LA0KDQpDb3VwbGUgb2YgY29tbWVudHMgaW5saW5lLg0KDQpPbiAwNS4wNy4yMDE4IDIy
OjQxLCBSb3kgUGxlZGdlIHdyb3RlOg0KPiBNb3ZlIHRoZSBOWFAgRFBJTyAoRGF0YXBhdGggSS9P
IERyaXZlcikgb3V0IG9mIHRoZQ0KPiBkcml2ZXJzL3N0YWdpbmcgZGlyZWN0b3J5IGFuZCBpbnRv
IHRoZSBkcml2ZXJzL3NvYy9mc2wgZGlyZWN0b3J5Lg0KPiANCj4gVGhlIERQSU8gZHJpdmVyIGVu
YWJsZXMgYWNjZXNzIHRvIFF1ZXVlIGFuZCBCdWZmZXIgTWFuYWdlciAoUUJNQU4pDQo+IGhhcmR3
YXJlIG9uIE5YUCBEUEFBMiBkZXZpY2VzLiBUaGlzIGlzIGEgcHJlcmVxdWlzaXRlIHRvIG1vdmlu
ZyB0aGUNCj4gRFBBQTIgRXRoZXJuZXQgZHJpdmVyIG91dCBvZiBzdGFnaW5nLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUm95IFBsZWRnZSA8cm95LnBsZWRnZUBueHAuY29tPg0KPiAtLS0NCj4gICBN
QUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9jcnlwdG8vY2FhbS9zZ19zd19xbTIuaCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvY3J5cHRvL2NhYW0v
c2dfc3dfc2VjNC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBk
cml2ZXJzL3NvYy9mc2wvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDEwICsrKysrKysrKysNCj4gICBkcml2ZXJzL3NvYy9mc2wvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gICBkcml2ZXJzL3tzdGFn
aW5nL2ZzbC1tYy9idXMgPT4gc29jL2ZzbH0vZHBpby9NYWtlZmlsZSAgICAgICAgICB8ICAwDQo+
ICAgZHJpdmVycy97c3RhZ2luZy9mc2wtbWMvYnVzID0+IHNvYy9mc2x9L2RwaW8vZHBpby1jbWQu
aCAgICAgICAgfCAgMA0KPiAgIGRyaXZlcnMve3N0YWdpbmcvZnNsLW1jL2J1cyA9PiBzb2MvZnNs
fS9kcGlvL2RwaW8tZHJpdmVyLmMgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL3tzdGFnaW5nL2Zz
bC1tYy9idXMgPT4gc29jL2ZzbH0vZHBpby9kcGlvLWRyaXZlci50eHQgICB8ICAwDQoNCk1heWJl
IHRoaXMgc2hvdWxkIGJlIGNvbnZlcnRlZCB0byAucnN0IGFuZCBnbyBpbiB0aGUgYWxyZWFkeSBl
eGlzdGluZw0KRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RwYWEyLz8NCg0KPiAgIGRyaXZlcnMv
e3N0YWdpbmcvZnNsLW1jL2J1cyA9PiBzb2MvZnNsfS9kcGlvL2RwaW8tc2VydmljZS5jICAgIHwg
IDIgKy0NCj4gICBkcml2ZXJzL3tzdGFnaW5nL2ZzbC1tYy9idXMgPT4gc29jL2ZzbH0vZHBpby9k
cGlvLmMgICAgICAgICAgICB8ICAwDQo+ICAgZHJpdmVycy97c3RhZ2luZy9mc2wtbWMvYnVzID0+
IHNvYy9mc2x9L2RwaW8vZHBpby5oICAgICAgICAgICAgfCAgMA0KPiAgIGRyaXZlcnMve3N0YWdp
bmcvZnNsLW1jL2J1cyA9PiBzb2MvZnNsfS9kcGlvL3FibWFuLXBvcnRhbC5jICAgIHwgIDIgKy0N
Cj4gICBkcml2ZXJzL3tzdGFnaW5nL2ZzbC1tYy9idXMgPT4gc29jL2ZzbH0vZHBpby9xYm1hbi1w
b3J0YWwuaCAgICB8ICAyICstDQo+ICAgZHJpdmVycy9zdGFnaW5nL2ZzbC1kcGFhMi9ldGhlcm5l
dC9kcGFhMi1ldGguaCAgICAgICAgICAgICAgICAgfCAgNCArKy0tDQo+ICAgZHJpdmVycy9zdGFn
aW5nL2ZzbC1tYy9idXMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgOSAt
LS0tLS0tLS0NCj4gICBkcml2ZXJzL3N0YWdpbmcvZnNsLW1jL2J1cy9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAyIC0tDQo+ICAge2RyaXZlcnMvc3RhZ2luZy9mc2wtbWMv
aW5jbHVkZSA9PiBpbmNsdWRlL3NvYy9mc2x9L2RwYWEyLWZkLmggfCAgMA0KPiAgIC4uLi9zdGFn
aW5nL2ZzbC1tYy9pbmNsdWRlID0+IGluY2x1ZGUvc29jL2ZzbH0vZHBhYTItZ2xvYmFsLmggIHwg
IDANCj4gICB7ZHJpdmVycy9zdGFnaW5nL2ZzbC1tYy9pbmNsdWRlID0+IGluY2x1ZGUvc29jL2Zz
bH0vZHBhYTItaW8uaCB8ICAwDQo+ICAgMjAgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygr
KSwgMjAgZGVsZXRpb25zKC0pDQo+ICAgcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcvZnNsLW1jL2J1
cyA9PiBzb2MvZnNsfS9kcGlvL01ha2VmaWxlICgxMDAlKQ0KPiAgIHJlbmFtZSBkcml2ZXJzL3tz
dGFnaW5nL2ZzbC1tYy9idXMgPT4gc29jL2ZzbH0vZHBpby9kcGlvLWNtZC5oICgxMDAlKQ0KPiAg
IHJlbmFtZSBkcml2ZXJzL3tzdGFnaW5nL2ZzbC1tYy9idXMgPT4gc29jL2ZzbH0vZHBpby9kcGlv
LWRyaXZlci5jICg5OSUpDQo+ICAgcmVuYW1lIGRyaXZlcnMve3N0YWdpbmcvZnNsLW1jL2J1cyA9
PiBzb2MvZnNsfS9kcGlvL2RwaW8tZHJpdmVyLnR4dCAoMTAwJSkNCj4gICByZW5hbWUgZHJpdmVy
cy97c3RhZ2luZy9mc2wtbWMvYnVzID0+IHNvYy9mc2x9L2RwaW8vZHBpby1zZXJ2aWNlLmMgKDk5
JSkNCj4gICByZW5hbWUgZHJpdmVycy97c3RhZ2luZy9mc2wtbWMvYnVzID0+IHNvYy9mc2x9L2Rw
aW8vZHBpby5jICgxMDAlKQ0KPiAgIHJlbmFtZSBkcml2ZXJzL3tzdGFnaW5nL2ZzbC1tYy9idXMg
PT4gc29jL2ZzbH0vZHBpby9kcGlvLmggKDEwMCUpDQo+ICAgcmVuYW1lIGRyaXZlcnMve3N0YWdp
bmcvZnNsLW1jL2J1cyA9PiBzb2MvZnNsfS9kcGlvL3FibWFuLXBvcnRhbC5jICg5OSUpDQo+ICAg
cmVuYW1lIGRyaXZlcnMve3N0YWdpbmcvZnNsLW1jL2J1cyA9PiBzb2MvZnNsfS9kcGlvL3FibWFu
LXBvcnRhbC5oICg5OSUpDQo+ICAgcmVuYW1lIHtkcml2ZXJzL3N0YWdpbmcvZnNsLW1jL2luY2x1
ZGUgPT4gaW5jbHVkZS9zb2MvZnNsfS9kcGFhMi1mZC5oICgxMDAlKQ0KPiAgIHJlbmFtZSB7ZHJp
dmVycy9zdGFnaW5nL2ZzbC1tYy9pbmNsdWRlID0+IGluY2x1ZGUvc29jL2ZzbH0vZHBhYTItZ2xv
YmFsLmggKDEwMCUpDQo+ICAgcmVuYW1lIHtkcml2ZXJzL3N0YWdpbmcvZnNsLW1jL2luY2x1ZGUg
PT4gaW5jbHVkZS9zb2MvZnNsfS9kcGFhMi1pby5oICgxMDAlKQ0KDQpJIHJlY2VpdmVkIGZlZWRi
YWNrIGluIHRoZSBwYXN0IG9uIG1jLWJ1cyB0aGF0IGEgZHJpdmVyIHNob3VsZCBsaW1pdCB0byAN
Cm9ubHkgb25lIHB1YmxpYyBoZWFkZXIgYW5kIG9uZSBwcml2YXRlIG9uZS4gV291bGQgaXQgbWFr
ZSBzZW5zZSB0byBkbyANCnRoZSBzYW1lIGZvciBkcGlvIHRvbz8NCg0KLS0tDQpCZXN0IFJlZ2Fy
ZHMsIExhdXJlbnRpdQ==
