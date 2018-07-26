Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849A020894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849A020894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeGZIYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:24:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54241 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbeGZIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:24:43 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6Q6xIj9005394;
        Thu, 26 Jul 2018 09:09:14 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kbt9xf8fe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 26 Jul 2018 09:09:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0166E3A;
        Thu, 26 Jul 2018 07:09:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A3273274D;
        Thu, 26 Jul 2018 07:09:13 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 09:09:13 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Thu, 26 Jul 2018 09:09:13 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH 1/1] rpmsg: virtio_rpmsg_bus: Fix rpmsg_remove() release
 order
Thread-Topic: [PATCH 1/1] rpmsg: virtio_rpmsg_bus: Fix rpmsg_remove() release
 order
Thread-Index: AQHUJFt/s/sahtCVQEG8l9qPPXI3kKSgZGMAgACupBA=
Date:   Thu, 26 Jul 2018 07:09:13 +0000
Message-ID: <41d5058358014bbd8ab4329ecb5355f6@SFHDAG7NODE2.st.com>
References: <1532552826-30003-1-git-send-email-loic.pallardy@st.com>
 <d9b7192b-2fc7-664f-d9a5-b90c8644b991@ti.com>
In-Reply-To: <d9b7192b-2fc7-664f-d9a5-b90c8644b991@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4gQW5uYSA8cy1h
bm5hQHRpLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMjYsIDIwMTggMTI6MzIgQU0NCj4g
VG86IExvaWMgUEFMTEFSRFkgPGxvaWMucGFsbGFyZHlAc3QuY29tPjsgYmpvcm4uYW5kZXJzc29u
QGxpbmFyby5vcmc7DQo+IG9oYWRAd2l6ZXJ5LmNvbQ0KPiBDYzogbGludXgtcmVtb3RlcHJvY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEFybmF1ZCBQ
T1VMSVFVRU4gPGFybmF1ZC5wb3VsaXF1ZW5Ac3QuY29tPjsNCj4gYmVuamFtaW4uZ2FpZ25hcmRA
bGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gcnBtc2c6IHZpcnRpb19ycG1z
Z19idXM6IEZpeCBycG1zZ19yZW1vdmUoKQ0KPiByZWxlYXNlIG9yZGVyDQo+IA0KPiBIaSBMb2lj
LA0KPiANCj4gT24gMDcvMjUvMjAxOCAwNDowNyBQTSwgTG9pYyBQYWxsYXJkeSB3cm90ZToNCj4g
PiBJbiBycG1zZ19yZW1vdmUoKSBwcm9jZWR1cmUsIGNoaWxkcmVuIGFyZSByZW1vdmVkIHRoZW4g
TmFtZQ0KPiA+IFNlcnZpY2UgYW5ub3VuY2VtZW50IGVuZHBvaW50IGlzIGRlc3Ryb3llZCBhbmQg
ZGV2aWNlIHJlbGVhc2VkLg0KPiA+DQo+ID4gSXNzdWUgd2l0aCBjdXJyZW50IGltcGxlbWVudGF0
aW9uIGlzIGlmIGEgTlMgYW5ub3VuY2VtZW50DQo+ID4gY3JlYXRpb24gcmVxdWVzdCBpcyBvbmdv
aW5nIChyZWNlaXZlZCBiZWZvcmUgdmlydGlvIHJlc2V0KSwNCj4gPiBjaGlsZCBkZXZpY2UgY291
bGQgYmUgY3JlYXRlZCBhZnRlciBjaGlsZHJlbiByZW1vdmluZy4NCj4gPiBJbiB0aGF0IGNhc2Ug
cnBtc2dfcmVtb3ZlKCkgaXMgZnJlZWluZyBycG1zZ192aXJ0aW9fYnVzLA0KPiA+IGxlYWRpbmcg
dG8gYW4gaW5jb25zaXN0ZW50IHN0YXRlLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyBkZXN0cm95
aW5nIE5TIGFubm91bmNlbWVudCBzZXJ2aWNlIGVuZHBvaW50IGJlZm9yZQ0KPiA+IHJlbW92aW5n
IGNoaWxkcmVuIHRvIGd1YXJhbnRlZSB0aGF0IGxpc3Qgb2YgY2hpbGQgZGV2aWNlcyBpcw0KPiA+
IGZpeGVkIGFuZCBhbGwgb2YgdGhlbSB3aWxsIGJlIGNvcnJlY3RseSByZW1vdmVkIGJlZm9yZSBj
bGVhbmluZw0KPiA+IHJlc291cmNlcy4NCj4gDQo+IEkgZG8gbm90IHRoaW5rIHRoaXMgaXMgdGhl
IHJpZ2h0IGZpeCBmb3IgdGhlIHByb2JsZW0geW91IGV4cGxhaW5lZC4NCj4gVGhlIHJlbW92YWwg
b2YgcnBtc2cgZGV2aWNlcyBjYW4gYWN0dWFsbHkgaW52b2tlIHRoZSBhbm5vdW5jZV9kZXN0cm95
DQo+IGluIHRoZSBycG1zZ19kZXZfcmVtb3ZlKCkuDQoNClllcyBpdCB3YXMgb25lIG9mIG15IGlu
dGVycm9nYXRpb24gY29ycmVjdGluZyBpdCBsaWtlIHRoYXQuIEJ1dCBhcyB2aXJ0aW8gbGluayBo
YXMgYmVlbiBwdXQgaW4gcmVzZXQgc3RhdGUganVzdCBiZWZvcmUsIG5vIG1lc3NhZ2UgY291bGQg
YmUgc2VudCB0byBjb3Byb2Nlc3Nvci4uLg0KT3RoZXIgcG9zc2libGUgY29ycmVjdGlvbiAobWF5
YmUgbGVzcyBlbGVnYW50KSwga2VlcGluZyBjdXJyZW50IG9yZGVyLCBpcyB0byBpbnRyb2R1Y2Ug
YSBycG1zZyBidXMgInN0YXR1cyIgdGhhdCB3aWxsIGJlIGNoZWNrZWQgYmVmb3JlIHJlZ2lzdGVy
aW5nIG5ldyBkZXZpY2UuDQpBbnl3YXksIHdlIG5lZWQgdG8gcHJldmVudCBuZXcgcnBtc2cgZGV2
aWNlIHJlZ2lzdGVyIGFmdGVyIGNoaWxkcmVuIHJlbW92YWwgdG8gYXZvaWQgb3JwaGFuIGRldmlj
ZS4NCg0KUmVnYXJkcywNCkxvaWMNCj4gDQo+IHJlZ2FyZHMNCj4gU3VtYW4NCj4gDQo+ID4NCj4g
PiBmaXhlczogYmNhYmJjY2FiZmZlICgicnBtc2c6IFNwbGl0IG9mZiBnZW5lcmljIHRhaWwgb2Yg
Y3JlYXRlX2NoYW5uZWwoKSIpDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMb2ljIFBhbGxhcmR5
IDxsb2ljLnBhbGxhcmR5QHN0LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ycG1zZy92aXJ0
aW9fcnBtc2dfYnVzLmMgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnBt
c2cvdmlydGlvX3JwbXNnX2J1cy5jDQo+IGIvZHJpdmVycy9ycG1zZy92aXJ0aW9fcnBtc2dfYnVz
LmMNCj4gPiBpbmRleCA2NjRmOTU3Li5mNWQ0ODFmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cnBtc2cvdmlydGlvX3JwbXNnX2J1cy5jDQo+ID4gKysrIGIvZHJpdmVycy9ycG1zZy92aXJ0aW9f
cnBtc2dfYnVzLmMNCj4gPiBAQCAtMTAwNCwxMyArMTAwNCwxMyBAQCBzdGF0aWMgdm9pZCBycG1z
Z19yZW1vdmUoc3RydWN0IHZpcnRpb19kZXZpY2UNCj4gKnZkZXYpDQo+ID4NCj4gPiAgCXZkZXYt
PmNvbmZpZy0+cmVzZXQodmRldik7DQo+ID4NCj4gPiArCWlmICh2cnAtPm5zX2VwdCkNCj4gPiAr
CQlfX3JwbXNnX2Rlc3Ryb3lfZXB0KHZycCwgdnJwLT5uc19lcHQpOw0KPiA+ICsNCj4gPiAgCXJl
dCA9IGRldmljZV9mb3JfZWFjaF9jaGlsZCgmdmRldi0+ZGV2LCBOVUxMLA0KPiBycG1zZ19yZW1v
dmVfZGV2aWNlKTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJZGV2X3dhcm4oJnZkZXYtPmRldiwg
ImNhbid0IHJlbW92ZSBycG1zZyBkZXZpY2U6ICVkXG4iLA0KPiByZXQpOw0KPiA+DQo+ID4gLQlp
ZiAodnJwLT5uc19lcHQpDQo+ID4gLQkJX19ycG1zZ19kZXN0cm95X2VwdCh2cnAsIHZycC0+bnNf
ZXB0KTsNCj4gPiAtDQo+ID4gIAlpZHJfZGVzdHJveSgmdnJwLT5lbmRwb2ludHMpOw0KPiA+DQo+
ID4gIAl2ZGV2LT5jb25maWctPmRlbF92cXModnJwLT52ZGV2KTsNCj4gPg0KDQo=
