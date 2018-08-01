Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC780C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E17A20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E17A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389334AbeHAPJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:09:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:55982 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388530AbeHAPJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:09:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 06:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="58863122"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2018 06:23:09 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 06:23:09 -0700
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 06:23:08 -0700
Received: from hasmsx106.ger.corp.intel.com ([169.254.10.9]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.132]) with mapi id 14.03.0319.002;
 Wed, 1 Aug 2018 16:23:06 +0300
From:   "Dreyfuss, Haim" <haim.dreyfuss@intel.com>
To:     Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cfg80211: read wmm rules from regulatory database
Thread-Topic: [PATCH] cfg80211: read wmm rules from regulatory database
Thread-Index: AQHUKMGbiSc2vpjIpE2Kg+hw2PrnLaSq42DQ
Date:   Wed, 1 Aug 2018 13:23:06 +0000
Message-ID: <409B2791E285FD41B488E034D9B4719F2D5D22DA@HASMSX106.ger.corp.intel.com>
References: <9ff30f03-07f1-0abd-8c57-2601af546de0@canonical.com>
In-Reply-To: <9ff30f03-07f1-0abd-8c57-2601af546de0@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjk2ZjA0MTMtMDYyOC00NWNhLThhMzUtOGMxOWVjZWRiYWIzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid20wOVM5NUpPMjc5eVNMdittWVwvMlZDK3A4K1dEb25EbXB6b1ZRSHNqb0F1aGxjVkdKVU9WUXN1Nnp1MEs5QlAifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.85.57]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyBbbWFp
bHRvOmNvbGluLmtpbmdAY2Fub25pY2FsLmNvbV0NCj4gU2VudDogVHVlc2RheSwgSnVseSAzMSwg
MjAxOCAyOjI4IFBNDQo+IFRvOiBEcmV5ZnVzcywgSGFpbSA8aGFpbS5kcmV5ZnVzc0BpbnRlbC5j
b20+OyBEYXZpZCBTLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBKb2hhbm5lcyBC
ZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PjsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IHJlOiBbUEFUQ0hdIGNmZzgwMjExOiByZWFkIHdtbSBy
dWxlcyBmcm9tIHJlZ3VsYXRvcnkgZGF0YWJhc2UNCj4gDQo+IEhpIEhhaW0sDQo+IA0KPiBJIHRo
aW5rIHRoZXJlIG1heSBiZSBhbiBpc3N1ZSB3aXRoIHRoZSBjb21taXQ6DQo+IA0KPiBGcm9tIDIz
MGViYWExODlhZjQ0ZDUwZGNjYjRhMTg0NmUzOWNhNTk0ZTM0N2IgTW9uIFNlcCAxNyAwMDowMDow
MA0KPiAyMDAxDQo+IEZyb206IEhhaW0gRHJleWZ1c3MgPGhhaW0uZHJleWZ1c3NAaW50ZWwuY29t
Pg0KPiBEYXRlOiBXZWQsIDI4IE1hciAyMDE4IDEzOjI0OjA5ICswMzAwDQo+IFN1YmplY3Q6IFtQ
QVRDSF0gY2ZnODAyMTE6IHJlYWQgd21tIHJ1bGVzIGZyb20gcmVndWxhdG9yeSBkYXRhYmFzZQ0K
PiANCj4gc3BlY2lmaWNhbGx5IGluIGZ1bmN0aW9uOiByZWdfY29weV9yZWdkKCkNCj4gDQo+ICsg
ICAgICAgZm9yIChpID0gMDsgaSA8IHNyY19yZWdkLT5uX3JlZ19ydWxlczsgaSsrKSB7DQo+ICAg
ICAgICAgICAgICAgICBtZW1jcHkoJnJlZ2QtPnJlZ19ydWxlc1tpXSwgJnNyY19yZWdkLT5yZWdf
cnVsZXNbaV0sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCBpZWVlODAy
MTFfcmVnX3J1bGUpKTsNCj4gKyAgICAgICAgICAgICAgIGlmICghc3JjX3JlZ2QtPnJlZ19ydWxl
c1tpXS53bW1fcnVsZSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+IA0K
PiArICAgICAgICAgICAgICAgcmVnZC0+cmVnX3J1bGVzW2ldLndtbV9ydWxlID0gZF93bW0gKw0K
PiArICAgICAgICAgICAgICAgICAgICAgICAoc3JjX3JlZ2QtPnJlZ19ydWxlc1tpXS53bW1fcnVs
ZSAtIHNfd21tKSAvDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgaWVl
ZTgwMjExX3dtbV9ydWxlKTsNCj4gKyAgICAgICB9DQo+IA0KPiBUaGUgcG9pbnRlciBhcml0aG1l
dGljIChzcmNfcmVnZC0+cmVnX3J1bGVzW2ldLndtbV9ydWxlIC0gc193bW0pIGlzDQo+IHBlcmZv
cm1lZCBpbiB0ZXJtcyBvZiB0aGUgc2l6ZSBvZiBzdHJ1Y3QgaWVlZTgwMjExX3dtbV9ydWxlIGFu
ZCBub3QgaW4NCj4gYnl0ZXMgYW5kIEkgYmVsaWV2ZSB0aGF0IHRoZSBkaXZpc2lvbiBieSBzaXpl
b2Yoc3RydWN0DQo+IGllZWU4MDIxMV93bW1fcnVsZSkgaXMgbm90IHJlcXVpcmVkLg0KPiANCj4g
VGhpcyBpc3N1ZSB3YXMgZGV0ZWN0ZWQgYnkgc3RhdGljIGFuYWx5c2lzIHdpdGggQ292ZXJpdHkg
U2NhbiwNCj4gQ0lEIzE0Njc0NTEgKCJFeHRyYSBzaXplb2YgZXhwcmVzc2lvbiIpLCAnc3VzcGlj
aW91c19kaXZpc2lvbicNCj4gDQo+IEknbSBub3QgMTAwJSBzdXJlIHRoYXQgaXMgdGhpcyBhIGZh
bHNlIHBvc2l0aXZlIG9yIG5vdCwgYnV0IEkgdGhpbmsgaXQgbG9va3MNCj4gaW5jb3JyZWN0IHRv
IG1lLg0KDQpZZWFoIHlvdSdyZSByaWdodCwgdGhpcyBpcyBub3QgZmFsc2UgcG9zaXRpdmUuDQpK
b2hhbm5lcyBhbHJlYWR5IGZpeGVkIHRoYXQgYW5kIEx1Y2Egd2lsbCBwcm9iYWJseSBzZW5kIGl0
IGluIHRoZSBjb21pbmcgd2Vlay4NCj4gDQo=
