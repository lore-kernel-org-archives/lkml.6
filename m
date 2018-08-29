Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C82920652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="oH8m7nYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C82920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeH2XLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:11:37 -0400
Received: from mail-bn3nam01on0053.outbound.protection.outlook.com ([104.47.33.53]:56028
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbeH2XLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5obssNj2hYWDF14WfvblEPqku4pYtKWPl6ewNryq1U=;
 b=oH8m7nYT2j+J46rOF3KcNnzksdQUU3q1MAcGpFXwrCljSelMutO4xAL8VwSyZJn/v9kVdlvfqLMGDXmoMrcLLf9KERXSMp1C92s5jkMfSSGDWRoc8CAiujlGV3V0nKQAvbLRR8yPzz8jbesDNbYGdBrqEl4KV2914mwuWfYKinc=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB699.namprd06.prod.outlook.com (10.141.226.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Wed, 29 Aug 2018 19:13:16 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 19:13:16 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] lightnvm: pblk: collection of small fixes
Thread-Topic: [PATCH 0/4] lightnvm: pblk: collection of small fixes
Thread-Index: AQHUP3b0c02+jLolfUKSPiOQdz1hBKTWtYWAgAADrICAAE9NgIAAEUE/
Date:   Wed, 29 Aug 2018 19:13:15 +0000
Message-ID: <6E7A547D-842F-4842-84FB-05180AA50D79@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
 <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
 <3F0AC430-4499-4D2D-B989-45B5635307A4@cnexlabs.com>,<115fa3ea-c53b-557f-9465-5f61a02efa49@lightnvm.io>
In-Reply-To: <115fa3ea-c53b-557f-9465-5f61a02efa49@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [83.94.206.14]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB699;6:g02CC34u3nkBpfnjGiVsJeP42VAjIsDfl2+ZEjXXoH3vgVZhxhp+OVjKLSzkbI8IpFY1C+0z4rB8n2fmetC3X6Y3hgTCwh3S9f0k0jL9eILs81y1ZFCk/dH+wVmrCgruvlDmRsgcpIG5RHLPkIw1mG8rhQ9w/M2ijNMqVZ07OyFu8uLYfsqbjB+MWM8X6ELOeC7w6w7C6kAvru32+wE0Wpx7bCuyZGNTOUU4LM4EEqaZp3iJCvrBWc06CpgT5eX9SfFBFov2NWWzFYFEESxNdEfW7ytBFZTIkBWYGdN7OsIjwKECxyjN/jPq4zUKK0d9dE1gkR4xKTHfV/1NInyUXKMV1rFCrx8pMdQ6tR8bwKZooXOdshBWKpMm/3G3BjFoIzykWD0QfFUcOX15wOpRvMJvth0JjEdzjtFsaIMtaQeY511a6bQMBBZ4nTIuTduK9u3tmbZ4x364e/s8XwOrJQ==;5:uqeXzxkflULIdWz5P0jdvnipxXjIPBsg6g88g5DtV9MWq2u1mBPmcv+mdLJKpdRXSiQ4Bcqm/2rz06AbdL5OzGDefVuK86NjKINS5nY0zuYWbiM4O7D1SoVXJ8fPDE/CvQudOmUKiemOJex1U6N5fTsgU23prMz4PPaXWzvGBPQ=;7:IUTytEcYYddszen/zen8t/5DZxNe/WtvCO/u31IEMH4tHyhFvV9kJ6eLxETK1zEP0Z5dMt/jg4xhgdkQP6O6w21b6SOMp+jpt3cSWfRTY+TpF7ljyNMf6VSHrgTpZVuP/QrZhWr/lvZMbWFtZ8HTAV+B3Xyh6psrZCxWq1H+pXkVbSi0V1S/nOG1V6nLhLdNB3nMQgI5bo9mkSX6bbz7ymCFagScuWgve30T7GiXaQgij/2T4B98ihtFAsBoEY/K
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 791bb5d2-6b53-4d4b-4029-08d60de37932
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB699;
x-ms-traffictypediagnostic: CO2PR06MB699:
x-microsoft-antispam-prvs: <CO2PR06MB6998923F62073CC2E1A0219BA090@CO2PR06MB699.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB699;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB699;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39840400004)(136003)(396003)(199004)(189003)(6512007)(6246003)(2616005)(8676002)(81166006)(36756003)(7736002)(76176011)(53936002)(14454004)(93886005)(305945005)(25786009)(54906003)(476003)(4326008)(5250100002)(486006)(81156014)(6436002)(316002)(26005)(186003)(229853002)(99286004)(14444005)(6506007)(102836004)(53546011)(256004)(6486002)(446003)(5660300001)(11346002)(33656002)(478600001)(6116002)(66066001)(86362001)(3846002)(6916009)(8936002)(83716003)(68736007)(97736004)(105586002)(106356001)(82746002)(2906002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB699;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: czIJI1pxz4bn0TBKNZmi8pcsVE8nB2fUzxgN/5Dv6EnZZz1mGI9Y+I8iWGg8c35a0fXrcXNJOovCJO3kUE52+5+0yuCKCJjAVeSpA+r8wUjybiFTK5lAB7Vw/Z7K1AXanBTOf5353IH02kHKkQOnBq/M9xAZFzmXMU1X47LfG8CpVRdJoBWxNqlgMmc1J3e0FdowTru1tZ7JGwGUjCMT1Q4FA1WuNhHlv4fliiZgTMkWID2Ih5Nzdl16/PFB/YVNt0WwKM0DAsQPr40RShQ1o8e52V9wxmVXapTlrz1zjdS4AFRmopR5nvx3VhmzqtcpwJROwMzI9AtJv95A9xSndmMjh4aeQeMoFwhgGMtzq7I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791bb5d2-6b53-4d4b-4029-08d60de37932
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 19:13:16.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB699
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDI5IEF1ZyAyMDE4LCBhdCAyMC4xMSwgTWF0aWFzIEJqw7hybGluZyA8bWJAbGlnaHRu
dm0uaW8+IHdyb3RlOg0KPiANCj4gT24gMDgvMjkvMjAxOCAwMzoyNyBQTSwgSmF2aWVyIEdvbnph
bGV6IHdyb3RlOg0KPj4+IE9uIDI5IEF1ZyAyMDE4LCBhdCAxNS4xNCwgTWF0aWFzIEJqw7hybGlu
ZyA8bWJAbGlnaHRudm0uaW8+IHdyb3RlOg0KPj4+IA0KPj4+PiBPbiAwOC8yOS8yMDE4IDExOjAx
IEFNLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0KPj4+PiBDb2xsZWN0aW9uIG9mIHNtYWxsIGhl
bHBlciBmdW5jdGlvbiBmaXhlcywgcmVtb3ZhbCBvZiB1bnVzZWQgdmFyaWFibGVzDQo+Pj4+IGFu
ZCBjb21tZW50IHR5cG9zLg0KPj4+PiBKYXZpZXIgR29uesOhbGV6ICg0KToNCj4+Pj4gICBsaWdo
dG52bTogcGJsazogY2FsY3VsYXRlIGxpbmUgcGFkIGRpc3RhbmNlIGluIGhlbHBlcg0KPj4+PiAg
IGxpZ2h0bnZtOiBwYmxrOiBmaXggY29tbWVudCB0eXBvDQo+Pj4+ICAgbGlnaHRudm06IHBibGs6
IHJlbW92ZSB1bnVzZWQgdmFyaWFibGUuDQo+Pj4+ICAgbGlnaHRudm06IHBibGs6IGd1YXJhbnRl
ZSBlbWV0YSBvbiBsaW5lIGNsb3NlDQo+Pj4+ICBkcml2ZXJzL2xpZ2h0bnZtL3BibGstY29yZS5j
ICAgICB8IDEzICsrKysrKysrKysrLS0NCj4+Pj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay1yZWNv
dmVyeS5jIHwgIDIgLS0NCj4+Pj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay13cml0ZS5jICAgIHwg
IDIgKy0NCj4+Pj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay5oICAgICAgICAgIHwgIDYgKysrLS0t
DQo+Pj4+ICA0IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
DQo+Pj4gDQo+Pj4gVGhhbmtzLiBBcHBsaWVkIDItNC4gVGhlIHBhZCBkaXN0YW5jZSBkb2VzIG5v
dCBjb21waWxlIGR1ZSB0byBtaXNzaW5nDQo+Pj4gdXBkYXRlIHRvIHBibGtfcGFkX2Rpc3RhbmNl
IGNhbGwgZnJvbSBwYmxrLXJlY292ZXJ5LmMuDQo+Pj4gDQo+Pj4gQWxzbywgaXQgbG9va3MgbGlr
ZSBwYmxrLXJlY292ZXJ5LmMgaXMgdGhlIG9ubHkgdXNlci4gUGxlYXNlIGNvbnNpZGVyDQo+Pj4g
bW92aW5nIGl0IHRoZSBmdW5jdGlvbiBmcm9tIHBibGsuaCB0byBwYmxrLXJlY292ZXJ5LmMNCj4+
IEkgcmVvcmRlcmVkIHRvIHNlbmQgdGhlIGhlbHBlcnMsIGJ1dCB5b3UgY2FuIHNlZSB0aGF0IGFs
bCB0aGVzZSBhcmUgbWFkZQ0KPj4gdG8gc3VwcG9ydC4NCj4+ICAgbGlnaHRudm06IHBibGs6IHJl
Y292ZXIgb3BlbiBsaW5lcyBvbiAyLjAgZGV2aWNlcw0KPj4gQ2FuIHlvdSBmaXggdGhpcyBkaXJl
Y3RseSBhbmQgYXBwbHkgMSB0b28/IEknbSBmaW5lIHdpdGggbW92aW5nIGl0IHRvDQo+PiBwYmxr
LXJlY292ZXJ5LmMuIFRoZSBwYXRjaCBhYm92ZSB3aWxsIHVzZSBpdC4NCj4gDQo+IFllcy4gSSd2
ZSBmaXhlZCBpdCB1cCBpbiBwYmxrLXJlY292ZXJ5LmMsIGFuZCBhbHNvIG1vdmVkIHRoZSBmdW5j
dGlvbiB0byBwYmxrLXJlY292ZXJ5LmMuIEFwcGxpZWQgZm9yIDQuMjAuDQoNClRoYW5rcyENCg==
