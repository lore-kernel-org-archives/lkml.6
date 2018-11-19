Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61F6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69583206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SESTMW6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69583206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeKTBtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:49:33 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:45442 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbeKTBtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:49:33 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E73F910C1491;
        Mon, 19 Nov 2018 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542641138; bh=6g2l45bCnSB+ZxbUqsFOOT1ilsyMkTsEckcginyFYYw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SESTMW6o5LQDDkvB6GEazQianpDo9v6acfWf0WGNcS8sZ/Huc2+2DDsbUZa68h11D
         CEVWQofb21rtVjtnm8jwEzCDC29R1AbUQgtcJvDw5AXM77Cdq5yKguPvo6nJRJiI1o
         L7kk89rTql9NiBaHAh0BmFKBfTkZWLI6TVHjTKw6fBQfjcdifixRTK4MQEh/UYB/54
         Eb8SJNo23Hwj4N/sC8ObwwmQ4MGh0p+degnydjW/egFS1iiysHfqVvIzhwytnF8Aak
         ar2ZCPPnW1tlRd26RGkCsnSKoln+zxcoJp2PXPZ6hO+k5EWRi4yABmKILbFMVLS8db
         nPJcB3iR35ayg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 34D0F5E4C;
        Mon, 19 Nov 2018 07:25:36 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 07:25:36 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 19 Nov 2018 16:25:34 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH v2 0/2] MTD: spi-nor: add support for sst26wf016,
 sst26wf032
Thread-Topic: [PATCH v2 0/2] MTD: spi-nor: add support for sst26wf016,
 sst26wf032
Thread-Index: AQHUSPvuffhE0Br5ZEyOxS1chcEkcaUrZ/QAgAACpICALCrmgA==
Date:   Mon, 19 Nov 2018 15:25:34 +0000
Message-ID: <1542641133.4940.5.camel@synopsys.com>
References: <20180910114628.19156-1-Eugeniy.Paltsev@synopsys.com>
         <1540216028.19916.6.camel@synopsys.com>
         <20181022155635.2175a595@bbrezillon>
In-Reply-To: <20181022155635.2175a595@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <792B627031D4524B90B1F069409F72FB@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCkFzIDQuMjAtcmMxIGlzIGFscmVhZHkgb3V0IEkgZ3Vlc3MgeW91IGNhbiBw
aWNrIHRoaXMgcGF0Y2hlcyB0byBzcGktbm9yL25leHQ/DQoNClRoYW5rcy4NCg0KT24gTW9uLCAy
MDE4LTEwLTIyIGF0IDE1OjU2ICswMjAwLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6DQo+ICtUdWRv
cg0KPiANCj4gSGkgRXVnZW5peSwNCj4gDQo+IFNvcnJ5LCBpdCdzIGFscmVhZHkgdG9vIGxhdGUg
Zm9yIDQuMjAsIGFuZCBJIHdvbid0IGFwcGx5IHBhdGNoZXMgdG8gdGhlDQo+IHNwaS1ub3IvbmV4
dCBicmFuY2ggYmVmb3JlIDQuMjAtcmMxIGlzIG91dC4NCj4gDQo+IFR1ZG9yLCBNYXJlaywgY2Fu
IEkgaGF2ZSBhIFJldmlld2VkLWJ5L0Fja2VkLWJ5IG9uIHRoaXMgcGF0Y2hzZXQ/DQo+IA0KPiBU
aGFua3MsDQo+IA0KPiBCb3Jpcw0KPiANCj4gPiANCj4gPiBPbiBNb24sIDIwMTgtMDktMTAgYXQg
MTQ6NDYgKzAzMDAsIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gPiA+IEFkZCBzdXBwb3J0IGZv
ciB0aGUgU1NUIHNzdDI2d2YwMTYgYW5kIHNzdDI2d2YwMzIgZmxhc2ggSUM6DQo+ID4gPiANCj4g
PiA+IHNzdDI2d2YqKiogZmxhc2ggc2VyaWVzIGJsb2NrIHByb3RlY3Rpb24gaW1wbGVtZW50YXRp
b24gZGlmZmVycyBmcm9tIG90aGVyDQo+ID4gPiBTU1Qgc2VyaWVzLCBzbyB3ZSBhZGQgaW1wbGVt
ZW50YXRpb24gZm9yIHNzdDI2d2YqKiogbG9jay91bmxvY2svaXNfbG9ja2VkDQo+ID4gPiBmdW5j
dGlvbnMuDQo+ID4gPiANCj4gPiA+IEFkZCBzc3QyNndmMDE2IGFuZCBzc3QyNndmMDMyIGZsYXNo
IElDIGluZm8gdG8gc3BpX2ZsYXNoX2lkcyBsaXN0Lg0KPiA+ID4gDQo+ID4gPiBFdWdlbml5IFBh
bHRzZXYgKDIpOg0KPiA+ID4gICBtdGQ6IHNwaS1ub3I6IEFkZCBzdXBwb3J0IG9mIHNzdDI2d2Yq
IGZsYXNoIElDcyBwcm90ZWN0aW9uIG9wcw0KPiA+ID4gICBtdGQ6IHNwaS1ub3I6IGFkZCBzdXBw
b3J0IGZvciBzc3QyNndmMDE2LCBzc3QyNndmMDMyDQo+ID4gPiANCj4gPiA+ICBkcml2ZXJzL210
ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDE3OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggICB8ICAgNCAr
DQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxODMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gICANCj4g
DQo+IA0KLS0gDQogRXVnZW5peSBQYWx0c2V2
