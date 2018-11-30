Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E24C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB61A2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB61A2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeLAH67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:58:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35817 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbeLAH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:58:58 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAUKdhK0022268;
        Fri, 30 Nov 2018 21:48:20 +0100
Received: from beta.dmz-us.st.com (beta.dmz-us.st.com [167.4.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p35mnj93g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 30 Nov 2018 21:48:20 +0100
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.16.71])
        by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id 6C24F26;
        Fri, 30 Nov 2018 20:04:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id D0309BDA;
        Fri, 30 Nov 2018 20:48:16 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 30 Nov
 2018 21:48:15 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Fri, 30 Nov 2018 21:48:16 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Suman Anna <s-anna@ti.com>
Subject: RE: [PATCH 4/7] remoteproc: add warning on resource table cast
Thread-Topic: [PATCH 4/7] remoteproc: add warning on resource table cast
Thread-Index: AQHUiCqsscWCqS23tUSPBHNf8AkNUqVoUjmAgAB36bA=
Date:   Fri, 30 Nov 2018 20:48:16 +0000
Message-ID: <cdcc435066ff48aebc9b02e7e0b13c8f@SFHDAG7NODE2.st.com>
References: <1543526968-56091-1-git-send-email-loic.pallardy@st.com>
 <1543526968-56091-5-git-send-email-loic.pallardy@st.com>
 <CAK8P3a25Y3y1Zjtf18i6Tgt83npLvbCeBvcd-r1+u8ijp=X2Yw@mail.gmail.com>
In-Reply-To: <CAK8P3a25Y3y1Zjtf18i6Tgt83npLvbCeBvcd-r1+u8ijp=X2Yw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogdmVuZHJlZGkgMzAgbm92ZW1icmUgMjAxOCAxNTozMw0K
PiBUbzogTG9pYyBQQUxMQVJEWSA8bG9pYy5wYWxsYXJkeUBzdC5jb20+DQo+IENjOiBCam9ybiBB
bmRlcnNzb24gPGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnPjsgT2hhZCBCZW4tQ29oZW4NCj4g
PG9oYWRAd2l6ZXJ5LmNvbT47IGxpbnV4LXJlbW90ZXByb2NAdmdlci5rZXJuZWwub3JnOyBMaW51
eCBLZXJuZWwNCj4gTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsg
QXJuYXVkIFBPVUxJUVVFTg0KPiA8YXJuYXVkLnBvdWxpcXVlbkBzdC5jb20+OyBCZW5qYW1pbiBH
YWlnbmFyZA0KPiA8YmVuamFtaW4uZ2FpZ25hcmRAbGluYXJvLm9yZz47IFN1bWFuIEFubmEgPHMt
YW5uYUB0aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC83XSByZW1vdGVwcm9jOiBhZGQg
d2FybmluZyBvbiByZXNvdXJjZSB0YWJsZSBjYXN0DQo+IA0KPiBPbiBUaHUsIE5vdiAyOSwgMjAx
OCBhdCAxMDozMSBQTSBMb2ljIFBhbGxhcmR5IDxsb2ljLnBhbGxhcmR5QHN0LmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBUb2RheSByZXNvdXJjZSB0YWJsZSBzdXBwb3J0cyBvbmx5IDMyYml0IGFkZHJl
c3MgZmllbGRzLg0KPiA+IFRoaXMgaXMgbm90IGNvbXBsaWFudCB3aXRoIDY0Yml0IHBsYXRmb3Jt
IGZvciB3aGljaCBhZGRyZXNzZXMNCj4gPiBhcmUgY2FzdCBpbiAzMmJpdC4NCj4gPiBUaGlzIHBh
dGNoIGFkZHMgd2FybiBtZXNzYWdlcyB3aGVuIGFkZHJlc3MgY2FzdCBpcyBkb25lLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTG9pYyBQYWxsYXJkeSA8bG9pYy5wYWxsYXJkeUBzdC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYyB8IDggKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiBiL2RyaXZl
cnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+IGluZGV4IDE4YTFiYmY4MjBjOS4u
NjFjOTU0YmQ2OTVlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVw
cm9jX2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUu
Yw0KPiA+IEBAIC03NzIsNiArNzcyLDEwIEBAIHN0YXRpYyBpbnQgcnByb2NfYWxsb2NfY2FydmVv
dXQoc3RydWN0IHJwcm9jICpycHJvYywNCj4gPiAgICAgICAgICAgICAgICAgZGV2X2RiZyhkZXYs
ICJjYXJ2ZW91dCBtYXBwZWQgMHgleCB0byAlcGFkXG4iLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIG1lbS0+ZGEsICZkbWEpOw0KPiA+ICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAg
ICAgICAgICAgLyogVXBkYXRlIGRldmljZSBhZGRyZXNzIGFzIHVuZGVmaW5lZCBieSByZXF1ZXN0
ZXIgKi8NCj4gPiArICAgICAgICAgICAgICAgaWYgKHNpemVvZihkbWFfYWRkcl90KSA+IHNpemVv
Zih1MzIpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIkRNQSBh
ZGRyZXNzIGNhc3QgaW4gMzJiaXQgdG8gZml0IHJlc291cmNlIHRhYmxlDQo+IGZvcm1hdFxuIik7
DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICBtZW0tPmRhID0gKHUzMilkbWE7DQo+ID4gICAg
ICAgICB9DQo+IA0KPiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgd3Jvbmc6IHNpemVvZihkbWFfYWRk
cl90KSBpcyBkZWZpbmVkIHRvIGJlIGxhcmdlIGVub3VnaA0KPiB0byBzdXBwb3J0IGFueSBtYWNo
aW5lIHRoYXQgdGhlIGtlcm5lbCBjYW4gcnVuIG9uLiBJZiB5b3UgYnVpbGQgYSBrZXJuZWwgdGhh
dA0KPiBoYXBwZW5zIHRvIHdvcmsgb24gYW4gQVJNMzIgcGxhdGZvcm0gd2l0aCBMUEFFIGVuYWJs
ZWQsIHRoZW4gdGhpcyB3aWxsDQo+IHdhcm4gZXZlcnkgdGltZSwgZXZlbiBpZiB5b3UgYXJlIHJ1
bm5pbmcgb24gYSBtYWNoaW5lIHRoYXQgb25seSBoYXMgYSAzMi1iaXQNCj4gYWRkcmVzcyBzcGFj
ZS4NCg0KSSBzdXBwb3NlIGlmIExQQUUgaXMgZW5hYmxlZCwgYWRkcmVzcyBzcGFjZSBpcyBsYXJn
ZXIgdGhhbiAzMmJpdC4NCkJ1dCBJIGFncmVlIGl0IGlzIHBvc3NpYmxlIHRvIGRpc3BsYXkgYSB3
YXJuIG9ubHkgd2hlbiBzb21lIGluZm9ybWF0aW9uIHdpbGwgYmUgbG9zdA0KZHVlIHRvIGNhc3Qu
DQpJJ2xsIHByb3Bvc2UgYSBuZXcgdmVyc2lvbiB0ZXN0aW5nIGRtYSBhZGRyZXNzIGl0c2VsZiBh
bmQgZGlzcGxheWluZyB3YXJuIG9ubHkgaWYgYWJvdmUgNEdCLg0KDQpSZWdhcmRzLA0KTG9pYw0K
PiANCj4gICAgICBBcm5kDQo=
