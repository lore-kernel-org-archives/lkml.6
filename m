Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7988AC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3909720846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3909720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeGZITx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:19:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18870 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbeGZITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:19:53 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6Q749xO014012;
        Thu, 26 Jul 2018 09:04:25 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kf8sq08hv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 26 Jul 2018 09:04:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F18B938;
        Thu, 26 Jul 2018 07:04:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BDFE326E7;
        Thu, 26 Jul 2018 07:04:23 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 09:04:23 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Thu, 26 Jul 2018 09:04:23 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH 1/1] rpmsg: virtio_rpmsg_bus: Fix rpmsg_create_channel
 memory leak
Thread-Topic: [PATCH 1/1] rpmsg: virtio_rpmsg_bus: Fix rpmsg_create_channel
 memory leak
Thread-Index: AQHUJFusoeKpZGy6/UWhD8zLBFcer6SgZaGAgACvC4A=
Date:   Thu, 26 Jul 2018 07:04:23 +0000
Message-ID: <fd10ef4f445641b2b333bffa5da225f6@SFHDAG7NODE2.st.com>
References: <1532552916-30111-1-git-send-email-loic.pallardy@st.com>
 <19e8f6e7-3ee6-6606-164c-3bb953a13da5@ti.com>
In-Reply-To: <19e8f6e7-3ee6-6606-164c-3bb953a13da5@ti.com>
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

SGkgU3VtYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4g
QW5uYSA8cy1hbm5hQHRpLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMjYsIDIwMTggMTI6
MzcgQU0NCj4gVG86IExvaWMgUEFMTEFSRFkgPGxvaWMucGFsbGFyZHlAc3QuY29tPjsgYmpvcm4u
YW5kZXJzc29uQGxpbmFyby5vcmc7DQo+IG9oYWRAd2l6ZXJ5LmNvbQ0KPiBDYzogbGludXgtcmVt
b3RlcHJvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IEFybmF1ZCBQT1VMSVFVRU4gPGFybmF1ZC5wb3VsaXF1ZW5Ac3QuY29tPjsNCj4gYmVuamFtaW4u
Z2FpZ25hcmRAbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gcnBtc2c6IHZp
cnRpb19ycG1zZ19idXM6IEZpeA0KPiBycG1zZ19jcmVhdGVfY2hhbm5lbCBtZW1vcnkgbGVhaw0K
PiANCj4gSGkgTG9pYywNCj4gDQo+IE9uIDA3LzI1LzIwMTggMDQ6MDggUE0sIExvaWMgUGFsbGFy
ZHkgd3JvdGU6DQo+ID4gSW4gY2FzZSBvZiBycG1zZ19yZWdpc3Rlcl9kZXZpY2UoKSBmYWlsdXJl
LCB2Y2ggcHJldmlvdXNseQ0KPiA+IGFsbG9jYXRlZCBtdXN0IGJlIGZyZWUuDQo+ID4NCj4gDQo+
IElzbid0IHRoaXMgYWxyZWFkeSBoYW5kbGVkIHRocm91Z2ggdGhlIHZpcnRpb19ycG1zZ19yZWxl
YXNlX2RldmljZSgpDQo+IGNhbGxiYWNrIGFzIHBhcnQgb2YgdGhlIHB1dF9kZXZpY2UoKSBpbiBy
cG1zZ19yZWdpc3Rlcl9kZXZpY2UoKSBmYWlsdXJlLg0KDQpZZXMgeW91J3JlIHJpZ2h0LCBwdXRf
ZGV2aWNlKCkgaXMgZG9pbmcgdGhlIGpvYi4NClBsZWFzZSBmb3JnZXQgdGhpcyBwYXRjaC4NCg0K
UmVnYXJkcywNCkxvaWMgDQoNCj4gDQo+IHJlZ2FyZHMNCj4gU3VtYW4NCj4gDQo+ID4gZml4ZXM6
IDZlZWQ1OThhMDQ5MSAoInJwbXNnOiBTcGxpdCBvZmYgZ2VuZXJpYyB0YWlsIG9mIGNyZWF0ZV9j
aGFubmVsKCkiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9pYyBQYWxsYXJkeSA8bG9pYy5w
YWxsYXJkeUBzdC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcnBtc2cvdmlydGlvX3JwbXNn
X2J1cy5jIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JwbXNnL3ZpcnRpb19y
cG1zZ19idXMuYw0KPiBiL2RyaXZlcnMvcnBtc2cvdmlydGlvX3JwbXNnX2J1cy5jDQo+ID4gaW5k
ZXggNjY0Zjk1Ny4uMTBmOTI3ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JwbXNnL3ZpcnRp
b19ycG1zZ19idXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcnBtc2cvdmlydGlvX3JwbXNnX2J1cy5j
DQo+ID4gQEAgLTQzMSw4ICs0MzEsMTAgQEAgc3RhdGljIHN0cnVjdCBycG1zZ19kZXZpY2UNCj4g
KnJwbXNnX2NyZWF0ZV9jaGFubmVsKHN0cnVjdCB2aXJ0cHJvY19pbmZvICp2cnAsDQo+ID4gIAly
cGRldi0+ZGV2LnBhcmVudCA9ICZ2cnAtPnZkZXYtPmRldjsNCj4gPiAgCXJwZGV2LT5kZXYucmVs
ZWFzZSA9IHZpcnRpb19ycG1zZ19yZWxlYXNlX2RldmljZTsNCj4gPiAgCXJldCA9IHJwbXNnX3Jl
Z2lzdGVyX2RldmljZShycGRldik7DQo+ID4gLQlpZiAocmV0KQ0KPiA+ICsJaWYgKHJldCkgew0K
PiA+ICsJCWtmcmVlKHZjaCk7DQo+ID4gIAkJcmV0dXJuIE5VTEw7DQo+ID4gKwl9DQo+ID4NCj4g
PiAgCXJldHVybiBycGRldjsNCj4gPiAgfQ0KPiA+DQoNCg==
