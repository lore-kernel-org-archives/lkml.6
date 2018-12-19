Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FABC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFCD21873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeLSKb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:31:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9526 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbeLSKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:31:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBJAVJlu025689;
        Wed, 19 Dec 2018 11:31:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcr8xw6dx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Dec 2018 11:31:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05A9D34;
        Wed, 19 Dec 2018 10:31:35 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D36411686;
        Wed, 19 Dec 2018 10:31:35 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 19 Dec
 2018 11:31:35 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 19 Dec 2018 11:31:35 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Topic: [PATCH 1/1] ARM: STi: Restore secondary CPU's bringup
Thread-Index: AQHUluC8wzYjRbliykengwL93mfzKqWElOMAgAAUSoCAAAZLAIABHgkA
Date:   Wed, 19 Dec 2018 10:31:35 +0000
Message-ID: <913263b2-7421-5174-2e7d-5a15df40e51e@st.com>
References: <1545144493-11600-1-git-send-email-patrice.chotard@st.com>
 <20181218155239.GP26090@n2100.armlinux.org.uk>
 <b26902d8-79d6-2b09-6e35-9e8823f9181e@st.com>
 <20181218172748.GQ26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218172748.GQ26090@n2100.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE31AC30FBF01A4EB5CCA5904A1F877B@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzc2VsbA0KDQpPbiAxMi8xOC8xOCA2OjI3IFBNLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggd3JvdGU6DQo+IE9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0IDA1OjA1OjE4UE0gKzAwMDAsIFBh
dHJpY2UgQ0hPVEFSRCB3cm90ZToNCj4+IEhpIFJ1c3NlbGwNCj4+DQo+PiBPbiAxMi8xOC8xOCA0
OjUyIFBNLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggd3JvdGU6DQo+Pj4gT24gVHVlLCBEZWMg
MTgsIDIwMTggYXQgMDM6NDg6MTNQTSArMDEwMCwgcGF0cmljZS5jaG90YXJkQHN0LmNvbSB3cm90
ZToNCj4+Pj4gRnJvbTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3QuY29tPg0K
Pj4+Pg0KPj4+PiBEdWUgdG8gcGVuX3JlbGVhc2UgYW5kIGJvb3RfbG9jayByZW1vdmFsLCBzZWNv
bmRhcnkgQ1BVJ3MgYnJpbmd1cA0KPj4+PiB3YXMgYnJva2VuLiBSZXN0b3JlIENQVSdzIGJyaW5n
dXAgYnkgcmV3b3JraW5nIHByb3Blcmx5DQo+Pj4+IC5zbXBfcHJlcGFyZV9jcHVzIGFuZCAuc21w
X2Jvb3Rfc2Vjb25kYXJ5IFNUaSBjYWxsYmFja3MuDQo+Pj4NCj4+PiBTb3JyeSwgbWF5YmUgSSBk
b24ndCB1bmRlcnN0YW5kIHlvdXIgY29tbWl0IG1lc3NhZ2UsIGJ1dCB5b3Ugc2VlbSB0byBiZQ0K
Pj4+IHNheWluZyB0aGF0IHJlbW92YWwgb2YgdGhlIHBlbl9yZWxlYXNlIGFuZCBib290X2xvY2sg
YnJva2UgU1RpJ3Mgc2Vjb25kYXJ5DQo+Pj4gQ1BVIGJyaW5nIHVwPyAgUGxlYXNlIGNsYXJpZnks
IGFuZCBleHBsYWluIGhvdyB0aGF0IGhhcHBlbmVkLg0KPj4NCj4+IENvcnJlY3QsIENQVTEgZmFp
bGVkIHRvIGNvbWUgb25saW5lLg0KPj4NCj4+IEl0IHNlZW1zIHRoYXQgd3JpdGluZyBzZWNvbmRh
cnlfc3RhcnR1cCBhZGRyZXNzIGF0IGNwdS1yZWxlYXNlLWFkZHIgaW4NCj4+IC5zbXBfcHJlcGFy
ZV9jcHVzIGNhbGxiYWNrIHdhcyB0b28gZWFybHkuDQo+Pg0KPj4gRG9pbmcgaXQgaW4gLnNtcF9i
b290X3NlY29uZGFyeSBjYWxsYmFjaywgaW5zdXJlcyB0aGF0IHNlY29uZGFyeV9kYXRhDQo+PiBz
dHJ1Y3QgaXMgcG9wdWxhdGVkIGluIF9fY3B1X3VwKCkgKHN0YWNrLCBwZ2RpciBhbmQgc3dhcHBl
cl9wZ19kaXIgZmllbGRzKS4NCj4gDQo+IEFoLCB5b3UncmUgc2F5aW5nIHRoYXQgaXQgY2F1c2Vz
IHRoZSBDUFUgdG8ganVtcCB0byBzZWNvbmRhcnlfc3RhcnR1cA0KPiB3aGlsZSB0aGUgYm9vdCBD
UFUgaXMgaW4gc21wX3ByZXBhcmVfY3B1cygpPyAgV2hhdCB0cmlnZ2VycyB0aGUgQ1BVDQoNClll
cw0KDQo+IHRvIGp1bXAgdG8gdGhlIGFkZHJlc3Mgd3JpdHRlbiB0byBjcHVfc3RydF9wdHI/ICBX
aGF0IHlvdSdyZSBzYXlpbmcNCj4gc2VlbXMgdG8gc3VnZ2VzdCB0aGF0IGl0J3MgdGhlIHdyaXRl
IHRvIHRoYXQgYWRkcmVzcywgcmF0aGVyIHRoYW4gdGhlDQo+IElQSSB0aGF0J3Mgc2VudCBpbiBz
dGlfYm9vdF9zZWNvbmRhcnkoKS4NCg0KQXQgcGxhdGZvcm0gc3RhcnR1cCwgYW4gVS1Cb290cm9t
IGZpcm13YXJlIGluaXRpYWxpemUgc2Vjb25kYXJ5IENQVSBhbmQNCm1ha2UgaXQgc3Bpbm5pbmcg
d2FpdGluZyBmb3IgYSBqdW1wIGFkZHJlc3MgdG8gYmUgd3JpdHRlbiBhdCBjcHVfc3RydF9wdHIu
DQoNCkkgZGlkbid0IHBheSBhdHRlbnRpb24gdG8gdGhlIElQSSwgeW91IGFyZSByaWdodCBJUEkg
aXMgdXNlbGVzcywgaSB3aWxsDQpyZW1vdmUgaXQuDQoNCj4gDQo+IElmIHRoZSBJUEkgaW4gc3Rp
X2Jvb3Rfc2Vjb25kYXJ5KCkgaXNuJ3QgZG9pbmcgYW55dGhpbmcsIGl0IG91Z2h0IHRvDQo+IGJl
IHJlbW92ZWQuICBJdCdkIGFsc28gYmUgYSBnb29kIGlkZWEgdG8gZG9jdW1lbnQgd2hhdCdzIGdv
aW5nIG9uIGFzDQo+IGNvbW1lbnRzIGluIHRoZSBjb2RlIGZvciBmdXR1cmUgbWFpbnRhbmVuY2Uu
DQoNCkFncmVlLCBpIHdpbGwgYWRkIGEgY29tbWVudC4NCg0KVGhhbmtzDQoNClBhdHJpY2UNCg0K
PiANCj4+IElmIHlvdSBhcmUgb2ssIGkgd2lsbCBwaWNrIHVwIHlvdXIgcGF0Y2ggWzFdIGFuZCB0
aGlzIG9uZSB0byBwcmVwYXJlIGENCj4+IFNUaSBwdWxsLXJlcXVlc3QuDQo+IA0KPiBZZXMsIGFs
dGhvdWdoIEknbGwgaGF2ZSB0byBkZWxheSBwYXRjaCA5IGFzIGEgcmVzdWx0Lg0KPiA=
