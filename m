Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA5DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B362087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TGLpmI+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B362087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbeGIGq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:46:57 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39831 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeGIGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:46:53 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C1C6624E2324;
        Sun,  8 Jul 2018 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531118812; bh=5ThOsbE0vMQdI86cBZj3MxWo9f35z/IGArf4WTGG2Wc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TGLpmI+RYCIBhrP2IdrQHOYD0ybDtV3JCVQ8K8jX4tIgT0SxpYuwk+8vpofVex5Ec
         RvLygw8tBZ0xQHbEnCfbInQGpLEmnU9rmQUOCpZYj8q56ba8AoEbLs8cmjfNOZEj1r
         kotsR49OkzfvtropTFLnHKpaRPiKTGS+Ew/cc6ZaBWvBQt1exbuIEAotFsY1k9neEw
         UDAjP1AVbgyziTPgWjA7dyoRURoybzZu5ODmbwuPtgxobZftVDwsK7gMlGNkcjx3yo
         a546bGI8wC+dIPHs8RlMuwem5B3h8vgcO00dRgx2Qbe/uf7MOSAsdoEUEOhsrOpPbk
         WlJGUXLoCc/UQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7660F5084;
        Sun,  8 Jul 2018 23:46:52 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Sun, 8 Jul 2018 23:46:52 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 08:46:50 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "greg@kroah.com" <greg@kroah.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz+a+E6GQfxV7UuzGYUzCAFtDqSGQPUAgAAQPAA=
Date:   Mon, 9 Jul 2018 06:46:50 +0000
Message-ID: <1d34b6addd98c3219f902e0dc0c2922309e1de93.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <20180709054842.GB7618@kroah.com>
In-Reply-To: <20180709054842.GB7618@kroah.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2978DF69C2E7CB40AA3E1F5D269194CD@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KT24gTW9uLCAyMDE4LTA3LTA5IGF0IDA3OjQ4ICswMjAwLCBHcmVnIEtIIHdy
b3RlOg0KPiBPbiBNb24sIEp1bCAwOSwgMjAxOCBhdCAwNzo0NDo0NEFNICswMzAwLCBBbGV4ZXkg
QnJvZGtpbiB3cm90ZToNCj4gPiBEZXBlbmRpbmcgb24gQUJJICJsb25nIGxvbmciIHR5cGUgb2Yg
YSBwYXJ0aWN1bGFyIDMyLWJpdCBDUFUNCj4gPiBtaWdodCBiZSBhbGlnbmVkIGJ5IGVpdGhlciB3
b3JkICgzMi1iaXRzKSBvciBkb3VibGUgd29yZCAoNjQtYml0cykuDQo+ID4gTWFrZSBzdXJlICJk
YXRhIiBpcyByZWFsbHkgNjQtYml0IGFsaWduZWQgZm9yIGFueSAzMi1iaXQgQ1BVLg0KPiA+IA0K
PiA+IEF0IGxlYXN0IGZvciAzMi1iaXQgQVJDIGNvcmVzIEFCSSByZXF1aXJlcyAibG9uZyBsb25n
IiB0eXBlcw0KPiA+IHRvIGJlIGFsaWduZWQgYnkgbm9ybWFsIDMyLWJpdCB3b3JkLiBUaGlzIG1h
a2VzICJkYXRhIiBmaWVsZCBhbGlnbmVkIHRvDQo+ID4gMTIgYnl0ZXMuIFdoaWNoIGlzIHN0aWxs
IE9LIGFzIGxvbmcgYXMgd2UgdXNlIDMyLWJpdCBkYXRhIG9ubHkuDQo+ID4gDQo+ID4gQnV0IG9u
Y2Ugd2Ugd2FudCB0byB1c2UgbmF0aXZlIGF0b21pYzY0X3QgdHlwZSAoaS5lLiB3aGVuIHdlIHVz
ZSBzcGVjaWFsDQo+ID4gaW5zdHJ1Y3Rpb25zIExMT0NLRC9TQ09OREQgZm9yIGFjY2Vzc2luZyA2
NC1iaXQgZGF0YSkgd2UgZWFzaWx5IGhpdA0KPiA+IG1pc2FsaWduZWQgYWNjZXNzIGV4Y2VwdGlv
bi4NCj4gDQo+IFNvIGlzIHRoaXMgc29tZXRoaW5nIHlvdSBoaXQgdG9kYXk/ICBJZiBub3QsIHdo
eSBpcyB0aGlzIG5lZWRlZCBmb3INCj4gc3RhYmxlIGtlcm5lbHM/DQoNCkluZGVlZCB3ZSBoaXQg
dGhhdCBwcm9ibGVtIHJlY2VudGx5IHdoZW4gRXRuYXZpdiBkcml2ZXIgd2FzIHN3aXRjaGVkIHRv
DQpEUk0gR1BVIHNjaGVkdWxlciwgc2VlDQpjb21taXQgZTkzYjZkZWViNDVhICgiZHJtL2V0bmF2
aXY6IGhvb2sgdXAgRFJNIEdQVSBzY2hlZHVsZXIiKS4NClRoZSBtb3N0IGltcG9ydGFudCBwYXJ0
IG9mIERSTSBHUFUgc2NoZWR1bGVyIGlzICJqb2JfaWRfY291bnQiIG1lbWJlciBvZg0KImRybV9n
cHVfc2NoZWR1bGVyIiBzdHJ1Y3R1cmUgb2YgdHlwZSAiYXRvbWljNjRfdCIuIFRoaXMgc3RydWN0
dXJlIGlzIHB1dA0KaW4gYSBidWZmZXIgYWxsb2NhdGVkIGJ5IGRldm1fa3phbGxvYygpIGFuZCBp
ZiAiam9iX2lkX2NvdW50IiBpcyBub3QgNjQtYml0DQphbGlnbmVkIGF0b21pYyBpbnN0cnVjdGlv
biBmYWlscyB3aXRoIGFuIGV4Y2VwdGlvbi4NCg0KQXMgZm9yIHN0YWJsZSByZXF1aXJlbWVudHMg
LSBtZW50aW9uZWQgY29tbWl0IHdhcyBhIHBhcnQgb2YgNC4xNyBrZXJuZWwNCndoaWNoIGJyb2tl
IEdQVSBkcml2ZXIgZm9yIG9uZSBvZiBvdXIgSFNESyBib2FyZCBzbyBJIGd1ZXNzIGJhY2stcG9y
dGluZw0KdG8gNC4xNyBpcyBhIG5vLWJyYWluZXIuDQoNCk5vdyBnaXZlbiBhIG5hdHVyZSBvZiB0
aGUgcHJvYmxlbSBhdCBoYW5kIEkgbWF5IGV4cGVjdCBvdGhlciBicmVha2FnZXMNCndoZW5ldmVy
IGFub3RoZXIgZHJpdmVyL2ZzIGV0YyB0aGF0IHVzZSAiYXRvbWljNjRfdCIgZ2V0cyBlbmFibGVk
Lg0KDQo+ID4gVGhhdCdzIGJlY2F1c2UgZXZlbiBvbiBDUFVzIGNhcGFibGUgb2Ygbm9uLWFsaWdu
ZWQgZGF0YSBhY2Nlc3MgTEwvU0MNCj4gPiBpbnN0cnVjdGlvbnMgcmVxdWlyZSBzdHJpY3QgYWxp
Z25tZW50Lg0KPiANCj4gQXJlIHlvdSBnb2luZyB0byBoaXQgdGhpcyBjb2RlIHdpdGggYWxsIHR5
cGVzIG9mIHN0cnVjdHVyZXM/DQoNCklmIHRoZXJlJ3JlIG90aGVyIGNhc2VzIHdoaWNoIGxlYWQg
dG8gNC1ieXRlIGFsaWduZWQgImF0b21pYzY0X3QiIHZhcmlhYmxlcw0KdGhlcmUgd2lsbCBiZSBh
IHByb2JsZW0gYXMgd2VsbCBidXQgaXQncyBxdWl0ZSBoYXJkIHRvIHByZWRpY3QgdGhvc2UgY2Fz
ZXMuDQpUaGF0IHNhaWQgaWYgd2UgbWFuYWdlIHRvIHJlcHJvZHVjZSBtb3JlIHNpbWlsYXIgaXNz
dWVzIHRoZXJlIHdpbGwgYmUgbW9yZQ0KcGF0Y2hlcyB3aXRoIGZpeGVzIDopDQoNCj4gV2hhdCBo
YXBwZW5zIHdoZW4geW91IGRvIGhhdmUgYW4gdW5hbGlnbmVkIGFjY2Vzcz8NCg0KQXRvbWljIGlu
c3RydWN0aW9ucyBhcmUgYSBiaXQgc3BlY2lhbCBhcyBjb21wYXJlZCB0byBub3JtYWwgbG9hZHMg
YW5kIHN0b3Jlcy4NCkV2ZW4gaWYgbm9ybWFsIGxvYWRzIGFuZCBzdG9yZXMgbWF5IGRlYWwgd2l0
aCB1bmFsaWduZWQgZGF0YSBhdG9taWMgaW5zdHJ1Y3Rpb25zDQpzdGlsbCByZXF1aXJlIGRhdGEg
dG8gYmUgYWxpZ25lZCBiZWNhdXNlIGl0J3MgaGFyZCB0byBtYW5hZ2UgYXRvbWljIHZhbHVlIHRo
YXQNCnNwYW5zIHRocm91Z2ggbXVsdGlwbGUgY2FjaGUgbGluZXMgb3IgZXZlbiBNTVUgcGFnZXMu
IEFuZCBoYXJkd2FyZSBqdXN0DQpyYWlzZXMgYW4gYWxpZ25tZW50IGZhdWx0IGV4Y2VwdGlvbi4N
Cg0KQW5kIHRoYXQncyBub3Qgc29tZXRoaW5nIHNwZWNpYWwgZm9yIEFSQywgSSBndWVzcyBhbGwg
Q1BVcyBhcmUgdGhlIHNhbWUgaW4NCnRoYXQgcmVnYXJkLCBzZWUgaGVyZSdzIGFuIGV4dHJhY3Qg
ZnJvbSBBUk0ocikgQXJjaGl0ZWN0dXJlIFJlZmVyZW5jZQ0KTWFudWFsIEFSTXY3LUEgYW5kIEFS
TXY3LVIgZWRpdGlvbjogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTcvMTIvNS80NDANCkZyb20g
IlRhYmxlIEEzLTEgQWxpZ25tZW50IHJlcXVpcmVtZW50cyBvZiBsb2FkL3N0b3JlIGluc3RydWN0
aW9ucyINCml0J3Mgc2VlbiB0aGF0IExEUkVYRCwgU1RSRVhEIGluc3RydWN0aW9ucyB3aWxsIGNh
dXNlIGFsaWdubWVudCBmYXVsdA0KZXZlbiBpZiBTQ1RMUi5BPTAgKHN0cmljdCBhbGlnbm1lbnQg
ZmF1bHQgY2hlY2tpbmcgZGlzYWJsZWQpIGZvciBub24NCmRvdWJsZS13b3JkLWFsaWduZWQgZGF0
YS4NCg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhleSBCcm9ka2luIDxhYnJvZGtpbkBz
eW5vcHN5cy5jb20+DQo+ID4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+DQo+IA0KPiBZb3UgZGlkbid0IGNjOiB0aGlzIGFkZHJlc3MgOigNCg0KU29y
cnksIHdoaWNoIG9uZT8NClRoYXQgd2hhdCBJIGhhdmUgaW4gLm1ib3gsIHNlZSBodHRwczovL3Bh
dGNod29yay5vemxhYnMub3JnL3BhdGNoLzk0MTA5Mi9tYm94LzoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDYzogbGludXgt
YXJjaEB2Z2VyLmtlcm5lbC5vcmcsIEdyZWcgS0ggPGdyZWdAa3JvYWguY29tPiwNCiBBbGV4ZXkg
QnJvZGtpbiA8QWxleGV5LkJyb2RraW5Ac3lub3BzeXMuY29tPiwgc3RhYmxlQHZnZXIua2VybmVs
Lm9yZywgDQogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4s
DQogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+LCBsaW51eC1zbnBzLWFyY0Bs
aXN0cy5pbmZyYWRlYWQub3JnDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQotQWxleGV5
