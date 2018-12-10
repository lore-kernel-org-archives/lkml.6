Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F317C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B1A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LYxjm2Np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B1A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeLJNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:32:28 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:41268 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeLJNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:32:28 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D9B7524E104E;
        Mon, 10 Dec 2018 05:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544448747; bh=q/Eh/bwff1PE72kU0WgxsGhKyHP0ggHVgzpesG4IHLw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LYxjm2Npf7Ulc+vKJ3buyKmOtErDAdZVdJVtal4bV1qeD2mAtUdil9dsSRjPRUmyc
         /AmL+C311cZyALY3ouBuVRD+hV6ZQlYOEh2Rn3hvSYn6RpnLY5AOrGEDcKrTNsIrrG
         88OB2OllODg1tv1oqhm8FvUYnAu8j2IhNfvyTlGOCSsNFKsngTZVFwoRjC30gYioez
         IJAEmuMGr6fnhlsQeiqQawBaabwRLaOLLGkRs0e6Q0PiA6SgAEthW1eKxVM+qSC1qZ
         gPgK5e6AfvxqgEHQtKUEaRiAVTXnKSS0so6YwlfaUmQhdKXxUxOI3cFBhzCulgUOGB
         aVn6E3k//wd+Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id C6F095C63;
        Mon, 10 Dec 2018 05:32:27 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Dec 2018 05:32:27 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 10 Dec 2018 14:32:25 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Remove 0x prefix from unit-address of node names
Thread-Topic: [PATCH] ARC: Remove 0x prefix from unit-address of node names
Thread-Index: AQHUjsPO+AXeE3WDFkC/l78UXo/lhKV36raAgAAAj4A=
Date:   Mon, 10 Dec 2018 13:32:24 +0000
Message-ID: <4a4b91fe634bd4352604743b3dfba245ee92a92c.camel@synopsys.com>
References: <20181208070101.6117-1-abrodkin@synopsys.com>
         <CAL_JsqK+gRtkNe4eeu_jzzMVTO5u=a30SZZFNShxn3o6rjTQYQ@mail.gmail.com>
In-Reply-To: <CAL_JsqK+gRtkNe4eeu_jzzMVTO5u=a30SZZFNShxn3o6rjTQYQ@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.121.8.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAB36835AF4CF64F8B8A78CCBA5A369F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiBNb24sIDIwMTgtMTItMTAgYXQgMDc6MzAgLTA2MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBTYXQsIERlYyA4LCAyMDE4IGF0IDE6MDEgQU0gQWxleGV5IEJyb2RraW4N
Cj4gPGFsZXhleS5icm9ka2luQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gRG9uZSBhdXRvbWF0
aWNhbGx5IHdpdGggaGVscCBvZjoNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gc2VkIC1pICdzL0AweC9AL2cnIGFyY2gvYXJjL2Jvb3Qv
ZHRzLyouZHRzKg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPiANCj4gPiBJbnNwaXJlZCBieSBbMV0gYW5kIHRoZSBsaWtlLg0KPiA+IA0K
PiA+IFsxXSANCj4gPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9
aHR0cC0zQV9fa2lzc2tiLmVsbGVybWFuLmlkLmF1X2tpc3NrYl9idWlsZHJlc3VsdF8xMzYxMjAx
N18mZD1Ed0lCYVEmYz1EUEw2X1hfNkprWEZ4N0FYV3FCMHRnJnI9bHFkZWVTU0VlczBHRkREbDY1
NmVWaVhPN2JyZVM1NXl0V2tocGs1UjgxSSZtPXp4X21KNUd6QU1JMzItaXFjWFppTDhRenJnNzlE
ejRjeE5GNzJWWWhRbDAmcz1Kd2JGY0ZtbkpSRUNsX3o3alFHbDA2ODdVcE9ScTkzOTVtZ1JibzFP
d0ZFJmU9DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGV5IEJyb2RraW4gPGFicm9ka2lu
QHN5bm9wc3lzLmNvbT4NCj4gPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4ZXkgQnJvZGtpbiA8YWJyb2RraW5Ac3lub3Bz
eXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FyYy9ib290L2R0cy9hYmlsaXNfdGIxMHguZHRz
aSAgIHwgIDQgKystLQ0KPiA+ICBhcmNoL2FyYy9ib290L2R0cy9heGMwMDEuZHRzaSAgICAgICAg
IHwgIDYgKysrLS0tDQo+ID4gIGFyY2gvYXJjL2Jvb3QvZHRzL2F4YzAwMy5kdHNpICAgICAgICAg
fCAxNCArKysrKysrLS0tLS0tLQ0KPiA+ICBhcmNoL2FyYy9ib290L2R0cy9heGMwMDNfaWR1LmR0
c2kgICAgIHwgMTQgKysrKysrKy0tLS0tLS0NCj4gPiAgYXJjaC9hcmMvYm9vdC9kdHMvYXhzMTB4
X21iLmR0c2kgICAgICB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgYXJjaC9hcmMv
Ym9vdC9kdHMvdmRrX2F4YzAwMy5kdHNpICAgICB8ICA0ICsrLS0NCj4gPiAgYXJjaC9hcmMvYm9v
dC9kdHMvdmRrX2F4YzAwM19pZHUuZHRzaSB8ICA0ICsrLS0NCj4gPiAgYXJjaC9hcmMvYm9vdC9k
dHMvdmRrX2F4czEweF9tYi5kdHNpICB8IDE0ICsrKysrKystLS0tLS0tDQo+ID4gIDggZmlsZXMg
Y2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgNDEgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJjL2Jvb3QvZHRzL2FiaWxpc190YjEweC5kdHNpIGIvYXJjaC9hcmMv
Ym9vdC9kdHMvYWJpbGlzX3RiMTB4LmR0c2kNCj4gPiBpbmRleCAzMTIxNTM2YjI1YTMuLjc3YWMx
MzY4YTY1YiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FyYy9ib290L2R0cy9hYmlsaXNfdGIxMHgu
ZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJjL2Jvb3QvZHRzL2FiaWxpc190YjEweC5kdHNpDQo+ID4g
QEAgLTE3OCw3ICsxNzgsNyBAQA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9
IDwmYWhiX2Nsaz47DQo+ID4gICAgICAgICAgICAgICAgIH07DQo+ID4gDQo+ID4gLSAgICAgICAg
ICAgICAgIHNwaTA6IHNwaUAweEZFMDEwMDAwIHsNCj4gPiArICAgICAgICAgICAgICAgc3BpMDog
c3BpQEZFMDEwMDAwIHsNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGxvd2VyY2FzZSB0b28uDQo+IA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGNlbGwtaW5kZXggPSA8MD47DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBAQCAt
MTE5LDcgKzExOSw3IEBADQo+ID4gICAgICAgICAgKiBUaGlzIG5vZGUgaXMgaW50ZW50aW9uYWxs
eSBwdXQgb3V0c2lkZSBvZiBNQiBhYm92ZSBiZWNhc2UNCj4gPiAgICAgICAgICAqIGl0IG1hcHMg
YXJlYXMgb3V0c2lkZSBvZiBNQidzIDB4RXotMHhGei4NCj4gPiAgICAgICAgICAqLw0KPiA+IC0g
ICAgICAgdWlvX2V2OiB1aW9AMHhEMDAwMDAwMCB7DQo+ID4gKyAgICAgICB1aW9fZXY6IHVpb0BE
MDAwMDAwMCB7DQo+IA0KPiBsb3dlcmNhc2UNCj4gDQo+ID4gICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAiZ2VuZXJpYy11aW8iOw0KPiA+ICAgICAgICAgICAgICAgICByZWcgPSA8MHhEMDAw
MDAwMCAweDIwMDAgMHhEMTAwMDAwMCAweDIwMDAgMHg5MDAwMDAwMCAweDEwMDAwMDAwIDB4QzAw
MDAwMDAgMHgxMDAwMDAwMD47DQoNCkkgZ3Vlc3MgcmVhbCBhZGRyZXNzZXMgc2hvdWxkIGJlIGxv
d2VyLWNhc2UgdG9vLCByaWdodD8NCg0KLUFsZXhleQ0K
