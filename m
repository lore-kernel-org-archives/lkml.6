Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97256ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4564F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RDB0vfGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4564F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbeGQPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:30:35 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:60623 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731595AbeGQPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:30:35 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 17 Jul 2018 23:57:30 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 89E9286185;
        Tue, 17 Jul 2018 23:57:30 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,365,1526310000"; 
   d="scan'208";a="287118110"
Received: from mail-os2jpn01lp0150.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.150])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2018 23:57:30 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k21svS4wWydFBUdtfiCgusAZjVTs8rcialZXKgbnWMI=;
 b=RDB0vfGoRmRviRwvRWVB1neHV6PwDbpBHc/B9tyS6x0h1jbgNRVb1xMEzeyYzNVRW+Zc8eNV4yyljV19CbH6i6AGEBTh8EWpgEGpN6jOqt7+PznhxSdCJN93SaQ1WXtcubMGEnte31jgqagPUhSscs7BHEkhCS2n0DEndrU6GZQ=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0889.jpnprd01.prod.outlook.com (10.167.156.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 17 Jul 2018 14:57:27 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333%2]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 14:57:27 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Horman <horms@verge.net.au>
CC:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Topic: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Index: AQHUHONXv++x9VJe70Gk9EuuSmoVI6STU7qAgAAEdoCAAAK7oIAAHWMAgAAEvbCAAANNgIAAATtQ
Date:   Tue, 17 Jul 2018 14:57:27 +0000
Message-ID: <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
         <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
         <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
         <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
In-Reply-To: <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0889;20:KHD7zvDgfaZb4Un+pYB+KggDXrd3MIDpWdEoxi/V03XU2M3/W6MwnfCFtw9wgldQOsFyk1wYGZdCFFu85uv4lWOBrbqXXdUjsVZKl32Ogj5MKcLX+cZWTBT6TddYK1G6DT+wc475C9aRE6anYfKCZTIOcvnswmGytxWEUATf3PY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cafb13da-adc9-4813-d68c-08d5ebf59d31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0889;
x-ms-traffictypediagnostic: TY1PR01MB0889:
x-microsoft-antispam-prvs: <TY1PR01MB0889140E69888528D8274AB3F55C0@TY1PR01MB0889.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0889;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0889;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(25786009)(105586002)(11346002)(2900100001)(106356001)(3846002)(6116002)(8936002)(486006)(53936002)(6246003)(316002)(97736004)(110136005)(476003)(33656002)(5250100002)(44832011)(4326008)(54906003)(99286004)(81156014)(81166006)(6506007)(102836004)(8676002)(93886005)(66066001)(53546011)(186003)(5660300001)(68736007)(86362001)(14454004)(26005)(74316002)(2906002)(229853002)(305945005)(6436002)(7696005)(76176011)(7736002)(9686003)(446003)(478600001)(55016002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0889;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zD9pH3HSewtB9LAznMZxdJK8qmCztQ916I7MxJskrihAwmhj9MYTVkgIdC01h4yFK3CysGg2hTaUM9fcmZ0VHMFL+xdBtJDM7usfmRWX7KfUbuD6LEKGlqwB7RSeAdTDwp9C9yaQhwOGWI3NZQEqGPdDOyj2nLqhHps5erVHVqzw5Qob8MhmQCLkdxpDMWSJS1deCE8eqYwAKum6d3YEPqrrXImkLVyjPJmqsuRVWBWLbQmeljVbYmQus3KFrk0WuBpo+ZaeZAvYybpYbBaHjJtSWrizTdxJrwS2jC9CR0aBx1x0j2vCl9LGkFicV1jkSXJhv+/5pE4UsohRvQlwXzmFX3Fl8+3FD1hstV1l7yQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafb13da-adc9-4813-d68c-08d5ebf59d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 14:57:27.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0889
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KT24gMTcgSnVseSAyMDE4IDE1OjQ3LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIFR1ZSwgMjAxOC0wNy0xNyBhdCAxNDo0MCArMDAwMCwgUGhpbCBFZHdvcnRoeSB3cm90
ZToNCj4gPiBPbiAxNyBKdWx5IDIwMTggMTU6MTksIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4g
PiA+IE9uIFR1ZSwgMjAxOC0wNy0xNyBhdCAxMjo0MiArMDAwMCwgUGhpbCBFZHdvcnRoeSB3cm90
ZToNCj4gPiA+DQo+ID4gPiA+ID4gV2hpbGUgeW91ciBwb2ludCBzb3VuZHMgdmFsaWQgKGRvbid0
IHJlbWVtYmVyIGhvdyBjbGtfZ2V0KCkgaXMNCj4gPiA+ID4gPiBpbXBsZW1lbnRlZCksIE5VTEwg
aXMgYWxzbyBPSyB0byBoYXZlLg0KPiA+ID4gPg0KPiA+ID4gPiBPayBhcyBpbiB0aGVyZSBpcyBu
byBidXMgY2xvY2ssIHJpZ2h0Pw0KPiA+ID4gPiBTbyBpdCBzaG91bGQgYmU6DQo+ID4gPiA+ICBp
ZiAoIUlTX0VSUl9PUl9OVUxMIChkZXYtPmJ1c2NsaykpDQo+ID4gPg0KPiA+ID4gTm9wZSwgTlVM
TCBpcyBubyBlcnJvciBjYXNlIGZvciBvcHRpb25hbCBjbG9jay4NCj4gPg0KPiA+IEkgbXVzdCBi
ZSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlLi4uDQo+IA0KPiBTZWUgaG93IGNsa19wcmVwYXJlX2Vu
YWJsZSgpIGlzIGltcGxlbWVudGVkLg0KT2ssIGlmIGJ1c2NsayBpcyBOVUxMIHRoZSBjb2RlIGNh
biBzYWZlbHkgY2FsbCBjbGtfcHJlcGFyZV9lbmFibGUoKQ0KDQoNCj4gPiBJIGFncmVlIHRoYXQg
TlVMTCBmb3IgYW4gb3B0aW9uYWwgY2xvY2sgaXMgbm90IGFuIGVycm9yLiBIb3dldmVyLCB0aGUN
Cj4gPiBjb2RlIGFib3ZlIGlzIG5vdzoNCj4gPiArCWlmIChwcmVwYXJlKSB7DQo+ID4gKwkJLyog
T3B0aW9uYWwgYnVzIGNsb2NrICovDQo+IA0KPiA+ICsJCWlmICghSVNfRVJSX09SX05VTEwoZGV2
LT5idXNjbGspKSB7DQo+IA0KPiBDaGVjayBmb3IgTlVMTCBpcyByZWR1bmRhbnQuDQo+IA0KPiA+
ICsJCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZGV2LT5idXNjbGspOw0KPiA+ICsJCQlpZiAo
cmV0KQ0KPiA+ICsJCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICAJCXJldHVy
biBjbGtfcHJlcGFyZV9lbmFibGUoZGV2LT5jbGspOw0KPiA+ICsJfQ0KPiA+DQo+ID4gU28sIGlm
IHlvdSBoYXZlIGEgdmFsaWQgYnVzY2xrLCBpdCBnZXRzIGVuYWJsZWQsIG90aGVyd2lzZSBpdCBp
cyBsZWZ0DQo+ID4gYWxvbmUuDQo+IA0KU28gdGhlIGNvZGUgYXMgc2VudCBpbiB0aGUgb3JpZ2lu
YWwgZW1haWwgaXMgY29ycmVjdCAoYXNpZGUgZnJvbSBHZWVydCdzDQpjb21tZW50cyBhYm91dCBF
UFJPQkVfREVGRVIgaGFuZGxpbmcpLg0KDQpNYXliZSBJIG5lZWQgc29tZSBjb2ZmZWUgOlwNClRo
YW5rcw0KUGhpbA0K
