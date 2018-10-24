Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC969C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694CC207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694CC207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJXXwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:52:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49195 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726407AbeJXXwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:52:42 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9OFDxcf017368;
        Wed, 24 Oct 2018 17:24:05 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n7stx3em2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Oct 2018 17:24:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A3E653F;
        Wed, 24 Oct 2018 15:24:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D64351A9;
        Wed, 24 Oct 2018 15:24:03 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Oct
 2018 17:24:03 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Wed, 24 Oct 2018 17:24:03 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v4 10/17] remoteproc: add helper function to check
 carveout device address
Thread-Topic: [PATCH v4 10/17] remoteproc: add helper function to check
 carveout device address
Thread-Index: AQHUJaviZhWhit+O1E6QgB3gy+7EXaUtzpwAgAE+f1A=
Date:   Wed, 24 Oct 2018 15:24:03 +0000
Message-ID: <8b16461d7d99487480253cde5cdcfd2c@SFHDAG7NODE2.st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-11-git-send-email-loic.pallardy@st.com>
 <2844874b-9484-aeee-c614-411d0ff38d12@ti.com>
In-Reply-To: <2844874b-9484-aeee-c614-411d0ff38d12@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VtYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4g
QW5uYSA8cy1hbm5hQHRpLmNvbT4NCj4gU2VudDogbWVyY3JlZGkgMjQgb2N0b2JyZSAyMDE4IDAw
OjE0DQo+IFRvOiBMb2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IGJqb3JuLmFu
ZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBvaGFkQHdpemVyeS5jb20NCj4gQ2M6IGxpbnV4LXJlbW90
ZXByb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBB
cm5hdWQgUE9VTElRVUVOIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT47DQo+IGJlbmphbWluLmdh
aWduYXJkQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxMC8xN10gcmVtb3Rl
cHJvYzogYWRkIGhlbHBlciBmdW5jdGlvbiB0byBjaGVjaw0KPiBjYXJ2ZW91dCBkZXZpY2UgYWRk
cmVzcw0KPiANCj4gSGkgTG9pYywNCj4gDQo+IE9uIDcvMjcvMTggODoxNCBBTSwgTG9pYyBQYWxs
YXJkeSB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBmdW5jdGlvbiB0byB2ZXJp
ZnkgdGhhdCBhIHNwZWNpZmllZCBjYXJ2ZW91dA0KPiA+IGlzIGZpdHRpbmcgcmVxdWVzdCBkZXZp
Y2UgYWRkcmVzcyBhbmQgYXNzb2NpYXRlZCBsZW5ndGgNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IExvaWMgUGFsbGFyZHkgPGxvaWMucGFsbGFyZHlAc3QuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMgfCA0Nw0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19j
b3JlLmMNCj4gYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCj4gPiBpbmRl
eCAxZTBmZTNlLi41ZGQ1ZWRmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9y
ZW1vdGVwcm9jX2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9j
X2NvcmUuYw0KPiA+IEBAIC0yNTksNiArMjU5LDUzIEBAIHN0cnVjdCBycHJvY19tZW1fZW50cnkg
Kg0KPiA+ICAJcmV0dXJuIG1lbTsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiBycHJv
Y19jaGVja19jYXJ2ZW91dF9kYSgpIC0gQ2hlY2sgc3BlY2lmaWVkIGNhcnZlb3V0IGRhIGNvbmZp
Z3VyYXRpb24NCj4gPiArICogQHJwcm9jOiBoYW5kbGUgb2YgYSByZW1vdGUgcHJvY2Vzc29yDQo+
ID4gKyAqIEBtZW06IHBvaW50ZXIgb24gY2FydmVvdXQgdG8gY2hlY2sNCj4gPiArICogQGRhOiBh
cmVhIGRldmljZSBhZGRyZXNzDQo+ID4gKyAqIEBsZW46IGFzc29jaWF0ZWQgYXJlYSBzaXplDQo+
ID4gKyAqDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgYSBoZWxwZXIgZnVuY3Rpb24gdG8gdmVy
aWZ5IHJlcXVlc3RlZCBkZXZpY2UgYXJlYQ0KPiAoY291cGxlDQo+ID4gKyAqIGRhLCBsZW4pIGlz
IHBhcnQgb2Ygc3BlY2lmaWVkIGNhcmV2b3V0Lg0KPiANCj4gJXMvY2FyZXZvdXQvY2FydmVvdXQv
DQpPSw0KPiANCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIGlmIGNhcnZlb3V0IG1hdGNocyBy
ZXF1ZXN0IGVsc2UgLUVOT01FTQ0KPiANCj4gJXMvbWF0Y2hzL21hdGNoZXMvDQpPSw0KPiANCj4g
PiArICovDQo+ID4gK2ludCBycHJvY19jaGVja19jYXJ2ZW91dF9kYShzdHJ1Y3QgcnByb2MgKnJw
cm9jLCBzdHJ1Y3QNCj4gcnByb2NfbWVtX2VudHJ5ICptZW0sDQo+IA0KPiBzdGF0aWMgaW50IHNp
bmNlIHRoaXMgc2VlbXMgdG8gYmUgb25seSBhIGxvY2FsIGZ1bmN0aW9uLg0KT0sNCj4gDQo+ID4g
KwkJCSAgICB1MzIgZGEsIHUzMiBsZW4pDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRl
diA9ICZycHJvYy0+ZGV2Ow0KPiA+ICsJaW50IGRlbHRhID0gMDsNCj4gPiArDQo+ID4gKwkvKiBD
aGVjayByZXF1ZXN0ZWQgcmVzb3VyY2UgbGVuZ3RoICovDQo+ID4gKwlpZiAobGVuID4gbWVtLT5s
ZW4pIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIlJlZ2lzdGVyZWQgY2FydmVvdXQgZG9lc24ndCBm
aXQgbGVuDQo+IHJlcXVlc3RcbiIpOw0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiANCj4gRU5P
TUVNIG5vdCB0eXBpY2FsbHkgdXNlZCBmb3IgdGhlc2Uga2luZCBvZiBlcnJvcnMsIHlvdSB3ZXJl
IHByb2JhYmx5DQo+IGluY2xpbmVkIHRvIHVzZWQgdGhpcyBzaW5jZSBpdCBpcyBkZWFsaW5nIHdp
dGggbWVtb3J5Lg0KDQotRUlOVkFMIHdpbGwgYmUgYmV0dGVyDQo+IA0KPiA+ICsJfQ0KPiA+ICsN
Cj4gDQo+IEJvdGggdGhlIGJlbG93IGNvZGVwYXRocyBhcmUgZXhlcmNpc2VkIG9ubHkgd2hlbiBk
YSBpcyBub3QNCj4gRldfUlNDX0FERFJfQU5ZLCBhbmQgeW91IGFyZSByZXR1cm5pbmcgMCBvdGhl
cndpc2UgKHdoaWNoIGlzIHRoZSBjYXNlIG9mDQo+IG1hdGNoZXMgYXMgcGVyIHlvdXIgZGVzY3Jp
cHRpb24gYWJvdmUpLiBJcyB0aGF0IHdoYXQgeW91IHJlYWxseSB3YW50IC0NCj4gc2hvdWxkIGl0
IGJlIGFuIGVycm9yDQoNClllcyB3aGVuIGRhIGlzIGVxdWFsIHRvIEZXX1JTQ19BRERSX0FOWSB3
ZSBzaG91bGQgY2hlY2sgdGhlIGxlbmd0aCB0b28NCg0KPiANCj4gPiArCWlmIChkYSAhPSBGV19S
U0NfQUREUl9BTlkgJiYgbWVtLT5kYSA9PSBGV19SU0NfQUREUl9BTlkpDQo+IHsNCj4gPiArCQkv
KiBVcGRhdGUgZXhpc3RpbmcgY2FydmVvdXQgZGEgKi8NCj4gPiArCQltZW0tPmRhID0gZGE7DQo+
IA0KPiBXaGVyZSB3b3VsZCB5b3UgbmVlZCB0byB1cGRhdGUgdGhpcz8NCkluIHRoYXQgY2FzZSwg
d2UgaGF2ZSAyIGNhcnZlb3V0cyB3aXRoIHRoZSBzYW1lIG5hbWUuDQpPbmUgaGFzIHNvbWUgZml4
ZWQgcmVxdWVzdHMuIFRoZSBvdGhlciBvbmUgaGFzIG5vbmUuDQpUaGUgZ29hbCBoZXJlIGlzIHRv
IGFsaWduIGJvdGggb24gdGhlIG9uZSB3aGljaCBoYXMgdGhlIHN0cm9uZ2VzdCByZXF1aXJlbWVu
dHMuDQpJIHRoaW5rIGxlbmd0aCBpcyBtaXNzaW5nLg0KDQpSZWdhcmRzLA0KTG9pYw0KDQo+IA0K
PiByZWdhcmRzDQo+IFN1bWFuDQo+IA0KPiA+ICsJfSBlbHNlIGlmIChkYSAhPSBGV19SU0NfQURE
Ul9BTlkgJiYgbWVtLT5kYSAhPQ0KPiBGV19SU0NfQUREUl9BTlkpIHsNCj4gPiArCQlkZWx0YSA9
IGRhIC0gbWVtLT5kYTsNCj4gPiArDQo+ID4gKwkJLyogQ2hlY2sgcmVxdWVzdGVkIHJlc291cmNl
IGJlbG9uZ3MgdG8gcmVnaXN0ZXJlZCBjYXJ2ZW91dA0KPiAqLw0KPiA+ICsJCWlmIChkZWx0YSA8
IDApIHsNCj4gPiArCQkJZGV2X2VycihkZXYsDQo+ID4gKwkJCQkiUmVnaXN0ZXJlZCBjYXJ2ZW91
dCBkb2Vzbid0IGZpdCBkYQ0KPiByZXF1ZXN0XG4iKTsNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07
DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlpZiAoZGVsdGEgKyBsZW4gPiBtZW0tPmxlbikgew0K
PiA+ICsJCQlkZXZfZXJyKGRldiwNCj4gPiArCQkJCSJSZWdpc3RlcmVkIGNhcnZlb3V0IGRvZXNu
J3QgZml0IGxlbg0KPiByZXF1ZXN0XG4iKTsNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
KwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiANCj4gDQo+ID4gK30NCj4g
PiArDQo+ID4gIGludCBycHJvY19hbGxvY192cmluZyhzdHJ1Y3QgcnByb2NfdmRldiAqcnZkZXYs
IGludCBpKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcnByb2MgKnJwcm9jID0gcnZkZXYtPnJwcm9j
Ow0KPiA+DQoNCg==
