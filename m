Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C8ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316492148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nlkYj/GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316492148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeJRCZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:25:29 -0400
Received: from mail-eopbgr730061.outbound.protection.outlook.com ([40.107.73.61]:34432
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727014AbeJRCZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwnrFhRl7ZkAe1vxREIO9ki56n6p5LrVLLYA+LyRsjA=;
 b=nlkYj/GVOXCfD5nwYmEsA0BsXuskdiXG3ShGf0z3bolL3qS28daxvOQB/6E2tjVLE6Y489ASoJZilkyo98GblEC4uUhfr/b/83n227+IP4smwz97scz5BQO/J0Rut3zGI9KuaX4sgOZrhdD+IOjsNnnVK5Uxi5WyUj9obGRvLqA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1162.namprd12.prod.outlook.com (10.168.236.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 17 Oct 2018 18:28:30 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 18:28:30 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morse <james.morse@arm.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUZXHOqsT656eCL0G131BxPAQCYqUhz9GAgACE8N+AANtDgIAAgsyAgAAQsIA=
Date:   Wed, 17 Oct 2018 18:28:30 +0000
Message-ID: <feb572ec-4495-c52c-0127-213417a67c3c@amd.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
 <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
 <20181016203215.GA39177@romley-ivt3.sc.intel.com>
 <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D4D41@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F485D4D41@ORSMSX114.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0019.namprd02.prod.outlook.com
 (2603:10b6:803:2b::29) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1162;20:se1RP/Y9obcnBo3O2EGvU9n/ifIA6dZFovIhQQJKCCsyxeRCDm0pK7FU2Jc9CV+8aTg3zuyDmmV1sTzk+Z4Q2hQFlnAmTLXpHYG1/YoFtE8ZzlXetZCUGc7HV85ZuSgsIopBivTw8RVWObM3zeDbWIro6RF0XNwfaOV1Aax9eUX7NINt+1DGFNQdEb7u5FPRNtk0QZd7wbHZ23AZbN1UgioP/HRM7qQ4wtbxWRpzVonyLnuXdfCYX0LEcMS7KATP
x-ms-office365-filtering-correlation-id: 3d7aedff-3eaa-4c08-b1a5-08d6345e5686
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1162;
x-ms-traffictypediagnostic: DM5PR12MB1162:
x-microsoft-antispam-prvs: <DM5PR12MB11622DB24A3602089DFBA4BD95FF0@DM5PR12MB1162.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1162;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1162;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(72206003)(3846002)(52116002)(54906003)(6116002)(8676002)(110136005)(76176011)(14454004)(68736007)(229853002)(6436002)(6486002)(26005)(81156014)(99286004)(81166006)(102836004)(8936002)(5250100002)(186003)(71200400001)(316002)(66066001)(446003)(71190400001)(2906002)(31696002)(6246003)(2900100001)(86362001)(11346002)(31686004)(106356001)(105586002)(14444005)(256004)(5660300001)(25786009)(36756003)(6512007)(53936002)(4326008)(476003)(53546011)(7736002)(6506007)(93886005)(478600001)(386003)(97736004)(7416002)(2616005)(305945005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1162;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1Tt50GYDZ+o7MVELOzp90tcSgzAOcWVJVUr3sJjQLDzxZqVaT/k+n99RrFLe/6f7gcILMCFeJekokTPUNS7U5FXVvhNhGpc8OksMIbm/cU3ALaoV1XGyZrp/5C/TT0MsHzZhRl3Oyd+jWqITJKy7fX3zj2y80by3A0E9kAojpu98sKQESbIWjQbxzWHUWHiq9JWTMwBopxgrAHC67bLLq6NOud7P5q6P2HUzp2ZMMXz8VBX97462LsCNjJ7RGJNYtAolVWPYB39S2EEkAzsiqMs3ORgBSA++UM3HYPt5XdHbgyLLSaj0aH1gw5Fxw5JcorVvAxxDyO/asUu225Nir5Q6GXQ5ekRsAX7VMgMMacw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <23ABA5CA662CBF4297A34D8A3084ADC6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7aedff-3eaa-4c08-b1a5-08d6345e5686
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 18:28:30.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzE3LzIwMTggMTI6MjggUE0sIFByYWtoeWEsIFNhaSBQcmFuZWV0aCB3cm90ZToN
Cj4+PiBObywgdGhlIHNlbGZ0ZXN0IGluIHRoaXMgcGF0Y2ggc2V0IHdpbGwgbm90IHJlcGxhY2Ug
aW50ZWwtY210LWNhdCBvcg0KPj4+IHZpY2UgdmVyc2EuDQo+Pj4NCj4+PiBUaGUgc2VsZnRlc3Qg
aW4gdGhpcyBwYXRjaCBzZXQgaGFzIGEgZGlmZmVyZW50IHB1cnBvc2UgZnJvbSBpbnRlbC1jbXQt
Y2F0Og0KPj4+IHRoZSBzZWxmdGVzdCBpcyBhIHRlc3QgdG9vbCB3aGljaCB2YWxpZGF0ZXMgcmVz
Y3RybCBmdW5jdGlvbmFsaXRpZXMNCj4+PiB3aGlsZSBpbnRlbC1jbXQtY2F0IGlzIG1haW5seSBh
IHV0aWxpdHkgdGhhdCBwcm92aWRlcyBiYXNlIGxpYnJhcnkgZm9yDQo+Pj4gaGlnaGVyIGxldmVs
IGFwcGxpY2F0aW9ucyBpbmNsdWRpbmcgcGVyZm9ybWFuY2UgYW5hbHlzaXMgdG9vbHMsDQo+Pj4g
YmVuY2htYXJrIG1lYXN1cmVtZW50IHRvb2xzLCBhbmQgcG90ZW50aWFsIHJlc2N0cmwgdGVzdHMu
IEZvciBleGFtcGxlLA0KPj4+IHJ1bm5pbmcgTUJBIHRlc3QgaW4gdGhlIHNlbGZ0ZXN0cyB0ZWxs
cyBNQkEgd29ya2luZyBvciBub3Qgd29ya2luZw0KPj4+IChmYWlsL3Bhc3MpIHJpZ2h0IHdheS4g
VGhlDQo+Pg0KPj4gT2suIFN1cmUuIExldCBtZSB0YWtlIGEgbG9vayBhdCBzZWxmdGVzdCBjbG9z
ZWx5LiBXaWxsIHNlbmQgbXkgZmVlZGJhY2sgc29vbi4NCj4gDQo+IEdyZWF0IQ0KPiANCj4+DQo+
Pj4gaW50ZWwtY210LWNhdCBkb2Vzbid0IGhhdmUgdGhpcyB0ZXN0aW5nIGNhcGFiaWxpdHkgdW5s
ZXNzIHdlIGV4dGVuZA0KPj4+IHRoZSB0b29sLg0KPj4+DQo+Pj4gQW5kIGludGVsLWNtdC1jYXQg
aXMgbWFpbnRhaW5lZCBhbmQgZGV2ZWxvcGVkIGJ5IEludGVsLiBJIGRvbid0IHRoaW5rDQo+Pj4g
aXQncyBlYXN5IHRvIGV4dGVuZCBpdCB0byBBTUQgYW5kIEFSTSBmZWF0dXJlcy4gVGhlIHNlbGZ0
ZXN0IHdpbGwgYmUNCj4+PiBtYWludGFpbmVkDQo+Pg0KPj4gV2UxbC4uIFdlIHdlcmUgaG9waW5n
IHRvIGhhdmUgYSBjb21tb24gdG9vbCBhY3Jvc3MuIEl0IG1ha2VzIGl0IGVhc3kgZm9yDQo+PiBk
aXN0cm9zLiBQcm9iYWJseSwgd2UgY2FuIGhhdmUgYSBzZXBhcmF0ZSBkaXNjdXNzaW9uIG9uIHRo
aXMuDQo+Pg0KPiANCj4gVGhlIG1haW4gZ29hbCBvZiB0aGlzIHRlc3Qgc3VpdGUgaXMgdG8gdmFs
aWRhdGUgdmFsdWVzIHJlcG9ydGVkIGJ5IHJlc2N0cmwgZmVhdHVyZXMgDQo+IGkuZS4gd2UgbmVl
ZCBfc29tZV93YXlfIHRvIGNoZWNrIGlmIHZhbHVlcyByZXBvcnRlZCBieSByZXNjdHJsIGZlYXR1
cmVzIGFyZSANCj4gY29ycmVjdCBvciBub3QuDQo+IA0KPiBGb3IgKEludGVsKSBNZW1vcnkgQmFu
ZHdpZHRoIGZlYXR1cmVzIGxpa2UgTUJBIGFuZCBNQk0sIHBlcmYgaU1DIA0KPiAoSW50ZWdyYXRl
ZCBNZW1vcnkgQ29udHJvbGxlcikgaXMgdXNlZCBmb3IgdmFsaWRhdGlvbi4gQXMgYSBwYXJ0IG9m
IHRlc3QsIHdlIHJ1biBhIA0KPiBiZW5jaG1hcmsgKGVnOiBmaWxsX2J1ZikgYW5kIGdldCBtZW1v
cnkgYmFuZHdpZHRoIHZhbHVlcyBmcm9tIE1CTSBhbmQgaU1DIA0KPiBhbmQgdmVyaWZ5IGlmIHRo
ZSBkaWZmZXJlbmNlIGJldHdlZW4gYm90aCB0aGUgcmVwb3J0ZWQgdmFsdWVzIGFyZSBpbiBhIHJl
YXNvbmFibGUgcmFuZ2UuDQo+IA0KPiBUbyBtYWtlIHRoaXMgY29tbW9uIGFjcm9zcyB4ODYsIGNv
dWxkIHlvdSBwbGVhc2UgbGV0IHVzIGtub3cgaWYgc2ltaWxhciB0aGluZ3MgDQo+IChpLmUuIHBl
cmYgaU1DKSBleGlzdCBvbiBBTUQ/IElmIHNvLCB5b3UgY291bGQgYWRkIGl0IGluLiBUaGUgc2Ft
ZSBhcHBsaWVzIGZvciBBUk0uDQoNCldlIGRvbnQgaGF2ZSBpTUMuIFlvdSBjYW4gZ28gYWhlYWQg
d2l0aCB3aGF0IHlvdSBoYXZlIHJpZ2h0IG5vdy4gV2UgY2FuDQphZGQgdGhvc2UgZGV0YWlscyBs
YXRlciBpZiByZXF1aXJlZC4NCg0KPiANCj4gUmVnYXJkcywNCj4gU2FpDQo+IA0K
