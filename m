Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABC1C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998DD2177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ApaAM0A1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfBCSOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 13:14:23 -0500
Received: from mail-eopbgr1320131.outbound.protection.outlook.com ([40.107.132.131]:53509
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbfBCSOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 13:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw1eOAepF7uub20qicUZMGXTIWEh5fPspr8Tmhifqz0=;
 b=ApaAM0A1+7J5x0mnC6SWc+cTSjNg5pjdE23i73JlgJOQJBJiyluZXUTmm595uGYFjAXRVCMu/RL5hivtCWWcWEL8zpxvD7bYrfCaT95beZZjh1y0RyQ1hOUU48s8HEXstXhXhSctB5EUCrEO8vDygrSnVhCivkqnBCfsY0rxsws=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0140.APCP153.PROD.OUTLOOK.COM (10.170.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.5; Sun, 3 Feb 2019 18:13:36 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1622.000; Sun, 3 Feb 2019
 18:13:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
Thread-Topic: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM
 family
Thread-Index: AQHUu+TohgnD5hWBBUGGy2lRJKF6bKXOWb4AgAABhxA=
Date:   Sun, 3 Feb 2019 18:13:35 +0000
Message-ID: <PU1P153MB0169F7C111EEC5890D3F840ABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
 <PU1P153MB0169BD9237F2DC1FA64721BABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4h0B0sBMjiAC=Tk=Mu58A4vZ5F9yUPQsXqf5jyYF37VCw@mail.gmail.com>
In-Reply-To: <CAPcyv4h0B0sBMjiAC=Tk=Mu58A4vZ5F9yUPQsXqf5jyYF37VCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-03T18:13:33.9466043Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=be00ab77-3ac9-4052-9623-58cc6bee22df;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [73.53.115.85]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0140;6:olKnf2p7rAUR6E+HGLC/aYyASp3gYe2J2CKN0mlTugb13xtlHeQ/81Fe2fwCPDzQkmZ2UfnyW8T11ntYE4aUiX64aRCsHZ5MQDAIuCPB4XJMZc6uVASHeOiOlr54tyld4iXEIN19gassBysVjvBgiNxWryQNJAnDtNZGSTbM3xPv6y9eD64GOl0093qXBHTk2scT41m+Vl/aX7gRsWQOvkpqM+8KkFZRv8cqBtniV4cUwJNVE5nD2JtOSs1bS51i/VLTrWgtx9OcUxyr4gCjLDTdF+2NGDsmHdPlYmW30S74GdjGR+M+ciIeHztRKyF7YtNI9/FlSUATOXm9AGszSomfGIVfv/URXoTTXccnkgM4NfinrYhqlzpQWAHelQRGy2bTeVKZoXVfB0AjRVDHk1MB10uXt09jCXFR/XdUnBQ5kKNfpTY2lsb3GFOADg3Raz1jkEkvtaBd70k+pUHHzg==;5:5S54hBW02SU89pD0A1nYvP6j6fv4WabTJ6Gbyiw0rZXaZt3HVnPpcKWXofbG9k8FqpYLgF1tBr1CnGJHjDoSb3NS8WoHO6XVTBOeRPUwuqFVLysuG7qBr+0Ju0iMRjdmCxztd87NyF2uIgPXdrrl82FXm32OtYmAfVhXrvp5S2KfNVp6aKrTf+Rle1pdbC/H/pIc8/MZjchIzT5E71v8SA==;7:U9sZxspYiRtMmZhf9R/lm44B6K5dvx8XMM/H4jRgFkgutxgRMN688dOjHXI7VVINYjvIjstKYkr89614YKk8w7CjVbTYOVqHonrPIqnQaucHWLJ2YsqbAQQlKKMWlCcKSk0l0J9OaF54L/XC+OK1Lg==
x-ms-office365-filtering-correlation-id: fd730feb-69ef-462d-02f4-08d68a035091
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0140;
x-ms-traffictypediagnostic: PU1P153MB0140:
x-microsoft-antispam-prvs: <PU1P153MB0140987D9C163F44876A6FC4BF6C0@PU1P153MB0140.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39850400004)(136003)(189003)(199004)(51914003)(55016002)(305945005)(26005)(74316002)(99286004)(9686003)(7696005)(7736002)(76176011)(107886003)(53936002)(4326008)(25786009)(14444005)(6436002)(186003)(256004)(97736004)(102836004)(8676002)(6246003)(11346002)(81156014)(8936002)(6916009)(81166006)(446003)(476003)(486006)(2906002)(86362001)(8990500004)(10090500001)(33656002)(68736007)(316002)(22452003)(6116002)(6506007)(66066001)(3846002)(10290500003)(71200400001)(478600001)(71190400001)(14454004)(54906003)(106356001)(93886005)(86612001)(105586002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0140;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yPJ0io2ca7UNxfdf7cz4F9DL9H+7gfXeY9K9W1KLMTxZTseGVx1QUCLUNvodwtfb5I8WQsrehDHwYadaI1P6MNd/5flYajRO+VJMeoSIgMYriXNEHQyxruPeGWBwqvLTZ43Grfm8bKychaBnVrWdKEpxwzRmhSLMiuyh68tQccxTVVZa5OxdWj5A1Cw9XpEf3Siqo4/XtvGzgKG73V0kYzIv5VLSyfD+qCz7PiuJjqXguyyZJbUJSG/53Xe2oPtSnUyNC1scvOEWGbDlXmkwseLGMOr1Kou9Zoe7oz/Vcjbe9MkhvigSvVXme0IEuibvmuKH+HWNcuKgcwZDype6LsEPwHtCfwSHXNT9JvP3/VGgrRIKtw8poCKtKICn988064L4OHHSNmqoPXpxLAX4VrZKtKLtq9AHwZtnD0UH1Qg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd730feb-69ef-462d-02f4-08d68a035091
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 18:13:35.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
U3VuZGF5LCBGZWJydWFyeSAzLCAyMDE5IDk6NDkgQU0NCj4gPiAuLi4NCj4gPiBJdCBsb29rcyB0
aGUgbmFtZXNwYWNlIGNyZWF0ZWQgYnkgVWJ1bnR1IDE5LjA0ICg0LjE4KSBpcyBpbmNvbXBhdGli
bGUgd2l0aA0KPiA+IHRoZSBsaWJudmRpbW0tcGVuZGluZyBicmFuY2ggKyB0aGlzIHBhdGNoLg0K
PiANCj4gVGhpcyBpcyBjb3JyZWN0LCB0aGUgY29uZmlndXJhdGlvbiBzd2l0Y2hlZCBmcm9tIGxh
YmVsLWxlc3MgYnkgZGVmYXVsdA0KPiB0byBsYWJlbGVkLg0KVGhhbmtzIGZvciB0aGUgY29uZmly
bWF0aW9uISANCiANCj4gPiBJdCBsb29rcyB3ZSBuZWVkIHRvIGNvbXBsZXRlbHkgZGlzYWJsZSB0
aGUgbGFiZWwgdXNhZ2UgZm9yDQo+IE5WRElNTV9GQU1JTFlfSFlQRVJWDQo+ID4gZHVlIHRvIGNv
bXBhYmlsaXR5Pw0KPiANCj4gSXQncyBlaXRoZXIgZ29pbmcgdG8gYmUgYSBxdWlyayBpbiBMaW51
eCBvciBhIHF1aXJrIGluIHRoZSBIeXBlci1WDQo+IGNvbmZpZ3VyYXRpb24uIEkgdGhpbmsgaXQn
cyBtb3JlIG1hbmFnZWFibGUgZm9yIEh5cGVyLVYgdG8gc2hpcCBhDQo+ICJsYWJlbCBkaXNhYmxl
IiBzd2l0Y2ggdGhhbiB0byB0cnkgdG8gc2hpcCBhIHdvcmthcm91bmQgaW4gTGludXguIFRoZQ0K
PiAibm9ibGsiIHF1aXJrIGluIExpbnV4IHdvcmtzIGFyb3VuZCB0aGUgTE9DQUwgYml0IGluIHRo
ZSBsYWJlbHMuDQo+IEhvd2V2ZXIsIHRoZSBuYW1lc3BhY2UgbW9kZSByZWdyZXNzaW9uIGNhbiBv
bmx5IGJlIHJlc29sdmVkIGJ5IGhpZGluZw0KPiB0aGUgbGFiZWwgY2FwYWJpbGl0eSB1bnRpbCB0
aGUgYWRtaW5pc3RyYXRvciBtYW51YWxseSBzd2l0Y2hlcyBmcm9tDQo+IGxhYmVsLWxlc3MgdG8g
bGFiZWxlZCBvcGVyYXRpb24uDQoNCkFzIEkgdW5kZXJzdGFuZCwgdGhlIGVzc2VuY2Ugb2YgdGhl
IGlzc3VlIGlzOiBIeXBlci1WIGVtdWxhdGVzIHRoZQ0KbGFiZWwgbWVjaGFuaXNtIChpLmUuIGl0
IHN1cHBvcnRzIF9MU0kgYW5kIExTUiksIGJ1dCBkb2Vzbid0IGRvIGl0DQpyaWdodCAoaS5lLiBp
dCBkb2Vzbid0IHN1cHBvcnQgX0xTVykuDQoNClRvIG1hbmFnZSB0aGUgbmFtZXNwYWNlcywgTGlu
dXggY2FuIGNob29zZSB0byB1c2UgbGFiZWwgb3Igbm90Lg0KDQpJZiBfTFNJL19MU1IgYXJlIHN1
cHBvcnRlZCwgTGludXggYXNzdW1lcyBfTFNXIGlzIHN1cHBvcnRlZCBhcyB3ZWxsDQphbmQgY2hv
b3NlcyB0byB1c2UgbGFiZWwgKGkuZS4gdGhlIGxhYmVsIG1vZGUpLCBidXQgc2luY2UgSHlwZXIt
ViBkb2Vzbid0DQpzdXBwb3J0IF9MU1csIExpbnV4IGZhaWxzIHRvIGNoYW5nZSB0aGUgbmFtZXNw
YWNlIGNvbmZpZ3VyYXRpb24uIEluDQpVYnVudHUgMTkuMDQgKDQuMTgpLCB0aGUga2VybmVsIGlz
IG5vdCBhd2FyZSBvZiBIeXBlci1WIF9MU0kvX0xTUiwgc28NCnRoZSBjcmVhdGVkIG5hbWVzcGFj
ZSBpcyBpbiAibGFiZWwtbGVzcyIgbW9kZSwgYW5kIGhlbmNlIGNhbid0IGJlIHVzZWQNCndpdGgg
dGhlIGxpYm52ZGltbS1wZW5kaW5nIGJyYW5jaCArIHRoaXMgcGF0Y2gsIHVubGVzcyB3ZSBhZGQg
YSBxdWlyaw0KaW4gTGludXggdG8gZXhwbGljaXRseSBub3QgdXNlIHRoZSBsYWJlbC4NCg0KSSBh
Z3JlZSBpZGVhbGx5IEh5cGVyLVYgc2hvdWxkIGhpZGUgdGhlIGxhYmVsIGNhcGFiaWxpdHksIGFu
ZCBJJ2xsIHJlcXVlc3QNCkh5cGVyLVYgdGVhbSB0byBkbyB0aGF0LiBJIGhvcGUgSHlwZXItViBn
dXlzIGFyZSBzdGlsbCBhYmxlIHRvIGRvIHRoYXQNCmluIHRpbWUgc28gd2Ugd29uJ3QgbmVlZCBh
IHF1aXJrIGluIExpbnV4IGtlcm5lbC4NCg0KQlRXLCBJIHN1cHBvc2UgV2luZG93cyBWTSBzaG91
bGQgYmUgaW4gImxhYmVsLWxlc3MiIG1vZGUuDQoNClRoYW5rcyBmb3IgdGhlIGhlbHAsIERhbiEN
Cg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
