Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087CCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FD3217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeLSMPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:15:11 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9074 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728771AbeLSMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:15:10 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBJBtbn6025321;
        Wed, 19 Dec 2018 13:14:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pegxj2n88-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Dec 2018 13:14:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 805D631;
        Wed, 19 Dec 2018 12:14:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6727525FB;
        Wed, 19 Dec 2018 12:14:38 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 19 Dec
 2018 13:14:38 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 19 Dec 2018 13:14:38 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Topic: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Index: AQHUluC8wzYjRbliykengwL93mfzKqWElOMAgAAUSoCAAAZLAIABHgkAgAAP6wCAAAzggA==
Date:   Wed, 19 Dec 2018 12:14:38 +0000
Message-ID: <becad78d-2f00-46a7-a42f-5558d173d23b@st.com>
References: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
 <20181218155239.GP26090@n2100.armlinux.org.uk>
 <b26902d8-79d6-2b09-6e35-9e8823f9181e@st.com>
 <20181218172748.GQ26090@n2100.armlinux.org.uk>
 <913263b2-7421-5174-2e7d-5a15df40e51e@st.com>
 <20181219112832.GT26090@n2100.armlinux.org.uk>
In-Reply-To: <20181219112832.GT26090@n2100.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <460BAC9213CA594991D264FFBEF4CEEB@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTkvMTggMTI6MjggUE0sIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMTksIDIwMTggYXQgMTA6MzE6MzVBTSArMDAwMCwgUGF0cmljZSBDSE9UQVJE
IHdyb3RlOg0KPj4gSGkgUnVzc2VsbA0KPj4NCj4+IE9uIDEyLzE4LzE4IDY6MjcgUE0sIFJ1c3Nl
bGwgS2luZyAtIEFSTSBMaW51eCB3cm90ZToNCj4+PiBPbiBUdWUsIERlYyAxOCwgMjAxOCBhdCAw
NTowNToxOFBNICswMDAwLCBQYXRyaWNlIENIT1RBUkQgd3JvdGU6DQo+Pj4+IEhpIFJ1c3NlbGwN
Cj4+Pj4NCj4+Pj4gT24gMTIvMTgvMTggNDo1MiBQTSwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4
IHdyb3RlOg0KPj4+Pj4gT24gVHVlLCBEZWMgMTgsIDIwMTggYXQgMDM6NDg6MTNQTSArMDEwMCwg
cGF0cmljZS5jaG90YXJkQHN0LmNvbSB3cm90ZToNCj4+Pj4+PiBGcm9tOiBQYXRyaWNlIENob3Rh
cmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQo+Pj4+Pj4NCj4+Pj4+PiBEdWUgdG8gcGVuX3Jl
bGVhc2UgYW5kIGJvb3RfbG9jayByZW1vdmFsLCBzZWNvbmRhcnkgQ1BVJ3MgYnJpbmd1cA0KPj4+
Pj4+IHdhcyBicm9rZW4uIFJlc3RvcmUgQ1BVJ3MgYnJpbmd1cCBieSByZXdvcmtpbmcgcHJvcGVy
bHkNCj4+Pj4+PiAuc21wX3ByZXBhcmVfY3B1cyBhbmQgLnNtcF9ib290X3NlY29uZGFyeSBTVGkg
Y2FsbGJhY2tzLg0KPj4+Pj4NCj4+Pj4+IFNvcnJ5LCBtYXliZSBJIGRvbid0IHVuZGVyc3RhbmQg
eW91ciBjb21taXQgbWVzc2FnZSwgYnV0IHlvdSBzZWVtIHRvIGJlDQo+Pj4+PiBzYXlpbmcgdGhh
dCByZW1vdmFsIG9mIHRoZSBwZW5fcmVsZWFzZSBhbmQgYm9vdF9sb2NrIGJyb2tlIFNUaSdzIHNl
Y29uZGFyeQ0KPj4+Pj4gQ1BVIGJyaW5nIHVwPyAgUGxlYXNlIGNsYXJpZnksIGFuZCBleHBsYWlu
IGhvdyB0aGF0IGhhcHBlbmVkLg0KPj4+Pg0KPj4+PiBDb3JyZWN0LCBDUFUxIGZhaWxlZCB0byBj
b21lIG9ubGluZS4NCj4+Pj4NCj4+Pj4gSXQgc2VlbXMgdGhhdCB3cml0aW5nIHNlY29uZGFyeV9z
dGFydHVwIGFkZHJlc3MgYXQgY3B1LXJlbGVhc2UtYWRkciBpbg0KPj4+PiAuc21wX3ByZXBhcmVf
Y3B1cyBjYWxsYmFjayB3YXMgdG9vIGVhcmx5Lg0KPj4+Pg0KPj4+PiBEb2luZyBpdCBpbiAuc21w
X2Jvb3Rfc2Vjb25kYXJ5IGNhbGxiYWNrLCBpbnN1cmVzIHRoYXQgc2Vjb25kYXJ5X2RhdGENCj4+
Pj4gc3RydWN0IGlzIHBvcHVsYXRlZCBpbiBfX2NwdV91cCgpIChzdGFjaywgcGdkaXIgYW5kIHN3
YXBwZXJfcGdfZGlyIGZpZWxkcykuDQo+Pj4NCj4+PiBBaCwgeW91J3JlIHNheWluZyB0aGF0IGl0
IGNhdXNlcyB0aGUgQ1BVIHRvIGp1bXAgdG8gc2Vjb25kYXJ5X3N0YXJ0dXANCj4+PiB3aGlsZSB0
aGUgYm9vdCBDUFUgaXMgaW4gc21wX3ByZXBhcmVfY3B1cygpPyAgV2hhdCB0cmlnZ2VycyB0aGUg
Q1BVDQo+Pg0KPj4gWWVzDQo+Pg0KPj4+IHRvIGp1bXAgdG8gdGhlIGFkZHJlc3Mgd3JpdHRlbiB0
byBjcHVfc3RydF9wdHI/ICBXaGF0IHlvdSdyZSBzYXlpbmcNCj4+PiBzZWVtcyB0byBzdWdnZXN0
IHRoYXQgaXQncyB0aGUgd3JpdGUgdG8gdGhhdCBhZGRyZXNzLCByYXRoZXIgdGhhbiB0aGUNCj4+
PiBJUEkgdGhhdCdzIHNlbnQgaW4gc3RpX2Jvb3Rfc2Vjb25kYXJ5KCkuDQo+Pg0KPj4gQXQgcGxh
dGZvcm0gc3RhcnR1cCwgYW4gVS1Cb290cm9tIGZpcm13YXJlIGluaXRpYWxpemUgc2Vjb25kYXJ5
IENQVSBhbmQNCj4+IG1ha2UgaXQgc3Bpbm5pbmcgd2FpdGluZyBmb3IgYSBqdW1wIGFkZHJlc3Mg
dG8gYmUgd3JpdHRlbiBhdCBjcHVfc3RydF9wdHIuDQo+Pg0KPj4gSSBkaWRuJ3QgcGF5IGF0dGVu
dGlvbiB0byB0aGUgSVBJLCB5b3UgYXJlIHJpZ2h0IElQSSBpcyB1c2VsZXNzLCBpIHdpbGwNCj4+
IHJlbW92ZSBpdC4NCj4gDQo+IE9rYXksIGluIHRoYXQgY2FzZSBtYXkgSSBzdWdnZXN0IGFuIGFs
dGVybmF0aXZlIHRvIHRha2luZyBteSBwYXRjaA0KPiB3aGljaCB3aWxsIGJyZWFrIHRoaXMsIGFu
ZCB0aGVuIGZpeGluZyBpdCBpbiBhIHN1YnNlcXVlbnQgcGF0Y2ggLQ0KPiBwbGVhc2UgbWVyZ2Ug
dGhlIHR3byBwYXRjaGVzIHRvZ2V0aGVyIHNvIGl0IGJlY29tZXMgb25lICJjbGVhbiB1cCINCj4g
cGF0Y2ggd2hpY2ggZG9lc24ndCBjYXVzZSBhbnkgYnJlYWthZ2UuDQo+IA0KPiBUaGFua3MuDQo+
IA0KDQpPaywgYWdyZWUgd2l0aCB5b3VyIHByb3Bvc2FsLiBJIHdpbGwgc3F1YXNoIG91ciAyIHBh
dGNoZXMuDQoNClRoYW5rcw0KDQpQYXRyaWNl
