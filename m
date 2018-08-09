Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FADC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F6321EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="PZwDvGAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F6321EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHIUvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:51:12 -0400
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:9248
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbeHIUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flxGBxRQmMD9iyJpjnxPPoOYk37kmNbOuPDnibFHZhw=;
 b=PZwDvGAaZPSLmFawh2BP4PnupkcBBjmcOML/HEjd1znDgj3yKddanWjSU3dxgb4ESd+28MSyCzOrb2sTlVpXPolPOJNY430EvfYrCssV0iAWBYwoP/7FoodJc/ceu9WUNUujYEmRsAMx6cnYCM1qmO4IVyT+ExhTVEfAQ1i87nU=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3673.namprd06.prod.outlook.com (10.167.236.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Thu, 9 Aug 2018 18:24:03 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c41d:e8d9:b123:5864]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c41d:e8d9:b123:5864%2]) with mapi id 15.20.1038.023; Thu, 9 Aug 2018
 18:24:03 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "dianders@chromium.org" <dianders@chromium.org>,
        "dkota@codeaurora.org" <dkota@codeaurora.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kramasub@codeaurora.org" <kramasub@codeaurora.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Thread-Topic: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Thread-Index: AQHT4yafyeQn7soaS0qz4ku89UJpHKQrKQSAgA9INYCAAaFigIAADB0AgAMSxQCAAAEJAIBvT2e2gAnOcoCAAAWfAA==
Date:   Thu, 9 Aug 2018 18:24:03 +0000
Message-ID: <1533839042.2283.305.camel@impinj.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
         <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
         <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
         <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
         <20180522173000.GG24776@sirena.org.uk>
         <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
         <20180524162940.GA4828@sirena.org.uk>
         <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
         <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
         <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
In-Reply-To: <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3673;6:I9B4s2Kv5WDLjF4CSVvH66JRODF07HXO1hm6ZTUJAFxzNzqgt2YqdfGXBV2Ld4PxruNHcdjkDd/3yYN2tzx7hLUaJj+al07p86oFI1SCx4DlCdZKv110oKdscvMIid+ITqKrPJ74ZbrHdQsxlbeEJTfFSxT9BTRnyUBzeAtzkd07QR5ZHTo1S30Vh4VNMHLQqGUgbAMffxa386aoGcVKlZHE3laieVnodl0MZLEDWnLKkNk7C7Wsewojzlj+8kE2TKEwE60CM8SJPs/5oQ7GRsUDKhYFrBi52/WdNCXZVRhE3DS8c2VryhkzbTIJ5gLXNXhCfd/9rewZl1ZbUE6ADbjipJLryztqdkmMJNUQwMENuZiGtonBDcJB4sswddOaiKWNsnPC4hi1nuYKNof7FZegmkugstezuUcxMp3M3Tjd33JMWT4NUlHuOWU4m5pfvTvwHuzCCHF/m3UStxSuwA==;5:8iOdyAmNFh4kfCjqQ37vnRcp2JDhwLQuohG+EKWXj78TE2F+3g8P35jNk70dAsxF1zaZfQGCf5DnzKiWt2RyYCdDGnf3JvaDCB8gGPXjsbnM8676YZehk2AAS1mTsFTfZ3n3oaOI25tFVBW/0I9eneTzoiRBV0FiVNGoOcaKMds=;7:cgyfTCsr5+hY2vD9Jng8xNDAP7uMt4NYDbVounTqcpofLQLOfVAvwhFWW87ZSn5JMwdtQYSLK4ca/obAl0qUrdB7vqkQ3Z/N4PRtHtxe2ROp+uQq6ZWRf6AFLRjUuVEralMoZU/UVFauIDeTRyID8xvihwve4kYXvFrkRXlusFdGuSzPHEuzZHsxdCNi1SoVIr+jzAT+s0quoP1hVq2rDvli2V9yEI1r/3MQevI08NeENKslB7nOSPZ8cDXvJtwI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df232504-a2e2-4775-7de1-08d5fe254911
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3673;
x-ms-traffictypediagnostic: MWHPR0601MB3673:
x-microsoft-antispam-prvs: <MWHPR0601MB3673964927B3718A72A0E1A0D3250@MWHPR0601MB3673.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3673;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3673;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39850400004)(136003)(189003)(199004)(68736007)(6512007)(53936002)(93886005)(316002)(2501003)(305945005)(7736002)(3846002)(478600001)(99286004)(36756003)(110136005)(6246003)(76176011)(54906003)(229853002)(6436002)(81166006)(25786009)(81156014)(4326008)(6486002)(8676002)(86362001)(6116002)(66066001)(103116003)(5660300001)(256004)(14444005)(2900100001)(106356001)(105586002)(26005)(486006)(102836004)(8936002)(5250100002)(97736004)(186003)(53546011)(6506007)(14454004)(7416002)(2906002)(476003)(2616005)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3673;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Fc9loHofLqGqGwRuAgmou44DtC60eq3/9cys3UuJHWh0/WL4Z9eAyQi0A07i/zRm54iTzXWA+D8IEZn592vwDfjjfOAm+59LFNhMYX/T2aIfR8/TqSWptQkj4+PIWCmsd7w5mbp/gv/GXDD/hT+LSa9tIoj8dU+6Rp0gaPjw38np7KhAFfmDcTFSvW+aCYKfnXX34vOzNuZLoHPlkHm0VQ6g3klasqetK6irr2sZwFdAs7byxKiuzPI/fd23BwsOGhtMA8ggqxLK3sh6Wpu3g/OT1GNoqm+DXU4RESZGo1VX0e9l3l1HZdsx+x1EOJYAM+Ddh5aCZ7Uu398uHqCe5MuvDm2mE3hiFrwEDD4epKU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B25E189A2D7E8D45B21D01B0055E6920@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df232504-a2e2-4775-7de1-08d5fe254911
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 18:24:03.4827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA4LTA5IGF0IDExOjAzIC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOg0K
PiBPbiBGcmksIEF1ZyAzLCAyMDE4IGF0IDU6MTggQU0sICA8ZGtvdGFAY29kZWF1cm9yYS5vcmc+
IHdyb3RlOg0KPiA+ID4gPiArICAgICAgIGlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5k
ZXYub2Zfbm9kZSwgInNwaS1tYXgtZnJlcXVlbmN5IiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmc3BpLT5tYXhfc3BlZWRfaHopKSB7DQo+ID4gDQo+ID4gDQo+ID4g
PiBXaHkgZG9lcyB0aGlzIG5lZWQgdG8gY29tZSBmcm9tIERUPw0KPiA+IA0KPiA+IA0KPiA+IFRo
aXMgaXMgcmVxdWlyZWQgdG8gc2V0IHRoZSBTUEkgY29udHJvbGxlciBtYXggZnJlcXVlbmN5Lg0K
PiA+IEFzIGl0IGlzIHNwZWNpZmljIHRvIHRoZSBjb250cm9sbGVyLCBzbyBsb29rcyBtZWFuaW5n
ZnVsIHRvIHNwZWNpZnkgaXQgaW4NCj4gPiBkdHNpLg0KPiA+IEFsc28sIHNwaSBjb3JlIGZyYW1l
d29yayB3aWxsIHNldCB0aGUgdHJhbnNmZXIgc3BlZWQgdG8gY29udHJvbGxlciBtYXgNCj4gPiBm
cmVxdWVuY3kNCj4gPiBpZiB0cmFuc2ZlciBmcmVxdWVuY3kgaXMgZ3JlYXRlciB0aGFuIGNvbnRy
b2xsZXIgbWF4IGZyZXF1ZW5jeS4NCj4gPiBQbGVhc2UgbWVudGlvbiBpZiB5b3UgaGF2ZSBhIG90
aGVyIG9waW5pb24uDQo+IA0KPiBIZXJlIGFyZSBteSB0aG91Z2h0czoNCj4gDQo+IDEuIEl0IHN1
cmUgc2VlbXMgbGlrZSB0aGUgY2xvY2sgZnJhbWV3b3JrIGNvdWxkIGJlIGVuZm9yY2luZyB0aGUg
bWF4DQo+IHNwZWVkIGhlcmUuICBTUEkgY2FuIGp1c3QgYXNrIGZvciB0aGUgc3BlZWQgYW5kIHRo
ZSBjbG9jayBmcmFtZXdvcmsNCj4gd2lsbCBwaWNrIHRoZSBoaWdoZXN0IHNwZWVkIGl0IGNhbiBp
ZiB5b3UgYXNrIGZvciBvbmUgdG9vIGhpZ2guICBJc24ndA0KPiB0aGF0IHRoZSB3aG9sZSBwb2lu
dCBvZiB0aGUgInN0cnVjdCBmcmVxX3RibCIgaW4gdGhlIGNsb2NrIGRyaXZlcj8NCj4gDQo+IA0K
PiAyLiBUaGUgZGV2aWNlIHRyZWUgd3JpdGVyIGFscmVhZHkgcHJvdmlkZXMgYSBtYXggY2xvY2sg
c3BlZWQgZm9yIGVhY2gNCj4gU1BJIHNsYXZlIGluIHRoZSBkZXZpY2UgdHJlZS4gIC4uLnNob3Vs
ZG4ndCB0aGUgZGV2aWNlIHRyZWUgd3JpdGVyDQo+IGFscmVhZHkgYmUgdGFraW5nIGludG8gYWNj
b3VudCB0aGUgbWF4IG9mIHRoZSBTUEkgcG9ydCB3aGVuIHNldHRpbmcNCj4gdGhpcyB2YWx1ZT8N
Cg0KTm8sIHRoZSB3YXkgaXQgd29ya3MgaXMgdGhlIGFjdHVhbCBzcGVlZCBpcyB0aGUgbGVzc2Vy
IG9mIHRoZSBtYXN0ZXIncw0KbWF4IGFuZCB0aGUgc2xhdmUgZGV2aWNlJ3MgbWF4Lg0KDQpCdXQg
dXN1YWxseSB0aGUgbWFzdGVyJ3MgbWF4IGlzIGRldGVybWluZWQgYnk6DQoNCjEuIFRoZSBpbnB1
dCBjbG9jayB0aGUgU1BJIG1hc3RlciBkZXZpY2UsIGFzIHByb3ZpZGVkIGJ5IHRoZSBjbG9jaw0K
ZnJhbWV3b3JrLiAgVXN1YWxseSB0aGUgbWF4IFNQSSBjbG9jayB3aWxsIGJlIHRoaXMgY2xvY2sg
LzIgb3INCnNvbWV0aGluZyBsaWtlIHRoYXQuDQoNCjIuIFRoZSBtYXN0ZXIgaGFzIHNvbWUgbWF4
aW11bSBjbG9jayBhcyBwYXJ0IG9mIGl0cyBzcGVjaWZpY2F0aW9ucywgaW4NCndoaWNoIGNhc2Ug
dGhlIGRyaXZlciBiYXNpY2FsbHkgaGFyZCBjb2RlcyBpdC4gIE1heWJlIGl0IGlzIGRpZmZlcmVu
dA0KYmFzZWQgb24gbW9kZWwgYW5kIHRoZSBkcml2ZXIgaGFzIGEgdGFibGUuDQoNClRoZSBkZXZp
Y2UgdHJlZSBpc24ndCByZWFsbHkgbWVhbnQgdG8gYmUgYSB3YXkgdG8gcmVtb3ZlIGFsbCBkYXRh
IGZyb20NCnRoZSBkZXZpY2UgZHJpdmVyIGp1c3QgYmVjYXVzZSBpdCBjYW4gYmUsIG9yIHNoaWZ0
IHdvcmsgZnJvbSB0aGUgZHJpdmVyDQphdXRob3IgdG8gdGhlIGRldmljZSB0cmVlIGF1dGhvci4N
Cg0KU28sIG9uZSBzaG91bGRuJ3Qgc3BlY2lmeSB0aGUgbWFzdGVyIG1heCBpbiB0aGUgRFQgaWYg
dGhlIGRyaXZlciBjb3VsZA0KZmlndXJlIGl0IG91dC4NCg0KU29tZXRpbWVzIHlvdSBzZWUgYSBm
aWVsZCBpbiB0aGUgRFQgYW5kIEkgdGhpbmsgdGhlIHRob3VnaHQgcHJvY2Vzcw0KdGhhdCBwdXQg
aXQgdGhlcmUgd2FzLCAiSSBkb24ndCB1bmRlcnN0YW5kIGhvdyB0byBzZXQgdGhpcyByZWdpc3Rl
ciwNCkknbGwganVzdCBzdGljayBpbiB0aGUgZGV2aWNlIHRyZWUgYW5kIHRoZW4gaXQncyBTb21l
b25lIEVsc2UncyBQcm9ibGVtDQp0byBmaW5kIHRoZSBjb3JyZWN0IHZhbHVlLiINCg0KVGhlIG1h
eCBzcGVlZCB0aGF0IHNvbWUgYm9hcmQgY2FuIHRhbGsgdG8gYSBTUEkgc2xhdmUgbWlnaHQgYmUg
ZnJvbSB0aGUNCnNwZWNzIG9mIHRoZSBzbGF2ZSBkZXZpY2Ugb3IgbWF5YmUgaXQncyBkdWUgdG8g
dGhlIHRyYWNlcyBvbiB0aGUgYm9hcmQNCml0c2VsZiB0aGF0IGlzIHRoZSBsaW1pdGluZyBmYWN0
b3IuICBJbiB0aGUgbGF0dGVyIGNhc2UgdGhlIGNvbnZlbnRpb24NCmlzIHRvIGNvbnNpZGVyIHRo
aXMgcGFydCBvZiB0aGUgc2xhdmUncyBtYXggc3BlZWQgYW5kIHB1dCBpbnRvIHRoZSBEVA0KaW4g
dGhlIHNsYXZlJ3MgRFQgbm9kZSBtYXggc3BlZWQgcHJvcGVydHkuDQoNClNvIHRoZSBzYW1lIHNw
aSBlZXByb20gY2hpcCBtaWdodCBoYXZlIGhhdmUgYSBtYXggaW4gdGhlIERUIG9mIDIwIE1Ieg0K
b24gb25lIGJvYXJkLCBjb3BpZWQgb3V0IG9mIHRoZSBlZXByb20ncyBkYXRhc2hlZXQuICBCdXQg
b24gYW5vdGhlcg0KYm9hcmQgaXQgaGFzIGEgbWF4IG9mIDEwIE1IeiBiZWNhdXNlIG9uIHRoYXQg
Ym9hcmQncyBsYXlvdXQgaXQgb25seQ0Kd29ya3MgdXAgdG8gMTAu
