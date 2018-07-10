Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF69C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AE320840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Oz1jvacY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AE320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeGJGnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:43:04 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37641 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeGJGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:42:59 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C8A3A24E2515;
        Mon,  9 Jul 2018 23:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531204979; bh=4M6LkRgsUXGwvZ2hjWooK7bEBpwEDDce7o709yRC/fU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Oz1jvacY0BW2PafAfO5MhPH9udy8YWUW9Z2WOITkhOzwgcT0GZc6PtrtbvWbKSL4J
         JSraQwJk0w21qWsdLZic5ryr+oCFVb+faHRLIjBlbOg7Teo04HRi5VvmC38toFqlu7
         HQbvQ+jqMPJfkYgQXZIt1d2jsgUsqTQn1MRl7uxdMQz4kW+9pYHAFRaTQImF4vfTks
         nCGyk18gvLdqXoOc/34UtopxAQcfcpGnIZUDTVviDin1iXoQFdwrDDV4P9dAPHHXY6
         XlzuCZ1a5TzOwO5pQtHjVay57I4FjqZr2fJXCJgJYM4zqoJ6pa15sEZjBTBzBXlBnk
         OfEESPrWriavA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id A0A415C29;
        Mon,  9 Jul 2018 23:42:58 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 23:42:58 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 10 Jul 2018 08:42:56 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz+a+E6GQfxV7UuzGYUzCAFtDqSGew4AgAAL/YCAAAVTAIAAAX+AgACHG4CAAM13AA==
Date:   Tue, 10 Jul 2018 06:42:55 +0000
Message-ID: <f73763e1375693777cd6d95a2133a36618e9412d.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
         <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
         <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
         <82d2b36fa913bca6d56c7bf32a653324970817b8.camel@synopsys.com>
         <e98bd4ab-ea20-0b42-bda9-eae8a6030c8f@synopsys.com>
In-Reply-To: <e98bd4ab-ea20-0b42-bda9-eae8a6030c8f@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <85BF71212F3A5B47B6BDBEC3970980CA@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBNb24sIDIwMTgtMDctMDkgYXQgMTE6MjcgLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMDcvMDkvMjAxOCAwMzoyMyBBTSwgQWxleGV5IEJyb2RraW4gd3Jv
dGU6DQo+ID4gSGkgRGF2aWQsDQo+ID4gDQo+ID4gT24gTW9uLCAyMDE4LTA3LTA5IGF0IDEwOjE4
ICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gPiBGcm9tOiBBbGV4ZXkgQnJvZGtpbg0K
PiA+ID4gPiBTZW50OiAwOSBKdWx5IDIwMTggMTE6MDANCj4gPiA+IA0KPiA+ID4gLi4uDQo+ID4g
PiA+IFRoYXQncyBhIGdvb2QgaWRlYSBpbmRlZWQgYnV0IGl0IGRvZXNuJ3Qgc29sdmUgdGhlIHBy
b2JsZW0gd2l0aA0KPiA+ID4gPiBzdHJ1Y3QgZGV2cmVzX25vZGUuIENvbnNpZGVyIHRoZSBmb2xs
b3dpbmcgc25pcHBldDoNCj4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+
OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gCXN0cnVjdCBteXN0cnVj
dCB7DQo+ID4gPiA+IAkJYXRvbWljNjRfdCBteXZhcjsNCj4gPiA+ID4gCX0NCj4gPiA+ID4gDQo+
ID4gPiA+IAlzdHJ1Y3QgbXlzdHJ1Y3QgKnA7DQo+ID4gPiA+IAlwID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCpwKSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+IA0K
PiA+ID4gPiBIZXJlIG15dmFyIGFkZHJlc3Mgd2lsbCBtYXRjaCBhZGRyZXNzIG9mICJkYXRhIiBt
ZW1iZXIgb2Ygc3RydWN0IGRldnJlc19ub2RlLg0KPiA+ID4gPiBTbyBpZiAiZGF0YSIgaXMgaGFz
IG9mZnNldCBvZiAxMiBieXRlcyBmcm9tIHRoZSBiZWdpbm5pbmcgb2YgYSBwYWdlIHRoZW4NCj4g
PiA+ID4gbXl2YXIgd29uJ3QgYmUgNjQtYml0IGFsaWduZWQgcmVnYXJkbGVzcyBvZiBteXZhcidz
IGF0dHJpYnV0ZSwgcmlnaHQ/DQo+ID4gPiANCj4gPiA+IC4uLg0KPiA+ID4gPiA+ID4gLQl1bnNp
Z25lZCBsb25nIGxvbmcJCWRhdGFbXTsJLyogZ3VhcmFudGVlIHVsbCBhbGlnbm1lbnQgKi8NCj4g
PiA+IA0KPiA+ID4gQWhoLCB0aGF0IGxpbmUgc2hvdWxkIGJlOg0KPiA+ID4gCXU4IGRhdGFbXSBf
X2FsaWduZWQoOCk7IC8qIEd1YXJhbnRlZSA2NGJpdCBhbGlnbm1lbnQgKi8NCj4gPiANCj4gPiBB
bmQgdGhhdCBwcmV0dHkgbXVjaCB3aGF0IEkgc3VnZ2VzdGVkIGluIG15IGluaXRpYWwgcGF0Y2gg
OikNCj4gPiANCj4gPiBGb3IgdGhlIHJlY29yZCB4ODYgaGFzIGV4YWN0bHkgdGhlIHNhbWUgYXRv
bWljNjRfdCBhcyB5b3Ugc3VnZ2VzdGVkLA0KPiA+IHNlZSBodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2FyY2gveDg2L2luY2x1ZGUvYXNtL2F0b21pYzY0XzMy
LmgjTDEzOg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+IHR5cGVkZWYgc3RydWN0IHsNCj4gPiAJdTY0IF9fYWxpZ25lZCg4KSBjb3VudGVyOw0KPiA+
IH0gYXRvbWljNjRfdDsNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0t
LS0tLS0NCj4gDQo+IEFuZCBzbyBkb2VzIHRoZSBBUkMgdmVyc2lvbiBzaW5jZSB3aGVuIHRoZSBh
dG9taWM2NF90IHN1cHBvcnQgd2FzIGFkZGVkIGJ5IGNvbW1pdA0KPiBjZTYzNjUyNzBlY2QNCj4g
DQo+IEFsc28sIHlvdSBzaG91bGQgY29uc2lkZXIgdXNpbmcgdGhlIHByZS1jYW5uZWQgdHlwZSBh
bGlnbmVkX3U2NC4NCj4gDQo+IHR5cGVkZWYgc3RydWN0IHsNCj4gICAgICAgIGFsaWduZWRfdTY0
IGNvdW50ZXI7DQo+ICAgICAgICBeXl5eXl5eXl5eXg0KPiB9IGF0b21pYzY0X3Q7DQoNCkFzIFBl
dGVyIG1lbnRpb25lZCBlYXJsaWVyIGF0b21pYyBpcyBzaWduZWQsIHNlZToNCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1zbnBzLWFyYy8yMDE4LUp1bHkvMDA0MDMw
Lmh0bWwNCg0KU28gbG9va3MgbGlrZSB3ZSBuZWVkIHRoaXMgZml4IGZvciBBUkMgaW5zdGVhZDoN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2F0b21pYy5oIGIvYXJj
aC9hcmMvaW5jbHVkZS9hc20vYXRvbWljLmgNCmluZGV4IDExODU5Mjg3YzUyYS4uZWY5NGI3Mzcx
ZGU2IDEwMDY0NA0KLS0tIGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vYXRvbWljLmgNCisrKyBiL2Fy
Y2gvYXJjL2luY2x1ZGUvYXNtL2F0b21pYy5oDQpAQCAtMzY3LDcgKzM2Nyw3IEBAIEFUT01JQ19P
UFMoeG9yLCBePSwgQ1RPUF9JTlNUX0FYT1JfRElfUjJfUjJfUjMpDQogICovDQogDQogdHlwZWRl
ZiBzdHJ1Y3Qgew0KLSAgICAgICBhbGlnbmVkX3U2NCBjb3VudGVyOw0KKyAgICAgICBsb25nIGxv
bmcgX19hbGlnbmVkKDgpIGNvdW50ZXI7DQogfSBhdG9taWM2NF90Ow0KIA0KICNkZWZpbmUgQVRP
TUlDNjRfSU5JVChhKSB7IChhKSB9DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+
OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KLUFsZXhleQ==
