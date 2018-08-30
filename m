Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392C92054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392C92054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=live.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeH3G3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:29:49 -0400
Received: from mail-oln040092254051.outbound.protection.outlook.com ([40.92.254.51]:36167
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbeH3G3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:29:49 -0400
Received: from HK2APC01FT006.eop-APC01.prod.protection.outlook.com
 (10.152.248.54) by HK2APC01HT043.eop-APC01.prod.protection.outlook.com
 (10.152.248.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.1101.10; Thu, 30
 Aug 2018 02:29:41 +0000
Received: from HK0PR06MB2561.apcprd06.prod.outlook.com (10.152.248.59) by
 HK2APC01FT006.mail.protection.outlook.com (10.152.248.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1101.10 via Frontend Transport; Thu, 30 Aug 2018 02:29:41 +0000
Received: from HK0PR06MB2561.apcprd06.prod.outlook.com
 ([fe80::5902:da9:e907:fe7d]) by HK0PR06MB2561.apcprd06.prod.outlook.com
 ([fe80::5902:da9:e907:fe7d%5]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 02:29:41 +0000
From:   Changwei Ge <gechangwei@live.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Larry Chen <lchen@suse.com>
CC:     "mfasheh@suse.com" <mfasheh@suse.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ocfs2-devel] [PATCH] fix crash on
 ocfs2_duplicate_clusters_by_page
Thread-Topic: [Ocfs2-devel] [PATCH] fix crash on
 ocfs2_duplicate_clusters_by_page
Thread-Index: AQHUQAlOwwG9sNWzOEK6uP60LXl+0w==
Date:   Thu, 30 Aug 2018 02:29:41 +0000
Message-ID: <HK0PR06MB256142B68441A3513747DCFAD5080@HK0PR06MB2561.apcprd06.prod.outlook.com>
References: <20180829074740.9438-1-lchen@suse.com>
 <20180829152533.431fd4972ae046943cabc2e3@linux-foundation.org>
In-Reply-To: <20180829152533.431fd4972ae046943cabc2e3@linux-foundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PU1PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::15) To HK0PR06MB2561.apcprd06.prod.outlook.com
 (2603:1096:203:6f::10)
x-incomingtopheadermarker: OriginalChecksum:059CD5475CBAFBCF75834D3621DD69C1D1012EEBF0A23B3DC29F1CB23C9D45AC;UpperCasedChecksum:B98AFF15B5FBF2D60CF85369A60294C4358FFF4F930F83E54199BF00133534BA;SizeAsReceived:7714;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [sWuFSDp6tsDWpM1y44BAbL7gUGMGFtSALlrtxwWCl9Y=]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2APC01HT043;6:2VjDHDTR7xrxAKng/JFRW/r32LAid6ZuEuv6BVPYFz1bGGlqSWi44B3WTfCiwISEP/qMo6ZgaIpTyZJLy7flbF4rbepcW8rnbvZn9zh7ezSNAyLTvxqx9/a5BQxtLgmLBr2jwq3Ogq7CdeDcuv5X9t1Q+MxoHOIeylOmRsSLUcq4kMjTECkpLrNsTbu22HChmtpeDWrPsxalou3NUpmmNL5yqirBxnl3e/VWO9j1zZW2ypL3ImWM1kwCWFkpg4RD21JsM9jcJTiP6Ph9HrvmBgfhF+2VwvXjhijhGCkmzX3Jt9sIEWozLEsAcw70Wgpc/4l1FzyzCE5RcpssJ2981xscbDd4cF+DxoTx81u9kz3ZGuq2IO69FIExvtzRHVxOToIAclY8EJV4VGOPIMU476mjT26sQDs0t50xF8ax9jXMlq34XXwjUuaJIkCU4sfi8Izcb/BvZnRxodhSNkmiWg==;5:UC6VP5GlQEyxs0k/n+JvVdYbcy4c4anQsfYi9ABsjvoOZyGVnG9zjfYIkGQeIAQpDT4Izw9HSYJafv9TDkeZ1R5ret8g4B7NFpmSYOBUXsgDux6r+0Hu0cwgWyttbJC50FiUJr4eG4hymRVTJUX93mTpfBNnq5tZ4x0CpLg2e9E=;7:iGPvhRkcLdbSJiTB/jIw4Q+l9exVb0ipWvKAKDKsyZIDF4k67OOXcZGErqKdUWjhTtUnHt07TacWGTps8IB1SH8tI+lW5hacHokiF2fBrZzxVvLTswt8vQdVGWZF78H6uKQtD1Wwffu7ax+TBpo3ZSx7NkYHNYDqmsgChzpVPWwLWBPrjySaUvN+xHjhPuMUJH8UVntxHdo2KYiTLi1SVyE/zXzH3+ie3yMOfkzxox+59+IuGVmbh/jNVlDuACQY
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:HK2APC01HT043;
x-ms-traffictypediagnostic: HK2APC01HT043:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:HK2APC01HT043;BCL:0;PCL:0;RULEID:;SRVR:HK2APC01HT043;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(86362001)(8936002)(68736007)(25786009)(2900100001)(4326008)(6246003)(14444005)(110136005)(7696005)(15760500003)(54906003)(99286004)(76176011)(14454004)(966005)(6436002)(104016004)(9686003)(81156014)(6306002)(55016002)(229853002)(105586002)(81612004)(256004)(56003)(74482002)(5250100002)(97736004)(106356001)(33656002)(26005)(6346003)(8676002)(476003)(11346002)(446003)(486006)(82202002)(5660300001)(305945005)(53546011)(386003)(74316002)(6506007)(102836004);DIR:OUT;SFP:1901;SCL:1;SRVR:HK2APC01HT043;H:HK0PR06MB2561.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: live.cn does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gechangwei@live.cn; 
x-microsoft-antispam-message-info: BSsx7SYVbtpSqF36XBD7vqjMwKW/orpTFhhiyJ1FtbCxHqHwgbHT/BFupKT36g919DNV2sEYJ+qvjbHeN2NPXb1F2kezX6wSrm1vo7osl+0h5EozJhTp2MmSfdPKbFDlddY1UVKkK8YQI3OOSBQ2fwUmcvvA+j+whenOeyf6o5ulLZt9u/DzT7IEBfI3goxBoReWSUT1KtPuTD1L0mwsKm36KWBHHEJN+R9C3VEmIWU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0AA1418A9BB804F8A45A281B7FA0B75@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c57982-3e25-4a2e-0947-08d60e207064
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 02:29:41.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGFycnksDQoNCkJlc2lkZXMgQW5kcmV3J3MgY29tbWVudHMsIG90aGVyIHBhcnRzIG9mIHRo
aXMgcGF0Y2ggbG9vayBnb29kIHRvIG1lLg0KDQpUaGFua3MsDQoNCkNoYW5nd2VpDQoNCg0KT24g
MjAxOC84LzMwIDY6MjUsIEFuZHJldyBNb3J0b24gd3JvdGU6DQo+IE9uIFdlZCwgMjkgQXVnIDIw
MTggMTU6NDc6NDAgKzA4MDAgTGFycnkgQ2hlbiA8bGNoZW5Ac3VzZS5jb20+IHdyb3RlOg0KPg0K
Pj4gb2NmczJfZHVwbGljYXRlX2NsdXN0ZXJzX2J5X3BhZ2UgbWF5IGNyYXNoIGlmIG9uZSBvZiBl
eHRlbnQncyBwYWdlcyBpcyBkaXJ0eS4NCj4+IFdoZW4gYSBwYWdlIGhhcyBub3QgYmVlbiB3cml0
dGVuIGJhY2ssIGl0IGlzIHN0aWxsIGluIGRpcnR5IHN0YXRlLiBJZg0KPj4gb2NmczJfZHVwbGlj
YXRlX2NsdXN0ZXJzX2J5X3BhZ2UgaXMgY2FsbGVkIGFnYWluc3QgdGhlDQo+PiBkaXJ0eSBwYWdl
LCB0aGUgY3Jhc2ggaGFwcGVucy4NCj4+DQo+PiBUbyBmaXggdGhpcyBidWcsIHdlIGNhbiBqdXN0
IHVubG9jayB0aGUgcGFnZSBhbmQgd2FpdCB0aGUgcGFnZSB1bnRpbA0KPj4gaXQncyBub3QgZGly
dHkuDQo+Pg0KPj4gVGhlIGZvbGxvd2luZyBpcyB0aGUgYnVjayB0cmFjZSBkdW1wOg0KPj4NCj4+
IGtlcm5lbCBCVUcgYXQgL3Jvb3QvY29kZS9vY2ZzMi9yZWZjb3VudHRyZWUuYzoyOTYxIQ0KPj4g
W2V4Y2VwdGlvbiBSSVA6IG9jZnMyX2R1cGxpY2F0ZV9jbHVzdGVyc19ieV9wYWdlKzgyMl0NCj4+
IF9fb2NmczJfbW92ZV9leHRlbnQrMHg4MC8weDQ1MCBbb2NmczJdDQo+PiA/IF9fb2NmczJfY2xh
aW1fY2x1c3RlcnMrMHgxMzAvMHgyNTAgW29jZnMyXQ0KPj4gb2NmczJfZGVmcmFnX2V4dGVudCsw
eDViOC8weDVlMCBbb2NmczJdDQo+PiBfX29jZnMyX21vdmVfZXh0ZW50c19yYW5nZSsweDJhNC8w
eDQ3MCBbb2NmczJdDQo+PiBvY2ZzMl9tb3ZlX2V4dGVudHMrMHgxODAvMHgzYjAgW29jZnMyXQ0K
Pj4gPyBvY2ZzMl93YWl0X2Zvcl9yZWNvdmVyeSsweDEzLzB4NzAgW29jZnMyXQ0KPj4gb2NmczJf
aW9jdGxfbW92ZV9leHRlbnRzKzB4MTMzLzB4MmQwIFtvY2ZzMl0NCj4+IG9jZnMyX2lvY3RsKzB4
MjUzLzB4NjQwIFtvY2ZzMl0NCj4+IGRvX3Zmc19pb2N0bCsweDkwLzB4NWYwDQo+PiBTeVNfaW9j
dGwrMHg3NC8weDgwDQo+PiBkb19zeXNjYWxsXzY0KzB4NzQvMHgxNDANCj4+IGVudHJ5X1NZU0NB
TExfNjRfYWZ0ZXJfaHdmcmFtZSsweDNkLzB4YTINCj4+DQo+PiAtLS0gYS9mcy9vY2ZzMi9yZWZj
b3VudHRyZWUuYw0KPj4gKysrIGIvZnMvb2NmczIvcmVmY291bnR0cmVlLmMNCj4+IEBAIC0yOTQ2
LDYgKzI5NDYsNyBAQCBpbnQgb2NmczJfZHVwbGljYXRlX2NsdXN0ZXJzX2J5X3BhZ2UoaGFuZGxl
X3QgKmhhbmRsZSwNCj4+ICAgCQlpZiAobWFwX2VuZCAmIChQQUdFX1NJWkUgLSAxKSkNCj4+ICAg
CQkJdG8gPSBtYXBfZW5kICYgKFBBR0VfU0laRSAtIDEpOw0KPj4gICANCj4+ICtyZXRyeToNCj4+
ICAgCQlwYWdlID0gZmluZF9vcl9jcmVhdGVfcGFnZShtYXBwaW5nLCBwYWdlX2luZGV4LCBHRlBf
Tk9GUyk7DQo+PiAgIAkJaWYgKCFwYWdlKSB7DQo+PiAgIAkJCXJldCA9IC1FTk9NRU07DQo+PiBA
QCAtMjk1Nyw4ICsyOTU4LDE1IEBAIGludCBvY2ZzMl9kdXBsaWNhdGVfY2x1c3RlcnNfYnlfcGFn
ZShoYW5kbGVfdCAqaGFuZGxlLA0KPj4gICAJCSAqIEluIGNhc2UgUEFHRV9TSVpFIDw9IENMVVNU
RVJfU0laRSwgVGhpcyBwYWdlDQo+PiAgIAkJICogY2FuJ3QgYmUgZGlydGllZCBiZWZvcmUgd2Ug
Q29XIGl0IG91dC4NCj4+ICAgCQkgKi8NCj4gTG9va3Mgc2FuZSwgYnV0IHRoZSBiZWxvdyBjaGFu
Z2Ugc2hvd3MgdGhhdCB0aGUgYWJvdmUgY29tbWVudCBpcw0KPiB1bnRydWUuICBDYW4gd2UgcGxl
YXNlIHVwZGF0ZSB0aGUgY29tbWVudCBhcyB3ZWxsPw0KPg0KPg0KPj4gLQkJaWYgKFBBR0VfU0la
RSA8PSBPQ0ZTMl9TQihzYiktPnNfY2x1c3RlcnNpemUpDQo+PiAtCQkJQlVHX09OKFBhZ2VEaXJ0
eShwYWdlKSk7DQo+PiArCQlpZiAoUEFHRV9TSVpFIDw9IE9DRlMyX1NCKHNiKS0+c19jbHVzdGVy
c2l6ZSkgew0KPj4gKwkJCWlmIChQYWdlRGlydHkocGFnZSkpIHsNCj4+ICsJCQkJLyoNCj4+ICsJ
CQkJICogd3JpdGVfb25fcGFnZSB3aWxsIHVubG9jayB0aGUgcGFnZSBvbiByZXR1cm4NCj4+ICsJ
CQkJICovDQo+PiArCQkJCXJldCA9IHdyaXRlX29uZV9wYWdlKHBhZ2UpOw0KPj4gKwkJCQlnb3Rv
IHJldHJ5Ow0KPj4gKwkJCX0NCj4+ICsJCX0NCj4+ICAgDQo+PiAgIAkJaWYgKCFQYWdlVXB0b2Rh
dGUocGFnZSkpIHsNCj4+ICAgCQkJcmV0ID0gYmxvY2tfcmVhZF9mdWxsX3BhZ2UocGFnZSwgb2Nm
czJfZ2V0X2Jsb2NrKTsNCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gT2NmczItZGV2ZWwgbWFpbGluZyBsaXN0DQo+IE9jZnMyLWRldmVsQG9z
cy5vcmFjbGUuY29tDQo+IGh0dHBzOi8vb3NzLm9yYWNsZS5jb20vbWFpbG1hbi9saXN0aW5mby9v
Y2ZzMi1kZXZlbA0KDQo=
