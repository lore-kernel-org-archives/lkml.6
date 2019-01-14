Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A03C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EF92064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfANUXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:23:14 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9043 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbfANUXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:23:14 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EKGSNT031571;
        Mon, 14 Jan 2019 21:23:08 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pyc011uth-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 14 Jan 2019 21:23:08 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FFAD31;
        Mon, 14 Jan 2019 20:23:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 493C3A7A7;
        Mon, 14 Jan 2019 20:23:07 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 14 Jan
 2019 21:23:06 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Mon, 14 Jan 2019 21:23:06 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     xiang xiao <xiaoxiang781216@gmail.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: RE: [PATCH 1/1] remoteproc: fix recovery procedure
Thread-Topic: [PATCH 1/1] remoteproc: fix recovery procedure
Thread-Index: AQHUqAn/EJZV5bhF3ki4eEklyP85XqWr6HGAgAJ6h6A=
Date:   Mon, 14 Jan 2019 20:23:06 +0000
Message-ID: <a7040498e7dc4e64b0748052c3ff3403@SFHDAG7NODE2.st.com>
References: <1547031403-34535-1-git-send-email-loic.pallardy@st.com>
 <CAH2Cfb_4qFAEjiANLpRmQL5o9-JCPHCBULLz5-r=zbK9EwiT_A@mail.gmail.com>
In-Reply-To: <CAH2Cfb_4qFAEjiANLpRmQL5o9-JCPHCBULLz5-r=zbK9EwiT_A@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWGlhbmcsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogeGlhbmcg
eGlhbyA8eGlhb3hpYW5nNzgxMjE2QGdtYWlsLmNvbT4NCj4gU2VudDogc2FtZWRpIDEyIGphbnZp
ZXIgMjAxOSAxOToyOQ0KPiBUbzogTG9pYyBQQUxMQVJEWSA8bG9pYy5wYWxsYXJkeUBzdC5jb20+
DQo+IENjOiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgb2hhZEB3aXplcnkuY29tOyBsaW51
eC0NCj4gcmVtb3RlcHJvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEFybmF1ZA0KPiBQT1VMSVFVRU4gPGFybmF1ZC5wb3VsaXF1ZW5Ac3QuY29tPjsgYmVu
amFtaW4uZ2FpZ25hcmRAbGluYXJvLm9yZzsgcy0NCj4gYW5uYUB0aS5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzFdIHJlbW90ZXByb2M6IGZpeCByZWNvdmVyeSBwcm9jZWR1cmUNCj4gDQo+
IEhpIExvaWMsDQo+IFRoZSBjaGFuZ2UganVzdCBoaWRlIHRoZSBwcm9ibGVtLCBJIHRoaW5rLiBU
aGUgYmlnIGlzc3VlIGlzOg0KPiAxLnZpcnRpbyBkZXZpY2VzIGFyZW4ndCBkZXN0cm95ZWQgYnkg
cnBwcm9jX3N0b3ANClZpcnRpbyBkZXZpY2VzIGFyZSBkZXN0cm95ZWQgYnkgcnByb2Nfc3RvcCgp
IGFzIHZkZXYgaXMgcmVnaXN0ZXJlZCBhcyBycHJvYyBzdWIgZGV2aWNlLg0KcnByb2Nfc3RvcCgp
IGlzIGNhbGxpbmcgcnByb2Nfc3RvcF9zdWJkZXZpY2VzKCkgd2hpY2ggaXMgaW4gY2hhcmdlIG9m
IHJlbW92aW5nIHZpcnRpbyBkZXZpY2UgYW5kIGFzc29jaWF0ZWQgY2hpbGRyZW4uDQpycHJvY192
ZGV2X2RvX3N0b3AoKSAtLT4gcnByb2NfcmVtb3ZlX3ZpcnRpb19kZXYoKSAtLT4gdW5yZWdpc3Rl
cl92aXJ0aW9fZGV2aWNlKCkNCg0KUGxlYXNlIGZpbmQgYmVsb3cgdHJhY2Ugb2YgYSByZWNvdmVy
eSBvbiBteSBTVCBTT0MuIE15IDIgcnBtc2cgdHR5IGFyZSByZW1vdmVkIGFuZCByZS1pbnNlcnRl
ZCBjb3JyZWN0bHkNCnJvb3RAc3RtMzJtcDE6fiMgbHMgL2Rldi90dHlSUE1TRyoNCi9kZXYvdHR5
UlBNU0cwICAvZGV2L3R0eVJQTVNHMQ0Kcm9vdEBzdG0zMm1wMTp+IyBbICAxNTQuODMyNTIzXSBy
ZW1vdGVwcm9jIHJlbW90ZXByb2MwOiBjcmFzaCBkZXRlY3RlZCBpbiBtNDogdHlwZSB3YXRjaGRv
Zw0KWyAgMTU0LjgzNzcyNV0gcmVtb3RlcHJvYyByZW1vdGVwcm9jMDogaGFuZGxpbmcgY3Jhc2gg
IzIgaW4gbTQNClsgIDE1NC44NDMzMTldIHJlbW90ZXByb2MgcmVtb3RlcHJvYzA6IHJlY292ZXJp
bmcgbTQNClsgIDE1NC44NDkxODVdIHJwbXNnX3R0eSB2aXJ0aW8wLnJwbXNnLXR0eS1jaGFubmVs
Li0xLjA6IHJwbXNnIHR0eSBkZXZpY2UgMCBpcyByZW1vdmVkDQpbICAxNTQuODU3NTcyXSBycG1z
Z190dHkgdmlydGlvMC5ycG1zZy10dHktY2hhbm5lbC4tMS4xOiBycG1zZyB0dHkgZGV2aWNlIDEg
aXMgcmVtb3ZlZA0KWyAgMTU1LjM4MjMyN10gcmVtb3RlcHJvYyByZW1vdGVwcm9jMDogd2Fybmlu
ZzogcmVtb3RlIEZXIHNodXRkb3duIHdpdGhvdXQgYWNrDQpbICAxNTUuMzg3ODU3XSByZW1vdGVw
cm9jIHJlbW90ZXByb2MwOiBzdG9wcGVkIHJlbW90ZSBwcm9jZXNzb3IgbTQNClsgIDE1NS4zOTg5
ODhdICBtNEAwI3ZkZXYwYnVmZmVyOiBhc3NpZ25lZCByZXNlcnZlZCBtZW1vcnkgbm9kZSB2ZGV2
MGJ1ZmZlckAxMDA0NDAwMA0KWyAgMTU1LjQwNTkxMF0gdmlydGlvX3JwbXNnX2J1cyB2aXJ0aW8w
OiBjcmVhdGluZyBjaGFubmVsIHJwbXNnLXR0eS1jaGFubmVsIGFkZHIgMHgwDQpbICAxNTUuNDEz
NDIyXSBycG1zZ190dHkgdmlydGlvMC5ycG1zZy10dHktY2hhbm5lbC4tMS4wOiBuZXcgY2hhbm5l
bDogMHg0MDAgLT4gMHgwIDogdHR5UlBNU0cwDQpbICAxNTUuNDIxMDM4XSB2aXJ0aW9fcnBtc2df
YnVzIHZpcnRpbzA6IGNyZWF0aW5nIGNoYW5uZWwgcnBtc2ctdHR5LWNoYW5uZWwgYWRkciAweDEN
ClsgIDE1NS40MjkwODhdIHJwbXNnX3R0eSB2aXJ0aW8wLnJwbXNnLXR0eS1jaGFubmVsLi0xLjE6
IG5ldyBjaGFubmVsOiAweDQwMSAtPiAweDEgOiB0dHlSUE1TRzENClsgIDE1NS40MzczMzhdIHZp
cnRpb19ycG1zZ19idXMgdmlydGlvMDogcnBtc2cgaG9zdCBpcyBvbmxpbmUNClsgIDE1NS40NDI0
MDFdICBtNEAwI3ZkZXYwYnVmZmVyOiByZWdpc3RlcmVkIHZpcnRpbzAgKHR5cGUgNykNClsgIDE1
NS40NjExNTRdIHJlbW90ZXByb2MgcmVtb3RlcHJvYzA6IHJlbW90ZSBwcm9jZXNzb3IgbTQgaXMg
bm93IHVwDQpscyAvZGV2L3R0eVJQTVNHKg0KL2Rldi90dHlSUE1TRzAgIC9kZXYvdHR5UlBNU0cx
DQpyb290QHN0bTMybXAxOn4jDQoNCkFzIHZkZXYgaXMgaW5jbHVkaW5nIGluIGEgbGFyZ2VyIHN0
cnVjdCBhbGxvY2F0ZWQgYnkgcnByb2MsIGl0IGlzIHNhZmUgdG8gc2V0IGl0IHRvIDAgYmVmb3Jl
IGluaXRpYWxpemluZyB2aXJ0aW8gZGV2aWNlIHdoaWxlIHJwcm9jIHN1YmRldmljZSBzZXF1ZW5j
ZSBpcyByZXNwZWN0ZWQuDQoNCj4gMi5hbmQgdGhlbiBycG1zZyBjaGlsZCBkZXZpY2VzIGFyZW4n
dCBkZXN0cm95ZWQgdG9vDQo+IFRoZW4sIHdoZW4gdGhlIHJlbW90ZSBzdGFydCBhbmQgY3JlYXRl
IHJwbXNnIGNoYW5uZWwgYWdhaW4sIHRoZQ0KPiBkdXBsaWNhdGVkIGNoYW5uZWwgd2lsbCBhcHBl
YXIgaW4ga2VybmVsLg0KPiBUbyBmaXggdGhpcyBwcm9ibGVtLCB3ZSBuZWVkIGdvIHRocm91Z2gg
cnBwcm9jX3NodXRkb3duL3Jwcm9jX2Jvb3QgdG8NCj4gZGVzdHJveSBhbGwgZGV2aWNlcyh2aXJ0
aW8gYW5kIHJwbXNnKSBhbmQgY3JlYXRlIHRoZW0gYWdhaW4uDQpScHJvY19zaHV0ZG93bi9ycHJv
Y19ib290IGlzIHNvbHZpbmcgdGhlIGlzc3VlIHRvbywgZXhjZXB0IGlmIHJwcm9jX2Jvb3QoKSB3
YXMgY2FsbGVkIHNldmVyYWwgdGltZXMgYW5kIHNvIHJwcm9jLT5wb3dlciBhdG9taWMgbm90IGVx
dWFsIHRvIDEuDQpVc2luZyBvbmx5IHJwcm9jX3N0b3AoKSBhbmQgcnByb2Nfc3RhcnQoKSBhbGxv
d3MgdG8gcHJlc2VydmUgcnByb2MtPnBvd2VyIGFuZCBzbyB0byBiZSBzaWxlbnQgZnJvbSBycHJv
YyB1c2VyIHBvdi4NCg0KUmVnYXJkcywNCkxvaWMNCj4gDQo+IFRoYW5rcw0KPiBYaWFuZw0KPiAN
Cj4gT24gV2VkLCBKYW4gOSwgMjAxOSBhdCA2OjU2IFBNIExvaWMgUGFsbGFyZHkgPGxvaWMucGFs
bGFyZHlAc3QuY29tPiB3cm90ZToNCj4gPg0KPiA+IENvbW1pdCA3ZTgzY2FiODI0YTg3ZTgzY2Fi
ODI0YTggKCJyZW1vdGVwcm9jOiBNb2RpZnkgcmVjb3ZlcnkgcGF0aA0KPiA+IHRvIHVzZSBycHJv
Y197c3RhcnQsc3RvcH0oKSIpIHJlcGxhY2VzIHJwcm9jX3tzaHV0ZG93bixib290fSgpIHdpdGgN
Cj4gPiBycHJvY197c3RvcCxzdGFydH0oKSwgd2hpY2ggc2tpcHMgZGVzdHJveSB0aGUgdmlydGlv
IGRldmljZSBhdCBzdG9wDQo+ID4gYnV0IHJlLWluaXRpYWxpemVzIGl0IGFnYWluIGF0IHN0YXJ0
Lg0KPiA+DQo+ID4gSXNzdWUgaXMgdGhhdCBzdHJ1Y3QgdmlydGlvX2RldiBpcyBub3QgY29ycmVj
dGx5IHJlaW5pdGlhbGl6ZWQgbGlrZSBkb25lDQo+ID4gYXQgaW5pdGlhbCBhbGxvY2F0aW9uIHRo
YW5rcyB0byBremFsbG9jKCkgYW5kIGtvYmplY3QgaXMgY29uc2lkZXJlZCBhcw0KPiA+IGFscmVh
ZHkgaW5pdGlhbGl6ZWQgYnkga2VybmVsLiBUaGF0IGlzIGR1ZSB0byB0aGUgZmFjdCBzdHJ1Y3Qg
dmlydGlvX2Rldg0KPiA+IGlzIGFsbG9jYXRlZCBhbmQgcmVsZWFzZWQgYXQgdmRldiByZXNvdXJj
ZSBoYW5kbGluZyBsZXZlbCBtYW5hZ2VkIGFuZA0KPiA+IHZpcnRpbyBkZXZpY2UgaXMgcmVnaXN0
ZXJlZCBhbmQgdW5yZWdpc3RlcmVkIGF0IHJwcm9jIHN1YmRldmljZXMgbGV2ZWwuDQo+ID4NCj4g
PiBUaGlzIHBhdGNoIGluaXRpYWxpemVzIHN0cnVjdCB2aXJ0aW9fZGV2IHRvIDAgYmVmb3JlIHVz
aW5nIGl0IGFuZA0KPiA+IHJlZ2lzdGVyaW5nIGl0Lg0KPiA+DQo+ID4gRml4ZXM6IDdlODNjYWI4
MjRhOCAoInJlbW90ZXByb2M6IE1vZGlmeSByZWNvdmVyeSBwYXRoIHRvIHVzZQ0KPiBycHJvY197
c3RhcnQsc3RvcH0oKSIpDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogWGlhbmcgWGlhbyA8eGlhb3hp
YW5nNzgxMjE2QGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMb2ljIFBhbGxhcmR5IDxs
b2ljLnBhbGxhcmR5QHN0LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL3Jl
bW90ZXByb2NfdmlydGlvLmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJv
Y192aXJ0aW8uYw0KPiBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX3ZpcnRpby5jDQo+
ID4gaW5kZXggMTgzZmM0MmE1MTBhLi44OGVhZGU5OTM5NWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMNCj4gPiArKysgYi9kcml2ZXJzL3Jl
bW90ZXByb2MvcmVtb3RlcHJvY192aXJ0aW8uYw0KPiA+IEBAIC0zMzIsNiArMzMyLDggQEAgaW50
IHJwcm9jX2FkZF92aXJ0aW9fZGV2KHN0cnVjdCBycHJvY192ZGV2ICpydmRldiwNCj4gaW50IGlk
KQ0KPiA+ICAgICAgICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSAmcnZkZXYtPnZkZXY7
DQo+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gKyAgICAgICAvKiBSZXNldCB2ZGV2IHN0
cnVjdCBhcyB5b3UgZG9uJ3Qga25vdyBob3cgaXQgaGFzIGJlZW4gcHJldmlvdXNseQ0KPiB1c2Vk
ICovDQo+ID4gKyAgICAgICBtZW1zZXQodmRldiwgMCwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlKSk7DQo+ID4gICAgICAgICB2ZGV2LT5pZC5kZXZpY2UgPSBpZCwNCj4gPiAgICAgICAgIHZk
ZXYtPmNvbmZpZyA9ICZycHJvY192aXJ0aW9fY29uZmlnX29wcywNCj4gPiAgICAgICAgIHZkZXYt
PmRldi5wYXJlbnQgPSBkZXY7DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo=
