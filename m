Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gY7FDhbwHFtbZgAAmS7hNA
	; Sun, 10 Jun 2018 09:32:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1E279608CD; Sun, 10 Jun 2018 09:32:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oP/FhYqj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IJ+CDy+L"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4C2AB608B8;
	Sun, 10 Jun 2018 09:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C2AB608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753786AbeFJJbv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 05:31:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29254 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeFJJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 05:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528623108; x=1560159108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=STujZL+cuzFG80NvU5fO3pT8fcywy/uQWrykjgeq/3c=;
  b=oP/FhYqj7nGh4wn8Fvd21sSz+9vRXCCRGKknsvcDMHMOeCrVV9INIwfU
   iChSnVahLT83PpzzMEqTlULcCc8n2vWHO9Bu+MQPiSmaRmD2oK9XCUtQ7
   +2qn2rbLIQKQlo6ullZLboM3O7NNcy7Khb/Q8vSs3c+9FoKSNw8SVecc8
   iN7PAqGhSqF9L5Z7pZgrJPOQ2qonlDfHdXwY2y29wNWg23KRIqCjqAqYe
   qToKJnOJ5zT8FfHer0OiROYjbh8fxJrjWolUg4RofQ/s+sPcAdRHLKaF2
   BMh8EIBOZ5Y4e807f9gBoJGA/m+NQNUdJVSDSxcFagpJH31385nfTyvvx
   g==;
X-IronPort-AV: E=Sophos;i="5.49,497,1520870400";
   d="scan'208";a="80472460"
Received: from mail-co1nam05lp0080.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.80])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2018 17:31:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STujZL+cuzFG80NvU5fO3pT8fcywy/uQWrykjgeq/3c=;
 b=IJ+CDy+L85ZdIC1y3+m4u6McDbLAoZKuHQoBER4EUdQXfgG+2vmeqbD8uWCrECp6mEZcRlDCsdIzGTH+nSXDifjP0QJufB4oK80YOm8GCv+0WWwMeUuz4NGdMPBLLLoZVmAUdVloZbwoT124rUSMLV5Uamtx7s+jrjrmHuyApuo=
Received: from MWHPR04MB1137.namprd04.prod.outlook.com (10.173.51.151) by
 MWHPR04MB1007.namprd04.prod.outlook.com (10.174.250.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.797.11; Sun, 10 Jun 2018 09:31:45 +0000
Received: from MWHPR04MB1137.namprd04.prod.outlook.com
 ([fe80::b928:3117:cd49:eae]) by MWHPR04MB1137.namprd04.prod.outlook.com
 ([fe80::b928:3117:cd49:eae%2]) with mapi id 15.20.0841.019; Sun, 10 Jun 2018
 09:31:45 +0000
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Evan Green <evgreen@chromium.org>
CC: Vinayak Holikatti <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Topic: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Index: AQHT93lpGmTFqrK/4k6nSxRetFdr1aRJmw1AgAHj/gCAAtT7sIAB5jsAgAYf3wCAAuSwoA==
Date: Sun, 10 Jun 2018 09:31:45 +0000
Message-ID: <MWHPR04MB1137E9FA44BAC5EBE097589C9A790@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
 <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
 <MWHPR04MB11370AED823FB608218CB9AD9A600@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft5Vk3neDkyvmVf4CkBQQPVK=wXp=5jJ8n0uaosEwWUOAg@mail.gmail.com>
 <b844b80f-9f6f-10f7-6dfd-f92d905738e3@intel.com>
In-Reply-To: <b844b80f-9f6f-10f7-6dfd-f92d905738e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1007;7:XazicdiQ8d5Af152S6NVxlzgJIZxKOJ8UUJy/QkbRxdhAHzgOgwMCS27OgXfQRbsEiPoXNRu4IPk/KNR9xNWdInY/ymKSoZO3piTX/OgJcX5VVw9srVcCqnALEYZ6zztPFh+CiEtBQoBR4jvxRNTT9kC2LIx6A7QAI2pJM7PMF9cH7lgjn0vbVq5pttTKUBEPdmwF4XluJct1fCIWJ5jDXbcGROrZNNC41N3tm48ZFjjRUIEwjyMO/XfkshBLtiT;20:vVBobAMJfya2o1M988B99TeRgTlsJnWQ3kRXMPJMF8BGm7T51xQuFvGyogHUQWDbZP24UuWfuWTQ+lAizqpmTPjvvPHtLxQOEs2HvFnMIPaH29B8uoLzD+KLhCdn30jtgs1DioXO0zC86hORidU5WI23EAvNzgJvtJwweTBNbLE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1007;
x-ms-traffictypediagnostic: MWHPR04MB1007:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1007025BC266D5A5E1429CDB9A790@MWHPR04MB1007.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1007;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1007;
x-forefront-prvs: 0699FCD394
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(346002)(376002)(39380400002)(13464003)(199004)(189003)(53936002)(7736002)(74316002)(6506007)(76176011)(53546011)(14454004)(6116002)(11346002)(54906003)(110136005)(446003)(59450400001)(99286004)(66066001)(8936002)(5250100002)(4326008)(478600001)(81156014)(25786009)(3846002)(3660700001)(39060400002)(305945005)(93886005)(3280700002)(86362001)(6246003)(68736007)(72206003)(5660300001)(229853002)(97736004)(55016002)(476003)(316002)(8676002)(2900100001)(9686003)(81166006)(7696005)(6436002)(26005)(102836004)(486006)(106356001)(105586002)(186003)(2906002)(33656002)(5890100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1007;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YLffNrjERXcS8TvmWvhMWSBbznzqkcWPrSlYT4LiV/+uayq/tpwC0kD3wmjIYsWLHk70aCkxjR974D6Rjksl0P81rLTgIe0ZRfyF0TdclAKpq6g47GvRs1SoAVituVEQkur7TfsySoo1TCw++eZfx5GRpPEbgx5xa+ZMEcBS+QJvHHe0WI5nRXUxIwHh51s2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bf3058f0-d141-4fca-5b9f-08d5ceb4fbd8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3058f0-d141-4fca-5b9f-08d5ceb4fbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2018 09:31:45.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRyaWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmlh
biBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bmUg
OCwgMjAxOCAzOjMxIFBNDQo+IFRvOiBFdmFuIEdyZWVuIDxldmdyZWVuQGNocm9taXVtLm9yZz47
IFN0YW5pc2xhdiBOaWpuaWtvdiA8U3RhbmlzbGF2Lk5pam5pa292QHdkYy5jb20+DQo+IENjOiBW
aW5heWFrIEhvbGlrYXR0aSA8dmluaG9saWthdHRpQGdtYWlsLmNvbT47IGplamJAbGludXgudm5l
dC5pYm0uY29tOyBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbTsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBHd2VuZGFsIEdyaWdu
b3UgPGd3ZW5kYWxAY2hyb21pdW0ub3JnPjsgQWxleCBMZW1iZXJnDQo+IDxBbGV4LkxlbWJlcmdA
d2RjLmNvbT47IEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkB3ZGMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDAvN10gRW5hYmxlIFVGUyBwcm92aXNpb25pbmcgdmlhIExpbnV4DQo+IA0KPiBP
biAwNC8wNi8xOCAxNzo1OSwgRXZhbiBHcmVlbiB3cm90ZToNCj4gPiBPbiBTdW4sIEp1biAzLCAy
MDE4IGF0IDM6MjEgQU0gU3RhbmlzbGF2IE5pam5pa292DQo+ID4gPFN0YW5pc2xhdi5OaWpuaWtv
dkB3ZGMuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBsaW51eC1zY3NpLW93bmVyQHZnZXIua2VybmVsLm9y
ZyA8bGludXgtc2NzaS1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBFdmFuIEdy
ZWVuDQo+ID4+PiBTZW50OiBGcmlkYXksIEp1bmUgMSwgMjAxOCA1OjQ0IFBNDQo+ID4+PiBUbzog
U3RhbmlzbGF2IE5pam5pa292IDxTdGFuaXNsYXYuTmlqbmlrb3ZAd2RjLmNvbT4NCj4gPj4+IENj
OiBWaW5heWFrIEhvbGlrYXR0aSA8dmluaG9saWthdHRpQGdtYWlsLmNvbT47IGplamJAbGludXgu
dm5ldC5pYm0uY29tOyBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbTsgbGludXgtDQo+ID4+PiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgR3dlbmRh
bCBHcmlnbm91IDxnd2VuZGFsQGNocm9taXVtLm9yZz47IEFsZXggTGVtYmVyZw0KPiA+Pj4gPEFs
ZXguTGVtYmVyZ0B3ZGMuY29tPjsgQXZyaSBBbHRtYW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+DQo+
ID4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvN10gRW5hYmxlIFVGUyBwcm92aXNpb25pbmcgdmlh
IExpbnV4DQo+ID4+Pg0KPiA+Pj4gSGkgU3RhbmlzbGF2LiBUaGFua3MgZm9yIHRha2luZyBhIGxv
b2suIFJlc3BvbnNlcyBiZWxvdy4NCj4gPj4+DQo+ID4+PiBPbiBUaHUsIE1heSAzMSwgMjAxOCBh
dCAzOjA0IEFNIFN0YW5pc2xhdiBOaWpuaWtvdg0KPiA+Pj4gPFN0YW5pc2xhdi5OaWpuaWtvdkB3
ZGMuY29tPiB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+IEhpIEV2YW4sDQo+ID4+Pj4gSSBoYXZlIHNv
bWUgZ2VuZXJpYyBub3RlczoNCj4gPj4+PiAtIFdoeSB0byBjcmVhdGUgbmV3IHN5c2ZzIGVudHJp
ZXMgZm9yIHRoZSBjb25maWd1cmF0aW9uIGRlc2NyaXB0b3IgZmllbGRzIGlmIHRoZXkgYXJlIGp1
c3QgZHVwbGljYXRpb24gb2YgZmllbGRzIGluIHRoZSBkZXZpY2UgYW5kIHVuaXQNCj4gPj4+IGRl
c2NyaXB0b3JzPyBBbmQgdGhlIHN5c2ZzIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBkZXZpY2UgYW5k
IHVuaXQgZGVzY3JpcHRvcnMgaXMgZXhpc3RpbmcgYWxyZWFkeS4NCj4gPj4+DQo+ID4+PiBXZWxs
LCBVRlMgZGVzY3JpYmVzIHRoZW0gYXMgZGlmZmVyZW50IGRlc2NyaXB0b3JzLiBJIHdvcnJ5IHRo
YXQgaWYgSQ0KPiA+Pj4gYWRkIGEgYnVuY2ggb2YgY2xldmVyIGxvZ2ljIHRvIGhpZGUgdGhlIGNv
bmZpZyBkZXNjcmlwdG9yIGJlaGluZCBvdGhlcg0KPiA+Pj4gZGVzY3JpcHRvcnMsIHRoZXJlIG1p
Z2h0IGJlIHRyb3VibGUgbGF0ZXIgaWYgMSkgdGhlcmUgaXMgYSBxdWlya3kNCj4gPj4+IGRldmlj
ZSB0aGF0IGRvZXNuJ3QgcmVmbGVjdCB0aGUgdmFsdWVzIGJldHdlZW4gZGVzY3JpcHRvcnMgcXVp
dGUgdGhlDQo+ID4+PiBzYW1lIHdheSBvciBhdCB0aGUgc2FtZSB0aW1lLCBvciAyKSBpZiBhIGxh
dGVyIFVGUyBzcGVjIGFkZHMgbW9yZQ0KPiA+Pj4gY29uZmlndXJhdGlvbiBkZXNjcmlwdG9yIGZp
ZWxkcyB0aGF0IGRvbid0IGV4YWN0bHkgcmVmbGVjdCBpbnRvIG90aGVyDQo+ID4+PiBub24tY29u
ZmlnIGRlc2NyaXB0b3JzLCB0aGUgY2xldmVybmVzcyB3aWxsIGxvb2sgYXdrd2FyZC4NCj4gPj4N
Cj4gPj4gTm8gYWRkaXRpb25hbCBsb2dpYyB3aWxsIGJlIHJlcXVpcmVkIHRvIGF0dGFjaCB3cml0
ZSBmdW5jdGlvbmFsaXR5IHRvIHRoZQ0KPiA+PiBleGlzdGluZyBlbnRyaWVzIGluc3RlYWQgb2Yg
bmV3IGRlZmluZWQgb25lcy4gSXQgd2lsbCByZWR1Y2UgdGhlIHBhdGNoDQo+ID4+IHNpemUgc2ln
bmlmaWNhbnRseS4gQW5kIHRoZXJlIHdpbGwgYmUgbm8gbmVlZCBmb3IgdGhlIHVuaXQgc2VsZWN0
b3INCj4gPj4gbWVjaGFuaXNtIHdoaWNoIEknbSBub3Qgc3VyZSB3aWxsIGJlIGFjY2VwdGVkIGJ5
IHRoZSBTQ1NJIGNvbW11bml0eS4NCj4gPj4NCj4gPg0KPiA+IFNvIHRoaXMgd291bGQgYmUgbW9k
aWZ5aW5nIHRoZSBleGlzdGluZyBzeXNmcyBlbnRyaWVzIHNvIHRoYXQgcmVhZHMNCj4gPiBzdGls
bCBjb21lIGZyb20gdGhlIGRldmljZSBhbmQgdW5pdCBkZXNjcmlwdG9ycywgYnV0IHdyaXRlcyBn
byB0bw0KPiA+IGVxdWl2YWxlbnQgZmllbGRzIGluIHRoZSBjb25maWcgZGVzY3JpcHRvcj8gSSBj
YW4gZXhwbG9yZSB0aGF0DQo+ID4gYXBwcm9hY2guIEFsdGVybmF0aXZlbHksIGlmIHRoZSB1bml0
IHNlbGVjdG9yIG1lY2hhbmlzbSBpcyBub3QNCj4gPiBkZXNpcmVkLCBJIGNvdWxkIGR5bmFtaWNh
bGx5IGNyZWF0ZSBzeXNmcyBkaXJlY3RvcmllcyBmb3IgZWFjaCB1bml0IGluDQo+ID4gdGhlIGNv
bmZpZyBkZXNjcmlwdG9yLCBidXQgc3RpbGwgYnJpbmcgb3V0IHRoZSBjb25maWcgZGVzY3JpcHRv
cg0KPiA+IHZhbHVlcyBhcyBzZXBhcmF0ZSBlbnRyaWVzLiAoSSBzdGlsbCB3b3JyeSBhIGJpdCBh
Ym91dCBzbWFzaGluZyB0aGUNCj4gPiBkZXNjcmlwdG9ycyB0b2dldGhlciBhcyB0aGUgVUZTIHNw
ZWMgY2FsbGVkIHRoZW0gb3V0IGFzIGRpZmZlcmVudCkuDQo+IA0KPiBJZiB5b3UgdXNlIHRoZSB1
bml0IGF0dHJpYnV0ZXMsIGhvdyBkbyB5b3UgY29uZmlndXJlIHVuaXRzIHRoYXQgZG8gbm90IHll
dA0KPiBleGlzdD8NCg0KRm9yIGV4YW1wbGUgYnkgYWRkaW5nIHRoZSBlbmFibGVfbHVuIHdyaXRl
YWJsZSBzeXNmcyBlbnRyeS4gSSB0aGluayBib3RoIHdheXMgYXJlDQp2aWFibGUgYW5kIHRoZXJl
IGFyZSBzZXZlcmFsIHBpdGZhbGxzIGluIGVhY2ggb2YgdGhlbS4gTm93IGl0J3MgdXAgdG8gRXZh
biB0byBkZWNpZGUNCmhvdyB0byBpbXBsZW1lbnQgdGhpcy4NCg0KPiANCj4gUGVyaGFwcyBpdCBp
cyBiZXR0ZXIgdG8gcmVwcmVzZW50IHRoZSBjb25maWd1cmF0aW9uIGRlc2NyaXB0b3JzIGV4YWN0
bHkgYXMNCj4gdGhleSBhcmUgZGVmaW5lZCBpbiB0aGUgc3BlY2lmaWNhdGlvbi4gIFByb2JhYmx5
IG5vdCB3b3J0aCBleHBvc2luZyB0aGVtIGF0DQo+IGFsbCBpZiB0aGUgY29uZmlndXJhdGlvbiBp
cyBsb2NrZWQgKGF0dHJpYnV0ZSBiQ29uZmlnRGVzY3JMb2NrID09IDEpLg0KPiANCj4gTm90ZSBh
bHNvIHRoYXQgdGhlIDIuMSBzcGVjLiBkZWZpbmVzICBiQ29uZkRlc2NDb250aW51ZSB3aGljaCBh
bGxvd3MgdXBkYXRlcw0KPiB0byBiZSBncm91cGVkIGFuZCBjb21taXR0ZWQgdG9nZXRoZXIuDQoN
ClRoZSBvbmx5IHF1ZXN0aW9uIGlzIGhvdyBtYW55IGRldmljZXMgYXJlIHJlYWR5IHRvIGdldCBk
b3plbnMgb2YgY29uZmlndXJhdGlvbg0KZGVzY3JpcHRvcnMgcmVsYXRlZCB0byBmaXJzdCBlaWdo
dCBMVU5zIGluc3RlYWQganVzdCBvbmUgd2hlbiB0aGlzIGxvY2sgaXMgZW5hYmxlZC4NCg0KUmVn
YXJkcw0KU3RhbmlzbGF2DQo=
