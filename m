Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AAFC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D429E2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iRD5Rq1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D429E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeI2Jqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:46:32 -0400
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:38887
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbeI2Jqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay/iSuast34LT7wuJHIjBz49gqIEHBwHTYrPSOxvJis=;
 b=iRD5Rq1yaqY/YQq2HpraznIxz7dAWjIsCUvARE+pNEa5J159W68+Gfp/pDDCPXZTwnL0OqJUoFxu8K9tLzF2hxN2JbxA8gO3ngPQpGXJx7cRD2Wn/NAzrElHix05y7TZlvD6by/FKLGW0KdNJ9KWk7C0bee5/bopzldZywWDmeg=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.133.18) by
 VI1PR0401MB2672.eurprd04.prod.outlook.com (10.168.66.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Sat, 29 Sep 2018 03:19:43 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::984e:2d7e:1a9c:c1b9]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::984e:2d7e:1a9c:c1b9%7]) with mapi id 15.20.1185.022; Sat, 29 Sep 2018
 03:19:43 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Topic: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Index: AQHUVlODYLzUr6TXRkCk3Aso2dGK1KUEHlyAgAEqd6CAAIdcAIAAxprw
Date:   Sat, 29 Sep 2018 03:19:42 +0000
Message-ID: <VI1PR0401MB2237AB083B3A6A9E084E4349F8ED0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
 <20180927132507.GB23375@lunn.ch>
 <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
 <20180928151750.GD19396@lunn.ch>
In-Reply-To: <20180928151750.GD19396@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB2672;6:m6LKqawtE/l298S+Z+ScjCaw3f0/nAifC7FeMsWMG0/cmjhqXMyzKcAAnA46QnKbR2d8gGU2K39xzmm1corPAVTp3CRmvW6ftPf5ii3KZ+iX09QJwxXQzuJQyS+uhMlbDl9W/SwE5b+81JlA69QFa1NthkIwvaw6MrY8yzsdzMv0fX6HT8woXJIGMsqUvNepJCKYpiK7SlLb8qvS+Axa1yNne/5ZMaon/yG4bxD41Fj0GSFabSDQUTIRrWJdeZ+hmtB1HvvQVElwaLdtZk3oAyBNXThAXkzSAoUHY1mPPUGhqJX+a9uKg4cAlTKI88IRu5khbOET5uTcgojjXpzj7Hj3lHszMyamT1d16CZhL8O/QyeC3H6RuO+UR98dQ9o4XSzAzrYG64KiP670DvgJvNVd27ZIy88SO6RfwNtAQbvkfqSGz/I/XADSyUiW1K9uloRb1doDNeBWSysDnr2/oA==;5:JhLb9yIkjtRphKg2ELd0n0/4ILGez4d8DSok3Qa37ieosOygD4IpLVSKX1FsNbGzZeK8BLbtHMavpqSKE/NNYrpagwoxuns5NLFBYLiSsThf2CKFOqel4YAQ805P2K3nQ+4t4DymaUktGRgp9rc73oqzdn/BMA2topbE7CRLWhM=;7:vFvLDA5XVsk7shhO6uFvsb3b5+A8OBv0Wtj704ur0iRwwjHpQFi5oNb43lmF+Pr0XwLVCUcskzvnGFXmW0FPCUgSpzGTL7gYtf+w5vjJTbiknPYWzavDo3VwWjYUZ3M0Ke4I1gWL2YubYTzR4flQilBnb69q/aILMm9BELjOW24lL7lDHzfJ44rg10bS3m2Jtb1YboXiqXL42NMxIklM1/HyzNMfHuvK792YheEVaKbTsYTBFB7Tt3h625tR3tmz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e61b29e0-2320-4bd2-20d6-08d625ba6659
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2672;
x-ms-traffictypediagnostic: VI1PR0401MB2672:
x-microsoft-antispam-prvs: <VI1PR0401MB26723D2BC1B003C5038A6F3EF8ED0@VI1PR0401MB2672.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR0401MB2672;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2672;
x-forefront-prvs: 0810818DA0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(13464003)(189003)(199004)(68736007)(33656002)(93886005)(8936002)(53546011)(2906002)(81156014)(6506007)(81166006)(34290500001)(7736002)(102836004)(229853002)(25786009)(8676002)(106356001)(256004)(14444005)(2900100001)(105586002)(316002)(66066001)(71200400001)(71190400001)(54906003)(86362001)(5250100002)(305945005)(11346002)(6436002)(486006)(26005)(74316002)(476003)(6246003)(6916009)(39060400002)(9686003)(55016002)(99286004)(6116002)(4326008)(3846002)(53936002)(7696005)(5660300001)(478600001)(14454004)(97736004)(76176011)(186003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2672;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /LnZIvARXSB+pNrO91jAhhnpepnviUc7+w2vglENItmaulUWIhYx28eJFSm7LR8fe4upC53VsOWqlyRS+wSDMHYt9x7vU/7mMfuxx+OfFTSZQnSO00lFoDAlFcbm+PBGEFASJHPEMW7SvjtAUNj1CsJ9YBnjh8Uok2yTRxSY9DWvgwt5U21jQwZyfvh0C1eHqowmY9/X55KH64/AxWorlpVzzzF3KTtzd4UfmE0JqisfDyDG473wmidn6Xv/j88vSF7SoGJRXQYAwU7OWmQKLvw851ufOaBEA0AqDYH057urGHBII/Cr8uptsrwl8POD8tghOHeIYZvo5owG9fF99RyU+9d+q07VnbZheo/R67Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61b29e0-2320-4bd2-20d6-08d625ba6659
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2018 03:19:42.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJl
dyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjgsIDIw
MTggMTE6MTggUE0NCj4gVG86IFkuYi4gTHUgPHlhbmdiby5sdUBueHAuY29tPg0KPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAZHJpdmVyZGV2Lm9zdW9zbC5vcmc7DQo+
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5A
Z21haWwuY29tPjsNCj4gRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IElv
YW5hIENpb2NvaSBSYWR1bGVzY3UNCj4gPHJ1eGFuZHJhLnJhZHVsZXNjdUBueHAuY29tPjsgR3Jl
ZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzJdIG5ldDogZHBhYTI6IG1vdmUgRFBBQTIgUFRQIGRyaXZlciBvdXQg
b2Ygc3RhZ2luZy8NCj4gDQo+ID4gPiBzdHJ1Y3QgZHBydGNfY21kX2dldF9pcnEgLSBQdXR0aW5n
IHBhZCBhdCB0aGUgYmVnaW5uaW5nIG9mIGEgc3RydWN0DQo+ID4gPiBzZWVtcyB2ZXJ5IG9kZC4g
QW5kIGl0IGlzIG5vdCB0aGUgb25seSBleGFtcGxlLg0KPiA+DQo+ID4gW1kuYi4gTHVdIFRoaXMg
c2hvdWxkIGRlcGVuZGVkIG9uIE1DIGZpcm13YXJlIGFuZCBBUElzIEkgdGhpbmsuIE9uY2UgdGhl
DQo+IE1DIGltcHJvdmVzIHRoaXMsIHRoZSBBUElzIGNvdWxkIGJlIHVwZGF0ZWQgdG8gZml4IHRo
aXMuDQo+IA0KPiBUaGF0IGlzIGdvaW5nIHRvIGJlIGhhcmQgdG8gZG8uIElkZWFsbHkgdGhlIGRy
aXZlciBzaG91bGQgd29yayB3aXRoIGFueQ0KPiBmaXJtd2FyZSB2ZXJzaW9uLiBZb3UgZG9uJ3Qg
cmVhbGx5IHdhbnQgdG8gZm9yY2UgdGhlIHVzZXIgdG8gdXBncmFkZSB0aGUNCj4gZHJpdmVyL2tl
cm5lbCBhbmQgdGhlIGZpcm13YXJlIGF0IHRoZSBzYW1lIHRpbWUuIFNvIHlvdSBjYW5ub3QgZm9y
IGV4YW1wbGUNCj4gcmVtb3ZlIHRoaXMgcGFkLiBXaGF0IHlvdSBtaWdodCBiZSBhYmxlIHRvIGRv
IGluIG5ld2VyIHZlcnNpb25zIGlzIGFjdHVhbGx5DQo+IHVzZSB0aGUgc3BhY2UuIEJ1dCB5b3Ug
aGF2ZSB0byBiZSBzdXJlIHRoZSBjdXJyZW50IGNvZGUgaXMgY29ycmVjdGx5IGlnbm9yaW5nIGl0
DQo+IGFuZCBzZXR0aW5nIGl0IHRvIHplcm8uDQoNCltZLmIuIEx1XSBUaGFua3MgYSBsb3QsIEkg
dGhpbmsgSSB1bmRlcnN0YW5kIG5vd/CfmIoNClRoZSBmaWxlcyBkcHJ0YyogZGVmaW5pbmcgdGhl
IEFQSXMgd2VyZSBwcm92aWRlZCB0b2dldGhlciB3aXRoIE1DIGZpcm13YXJlLiBUaGV5IHdlcmUg
dGVzdGVkIHdvcmtpbmcgZmluZS4NCk1DIGZpcm13YXJlIHdvdWxkIGFsc28gY29uc2lkZXIgdGhl
IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgSSB0aGluay4NClJlZ2FyZGluZyB0byB0aGUgQVBJIGZp
bGVzLCBsZXQgbWUgcmVtb3ZlIHVudXNlZCBjb2RlIGJlZm9yZSB1c2luZyB0aGVtLCBhbmQga2Vl
cCB0aGUgcmVzdC4NCg0KPiANCj4gCUFuZHJldw0K
