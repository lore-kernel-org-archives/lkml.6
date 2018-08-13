Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2125BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FF12175A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aLhDBd/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FF12175A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeHMUKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:10:32 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:57706 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbeHMUKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:10:32 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3E11524E0461;
        Mon, 13 Aug 2018 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534181243; bh=TsSOg2bsRTxfZWc6F+DBNezLSPUwyaoGVNSSfntiVpo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aLhDBd/5KyXN+79mQoN0NUkkr3NI6FybLZBS0lPjEdz+ZM6Jj08VGHbFHQKRcykSH
         oo+h3FMU9MvYORlKZB4V4Zla9PgPfur/VHG9MA6QOeqB9h4obwQOBqfwpaalv0MAR5
         TUDG3u7b9V5pwMA9P3f2DXtu0m6xTqEDr4AOUS69AmpKJ2TEr2cYBM+BuIZKBg0Aqk
         J82HAi55wj91qZo8fv9vDamXCEX0i6CW9mSO2RjD/bVscZZxu65i0WAl7RRuffCOkr
         DXxgmiSBE1xSF0lwBQmLqKJZGeX/sfG0WCWuF59pN5zQjU2O7AD0/KfjX2ivXc2U/a
         /1IYHERHOqJ8g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 22AD537D8;
        Mon, 13 Aug 2018 10:27:23 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 13 Aug 2018 10:27:23 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 13 Aug 2018 19:27:20 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Vineet Gupta" <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Topic: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Index: AQHUKCIbvKCcbW9tAUCYTpMlngwMd6S94/kA
Date:   Mon, 13 Aug 2018 17:27:19 +0000
Message-ID: <1534181238.3962.74.camel@synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B08C82C@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B08C82C@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C497C2DABB9640469AD926314E933D00@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA4LTEzIGF0IDE2OjE5ICswMDAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDA3LzMwLzIwMTggMDk6MjYgQU0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gPiBUaGUg
QVJDIEhTIHByb2Nlc3NvciBwcm92aWRlcyBhbiBJT0MgcG9ydCAoSS9PIGNvaGVyZW5jeSBidXMN
Cj4gPiBpbnRlcmZhY2UpIHRoYXQgYWxsb3dzIGV4dGVybmFsIGRldmljZXMgc3VjaCBhcyBETUEg
ZGV2aWNlcw0KPiA+IHRvIGFjY2VzcyBtZW1vcnkgdGhyb3VnaCB0aGUgY2FjaGUgaGllcmFyY2h5
LCBwcm92aWRpbmcNCj4gPiBjb2hlcmVuY3kgYmV0d2VlbiBJL08gdHJhbnNhY3Rpb25zIGFuZCB0
aGUgY29tcGxldGUgbWVtb3J5DQo+ID4gaGllcmFyY2h5Lg0KPiANCj4gWW91IGRpZG4ndCBwYXkg
YXR0ZW50aW9uIHRvIG15IHByZXZpb3VzIGNvbW1lbnQgb24gdGhpcyAhDQo+IElPQyBwb3J0IGNh
biBiZSBjb25zaWRlcmVkIGEgbWljcm8tYXJjaGl0ZWN0dXJlIG9wdGltaXphdGlvbiAoYW4gaW1w
b3J0YW50IG9uZQ0KPiB0aG91Z2gpLiBUaGUgbWFpbiB0aGluZyBpcyBoYXJkd2FyZSBzbm9vcGlu
ZyBETUEgdHJhbnNhY3Rpb25zIHdoaWNoIGVuYWJsZWQgSU9DIGluDQo+IGZpcnN0IHBsYWNlLg0K
DQpPaywgSSdsbCByZXdyaXRlIHRoaXMgY29tbWl0IG1lc3NhZ2UuDQoNCj4gPiBTb21lIHJlY2Vu
dCBTb0Mgd2l0aCBBUkMgSFMgKGxpa2UgSFNESykgYWxsb3cgdG8gc2VsZWN0IGJ1cw0KPiA+IHBv
cnQgKElPQyBvciBub24tSU9DIHBvcnQpIGZvciBjb25uZWN0aW5nIERNQSBkZXZpY2VzIGluIHJ1
bnRpbWUuDQo+IA0KPiBBZ2FpbiB5b3UgbWVudGlvbiB0aGUgcG9ydCBidXQgbm9uZSBvZiB5b3Vy
IDQgcGF0Y2hlcyBhY3R1YWxseSB0b3VjaCB0aGUgcG9ydA0KPiBpdHNlbGYgaW4gcHJvZ3JhbW1p
bmcgaXQuDQoNCk9rLg0KDQo+IA0KPiA+IFdpdGggdGhpcyBwYXRjaCB3ZSBjYW4gdXNlIGJvdGgg
SFctY29oZXJlbnQgYW5kIHJlZ3VsYXIgRE1BDQo+ID4gcGVyaXBoZXJhbHMgc2ltdWx0YW5lb3Vz
bHkuDQo+ID4gDQo+ID4gTk9URToNCj4gPiBUaGlzIHBhdGNoIHNlcmllcyB3YXMgc3RyZXNzIHRl
c3RlZCBvbiBIU0RLIHdpdGggaXBlcmYzIChldGhlcm5ldCkNCj4gPiBhbmQgYm9uaWUrKyAodXNi
IGFuZCBzZGlvKSBpbiB0aHJlZSBjb25maWd1cmF0aW9uczoNCj4gPiAgKiBJT0MgZW5hYmxlZCBn
bG9iYWx5DQo+ID4gICogSU9DIGRpc2FibGVkIGdsb2JhbHkNCj4gPiAgKiBJT0MgZW5hYmxlZCBw
YXJ0aWFsbHkgKFVTQiAmIFNESU8gYXJlIGNvbm5lY3RlZCB2aWEgSU9DIEFYSSBwb3J0LA0KPiA+
ICAgIGV0aGVybmV0IGlzIGNvbm5lY3RlZCB0byBERFIgQVhJIHBvcnQgKG5vbi1JT0MgcG9ydCkg
DQo+ID4gDQo+ID4gTk9URToNCj4gPiBJZiB5b3Ugd2FudCB0byB0ZXN0IHNvbWUgZGV2aWNlIHdp
dGhvdXQgSU9DIGl0IGlzIG5vdCBlbm91Z2gNCj4gPiB0byByZW1vdmUgImRtYS1jb2hlcmVudCIg
cHJvcGVydHkgZnJvbSBkdHMuIFlvdSBoYWQgdG8gcmVtYXAgdGhpcw0KPiA+IGRldmljZSB0byBy
ZWd1bGFyIEREUiBBWEkgcG9ydCBpbnRlYWQgb2YgSU9DIEFYSSBwb3J0Lg0KPiANCj4gV2h5IGFy
ZSB3ZSBub3QgZG9pbmcgdGhhdCBmb3IgdGhlIEdQVSBhcyBwYXJ0IG9mIHRoaXMgc2VyaWVzLg0K
DQpXZSBzdGlsbCBuZWVkIHRvIHVwc3RyZWFtIGNvdXBsZSBvZiBtaW5vciBjaGFuZ2VzIGluIFZp
dmFudGUgZHJpdmVyIGJlZm9yZSBlbmFibGUNCml0IGZvciBIU0RLLg0KDQo+IA0KPiA+IFlvdSBh
bHNvIG5lZWQgdG8gYXBwbHkgMyBmb2xsb3dpbmcgcGF0Y2hlcyBmaXJzdGx5Og0KPiA+IGh0dHBz
Oi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vbGludXgtc25wcy1hcmNAbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tc2cwMzg2NS5odG1sDQo+ID4gaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9saW51eC1z
bnBzLWFyY0BsaXN0cy5pbmZyYWRlYWQub3JnL21zZzAzODg5Lmh0bWwNCj4gPiBodHRwczovL3d3
dy5tYWlsLWFyY2hpdmUuY29tL2xpbnV4LXNucHMtYXJjQGxpc3RzLmluZnJhZGVhZC5vcmcvbXNn
MDM4ODcuaHRtbA0KPiA+IA0KPiA+IE5PVEU6DQo+ID4gV2UgZG9uJ3QgdG91Y2ggYW55IGFwZXJ0
dXJlIGNvbmZpZ3VyYXRpb24gaW4gdGhpcyBwYXRjaCBzZXJpZXMuIFNvIHdlDQo+ID4gZG9uJ3Qg
c3dpdGNoIGFueSBkZXZpY2VzIGJldHdlZW4gSU9DIGFuZCBub24tSU9DIEFYSSBwb3J0cyBvbiBh
bnkgYm9hcmQuDQo+ID4gSXQgY2FuIGJlIGRvbmUgbGF0ZXIgaWYgaXQgaXMgcmVxdWlyZWQuDQo+
ID4gDQo+ID4gQ2hhbmdlcyB2MS0+djIgKFRoYW5rcyB0byBDaHJpc3RvcGgpOg0KPiA+ICAqIERv
bid0IHNlbGVjdCBETUFfRElSRUNUX09QUyBleHBsaWNpdGx5IGFzIGl0IGlzIGFscmVhZHkgc2Vs
ZWN0ZWQgYnkNCj4gPiAgICBETUFfTk9OQ09IRVJFTlRfT1BTDQo+ID4gICogUmVtb3ZlIGNoZWNr
IGZvciBISUdITUVNIHBhZ2VzIGZyb20gYXJjaF9kbWFfe2FsbG9jLCBmcmVlfQ0KPiA+IA0KPiA+
IEV1Z2VuaXkgUGFsdHNldiAoNCk6DQo+ID4gICBBUkM6IERUUzogbWFyayBETUEgZGV2aWNlcyBj
b25uZWN0ZWQgdGhyb3VnaCBJT0MgcG9ydCBhcyBkbWEtY29oZXJlbnQNCj4gPiAgIEFSQzogYWxs
b3cgdG8gdXNlIElPQyBhbmQgbm9uLUlPQyBETUEgZGV2aWNlcyBzaW11bHRhbmVvdXNseQ0KPiA+
ICAgQVJDOiBJT0M6IHBhbmljIGlmIGJvdGggSU9DIGFuZCBaT05FX0hJR0hNRU0gZW5hYmxlZA0K
PiA+ICAgQVJDOiBkb24ndCBjaGVjayBmb3IgSElHSE1FTSBwYWdlcyBpbiBhcmNoX2RtYV9hbGxv
Yw0KPiA+IA0KPiA+ICBhcmNoL2FyYy9ib290L2R0cy9heGMwMDMuZHRzaSAgICAgIHwgMjYgKysr
KysrKysrKysrKysrKw0KPiA+ICBhcmNoL2FyYy9ib290L2R0cy9heGMwMDNfaWR1LmR0c2kgIHwg
MjYgKysrKysrKysrKysrKysrKw0KPiA+ICBhcmNoL2FyYy9ib290L2R0cy9oc2RrLmR0cyAgICAg
ICAgIHwgIDQgKysrDQo+ID4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggfCAx
MyArKysrKysrKw0KPiA+ICBhcmNoL2FyYy9tbS9jYWNoZS5jICAgICAgICAgICAgICAgIHwgMzAg
KysrKysrKysrLS0tLS0tLS0tDQo+ID4gIGFyY2gvYXJjL21tL2RtYS5jICAgICAgICAgICAgICAg
ICAgfCA2MiArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICA2IGZp
bGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgNCj4gPiAN
Cj4gDQo+IA0KLS0gDQogRXVnZW5peSBQYWx0c2V2
