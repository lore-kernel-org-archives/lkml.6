Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B98BC282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E82218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YtVbn7tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfA3FEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:04:20 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:49785 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfA3FEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:04:20 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5130510000>; Wed, 30 Jan 2019 13:04:17 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 21:04:16 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 29 Jan 2019 21:04:16 -0800
Received: from DRBGMAIL104.nvidia.com (10.18.16.23) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 05:04:15 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by DRBGMAIL104.nvidia.com
 (10.18.16.23) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 05:04:13 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 30 Jan 2019 05:04:13 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2807.namprd12.prod.outlook.com (20.177.126.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 05:04:11 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 05:04:11 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuCjcFQq4Ugnr9EajTUu9v/+Er6XHCbsAgAACEcCAABenIIAAEeJAgAAI0YCAAABlQA==
Date:   Wed, 30 Jan 2019 05:04:10 +0000
Message-ID: <BYAPR12MB33989F7D98AF19F84BA216D7C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
        <1548803771-13424-3-git-send-email-skomatineni@nvidia.com>
        <20190130044214.65991195@dimatab>
        <BYAPR12MB339850895826781B4E6AF028C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
        <BYAPR12MB339812A2E876B76E95828EA1C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
        <BYAPR12MB3398502D8F00D4F7BFF25D27C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190130074951.154cf037@dimatab>
In-Reply-To: <20190130074951.154cf037@dimatab>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2807;6:9VW/Qrs9ZHMHh34aaTmgvz9GEPjLbfPfij+oD+r/vl3NYj5ZSwOgde5Uw2042zizBMlMvla2ktQTQE+mOiedHZmp/jY049wEoNR6z3tzaAZxTPo3wcUqotBJGrOkV33omCHHmgeRukJrkoiBBddCjSrwajqb92DilwWXaDVqzpyTJALuCcKfhWSv1kxMbbRcwPePdgAv5s53DZxEZEnNEZZHXTKHUo9sMtuo6DM/knqGC6kHWZiG5j4rKW4lw2ZSabjAuUWZutR0WGMCQijoefAp9cx/32Oxe3NtJ8GJvUMwdUYPA5cXi2pRmgXdGM+W/zblpWtUelgb9LaN4i6MQa9o3tz29YLJ1Ex6zVGPWVYnfdb51ZiPDzVr71OFMP2r2PPB8xycRKKxE4epQVNSjLF186fJTTeGvp8F4ZOK+0NQdTKjBNCofWEj+Z3JsJlRhEc45LYo3nHj/+GOdm6SuA==;5:qddy/Sjnn2j9JiULdq98zV0bVigKZ8FWONS8mzBMGTVPINLghvD/9hx7h/VmPtlCGiCTebVhp0iq508+rN0HKC15mdy2tCh9tZCiS7cvHHedSJPO8kRe2LnTMaDs2Zh7b45XWoMEpT4KTmDNl3G/2U0l1N1agHVSQrJ7HqZtzZvRDvsIMjWSMpdpoHXYR8oGEWSrzM/RHapOjBMdX80/4Q==;7:yg9JSUN00MDlzPQ9wbcq0D3AcXOy2zB0Pm++LCCDbpxi+lzaSN0nrk1nD08P2yj4yJsv5H4qzmzKPtps91peK/U2z/rJuKmYylmt0uIWeFhcwvpGvgCPVdoFJN7hinWiq9rvjNX5yxJVInwnhc6PRQ==
x-ms-office365-filtering-correlation-id: 42162115-0ed7-45a9-dedb-08d686705f2d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2807;
x-ms-traffictypediagnostic: BYAPR12MB2807:
x-microsoft-antispam-prvs: <BYAPR12MB2807B885B802C84C90FEF0B5C2900@BYAPR12MB2807.namprd12.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(51914003)(189003)(25584004)(199004)(14444005)(53936002)(6506007)(105586002)(6436002)(81166006)(81156014)(6116002)(2906002)(66066001)(478600001)(39060400002)(97736004)(8936002)(316002)(76176011)(86362001)(256004)(8676002)(106356001)(102836004)(99286004)(55016002)(486006)(186003)(54906003)(229853002)(6916009)(93886005)(305945005)(68736007)(446003)(4326008)(26005)(476003)(11346002)(966005)(6306002)(71190400001)(25786009)(7736002)(14454004)(7696005)(74316002)(33656002)(3846002)(1411001)(9686003)(71200400001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2807;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: clveyqE90iD+8tBPJGmvXlfDeI63j1o5/lWsZir1KDGjeejUPZXu/BRXCg912nFBNSSX9i6qJaSw6LHPq7UZU62yuWYrEgFIRaKSc/CxM9LOqlNRGQVeBD9vjKItg92RKgucwd6COJzKZX6FkQnL5S4AzhjIvkn03dw96aMGYX0w2s0UAs4V47LeAkCVZxvVjQA9Rozaqviup1RpU/zyjJJ0n2/7YvhavH91BwxelDS4Lx4UkNShuI1tbnrR8paMoKe5qOuk0vPqBSCG6qQ+fu07LURslGIIp5msrUMe9u/RTV9yhTV4oVbTQAATsFaqlGK1vGYrHDzBu5Zy7c4j4H4jiVbOENL6fzemgLOcdG7c1JvER9yE6pg/hXvsC85803K0jPbovzFdPwn2jnCFzabhrrut+SyfCNuP1Nkw2FA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42162115-0ed7-45a9-dedb-08d686705f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 05:04:10.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2807
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548824657; bh=l2Bd76Vew6drCZKLe8iG+Lrdvycx7+vntZ39PnlXtOc=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=YtVbn7tSDGxLF1Wu3zPnU1ZBbBz80CnY/FC9dSaWjH9gIFoDlg6mzff8Lm/xc3mcS
         PbA97hMVPjLOSqtiC+sGzTwOVPTBuiWbM44mdCWE7NOEFKSmLeHuzR0Yuj1awC8f00
         kDOml5LKxripQ+/XzSktj0FtqmFtIOSUhcqHLB6Ww9y6pVJKI2IBXMs3FR7tO9Mh0Y
         SRRNIDWnpPycM0zeIZ7t4ISDhGETuGOsmp5GSqBkRtiRmnns+WHQN7EUv0g4G8aTAh
         AhDLPI2MgHlvv/yErS27TyEQ/FwV/i4psEyjgtyJHqPduqQq6Cqu6/xNJxTcjS1Sv2
         J0y8cCCOWbAoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFtDb3JyZWN0aW9uXQ0KPiA+IA0KPiA+ID4gPiBDb3VsZCB5b3UgcGxlYXNlIHRlbGwgd2hl
dGhlciB5b3UgbWlzc2VkIG15IGNvbW1lbnRzIHRvIFYzIFswXSBvciANCj4gPiA+ID4gY2hvc2Ug
dG8gaWdub3JlIHRoZW0/IElmIHRoZSBmb3JtZXIsIHRoZW4gSSdkIHdhbnQgdG8gZ2V0IGFuc3dl
cnMgDQo+ID4gPiA+IHRvIHRob3NlIHF1ZXN0aW9ucyBhbmQgY29tbWVudHMuIEknbGwgc3RvcCBo
ZXJlIGZvciBub3cuDQo+ID4gPiA+IA0KPiA+ID4gPiBbMF0gaHR0cHM6Ly9wYXRjaHdvcmsub3ps
YWJzLm9yZy9wYXRjaC8xMDMxMzc5Lw0KPiA+ID4NCj4gPiA+IFNvbWVob3cgbWlzc2VkIHRob3Nl
IGZyb20gbXVsdGlwbGUgY29tbWVudHMuIFdpbGwgZ28gdGhydSBhbmQgDQo+ID4gPiByZXNwb25k
IGJhY2suDQo+ID4gDQo+ID4gVjYgaW5jbHVkZXMgZmVlZGJhY2sgY2hhbmdlcy4gV2FudCB0byBj
bGFyaWZ5IG9uIGZldyBmZWVkYmFjayBwb2ludHMNCj4gPiANCj4gPiAtIEFMSUdOIGlzIHVzZWQg
Zm9yIDQgYnl0ZSBib3VuZGFyeSB0byB1c2Ugd2l0aCBETUEgYnV0IGV4dHJhIGJ5dGVzIA0KPiA+
IGRvZXNu4oCZdCBnZXQgdHJhbnNmZXJyZWQgb3ZlciBJMkMgYXMgSTJDIGNvbnRyb2xsZXIgdHJh
bnNmZXIgYnl0ZXMgDQo+ID4gYmFzZWQgb24gc2l6ZSBzcGVjaWZpZWQgaW4gdGhlIHBhY2tldCBo
ZWFkZXIuIERNQSBsZW5ndGggYW5kIG1lbW9yeSANCj4gPiBhZGRyZXNzIG5lZWQgdG8gYmUgNCBi
eXRlIGJvdW5kYXJ5Lg0KPg0KPiBPa2F5LCBJIHNlZSBub3cuIFRoYW5rcy4NCj4NCj4gPiAtIFJY
IGNoYW5uZWwgcmVsZWFzaW5nIHdoZW4gVFggaW5pdCBmYWlscz8NCj4gPiAgIEZvciBJMkMgYm90
aCBUWCBhbmQgUlggZG9lc27igJl0IGhhcHBlbiBpbiBzYW1lIHRyYW5zYWN0aW9uIGFuZCBubyAN
Cj4gPiBkZXBlbmRlbmN5LiBTbyBpZiBSWCBjaGFubmVsIHJlcXVlc3QgJiBidWZmZXIgYWxsb2Nh
dGlvbiBzdWNjZWVkcyBidXQgDQo+ID4gVFggY2hhbm5lbCByZXF1ZXN0IGZhaWxzLCB0aGVuIFJY
IERNQSBjYW4gc3RpbGwgYmUgdXNlZCBmb3IgTXNnIHJlYWRzIA0KPiA+IGFuZCB0cmFuc21pdHMg
Y2FuIGhhcHBlbiBvbiBQSU8gbW9kZQ0KPg0KPiBUaGF0J3Mgbm90IHdoYXQgbXkgcG9pbnQgaXMg
YWJvdXQuIEluIGEgY2FzZSBvZiBUWCBpbml0aW5nIGZhaWx1cmUsIHRoZSBSWCBjaGFubmVsIGFu
ZCBETUEgYnVmZmVyIGFyZSBub3QgZ2V0dGluZyByZWxlYXNlZCBpbiB0aGUgcHJvYmUgZnVuY3Rp
b24uIFBsZWFzZSBiZSBtb3JlIGNhcmVmdWwgYWJvdXQgbWFuYWdpbmcgYWxsb2NhdGVkIHJlc291
cmNlcy4NCg0KT0ssIHRoaXMgY29tbWVudCBmcm9tIHlvdSB3YXMgZm9yIFYzLiBJbiBWNSBvciBW
NiwgSSBjaGFuZ2VkIGluaXQgYW5kIGFsbG9jYXRpb24gdG8gaGFwcGVuIG9ubHkgd2hlbiBETUEg
aXMgbmVlZGVkLiBTbyBteSByZXNwb25zZSBoZXJlIHdhcyByZWZlcnJpbmcgdG8gbGF0ZXN0IGNo
YW5nZXMuIA0KSSBzaG91bGQgbm90IGhhdmUgbWVudGlvbmVkIHRoaXMgY29tbWVudCBoZXJlIGFz
IGl0cyBhbHJlYWR5IGFkZHJlc3MgaW4gdGhlIGxhdGVzdCBjaGFuZ2VzLg0KSW4gbGF0ZXN0IGNo
YW5nZXMsIERNQSBDaGFubmVsIHJlcXVlc3QgYW5kIGFsbG9jYXRpb24gaGFwcGVucyBvbmx5IHdo
ZW4gRE1BIGlzIG5lZWRlZCBhbmQgSWYgY2hhbm5lbCArIGJ1ZiBpcyBub3QgYWxyZWFkeSBhbGxv
Y2F0ZWQuDQpEdXJpbmcgUlggZG1hIGluaXQsIGJ1ZmZlciBpcyBhbGxvY2F0ZWQgb25seSBvbiBz
dWNjZXNzZnVsIFJYIGNoYW5uZWwgcmVxdWVzdC4gSWYgYnVmIGFsbG9jYXRpb24gZmFpbHMsIHRo
ZW4gUlggY2hhbm5lbCBpcyByZWxlYXNlZC4NCkR1cmluZyBUWCBkbWEgaW5pdCwgYnVmIGlzIGFs
bG9jYXRlZCBvbmx5IGlmIGl0cyBub3QgYWxyZWFkeSBhbGxvY2F0ZWQgZHVyaW5nIFJYIEluaXQg
YW5kIGluY2FzZSBvZiBhbGxvY2F0aW9uIGZhaWx1cmUgaXQgcmVsZWFzZXMgVFggY2hhbm5lbC4N
CkJ1dCBpZiBUWCBjaGFubmVsIHJlcXVlc3QgZmFpbHMgYnV0IGRtYSBidWZmZXIgYWxsb2NhdGlv
biB3aXRoIHJ4IGNoYW5uZWwgZHVyaW5nIFJYIERNQSBpbml0IGlzIHN1Y2Nlc3NmdWwgaXQgd2ls
bCB1c2UgUlggRE1BIGZvciBpMmMgcmVhZHMgYW5kIHVzZXMgUElPIGZvciBpMmMgd3JpdGVzIA0K
DQo+ID4gLSBkbWFfYnVyc3QgPCA4IG5lZ2F0aXZlbHkgYWZmZWN0cyB0cmFuc2ZlciBlZmZpY2ll
bmN5PyBQZXJmb3JtYW5jZSANCj4gPiBzdGF0cyBmb3IgRE1BIFZzIFBJTyBtb2RlLiBUZXN0ZWQg
d2l0aCAyNTYgYnl0ZXMgb2YgdHJhbnNmZXIgYW5kIERNQSANCj4gPiBWcyBQSU8gbW9kZSB0cmFu
c2ZlciByYXRlIGlzIGFsbW9zdCBzYW1lLiBCdXQgdGhlIG1haW4gcmVhc29uIGZvciANCj4gPiBh
ZGRpbmcgRE1BIG1vZGUgaXMgdG8gYWRkcmVzcyBjb3VwbGUgb2YgY2FzZXMgbWVudGlvbmVkIGVh
cmxpZXIgYW5kIA0KPiA+IG5vdCBtYWlubHkgZnJvbSB0aGUgdHJhbnNmZXIgcGVyZm9ybWFuY2Ug
cGVyc3BlY3RpdmUuDQo+DQo+IENvdWxkIHlvdSBwbGVhc2UgYWRkIGEgY2xhcmlmeWluZyBjb21t
ZW50IHRvIHRoZSBjb2RlLCBzYXlpbmcgdGhhdCB0aGUgd2hvbGUgcHVycG9zZSBvZiB0aGUgRE1B
IHRyYW5zZmVyIGlzIHNvbGVseSB0byBhdm9pZCBkZWxheWluZyBvZiB0aGUgdHJhbnNhY3Rpb25z
Pw0KDQpUaG91Z2h0IHRoYXTigJlzIHRvbyBtdWNoIGluZm8gdG8gYWRkIGFzIGNvbW1lbnRzIHRv
IGNvZGUsIGJ1dCBhZGRlZCBpbiBjb21taXQgbWVzc2FnZS4NCg0KPiBUaGFua3MgZm9yIHRoZSBy
ZXBsaWVzISBJJ2xsIHRha2UgYSBsb29rIGF0IFY2IGxhdGVyIHRvZGF5Lg0KDQo=
