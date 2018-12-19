Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337B0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF0D21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JBcBaVlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeLSPL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:11:58 -0500
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:40000
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728616AbeLSPL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKLMRRMJ9l/ZTRf2vU21mYg2RnznFpBIuaPBot9jTRU=;
 b=JBcBaVloVDQ6CYAz8/ntDSji4iv98/mlMur1fIR3glzYQf/v0LVDXINGzgjZ4I7R/TyYRjMRDYMBnA6EUnOp/qrA+kobLwcW7Jy12DaqTc2mQvE19KOJDAczW+rs66ahE6qtCyIWFKb/c3u099m/KnizbFYwsC3ovbjaOtTiGEw=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB0639.eurprd08.prod.outlook.com (10.163.169.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 15:11:53 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::247d:c09f:851c:c938]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::247d:c09f:851c:c938%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 15:11:52 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Dave P Martin <Dave.Martin@arm.com>,
        kbuild test robot <lkp@intel.com>
CC:     nd <nd@arm.com>, Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Thread-Topic: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Thread-Index: AQHUkYd+cKmKBO7HTkm9+VFCNK1nOqV/i8iAgATnfYCAAcQCgA==
Date:   Wed, 19 Dec 2018 15:11:52 +0000
Message-ID: <9c409567-1beb-e0cb-3efd-589a869ac7c8@arm.com>
References: <1544556407-19897-4-git-send-email-Dave.Martin@arm.com>
 <201812151729.IIgleZIH%fengguang.wu@intel.com>
 <20181218121307.GA22067@e103592.cambridge.arm.com>
In-Reply-To: <20181218121307.GA22067@e103592.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWLP265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::25) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0639;6:brOzH9TzMLcxi7SBSxO9GV3TKrmrUoXhlh2KfXEv/mH7cu52C435o7HP0vTfZ/FaEpcOsffwQAGA4RxDTAYkyR5kFMZIYPACn4uQTG8ijpLdlrmI1wjlX1zprp0CVa2fU44r7n825M0gmYkgoDCQFgmGMLaR/IR438zN9J/UqaID1K0hJY9YR0aN832JUD9DmJmwXfUSNgLIgjd//l3JBrTEnNHkBGxBBEZnLpzNtcVXRKeEkp8mBwdE4T80jFgpMRVPxPLEe+757HvOEVLT8z6TBIbyZTGD3YNYviw4b+8Hvq28XkMa7oQV2KLAvLLJ3MOOvMYELrdRY5mFemGnJqHWsamPx9OCs4fLzFcIDwrMaSdoQhtvprJ04jCQGA3iz9DBn/V1GxxgboMTUD/LJIz5QDQHWs+dxcstiQggvHw4u97u9Jn9Ms2PClNJRD25TYoothz5igncYBctLzZb+w==;5:33NLaJSXQUZta+E0g/e/Acobg9ma6wyBguI4AGeq6shiZVO+8rqwfHkwG1z8EeiisLIEhp7ser33wwiKvWuXc3BcCVm8dxUU154MA5XzyDd4zLfY4adNcrDDzrRCud38orh8PoB8CUwRS6b1ywMn4f8njqtRaP5SmIjzSLffOSQ=;7:ludp+820k0wCTGiq7bOkTCSRj1wb5RNBNCpaidHSC8qMUURjuaRWrVM0lQPQepDXqlLKUuFMVYD+uee8kkBUibtq0z1L/+zJxN8IXF2zY9pd8AjuAhz8o3kkR8941elC5hcfCjSgIgsBTSZHYhZN5w==
x-ms-office365-filtering-correlation-id: 01d27d07-4ba2-43ab-05c8-08d665c44e8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0639;
x-ms-traffictypediagnostic: VI1PR08MB0639:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB0639CF912AC5B66E2392B76AEDBE0@VI1PR08MB0639.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB0639;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0639;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(53936002)(476003)(4326008)(5024004)(14444005)(2616005)(86362001)(31686004)(31696002)(6116002)(305945005)(44832011)(6306002)(6486002)(106356001)(6246003)(3846002)(256004)(6512007)(486006)(97736004)(11346002)(105586002)(71190400001)(6436002)(71200400001)(186003)(229853002)(446003)(5660300001)(52116002)(81156014)(81166006)(36756003)(68736007)(26005)(8676002)(65826007)(66066001)(14454004)(99286004)(65806001)(65956001)(102836004)(53546011)(6506007)(386003)(345774005)(64126003)(76176011)(58126008)(316002)(54906003)(110136005)(7736002)(72206003)(966005)(478600001)(2906002)(8936002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0639;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eoWbKlilpZSAtoBC7PEm+74WX7mRLIJpOyPCw7eTgrqFHcqIlAEZ454Mn/f3XRz8R/PbYLvyNaQzLewK+XJPwEmvYYvNik55DrpkxMnNQuUz4ZNd5g29nCaN/9jEf/SRU0XW9xHjinMEp95JSPKnoyLUY9ugP90f4x2Q6bRwZRdYy0rnFzUY9rt4wJV/gsHN0FNrEhxmUSzE+z76tVZrc8SxfEfdjERfIuIY/jrHWmNtzkFDJ1Q/qUKQgOC5V+bhUP67NzYaMPnxJ+XswrWdY/BHen8pZeAOQQLGQTmBUODpI9/hzLQUTi3VrG8GmXO8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <47E72A1058A67943831F4B02188CC9E0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d27d07-4ba2-43ab-05c8-08d665c44e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:11:52.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMTIvMjAxOCAxMjoxNCwgRGF2ZSBNYXJ0aW4gd3JvdGU6DQo+IE9uIFNhdCwgRGVjIDE1
LCAyMDE4IGF0IDA1OjIwOjI5UE0gKzA4MDAsIGtidWlsZCB0ZXN0IHJvYm90IHdyb3RlOg0KPj4g
SGkgRGF2ZSwNCj4+DQo+PiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCEgUGVyaGFwcyBzb21ldGhp
bmcgdG8gaW1wcm92ZToNCj4+DQo+PiBbYXV0byBidWlsZCB0ZXN0IFdBUk5JTkcgb24gYXJtNjQv
Zm9yLW5leHQvY29yZV0NCj4+IFthbHNvIGJ1aWxkIHRlc3QgV0FSTklORyBvbiB2NC4yMC1yYzYg
bmV4dC0yMDE4MTIxNF0NCj4+IFtpZiB5b3VyIHBhdGNoIGlzIGFwcGxpZWQgdG8gdGhlIHdyb25n
IGdpdCB0cmVlLCBwbGVhc2UgZHJvcCB1cyBhIG5vdGUgdG8gaGVscCBpbXByb3ZlIHRoZSBzeXN0
ZW1dDQo+Pg0KPj4gdXJsOiAgICBodHRwczovL2dpdGh1Yi5jb20vMGRheS1jaS9saW51eC9jb21t
aXRzL0RhdmUtTWFydGluL2FybTY0LXN2ZS1VQVBJLURpc2VudGFuZ2xlLXB0cmFjZS1oLWZyb20t
c2lnY29udGV4dC1oLzIwMTgxMjE0LTIyNTE1NA0KPj4gYmFzZTogICBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hcm02NC9saW51eC5naXQgZm9yLW5leHQv
Y29yZQ0KPj4gY29uZmlnOiBhcm02NC1hbGxtb2Rjb25maWcgKGF0dGFjaGVkIGFzIC5jb25maWcp
DQo+PiBjb21waWxlcjogYWFyY2g2NC1saW51eC1nbnUtZ2NjIChEZWJpYW4gNy4yLjAtMTEpIDcu
Mi4wDQo+PiByZXByb2R1Y2U6DQo+PiAgICAgICAgIHdnZXQgaHR0cHM6Ly9yYXcuZ2l0aHVidXNl
cmNvbnRlbnQuY29tL2ludGVsL2xrcC10ZXN0cy9tYXN0ZXIvc2Jpbi9tYWtlLmNyb3NzIC1PIH4v
YmluL21ha2UuY3Jvc3MNCj4+ICAgICAgICAgY2htb2QgK3ggfi9iaW4vbWFrZS5jcm9zcw0KPj4g
ICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXggYnVpbGQgdHJlZQ0K
Pj4gICAgICAgICBHQ0NfVkVSU0lPTj03LjIuMCBtYWtlLmNyb3NzIEFSQ0g9YXJtNjQgDQo+Pg0K
Pj4gQWxsIHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+Pg0KPj4+PiAuL3Vz
ci9pbmNsdWRlL2FzbS9zdmVfY29udGV4dC5oOjMwOiBmb3VuZCBfX1t1c117OCwxNiwzMiw2NH0g
dHlwZSB3aXRob3V0ICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiANCj4gU2luY2UgdGhlIG5l
dyBoZWFkZXIgaXMgbm90IG1lYW50IHRvIGJlIGluY2x1ZGVkIGRpcmVjdGx5IChhbmQgaGFzIGEN
Cj4gZ3VhcmQgdG8gdGhhdCBlZmZlY3QpLCB3ZSBkb24ndCBzdHJpY3RseSBuZWVkIHRvIGRvIGFu
eXRoaW5nIGhlcmUuDQo+IA0KPiBUaGUgd2F5IHRvIGluY2x1ZGUgPGFzbS9zdmVfY29udGV4dC5o
PiBpbiB1c2Vyc3BhY2UgaXMgdmlhDQo+IDxhc20vc2lnY29udGV4dC5oPiBvciA8YXNtL3B0cmFj
ZS5oPiwgYm90aCBvZiB3aGljaCBpbmNsdWRlDQo+IDxsaW51eC90eXBlcy5oPiBmaXJzdC4NCj4g
DQoNCmkgdGhpbmsgdGhlcmUgaXMgbm8gbmVlZCB0byBleHBsaWNpdGx5IHByZXZlbnQgdGhlIGlu
Y2x1c2lvbiBvZg0KdGhlIGhlYWRlci4NCg0KaXQgaXMgZW5vdWdoIHRvIGhhdmUgYSBjb21tZW50
IHRoYXQgaXQncyBub3Qgc3VwcG9zZWQgdG8gYmUNCmluY2x1ZGVkIGJ5IHVzZXIgY29kZSAoc28g
dGhlIGhlYWRlciBjYW4gYmUgbGF0ZXIgcmVmYWN0b3JlZCkuDQoNCmFuZCB0aGVuIHN1Y2ggYXV0
b21hdGVkIGhlYWRlciBjaGVja3MgKG9yIHdoYXRldmVyIG90aGVyIGhhY2tzDQpwcGwgZG8gdGVt
cG9yYXJpbHkpIGNhbiBjb250aW51ZSB0byB3b3JrLg0K
