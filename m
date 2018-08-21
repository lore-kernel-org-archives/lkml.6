Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC200C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0FC214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z57auqH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0FC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeHUVsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:48:53 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:51844
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbeHUVsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx1CL79HGeLPEPvKumsS3p3DvV7cH9hZBRLXAha7jnU=;
 b=z57auqH/WxKXAE8qWk+tMVwEHqjQ7faeHRVBl+cL8zDloCvCkSs4g1vmQN+xrEtd/Un9W50qMbzdZ6fZWotDxBr0iNcrX5VxnxuR6bxoi1AP3dxcXw0ddVsmbG97QOgaIVg6/RvwedplmJKEkJVuKP5F6wA3O8iNg1m7hNyJzJU=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2721.namprd12.prod.outlook.com (20.176.178.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Tue, 21 Aug 2018 18:27:35 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::60a7:5c31:8fd7:825d]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::60a7:5c31:8fd7:825d%4]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 18:27:35 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Thread-Topic: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Thread-Index: AQHUL+qPjfuIpXUOskyw2O7P1ShxPqS3mUYAgAAhmNCACUXnAIABukEQgAeHQ4CAAFbVkA==
Date:   Tue, 21 Aug 2018 18:27:34 +0000
Message-ID: <BN7PR12MB2593D34AEBB6BFD8CAC381AEF8310@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809140834.59264-2-Yazen.Ghannam@amd.com>
 <20180809161806.GB20928@nazgul.tnic>
 <BN7PR12MB259395675EBD74400D9FEBE5F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
 <20180815155452.GB28669@nazgul.tnic>
 <BN7PR12MB2593C9819A949A2F7571FAB7F83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
 <20180821131541.GE30528@nazgul.tnic>
In-Reply-To: <20180821131541.GE30528@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2721;20:vLJy9qtddPPpE79bp9inJfsPCi3hEWJ67SaEdRyLb7B1D+DdTcbTfDFGDyCtL6zACX4W+jUlgKHG7lLzkYzlZqwZSN4ICDnZQWitI+qVvjiBPWfE/yF2wWxB1GcD59y3r1LZKdZgylT5Rajq0/pL/oCuceV2yBRYrU+/NfI3q6/N7BdfMB/1c9WsUfj3BAyswWInN8nzk0dqBtzClXaXZCW3JgVx8uVtwMdq3hU8reoefDn96xfLmc1iW+CeKHOS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ff7435dc-3eb1-4700-6f39-08d60793c41b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2721;
x-ms-traffictypediagnostic: BN7PR12MB2721:
x-microsoft-antispam-prvs: <BN7PR12MB2721172075527F43EB43CDBEF8310@BN7PR12MB2721.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(105169848403564)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:BN7PR12MB2721;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2721;
x-forefront-prvs: 0771670921
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(13464003)(199004)(189003)(486006)(7696005)(86362001)(7736002)(106356001)(5660300001)(6436002)(76176011)(229853002)(316002)(2900100001)(2906002)(93886005)(305945005)(476003)(4326008)(256004)(68736007)(74316002)(6246003)(54906003)(105586002)(446003)(11346002)(8676002)(25786009)(186003)(102836004)(46003)(72206003)(5250100002)(33656002)(6506007)(81166006)(81156014)(478600001)(53546011)(9686003)(53936002)(8936002)(97736004)(14454004)(6916009)(55016002)(99286004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2721;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1qefkvgDownBxM4m59ljCs1LADBEqwRpqa7GliM8G+Ri+c7OCdc/PKEfdltSs5f3mQRlDfdu7m2+IrMHYLrLJov+I70K0tKrTEILkOwgaISxJ5HeZv9CK/zkkjUvItq62wbmblB58MKFCI2x4K98aeCNek3xpOHK9uYYIyWLHsbv+0EaXZN5/F6JYpNT/anFTxFRIheWoH/YKLD8jJQgaPOQxIale6AlOjc/3lLk/IKxGINgT1I9ztORedz0s/XachQnzsD8RntDS2BkDetlk9eDOQpALTnPjUtCDHLpvP6Q9f08z6rqcI4J2sLHcFYbxABfSaFj5Mi8mgDqaDhy0F3vFlhBCsINVvowEfgW6Ds=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7435dc-3eb1-4700-6f39-08d60793c41b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 18:27:34.9504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDIxLCAyMDE4IDg6MTYgQU0NCj4g
VG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENjOiBsaW51eC1l
ZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gdG9u
eS5sdWNrQGludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzJdIHg4Ni9NQ0UvQU1EOiBTa2lwIGNyZWF0aW5nIGtvYmplY3RzIHdpdGggTlVMTA0KPiBuYW1l
cw0KPiANCj4gT24gVGh1LCBBdWcgMTYsIDIwMTggYXQgMDY6NDY6MzNQTSArMDAwMCwgR2hhbm5h
bSwgWWF6ZW4gd3JvdGU6DQo+ID4gRnV0dXJlIFNNQ0Egc3lzdGVtcyBtYXkgaGF2ZSBiYW5rcyB3
aG9zZSBNQ0FfSVBJRCBpcyBub3Qga25vd24gc28gd2UNCj4gDQo+IFlvdSBsb3N0IG1lIGhlcmUu
IEhvdyB3b3VsZCB0aGUgSVBJRCBub3QgYmUga25vd24/IEFyZSB5b3UgdGFsa2luZyBhYm91dA0K
PiBhbiBvbGQga2VybmVsIHJ1bm5pbmcgb24gbmV3IEhXIGFuZCB0aHVzIHRoZSBIYXJkd2FyZUlE
IGluIGl0cyBNQ0FfSVBJRA0KPiB0byBiZSB1bmtub3duIHRvIHRoZSBvbGQga2VybmVsPw0KPiAN
Cg0KWWVzLCB0aGF0J3MgcmlnaHQ6IG9sZCBrZXJuZWwgb24gbmV3IEhXLg0KDQo+ID4gSW4gdGhl
IHBhc3QsIHRoZSBzeXNmcyBlbnRyaWVzIHdlcmUgbmFtZWQgc29tZXRoaW5nIGxpa2UgInRoX2Jh
bmsjIiBiZWZvcmUNCj4gPiBlYWNoIGJhbmsgd2FzIGdpdmVuIGEgbW9yZSBkZXNjcmlwdGl2ZSBu
YW1lLiBXZSBjYW4gZ28gYmFjayB0byB0aGlzIGZvcm1hdA0KPiA+IGFzIGEgZmFsbGJhY2sgZm9y
IHVucmVjb2duaXplZCBiYW5rIHR5cGVzLiBUaGlzIHdpbGwgZml4IHRoZSBpc3N1ZSB3aXRoIHN5
c2ZzDQo+ID4gZmFpbGluZyBhbmQgYWxzbyB0aGUgaW50ZXJmYWNlIHdpbGwgc3RpbGwgd29yayBv
biBuZXcgaGFyZHdhcmUuDQo+IA0KPiBZb3UgY291bGQgZG86IHRoX2JhbmsjPEhhcmR3YXJlSUQ+
IHNvIHRoYXQgd2UgY2FuIGZpbmQgd2hhdCBpdCBpcyBieQ0KPiBncmVwcGluZyB0aGUgUFBSLg0K
PiANCg0KR29vZCBpZGVhLiBXaWxsIGRvLg0KDQpUaGFua3MsDQpZYXplbg0K
