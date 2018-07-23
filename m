Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F00ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C6A20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="22iEq1Yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C6A20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbeGWK1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:27:25 -0400
Received: from mail-eopbgr700073.outbound.protection.outlook.com ([40.107.70.73]:21472
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388049AbeGWK1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZDMOcxwKB8E4+njgTeXCTgoKGD3JiIiIR9n3uEJwkA=;
 b=22iEq1YoKOY5BY+UEk+2tF6CIv1ZqPI/1gq9p1S73CgYXGd63+oJYYViW2y1TClmmfJIQdxeLcvQcN+ojiMcUDudCCzz+kExNvaYxhZ2p2mcVkijfGunjjV5+dZORKrLEXOD2Z9UGK+cSd3Q0KTgerRmgt3b3lgx0eQ+dk0eIB4=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB4736.namprd02.prod.outlook.com (52.135.113.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 09:27:05 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7%4]) with mapi id 15.20.0973.018; Mon, 23 Jul 2018
 09:27:03 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while
 requesting irq
Thread-Topic: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while
 requesting irq
Thread-Index: AQHUHohBEv0sqwhVKESuL8mVdwkY2qSWwJ4AgAXQlDA=
Date:   Mon, 23 Jul 2018 09:27:03 +0000
Message-ID: <SN6PR02MB4959DB7E5C4D148D21F81E42C1560@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
 <32791313-d317-c9c3-0760-34d4a4a691f9@metafoo.de>
In-Reply-To: <32791313-d317-c9c3-0760-34d4a4a691f9@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4736;6:8tmHVld5e1qQQ+oAXQInSS86Le0u5rETALFzMAzGA/BiT3pYzCmdw2hjdgqs+X/+lBThERHKsJiIOHElp4pekuvfnk08U2Qz6DmRYDj7TKNlKIkuawFjVs+x1Vt9tGXE/cVAVhGFBlOGrLQVVE6K+rHVj9zYqG6ZS0uxsDms7fUUNmiqO2RmsFvR+oHRCnpaXn4xn6sGkva5N3LmCUFmPBylNrVKNKMVFgPfUsvFmEW9c1dy93F7H8TBLHWiMzwDkBXJ2QFUe70p5CceDTKYE8lLBhqewcbt0l4qJu76S6R276278bzE2XZ8zIpwB0GyxO7hq3omtCNalB4C8tZCwhEX2YetUbv7HvE0cX5DOxFjo6cwhuDcK6PyPDrX4xTe1t2R99Nn4pm093+Cl0rlU0riXd2k5k9SbVl912a0hpnCu26LBDmUHq6YhQbh/ZD0uLhC4AzwFdjBhpMcmkM8FA==;5:O7gjvVycDJlfqiPPOuXkePKOqMrrVWkd8Bc8nk7PeajYUTbmo0AtykEW0UVFH728yI+HX0/Pochku97i5Yw49V4gwJbyrOYS+uYYc1OWlfoNyE0cR0OmH8/TE2uoPMaNCKah8ZuQRDqZHrGbN98WOga+1a1WtYGG5NHOMoxqC/w=;7:rEF+CMQn+J261dNQXxr53IG3I4kgWydAOQYSKPdNDPDHRLgapPcOUP+ovUPC1tMtt+Vtf7GujIAoUxwhQxQAEZg5DWy/1KCIaoBPFFUWx5TdhTUK/Chpl1K/3p2l3OCvt3B86/AOvGomOlMqEji8rUXTwp6opOuZTXu1KV83O7bPzwA/GVNKOueW35QpZht7cBJvWGND8dknvfpWc9VC+KG9/zWvZvqiZDV/VnqRFGQeRUGZmP4x9qxDG94vovgg
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(13464003)(86362001)(8936002)(81156014)(81166006)(6116002)(3846002)(33656002)(5660300001)(74316002)(72206003)(476003)(186003)(66066001)(486006)(55016002)(11346002)(26005)(9686003)(8676002)(53936002)(6436002)(107886003)(6246003)(55236004)(53546011)(2900100001)(6506007)(102836004)(97736004)(5250100002)(105586002)(7696005)(2501003)(446003)(4326008)(2906002)(25786009)(54906003)(110136005)(99286004)(256004)(305945005)(229853002)(2201001)(478600001)(316002)(14454004)(76176011)(106356001)(68736007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4736;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: e7d55eea-6fe1-4c11-87cb-08d5f07e732c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4736;
x-ms-traffictypediagnostic: SN6PR02MB4736:
x-microsoft-antispam-prvs: <SN6PR02MB4736B30EC7D52C097A917691C1560@SN6PR02MB4736.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4736;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4736;
x-forefront-prvs: 0742443479
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I+W1M+UPib8W3ifbVOe70FBg97CfF567tisZBseLRpfPSsYzk7lsDpxKptxLwsh1yHEI+zd2bNDdbwyKOyxMq10Nayo7iP0xEODTvu7qyWSdtL9p9+kA23yb3MgQaWpHyROYn+KyY8hvmTOUPg3+HX/tEptuFvHOlqywfRhiM217mwfNk9OUgwHrlR7cOwD/3zGMkdQiRVfQaFhqfOtgrnoQVnGbpTHDd9nKsOi/wGYtortEcyduF35D5tMkeQGnGgeZrqqLqrrhP/bYFP3DDZXEOlWU6RLh+mjB4bBe3vo15SQYgsF3IDt3MHa8dHDagerKriuKLViDiEoWPtOcQloLDLoNcKCerTfuWrK0SK8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d55eea-6fe1-4c11-87cb-08d5f07e732c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 09:27:03.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGFycywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXJzLVBl
dGVyIENsYXVzZW4gW21haWx0bzpsYXJzQG1ldGFmb28uZGVdDQo+IFNlbnQ6IFRodXJzZGF5LCBK
dWx5IDE5LCAyMDE4IDEwOjA4IFBNDQo+IFRvOiBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlu
eC5jb20+OyBqaWMyM0BrZXJuZWwub3JnOw0KPiBrbmFhY2suaEBnbXguZGU7IHBtZWVyd0BwbWVl
cncubmV0OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT47IGxpbnV4LWlpb0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFuaXJ1ZGhhIFNhcmFuZ2kgPGFu
aXJ1ZGhAeGlsaW54LmNvbT47IFNyaW5pdmFzIEdvdWQNCj4gPHNnb3VkQHhpbGlueC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBpaW86IGFkYzogeGlsaW54OiBVc2UgZGV2bV8gZnVu
Y3Rpb25zIHdoaWxlIHJlcXVlc3RpbmcNCj4gaXJxDQo+IA0KPiA+IEBAIC0xMzEwLDcgKzEzMDgs
NiBAQCBzdGF0aWMgaW50IHhhZGNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gPiAq
cGRldikgIHsNCj4gPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBwbGF0Zm9ybV9nZXRf
ZHJ2ZGF0YShwZGV2KTsNCj4gPiAgCXN0cnVjdCB4YWRjICp4YWRjID0gaWlvX3ByaXYoaW5kaW9f
ZGV2KTsNCj4gPiAtCWludCBpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+DQo+
ID4gIAlpaW9fZGV2aWNlX3VucmVnaXN0ZXIoaW5kaW9fZGV2KTsNCj4gPiAgCWlmICh4YWRjLT5v
cHMtPmZsYWdzICYgWEFEQ19GTEFHU19CVUZGRVJFRCkgeyBAQCAtMTMxOCw3ICsxMzE1LDYNCj4g
QEANCj4gPiBzdGF0aWMgaW50IHhhZGNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gIAkJaWlvX3RyaWdnZXJfZnJlZSh4YWRjLT5jb252c3RfdHJpZ2dlcik7DQo+ID4g
IAkJaWlvX3RyaWdnZXJlZF9idWZmZXJfY2xlYW51cChpbmRpb19kZXYpOw0KPiA+ICAJfQ0KPiA+
IC0JZnJlZV9pcnEoaXJxLCBpbmRpb19kZXYpOw0KPiANCj4gVGhpcyBvcGVucyB1cCBhIHJhY2Ug
Y29uZGl0aW9uLiBUaGUgSVJRIG5lZWRzIHRvIGJlIGZyZWVkIGJlZm9yZSBhbnkgb2YgdGhlc2UN
Cj4gb3RoZXIgdGhpbmdzIGJlbG93IHRoZSBmcmVlX2lycSgpIGFyZSBleGVjdXRlZC4NCldpbGwg
bG9vayBpbnRvIGl0IGFuZCBzZW5kIHdpdGggdGFraW5nIGNhcmUgb2YgdGhlIHNhbWUuDQoNCj4g
DQo+ID4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoeGFkYy0+Y2xrKTsNCj4gPiAgCWNhbmNlbF9k
ZWxheWVkX3dvcmsoJnhhZGMtPnp5bnFfdW5tYXNrX3dvcmspOw0KPiA+ICAJa2ZyZWUoeGFkYy0+
ZGF0YSk7DQo+ID4NCg0KVGhhbmtzLA0KTWFuaXNoDQo=
