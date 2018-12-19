Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783FF20643
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aFGYuWMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeLSP1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:27:39 -0500
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:10976
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbeLSP1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKzO2DKYdfPuaAt8X8cUBcMQtDyX88eYsSUGu337ZrA=;
 b=aFGYuWMv27+DypeTtTduEbtTmnqPf5JOxCeWOz6oG+VSSjevJOEs8jMjtWcYNQWJXL9jPxJDxJyVrVMD1d9jHbS9Y5YRXkv+K224WztZX+ZgVdX8eSwTSjURf+XQADBFTWo+ch0FtROl5IGyvEZ0+sf1QEimryUcfWGLYg9wcY0=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB3632.eurprd08.prod.outlook.com (20.177.61.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Wed, 19 Dec 2018 15:26:52 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::247d:c09f:851c:c938]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::247d:c09f:851c:c938%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 15:26:52 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Dave P Martin <Dave.Martin@arm.com>
CC:     nd <nd@arm.com>, kbuild test robot <lkp@intel.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Thread-Topic: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Thread-Index: AQHUkYd+cKmKBO7HTkm9+VFCNK1nOqV/i8iAgATnfYCAAcQCgIAAA0QAgAAA6oA=
Date:   Wed, 19 Dec 2018 15:26:52 +0000
Message-ID: <0bd88c97-c93b-2589-7ac6-49d30fd9ae97@arm.com>
References: <1544556407-19897-4-git-send-email-Dave.Martin@arm.com>
 <201812151729.IIgleZIH%fengguang.wu@intel.com>
 <20181218121307.GA22067@e103592.cambridge.arm.com>
 <9c409567-1beb-e0cb-3efd-589a869ac7c8@arm.com>
 <20181219152332.GC22067@e103592.cambridge.arm.com>
In-Reply-To: <20181219152332.GC22067@e103592.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0379.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::31) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3632;6:GVbf1o5MAGqaDPBprToEc16n0i6o69peIj8N0AZSZc9fYJjOedKpF7ixKH22KFgozkPAAp/uj759gEbKJOHz7hEQSAApnHJwj2IoIpwJ/gPPhXGY86LcwoYL8jmEp5LiIKhRyZHgNIGya+UMl56JCgeh2tIKSDonvs2MXdY6OzKR76gAsGqjdiAJ85W4kJV72H7C9OYR7zTgD1b9cq8ojWkn7XEXqU9a6k3kYvjOJiHUxB8ypf/TgPMGuQOF/dFN8yXh1sr6cNheCTd26Z6pK9U7Kx0iM0rqcG5eVE5GY+PqTKPeyEz/BE2YWnvQ3QUHN1N9cA++X+PYZRTSSOQQjAAc/Yh8lbp3k3fwnACWIspmdyaXhUNBh29lJ1z5XiZlI2tD0LzLbjK/mv4tvIwYY5ubTK+uCe9R6qu1SJ3OSWJlWkmKx2k6VGvO2941DGD31zUy9x/8QfFBNdtmaS6nig==;5:R/gmlwMqeIhPwMRqyiK8tQ+Vp3KQEdH1WHCEXgSI8YHyfhYVNqHVoNejCuyo51NR1km7EEf7Cb4SpFdMGslyoBK9AZBXwczQ0MHaEnNJpOCq4Q50LSsOhAWpyPXyjvQjiP6QZvFktQPltD5QdxkHmqsKxTRMfDLWqgpaslepfn4=;7:LJCyIiWy0otruAwHWiiSkqvrnIc/aBUjTu9hxHVNIM20ULxZ5BuRdwTqpcX4MB2Ew1F9ZHCTNJrArqyyheeasc1bOzq3ZcucwregvOOalRIjT0lAxDtnC4HGnx9ZB1hOlUR5dIA9771L9rMdD9CCZA==
x-ms-office365-filtering-correlation-id: f634f223-9d81-42d6-95d4-08d665c66657
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3632;
x-ms-traffictypediagnostic: VI1PR08MB3632:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB3632DBD308074450DD419F69EDBE0@VI1PR08MB3632.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3632;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3632;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(76176011)(5660300001)(86362001)(93886005)(186003)(386003)(102836004)(53546011)(6506007)(65956001)(26005)(66066001)(65806001)(478600001)(72206003)(54906003)(58126008)(37006003)(14454004)(71190400001)(36756003)(71200400001)(99286004)(52116002)(6436002)(316002)(31696002)(65826007)(7736002)(31686004)(6862004)(6246003)(2616005)(476003)(305945005)(11346002)(446003)(81156014)(486006)(106356001)(105586002)(97736004)(44832011)(4326008)(6636002)(256004)(8676002)(229853002)(6512007)(6486002)(64126003)(68736007)(53936002)(25786009)(8936002)(14444005)(81166006)(6116002)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3632;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KA0GZKxVbQPLe8nR0jgbVuLLclillwcJSdn6BZke5WGXyoinVOBD+kW84bfuQq/GlKS4ElDpM2JWz7xtd9UoM0KZdLCbk4IKV+xlXzL801e/pnIOYoH+c/Ql26hz4WF3LXqy79W+BsoobBsvHvsryyBmnhsAWJGh8pB75pPE7moDxQ6YOHayEm0nX9EQk/psdxAqc7axO60h5rAWqu8TYu6Sfr/RPaeTV1B7QhfOBpbrzzUxFNtoSLudRcInZDsy//CIPIaDMwGgULnVeqxWG3+uwe1lIGzCGgdKASoangKqRgDX9cw6toUpo4URz/70
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA1E50E50B85C54AB8B99C103B86A96D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f634f223-9d81-42d6-95d4-08d665c66657
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:26:52.0700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMTIvMjAxOCAxNToyMywgRGF2ZSBNYXJ0aW4gd3JvdGU6DQo+IE9uIFdlZCwgRGVjIDE5
LCAyMDE4IGF0IDAzOjExOjUyUE0gKzAwMDAsIFN6YWJvbGNzIE5hZ3kgd3JvdGU6DQo+PiBPbiAx
OC8xMi8yMDE4IDEyOjE0LCBEYXZlIE1hcnRpbiB3cm90ZToNCj4+PiBPbiBTYXQsIERlYyAxNSwg
MjAxOCBhdCAwNToyMDoyOVBNICswODAwLCBrYnVpbGQgdGVzdCByb2JvdCB3cm90ZToNCj4gDQo+
IFsuLi5dDQo+IA0KPj4+Pj4+IC4vdXNyL2luY2x1ZGUvYXNtL3N2ZV9jb250ZXh0Lmg6MzA6IGZv
dW5kIF9fW3VzXXs4LDE2LDMyLDY0fSB0eXBlIHdpdGhvdXQgI2luY2x1ZGUgPGxpbnV4L3R5cGVz
Lmg+DQo+Pj4NCj4+PiBTaW5jZSB0aGUgbmV3IGhlYWRlciBpcyBub3QgbWVhbnQgdG8gYmUgaW5j
bHVkZWQgZGlyZWN0bHkgKGFuZCBoYXMgYQ0KPj4+IGd1YXJkIHRvIHRoYXQgZWZmZWN0KSwgd2Ug
ZG9uJ3Qgc3RyaWN0bHkgbmVlZCB0byBkbyBhbnl0aGluZyBoZXJlLg0KPj4+DQo+Pj4gVGhlIHdh
eSB0byBpbmNsdWRlIDxhc20vc3ZlX2NvbnRleHQuaD4gaW4gdXNlcnNwYWNlIGlzIHZpYQ0KPj4+
IDxhc20vc2lnY29udGV4dC5oPiBvciA8YXNtL3B0cmFjZS5oPiwgYm90aCBvZiB3aGljaCBpbmNs
dWRlDQo+Pj4gPGxpbnV4L3R5cGVzLmg+IGZpcnN0Lg0KPj4+DQo+Pg0KPj4gaSB0aGluayB0aGVy
ZSBpcyBubyBuZWVkIHRvIGV4cGxpY2l0bHkgcHJldmVudCB0aGUgaW5jbHVzaW9uIG9mDQo+PiB0
aGUgaGVhZGVyLg0KPj4NCj4+IGl0IGlzIGVub3VnaCB0byBoYXZlIGEgY29tbWVudCB0aGF0IGl0
J3Mgbm90IHN1cHBvc2VkIHRvIGJlDQo+PiBpbmNsdWRlZCBieSB1c2VyIGNvZGUgKHNvIHRoZSBo
ZWFkZXIgY2FuIGJlIGxhdGVyIHJlZmFjdG9yZWQpLg0KPj4NCj4+IGFuZCB0aGVuIHN1Y2ggYXV0
b21hdGVkIGhlYWRlciBjaGVja3MgKG9yIHdoYXRldmVyIG90aGVyIGhhY2tzDQo+PiBwcGwgZG8g
dGVtcG9yYXJpbHkpIGNhbiBjb250aW51ZSB0byB3b3JrLg0KPiANCj4gVGhlIGd1YXJkIGlzIGlu
IGxpbnV4LW5leHQgbm93IEFGQUlLLg0KPiANCj4gQXJlIHlvdSBzYXlpbmcgdGhhdCBpdCdzIGxp
a2VseSB0byBicmVhayBzb21ldGhpbmcgYW5kIG5lZWRzIHRvIGJlDQo+IHJlbW92ZWQsIG9yIGl0
IGlzIHVubmVjZXNzYXJ5IGJ1dCBoYXJtbGVzcz8NCg0KdW5uZWNlc3NhcnkgYnV0IGhhcm1sZXNz
Lg0KDQooaSBhc3N1bWVkIHRoZSBoZWFkZXIgY2hlY2sgYm90IHdvdWxkIHdhbnQgdG8gaW5jbHVk
ZSBldmVyeQ0KaGVhZGVyIG9uIGl0cyBvd24gYW5kIHNlZSBpZiB0aGVyZSBhcmUgdW5kZWZpbmVk
IHN5bWJvbHMsIGJ1dA0KaWYgaXQgd29ya3Mgd2l0aCB0aGUgZ3VhcmQgdGhlbiBmaW5lKQ0K
