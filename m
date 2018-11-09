Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFD2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16CA2081D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16CA2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeKIMdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:33:08 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:51698 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeKIMdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:33:08 -0500
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: eiOkkG+bjm4C/AJNisyTuppzDtLdE3xte4RJwj+E2m208MOI8bNaGq0rIMHeJ
        eLGAFI9CaNjVX3iWZBAoEaeW/NhKjNmeuAJrulVNkFtEhGSCrb/1/ATxvNCu5xYlSa/i72M
        F+427Q8xt6+aPx2vh/mjTLV3q2pdyFpPfsuWwn2Q+oiQD0cJKyF2CFApsT10vrJx1O4tsUM
        v7gWfEEE98F9KQpyX4mjGlW1/PQga3zcMKVYSDPXZ0L5C75x4nBS3+GXW8KVn6cHvco3O2a
        TIFuTdjddLmAncxZr0A+5qe28=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1541732066t41419
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?TWlrZSBSYXBvcG9ydA==?=" <rppt@linux.ibm.com>,
        "=?utf-8?B?VGhvbWFzIEJvZ2VuZG9lcmZlcg==?=" <tbogendoerfer@suse.de>
Cc:     "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <jhogan@kernel.org>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?cnBwdA==?=" <rppt@linux.vnet.ibm.com>
Subject: Re: [[PATCH]] mips: Fix switch to NO_BOOTMEM for SGI-IP27/loongons3 NUMA
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 9 Nov 2018 10:54:26 +0800
X-Priority: 3
Message-ID: <tencent_4F1049E7045AD21E19098484@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20181108144428.28149-1-tbogendoerfer@suse.de>
        <20181108161823.GB15707@rapoport-lnx>
        <20181108175217.f55065d6115edbafd6aa3487@suse.de>
        <43783525-DEC2-46A5-A61E-4C3BF3DDE4A0@linux.ibm.com>
In-Reply-To: <43783525-DEC2-46A5-A61E-4C3BF3DDE4A0@linux.ibm.com>
X-QQ-ReplyHash: 3068284119
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Fri, 09 Nov 2018 10:54:29 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkl0IHNlZW1zIHRoZSBwYXRjaCBiZWxvdyBjYW4gc29sdmUgbWFueSBwcm9ibGVt
cyBhZnRlciBzd2l0Y2hlZCB0byBOT19CT09UTUVNLCBiZWNhdXNlIHRoZSBtZW1vcnkgYWxs
b2NhdGlvbiBiZWhhdmlvciBpcyBtb3JlIHNpbWlsYXIgYXMgYmVmb3JlLg0KDQpkaWZmIC0t
Z2l0IGEvYXJjaC9taXBzL2tlcm5lbC9zZXR1cC5jIGIvYXJjaC9taXBzL2tlcm5lbC9zZXR1
cC5jDQppbmRleCAwNzAyMzRiLi43YTQ0OWQ5IDEwMDY0NA0KLS0tIGEvYXJjaC9taXBzL2tl
cm5lbC9zZXR1cC5jDQorKysgYi9hcmNoL21pcHMva2VybmVsL3NldHVwLmMNCkBAIC04Mzks
NiArODM5LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IGFyY2hfbWVtX2luaXQoY2hhciAqKmNt
ZGxpbmVfcCkNCg0KICAgICAgICAvKiBjYWxsIGJvYXJkIHNldHVwIHJvdXRpbmUgKi8NCiAg
ICAgICAgcGxhdF9tZW1fc2V0dXAoKTsNCisgICAgICAgbWVtYmxvY2tfc2V0X2JvdHRvbV91
cCh0cnVlKTsNCg0KICAgICAgICAvKg0KICAgICAgICAgKiBNYWtlIHN1cmUgYWxsIGtlcm5l
bCBtZW1vcnkgaXMgaW4gdGhlIG1hcHMuICBUaGUgIlVQIiBhbmQNCmRpZmYgLS1naXQgYS9h
cmNoL21pcHMva2VybmVsL3RyYXBzLmMgYi9hcmNoL21pcHMva2VybmVsL3RyYXBzLmMNCmlu
ZGV4IDBmODUyZTEuLjE1ZTEwM2MgMTAwNjQ0DQotLS0gYS9hcmNoL21pcHMva2VybmVsL3Ry
YXBzLmMNCisrKyBiL2FyY2gvbWlwcy9rZXJuZWwvdHJhcHMuYw0KQEAgLTIyNjAsMTAgKzIy
NjAsOCBAQCB2b2lkIF9faW5pdCB0cmFwX2luaXQodm9pZCkNCiAgICAgICAgICAgICAgICB1
bnNpZ25lZCBsb25nIHNpemUgPSAweDIwMCArIFZFQ1RPUlNQQUNJTkcqNjQ7DQogICAgICAg
ICAgICAgICAgcGh5c19hZGRyX3QgZWJhc2VfcGE7DQoNCi0gICAgICAgICAgICAgICBtZW1i
bG9ja19zZXRfYm90dG9tX3VwKHRydWUpOw0KICAgICAgICAgICAgICAgIGViYXNlID0gKHVu
c2lnbmVkIGxvbmcpDQogICAgICAgICAgICAgICAgICAgICAgICBtZW1ibG9ja19hbGxvY19m
cm9tKHNpemUsIDEgPDwgZmxzKHNpemUpLCAwKTsNCi0gICAgICAgICAgICAgICBtZW1ibG9j
a19zZXRfYm90dG9tX3VwKGZhbHNlKTsNCg0KICAgICAgICAgICAgICAgIC8qDQogICAgICAg
ICAgICAgICAgICogVHJ5IHRvIGVuc3VyZSBlYmFzZSByZXNpZGVzIGluIEtTZWcwIGlmIHBv
c3NpYmxlLg0KQEAgLTIzMDcsNiArMjMwNSw3IEBAIHZvaWQgX19pbml0IHRyYXBfaW5pdCh2
b2lkKQ0KICAgICAgICBpZiAoYm9hcmRfZWJhc2Vfc2V0dXApDQogICAgICAgICAgICAgICAg
Ym9hcmRfZWJhc2Vfc2V0dXAoKTsNCiAgICAgICAgcGVyX2NwdV90cmFwX2luaXQodHJ1ZSk7
DQorICAgICAgIG1lbWJsb2NrX3NldF9ib3R0b21fdXAoZmFsc2UpOw0KDQogICAgICAgIC8q
DQogICAgICAgICAqIENvcHkgdGhlIGdlbmVyaWMgZXhjZXB0aW9uIGhhbmRsZXJzIHRvIHRo
ZWlyIGZpbmFsIGRlc3RpbmF0aW9uLg0KDQogDQotLS0tLS0tLS0tLS0tLS0tLS0gT3JpZ2lu
YWwgLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAgIk1pa2UgUmFwb3BvcnQiPHJwcHRAbGlu
dXguaWJtLmNvbT47DQpEYXRlOiAgRnJpLCBOb3YgOSwgMjAxOCAwMjowMSBBTQ0KVG86ICAi
VGhvbWFzIEJvZ2VuZG9lcmZlciI8dGJvZ2VuZG9lcmZlckBzdXNlLmRlPjsNCkNjOiAgIlJh
bGYgQmFlY2hsZSI8cmFsZkBsaW51eC1taXBzLm9yZz47ICJQYXVsIEJ1cnRvbiI8cGF1bC5i
dXJ0b25AbWlwcy5jb20+OyAiSmFtZXMgSG9nYW4iPGpob2dhbkBrZXJuZWwub3JnPjsgIkh1
YWNhaSBDaGVuIjxjaGVuaGNAbGVtb3RlLmNvbT47ICJsaW51eC1taXBzIjxsaW51eC1taXBz
QGxpbnV4LW1pcHMub3JnPjsgImxpbnV4LWtlcm5lbCI8bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZz47ICJycHB0IjxycHB0QGxpbnV4LnZuZXQuaWJtLmNvbT47DQpTdWJqZWN0OiAg
UmU6IFtbUEFUQ0hdXSBtaXBzOiBGaXggc3dpdGNoIHRvIE5PX0JPT1RNRU0gZm9yIFNHSS1J
UDI3L2xvb25nb25zMyBOVU1BDQogDQoNCg0KT24gTm92ZW1iZXIgOCwgMjAxOCA2OjUyOjE3
IFBNIEdNVCswMjowMCwgVGhvbWFzIEJvZ2VuZG9lcmZlciA8dGJvZ2VuZG9lcmZlckBzdXNl
LmRlPiB3cm90ZToNCj5PbiBUaHUsIDggTm92IDIwMTggMTg6MTg6MjMgKzAyMDANCj5NaWtl
IFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPg0KPj4gT24gVGh1LCBO
b3YgMDgsIDIwMTggYXQgMDM6NDQ6MjhQTSArMDEwMCwgVGhvbWFzIEJvZ2VuZG9lcmZlciB3
cm90ZToNCj4+ID4gQ29tbWl0IGJjZWM1NGJmMzExOCAoIm1pcHM6IHN3aXRjaCB0byBOT19C
T09UTUVNIikgYnJva2UgU0dJLUlQMjcNCj4+ID4gYW5kIE5VTUEgZW5hYmxlZCBsb29uZ3Nv
bjMgYnkgZG9pbmcgbWVtYmxvY2tfc2V0X2N1cnJlbnRfbGltaXQoKQ0KPj4gPiBiZWZvcmUg
bWF4X2xvd19wZm4gaGFzIGJlZW4gZXZhbHVhdGVkLiBCb3RoIHBsYXRmb3JtcyBuZWVkIHRv
IGRvDQo+dGhlDQo+PiA+IG1lbWJsb2NrX3NldF9jdXJyZW50X2xpbWl0KCkgaW4gcGxhdGZv
cm0gc3BlY2lmaWMgY29kZS4gRm9yDQo+PiA+IGNvbnNpc3RlbmN5IHRoZSBjYWxsIHRvIG1l
bWJsb2NrX3NldF9jdXJyZW50X2xpbWl0KCkgaXMgbW92ZWQNCj4+ID4gdG8gdGhlIGNvbW1v
biBib290bWVtX2luaXQoKSwgd2hlcmUgbWF4X2xvd19wZm4gaXMgY2FsY3VsYXRlZA0KPj4g
PiBmb3Igbm9uIE5VTUEgZW5hYmxlZCBwbGF0Zm9ybXMuDQo+PiBbLi5dDQo+PiANCj4+IEFz
IGZvciBTR0ktSVAyNywgdGhlIGluaXRpYWxpemF0aW9uIG9mIG1heF9sb3dfcGZuIGFzIGxh
dGUgYXMgaW4NCj4+IHBhZ2luZ19pbml0KCkgc2VlbXMgdG8gYmUgYnJva2VuIGJlY2F1c2Ug
aXQncyB2YWx1ZSBpcyB1c2VkIGluDQo+PiBhcmNoX21lbV9pbml0KCkgYW5kIGluIGZpbmFs
aXplX2luaXRyZCgpIGFueXdheS4NCj4NCj53ZWxsLCB0aGUgcGF0Y2ggaXMgdGVzdGVkIG9u
IHJlYWwgaGFyZHdhcmUgYW5kIHRoZSBmaXJzdCBjYWxsZXIgb2YNCj5hIG1lbWJsb2NrX2Fs
bG9jKiBmdW5jdGlvbiBpcyBpbiBhIGZ1bmN0aW9uIGNhbGxlZCBieQ0KPmZyZWVfYXJlYV9p
bml0X25vZGVzKCkuDQogDQpUaGVuLCBhcHBhcmVudGx5LCBJJ3ZlIG1pc3NlZCBzb21ldGhp
bmcgZWxzZS4NClRoZSBPbnl4MiBJIHdvcmtlZCBvbiBpcyBkZWFkIGZvciBhIGNvdXBsZSBv
ZiB5ZWFycyBub3cgOy0pDQoNCj4+IEFGQUlVLCBib3RoIHBsYXRmb3JtcyBzZXQgbWF4X2xv
d19wZm4gdG8gbGFzdCBhdmFpbGFibGUgcGZuLCBzbyBpdA0KPnNlZW1zIHdlDQo+PiBjYW4g
c2ltcGx5IGRvDQo+PiANCj4+IG1heF9sb3dfcGZuID0gUEZOX1BIWVMobWVtYmxvY2tfZW5k
X29mX0RSQU0oKSkNCj4+DQoNClNob3VsZCBoYXZlIGJlZW4gUEhZU19QRk4sIHNvcnJ5Lg0K
DQo+PiBpbiB0aGUgcHJvbV9tZW1pbml0KCkgZnVuY3Rpb24gZm9yIGJvdGggcGxhdGZvcm1z
IGFuZCBkcm9wIHRoZSBsb29wDQo+PiBldmFsdWF0aW5nIG1heF9sb3dfcGZuIGluIHBhZ2lu
Z19pbml0KCkuDQo+DQo+c291bmRzIGxpa2UgYSBiZXR0ZXIgcGxhbi4gSSdsbCBwcmVwYXJl
IGEgbmV3IHBhdGNoLg0KPg0KPlRob21hcy4NCg0KLS0gDQpTZW50IGZyb20gbXkgQW5kcm9p
ZCBkZXZpY2Ugd2l0aCBLLTkgTWFpbC4gUGxlYXNlIGV4Y3VzZSBteSBicmV2aXR5Lg==



