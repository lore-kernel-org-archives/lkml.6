Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C1BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C5E22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L4a5e5Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C5E22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeKOGLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:11:53 -0500
Received: from mail-eopbgr810050.outbound.protection.outlook.com ([40.107.81.50]:4096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725756AbeKOGLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXfNHRDlKyJ9gr6RUsR8qrnSNEWHMsFn+clb0YJRKZ8=;
 b=L4a5e5QniF4w+CudAneH8oL9dfPBISzDlRfB1R7EoZt4z+zc9yFW3lDVDUG1Wuv5GBGsOxyuvHb3kRflkpNzTySx5r+lsifVd9TwmruLHKAsAHD9rOg5nvBPlug0IJvd0QWIwoph11dnIyeUtxgRO/G05dvMIDu5k/ZdjrbKMEU=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1275.namprd12.prod.outlook.com (10.168.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 14 Nov 2018 20:07:07 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 20:07:07 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 03/13] arch/x86: Re-arrange RDT init code
Thread-Topic: [PATCH v7 03/13] arch/x86: Re-arrange RDT init code
Thread-Index: AQHUeG4gtVeqAbYB7UCtAL3NUjVDAqVPqTiAgAARJAA=
Date:   Wed, 14 Nov 2018 20:07:07 +0000
Message-ID: <e00c50de-f24e-5ff4-6a5b-0e8e0b918ddb@amd.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
 <20181109205153.14811-4-babu.moger@amd.com> <20181114190543.GL13926@zn.tnic>
In-Reply-To: <20181114190543.GL13926@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0084.namprd05.prod.outlook.com
 (2603:10b6:803:22::22) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1275;20:QM0R+dfllOiw8uU5xKPXuUqy+ovfaGIw7kJz+ZZsYejDoCemln+WlSZyWPGXKhtWWJG+ANOYrXuRCLayhE9qKbPs5Qx1PoUvwcBU2OveUGmuf5uQSVrm9rHLoisjcoxWvfoEShLEOti96s5M+12oVLlRvpF211IMU0ohajAPqCHOOqJzelZ8zSZAxk/4acU6jys4tWLdN4bEe1aj5xKWuRA4ePAxUlGtfey33jXTsMFBSIGVfxbYOvqFx8txVWSi
x-ms-office365-filtering-correlation-id: 48c66719-cdac-454f-06e9-08d64a6cc0a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1275;
x-ms-traffictypediagnostic: DM5PR12MB1275:
x-microsoft-antispam-prvs: <DM5PR12MB1275F2B40E6267B95E6B863495C30@DM5PR12MB1275.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1275;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1275;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(256004)(97736004)(68736007)(25786009)(71190400001)(8676002)(81166006)(81156014)(6512007)(14454004)(8936002)(6916009)(53936002)(478600001)(4326008)(72206003)(2906002)(26005)(66066001)(6436002)(54906003)(6246003)(186003)(71200400001)(316002)(52116002)(2616005)(105586002)(99286004)(76176011)(106356001)(31696002)(229853002)(86362001)(6486002)(6116002)(386003)(7736002)(476003)(3846002)(7416002)(7406005)(305945005)(6506007)(31686004)(11346002)(36756003)(486006)(53546011)(2900100001)(446003)(5660300001)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1275;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o/1V92ipMHGxoUNvR12Bg7Rz2oqq5ozI1qrFc+hL6+GgpdVCa4aJcguh3bI3dZaL64UrNjmn5qPzphDdTBkpD5cVVuRmagFuVJ1FM9+39P399Hb996VOQJiTzGXBSoyO1rTLZkWJ9+qEaYBzibwS/JKxcd1WuIdjrG11yH0rM0ePGaUh0lLTiJfCW/yHkcFlcMcA7qZjVoNUg0G0brvH1DDtLeGDpHSLY7YvomZA38KWDErgtqwA1dTGjLbRdw0Pqw9Aojo9491LFAJMBidsLdA7ckmvOOE9pRMMMpkett/FGuxISQ6Q9P+i2wXeNSDTfY3z9pgaOj5FP+pQWTAE4AODIuaPTNFN6YFE6CvBduw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEEC4C30C4AD5B4EB6657F86944A84A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c66719-cdac-454f-06e9-08d64a6cc0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 20:07:07.1363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm9yaXMsDQoNCk9uIDExLzE0LzE4IDE6MDUgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4g
T24gRnJpLCBOb3YgMDksIDIwMTggYXQgMDg6NTI6MjlQTSArMDAwMCwgTW9nZXIsIEJhYnUgd3Jv
dGU6DQo+PiBTZXBhcmF0ZSB0aGUgY2FsbCBzZXF1ZW5jZSBmb3IgcmR0X3F1aXJrcyBhbmQgTUJB
IGZlYXR1cmUuDQo+PiBUaGlzIGlzIGluIHByZXBhcmF0aW9uIHRvIGhhbmRsZSB2ZW5kb3IgZGlm
ZmVyZW5jZXMgaW4gdGhlc2UNCj4+IGNhbGwgc2VxdWVuY2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gveDg2
L2tlcm5lbC9jcHUvcmVzY3RybC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0N
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3Jlc2N0cmwuYw0KPj4gaW5kZXggNWQ1MjZkYzQ1NzUxLi5mZDUzMjBkZGRk
ZGMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwuYw0KPj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsLmMNCj4+IEBAIC03OTQsNiArNzk0LDE2IEBA
IHN0YXRpYyBib29sIF9faW5pdCByZHRfY3B1X2hhcyhpbnQgZmxhZykNCj4+ICAJcmV0dXJuIHJl
dDsNCj4+ICB9DQo+PiAgDQo+PiArc3RhdGljIF9faW5pdCBib29sIHJkdF9tYmFfY29uZmlnKHZv
aWQpDQo+PiArew0KPj4gKwlpZiAocmR0X2NwdV9oYXMoWDg2X0ZFQVRVUkVfTUJBKSkgew0KPj4g
KwkJaWYgKHJkdF9nZXRfbWVtX2NvbmZpZygmcmR0X3Jlc291cmNlc19hbGxbUkRUX1JFU09VUkNF
X01CQV0pKQ0KPj4gKwkJCXJldHVybiB0cnVlOw0KPiANCj4gT3Igc2ltcGxlcjoNCj4gDQo+ICAg
ICAgICAgaWYgKHJkdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX01CQSkpDQo+ICAgICAgICAgICAgICAg
ICByZXR1cm4gcmR0X2dldF9tZW1fY29uZmlnKCZyZHRfcmVzb3VyY2VzX2FsbFtSRFRfUkVTT1VS
Q0VfTUJBXSk7DQo+IA0KPiAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gDQo+IGFzIHJkdF9nZXRf
bWVtX2NvbmZpZygpIGFscmVhZHkgcmV0dXJucyBib29sLg0KPiANCg0KWWVzLiBXZSBjb3VsZCBk
byB0aGF0LiBXaWxsIG1vZGlmeSBpdC4NCg==
