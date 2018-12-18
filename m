Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F37BC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDBB218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeLRRFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:05:51 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17199 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbeLRRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:05:50 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBIGuQcD014917;
        Tue, 18 Dec 2018 18:05:25 +0100
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcr8xrwem-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Dec 2018 18:05:25 +0100
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 632494B;
        Tue, 18 Dec 2018 17:05:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5EF6D344;
        Tue, 18 Dec 2018 17:05:19 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Dec
 2018 18:05:18 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 18 Dec 2018 18:05:18 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Topic: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Index: AQHUluC8wzYjRbliykengwL93mfzKqWElOMAgAAUSoA=
Date:   Tue, 18 Dec 2018 17:05:18 +0000
Message-ID: <b26902d8-79d6-2b09-6e35-9e8823f9181e@st.com>
References: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
 <20181218155239.GP26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218155239.GP26090@n2100.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C0CCED9A72FBD41981080411894C864@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzc2VsbA0KDQpPbiAxMi8xOC8xOCA0OjUyIFBNLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggd3JvdGU6DQo+IE9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0IDAzOjQ4OjEzUE0gKzAxMDAsIHBh
dHJpY2UuY2hvdGFyZEBzdC5jb20gd3JvdGU6DQo+PiBGcm9tOiBQYXRyaWNlIENob3RhcmQgPHBh
dHJpY2UuY2hvdGFyZEBzdC5jb20+DQo+Pg0KPj4gRHVlIHRvIHBlbl9yZWxlYXNlIGFuZCBib290
X2xvY2sgcmVtb3ZhbCwgc2Vjb25kYXJ5IENQVSdzIGJyaW5ndXANCj4+IHdhcyBicm9rZW4uIFJl
c3RvcmUgQ1BVJ3MgYnJpbmd1cCBieSByZXdvcmtpbmcgcHJvcGVybHkNCj4+IC5zbXBfcHJlcGFy
ZV9jcHVzIGFuZCAuc21wX2Jvb3Rfc2Vjb25kYXJ5IFNUaSBjYWxsYmFja3MuDQo+IA0KPiBTb3Jy
eSwgbWF5YmUgSSBkb24ndCB1bmRlcnN0YW5kIHlvdXIgY29tbWl0IG1lc3NhZ2UsIGJ1dCB5b3Ug
c2VlbSB0byBiZQ0KPiBzYXlpbmcgdGhhdCByZW1vdmFsIG9mIHRoZSBwZW5fcmVsZWFzZSBhbmQg
Ym9vdF9sb2NrIGJyb2tlIFNUaSdzIHNlY29uZGFyeQ0KPiBDUFUgYnJpbmcgdXA/ICBQbGVhc2Ug
Y2xhcmlmeSwgYW5kIGV4cGxhaW4gaG93IHRoYXQgaGFwcGVuZWQuDQoNCkNvcnJlY3QsIENQVTEg
ZmFpbGVkIHRvIGNvbWUgb25saW5lLg0KDQpJdCBzZWVtcyB0aGF0IHdyaXRpbmcgc2Vjb25kYXJ5
X3N0YXJ0dXAgYWRkcmVzcyBhdCBjcHUtcmVsZWFzZS1hZGRyIGluDQouc21wX3ByZXBhcmVfY3B1
cyBjYWxsYmFjayB3YXMgdG9vIGVhcmx5Lg0KDQpEb2luZyBpdCBpbiAuc21wX2Jvb3Rfc2Vjb25k
YXJ5IGNhbGxiYWNrLCBpbnN1cmVzIHRoYXQgc2Vjb25kYXJ5X2RhdGENCnN0cnVjdCBpcyBwb3B1
bGF0ZWQgaW4gX19jcHVfdXAoKSAoc3RhY2ssIHBnZGlyIGFuZCBzd2FwcGVyX3BnX2RpciBmaWVs
ZHMpLg0KDQpJZiB5b3UgYXJlIG9rLCBpIHdpbGwgcGljayB1cCB5b3VyIHBhdGNoIFsxXSBhbmQg
dGhpcyBvbmUgdG8gcHJlcGFyZSBhDQpTVGkgcHVsbC1yZXF1ZXN0Lg0KDQpUaGFua3MNCg0KUGF0
cmljZQ0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDcyOTQ3OS8N
Cg0KPiANCj4gVGhhbmtzLg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXRyaWNlIENob3Rh
cmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL2FybS9tYWNoLXN0
aS9wbGF0c21wLmMgfCAzMSArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXN0aS9wbGF0c21wLmMgYi9hcmNoL2FybS9tYWNoLXN0
aS9wbGF0c21wLmMNCj4+IGluZGV4IDIxNjY4NTAuLjliZmM5M2EgMTAwNjQ0DQo+PiAtLS0gYS9h
cmNoL2FybS9tYWNoLXN0aS9wbGF0c21wLmMNCj4+ICsrKyBiL2FyY2gvYXJtL21hY2gtc3RpL3Bs
YXRzbXAuYw0KPj4gQEAgLTI4LDggKzI4LDIxIEBADQo+PiAgDQo+PiAgI2luY2x1ZGUgInNtcC5o
Ig0KPj4gIA0KPj4gK3N0YXRpYyB1MzIgX19pb21lbSAqY3B1X3N0cnRfcHRyOw0KPj4gKw0KPj4g
IHN0YXRpYyBpbnQgc3RpX2Jvb3Rfc2Vjb25kYXJ5KHVuc2lnbmVkIGludCBjcHUsIHN0cnVjdCB0
YXNrX3N0cnVjdCAqaWRsZSkNCj4+ICB7DQo+PiArCXVuc2lnbmVkIGxvbmcgZW50cnlfcGEgPSBf
X3BhX3N5bWJvbChzZWNvbmRhcnlfc3RhcnR1cCk7DQo+PiArDQo+PiArCV9fcmF3X3dyaXRlbChl
bnRyeV9wYSwgY3B1X3N0cnRfcHRyKTsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogd21iIHNvIHRo
YXQgZGF0YSBpcyBhY3R1YWxseSB3cml0dGVuDQo+PiArCSAqIGJlZm9yZSBjYWNoZSBmbHVzaCBp
cyBkb25lDQo+PiArCSAqLw0KPj4gKwlzbXBfd21iKCk7DQo+PiArCXN5bmNfY2FjaGVfdyhjcHVf
c3RydF9wdHIpOw0KPj4gKw0KPj4gIAkvKg0KPj4gIAkgKiBTZW5kIHRoZSBzZWNvbmRhcnkgQ1BV
IGEgc29mdCBpbnRlcnJ1cHQsIHRoZXJlYnkgY2F1c2luZw0KPj4gIAkgKiBpdCB0byBqdW1wIHRv
IHRoZSBzZWNvbmRhcnkgZW50cnlwb2ludC4NCj4+IEBAIC00MywxMCArNTYsOCBAQCBzdGF0aWMg
dm9pZCBfX2luaXQgc3RpX3NtcF9wcmVwYXJlX2NwdXModW5zaWduZWQgaW50IG1heF9jcHVzKQ0K
Pj4gIHsNCj4+ICAJc3RydWN0IGRldmljZV9ub2RlICpucDsNCj4+ICAJdm9pZCBfX2lvbWVtICpz
Y3VfYmFzZTsNCj4+IC0JdTMyIF9faW9tZW0gKmNwdV9zdHJ0X3B0cjsNCj4+ICAJdTMyIHJlbGVh
c2VfcGh5czsNCj4+ICAJaW50IGNwdTsNCj4+IC0JdW5zaWduZWQgbG9uZyBlbnRyeV9wYSA9IF9f
cGFfc3ltYm9sKHNlY29uZGFyeV9zdGFydHVwKTsNCj4+ICANCj4+ICAJbnAgPSBvZl9maW5kX2Nv
bXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiYXJtLGNvcnRleC1hOS1zY3UiKTsNCj4+ICANCj4+
IEBAIC03NCw4ICs4NSw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzdGlfc21wX3ByZXBhcmVfY3B1
cyh1bnNpZ25lZCBpbnQgbWF4X2NwdXMpDQo+PiAgCQl9DQo+PiAgDQo+PiAgCQkvKg0KPj4gLQkJ
ICogaG9sZGluZyBwZW4gaXMgdXN1YWxseSBjb25maWd1cmVkIGluIFNCQyBETUVNIGJ1dCBjYW4g
YWxzbyBiZQ0KPj4gLQkJICogaW4gUkFNLg0KPj4gKwkJICogY3B1LXJlbGVhc2UtYWRkciBpcyB1
c3VhbGx5IGNvbmZpZ3VyZWQgaW4gU0JDIERNRU0gYnV0IGNhbg0KPj4gKwkJICogYWxzbyBiZSBp
biBSQU0uDQo+PiAgCQkgKi8NCj4+ICANCj4+ICAJCWlmICghbWVtYmxvY2tfaXNfbWVtb3J5KHJl
bGVhc2VfcGh5cykpDQo+PiBAQCAtODUsMTcgKzk2LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHN0
aV9zbXBfcHJlcGFyZV9jcHVzKHVuc2lnbmVkIGludCBtYXhfY3B1cykNCj4+ICAJCQljcHVfc3Ry
dF9wdHIgPQ0KPj4gIAkJCQkodTMyIF9faW9tZW0gKilwaHlzX3RvX3ZpcnQocmVsZWFzZV9waHlz
KTsNCj4+ICANCj4+IC0JCV9fcmF3X3dyaXRlbChlbnRyeV9wYSwgY3B1X3N0cnRfcHRyKTsNCj4+
IC0NCj4+IC0JCS8qDQo+PiAtCQkgKiB3bWIgc28gdGhhdCBkYXRhIGlzIGFjdHVhbGx5IHdyaXR0
ZW4NCj4+IC0JCSAqIGJlZm9yZSBjYWNoZSBmbHVzaCBpcyBkb25lDQo+PiAtCQkgKi8NCj4+IC0J
CXNtcF93bWIoKTsNCj4+IC0JCXN5bmNfY2FjaGVfdyhjcHVfc3RydF9wdHIpOw0KPj4gLQ0KPj4g
LQkJaWYgKCFtZW1ibG9ja19pc19tZW1vcnkocmVsZWFzZV9waHlzKSkNCj4+IC0JCQlpb3VubWFw
KGNwdV9zdHJ0X3B0cik7DQo+PiArCQlzZXRfY3B1X3Bvc3NpYmxlKGNwdSwgdHJ1ZSk7DQo+PiAg
CX0NCj4+ICB9DQo+PiAgDQo+PiAtLSANCj4+IDEuOS4xDQo+Pg0KPiA=
