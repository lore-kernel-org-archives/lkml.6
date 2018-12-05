Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73847C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE9F2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE9F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeLEMiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:38:50 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42178 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLEMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:38:50 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID wB5CbluI003088, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id wB5CbluI003088
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 5 Dec 2018 20:37:47 +0800
Received: from RTITMBSV02.realtek.com.tw ([fe80::cc0e:6d5f:56d7:c15f]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Wed, 5 Dec 2018
 20:37:47 +0800
From:   Kailang <kailang@realtek.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire U27-880
Thread-Topic: [PATCH 1/4] ALSA: hda/realtek: ALC286 mic and headset-mode
 fixups for Acer Aspire U27-880
Thread-Index: AQHUjGa4XN13mVP0E0CVDcC2o9xZn6Vv1lzwgAAEP6D//4FnAIAAuQz0
Date:   Wed, 5 Dec 2018 12:37:43 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A184200F7@RTITMBSV02.realtek.com.tw>
References: <20181205064856.19380-1-jian-hong@endlessm.com>
        <6FAB7C47BCF00940BB0999A99BE3547A184200B5@RTITMBSV02.realtek.com.tw>,<s5hsgzcuxmx.wl-tiwai@suse.de>
In-Reply-To: <s5hsgzcuxmx.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [112.104.14.167]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGFrYXNoaSwKCllvdSBzaG91bGQgYXBwbHkgYWxjMjg2IHBsYXRmb3JtIGZpcnN0LgpJIHRo
aW5rIHRoZXkgaGFkIHRlc3QgcGFzc2VkIGFscmVhZHkuCkFMQzI5NCBwbGF0Zm9ybSBqdXN0IHdh
aXQgZm9yIHRlc3QgdmlhIGNoYW5nZSBtb2RlbC4KCkJSLApLYWlsYW5nCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KsXE6IFRha2FzaGkgSXdhaSBbdGl3YWlAc3VzZS5k
ZV0KsUil86TptME6IDIwMTimfjEypOs1pOkgpFWkyCAwNTozMgqm3DogS2FpbGFuZwqwxqW7OiBK
aWFuLUhvbmcgUGFuOyBKYXJvc2xhdiBLeXNlbGE7IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZzsgSHVpIFdhbmc7IENocmlzIENoaXU7IERhbmllbCBEcmFrZTsgbGludXhAZW5kbGVzc20uY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCqVEpq46IFJlOiBbUEFUQ0ggMS80XSBBTFNB
OiBoZGEvcmVhbHRlazogQUxDMjg2IG1pYyBhbmQgaGVhZHNldC1tb2RlIGZpeHVwcyBmb3IgQWNl
ciBBc3BpcmUgVTI3LTg4MAoKT24gV2VkLCAwNSBEZWMgMjAxOCAxMDowNjoxNCArMDEwMCwKS2Fp
bGFuZyB3cm90ZToKPgo+IFNvcnJ5ISEKPiBEb24ndCBjaGFuZ2UgdGhpcy4KCkhtLCBzaG91bGQg
SSBhcHBseSB0aGVzZSBzZXJpZXMgb3Igbm90PwoKCnRoYW5rcywKClRha2FzaGkKCj4KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEthaWxhbmcKPiBTZW50OiBXZWRuZXNkYXks
IERlY2VtYmVyIDUsIDIwMTggNDo1MiBQTQo+IFRvOiAnSmlhbi1Ib25nIFBhbicgPGppYW4taG9u
Z0BlbmRsZXNzbS5jb20+OyBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6PjsgVGFrYXNo
aSBJd2FpIDx0aXdhaUBzdXNlLmNvbT4KPiBDYzogSHVpIFdhbmcgPGh1aS53YW5nQGNhbm9uaWNh
bC5jb20+OyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4QGVuZGxlc3NtLmNvbTsgQ2hyaXMgQ2hpdSA8Y2hpdUBlbmRsZXNzbS5j
b20+OyBEYW5pZWwgRHJha2UgPGRyYWtlQGVuZGxlc3NtLmNvbT4KPiBTdWJqZWN0OiBSRTogW1BB
VENIIDEvNF0gQUxTQTogaGRhL3JlYWx0ZWs6IEFMQzI4NiBtaWMgYW5kIGhlYWRzZXQtbW9kZSBm
aXh1cHMgZm9yIEFjZXIgQXNwaXJlIFUyNy04ODAKPgo+IEhpIEppYW4gSG9uZywKPgo+IFBsZWFz
ZSBhbHNvIHRyeSB0byBjaGFuZ2UgbW9kZWwgdG8gQUxDMjY5X0ZJWFVQX0hFQURTRVRfTU9ERV9O
T19IUF9NSUMuCj4KPiArICAgICAgICAgICAgIC5jaGFpbl9pZCA9IEFMQzI2OV9GSVhVUF9IRUFE
U0VUX01JQyAgPT0+IGNoYW5nZSB0byAgQUxDMjY5X0ZJWFVQX0hFQURTRVRfTU9ERV9OT19IUF9N
SUMKPgo+IEJSLAo+IEthaWxhbmcKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206
IEppYW4tSG9uZyBQYW4gPGppYW4taG9uZ0BlbmRsZXNzbS5jb20+Cj4gU2VudDogV2VkbmVzZGF5
LCBEZWNlbWJlciA1LCAyMDE4IDI6NDkgUE0KPiBUbzogSmFyb3NsYXYgS3lzZWxhIDxwZXJleEBw
ZXJleC5jej47IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5jb20+Cj4gQ2M6IEthaWxhbmcgPGth
aWxhbmdAcmVhbHRlay5jb20+OyBIdWkgV2FuZyA8aHVpLndhbmdAY2Fub25pY2FsLmNvbT47IGFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXhAZW5kbGVzc20uY29tOyBDaHJpcyBDaGl1IDxjaGl1QGVuZGxlc3NtLmNvbT47IEppYW4t
SG9uZyBQYW4gPGppYW4taG9uZ0BlbmRsZXNzbS5jb20+OyBEYW5pZWwgRHJha2UgPGRyYWtlQGVu
ZGxlc3NtLmNvbT4KPiBTdWJqZWN0OiBbUEFUQ0ggMS80XSBBTFNBOiBoZGEvcmVhbHRlazogQUxD
Mjg2IG1pYyBhbmQgaGVhZHNldC1tb2RlIGZpeHVwcyBmb3IgQWNlciBBc3BpcmUgVTI3LTg4MAo+
Cj4gRnJvbTogQ2hyaXMgQ2hpdSA8Y2hpdUBlbmRsZXNzbS5jb20+Cj4KPiBBY2VyIEFzcGlyZSBV
MjctODgwKEFJTykgd2l0aCBBTEMyODYgY29kZWMgY2FuIG5vdCBkZXRlY3QgaGVhZHNldCBtaWMg
YW5kIGludGVybmFsIG1pYyBub3Qgd29ya2luZyBlaXRoZXIuIEl0IG5lZWRzIHRoZSBzaW1pbGFy
IHF1aXJrIGxpa2UgU29ueSBsYXB0b3BzIHRvIGZpeCBoZWFkcGhvbmUgamFjayBzZW5zaW5nIGFu
ZCBlbmFibGVzIHVzZSBvZiB0aGUgaW50ZXJuYWwgbWljcm9waG9uZS4KPgo+IFVuZm9ydHVuYXRl
bHkgamFjayBzZW5zaW5nIGZvciB0aGUgaGVhZHNldCBtaWMgaXMgc3RpbGwgbm90IHdvcmtpbmcu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKaWFuLUhvbmcgUGFuIDxqaWFuLWhvbmdAZW5kbGVzc20uY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBEcmFrZSA8ZHJha2VAZW5kbGVzc20uY29tPgo+IFNp
Z25lZC1vZmYtYnk6IENocmlzIENoaXUgPGNoaXVAZW5kbGVzc20uY29tPgo+IC0tLQo+ICBzb3Vu
ZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyB8IDE0ICsrKysrKysrKysrKysrCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9w
YXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBpbmRleCBjMGIy
ODliYTM5N2YuLmYyMWQ1MmViMmVkMyAxMDA2NDQKPiAtLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNo
X3JlYWx0ZWsuYwo+ICsrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCj4gQEAgLTU1
MTYsNiArNTUxNiw3IEBAIGVudW0gewo+ICAgICAgIEFMQzIyMV9GSVhVUF9IUF9IRUFEU0VUX01J
QywKPiAgICAgICBBTEMyODVfRklYVVBfTEVOT1ZPX0hFQURQSE9ORV9OT0lTRSwKPiAgICAgICBB
TEMyOTVfRklYVVBfSFBfQVVUT19NVVRFLAo+ICsgICAgIEFMQzI4Nl9GSVhVUF9BQ0VSX0FJT19N
SUNfTk9fUFJFU0VOQ0UsCj4gIH07Cj4KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfZml4dXAg
YWxjMjY5X2ZpeHVwc1tdID0geyBAQCAtNjM5Myw2ICs2Mzk0LDE1IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgaGRhX2ZpeHVwIGFsYzI2OV9maXh1cHNbXSA9IHsKPiAgICAgICAgICAgICAgIC50eXBl
ID0gSERBX0ZJWFVQX0ZVTkMsCj4gICAgICAgICAgICAgICAudi5mdW5jID0gYWxjX2ZpeHVwX2F1
dG9fbXV0ZV92aWFfYW1wLAo+ICAgICAgIH0sCj4gKyAgICAgW0FMQzI4Nl9GSVhVUF9BQ0VSX0FJ
T19NSUNfTk9fUFJFU0VOQ0VdID0gewo+ICsgICAgICAgICAgICAgLnR5cGUgPSBIREFfRklYVVBf
UElOUywKPiArICAgICAgICAgICAgIC52LnBpbnMgPSAoY29uc3Qgc3RydWN0IGhkYV9waW50Ymxb
XSkgewo+ICsgICAgICAgICAgICAgICAgICAgICB7IDB4MTgsIDB4MDFhMTkxM2MgfSwgLyogdXNl
IGFzIGhlYWRzZXQgbWljLCB3aXRob3V0IGl0cyBvd24gamFjayBkZXRlY3QgKi8KPiArICAgICAg
ICAgICAgICAgICAgICAgeyB9Cj4gKyAgICAgICAgICAgICB9LAo+ICsgICAgICAgICAgICAgLmNo
YWluZWQgPSB0cnVlLAo+ICsgICAgICAgICAgICAgLmNoYWluX2lkID0gQUxDMjY5X0ZJWFVQX0hF
QURTRVRfTUlDCj4gKyAgICAgfSwKPiAgfTsKPgo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9w
Y2lfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtdID0geyBAQCAtNzA3MSw2ICs3MDgxLDEwIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2hkYV9waW5fcXVpcmsgYWxjMjY5X3Bpbl9maXh1cF90Ymxb
XSA9IHsKPiAgICAgICAgICAgICAgIHsweDE0LCAweDkwMTcwMTEwfSwKPiAgICAgICAgICAgICAg
IHsweDE5LCAweDA0YTExMDQwfSwKPiAgICAgICAgICAgICAgIHsweDIxLCAweDA0MjExMDIwfSks
Cj4gKyAgICAgU05EX0hEQV9QSU5fUVVJUksoMHgxMGVjMDI4NiwgMHgxMDI1LCAiQWNlciIsIEFM
QzI4Nl9GSVhVUF9BQ0VSX0FJT19NSUNfTk9fUFJFU0VOQ0UsCj4gKyAgICAgICAgICAgICB7MHgx
MiwgMHg5MGE2MDEzMH0sCj4gKyAgICAgICAgICAgICB7MHgxNywgMHg5MDE3MDExMH0sCj4gKyAg
ICAgICAgICAgICB7MHgyMSwgMHgwMjIxMTAyMH0pLAo+ICAgICAgIFNORF9IREFfUElOX1FVSVJL
KDB4MTBlYzAyODgsIDB4MTAyOCwgIkRlbGwiLCBBTEMyODhfRklYVVBfREVMTDFfTUlDX05PX1BS
RVNFTkNFLAo+ICAgICAgICAgICAgICAgezB4MTIsIDB4OTBhNjAxMjB9LAo+ICAgICAgICAgICAg
ICAgezB4MTQsIDB4OTAxNzAxMTB9LAo+IC0tCj4gMi4xMS4wCj4KPgoKLS0tLS0tUGxlYXNlIGNv
bnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuCg==
