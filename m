Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4857C2083E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fDh67y6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4857C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeGIHRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:17:17 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:43687 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeGIHRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:17:16 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2EF6910C0ED3;
        Mon,  9 Jul 2018 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531120635; bh=km5h0SwTZFmwRBsEIGl0ndCkZ64zI90cz7mpoR4QLS0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fDh67y6WRs5iNQgvtf5wELvOO1x8rf+y3vnR3UER4/N1u2c10H5mt8EOjSGNVYJj+
         SFNZiMVlkSa9nhL+RV8q+/hvzMMXuOCNdOxznFAVYlLLUwYnT72qYLfwZwhrLTY2Qb
         +z2tfxCa9UsnSIFyqVbMJfvftUD8pMopwIs7vuGntWALoh+ZiRRJ+4YgH2ruq/erjs
         aQAy1HpRdu2gkk28Fm7Hle890wjr6+51tXIvBtq0fAYff9HZ8v2DrROHv/I08RRG7D
         3UG7K5K/YF8PFDpAvxvAVhOdDaQwdy3xlC9ZfgloFsJHb5q4MS7OATbd222JOzhPHy
         8OhoeWxXXidaA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id AD0034DC2;
        Mon,  9 Jul 2018 00:17:14 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 00:17:14 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 09:17:12 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "greg@kroah.com" <greg@kroah.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz+a+E6GQfxV7UuzGYUzCAFtDqSGQPUAgAAQPACAAAWHgIAAAvUA
Date:   Mon, 9 Jul 2018 07:17:11 +0000
Message-ID: <e1f959eb900b0c825842b0c28340bef9d1d2cf3e.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <20180709054842.GB7618@kroah.com>
         <1d34b6addd98c3219f902e0dc0c2922309e1de93.camel@synopsys.com>
         <20180709070635.GB13285@kroah.com>
In-Reply-To: <20180709070635.GB13285@kroah.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ECAF110E63F484996708C8228F2B85D@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KT24gTW9uLCAyMDE4LTA3LTA5IGF0IDA5OjA2ICswMjAwLCBncmVnQGtyb2Fo
LmNvbSB3cm90ZToNCj4gT24gTW9uLCBKdWwgMDksIDIwMTggYXQgMDY6NDY6NTBBTSArMDAwMCwg
QWxleGV5IEJyb2RraW4gd3JvdGU6DQo+ID4gSGkgR3JlZywNCj4gPiANCj4gPiBPbiBNb24sIDIw
MTgtMDctMDkgYXQgMDc6NDggKzAyMDAsIEdyZWcgS0ggd3JvdGU6DQo+ID4gPiBPbiBNb24sIEp1
bCAwOSwgMjAxOCBhdCAwNzo0NDo0NEFNICswMzAwLCBBbGV4ZXkgQnJvZGtpbiB3cm90ZToNCj4g
PiA+ID4gRGVwZW5kaW5nIG9uIEFCSSAibG9uZyBsb25nIiB0eXBlIG9mIGEgcGFydGljdWxhciAz
Mi1iaXQgQ1BVDQo+ID4gPiA+IG1pZ2h0IGJlIGFsaWduZWQgYnkgZWl0aGVyIHdvcmQgKDMyLWJp
dHMpIG9yIGRvdWJsZSB3b3JkICg2NC1iaXRzKS4NCj4gPiA+ID4gTWFrZSBzdXJlICJkYXRhIiBp
cyByZWFsbHkgNjQtYml0IGFsaWduZWQgZm9yIGFueSAzMi1iaXQgQ1BVLg0KPiA+ID4gPiANCj4g
PiA+ID4gQXQgbGVhc3QgZm9yIDMyLWJpdCBBUkMgY29yZXMgQUJJIHJlcXVpcmVzICJsb25nIGxv
bmciIHR5cGVzDQo+ID4gPiA+IHRvIGJlIGFsaWduZWQgYnkgbm9ybWFsIDMyLWJpdCB3b3JkLiBU
aGlzIG1ha2VzICJkYXRhIiBmaWVsZCBhbGlnbmVkIHRvDQo+ID4gPiA+IDEyIGJ5dGVzLiBXaGlj
aCBpcyBzdGlsbCBPSyBhcyBsb25nIGFzIHdlIHVzZSAzMi1iaXQgZGF0YSBvbmx5Lg0KPiA+ID4g
PiANCj4gPiA+ID4gQnV0IG9uY2Ugd2Ugd2FudCB0byB1c2UgbmF0aXZlIGF0b21pYzY0X3QgdHlw
ZSAoaS5lLiB3aGVuIHdlIHVzZSBzcGVjaWFsDQo+ID4gPiA+IGluc3RydWN0aW9ucyBMTE9DS0Qv
U0NPTkREIGZvciBhY2Nlc3NpbmcgNjQtYml0IGRhdGEpIHdlIGVhc2lseSBoaXQNCj4gPiA+ID4g
bWlzYWxpZ25lZCBhY2Nlc3MgZXhjZXB0aW9uLg0KPiA+ID4gDQo+ID4gPiBTbyBpcyB0aGlzIHNv
bWV0aGluZyB5b3UgaGl0IHRvZGF5PyAgSWYgbm90LCB3aHkgaXMgdGhpcyBuZWVkZWQgZm9yDQo+
ID4gPiBzdGFibGUga2VybmVscz8NCj4gPiANCj4gPiBJbmRlZWQgd2UgaGl0IHRoYXQgcHJvYmxl
bSByZWNlbnRseSB3aGVuIEV0bmF2aXYgZHJpdmVyIHdhcyBzd2l0Y2hlZCB0bw0KPiA+IERSTSBH
UFUgc2NoZWR1bGVyLCBzZWUNCj4gPiBjb21taXQgZTkzYjZkZWViNDVhICgiZHJtL2V0bmF2aXY6
IGhvb2sgdXAgRFJNIEdQVSBzY2hlZHVsZXIiKS4NCj4gPiBUaGUgbW9zdCBpbXBvcnRhbnQgcGFy
dCBvZiBEUk0gR1BVIHNjaGVkdWxlciBpcyAiam9iX2lkX2NvdW50IiBtZW1iZXIgb2YNCj4gPiAi
ZHJtX2dwdV9zY2hlZHVsZXIiIHN0cnVjdHVyZSBvZiB0eXBlICJhdG9taWM2NF90Ii4gVGhpcyBz
dHJ1Y3R1cmUgaXMgcHV0DQo+ID4gaW4gYSBidWZmZXIgYWxsb2NhdGVkIGJ5IGRldm1fa3phbGxv
YygpIGFuZCBpZiAiam9iX2lkX2NvdW50IiBpcyBub3QgNjQtYml0DQo+ID4gYWxpZ25lZCBhdG9t
aWMgaW5zdHJ1Y3Rpb24gZmFpbHMgd2l0aCBhbiBleGNlcHRpb24uDQo+ID4gDQo+ID4gQXMgZm9y
IHN0YWJsZSByZXF1aXJlbWVudHMgLSBtZW50aW9uZWQgY29tbWl0IHdhcyBhIHBhcnQgb2YgNC4x
NyBrZXJuZWwNCj4gPiB3aGljaCBicm9rZSBHUFUgZHJpdmVyIGZvciBvbmUgb2Ygb3VyIEhTREsg
Ym9hcmQgc28gSSBndWVzcyBiYWNrLXBvcnRpbmcNCj4gPiB0byA0LjE3IGlzIGEgbm8tYnJhaW5l
ci4NCj4gDQo+IE9rLCBzbyA0LjE3IGlzIGFzIGZhciBiYWNrIGFzIHlvdSBuZWVkPyAgUGxlYXNl
IHRyeSB0byBiZSBzcGVjaWZpYyB3aGVuDQo+IGFza2luZyBmb3Igc3RhYmxlIGJhY2twb3J0cy4N
Cg0KV2VsbCBpbiB0aGF0IHBhcnRpY3VsYXIgY2FzZSBJIHJlYWxseSB3YW50ZWQgdG8gZ2V0IHRo
aXMgZml4IGJhY2stcG9ydGVkDQpzdGFydGluZyBmcm9tIHY0Ljggc28gSSBndWVzcyB0aGF0J3Mg
d2hhdCBJIG5lZWQgdG8gYWRkIGluIENjIHRhZywgcmlnaHQ/DQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDYzogPHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmc+ICMgNC44Kw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KDQo+ID4gPiA+IFRoYXQncyBiZWNhdXNlIGV2ZW4gb24gQ1BVcyBjYXBhYmxl
IG9mIG5vbi1hbGlnbmVkIGRhdGEgYWNjZXNzIExML1NDDQo+ID4gPiA+IGluc3RydWN0aW9ucyBy
ZXF1aXJlIHN0cmljdCBhbGlnbm1lbnQuDQo+ID4gPiANCj4gPiA+IEFyZSB5b3UgZ29pbmcgdG8g
aGl0IHRoaXMgY29kZSB3aXRoIGFsbCB0eXBlcyBvZiBzdHJ1Y3R1cmVzPw0KPiA+IA0KPiA+IElm
IHRoZXJlJ3JlIG90aGVyIGNhc2VzIHdoaWNoIGxlYWQgdG8gNC1ieXRlIGFsaWduZWQgImF0b21p
YzY0X3QiIHZhcmlhYmxlcw0KPiA+IHRoZXJlIHdpbGwgYmUgYSBwcm9ibGVtIGFzIHdlbGwgYnV0
IGl0J3MgcXVpdGUgaGFyZCB0byBwcmVkaWN0IHRob3NlIGNhc2VzLg0KPiA+IFRoYXQgc2FpZCBp
ZiB3ZSBtYW5hZ2UgdG8gcmVwcm9kdWNlIG1vcmUgc2ltaWxhciBpc3N1ZXMgdGhlcmUgd2lsbCBi
ZSBtb3JlDQo+ID4gcGF0Y2hlcyB3aXRoIGZpeGVzIDopDQo+ID4gDQo+ID4gPiBXaGF0IGhhcHBl
bnMgd2hlbiB5b3UgZG8gaGF2ZSBhbiB1bmFsaWduZWQgYWNjZXNzPw0KPiA+IA0KPiA+IEF0b21p
YyBpbnN0cnVjdGlvbnMgYXJlIGEgYml0IHNwZWNpYWwgYXMgY29tcGFyZWQgdG8gbm9ybWFsIGxv
YWRzIGFuZCBzdG9yZXMuDQo+ID4gRXZlbiBpZiBub3JtYWwgbG9hZHMgYW5kIHN0b3JlcyBtYXkg
ZGVhbCB3aXRoIHVuYWxpZ25lZCBkYXRhIGF0b21pYyBpbnN0cnVjdGlvbnMNCj4gPiBzdGlsbCBy
ZXF1aXJlIGRhdGEgdG8gYmUgYWxpZ25lZCBiZWNhdXNlIGl0J3MgaGFyZCB0byBtYW5hZ2UgYXRv
bWljIHZhbHVlIHRoYXQNCj4gPiBzcGFucyB0aHJvdWdoIG11bHRpcGxlIGNhY2hlIGxpbmVzIG9y
IGV2ZW4gTU1VIHBhZ2VzLiBBbmQgaGFyZHdhcmUganVzdA0KPiA+IHJhaXNlcyBhbiBhbGlnbm1l
bnQgZmF1bHQgZXhjZXB0aW9uLg0KPiA+IA0KPiA+IEFuZCB0aGF0J3Mgbm90IHNvbWV0aGluZyBz
cGVjaWFsIGZvciBBUkMsIEkgZ3Vlc3MgYWxsIENQVXMgYXJlIHRoZSBzYW1lIGluDQo+ID4gdGhh
dCByZWdhcmQsIHNlZSBoZXJlJ3MgYW4gZXh0cmFjdCBmcm9tIEFSTShyKSBBcmNoaXRlY3R1cmUg
UmVmZXJlbmNlDQo+ID4gTWFudWFsIEFSTXY3LUEgYW5kIEFSTXY3LVIgZWRpdGlvbjogaHR0cHM6
Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sa21sLm9yZ19s
a21sXzIwMTdfMTJfNV80NDAmZD1Ed0lCQWcmYz1EUEw2X1hfNkprWEZ4N0FYV3ENCj4gPiBCMHRn
JnI9bHFkZWVTU0VlczBHRkREbDY1NmVWaVhPN2JyZVM1NXl0V2tocGs1UjgxSSZtPWVUMU9VWFFF
dDZ6bEEwYkFCd2RJN3NGcjdIeXMzYUh6b0NYVERBa002eFkmcz0tM25fWHVybTREMlRJQy1fR19H
SXZHajlQXzN1bm1xODM5b0dBVExFNVcwJmU9DQo+ID4gRnJvbSAiVGFibGUgQTMtMSBBbGlnbm1l
bnQgcmVxdWlyZW1lbnRzIG9mIGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb25zIg0KPiA+IGl0J3Mgc2Vl
biB0aGF0IExEUkVYRCwgU1RSRVhEIGluc3RydWN0aW9ucyB3aWxsIGNhdXNlIGFsaWdubWVudCBm
YXVsdA0KPiA+IGV2ZW4gaWYgU0NUTFIuQT0wIChzdHJpY3QgYWxpZ25tZW50IGZhdWx0IGNoZWNr
aW5nIGRpc2FibGVkKSBmb3Igbm9uDQo+ID4gZG91YmxlLXdvcmQtYWxpZ25lZCBkYXRhLg0KPiAN
Cj4gVGhhbmtzIGZvciB0aGUgYmV0dGVyIGV4cGxhaW5hdGlvbiwgdGhhdCBoZWxwcyBvdXQgYSBs
b3QuICBDYW4geW91IHJlZG8NCj4gdGhlIHBhdGNoIHdpdGggYWxsIG9mIHRoYXQgaW5mb3JtYXRp
b24gc28gdGhhdCBvdGhlcnMgZG8gbm90IGhhdmUgdGhlDQo+IHNhbWUgcXVlc3Rpb25zIGFzIEkg
ZGlkPw0KDQpTdXJlIHdpbGwgZG8gaXQgc29vbmlzaC4NCg0KLUFsZXhleQ==
