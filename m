Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F68C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACC3206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aTiMPi0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfAJICw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:02:52 -0500
Received: from mail-eopbgr770051.outbound.protection.outlook.com ([40.107.77.51]:43040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfAJICv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGrxz0jT6vklAEhTBFOjyNo0/mwnJIczHYSwo/P0tIA=;
 b=aTiMPi0wWyLNGBfDihO1IYAvFkPpLUIwW52GtSxwk4kULl7LOtWh4PqDbpt1EkuxcrYrVkCc+68lbSaxldmIODddZquIhL8WELUdxqol1MwnJ5FdYRe8pxufpP1JXjV+Q6CcmGhcOVSVSk9HYIDQxh27iUYFqAnp6sNsHESj3bM=
Received: from BYAPR12MB3237.namprd12.prod.outlook.com (20.179.93.25) by
 BYAPR12MB2855.namprd12.prod.outlook.com (20.179.90.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 10 Jan 2019 08:02:47 +0000
Received: from BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5]) by BYAPR12MB3237.namprd12.prod.outlook.com
 ([fe80::a96e:ffd:3bd6:c5f5%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 08:02:47 +0000
From:   S@vger.kernel.org
To:     Borislav Petkov <bp@alien8.de>, "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/mce/amd: Extend "Disable error thresholding bank
 4" to more models
Thread-Topic: [PATCH 1/2] x86/mce/amd: Extend "Disable error thresholding bank
 4" to more models
Thread-Index: AQHUpnT248JJI+5Ktk6P4uPYiZ1p96Wnfv4AgACtbgA=
Date:   Thu, 10 Jan 2019 08:02:47 +0000
Message-ID: <808faebf-f708-65d0-fd86-ab2ec2234fdd@amd.com>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-2-git-send-email-shirish.s@amd.com>
 <20190109215454.GJ15665@zn.tnic>
In-Reply-To: <20190109215454.GJ15665@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::20) To BYAPR12MB3237.namprd12.prod.outlook.com
 (2603:10b6:a03:136::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.56.249.162]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2855;20:CeOwkojI4zcXQcPGcX1nA8KP6ehl+COBZ4HCrMWbqUHXV/jhrsuJcqmTH7XjcJds3CiLCUFhvj8XMltQ/9vx+lxE7dL3QE6p6lkmHtw4AT/mrscUAXd+1uT88sM6bynel4fm4EhgE4E49IKlYTWanJ7Oy3Qo7WWPvs7CLumeLDSqnimGpTE1b6ddQ8ne6ujycw7Yw4izSpFKCNoGqk+cpGV/iBcA8b/3vh12B1/pV/zl1jP4FDRN2ktmg2BUei7S
x-ms-office365-filtering-correlation-id: 6d8e0da3-1480-426b-4b4e-08d676d20249
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2855;
x-ms-traffictypediagnostic: BYAPR12MB2855:
x-microsoft-antispam-prvs: <BYAPR12MB285526DADAB932A424B798CFF2840@BYAPR12MB2855.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(186003)(99286004)(386003)(2906002)(102836004)(66066001)(256004)(6506007)(26005)(76176011)(486006)(53546011)(7736002)(15650500001)(3846002)(68736007)(31696002)(5660300001)(52116002)(6116002)(97736004)(305945005)(4326008)(316002)(8936002)(8676002)(476003)(81166006)(478600001)(36756003)(2616005)(6486002)(71190400001)(71200400001)(31686004)(54906003)(110136005)(6246003)(6636002)(72206003)(25786009)(446003)(6512007)(6306002)(105586002)(106356001)(966005)(229853002)(6436002)(53936002)(14454004)(81156014)(4744005)(11346002)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2855;H:BYAPR12MB3237.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XB9Woa4k24eaG0053QzSrUGw9rWLm8CwTlLg58KpdIVMSX4BNB9srOSh9LH6boYXx53n+vLkw68o+1blwETOTUaqti/mC6Jok64HdOxG7Bt4EB6MjfbewjYUG8JiFhNwQgBLPqQ93Gz5uOWbuyZxU9wnmf5tqiC/Q0X7eN31/xtdcfCJVeUCdKNvT6JwVQoLfYFABiRUNOIXR57SE6dhewbLdrKxCYCoMNZZy8LM0hCxTtDYOIcrgdoeNVpZP3gNm5EB+cp2P/Il07I8QJkIwzvKf5Tfj6tODikzzqc+M3rsBVUkJ8UuI8GOQNLHf57s
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <268A98D16F5A1145BFB675D913735858@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8e0da3-1480-426b-4b4e-08d676d20249
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 08:02:47.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXNsYXYsDQoNCk9uIDEvMTAvMjAxOSAzOjI0IEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3Jv
dGU6DQo+IE9uIE1vbiwgSmFuIDA3LCAyMDE5IGF0IDEwOjM3OjE3QU0gKzAwMDAsIFMsIFNoaXJp
c2ggd3JvdGU6DQo+PiBUaGUgYmVsb3cgcGF0Y2ggYWRkZWQgdGhpcyBxdWlyayBvbmx5IGZvciB0
aGUgZmlyc3QgZ2VuZXJhdGlvbiBvZiBmYW1pbHkNCj4+IDE1IHByb2Nlc3NvcnMsIG92ZXIgdGlt
ZSBpdHMgbm90aWNlZCB0aGF0IGl0cyByZXF1aXJlZCBmb3IgbGF0ZXINCj4+IGdlbmVyYXRpb25z
IHRvby4NCj4+DQo+PiAiNTc1MjAzYjQ3NDdjIHg4NiwgTUNFLCBBTUQ6IERpc2FibGUgZXJyb3Ig
dGhyZXNob2xkaW5nIGJhbmsgNCBvbiBzb21lDQo+PiBtb2RlbHMiDQo+Pg0KPj4gVGhpcyBwYXRj
aCBleHRlbmRzIHRoZSBxdWlyayB0byBtYWtlIGl0IGFwcGxpY2FibGUgdGlsbCA3dGggR2VuZXJh
dGlvbiwNCj4gQXZvaWQgaGF2aW5nICJUaGlzIHBhdGNoIiBvciAiVGhpcyBjb21taXQiIGluIHRo
ZSBjb21taXQgbWVzc2FnZS4gSXQgaXMNCj4gdGF1dG9sb2dpY2FsbHkgdXNlbGVzcy4NCg0KQWdy
ZWUsIGhhdmUgbWFkZSB0aGUgY2hhbmdlcyBhbmQgcmUtc3B1biByZS1zcHVuIHYyIGhlcmU6IA0K
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvMS8xMC82OQ0KDQpJIHdhbnRlZCB0byBzZW5kIHRo
ZSBwYXRjaCB3aXRoIHlvdSBpbiByZWNpcGllbnQgZmllbGQgcmF0aGVyIHRoYW4gY2MsIA0KdW5m
b3J0dW5hdGVseSAtLWNjIHJlbWFpbmVkIGluIHRoZSBnaXQtc2VuZCBjb21tYW5kDQoNCnRoYXQg
aSB1c2VkLCBsZXQgbWUga25vdyBpIG5lZWQgdG8gcmUtc2VuZCBpdCBvciB5b3UgY2FuIHNlZSB0
aGUgcGF0Y2guDQoNClRoYW5rcy4NCg0KUmVnYXJkcywNCg0KU2hpcmlzaCBTDQoNCj4gQWxzbywg
ZG8NCj4NCj4gJCBnaXQgZ3JlcCAnVGhpcyBwYXRjaCcgRG9jdW1lbnRhdGlvbi9wcm9jZXNzDQo+
DQo+IGZvciBtb3JlIGRldGFpbHMuDQo+DQotLSANClJlZ2FyZHMsDQpTaGlyaXNoIFMNCg0K
