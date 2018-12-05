Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A92C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C7320878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C7320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeLEOnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:43:15 -0500
Received: from mail-eopbgr720064.outbound.protection.outlook.com ([40.107.72.64]:62496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbeLEOnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDS/CpyQiotw0wHnstDnO05wzbKWIFZFy3qMpJ4geN4=;
 b=L7v6PDEZIHo6ktX9n/r17bUwZllphHxSrXz7t9ulM3nLbkGrZN8O7wzDj5PcQUvkFj287tGDiB+fT0D7g9d0hSeKfDxNS+yY/LuxOk3szFI2gukJCuVrFOvEjVkFnes+0Ot4xxQmTdaEXp0UtQODHo/bFaJrV2OAn6p1JRYFC5E=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0192.namprd12.prod.outlook.com (10.162.3.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 14:43:10 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 14:43:10 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/umip: Make the UMIP activated message generic
Thread-Topic: [PATCH] x86/umip: Make the UMIP activated message generic
Thread-Index: AQHUjCCFH8x+LgP8GkWS/ubsimhkSKVvxTKAgAB0OIA=
Date:   Wed, 5 Dec 2018 14:43:09 +0000
Message-ID: <cfdd7539-577a-7c86-4347-ff3982b0a18a@amd.com>
References: <20181204222718.9375.11043.stgit@tlendack-t1.amdoffice.net>
 <20181205074709.GA105592@gmail.com>
In-Reply-To: <20181205074709.GA105592@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:805:a2::46) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0192;20:TOzTWQact9TBN6/S+ndRZaAWLFB5JgkZt1Cqp6Sn0s+ehhGFMOgVlwSf5B1fvo7n3sCOzkuS1FGj/S/5aJfJQwAC5LYG72kf9sUK7imn3lMD1fo0FGLN3P3lZ617zUoEoILS32XXxNxJk+oEZWEMqoakN/jMjAiurLGdq/BFJd+9XQpb/EV8kZFZqRH7Lw1XTYYtskGT4b2sd0DN6O3W/D0lFCqWEw5E789qyeBZdkH9D76nNatSHwCcxd28GMyK
x-ms-office365-filtering-correlation-id: f1e217c1-ecbf-49e4-972d-08d65abff9b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0192;
x-ms-traffictypediagnostic: SN1PR12MB0192:
x-microsoft-antispam-prvs: <SN1PR12MB0192B4B75177257D02FD3A9DECA80@SN1PR12MB0192.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0192;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0192;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(26005)(7736002)(54906003)(305945005)(86362001)(6486002)(5660300001)(316002)(256004)(14444005)(6246003)(6436002)(3846002)(31696002)(6116002)(72206003)(66066001)(478600001)(6916009)(99286004)(486006)(15650500001)(2906002)(106356001)(229853002)(52116002)(2616005)(8676002)(386003)(76176011)(6506007)(53546011)(97736004)(4326008)(14454004)(476003)(36756003)(446003)(71200400001)(105586002)(53936002)(25786009)(68736007)(186003)(102836004)(8936002)(71190400001)(6512007)(81156014)(11346002)(31686004)(81166006)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0192;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cw4/mSqpKlDm/FBaG3/2R6tuGSSAOGs3Qr51yI1Wqalt9AmNHG4fgykgalVc+emvxyTNBou4fkY4hUVebv8nF2nLzPuDo6SrDLAWk/5szoU5pK1AmZKas45lrStIafEbPZOHY4d/bQw+944DkJwzw9FAOl6TxvTJON9pztQ6rtR6FbgI4bnjCBajvuKU19H5rty6RcAhRTGctMza7H/roUmajz167GLlEjNgRgA2g1NLVV4N+mYhkyAzsUP76tIWIhYHsiRwoV9mfwp+oUeC0J4upxCPuoeKmX+O9Jf+q4XkdALEfaZA07MxbOtkwoXxejEjhegAWaA7mzTEIyfBuBg4PjigKSz0Ig7RxkRQqL0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <642416E4E7342E49B00E89D705691F4E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e217c1-ecbf-49e4-972d-08d65abff9b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 14:43:10.0681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDUvMjAxOCAwMTo0NyBBTSwgSW5nbyBNb2xuYXIgd3JvdGU6DQo+IA0KPiAqIExlbmRh
Y2t5LCBUaG9tYXMgPFRob21hcy5MZW5kYWNreUBhbWQuY29tPiB3cm90ZToNCj4gDQo+PiBUaGUg
VXNlciBNb2RlIEluc3RydWN0aW9uIFByZXZlbnRpb24gKFVNSVApIGZlYXR1cmUgaXMgcGFydCBv
ZiB0aGUgeDg2XzY0DQo+PiBpbnN0cnVjdGlvbiBzZXQgYXJjaGl0ZWN0dXJlIGFuZCBub3Qgc3Bl
Y2lmaWMgdG8gSW50ZWwuICBNYWtlIHRoZSBtZXNzYWdlDQo+PiBnZW5lcmljLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQo+PiAt
LS0NCj4+DQo+PiBUaGlzIHBhdGNoIGlzIGFnYWluc3QgdGhlIHg4Ni9jcHUgYnJhbmNoIG9mIHRo
ZSB0aXAgdHJlZToNCj4+ICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RpcC90aXAuZ2l0IHg4Ni9jcHUNCj4+DQo+PiAgYXJjaC94ODYva2VybmVsL2NwdS9j
b21tb24uYyB8ICAgIDIgKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4+IGluZGV4IDJjNTZiODAuLmNi
MjhlOTggMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+PiBAQCAtMzUzLDcgKzM1Myw3IEBA
IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBzZXR1cF91bWlwKHN0cnVjdCBjcHVpbmZvX3g4
NiAqYykNCj4+ICANCj4+ICAJY3I0X3NldF9iaXRzKFg4Nl9DUjRfVU1JUCk7DQo+PiAgDQo+PiAt
CXByX2luZm9fb25jZSgieDg2L2NwdTogSW50ZWwgVXNlciBNb2RlIEluc3RydWN0aW9uIFByZXZl
bnRpb24gKFVNSVApIGFjdGl2YXRlZFxuIik7DQo+PiArCXByX2luZm9fb25jZSgieDg2L2NwdTog
VXNlciBNb2RlIEluc3RydWN0aW9uIFByZXZlbnRpb24gKFVNSVApIGFjdGl2YXRlZFxuIik7DQo+
IA0KPiBJcyB0aGVyZSBhbnkgcHVibGljIGluZm9ybWF0aW9uIGFib3V0IHdoaWNoIEFNRCBDUFVz
IGFyZSBnb2luZyB0byBzdXBwb3J0IA0KPiBpdD8NCg0KTm8gcHVibGljIGluZm9ybWF0aW9uIHll
dC4uLg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4gVGhlIGxhdGVzdCBBTUQgQ1BVIEkgY2FuIHRl
c3Qgb24gaXMgYSBSeXplbiBUaHJlYWRyaXBwZXIgMTk1MFgsIGFuZCB0aGF0IA0KPiBkb2Vzbid0
IGhhdmUgVU1JUC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IAlJbmdvDQo+IA0K
