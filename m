Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F6FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053202147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aoIKmcMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053202147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbeHPVqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:46:48 -0400
Received: from mail-dm3nam03on0087.outbound.protection.outlook.com ([104.47.41.87]:36306
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730325AbeHPVqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENbIWLCxSd8jtaI3QK3nznhY5i4tMkqGhOOCPx2U3ko=;
 b=aoIKmcMW0zityQ5w+lFlqpiVP/98m8x/vf20MXQ119Ziq53HtUeUGJj53vgDOGubzEPaMheGkUT9BRHuEEPBYZPh4R6XsZEaHxuYrEs7mScCdZd0koed8e2/RziOo926NQYMbRx7PYTNNAbGz15G9WLzLDDzUNmhW5fmtxA1zRQ=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2801.namprd12.prod.outlook.com (20.176.177.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Thu, 16 Aug 2018 18:46:33 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96%4]) with mapi id 15.20.1017.020; Thu, 16 Aug 2018
 18:46:33 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Thread-Topic: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Thread-Index: AQHUL+qPjfuIpXUOskyw2O7P1ShxPqS3mUYAgAAhmNCACUXnAIABukEQ
Date:   Thu, 16 Aug 2018 18:46:33 +0000
Message-ID: <BN7PR12MB2593C9819A949A2F7571FAB7F83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809140834.59264-2-Yazen.Ghannam@amd.com>
 <20180809161806.GB20928@nazgul.tnic>
 <BN7PR12MB259395675EBD74400D9FEBE5F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
 <20180815155452.GB28669@nazgul.tnic>
In-Reply-To: <20180815155452.GB28669@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:a156:973f:d5f1:b585]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2801;20:yq5gIpaXS5tdvNncjOo8W0Y5H5WWRR8fIMfV2hkByvHcF7Io7WkwTW8YzyZuF+I7xaYzL8zwsWv+ZNS5oEgnmrriI4QgBIMAi6zWz7cbsTDm1tLINKvDoJ+gjwgU7vBTJraGZ77cyA6bIhjABcRxwRQCpCeddp6exm1U4t8L9lHjEzCkHedcWuUqLNeI+ELZWaAP7i424TAoV+0AtHCuTut6tZobAXQtavWK0DvhP/jlF9rpjqoU9mAFDcmUw8Sn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a163010a-2e8d-49c0-2ca0-08d603a896c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2801;
x-ms-traffictypediagnostic: BN7PR12MB2801:
x-microsoft-antispam-prvs: <BN7PR12MB28013FC467DA637593A351CEF83E0@BN7PR12MB2801.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(105169848403564)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR12MB2801;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2801;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(346002)(136003)(199004)(13464003)(189003)(6436002)(446003)(4326008)(53936002)(11346002)(6246003)(229853002)(5660300001)(5250100002)(476003)(14454004)(486006)(8936002)(53546011)(102836004)(6506007)(9686003)(186003)(68736007)(478600001)(33656002)(256004)(25786009)(14444005)(55016002)(72206003)(6916009)(46003)(54906003)(316002)(74316002)(2900100001)(6116002)(86362001)(99286004)(76176011)(81166006)(93886005)(7696005)(8676002)(2906002)(106356001)(81156014)(305945005)(105586002)(7736002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2801;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 22FR2biJ9RypWzrgec+nLqPeFj+mHNDDSUTvyV231FzCIeXDESHABbTSsbzIijeUdy/0udKaeQnde1k7gf7EgY0SP+Q7OeofH8SpJlJQwzsaHU7545/AV8wDuiQKmcbfTCKIVmU866fezeFuaxDY0UopqTA9kDtfuJaH6SS6q4YTiBTIAKXfoAMPyhbfU5s+ApPv5aufAtJC+2rnN4nhXF4tVpnH61HsBWJkp9sCze7ZPVTcpnpotQM1YrJu8sSJRrPBsZPie4VPHMrH4641FtRSh3PReazx5WGkFBiLOUYG/Fmv0+yXcxY3nJhSZI/6irzi/ST7N19NZdvN9X1iycGrfxHFe9dOvpgeFgEWXOQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a163010a-2e8d-49c0-2ca0-08d603a896c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 18:46:33.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJl
aGFsZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTUsIDIw
MTggMTA6NTUgQU0NCj4gVG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+
DQo+IENjOiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gdG9ueS5sdWNrQGludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAyLzJdIHg4Ni9NQ0UvQU1EOiBTa2lwIGNyZWF0aW5nIGtvYmplY3RzIHdp
dGggTlVMTA0KPiBuYW1lcw0KPiANCj4gT24gVGh1LCBBdWcgMDksIDIwMTggYXQgMDY6NDY6MjZQ
TSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBtYWtlcyBpdCBz
byB0aGF0IHdlIGRvbid0IGZhaWwgaW5pdCBqdXN0IGJlY2F1c2Ugc29tZSBiYW5rcyBkb24ndA0K
PiA+IGhhdmUgbmFtZXMuIFRoZSBkYXRhIGNhY2hpbmcgd2UgZG8gaXMgdXNlZnVsIGV2ZW4gaWYg
d2UgZmFpbCB0byBjcmVhdGUgc3lzZnMNCj4gPiBlbnRyaWVzIGZvciBzb21lIGJhbmtzLiBUaGUg
aW50ZXJydXB0IGhhbmRsZXIgY2FuIHdvcmsgZmluZSB3aXRob3V0IGEgc3lzZnMNCj4gPiBlbnRy
eSBmb3IgZXZlcnkgYmFuay4gSXQgc2VlbXMgbGlrZSBvdmVya2lsbCB0byBkZWFsbG9jYXRlIGFs
bCB0aGUgc3RydWN0dXJlcw0KPiA+IGFuZCBzeXNmcyBlbnRyaWVzIGZvciBhbGwgdGhlIGJhbmtz
IGp1c3QgYmVjYXVzZSB3ZSBmYWlsIHRvIGNyZWF0ZSBlbnRyaWVzIGZvcg0KPiA+IHNvbWUgYmFu
a3MgdGhhdCBkb24ndCBoYXZlIG5hbWVzLg0KPiANCj4gTWF5YmUgSSdtIG1pc3NpbmcgdGhlIGJp
ZyBwaWN0dXJlIGhlcmUgYnV0IHdoeSwgYWxsIG9mIGEgc3VkZGVuLCBhcmUNCj4gc29tZSBiYW5r
cyB3aXRob3V0IG5hbWVzPyBUaGlzIGNsZWFybHkgaXMgbmV3IGJlY2F1c2UgaXQgd2Fzbid0IGxp
a2UNCj4gdGhhdCBiZWZvcmUsIHNvIHdoYXQgaXMgaXQ/IE1heWJlIHlvdSBzaG91bGQgZXhwbGFp
biB0aGUgYmlnZ2VyIHBpY3R1cmUNCj4gZmlyc3QuDQo+IA0KDQpZZXMsIHlvdSdyZSByaWdodC4g
SSdsbCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpCZWZvcmUgRmFtMTdoLCB3ZSB3ZW50
IGdlbmVyYXRpb25zIHdpdGggb25seSBhIGZldyBNQ0EgYmFua3MgYW5kIHRoZWlyDQpiYW5rIG51
bWJlcnMgYW5kIHR5cGVzIHdlcmUgY29uc2lzdGVudC4gV2l0aCBGYW0xN2ggYW5kIFNNQ0Egd2Ug
Z290IGENCndob2xlIG5ldyBzZXQgb2YgYmFuayB0eXBlcyBhbmQgbm93IHRoZXNlIGJhbmtzIG1h
eSBub3QgaGF2ZSB0aGUgc2FtZQ0Kb3JkZXJpbmcgYmV0d2VlbiBtb2RlbHMuIFNvIHdlIGNyZWF0
ZWQgbmFtZXMgZm9yIHRoZSBuZXcgYmFua3MgYW5kIHdlDQptYXRjaCB0aGUgYmFua3MgdG8gYSBu
YW1lIGJhc2VkIG9uIHZhbHVlcyBmcm9tIHRoZSBNQ0FfSVBJRCByZWdpc3Rlci4NCg0KRnV0dXJl
IFNNQ0Egc3lzdGVtcyBtYXkgaGF2ZSBiYW5rcyB3aG9zZSBNQ0FfSVBJRCBpcyBub3Qga25vd24g
c28gd2UNCmRvbid0IG1hdGNoIGEgbmFtZSB0byB0aGVtLiBUaGlzIGNvdWxkIGhhcHBlbiBpZiB3
ZSBoYXZlIGEgbWlub3IgcmV2aXNpb24NCnRvIGEga25vd24gYmFuaywgb3IgaWYgd2UgaGF2ZSBh
IGNvbXBsZXRlbHkgbmV3IGJhbmsgdHlwZS4NCg0KPiBBbmQgaWYgYmFua3MgZG9uJ3QgaGF2ZSBu
YW1lcywgdGhlbiB3ZSBzaG91bGQgZ2VuZXJhdGUgc29tZSBmb3IgdGhlbQ0KPiBpbnN0ZWFkLiBC
ZWNhdXNlIHRoaXMgY29kZSBpcyBhbHJlYWR5IHVnbHkgYW5kIHJlY3Vyc2l2ZSAtIHdlIGNlcnRh
aW5seQ0KPiBkb24ndCB3YW50IHRvIGFkZCBtb3JlIGNvbmRpdGlvbmFscyB0byBpdCBiZWNhdXNl
IHRoYXQgdGhpbmcgaXMgYSBtZXNzDQo+IGFzIGl0IGlzIG5vdy4NCj4gDQoNClRoaXMgaXMgYSBn
b29kIGlkZWEuDQoNCkluIHRoZSBwYXN0LCB0aGUgc3lzZnMgZW50cmllcyB3ZXJlIG5hbWVkIHNv
bWV0aGluZyBsaWtlICJ0aF9iYW5rIyIgYmVmb3JlDQplYWNoIGJhbmsgd2FzIGdpdmVuIGEgbW9y
ZSBkZXNjcmlwdGl2ZSBuYW1lLiBXZSBjYW4gZ28gYmFjayB0byB0aGlzIGZvcm1hdA0KYXMgYSBm
YWxsYmFjayBmb3IgdW5yZWNvZ25pemVkIGJhbmsgdHlwZXMuIFRoaXMgd2lsbCBmaXggdGhlIGlz
c3VlIHdpdGggc3lzZnMNCmZhaWxpbmcgYW5kIGFsc28gdGhlIGludGVyZmFjZSB3aWxsIHN0aWxs
IHdvcmsgb24gbmV3IGhhcmR3YXJlLg0KDQpJIGNhbiBkbyB0aGlzIGFuZCB1cGRhdGUgdGhlIGNv
bW1pdCBtZXNzYWdlIGluIGEgdjIgcGF0Y2guDQoNCj4gPiBJbiBvdGhlciB3b3JkcywgSSB0aGlu
ayB3ZSBzaG91bGQgZGVjb3VwbGUgdGhlIGludGVycnVwdCBoYW5kbGVyIGZyb20gdGhlDQo+ID4g
c3lzZnMgaW50ZXJmYWNlLiBUaGUgaW50ZXJmYWNlIGlzIG5pY2UgdG8gaGF2ZSBidXQgbm90IG5l
Y2Vzc2FyeSBmb3IgdGhlIEhXDQo+ID4gYW5kIE9TIHRvIGhhbmRsZSB0aHJlc2hvbGQgaW50ZXJy
dXB0cy4gSWYgd2UgZG8gc28sIHRoZW4gbmV3IEhXIHdpdGggbmV3LA0KPiA+IHVubmFtZWQgdHlw
ZXMgd2lsbCB3b3JrIHdpdGggb2xkZXIgdmVyc2lvbnMgb2YgTGludXguDQo+IA0KPiBUbyB0ZWxs
IHlvdSB0aGUgdHJ1dGgsIEknbSBub3QgYXQgYWxsIHBzeWNoZWQgYWJvdXQgdGVsbGluZyB0aGUg
ZnV0dXJlLg0KPiBXZSBjYW4gdHJ5IHRvIGJlIGZ1dHVyZS1wcm9vZiB0byBhIGNlcnRhaW4gZGVn
cmVlIGJ1dCB0aGlzIHNob3VsZCBub3QgYmUNCj4gdGhlIGRldGVybWluaW5nIGZhY3RvciBob3cg
d2UgZGVzaWduIHRoaW5ncy4NCj4gDQo+IEJ1dCB0aGUgYXNwZWN0IG9mIGRlY291cGxpbmcgc3lz
ZnMgcmVwcmVzZW50YXRpb24gZnJvbSBoYW5kbGVyIG1ha2VzDQo+IHNlbnNlLiBJdCBqdXN0IG5l
ZWRzIHRvIGJlIGRvbmUgY2xlYW5seS4NCj4gDQoNCkkgYWdyZWUuIEkganVzdCB3YW50ZWQgdG8g
bWFrZSBhIHNtYWxsIGNoYW5nZSBhbmQgZml4IHRoaXMgaXNzdWUuIEkgdGhpbmsgdGhlcmUncw0K
YSBsb3Qgd2UgY2FuIGRvIHRvIGNsZWFuIHVwIHRoZSB0aHJlc2hvbGRpbmcgY29kZSBnb2luZyBm
b3J3YXJkLg0KDQpUaGFua3MsDQpZYXplbg0K
