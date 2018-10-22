Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AE4C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1683F2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hAigHyyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1683F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeJVWFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:05:53 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50976 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJVWFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:05:53 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4FCFA10C175D;
        Mon, 22 Oct 2018 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540216033; bh=BsTJcYxZ/+7zRmfJhATbYGz0XtoKrHBErtMprsJFT7Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hAigHyyx5EG3CZ6Svxi2A0MinKWC+rq0SJeCeXlNR7019m949DxT9BzqXvtdIW5Vb
         XJnYo5IaljL00pspdzZfkjakG2ehTfiy3BYi+y4/jsmAj0BtZSy3lcraqygbIDTPZK
         lpBFssAUd5o64TdOWX3vr285jh/HDIkcey2m9C9elfoj6pWEHU1h3Ayvbf9CUJhwph
         G1Z03mfB4jVhPQ7LDC+Lph4z1l2qm2UegSadR8BDRWNTWA3l4Rcj4RqTAF70Og6CNg
         VdEDzTO4vpwU+hvf0M8FqCsmDDDbP991mqK0XrosxO5/dKv79Owf8ciGWDcw4cDL8a
         FF4SV10cuzAAQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1371A38AA;
        Mon, 22 Oct 2018 06:47:13 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Oct 2018 06:47:13 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 22 Oct 2018 15:47:10 +0200
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH v2 0/2] MTD: spi-nor: add support for sst26wf016,
 sst26wf032
Thread-Topic: [PATCH v2 0/2] MTD: spi-nor: add support for sst26wf016,
 sst26wf032
Thread-Index: AQHUSPvuffhE0Br5ZEyOxS1chcEkcaUrZ/QA
Date:   Mon, 22 Oct 2018 13:47:09 +0000
Message-ID: <1540216028.19916.6.camel@synopsys.com>
References: <20180910114628.19156-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180910114628.19156-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CFE53BA8EFEEA49BA7AE581DDEAF3EF@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk1heWJlIHlvdSBoYXZlIGFueSBjb21tZW50cyBvciByZW1hcmtzIGFib3V0IHRoaXMg
cGF0Y2g/QW5kIGlmIHlvdSBkb24ndCBjb3VsZCB5b3UgcGxlYXNlIGFwcGx5IGl0LiBUaGFua3Mh
DQoNCk9uIE1vbiwgMjAxOC0wOS0xMCBhdCAxNDo0NiArMDMwMCwgRXVnZW5peSBQYWx0c2V2IHdy
b3RlOg0KPiBBZGQgc3VwcG9ydCBmb3IgdGhlIFNTVCBzc3QyNndmMDE2IGFuZCBzc3QyNndmMDMy
IGZsYXNoIElDOg0KPiANCj4gc3N0MjZ3ZioqKiBmbGFzaCBzZXJpZXMgYmxvY2sgcHJvdGVjdGlv
biBpbXBsZW1lbnRhdGlvbiBkaWZmZXJzIGZyb20gb3RoZXINCj4gU1NUIHNlcmllcywgc28gd2Ug
YWRkIGltcGxlbWVudGF0aW9uIGZvciBzc3QyNndmKioqIGxvY2svdW5sb2NrL2lzX2xvY2tlZA0K
PiBmdW5jdGlvbnMuDQo+IA0KPiBBZGQgc3N0MjZ3ZjAxNiBhbmQgc3N0MjZ3ZjAzMiBmbGFzaCBJ
QyBpbmZvIHRvIHNwaV9mbGFzaF9pZHMgbGlzdC4NCj4gDQo+IE5PVEU6DQo+IHRoZXNlIHBhdGNo
ZXMgaXMgYmFzaWNhbGx5IGZvbGxvd2luZyBtaW5lIHUtYm9vdCBjb21taXRzIHBvcnQ6DQo+IGh0
dHA6Ly9naXQuZGVueC5kZS8/cD11LWJvb3QuZ2l0O2E9Y29tbWl0ZGlmZjtoPTNkNGZlZDg3YTVm
YTNmZmVkZjY0ZmYyODExY2Q5NWM1YWM0NTAzYWMNCj4gaHR0cDovL2dpdC5kZW54LmRlLz9wPXUt
Ym9vdC5naXQ7YT1jb21taXRkaWZmO2g9YTE5ZTk3MTU3YzM3MjFlZjljNGIxNWM2OGMxNzczNDY3
YTNiNGE5OA0KPiANCj4gQ2hhbmdlcyB2MS0+djI6DQo+ICAqIENoZWNrIHJldHVybiB2YWx1ZSBv
ZiB7cmVhZCB8IHdyaXRlfV9yZWcgY2FsbGJhY2tzLg0KPiANCj4gRXVnZW5peSBQYWx0c2V2ICgy
KToNCj4gICBtdGQ6IHNwaS1ub3I6IEFkZCBzdXBwb3J0IG9mIHNzdDI2d2YqIGZsYXNoIElDcyBw
cm90ZWN0aW9uIG9wcw0KPiAgIG10ZDogc3BpLW5vcjogYWRkIHN1cHBvcnQgZm9yIHNzdDI2d2Yw
MTYsIHNzdDI2d2YwMzINCj4gDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDE3
OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUv
bGludXgvbXRkL3NwaS1ub3IuaCAgIHwgICA0ICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTgzIGlu
c2VydGlvbnMoKykNCj4gDQotLSANCiBFdWdlbml5IFBhbHRzZXY=
