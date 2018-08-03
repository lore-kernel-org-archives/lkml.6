Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DA1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAA92175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Qeg2hjOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAA92175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeHCO6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:58:23 -0400
Received: from mail-sn1nam02on0108.outbound.protection.outlook.com ([104.47.36.108]:34112
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729367AbeHCO6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qTRS5AFOAApmSOAJ8PM9f44mDj9nbQI7O4ILeuScx4=;
 b=Qeg2hjOQtPXqnmkjH5wuaI55fwrGYHoCMCedXjue8gSa89pvsMlHAqqQoZ4A/p7pUHbz93S5gpPQIiHUtWEQFgDeYxqp0c/0JytfjwG1Xrkb+yK56NasjRg2NPgVC+vKorFS+CREq4Ba7Gbj5l9LO4vkEzGCsinaBHfdXVg15hg=
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (52.135.230.12) by
 BYAPR13MB2376.namprd13.prod.outlook.com (52.135.229.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.10; Fri, 3 Aug 2018 13:02:04 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::8daa:3cbd:93ad:9338]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::8daa:3cbd:93ad:9338%3]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 13:02:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] Please pull a NFS fix for 4.18
Thread-Topic: [GIT PULL] Please pull a NFS fix for 4.18
Thread-Index: AQHUKyose2xABCrUMUOmzIHTsE/03w==
Date:   Fri, 3 Aug 2018 13:02:03 +0000
Message-ID: <974d5a967d57a6d1649a1389cfedcae04d41ce07.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.164.207]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR13MB2376;6:xDjHVKB32jRv6R7NlH9IWArINVG2Vi13bCjRDg/IfdbzjSmsRBIrdNEr1VsaywaS0EXJh7a+zuaHdSLOyYKZl0Jk/HtONT0qqdsGN1ThbBkHZ/oyK7lqvgdrGTExY2l6K49Pgx+DGuQ3llJVKb/A0WRAon1YVK1VbnJH+/PIATD1rONIH88J+VELtAHWYXep01PK6n8uR98CRQ0JXympbviwO+cTxxw4WMxxPvk7ctQwWFmgav1Dzrlor7Dy18kAAsi8Rts+/GYnSFu4ulbp/0vCEcG6Q9vKB5T2pdjZb5ZYCS/T3JVXPkyT6SPKEA0vN0hR/Npsgs1avnTCneG1QZpXhB3olZPDhq9vwrw23I4eVayXy41i+OAp8YT9BWaG0Q3BS5mTltgWxwD7bmCrYGXaTAIA5ga6HBm0RxrmEnwKD39W7fPx+zCyYYbMfvD/0GPpF9JtoaxNO91KoGEu5A==;5:Cdy6r1gcRQ1uqO/SHxfHDAueB/P4sBaDzdwrdQJcNEW85X3+Q7QRc6nGhviOJZ6rsxxoICS8uE909LQc6ap+ShVwJ8+I3H5lC5QY8IpTGScfVM5cI0QipD7gD6jZ2+b0J/zRD5GXnTidgMws4oIvlYjfggbfiTS8cgrLdyvsUlo=;7:0Mc6Pi6gAyPIOnaB2gRcVmRQTmpL/iRMM8yHje2YIxMc7Mpbh0WFFH0Go11IQ/60cAldwWXse2RgrSwKNnvSOR1FGIFNWoaN0VUUmJBMGI0ZN95jMvHHi4lurc60SF2WSzpO80E+muu3irz8OVjDb89Cw2vC4t85Yl9FFfOdZyQ1zV5glylwWMA5fEWClEnOtV7TgJtYS+vk9ca2RnupPHBOKdmK1oD5QeMjzmAMCQ+vtFGxwhOm9WYDOZkY2MUt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7411584a-817e-435d-0d30-08d5f9414f89
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR13MB2376;
x-ms-traffictypediagnostic: BYAPR13MB2376:
x-microsoft-antispam-prvs: <BYAPR13MB23763634C9B8302BE12836EBB8230@BYAPR13MB2376.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(5213294742642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR13MB2376;BCL:0;PCL:0;RULEID:;SRVR:BYAPR13MB2376;
x-forefront-prvs: 0753EA505A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39830400003)(199004)(189003)(486006)(6506007)(68736007)(97736004)(86362001)(2900100001)(6512007)(81156014)(8676002)(81166006)(53936002)(102836004)(3846002)(476003)(2351001)(25786009)(2616005)(186003)(8936002)(26005)(6486002)(4326008)(36756003)(7736002)(6116002)(256004)(5660300001)(105586002)(99286004)(1730700003)(6436002)(106356001)(54906003)(478600001)(14454004)(5640700003)(316002)(118296001)(2501003)(5250100002)(2906002)(305945005)(6916009)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR13MB2376;H:BYAPR13MB2486.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IhJA30V81Uf1Bp5NuITWDoIGD+0JY3jcBLOtn6po89Jjn91b37H5vFU60SovF5mg+uZqa+HaP7BhovjrDXSciINx/e6HJHzLmZuLpk6VonECHMZbmhpiDob15MFiTi7mnBLRUufh4iMyMPctbuGN9N3TSMmy3v3+sdAB0vRsYu8mnaQWHsDP2x76dD0QdCXbjvs+PqNHwkyFwham8bpP00fyZWK1myHWN/ItC5E9WV9sUPRGps03OFnh+G548QGhYGRJdN3pTpkerMMYkkFvvhpbH5kqQdP6sE58OL9BTWRh6jamPyQlbKTGL6JJirdnNqRUz7fbQFSGDZjycXvZOVWv4wvro0KAtTH2pR+wn80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6087B58892C48646933C901F2C761B2C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7411584a-817e-435d-0d30-08d5f9414f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 13:02:04.3774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgOWE5N2ViZjdh
NmJiZmMxZTQyMGQ1M2Y1MjgxZjVmNDRkZjFlNTEwZDoNCg0KICBNZXJnZSB0YWcgJ21tYy12NC4x
OC1yYzUnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC91
bGZoL21tYyAoMjAxOC0wOC0wMSAxMTo0MzoxMyAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0
aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVj
dHMvdHJvbmRteS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci00LjE4LTMNCg0KZm9yIHlvdSB0
byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDZlYTc2YmY1MTMzOTUwNmU5ZmIwMGQ2Y2FlYmY1ZDZiNDJh
NTcxZTM6DQoNCiAgTkZTdjQ6IEZpeCBfbmZzNF9kb19zZXRsaygpICgyMDE4LTA4LTAxIDIzOjE3
OjA2IC0wNDAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpORlMgY2xpZW50IGJ1Z2ZpeGVzIGZvciBMaW51eCA0LjE4
DQoNCkhpZ2hsaWdodHMgaW5jbHVkZToNCg0KQnVnZml4ZXM6DQotIEZpeCBhIE5GU3Y0IGZpbGUg
bG9ja2luZyByZWdyZXNzaW9uDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRyb25kIE15a2xlYnVzdCAoMSk6DQogICAg
ICBORlN2NDogRml4IF9uZnM0X2RvX3NldGxrKCkNCg0KIGZzL25mcy9uZnM0cHJvYy5jIHwgMjYg
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgMTMgZGVsZXRpb25zKC0pDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
