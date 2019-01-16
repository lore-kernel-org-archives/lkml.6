Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5224C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F1320675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VSQqWHmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394085AbfAPPbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:31:10 -0500
Received: from mail-eopbgr800081.outbound.protection.outlook.com ([40.107.80.81]:27190
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390925AbfAPPbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xFActjexAUIAUkV4HYyH4D9z8j31iCLmvzYVaWHvfE=;
 b=VSQqWHmkb5kOG/k9NSgNC8QQoF5ei9Mkyei4UW70gU4ZaNjXe9SyN++JkaRdKbdzmnURjac3x+oaMhLRBmX/+ggJxL2ao2l/Rl7XgDiT8dwGouOoQ6r7Z1c4FGKMtXnTbZqUi2D2XSYM8GN7b7xfY5Tyy0AaDyKMw+xMtL2uPpE=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3423.namprd12.prod.outlook.com (20.178.243.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 15:31:05 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f%3]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:31:04 +0000
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
Thread-Index: AQHUpnT6RX1zZkZcBk29IptIsRwq2qWngtqAgACqJYCABm8wAIAAVaaA///+GACAAMwsgIAA5geAgAFw8AD////KgIAABEdA
Date:   Wed, 16 Jan 2019 15:31:04 +0000
Message-ID: <MN2PR12MB32483E9CDA510F1B58617DFFF2820@MN2PR12MB3248.namprd12.prod.outlook.com>
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
In-Reply-To: <20190116152643.GH15409@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-originating-ip: [49.206.9.151]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3423;20:BStWBULCnyyrB+zhwvA6WwjdoFtP41NsurjcL7Jh7JfqhKy/pxyUr7MmXJVgDc9aJwsJm86v95lpzYPYyMKh0s32OGzETyx/LnCGyz1+ToA2WyEb4bht6nQFRCuC3MZ8Q9RXaMRipqHf/PJV2j48N8L9pLqq70ADFtlN8g32v1HBjCCP9hg4c+XGCFnllJ+Byjod4cJ7SyZv7zwcMc9sdrxFwW9up72AnWtuWGWjiO2GagBat+sIrm9XjcPJJjS2
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(13464003)(9686003)(6246003)(26005)(186003)(66066001)(316002)(478600001)(966005)(72206003)(4326008)(53936002)(6306002)(446003)(11346002)(476003)(71200400001)(86362001)(105586002)(76176011)(7696005)(106356001)(71190400001)(53546011)(55236004)(102836004)(6506007)(256004)(25786009)(93886005)(486006)(229853002)(99286004)(33656002)(97736004)(55016002)(6436002)(68736007)(74316002)(8936002)(14454004)(5660300001)(54906003)(2906002)(81156014)(81166006)(8676002)(305945005)(6116002)(7736002)(3846002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3423;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 478e19e8-3c89-4973-d64c-08d67bc7a0b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3423;
x-ms-traffictypediagnostic: MN2PR12MB3423:
x-microsoft-antispam-prvs: <MN2PR12MB3423FC1483E54BCC97383CB2F2820@MN2PR12MB3423.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nEm4p4wr90uggUsTZ7ZoaDQeY/nV7chY03MUKD7k2NF4CFk93Hqref2zqNANwEqqlzJOPS5sYNiK2IO0ycp77LegxEphR/FapBsjmg5F/AhWwWRqXK5RYq+7CxecBO6vb9nAdavi6Ec0pACre2VzbVPFJ1PsG9hZk/W8R6ZN9rHNoy+RljEYtQ2LEhRG+cHQ0rVlyho1zSgS/4pKwyW8vqMY+Bnhj4yEaIha7hIeRXitE7HPYs/CD3T4LBRstW7EzNWhwi5pbpvLbvlDTgCoGXVtJ80JL5OvpAIrS6RyZf2gBzgLAhFOdsHRAW5UGq35oOTXptrToGlQHPyKJfhur1oR783prZinpdyqbggRlEu2V8TYB7mhGCmZl1u3PywW1iDKYeCyKNt/t8U3o3Q67eDfMIvVHs8Rn3w/UifrHi4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478e19e8-3c89-4973-d64c-08d67bc7a0b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:31:04.2331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm9wZSB0aGF0cyBub3QgbXkgZW1haWwgaWQsIGFtIG5vdCBzdXJlIGhvdyhTQHZnZXIua2VybmVs
Lm9yZykgaXRzIGdldHRpbmcgYWRkZWQuDQpEbyB5b3UgZmluZCB0aGUgc2FtZSBmb3IgdGhlIG5l
dyBwYXRjaHNldCBJIGhhdmUgc2VudD8gDQoNCg0KUmVnYXJkcywNClNoaXJpc2ggUw0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjgu
ZGU+IA0KU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDE2LCAyMDE5IDg6NTcgUE0NClRvOiBTLCBT
aGlyaXNoIDxTaGlyaXNoLlNAYW1kLmNvbT4NCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgSCAuIFBldGVyIEFu
dmluIDxocGFAenl0b3IuY29tPjsgbWFpbnRhaW5lciA6IFg4NiBBUkNISVRFQ1RVUkUgPHg4NkBr
ZXJuZWwub3JnPjsgVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgVmlzaGFsIFZlcm1h
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+OyBvcGVuIGxpc3QgOiBYODYgQVJDSElURUNUVVJF
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTGVuZGFja3ksIFRob21hcyA8VGhvbWFz
LkxlbmRhY2t5QGFtZC5jb20+OyBTaW5naCwgQnJpamVzaCA8YnJpamVzaC5zaW5naEBhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIHg4Ni9tY2UvYW1kOiBFbnN1cmUgcXVpcmtzIGFy
ZSBhcHBsaWVkIGluIHJlc3VtZSBwYXRoIGFzIHdlbGwNCg0KT24gV2VkLCBKYW4gMTYsIDIwMTkg
YXQgMDM6MTQ6MjlQTSArMDAwMCwgUyB3cm90ZToNCj4gRG9uZS4gSG9wZSB0aGUgbWFpbGVyIGlz
IGZpbmUgbm93LCBpIGhhdmUgYWRkZWQgLS1mcm9tIHdoaWxlIHNlbmRpbmcgDQo+IHRoZSBuZXcg
cGF0Y2hzZXQgYW5kIGFsc28gZ290IGl0IHJldmlld2VkIGZyb20gZm9sa3MgaGVyZS4NCg0KTm8s
IGl0IGlzbid0LiBBbmQgdGhlIHByb2JsZW0gaXMgbm90IGdpdC4gVGhlIHByb2JsZW0gaXMgeW91
ciBub3JtYWwgZW1haWxzIHlvdSdyZSBzZW5kaW5nLiBMb29rIGF0IHdoYXQgeW91IGp1c3Qgc2Vu
dDoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC84YmVkMzljOC1kZjQ4LWRiYjktMzY3
NC1kZmJjNGFlYTI5NjdAYW1kLmNvbS9yYXcNCg0KYW5kIGVzcGVjaWFsbHkgeW91ciBGcm9tOiBm
aWVsZDoNCg0KRnJvbTogICBTQHZnZXIua2VybmVsLm9yZw0KDQpJcyB0aGF0IHlvdXIgZW1haWwg
YWRkcmVzcz8NCg0KLS0NClJlZ2FyZHMvR3J1c3MsDQogICAgQm9yaXMuDQoNCkdvb2QgbWFpbGlu
ZyBwcmFjdGljZXMgZm9yIDQwMDogYXZvaWQgdG9wLXBvc3RpbmcgYW5kIHRyaW0gdGhlIHJlcGx5
Lg0K
