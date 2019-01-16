Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A78C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9310120675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y0Q5h5Fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404959AbfAPPgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:36:12 -0500
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:10414
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394114AbfAPPgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeQqKDhrXBZh6E36+tihef+OWPwih/UW6g1ExUx+HA0=;
 b=y0Q5h5Fp8zoyVEyNFe9cZsL3HSLiCXo0Dp24ZAuc6S72rZ4TUsTtNM+1yizh6KmmyZCz19gVy80og95eEcN34n8dUHUOqwxdtBh/vo0yTBp3Gg/pRX9CALN/INdTWpHNt5PYGAlCnmoYB5Ay8dISf9ae0GOfAnuDBocH/Yb6a1U=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3501.namprd12.prod.outlook.com (20.178.241.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Wed, 16 Jan 2019 15:36:06 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f%3]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:36:05 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: RE: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume path
 as well
Thread-Topic: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Thread-Index: AQHUpnT6RX1zZkZcBk29IptIsRwq2qWngtqAgACqJYCABm8wAIAAVaaA///+GACAAMwsgIAA5geAgAFw8AD////KgIAABEdAgAABm8A=
Date:   Wed, 16 Jan 2019 15:36:04 +0000
Message-ID: <MN2PR12MB32489679E5F65DB808E10664F2820@MN2PR12MB3248.namprd12.prod.outlook.com>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
 <20190109220843.GK15665@zn.tnic>
 <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
 <20190114103312.GG2773@zn.tnic>
 <2ad4bb63-2b70-3652-3261-009cdbfc15a9@amd.com>
 <20190114153256.GM2773@zn.tnic>
 <4f8b532b-8613-feb5-7474-4bb0462cf1c7@amd.com>
 <20190115172659.GE6596@zn.tnic>
 <8bed39c8-df48-dbb9-3674-dfbc4aea2967@amd.com>
 <20190116152643.GH15409@zn.tnic>
 <MN2PR12MB32483E9CDA510F1B58617DFFF2820@MN2PR12MB3248.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB32483E9CDA510F1B58617DFFF2820@MN2PR12MB3248.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-originating-ip: [49.206.9.151]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3501;20:1kyMlDxwtMpBrbGdTTPujTu+q1cntfLBBCH6Ue1sAQDg9n7S3bz2H3airUoFeD73Bit+jhXC7azB7Tf/9AIJgg+lGpoM67kPsnL9bbfaXPVX6AYXkE9/ZgQXCZvU1wcZpc8LwHNngDnPs/K7lEZy/cB3msyeEILZvHpq9pyP5yMs9BjHXg8nGG4k/N7qvABAf7hqHNhcOWKOi1PSQbcyhcgfyC8P+q1U+vBit+ulAoQHORx/agHKLZZd4CyRbPA9
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(13464003)(26005)(186003)(9686003)(54906003)(71200400001)(446003)(6246003)(93886005)(86362001)(97736004)(476003)(11346002)(316002)(53936002)(53546011)(55236004)(71190400001)(33656002)(6506007)(76176011)(102836004)(25786009)(66066001)(7696005)(6306002)(2906002)(4326008)(486006)(256004)(966005)(72206003)(99286004)(478600001)(68736007)(14454004)(106356001)(6916009)(6116002)(105586002)(93156006)(3846002)(55016002)(74316002)(6436002)(5660300001)(7736002)(8936002)(2940100002)(229853002)(81156014)(8676002)(81166006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3501;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: e9d35454-60c3-4fdd-7d9f-08d67bc853eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3501;
x-ms-traffictypediagnostic: MN2PR12MB3501:
x-microsoft-antispam-prvs: <MN2PR12MB3501C215F31433BCF70CB6BFF2820@MN2PR12MB3501.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GlTkOOwi6KYmDmQjVfI2EpBA9dOd6Mi/ZVBGlofZy7ur0quaToCtlI6dWw4Vufiyp3+yRH7f0oSMhAHvXiKxnxzu37egZbmJflWWPajRGOL7U1Xff0GVU4pQFA7HlOqqa5XuSw5H0by5FQodz+FpQqkjJS2XNgfwwaYsvbz99Qy4ZXQBu1bFnrjafqpliEYnS+zdXczyR9E22jh8HFtHBDiCrntCNggfwGKEatVTQLQXCLfRShv/kf+frDxzYwMBBvDV4s+8g1sD2YDKrDm5xum3IYtwwflNg4Ev6TnabjYHL9tLPIW5DsA1ZjCIWS6zCWoYRZmrPRjk0Z9IyFica5Z0A6cwLY/eAfkyiZJebGlmV/UXyqynyAKarvsuPNyXeKdAcvcM5dTF/j36HlFEKJILqPEYk4hdqJQwLKLfVOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d35454-60c3-4fdd-7d9f-08d67bc853eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:36:04.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBiZWxpZXZlIGl0cyBmaXhlZCBub3cgaW4gOiANCg0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MTkvMS8xNi81MDcNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEvMTYvNTA4DQoNCkkgZG9u
4oCZdCBzZWUgU0B2Z2VyIC4uLiBpbiB0aGUgRnJvbSBmaWVsZCBpbiB0aGUgYWJvdmUgbGlua3Mg
aW5zdGVhZCBJIHNlZSAiUywgU2hpcmlzaCIgPD4NCg0KDQpSZWdhcmRzLA0KU2hpcmlzaCBTDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTLCBTaGlyaXNoIA0KU2VudDogV2Vk
bmVzZGF5LCBKYW51YXJ5IDE2LCAyMDE5IDk6MDEgUE0NClRvOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IElu
Z28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgSCAuIFBldGVyIEFudmluIDxocGFAenl0b3Iu
Y29tPjsgbWFpbnRhaW5lciA6IFg4NiBBUkNISVRFQ1RVUkUgPHg4NkBrZXJuZWwub3JnPjsgVG9u
eSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJt
YUBpbnRlbC5jb20+OyBvcGVuIGxpc3QgOiBYODYgQVJDSElURUNUVVJFIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgTGVuZGFja3ksIFRob21hcyA8VGhvbWFzLkxlbmRhY2t5QGFtZC5j
b20+OyBTaW5naCwgQnJpamVzaCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KU3ViamVjdDogUkU6
IFtQQVRDSCAyLzJdIHg4Ni9tY2UvYW1kOiBFbnN1cmUgcXVpcmtzIGFyZSBhcHBsaWVkIGluIHJl
c3VtZSBwYXRoIGFzIHdlbGwNCg0KTm9wZSB0aGF0cyBub3QgbXkgZW1haWwgaWQsIGFtIG5vdCBz
dXJlIGhvdyhTQHZnZXIua2VybmVsLm9yZykgaXRzIGdldHRpbmcgYWRkZWQuDQpEbyB5b3UgZmlu
ZCB0aGUgc2FtZSBmb3IgdGhlIG5ldyBwYXRjaHNldCBJIGhhdmUgc2VudD8gDQoNCg0KUmVnYXJk
cywNClNoaXJpc2ggUw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQm9yaXNs
YXYgUGV0a292IDxicEBhbGllbjguZGU+DQpTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTYsIDIw
MTkgODo1NyBQTQ0KVG86IFMsIFNoaXJpc2ggPFNoaXJpc2guU0BhbWQuY29tPg0KQ2M6IFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhh
dC5jb20+OyBIIC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+OyBtYWludGFpbmVyIDogWDg2
IEFSQ0hJVEVDVFVSRSA8eDg2QGtlcm5lbC5vcmc+OyBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRl
bC5jb20+OyBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT47IG9wZW4gbGlz
dCA6IFg4NiBBUkNISVRFQ1RVUkUgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMZW5k
YWNreSwgVGhvbWFzIDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT47IFNpbmdoLCBCcmlqZXNoIDxi
cmlqZXNoLnNpbmdoQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0geDg2L21jZS9h
bWQ6IEVuc3VyZSBxdWlya3MgYXJlIGFwcGxpZWQgaW4gcmVzdW1lIHBhdGggYXMgd2VsbA0KDQpP
biBXZWQsIEphbiAxNiwgMjAxOSBhdCAwMzoxNDoyOVBNICswMDAwLCBTIHdyb3RlOg0KPiBEb25l
LiBIb3BlIHRoZSBtYWlsZXIgaXMgZmluZSBub3csIGkgaGF2ZSBhZGRlZCAtLWZyb20gd2hpbGUg
c2VuZGluZyANCj4gdGhlIG5ldyBwYXRjaHNldCBhbmQgYWxzbyBnb3QgaXQgcmV2aWV3ZWQgZnJv
bSBmb2xrcyBoZXJlLg0KDQpObywgaXQgaXNuJ3QuIEFuZCB0aGUgcHJvYmxlbSBpcyBub3QgZ2l0
LiBUaGUgcHJvYmxlbSBpcyB5b3VyIG5vcm1hbCBlbWFpbHMgeW91J3JlIHNlbmRpbmcuIExvb2sg
YXQgd2hhdCB5b3UganVzdCBzZW50Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzhi
ZWQzOWM4LWRmNDgtZGJiOS0zNjc0LWRmYmM0YWVhMjk2N0BhbWQuY29tL3Jhdw0KDQphbmQgZXNw
ZWNpYWxseSB5b3VyIEZyb206IGZpZWxkOg0KDQpGcm9tOiAgIFNAdmdlci5rZXJuZWwub3JnDQoN
CklzIHRoYXQgeW91ciBlbWFpbCBhZGRyZXNzPw0KDQotLQ0KUmVnYXJkcy9HcnVzcywNCiAgICBC
b3Jpcy4NCg0KR29vZCBtYWlsaW5nIHByYWN0aWNlcyBmb3IgNDAwOiBhdm9pZCB0b3AtcG9zdGlu
ZyBhbmQgdHJpbSB0aGUgcmVwbHkuDQo=
