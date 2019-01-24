Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29271C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD16021855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h2lKkjjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfAXGrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:47:36 -0500
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:14736
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbfAXGrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVUhl5EWqKJOeF55AJA5x4CghaE2FbAhQRc8YV9nqVw=;
 b=h2lKkjjsfVqYHkJ6/prV1xFfvmliwk+phzIPpqQb9hhJQCU23pcM76fyyo02UerDr9vn48ust4BwM3gWirLb6KCL54AN3GbQtJTKvhPQIZMCHQG1KuBkwOjTqvT2aw2R5A9lceQNZzLuc8+5143JWuT/KJ+pmseEOgVznQgc41A=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0SPR01MB04.eurprd04.prod.outlook.com (52.133.47.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 06:47:28 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903%3]) with mapi id 15.20.1537.031; Thu, 24 Jan 2019
 06:47:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jliang@xilinx.com" <jliang@xilinx.com>
Subject: RE: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Topic: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Index: AQHUsUUJrf+HCksNJUevQFBecw2Jm6W7t2+AgAC8CgCAAOh3gIAAAqqAgAAp0YCAAHUmQA==
Date:   Thu, 24 Jan 2019 06:47:28 +0000
Message-ID: <AM0PR04MB4481BE680ACB40E78456DA64889A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
 <20190123071232.GA20526@infradead.org>
 <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
 <20190123211405.GA4971@infradead.org>
 <alpine.DEB.2.10.1901231427010.17936@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1901231427010.17936@sstabellini-ThinkPad-X260>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [114.217.246.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0SPR01MB04;6:eXtGygbOhAv2Jtmi0p0+LO25V6/kumDwGn+ZGpgOksMHSChAuKHwIl+dOgFNPx4fiq8r0TgnrMLDG7yAFTAJEz/48RoYEEQ7Ubeavw0q9dqozHJ/rH3x00BLSDTV0ub2+LspLpxmALGCy0WQm+LYyb19bZX44EaRnBBfWbXBvCHKbTnQU3IMDvKvSsNCVSx/C+KnvEcVF3CSyP9EWC4rI3EuVBKJQjakMlqfLn/8yC0FYQGnQcyTNDfOkd8PvdoROtfnUm3oVa8sejLLeOMzAmB7aH/TQ5ntwsCeBmE83ulei0RoEk8wx3prK2Eyh+35AaKUxOdNylwv6QbaMi9z08bPjS/drAae1J7ICQFnzdnG6bVb1ieiWLqXgMYIP3Rd2JX5v6nc38DbC2HEULWANdlLxvWX0Rxo3eU81wm+xvQZ0LK3g2VPeLD2HAn+zNnqa7TiFetCKxG5uDNhy/MV5g==;5:tKBbuz01Jzl6TmgfSdXuFjGSHS1gUwnQzy89GYXq0st/pETrSob+DyspGCJzdtrZPHfhIQhP9+Nn4pKAJM2pPZAryrhFtJyvtj3h14hUoBUhZX25IzzMvWPKzxDIW7SkVVkqVgqVuadtQXRA+JxIfRZWH46Btew+EoAZHfvrp0u43PhQLgsbU+eKQ8LMbCxTNMRiac20Y0UQfu6ePQz3Mg==;7:3BxN4+5ewthAj3BWdnPptAjaxoDqnI2YWoxx++i924pMZ6/aEVYlCcoBUDW5xR+DWGOZWJL2tGE5po1aWDRjH9b2JtOlhrcG+zDN7TP0i3AKx4Ph4EIiaoJeU4T/AteD0nRIQ8qeMLw7BE2rSX9j5A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 40d81656-64e2-4b02-f3e8-08d681c7cee8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0SPR01MB04;
x-ms-traffictypediagnostic: AM0SPR01MB04:
x-microsoft-antispam-prvs: <AM0SPR01MB0410E6047E61DEB82FA4A4889A0@AM0SPR01MB04.eurprd04.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(13464003)(189003)(199004)(966005)(44832011)(256004)(71190400001)(305945005)(14444005)(74316002)(53936002)(486006)(11346002)(476003)(446003)(4326008)(68736007)(71200400001)(2906002)(229853002)(81156014)(81166006)(86362001)(76176011)(8936002)(99286004)(8676002)(7736002)(478600001)(7696005)(66066001)(7416002)(2501003)(6116002)(3846002)(97736004)(33656002)(14454004)(25786009)(66574012)(186003)(53546011)(6436002)(6506007)(102836004)(26005)(54906003)(6246003)(316002)(105586002)(93886005)(110136005)(106356001)(6306002)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB04;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lB8JPDiZ2Y5SmbhC0btazGIyTo3NkPWVHtJdWRwOfhLrzfvuj1Os/5/21IK2hiAK34fBebJhqk4t1rqLr4m9KGAAJs1Rahhd5B3N2TAEiTfKJd9tOjAt+8+zES0aahLjuEHdaIcuTQD6fwL4pnstYlt5jGdmlyjea7RED5X+ESmaidoCmVcA62gNTKuRmMA9+vVTqYsa99v8fBkCrIWiqwWDFIPUwXJNkBTHsftrBf6rgoMp6ggNsznzfhc2Hf9l4rhPTKTbWJ3KcMVJJEhgcEb03c2kJqTHfGMa/5iQ/H36DMfO70kHO6jhLXKvt1CBbCxk0MNgYXNqsBJZQFx3wCn5O4Ew1ITcs/HIxB3LlWq67F3I88YsLGMRfYRGnRq0zMYgp97t+14+d3Qagx04W0lsu+OaYYMa8nsGaRvhjiQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d81656-64e2-4b02-f3e8-08d681c7cee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 06:47:28.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB04
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgc3RlZmFubywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVm
YW5vIFN0YWJlbGxpbmkgW21haWx0bzpzc3RhYmVsbGluaUBrZXJuZWwub3JnXQ0KPiBTZW50OiAy
MDE55bm0MeaciDI05pelIDc6NDQNCj4gVG86IGhjaEBpbmZyYWRlYWQub3JnDQo+IENjOiBTdGVm
YW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBQZW5nIEZhbg0KPiA8cGVu
Zy5mYW5AbnhwLmNvbT47IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOw0KPiB4
ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmc7IGxpbnV4LXJlbW90ZXByb2NAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB2aXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gbHV0b0BrZXJuZWwub3JnOyBqZ3Jvc3NAc3Vz
ZS5jb207IGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tOw0KPiBiam9ybi5hbmRlcnNzb25AbGlu
YXJvLm9yZzsgamxpYW5nQHhpbGlueC5jb20NCj4gU3ViamVjdDogUmU6IFtYZW4tZGV2ZWxdIFtS
RkNdIHZpcnRpb19yaW5nOiBjaGVjayBkbWFfbWVtIGZvciB4ZW5fZG9tYWluDQo+IA0KPiBPbiBX
ZWQsIDIzIEphbiAyMDE5LCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90ZToNCj4gPiBPbiBXZWQsIEph
biAyMywgMjAxOSBhdCAwMTowNDozM1BNIC0wODAwLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6
DQo+ID4gPiBJZiB2cmluZ191c2VfZG1hX2FwaSBpcyBhY3R1YWxseSBzdXBwb3NlZCB0byByZXR1
cm4gdHJ1ZSB3aGVuDQo+ID4gPiBkbWFfZGV2LT5kbWFfbWVtIGlzIHNldCwgdGhlbiBib3RoIFBl
bmcncyBwYXRjaCBhbmQgdGhlIHBhdGNoIEkNCj4gPiA+IHdyb3RlIGFyZSBub3QgZml4aW5nIHRo
ZSByZWFsIGlzc3VlIGhlcmUuDQo+ID4gPg0KPiA+ID4gSSBkb24ndCBrbm93IGVub3VnaCBhYm91
dCByZW1vdGVwcm9jIHRvIGtub3cgd2hlcmUgdGhlIHByb2JsZW0NCj4gPiA+IGFjdHVhbGx5IGxp
ZXMgdGhvdWdoLg0KPiA+DQo+ID4gVGhlIHByb2JsZW0gaXMgdGhlIGZvbGxvd2luZzoNCj4gPg0K
PiA+IERldmljZXMgY2FuIGRlY2xhcmUgYSBzcGVjaWZpYyBtZW1vcnkgcmVnaW9uIHRoYXQgdGhl
eSB3YW50IHRvIHVzZQ0KPiA+IHdoZW4gdGhlIGRyaXZlciBjYWxscyBkbWFfYWxsb2NfY29oZXJl
bnQgZm9yIHRoZSBkZXZpY2UsIHRoaXMgaXMgZG9uZQ0KPiA+IHVzaW5nIHRoZSBzaGFyZWQtZG1h
LXBvb2wgRFQgYXR0cmlidXRlLCB3aGljaCBjb21lcyBpbiB0d28gdmFyaWFudHMNCj4gPiB0aGF0
IHdvdWxkIGJlIGEgbGl0dGxlIHRvIG11Y2ggdG8gZXhwbGFpbiBoZXJlLg0KPiA+DQo+ID4gcmVt
b3RlcHJvYyBtYWtlcyB1c2Ugb2YgdGhhdCBiZWNhdXNlIGFwcGFyZW50bHkgdGhlIGRldmljZSBj
YW4gb25seQ0KPiA+IGNvbW11bmljYXRlIHVzaW5nIHRoYXQgcmVnaW9uLiAgQnV0IGl0IHRoZW4g
ZmVlZHMgYmFjayBtZW1vcnkgb2J0YWluZWQNCj4gPiB3aXRoIGRtYV9hbGxvY19jb2hlcmVudCBp
bnRvIHRoZSB2aXJ0aW8gY29kZS4gIEZvciB0aGF0IGl0IGNhbGxzDQo+ID4gdm1hbGxvY190b19w
YWdlIG9uIHRoZSBkbWFfYWxsb2NfY29oZXJlbnQsIHdoaWNoIGlzIGEgaHVnZSBuby1nbyBmb3IN
Cj4gPiB0aGUgxJBNQSBBUEkgYW5kIG9ubHkgd29ya2VkIGFjY2lkZW50YWxseSBvbiBhIGZldyBw
bGF0Zm9ybSwgYW5kDQo+ID4gYXBwYXJlbnRseSBhcm02NCBqdXN0IGNoYW5nZWQgYSBmZXcgaW50
ZXJuYWxzIHRoYXQgbWFkZSBpdCBzdG9wDQo+ID4gd29ya2luZyBmb3IgcmVtb3RlcHJvYy4NCj4g
Pg0KPiA+IFRoZSByaWdodCBhbnN3ZXIgaXMgdG8gbm90IHVzZSB0aGUgRE1BIEFQSSB0byBhbGxv
Y2F0ZSBtZW1vcnkgZnJvbSBhDQo+ID4gZGV2aWNlLXNwZWZpY2ljIHJlZ2lvbiwgYnV0IHRvIHRp
ZSB0aGUgZHJpdmVyIGRpcmVjdGx5IGludG8gdGhlIERUDQo+ID4gcmVzZXJ2ZWQgbWVtb3J5IEFQ
SSBpbiBhIHdheSB0aGF0IGFsbG93cyBpdCB0byBlYXNpbHQgb2J0YWluIGEgc3RydWN0DQo+ID4g
ZGV2aWNlIGZvciBpdC4NCj4gDQo+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIFBlbmcgc2hv
dWxkIGJlIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIG9uDQo+IG5hdGl2ZSBMaW51eCB3
aXRob3V0IGFueSBYZW4gaW52b2x2ZW1lbnQgc2ltcGx5IGJ5IGZvcmNpbmcNCj4gdnJpbmdfdXNl
X2RtYV9hcGkgdG8gcmV0dXJuIHRydWUuIFBlbmcsIGNhbiB5b3UgY29uZmlybT8NCg0KSXQgaXMg
YW5vdGhlciBpc3N1ZSB3aXRob3V0IHhlbiBpbnZvbHZlbWVudCwgDQpUaGVyZSBpcyBhbiB0aHJl
YWQgdGFsa2luZyB0aGlzOiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNzQy
OTIzLw0KDQpXaXRob3V0IHhlbiwgdnJpbmdfdXNlX2RtYV9hcGkgd2lsbCByZXR1cm4gZmFsc2Uu
DQpXaXRoIHhlbiwgaWYgdnJpbmdfdXNlX2RtYV9hcGkgcmV0dXJucyB0cnVlLCBpdCB3aWxsIGRt
YV9tYXBfeHggYW5kIHRyaWdnZXIgZHVtcC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gQW5k
IHRoZSByaWdodCBmaXggaXMgbm90IHRvIGNhbGwgdm1hbGxvY190b19wYWdlIG9uIGEgZG1hX2Fs
bG9jX2NvaGVyZW50DQo+IGJ1ZmZlciAtLSBJIGRvbid0IGtub3cgYWJvdXQgdGhlIHJlY2VudCBj
aGFuZ2VzIG9uIGFybTY0LCBidXQgdGhhdCdzIG5vdCBnb2luZw0KPiB0byB3b3JrIHdpdGggYXJt
MzIgZWl0aGVyIEFGQUlLLiBHaXZlbiB0aGF0IEkgZG9uJ3QgaGF2ZSBhIHJlcHJvLCBJJ2xsIGxl
YXZlIGl0IHRvDQo+IFBlbmcgYW5kL29yIG90aGVycyB0byBzZW5kIHRoZSBhcHByb3ByaWF0ZSBw
YXRjaCBmb3IgcmVtb3RlcHJvYy4NCj4gDQo+IA0KPiA+IFRoaXMgaXMgb3J0aG9nb25hbCB0byBh
bm90aGVyIGlzc3VlLCBhbmQgdGhhdCBpcyB0aGF0IGhhcmR3YXJlIHZpcnRpbw0KPiA+IGRldmlj
ZXMgcmVhbGx5IGFsd2F5cyBuZWVkIHRvIHVzZSB0aGUgRE1BIEFQSSwgb3RoZXJ3aXNlIHdlJ2xs
IGJ5cGFzcw0KPiA+IHN1Y2ggZmVhdHVyZXMgYXMgdGhlIGRldmljZSBzcGVjaWZpYyBETUEgcG9v
bHMsIERNQSBvZmZzZXRzLCBjYWNoZQ0KPiA+IGZsdXNoaW5nLCBldGMsIGV0Yy4NCj4gDQo+IEkg
dW5kZXJzdGFuZCwgSSdsbCBkcm9wIG15IHBhdGNoLg0K
