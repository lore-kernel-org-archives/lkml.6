Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B39DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB72E204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tu37uK8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB72E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJITkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:40:31 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:60400 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJITkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:40:31 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 81A3310C0C0E;
        Tue,  9 Oct 2018 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539087828; bh=A/bD8YO8uTHvoG/xFfMOgMMZuxk8z1CcByZwQEmlTyE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Tu37uK8uS2ICLR4k5T/ZSZbOzOFsnegxoKs7Yh2N9DKxDCBDT32vD5TJcUl1huSiM
         jt2QYpO/yVLKsb6kD999PGk3guiAH7g/b5prPN9nQE5c7joELYlpvIGxmFc86O0arI
         B+gqWYm9mCx2PSWvx1f49E5AktrSaEoNjPjYfWoTB0ZEDchPxmaNT02UWTVj1O3Yr1
         h2cbgnWR8IuCDiMvLKgnrdLXTKqPZdfor8d4xWawCAVUmBle3GGkFm3Sk408RbYlRq
         sfNyyPQ1NuJafHGGan5VxyuadpCptS1rrGTlo8rzPW8K8ruXv2RRJ7x3Xow10Jacxi
         jHFfzZEV4IDSA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7520456FA;
        Tue,  9 Oct 2018 05:23:48 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 9 Oct 2018 05:23:22 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 9 Oct 2018 14:23:19 +0200
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: IOC: panic if kernel was started with previously
 enabled IOC
Thread-Topic: [PATCH] ARC: IOC: panic if kernel was started with previously
 enabled IOC
Thread-Index: AQHUW+PkXTieEhWAekSeARFpoqVELKUWvGkA
Date:   Tue, 9 Oct 2018 12:23:18 +0000
Message-ID: <1539087798.23085.29.camel@synopsys.com>
References: <20181004131212.16405-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B09B9EF@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B09B9EF@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6759588056C2A6438C6DCE8694BE0D74@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTA1IGF0IDIyOjU2ICswMDAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDEwLzA0LzIwMTggMDY6MTIgQU0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gPiAgDQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL21tL2NhY2hlLmMgYi9hcmNoL2FyYy9tbS9jYWNoZS5j
DQo+ID4gaW5kZXggZjI3MDFjMTNhNjZiLi5lZTdiNjNlOWM1ZTMgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9hcmMvbW0vY2FjaGUuYw0KPiA+ICsrKyBiL2FyY2gvYXJjL21tL2NhY2hlLmMNCj4gPiBA
QCAtMTE0NCw2ICsxMTQ0LDI1IEBAIG5vaW5saW5lIHZvaWQgX19pbml0IGFyY19pb2Nfc2V0dXAo
dm9pZCkNCj4gPiAgew0KPiA+ICAJdW5zaWduZWQgaW50IGlvY19iYXNlLCBtZW1fc3o7DQo+ID4g
IA0KPiA+ICsJLyoNCj4gPiArCSAqIERpc2FibGluZyBhbmQgcmVjb25maWd1cmluZyBvZiBJT0Mg
YXJlIHF1aXRlIGEgdHJpY2t5IGFjdGlvbnMgYmVjYXVzZQ0KPiA+ICsJICogbm9ib2R5IGtub3dz
IHdoYXQgaGFwcGVucyBpZiB0aGVyZSdyZSBJT0MtYWhuZGxlZCB0YXJuc2FjdGlvbnMgaW4NCj4g
PiArCSAqIGZsaWdodCB3aGVuIHdlJ3JlIGRpc2FibGluZyBJT0MuDQo+ID4gKwkgKg0KPiA+ICsJ
ICogQW5kIHRoZSBwcm9ibGVtIGlzIGV4dGVybmFsIERNQSBtYXN0ZXJzIFt0aGF0IHdlcmUgaW5p
dGlhbGl6ZWQgYW5kDQo+ID4gKwkgKiBzZXQgaW4gYSBib290bGFvZGVyIHRoYXQgd2FzIGV4ZWN1
dGVkIGJlZm9yZSB3ZSBnb3QgaGVyZV0gbWlnaHQNCj4gPiArCSAqIGNvbnRpbnVlIHRvIHNlbmQg
ZGF0YSB0byBtZW1vcnkgZXZlbiBhdCB0aGlzIHBvaW50IGFuZCB3ZSBoYXZlDQo+ID4gKwkgKiBu
byB3YXkgdG8gcHJldmVudCB0aGF0Lg0KPiA+ICsJICoNCj4gPiArCSAqIFRoYXQgc2FpZCBpdCdz
IG11Y2ggc2FmZXIgdG8gbm90IGVuYWJsZSBJT0MgYXQgYWxsIGFueXdoZXJlIGJlZm9yZQ0KPiA+
ICsJICogTGludXgga2VybmVsLg0KPiA+ICsJICovDQo+ID4gKwlpZiAocmVhZF9hdXhfcmVnKEFS
Q19SRUdfSU9fQ09IX0VOQUJMRSkgJiBBUkNfSU9fQ09IX0VOQUJMRV9CSVQpDQo+ID4gKwkJcGFu
aWMoImtlcm5lbCB3YXMgc3RhcnRlZCB3aXRoIHByZXZpb3VzbHkgZW5hYmxlZCBJT0MhXG4iKTsN
Cj4gDQo+IFdoaWxlIEkgdW5kZXJzdGFuZCB0aGUgbmVlZHMsIHRoaXMgc2VlbXMgZXhjZXNzaXZl
LCBzaG91bGQgd2Ugd2FybSB0aGUgdXNlciwNCj4gaW5zdGVhZCBvZiBwYW5pYyA/IERpZCB5b3Ug
cnVuIGludG8gc3BlY2lmaWMgaXNzdWUgdG8gd2FycmFudCB0aGlzICENCg0KWWVzIHdlJ3ZlIHJ1
biBpbnRvIHRoaXMuDQpSZW1lbWJlciwgd2UgaGF2ZSBJT0MgZGlzYWJsZWQgKGFjdHVhbGx5ICdu
b3QgZW5hYmxlZCcpIGluIG1vc3Qgb2YgSFNESyBsaW51eCBkZW1vcw0KKGh0dHBzOi8vZ2l0aHVi
LmNvbS9mb3NzLWZvci1zeW5vcHN5cy1kd2MtYXJjLXByb2Nlc3NvcnMvYnVpbGRyb290LWRlbW9z
L3JlbGVhc2VzKQ0KDQpTbyB3ZSBmYWNlZCBzZXZlcmFsIHRpbWVzIHRoYXQgdGhpcyBkZW1vcyBj
cmFzaGVzIGRpZmZlcmVudCB3ZWlyZCB3YXlzIHdoZW4gd2UNCmFjY2lkZW50YWxseSBsYXVuY2gg
dGhlbSB1c2luZyBvbGQgdS1ib290ICh3aGljaCBlbmFibGVzIElPQyBieSBkZWZhdWx0ISkNCg0K
QXMgd2UgZG9uJ3Qgd2FudCB0byBmb3JjaWJseSBkaXNhYmxlIElPQyBkdXJpbmcgbGludXggbGF1
bmNoDQooaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvMS8xOS81NTcpIA0KSSBndWVzcyBwYW5p
YyBpcyB3aGF0IHdlIG5lZWQgaGVyZS4NCg0KPiBPVE9IIGluIHJlY2VudCBwYXN0IG1vcmUgdGhh
biAxIHBlcnNvbiByYW4gaW50byBzb21lIGhzZGsgdWJvb3Qgc2hlbmFuaWdhbnMsIHdoZXJlDQo+
IHdlIGhhZCB0byB1cGdyYWRlIHRoZSB1Ym9vdCB0byBnZXQgaXQgd29ya2luZyB3aXRoIHByZWJ1
aXQgaW1hZ2VzIC0gaXMgdGhhdCB3aGF0DQo+IHlvdSBhcmUgdHJ5aW5nIHRvIHByZXZlbnQgaGVy
ZSAtIHBhbmljIGVhcmx5IGluc3RlYWQgb2YgcmFuZG9tIHVzZXIgZXJyb3JzIC8gaGFuZ3MNCj4g
bGF0ZXIgPw0KDQpZZXMsIEkgcHJlZmVyIHRvIHBhbmljIGVhcmx5IGluc3RlYWQgb2YgcmFuZG9t
IGVycm9ycyAvIGNyYXNoZXMgbGF0ZXIuDQpUaGUgcHJvYmxlbSB3aXRoIHdhcm5pbmcgaGVyZSBp
cyB0aGF0IGl0IGlzbid0IHZlcnkgY2xlYXIgLyBlYXN5IHRvIG1hdGNoIHdhcm5pbmcNCm1lc3Nh
Z2Ugd2l0aCBzb21lIHJhbmRvbSBlcnJvci4NCg0KPiAtVmluZWV0DQotLSANCiBFdWdlbml5IFBh
bHRzZXY=
