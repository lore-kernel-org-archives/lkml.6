Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE2ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAC920867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hPK0DTC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAC920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeIZBT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:19:29 -0400
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:30863
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbeIZBT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMLEaEaGVDq+d9MR+yggrxiBcgD7QmErXuchjc3spao=;
 b=hPK0DTC1uwxNYjTpqVJCGaT7+gWd8P2UhrPGz+Ec4vNVnukP58kX55UVOodzV7970+/9bYP/5vavEkpufVYvd0bdfL0BE32cjQXuoq1Kh3343imCZOT9JVT+KzObbBYjFf+8S3HrFdCHaCmesTDyUFiz+IhPG/LlCJ1vENam588=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0269.namprd12.prod.outlook.com (10.162.4.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 25 Sep 2018 19:10:25 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.022; Tue, 25 Sep 2018
 19:10:25 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Lianbo Jiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 0/4 v7] Support kdump for AMD secure memory
 encryption(SME)
Thread-Topic: [PATCH 0/4 v7] Support kdump for AMD secure memory
 encryption(SME)
Thread-Index: AQHURoNZSpvUdmiv5EiaHAwnuDIBNKUBeckA
Date:   Tue, 25 Sep 2018 19:10:24 +0000
Message-ID: <fd8af3af-3b7c-75a6-ad67-b2efe78011fb@amd.com>
References: <20180907081805.368-1-lijiang@redhat.com>
In-Reply-To: <20180907081805.368-1-lijiang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0009.namprd04.prod.outlook.com
 (2603:10b6:803:21::19) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0269;20:JTYS9xZCAdqRU+CVHzqkPYyeQS+YDq4+g5kuasodlFUrVG8Raw9B+pmywVWPgr4gVv/EAtdy0Y8+ZOEGGLU0uBBk0zL9yfep4wFCgAlERsMdxSqXmeVtVjvyyDn4KD8fK3TFxqCi7FvuwSrYlWboI68NEMLKyB+GJUIhCTnnGT5d2kU4yyON1izcGr5uVwf0M7oAV2WLgBOskf9IBV2SgOjCrFbInNkYh2a5JLCpIrEo89MpKicynNwYNxklf5lx
x-ms-office365-filtering-correlation-id: f695f0ca-485a-403b-d878-08d6231a8be4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0269;
x-ms-traffictypediagnostic: SN1PR12MB0269:
x-microsoft-antispam-prvs: <SN1PR12MB02696E1070343B248F683171EC160@SN1PR12MB0269.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(84791874153150)(258649278758335)(767451399110)(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:SN1PR12MB0269;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0269;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(229853002)(68736007)(2501003)(72206003)(446003)(5250100002)(106356001)(86362001)(14454004)(478600001)(36756003)(2900100001)(2906002)(97736004)(966005)(7416002)(8676002)(316002)(486006)(476003)(54906003)(110136005)(6246003)(31696002)(6116002)(2616005)(26005)(53936002)(76176011)(81166006)(52116002)(3846002)(305945005)(25786009)(7736002)(99286004)(6506007)(186003)(66066001)(386003)(11346002)(53546011)(71190400001)(71200400001)(31686004)(4326008)(102836004)(6346003)(8936002)(6436002)(6512007)(6486002)(14444005)(6306002)(256004)(105586002)(5660300001)(81156014)(34290500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0269;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-microsoft-antispam-message-info: ZiHH5kjZ+qzraT+vsu6OmQoNBT3PM/adsHfxhrKzfE5C958h9lJVL6RdWCo/sT4UbM6ptbtaCo4qeyw5m0i9Etf0fjUxlEQ01b6WHKecbmGGbWEzVYokMt/lRA7RrAPNXHiISWxE6ohrsKzfBgAs37ENzIw21SxG7hpbJT3nWeNJ5RPQXk7sNQU3RXf9idpvPA5wbpA1p3VrE8+3MeaG71inW0ZXBN316aJLCwGlmEhHbbszqT71vgtSQ69a86cdeJQrvaNCeXd7jFGlca1nyO9g6iN7DnVfaaneiKASwMiKt+GZ5CZX77ksnQRkINgUhnf9Tn7GV1178PiserNUHIQ4/6ROVFd1z+xoMIgjJFw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B6C6FDC6F76874C97E4CDE626906303@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f695f0ca-485a-403b-d878-08d6231a8be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 19:10:25.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDcvMjAxOCAwMzoxOCBBTSwgTGlhbmJvIEppYW5nIHdyb3RlOg0KPiBXaGVuIFNNRSBp
cyBlbmFibGVkIG9uIEFNRCBtYWNoaW5lLCB3ZSBhbHNvIG5lZWQgdG8gc3VwcG9ydCBrZHVtcC4g
QmVjYXVzZQ0KPiB0aGUgbWVtb3J5IGlzIGVuY3J5cHRlZCBpbiB0aGUgZmlyc3Qga2VybmVsLCB3
ZSB3aWxsIHJlbWFwIHRoZSBvbGQgbWVtb3J5DQo+IHRvIHRoZSBrZHVtcCBrZXJuZWwgZm9yIGR1
bXBpbmcgZGF0YSwgYW5kIFNNRSBpcyBhbHNvIGVuYWJsZWQgaW4gdGhlIGtkdW1wDQo+IGtlcm5l
bCwgb3RoZXJ3aXNlIHRoZSBvbGQgbWVtb3J5IGNhbiBub3QgYmUgZGVjcnlwdGVkLg0KPiANCj4g
Rm9yIHRoZSBrZHVtcCwgaXQgaXMgbmVjZXNzYXJ5IHRvIGRpc3Rpbmd1aXNoIHdoZXRoZXIgdGhl
IG1lbW9yeSBpcyBlbmNyeXB0ZWQuDQo+IEZ1cnRoZXJtb3JlLCB3ZSBzaG91bGQgYWxzbyBrbm93
IHdoaWNoIHBhcnQgb2YgdGhlIG1lbW9yeSBpcyBlbmNyeXB0ZWQgb3INCj4gZGVjcnlwdGVkLiBX
ZSB3aWxsIGFwcHJvcHJpYXRlbHkgcmVtYXAgdGhlIG1lbW9yeSBhY2NvcmRpbmcgdG8gdGhlIHNw
ZWNpZmljDQo+IHNpdHVhdGlvbiBpbiBvcmRlciB0byB0ZWxsIGNwdSBob3cgdG8gYWNjZXNzIHRo
ZSBtZW1vcnkuDQo+IA0KPiBBcyB3ZSBrbm93LCBhIHBhZ2Ugb2YgbWVtb3J5IHRoYXQgaXMgbWFy
a2VkIGFzIGVuY3J5cHRlZCwgd2hpY2ggd2lsbCBiZQ0KPiBhdXRvbWF0aWNhbGx5IGRlY3J5cHRl
ZCB3aGVuIHJlYWQgZnJvbSBEUkFNLCBhbmQgd2lsbCBhbHNvIGJlIGF1dG9tYXRpY2FsbHkNCj4g
ZW5jcnlwdGVkIHdoZW4gd3JpdHRlbiB0byBEUkFNLiBJZiB0aGUgb2xkIG1lbW9yeSBpcyBlbmNy
eXB0ZWQsIHdlIGhhdmUgdG8NCj4gcmVtYXAgdGhlIG9sZCBtZW1vcnkgd2l0aCB0aGUgbWVtb3J5
IGVuY3J5cHRpb24gbWFzaywgd2hpY2ggd2lsbCBhdXRvbWF0aWNhbGx5DQo+IGRlY3J5cHQgdGhl
IG9sZCBtZW1vcnkgd2hlbiB3ZSByZWFkIHRob3NlIGRhdGEuDQo+IA0KPiBGb3Iga2R1bXAoU01F
KSwgdGhlcmUgYXJlIHR3byBjYXNlcyB0aGF0IGRvZXNuJ3Qgc3VwcG9ydDoNCj4gDQo+ICAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IHwgZmlyc3Qta2Vy
bmVsIHwgc2Vjb25kLWtlcm5lbCB8IGtkdW1wIHN1cHBvcnQgfA0KPiB8ICAgICAgKG1lbV9lbmNy
eXB0PW9ufG9mZikgICAgfCAgICh5ZXN8bm8pICAgIHwNCj4gfC0tLS0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS18DQo+IHwgICAgIG9uICAgICAgIHwgICAgIG9uICAg
ICAgICB8ICAgICB5ZXMgICAgICAgfA0KPiB8ICAgICBvZmYgICAgICB8ICAgICBvZmYgICAgICAg
fCAgICAgeWVzICAgICAgIHwNCj4gfCAgICAgb24gICAgICAgfCAgICAgb2ZmICAgICAgIHwgICAg
IG5vICAgICAgICB8DQo+IHwgICAgIG9mZiAgICAgIHwgICAgIG9uICAgICAgICB8ICAgICBubyAg
ICAgICAgfA0KPiB8X19fX19fX19fX19fX198X19fX19fX19fX19fX19ffF9fX19fX19fX19fX19f
X3wNCj4gDQo+IDEuIFNNRSBpcyBlbmFibGVkIGluIHRoZSBmaXJzdCBrZXJuZWwsIGJ1dCBTTUUg
aXMgZGlzYWJsZWQgaW4ga2R1bXAga2VybmVsDQo+IEluIHRoaXMgY2FzZSwgYmVjYXVzZSB0aGUg
b2xkIG1lbW9yeSBpcyBlbmNyeXB0ZWQsIHdlIGNhbid0IGRlY3J5cHQgdGhlDQo+IG9sZCBtZW1v
cnkuDQo+IA0KPiAyLiBTTUUgaXMgZGlzYWJsZWQgaW4gdGhlIGZpcnN0IGtlcm5lbCwgYnV0IFNN
RSBpcyBlbmFibGVkIGluIGtkdW1wIGtlcm5lbA0KPiBJdCBpcyB1bm5lY2Vzc2FyeSB0byBzdXBw
b3J0IGluIHRoaXMgY2FzZSwgYmVjYXVzZSB0aGUgb2xkIG1lbW9yeSBpcw0KPiB1bmVuY3J5cHRl
ZCwgdGhlIG9sZCBtZW1vcnkgY2FuIGJlIGR1bXBlZCBhcyB1c3VhbCwgd2UgZG9uJ3QgbmVlZCB0
byBlbmFibGUNCj4gU01FIGluIGtkdW1wIGtlcm5lbC4gQW5vdGhlciwgSWYgd2UgbXVzdCBzdXBw
b3J0IHRoZSBzY2VuYXJpbywgaXQgd2lsbA0KPiBpbmNyZWFzZSB0aGUgY29tcGxleGl0eSBvZiB0
aGUgY29kZSwgd2Ugd2lsbCBoYXZlIHRvIGNvbnNpZGVyIGhvdyB0byBwYXNzDQo+IHRoZSBTTUUg
ZmxhZyBmcm9tIHRoZSBmaXJzdCBrZXJuZWwgdG8gdGhlIGtkdW1wIGtlcm5lbCwgaW4gb3JkZXIg
dG8gbGV0IHRoZQ0KPiBrZHVtcCBrZXJuZWwga25vdyB0aGF0IHdoZXRoZXIgdGhlIG9sZCBtZW1v
cnkgaXMgZW5jcnlwdGVkLg0KPiANCj4gVGhlcmUgYXJlIHR3byBtZXRob2RzIHRvIHBhc3MgdGhl
IFNNRSBmbGFnIHRvIHRoZSBrZHVtcCBrZXJuZWwuIFRoZSBmaXJzdA0KPiBtZXRob2QgaXMgdG8g
bW9kaWZ5IHRoZSBhc3NlbWJseSBjb2RlLCB3aGljaCBpbmNsdWRlcyBzb21lIGNvbW1vbiBjb2Rl
IGFuZA0KPiB0aGUgcGF0aCBpcyB0b28gbG9uZy4gVGhlIHNlY29uZCBtZXRob2QgaXMgdG8gdXNl
IGtleGVjIHRvb2wsIHdoaWNoIGNvdWxkDQo+IHJlcXVpcmUgdGhlIFNNRSBmbGFnIHRvIGJlIGV4
cG9ydGVkIGluIHRoZSBmaXJzdCBrZXJuZWwgYnkgInByb2MiIG9yICJzeXNmcyIsDQo+IGtleGVj
IHRvb2xzIHdpbGwgcmVhZCB0aGUgU01FIGZsYWcgZnJvbSAicHJvYyIgb3IgInN5c2ZzIiB3aGVu
IHdlIHVzZSBrZXhlYw0KPiB0b29scyB0byBsb2FkIGltYWdlLCBzdWJzZXF1ZW50bHkgdGhlIFNN
RSBmbGFnIHdpbGwgYmUgc2F2ZWQgaW4gYm9vdF9wYXJhbXMsDQo+IHdlIGNhbiBwcm9wZXJseSBy
ZW1hcCB0aGUgb2xkIG1lbW9yeSBhY2NvcmRpbmcgdG8gdGhlIHByZXZpb3VzbHkgc2F2ZWQgU01F
DQo+IGZsYWcuIEJ1dCBpdCBpcyB0b28gZXhwZW5zaXZlIHRvIGRvIHRoaXMuDQo+IA0KPiBUaGlz
IHBhdGNoZXMgYXJlIG9ubHkgZm9yIFNNRSBrZHVtcCwgdGhlIHBhdGNoZXMgZG9uJ3Qgc3VwcG9y
dCBTRVYga2R1bXAuDQoNClJldmlld2VkLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNr
eUBhbWQuY29tPg0KDQpKdXN0IGN1cmlvdXMsIGFyZSB5b3UgcGxhbm5pbmcgdG8gYWRkIFNFViBr
ZHVtcCBzdXBwb3J0IGFmdGVyIHRoaXM/DQoNCkFsc28sIGEgcXVlc3Rpb24gYmVsb3cuLi4NCg0K
PiANCj4gVGVzdCB0b29sczoNCj4gbWFrZWR1bXBmaWxlW3YxLjYuM106IGh0dHBzOi8vZ2l0aHVi
LmNvbS9MaWFuYm9KL21ha2VkdW1wZmlsZQ0KPiBjb21taXQgZTFkZTEwM2VjYThmIChBIGRyYWZ0
IGZvciBrZHVtcCB2bWNvcmUgYWJvdXQgQU1EIFNNRSkNCj4gTm90ZTogVGhpcyBwYXRjaCBjYW4g
b25seSBkdW1wIHZtY29yZSBpbiB0aGUgY2FzZSBvZiBTTUUgZW5hYmxlZC4NCj4gDQo+IGNyYXNo
LTcuMi4zOiBodHRwczovL2dpdGh1Yi5jb20vY3Jhc2gtdXRpbGl0eS9jcmFzaC5naXQNCj4gY29t
bWl0IDAwMWY3N2EwNTU4NSAoRml4IGZvciBMaW51eCA0LjE5LXJjMSBhbmQgbGF0ZXIga2VybmVs
cyB0aGF0IGNvbnRhaW4NCj4gICAgICAgICAgICAgICAgICAgICAga2VybmVsIGNvbW1pdDcyOTBk
NTgwOTU3MTJhODlmODQ1ZTFiY2EwNTMzNDc5NmRkNDllZDIpDQo+IA0KPiBrZXhlYy10b29scy0y
LjAuMTc6IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vdXRpbHMva2VybmVsL2tleGVjL2tl
eGVjLXRvb2xzLmdpdA0KPiBjb21taXQgYjlkZTIxZWY1MWE3IChrZXhlYzogZml4IGZvciAiVW5o
YW5kbGVkIHJlbGEgcmVsb2NhdGlvbjogUl9YODZfNjRfUExUMzIiIGVycm9yKQ0KPiBOb3RlOg0K
PiBCZWZvcmUgeW91IGxvYWQgdGhlIGtlcm5lbCBhbmQgaW5pdHJhbWZzIGZvciBrZHVtcCwgdGhp
cyBwYXRjaChodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwva2V4ZWMvMjAxOC1T
ZXB0ZW1iZXIvMDIxNDYwLmh0bWwpDQo+IG11c3QgYmUgbWVyZ2VkIHRvIGtleGVjLXRvb2xzLCBh
bmQgdGhlbiB0aGUga2R1bXAga2VybmVsIHdpbGwgd29yayB3ZWxsLiBCZWNhdXNlIHRoZXJlDQo+
IGlzIGEgcGF0Y2ggd2hpY2ggaXMgcmVtb3ZlZCBiYXNlZCBvbiB2Nih4ODYvaW9yZW1hcDogc3Ry
ZW5ndGhlbiB0aGUgbG9naWMgaW4gZWFybHlfbWVtcmVtYXBfcGdwcm90X2FkanVzdCgpDQo+IHRv
IGFkanVzdCBlbmNyeXB0aW9uIG1hc2spLg0KPiANCj4gVGVzdCBlbnZpcm9ubWVudDoNCj4gSFAg
UHJvTGlhbnQgREwzODVHZW4xMCBBTUQgRVBZQyA3MjUxDQo+IDgtQ29yZSBQcm9jZXNzb3INCj4g
MzI3NjggTUIgbWVtb3J5DQo+IDYwMCBHQiBkaXNrIHNwYWNlDQo+IA0KPiBMaW51eCA0LjE5LXJj
MjoNCj4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdA0KPiBjb21taXQgNTczNjE4NDZiNTJiYzY4NjExMmRhNmNhNTM2OGQxMTIx
MDc5NjgwNA0KPiANCj4gUmVmZXJlbmNlOg0KPiBBTUQ2NCBBcmNoaXRlY3R1cmUgUHJvZ3JhbW1l
cidzIE1hbnVhbA0KPiBodHRwczovL3N1cHBvcnQuYW1kLmNvbS9UZWNoRG9jcy8yNDU5My5wZGYN
Cj4gDQo+IENoYW5nZXMgc2luY2UgdjY6DQo+IDEuIFRoZXJlIGlzIGEgcGF0Y2ggd2hpY2ggaXMg
cmVtb3ZlZCBiYXNlZCBvbiB2Ni4NCj4gKHg4Ni9pb3JlbWFwOiBzdHJlbmd0aGVuIHRoZSBsb2dp
YyBpbiBlYXJseV9tZW1yZW1hcF9wZ3Byb3RfYWRqdXN0KCkgdG8gYWRqdXN0IGVuY3J5cHRpb24g
bWFzaykNCj4gRGF2ZSBZb3VuZyBzdWdnZXN0cyB0aGF0IHRoaXMgcGF0Y2ggY2FuIGJlIHJlbW92
ZWQgYW5kIGZpeCB0aGUga2V4ZWMtdG9vbHMuDQo+IFJlZmVyZW5jZTogaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2tleGVjLzIwMTgtU2VwdGVtYmVyLzAyMTQ2MC5odG1sKQ0K
PiAyLiBVcGRhdGUgdGhlIHBhdGNoIGxvZy4NCj4gDQo+IFNvbWUga25vd24gaXNzdWVzOg0KPiAx
LiBhYm91dCBTTUUNCj4gVXBzdHJlYW0ga2VybmVsIHdpbGwgaGFuZyBvbiBIUCBtYWNoaW5lKERM
Mzg1R2VuMTAgQU1EIEVQWUMgNzI1MSkgd2hlbg0KPiB3ZSBleGVjdXRlIHRoZSBrZXhlYyBjb21t
YW5kIGFzIGZvbGxvdzoNCj4gDQo+ICMga2V4ZWMgLWwgL2Jvb3Qvdm1saW51ei00LjE5LjAtcmMy
KyAtLWluaXRyZD0vYm9vdC9pbml0cmFtZnMtNC4xOS4wLXJjMisuaW1nIC0tY29tbWFuZC1saW5l
PSJyb290PS9kZXYvbWFwcGVyL3JoZWxfaHAtLWRsMzg1ZzEwLS0wMy1yb290IHJvIG1lbV9lbmNy
eXB0PW9uIHJkLmx2bS5sdj1yaGVsX2hwLWRsMzg1ZzEwLTAzL3Jvb3QgcmQubHZtLmx2PXJoZWxf
aHAtZGwzODVnMTAtMDMvc3dhcCBjb25zb2xlPXR0eVMwLDExNTIwMG44MSBMQU5HPWVuX1VTLlVU
Ri04IGVhcmx5cHJpbnRrPXNlcmlhbCBkZWJ1ZyBub2thc2xyIg0KPiAjIGtleGVjIC1lIChvciBy
ZWJvb3QpDQo+IA0KPiBCdXQgdGhpcyBpc3N1ZSBjYW4gbm90IGJlIHJlcHJvZHVjZWQgb24gc3Bl
ZWR3YXkgbWFjaGluZSwgYW5kIHRoaXMgaXNzdWUNCj4gaXMgaXJyZWxldmFudCB0byBteSBwb3N0
ZWQgcGF0Y2hlcy4NCj4gDQo+IFRoZSBrZXJuZWwgbG9nOg0KPiBbIDEyNDguOTMyMjM5XSBrZXhl
Y19jb3JlOiBTdGFydGluZyBuZXcga2VybmVsDQo+IGVhcmx5IGNvbnNvbGUgaW4gZXh0cmFjdF9r
ZXJuZWwNCj4gaW5wdXRfZGF0YTogMHgwMDAwMDAwODdlOTFjM2I0DQo+IGlucHV0X2xlbjogMHgw
MDAwMDAwMDAwNjdmY2JkDQo+IG91dHB1dDogMHgwMDAwMDAwODdkNDAwMDAwDQo+IG91dHB1dF9s
ZW46IDB4MDAwMDAwMDAwMWI2ZmE5MA0KPiBrZXJuZWxfdG90YWxfc2l6ZTogMHgwMDAwMDAwMDAx
YTlkMDAwDQo+IHRyYW1wb2xpbmVfMzJiaXQ6IDB4MDAwMDAwMDAwMDA5OTAwMA0KPiANCj4gRGVj
b21wcmVzc2luZyBMaW51eC4uLg0KPiBQYXJzaW5nIEVMRi4uLiAgICAgICAgWy0tLUhlcmUgdGhl
IHN5c3RlbSB3aWxsIGhhbmddDQoNCkRvIHlvdSBrbm93IHRoZSByZWFzb24gZm9yIHRoZSBoYW5n
PyAgSXQgbG9va3MgbGlrZSBpdCBpcyBoYW5naW5nIGluDQpwYXJzZV9lbGYoKS4gIENhbiB5b3Ug
YWRkIHNvbWUgZGVidWcgdG8gcGFyc2VfZWxmKCkgdG8gc2VlIGlmIHRoZQ0KdmFsdWUgb2YgZWhk
ci5lX3BobnVtIGlzIHZhbGlkIChtYXliZSBpdCBpcyBub3QgYSB2YWxpZCB2YWx1ZSBhbmQgc28N
CnRoZSBsb29wIHRha2VzIGZvcmV2ZXIpPw0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4gDQo+IExp
YW5ibyBKaWFuZyAoNCk6DQo+ICAgeDg2L2lvcmVtYXA6IGFkZCBhIGZ1bmN0aW9uIGlvcmVtYXBf
ZW5jcnlwdGVkKCkgdG8gcmVtYXAga2R1bXAgb2xkDQo+ICAgICBtZW1vcnkNCj4gICBrZXhlYzog
YWxsb2NhdGUgdW5lbmNyeXB0ZWQgY29udHJvbCBwYWdlcyBmb3Iga2R1bXAgaW4gY2FzZSBTTUUg
aXMNCj4gICAgIGVuYWJsZWQNCj4gICBhbWRfaW9tbXU6IHJlbWFwIHRoZSBkZXZpY2UgdGFibGUg
b2YgSU9NTVUgd2l0aCB0aGUgbWVtb3J5IGVuY3J5cHRpb24NCj4gICAgIG1hc2sgZm9yIGtkdW1w
DQo+ICAga2R1bXAvdm1jb3JlOiBzdXBwb3J0IGVuY3J5cHRlZCBvbGQgbWVtb3J5IHdpdGggU01F
IGVuYWJsZWQNCj4gDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pby5oICAgICAgICAgICAgfCAg
MyArKw0KPiAgYXJjaC94ODYva2VybmVsL01ha2VmaWxlICAgICAgICAgICAgIHwgIDEgKw0KPiAg
YXJjaC94ODYva2VybmVsL2NyYXNoX2R1bXBfZW5jcnlwdC5jIHwgNTMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgYXJjaC94ODYvbW0vaW9yZW1hcC5jICAgICAgICAgICAgICAgIHwg
MjUgKysrKysrKystLS0tLQ0KPiAgZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jICAgICAg
IHwgMTQgKysrKysrLS0NCj4gIGZzL3Byb2Mvdm1jb3JlLmMgICAgICAgICAgICAgICAgICAgICB8
IDIxICsrKysrKystLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2NyYXNoX2R1bXAuaCAgICAgICAgICAg
fCAxMiArKysrKysrDQo+ICBrZXJuZWwva2V4ZWNfY29yZS5jICAgICAgICAgICAgICAgICAgfCAx
MiArKysrKysrDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspLCAxNiBkZWxl
dGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3g4Ni9rZXJuZWwvY3Jhc2hfZHVt
cF9lbmNyeXB0LmMNCj4gDQo=
