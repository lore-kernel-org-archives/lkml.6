Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7281C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C4920660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N9/ZZWwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C4920660
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934239AbeFKSVH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:21:07 -0400
Received: from mail-by2nam01on0097.outbound.protection.outlook.com ([104.47.34.97]:28032
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933481AbeFKSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6qpsM/BElpdxet2xwXOqmms/oXjPZXGzCPAXMMjn34=;
 b=N9/ZZWwz7RhfZQtFUBXl0KQEqD0OUUMGdYdL59Vq194jmVVK22+ZF2l84mznoIfz4CHnHTW4SbvWfaI9r6de6Q5XW/a87nn46NiTJx2Kd08xORp87ObekIQdF1z9hAsVOKGhbocCSwVQFEerkTYar64VGWS67vHH+yQI10xW830=
Received: from DM5PR2101MB0888.namprd21.prod.outlook.com (52.132.132.157) by
 DM5PR2101MB0872.namprd21.prod.outlook.com (10.167.111.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Mon, 11 Jun 2018 18:20:58 +0000
Received: from DM5PR2101MB0888.namprd21.prod.outlook.com
 ([fe80::9894:4c8f:60ce:a446]) by DM5PR2101MB0888.namprd21.prod.outlook.com
 ([fe80::9894:4c8f:60ce:a446%4]) with mapi id 15.20.0863.007; Mon, 11 Jun 2018
 18:20:58 +0000
From:   Matthew Wilcox <mawilcox@microsoft.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [GIT PULL] f2fs update for 4.18-rc1
Thread-Topic: [GIT PULL] f2fs update for 4.18-rc1
Thread-Index: AQHUAamQJxxqCyqfVEWUH7QeajP4SKRbWBLA
Date:   Mon, 11 Jun 2018 18:20:58 +0000
Message-ID: <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
In-Reply-To: <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mawilcox@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-11T18:17:51.0926468Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [206.248.175.83]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:tG8xxbU3KO0tDZv7zsx+OuKCFoRqB6Pvpj+i5Z1MxTbrvv1WPe/l5EcTOlossdLqaEiIVmIgh125f+kIZTjXHDWEhw7oxDGnWLFy+dRNLXEuLGnVEKKeHNbrbQyBs3t1DFJy2AN6MvuRGTzHIUDZmL4PeW59ynioXdcxmQ4P9J1BqxdhsEA0k36KeUicZFQjgu9OOmb433il6zrK+1IpS8ICQ/LfibJTz6XjkhtpTWjmbyBJ7l7HOF4p4OOf2Y9M
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mawilcox@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0872BE88338753374CE953B3CB780@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(143289334528602)(28532068793085)(89211679590171)(9452136761055)(189930954265078)(222783783823338)(42262312472803)(219752817060721);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 070092A9D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(39860400002)(376002)(366004)(199004)(189003)(13464003)(2900100001)(6246003)(14454004)(3660700001)(2906002)(25786009)(4326008)(305945005)(3280700002)(10090500001)(53936002)(59450400001)(106356001)(105586002)(7696005)(33656002)(74316002)(186003)(76176011)(26005)(68736007)(6506007)(15650500001)(53546011)(575784001)(102836004)(8676002)(966005)(55016002)(8990500004)(5660300001)(6306002)(8936002)(229853002)(97736004)(10290500003)(6436002)(446003)(54906003)(86612001)(316002)(3846002)(476003)(11346002)(5250100002)(81166006)(66066001)(110136005)(86362001)(22452003)(486006)(7736002)(99286004)(6116002)(9686003)(81156014)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB0888.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7FRPjLUFT2Gp77xwgcRGEvYC8QcNKOV2hd0Q97JhVncELUDZpi7aGnoCaTH4Dz+atb836kgt+Aez+O7DvRt9BpALveSi4cKPusQ/0OvuRZZOZykMcS6IWXXRWtbhMTXcfxQgKCV9PCzS0uYT1laY3qrg3D3LGU6YY8VnzQouc6kBA5o6E5tXng+b/8BKVndf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ff774e77-b134-4904-f240-08d5cfc81470
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff774e77-b134-4904-f240-08d5cfc81470
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2018 18:20:58.4607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXJnaCwgeW91IHVzZWQgbXkgT3V0bG9vayBlbWFpbCBhZGRyZXNzLCBzbyB5b3UgZ2V0IHRvcC1w
b3N0aW5nIPCfmIkNCg0KVGhlIHJhZGl4IHRyZWUgZG9lcyByZWx5IG9uIGNvbnN0cnVjdG9ycyBz
dGlsbC4gIE9uZSBvZiB0aGUgdGhpbmdzIG9uIG15IHRvZG8gbGlzdCBpcyB0byB2ZXJpZnkgd2hl
dGhlciBpdCBhY3R1YWxseSBtYWtlcyBzZW5zZSB0byBkbyB0aGF0IG9yIG5vdC4gIEl0IG1heSBj
b250aW51ZSB0byBtYWtlIHNlbnNlOyB0aGUgcmFkaXggdHJlZSBub2RlIGlzIDU3NiBieXRlcyAo
OSBjYWNoZSBsaW5lcykgYW5kIHRoZSBub3JtYWwgdXNhZ2Ugb2YgYSBmcmVzaGx5IGFsbG9jYXRl
ZCByYWRpeCB0cmVlIG5vZGUgd2lsbCB0b3VjaCBvbmx5IG9uZSBvciB0d28gY2FjaGVsaW5lcy4g
IFJhZGl4IHRyZWUgbm9kZXMgbmF0dXJhbGx5IGNvbWUgYmFjayB0byB0aGUgY2FjaGUgemVyb2Vk
LCBzbyB0aGVyZSdzIG5vIGNhY2hlIHBvbGx1dGlvbiB3aGVuIGRlc3Ryb3lpbmcgdGhlbSBlaXRo
ZXIuDQoNCldlIGRpZG4ndCBzZW5kIHRoYXQgcGF0Y2ggdXBzdHJlYW07IGluc3RlYWQgd2Ugc2Fp
ZCB0aGF0IGFueWJvZHkgd2hvIHNwZWNpZmllcyBfX0dGUF9aRVJPIG9uIGEgc2xhYiB3aXRoIGNv
bnN0cnVjdG9ycyBpcyBjcmF6eSBhbmQgZml4ZWQgaXQgd2l0aCBjb21taXRzIGFiYzFiZTEzZmQx
MTNkZGVmNWUyZDgwN2E0NjYyODZiODY0Y2FlZDMgYW5kIDEyODIyN2U3ZmU0MDg3YjYwZjFiZDMx
Zjc2MmU2MTIzN2ViMjM3OTANCg0KSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB3aHkgSmFlZ2V1
ayBpcyBjaGFuZ2luZyBmMmZzIG5vdyB3aGVuIHdlJ3ZlIGp1c3QgZml4ZWQgdGhlIGNvcmUga2Vy
bmVsIHRvIG1ha2Ugd2hhdCBoZSdzIGRvaW5nIHBlcmZlY3RseSBsZWdhbC4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGlu
dXgtZm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMSwgMjAxOCAxOjI4IFBN
DQo+IFRvOiBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPjsgTWF0dGhldyBXaWxjb3gN
Cj4gPG1hd2lsY294QG1pY3Jvc29mdC5jb20+DQo+IENjOiBMaW51eCBGMkZTIERFViwgTWFpbGlu
ZyBMaXN0IDxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD47IExpbnV4DQo+
IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbR0lUIFBVTExdIGYyZnMgdXBkYXRlIGZvciA0LjE4LXJjMQ0KPiANCj4gT24g
TW9uLCBKdW4gMTEsIDIwMTggYXQgOTo1MiBBTSBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4gPg0KPiA+IEluIG9yZGVyIHRvIGF2b2lkIG9sZCBNTSBidWcgWzFdLCB3
ZSBkZWNpZGVkIG5vdCB0byB1c2UgX19HRlBfWkVSTw0KPiA+IGZvciB0aGUgbWFwcGluZyBmb3Ig
bm9kZSBhbmQgbWV0YSBwYWdlIGNhY2hlcy4NCj4gPg0KPiA+IFsxXQ0KPiBodHRwczovL25hMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxrbWwu
b3JnDQo+ICUyRmxrbWwlMkYyMDE4JTJGNCUyRjglMkY2NjEmZGF0YT0wMiU3QzAxJTdDbWF3aWxj
b3glNDBtaWNyb3NvDQo+IGZ0LmNvbSU3Q2U2OWMxZjlhOGQ2YTQ0YmRhMzZlMDhkNWNmYzBiMWE1
JTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZA0KPiA3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2MzY2NDMz
NDg4NzQ2MDgzODUmc2RhdGE9eGJBZzBjT014eXJZNE5ZDQo+IHlzVGoxWDBEUFRkeHdUMjRvWXUx
Y3hPNDVua1ElM0QmcmVzZXJ2ZWQ9MA0KPiANCj4gSG1tLiBUaGUgcGF0Y2ggdGhlcmUgbG9va3Mg
Y29ycmVjdCwgYW5kIGFueWJvZHkgd2hvIHJlbGllcyBvbiBzbGFiDQo+IGNvbnN0cnVjdG9ycyBp
cyBjcmF6eS4NCj4gDQo+IFRoYXQgZW1haWwgZnJvbSBBcHJpbCBzYXlzIGl0IHNob3VsZCBnbyBp
bnRvIHN0YWJsZSwgYnV0IGl0IG5ldmVyIGV2ZW4NCj4gd2VudCB1cHN0cmVhbS4uDQo+IA0KPiBB
ZGRpbmcgV2lsbHkgdG8gdGhlIGNjLCBmb3IgY29tbWVudHMsIHNpbmNlIGhlJ3MgYmVlbiBhY3Rp
dmUgdGhlcmUgYW5kDQo+IGlzIHByb2JhYmx5IHRoZSBtYWludGFpbmVyIGV2ZW4gaWYgdGhlIE1B
SU5UQUlORVJTIGZpbGUgZG9lc24ndCBzYXkNCj4gc28uLg0KPiANCj4gV2lsbHk/DQo+IA0KPiAg
ICAgICAgICAgICAgTGludXMNCg==
