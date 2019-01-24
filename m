Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C60221855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OzyWbTW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAXGnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:43:00 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:35741
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfAXGm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcaN+QStbKU56G30QYsDCJCDtn147uo33iTNsG47n3o=;
 b=OzyWbTW7IkrsmPmMtLatyPVHypPL7hEVLjVs0AiOT0KiI8BSVITMatYYQuS8wSgP5nzyBwOfovoqLnoHgaB+nbnAGYIwP7WjL761ezhkcdr6EaHDkPrA20FCgiNAQaKb79XZYMq/LAsgfUN+UotAmTwQ/7sHKfsBNsoZGaRKbIQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0PR04MB4498.eurprd04.prod.outlook.com (52.135.148.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 24 Jan 2019 06:42:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903%3]) with mapi id 15.20.1537.031; Thu, 24 Jan 2019
 06:42:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
Subject: RE: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Topic: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Index: AQHUsUUJrf+HCksNJUevQFBecw2Jm6W7t2+AgAJF8qA=
Date:   Thu, 24 Jan 2019 06:42:52 +0000
Message-ID: <AM0PR04MB44818AC8A1FC7D706BCFE197889A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [114.217.246.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4498;6:Q5QcbeLwNYjcKxBTboMPTu1CIPbdpjcmwtKrrqxzr6M0qZa+wSHncwRCRymJl8K+R9YBx0StFLeqQkf/5VbTDCeAGo6a7m5SGhHVKilZYqSUY0SEyyGIl0p7rrLvaeGZP95g4iqSFn7V74qGo9Gunvw9SXSr/qH6Ktp4AymHw4eZUVH1dYmM9yGSuH3brsJBZnUHdVqusMI/E8GB1pie2pMHQgPyYYRxFfaTpR9ykXXRoQapa2OB3nVRXIIHsPWrJ4Z82k0VWAT7mQJNtomSBUpGX0SYevCFBt8JjQvijKHUqCWiCX5sGcYsRyAle4x1Tw5iKqxXqjKRP3uobEwrBILMk9fDaFo17vBE0PHZw6MtFX57mMdy/dr+CkMUxcDeTZguA9i1cnk87gYJlx50A5Y3Z5GRhMkPh/u4qUyzGs4Lb1+m5o+BvgE2XxSHK8n+WrbQQlWAyyed9TDRrKrRVA==;5:yShXwAnvrTTuLbdzDDVDgMUMiGalxUEMoAc6pWLzj0v7VZSpFhX2PPUVHrMM8xNkHD63GfjwekzkHTZzcqs1tFsfTpe4nos85xyCfAgKfTtOlIqwXIEGnGi+C40TiDzEBmHXieK2HiRjD2QBtQSD+GG5J+0HOCo1Wh12ppH2lZ/hIq0VIQeKeWELqUD16ULPJSyQHPNU6LWeZ5bNpNEeZQ==;7:6Umlh6iwXqtDPdRNIlIQzMOjqOPMNrMWjuAMILr4NHq95w9o/fxPNbMYIXJk9pop3wCRsRLQl3+ThWZO9HXLNqjM9As0yC9//7OLnYe+nMwkae10a22+J55PBsGxSpoS3mX+Ys7cpWm8veFgjI4FZg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 18ed2937-4dff-42e0-4023-08d681c72a1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4498;
x-ms-traffictypediagnostic: AM0PR04MB4498:
x-microsoft-antispam-prvs: <AM0PR04MB449880D9C98CFEB76FCC6B01889A0@AM0PR04MB4498.eurprd04.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(13464003)(25786009)(44832011)(33656002)(305945005)(8676002)(6246003)(4326008)(7736002)(81166006)(81156014)(8936002)(486006)(53936002)(68736007)(476003)(11346002)(71200400001)(99286004)(446003)(71190400001)(14444005)(256004)(186003)(55016002)(102836004)(54906003)(26005)(97736004)(76176011)(6506007)(316002)(53546011)(7696005)(2906002)(6916009)(229853002)(478600001)(66066001)(106356001)(86362001)(6436002)(105586002)(7416002)(9686003)(14454004)(3846002)(6116002)(74316002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4498;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X7b/k8GOP/fzoRZvmdHa4wSb4TNvhFiNH90y5Yaw3YKPLHcO+BYI2ldvZZC46b14D7orr6VO09ak0VVA9HYMRaiONhgpncWx/fAT8fW+zgUeLxiUX2izwL9U/6hTBB62J7W7WtpzhkXO+BGoPa76PNXpUM3EwzaAtg5VnAq3HqQAuwyXpUcVZkTBzYmTOug5vKEqFwsCSd3w3G8zLR8fpv00b3wP7kpkSEtSXWGIqPhANVkXc/XAixuNUtw1KQQvfnDvnBsqhbuPK6zfO8kXZbb/NULEBZZ6hSfd2Ufcewb6TqtRxXQdHdPvdjhN+ky8koDOq4YLoJWKv+XazJcaqcm0Hfj7Zs6rVGJNl99jd3gLPdfso62t4nUU8P1Z3oTYnln4CL7ahK0RMQdUCXMg3CQEBQxke/HZWJdcaC+IpkE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ed2937-4dff-42e0-4023-08d681c72a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 06:42:52.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFubyBTdGFiZWxs
aW5pIFttYWlsdG86c3N0YWJlbGxpbmlAa2VybmVsLm9yZ10NCj4gU2VudDogMjAxOcTqMdTCMjPI
1SA0OjAwDQo+IFRvOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gQ2M6IG1zdEByZWRo
YXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBzc3RhYmVsbGluaUBrZXJuZWwub3JnOw0KPiBo
Y2hAaW5mcmFkZWFkLm9yZzsgeGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnOw0KPiBsaW51
eC1yZW1vdGVwcm9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGx1dG9Aa2Vy
bmVsLm9yZzsgamdyb3NzQHN1c2UuY29tOw0KPiBib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1hlbi1kZXZlbF0gW1JGQ10gdmlydGlvX3Jpbmc6IGNoZWNrIGRtYV9t
ZW0gZm9yIHhlbl9kb21haW4NCj4gDQo+IE9uIE1vbiwgMjEgSmFuIDIwMTksIFBlbmcgRmFuIHdy
b3RlOg0KPiA+IG9uIGkuTVg4UU0sIE00XzEgaXMgY29tbXVuaWNhdGluZyB3aXRoIERvbVUgdXNp
bmcgcnBtc2cgd2l0aCBhIGZpeGVkDQo+ID4gYWRkcmVzcyBhcyB0aGUgZG1hIG1lbSBidWZmZXIg
d2hpY2ggaXMgcHJlZGVmaW5lZC4NCj4gPg0KPiA+IFdpdGhvdXQgdGhpcyBwYXRjaCwgdGhlIGZs
b3cgaXM6DQo+ID4gdnJpbmdfbWFwX29uZV9zZyAtPiB2cmluZ191c2VfZG1hX2FwaQ0KPiA+ICAg
ICAgICAgICAgICAgICAgLT4gZG1hX21hcF9wYWdlDQo+ID4gCQkgICAgICAgLT4gX19zd2lvdGxi
X21hcF9wYWdlDQo+ID4gCQkgICAgICAgICAgICAgICAgLT5zd2lvdGxiX21hcF9wYWdlDQo+ID4g
CQkJCS0+X19kbWFfbWFwX2FyZWEocGh5c190b192aXJ0KGRtYV90b19waHlzKGRldiwNCj4gZGV2
X2FkZHIpKSwgc2l6ZSwNCj4gPiBkaXIpOyBIb3dldmVyIHdlIGFyZSB1c2luZyBwZXIgZGV2aWNl
IGRtYSBhcmVhIGZvciBycG1zZywgcGh5c190b192aXJ0DQo+ID4gY291bGQgbm90IHJldHVybiBh
IGNvcnJlY3QgdmlydHVhbCBhZGRyZXNzIGZvciB2aXJ0dWFsIGFkZHJlc3MgaW4NCj4gPiB2bWFs
bG9jIGFyZWEuIFRoZW4ga2VybmVsIHBhbmljLg0KPiA+DQo+ID4gV2l0aCB0aGlzIHBhdGNoLCB2
cmluZ191c2VfZG1hX2FwaSB3aWxsIHJldHVybiBmYWxzZSwgYW5kDQo+ID4gdnJpbmdfbWFwX29u
ZV9zZyB3aWxsIHJldHVybiBzZ19waHlzKHNnKSB3aGljaCBpcyB0aGUgY29ycmVjdCBwaHlzDQo+
ID4gYWRkcmVzcyBpbiB0aGUgcHJlZGVmaW5lZCBtZW1vcnkgcmVnaW9uLg0KPiA+IHZyaW5nX21h
cF9vbmVfc2cgLT4gdnJpbmdfdXNlX2RtYV9hcGkNCj4gPiAgICAgICAgICAgICAgICAgIC0+IHNn
X3BoeXMoc2cpDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDQgKysr
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYw0KPiA+IGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBpbmRleCBjZDdlNzU1NDg0ZTMuLjg5OTNkN2Ni
MzU5MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jDQo+ID4g
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYw0KPiA+IEBAIC0yNDgsNiArMjQ4LDgg
QEAgc3RhdGljIGlubGluZSBib29sIHZpcnRxdWV1ZV91c2VfaW5kaXJlY3Qoc3RydWN0DQo+ID4g
dmlydHF1ZXVlICpfdnEsDQo+ID4NCj4gPiAgc3RhdGljIGJvb2wgdnJpbmdfdXNlX2RtYV9hcGko
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpICB7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkbWFf
ZGV2ID0gdmRldi0+ZGV2LnBhcmVudDsNCj4gPiArDQo+ID4gIAlpZiAoIXZpcnRpb19oYXNfaW9t
bXVfcXVpcmsodmRldikpDQo+ID4gIAkJcmV0dXJuIHRydWU7DQo+ID4NCj4gPiBAQCAtMjYwLDcg
KzI2Miw3IEBAIHN0YXRpYyBib29sIHZyaW5nX3VzZV9kbWFfYXBpKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlDQo+ICp2ZGV2KQ0KPiA+ICAJICogdGhlIERNQSBBUEkgaWYgd2UncmUgYSBYZW4gZ3Vlc3Qs
IHdoaWNoIGF0IGxlYXN0IGFsbG93cw0KPiA+ICAJICogYWxsIG9mIHRoZSBzZW5zaWJsZSBYZW4g
Y29uZmlndXJhdGlvbnMgdG8gd29yayBjb3JyZWN0bHkuDQo+ID4gIAkgKi8NCj4gPiAtCWlmICh4
ZW5fZG9tYWluKCkpDQo+ID4gKwlpZiAoeGVuX2RvbWFpbigpICYmICFkbWFfZGV2LT5kbWFfbWVt
KQ0KPiA+ICAJCXJldHVybiB0cnVlOw0KPiA+DQo+ID4gIAlyZXR1cm4gZmFsc2U7DQo+IA0KPiBJ
IGNhbiBzZWUgeW91IHNwb3R0ZWQgYSByZWFsIGlzc3VlLCBidXQgdGhpcyBpcyBub3QgdGhlIHJp
Z2h0IGZpeC4gV2UganVzdCBuZWVkDQo+IHNvbWV0aGluZyBhIGJpdCBtb3JlIGZsZXhpYmxlIHRo
YW4geGVuX2RvbWFpbigpOiB0aGVyZSBhcmUgbWFueSBraW5kcyBvZiBYZW4NCj4gZG9tYWlucyBv
biBkaWZmZXJlbnQgYXJjaGl0ZWN0dXJlcywgd2UgYmFzaWNhbGx5IHdhbnQgdG8gZW5hYmxlIHRo
aXMgKHJldHVybg0KPiB0cnVlIGZyb20gdnJpbmdfdXNlX2RtYV9hcGkpIG9ubHkgd2hlbiB0aGUg
eGVuIHN3aW90bGIgaXMgbWVhbnQgdG8gYmUgdXNlZC4NCj4gRG9lcyB0aGUgYXBwZW5kZWQgcGF0
Y2ggZml4IHRoZSBpc3N1ZSB5b3UgaGF2ZT8NCj4gDQo+IC0tLQ0KPiANCj4geGVuOiBpbnRyb2R1
Y2UgeGVuX3ZyaW5nX3VzZV9kbWENCj4gDQo+IEZyb206IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3Rl
ZmFub3NAeGlsaW54LmNvbT4NCj4gDQo+IEV4cG9ydCB4ZW5fc3dpb3RsYiBvbiBhcm0gYW5kIGFy
bTY0Lg0KPiANCj4gVXNlIHhlbl9zd2lvdGxiIHRvIGRldGVybWluZSB3aGVuIHZyaW5nIHNob3Vs
ZCB1c2UgZG1hIEFQSXMgdG8gbWFwIHRoZQ0KPiByaW5nOiB3aGVuIHhlbl9zd2lvdGxiIGlzIGVu
YWJsZWQgdGhlIGRtYSBBUEkgaXMgcmVxdWlyZWQuIFdoZW4gaXQgaXMgZGlzYWJsZWQsDQo+IGl0
IGlzIG5vdCByZXF1aXJlZC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBTdGFiZWxsaW5pIDxzdGVmYW5vc0B4
aWxpbnguY29tPg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3hlbi9z
d2lvdGxiLXhlbi5oDQo+IGIvYXJjaC9hcm0vaW5jbHVkZS9hc20veGVuL3N3aW90bGIteGVuLmgN
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uNDU1YWRlNQ0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3hlbi9zd2lvdGxiLXhlbi5o
DQo+IEBAIC0wLDAgKzEgQEANCj4gKyNpbmNsdWRlIDx4ZW4vYXJtL3N3aW90bGIteGVuLmg+DQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS94ZW4vbW0uYyBiL2FyY2gvYXJtL3hlbi9tbS5jIGluZGV4
DQo+IGNiNDRhYTIuLjg1OTI4NjMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL3hlbi9tbS5jDQo+
ICsrKyBiL2FyY2gvYXJtL3hlbi9tbS5jDQo+IEBAIC0yMSw2ICsyMSw4IEBADQo+ICAjaW5jbHVk
ZSA8YXNtL3hlbi9oeXBlcmNhbGwuaD4NCj4gICNpbmNsdWRlIDxhc20veGVuL2ludGVyZmFjZS5o
Pg0KPiANCj4gK2ludCB4ZW5fc3dpb3RsYiBfX3JlYWRfbW9zdGx5Ow0KPiArDQo+ICB1bnNpZ25l
ZCBsb25nIHhlbl9nZXRfc3dpb3RsYl9mcmVlX3BhZ2VzKHVuc2lnbmVkIGludCBvcmRlcikgIHsN
Cj4gIAlzdHJ1Y3QgbWVtYmxvY2tfcmVnaW9uICpyZWc7DQo+IEBAIC0xODksNiArMTkxLDcgQEAg
aW50IF9faW5pdCB4ZW5fbW1faW5pdCh2b2lkKQ0KPiAgCXN0cnVjdCBnbnR0YWJfY2FjaGVfZmx1
c2ggY2ZsdXNoOw0KPiAgCWlmICgheGVuX2luaXRpYWxfZG9tYWluKCkpDQo+ICAJCXJldHVybiAw
Ow0KPiArCXhlbl9zd2lvdGxiID0gMTsNCj4gIAl4ZW5fc3dpb3RsYl9pbml0KDEsIGZhbHNlKTsN
Cj4gIAl4ZW5fZG1hX29wcyA9ICZ4ZW5fc3dpb3RsYl9kbWFfb3BzOw0KPiANCj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20veGVuL3N3aW90bGIteGVuLmgNCj4gYi9hcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL3hlbi9zd2lvdGxiLXhlbi5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAuLjQ1NWFkZTUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3hlbi9zd2lvdGxiLXhlbi5oDQo+IEBAIC0wLDAgKzEgQEANCj4g
KyNpbmNsdWRlIDx4ZW4vYXJtL3N3aW90bGIteGVuLmg+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBpbmRl
eA0KPiBjZDdlNzU1Li5iZjhiYWRjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jDQo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMNCj4gQEAgLTI2
MCw3ICsyNjAsNyBAQCBzdGF0aWMgYm9vbCB2cmluZ191c2VfZG1hX2FwaShzdHJ1Y3QgdmlydGlv
X2RldmljZQ0KPiAqdmRldikNCj4gIAkgKiB0aGUgRE1BIEFQSSBpZiB3ZSdyZSBhIFhlbiBndWVz
dCwgd2hpY2ggYXQgbGVhc3QgYWxsb3dzDQo+ICAJICogYWxsIG9mIHRoZSBzZW5zaWJsZSBYZW4g
Y29uZmlndXJhdGlvbnMgdG8gd29yayBjb3JyZWN0bHkuDQo+ICAJICovDQo+IC0JaWYgKHhlbl9k
b21haW4oKSkNCj4gKwlpZiAoeGVuX3ZyaW5nX3VzZV9kbWEoKSkNCj4gIAkJcmV0dXJuIHRydWU7
DQo+IA0KPiAgCXJldHVybiBmYWxzZTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUveGVuL2FybS9z
d2lvdGxiLXhlbi5oIGIvaW5jbHVkZS94ZW4vYXJtL3N3aW90bGIteGVuLmgNCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMC4uMmFhYzdjNA0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL2luY2x1ZGUveGVuL2FybS9zd2lvdGxiLXhlbi5oDQo+IEBAIC0wLDAgKzEsMTAgQEANCj4g
KyNpZm5kZWYgX0FTTV9BUk1fWEVOX1NXSU9UTEJfWEVOX0gNCj4gKyNkZWZpbmUgX0FTTV9BUk1f
WEVOX1NXSU9UTEJfWEVOX0gNCj4gKw0KPiArI2lmZGVmIENPTkZJR19TV0lPVExCX1hFTg0KPiAr
ZXh0ZXJuIGludCB4ZW5fc3dpb3RsYjsNCj4gKyNlbHNlDQo+ICsjZGVmaW5lIHhlbl9zd2lvdGxi
ICgwKQ0KPiArI2VuZGlmDQo+ICsNCj4gKyNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS94
ZW4veGVuLmggYi9pbmNsdWRlL3hlbi94ZW4uaCBpbmRleCAwZTIxNTY3Li43NGE1MzZkDQo+IDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL3hlbi94ZW4uaA0KPiArKysgYi9pbmNsdWRlL3hlbi94ZW4u
aA0KPiBAQCAtNDYsNCArNDYsMTAgQEAgZW51bSB4ZW5fZG9tYWluX3R5cGUgeyAgYm9vbA0KPiB4
ZW5fYmlvdmVjX3BoeXNfbWVyZ2VhYmxlKGNvbnN0IHN0cnVjdCBiaW9fdmVjICp2ZWMxLA0KPiAg
CQljb25zdCBzdHJ1Y3QgYmlvX3ZlYyAqdmVjMik7DQo+IA0KPiArI2luY2x1ZGUgPGFzbS94ZW4v
c3dpb3RsYi14ZW4uaD4NCj4gK3N0YXRpYyBpbmxpbmUgaW50IHhlbl92cmluZ191c2VfZG1hKHZv
aWQpIHsNCj4gKwlyZXR1cm4gISF4ZW5fc3dpb3RsYjsNCj4gK30NCj4gKw0KPiAgI2VuZGlmCS8q
IF9YRU5fWEVOX0ggKi8NCg0KVGVzdGVkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cg0KVGhhbmtzLA0KUGVuZw0K
