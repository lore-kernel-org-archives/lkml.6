Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D470C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D519121F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I7hI1Oky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D519121F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeHIVMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:12:46 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:63195
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbeHIVMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlrpMteT4Gx1i4DhpeJgB9Ke1P9boOIgLMtEWcrnNVY=;
 b=I7hI1OkyM4GOryCucLnBosZ/zIuua08aRB+RUXtTgFU26sViD9T1FubFnfGZ0c/xFCmXtT0LgIClBf+tyRJfYNDbZE6YmjmNU4x1N4A5ZO9dg5iaeO3gJP6Alc9QsolDIfla3FlmuwQ2tEB7MHVkI81ZuRuTTR+Hdt3HymaWm20=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2691.namprd12.prod.outlook.com (20.176.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 9 Aug 2018 18:46:26 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96%4]) with mapi id 15.20.1017.020; Thu, 9 Aug 2018
 18:46:26 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Thread-Topic: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Thread-Index: AQHUL+qPjfuIpXUOskyw2O7P1ShxPqS3mUYAgAAhmNA=
Date:   Thu, 9 Aug 2018 18:46:26 +0000
Message-ID: <BN7PR12MB259395675EBD74400D9FEBE5F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809140834.59264-2-Yazen.Ghannam@amd.com>
 <20180809161806.GB20928@nazgul.tnic>
In-Reply-To: <20180809161806.GB20928@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:1df9:74bd:2f19:7509]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2691;20:BvcyC8ed5P7wXTm27B1dYts5hyB93kjcsokd2OoQ0W1BBqfHbC0pJW1iWGBrRz7SnI6oUEGzicjla6c7ra+e+BSAvTWlru9XfsM8f+9ipI/ze/7Oj5T7Hn2Vdd5c2hYKjpKQl0qAstjiBbhr9GXN9l5yJW/eKcX8wjGAeHcgwmpGZSaCQplOjBTj2XbewIFrUosXjVC/6ZikXzVtnA8Z8y2dn63xEw09YqxWuXSjR0wpTsxX+qGQNIZyGtQXci46
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: af446e74-463a-42af-7226-08d5fe286981
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2691;
x-ms-traffictypediagnostic: BN7PR12MB2691:
x-microsoft-antispam-prvs: <BN7PR12MB2691C4E6FCC10C67868FA0A0F8250@BN7PR12MB2691.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR12MB2691;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2691;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(346002)(39860400002)(13464003)(189003)(199004)(2906002)(86362001)(46003)(2900100001)(76176011)(6246003)(6506007)(53546011)(7696005)(53936002)(25786009)(186003)(4326008)(102836004)(97736004)(72206003)(14454004)(478600001)(106356001)(105586002)(54906003)(6436002)(316002)(99286004)(55016002)(9686003)(305945005)(229853002)(5250100002)(81156014)(68736007)(81166006)(8936002)(8676002)(256004)(33656002)(7736002)(486006)(6116002)(5660300001)(6916009)(74316002)(11346002)(476003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2691;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CvcFXiqAqecIfCJhF+nv5TQ2trhwGj3W+o2Ub1w7/T9kosJktO1g9cagVdKJEK1ViZW5ObdpkA/ENGIBjXnDDbgIqQKDm3LIzKlx7H4mgf/Pm9ijAVVqliOH4PIkqon2OCY+zqyzNAKvtNZnbi0b/ww4vuSvitCFrm43jc/P/FplRd/ssY0gg2ZV7Tcn/RPTDS0rTrGWuM/YLj39rFPY3Ms/K90eh0/UmuQBq5jXPh/BRRGckntBYFqQWPlxelp9ogxpz96Lzrs7peH36iIBij+OGel4sW07wh5F2gBePJGo8+vSo5iontkwL0NErD/M1DYUjZKa16FAs+W3jQc76urIBrwp4P0Tz6k1coBMcUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af446e74-463a-42af-7226-08d5fe286981
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 18:46:26.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJl
aGFsZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCA5LCAyMDE4
IDExOjE4IEFNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0K
PiBDYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IHRvbnkubHVja0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8yXSB4ODYvTUNFL0FNRDogU2tpcCBjcmVhdGluZyBrb2JqZWN0cyB3aXRo
IE5VTEwNCj4gbmFtZXMNCj4gDQo+IE9uIFRodSwgQXVnIDA5LCAyMDE4IGF0IDA5OjA4OjM0QU0g
LTA1MDAsIFlhemVuIEdoYW5uYW0gd3JvdGU6DQo+ID4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6
ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiA+DQo+ID4gRHVyaW5nIG1jZV90aHJlc2hvbGRfY3JlYXRl
X2RldmljZSgpIGRhdGEgc3RydWN0dXJlcyBhcmUgYWxsb2NhdGVkIGZvcg0KPiA+IGVhY2ggQ1BV
cyBNQ0EgYmFua3MgYW5kIHRocmVzaG9sZGluZyBibG9ja3MuIFRoZXNlIGRhdGEgc3RydWN0dXJl
cyBhcmUNCj4gPiB1c2VkIHRvIHNhdmUgaW5mb3JtYXRpb24gcmVsYXRlZCB0byBBTUQncyBNQ0Eg
RXJyb3IgVGhyZXNob2xkaW5nDQo+ID4gZmVhdHVyZS4gVGhlIHN0cnVjdHVyZXMgYXJlIHVzZWQg
aW4gdGhlIHRocmVzaG9sZGluZyBpbnRlcnJ1cHQgaGFuZGxlciwNCj4gPiBhbmQgdGhleSBhcmUg
ZXhwb3NlZCB0byB0aGUgdXNlciB0aHJvdWdoIHN5c2ZzLiBUaGUgc3lzZnMgaW50ZXJmYWNlIGhh
cw0KPiA+IHVzZXItZnJpZW5kbHkgbmFtZXMgZm9yIGVhY2ggYmFuay4NCj4gPg0KPiA+IEhvd2V2
ZXIsIGVycm9ycyBpbiBtY2VfdGhyZXNob2xkX2NyZWF0ZV9kZXZpY2UoKSB3aWxsIGNhdXNlIGFs
bCB0aGUgZGF0YQ0KPiA+IHN0cnVjdHVyZXMgdG8gYmUgZGVhbGxvY2F0ZWQuIFRoaXMgd2lsbCBi
cmVhayB0aGUgdGhyZXNob2xkaW5nIGludGVycnVwdA0KPiA+IGhhbmRsZXIgc2luY2UgaXQgZGVw
ZW5kcyBvbiB0aGVzZSBzdHJ1Y3R1cmVzLg0KPiANCj4gU2FtZSBhcmd1bWVudCBhcyBiZWZvcmU6
IGlmIG91ciBpbml0IGZhaWxzIGluIHNvbWUgZmFzaGlvbiwgd2Ugc2hvdWxkDQo+IG5vdCBiZSBy
dW5uaW5nIHRoZSBpbnRlcnJ1cHQgaGFuZGxlci4NCj4gDQoNClRoaXMgcGF0Y2ggbWFrZXMgaXQg
c28gdGhhdCB3ZSBkb24ndCBmYWlsIGluaXQganVzdCBiZWNhdXNlIHNvbWUgYmFua3MgZG9uJ3QN
CmhhdmUgbmFtZXMuIFRoZSBkYXRhIGNhY2hpbmcgd2UgZG8gaXMgdXNlZnVsIGV2ZW4gaWYgd2Ug
ZmFpbCB0byBjcmVhdGUgc3lzZnMNCmVudHJpZXMgZm9yIHNvbWUgYmFua3MuIFRoZSBpbnRlcnJ1
cHQgaGFuZGxlciBjYW4gd29yayBmaW5lIHdpdGhvdXQgYSBzeXNmcw0KZW50cnkgZm9yIGV2ZXJ5
IGJhbmsuIEl0IHNlZW1zIGxpa2Ugb3ZlcmtpbGwgdG8gZGVhbGxvY2F0ZSBhbGwgdGhlIHN0cnVj
dHVyZXMNCmFuZCBzeXNmcyBlbnRyaWVzIGZvciBhbGwgdGhlIGJhbmtzIGp1c3QgYmVjYXVzZSB3
ZSBmYWlsIHRvIGNyZWF0ZSBlbnRyaWVzIGZvcg0Kc29tZSBiYW5rcyB0aGF0IGRvbid0IGhhdmUg
bmFtZXMuIA0KDQpJbiBvdGhlciB3b3JkcywgSSB0aGluayB3ZSBzaG91bGQgZGVjb3VwbGUgdGhl
IGludGVycnVwdCBoYW5kbGVyIGZyb20gdGhlDQpzeXNmcyBpbnRlcmZhY2UuIFRoZSBpbnRlcmZh
Y2UgaXMgbmljZSB0byBoYXZlIGJ1dCBub3QgbmVjZXNzYXJ5IGZvciB0aGUgSFcNCmFuZCBPUyB0
byBoYW5kbGUgdGhyZXNob2xkIGludGVycnVwdHMuIElmIHdlIGRvIHNvLCB0aGVuIG5ldyBIVyB3
aXRoIG5ldywNCnVubmFtZWQgdHlwZXMgd2lsbCB3b3JrIHdpdGggb2xkZXIgdmVyc2lvbnMgb2Yg
TGludXguIFdlIGNhbiB0aGVuIGFkZCB0aGUNCm5ldyB0eXBlIG5hbWVzIHdpdGhvdXQgaGF2aW5n
IHRvIGJhY2twb3J0IHRvIGZpeCB0aGUgaW50ZXJydXB0IGhhbmRsZXIuDQoNClRoYW5rcywNCllh
emVuDQo=
