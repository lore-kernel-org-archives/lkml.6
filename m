Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339062081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="HkPxJ40N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339062081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeK2Llj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:41:39 -0500
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:38119
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbeK2Llj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d012L0aqc2iPnxS/2SdXKN+ylV/FBZsUGgNTKNVpFX0=;
 b=HkPxJ40NwHCI5olpk/2mrxl7UZaSxcpzO6Mc/Hu0H/WEzvIlVlpA/9q0XqI9Cs9YTmvvivufNkBekOZmZAVkU7iwHrZ9W/RgeB5Npe6UEZ4VPCdFvKn8YFB+wxIRQRdXHtjgGyMrjuoeHkrbw8lV9XeDmRu9IfIkLznMwycHzLY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5286.namprd05.prod.outlook.com (20.177.126.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.6; Thu, 29 Nov 2018 00:38:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1404.008; Thu, 29 Nov 2018
 00:38:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Topic: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Index: AQHUetXZ1x6cjbBfk0ugZnU2RuWk66VNksAAgABrugCAAArpgIAA2IoAgACsc4CAAH6KgIAACqQAgBXRgICAABjcAA==
Date:   Thu, 29 Nov 2018 00:38:07 +0000
Message-ID: <5682CCB4-B7D3-4DDC-81BB-2D4DCE968A3D@vmware.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
 <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
 <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
 <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
 <7072A2D8-30F8-45CB-AB0C-B1BE4A30259A@vmware.com>
 <db8293cf-9abc-e899-8f43-6e42039006d9@deltatee.com>
 <521458D7-A27C-4112-81ED-1974EFE96A76@vmware.com>
 <be24a6eb-ebf0-8d9f-0051-681f0da66109@deltatee.com>
In-Reply-To: <be24a6eb-ebf0-8d9f-0051-681f0da66109@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5286;20:C4X23cYD9rPc5I7rwTSaa8kZ7ShkWUBrS/MtkvaWZ2cWKNnmy9DVLY4gbbFDWJQw7DfMxghCsi/hyaKxKy1OAV1Bs3z2HIiJKCAUPjBW0E1vjYp+7N0hrFusWWm8Ci76rBZjNwWjaGg/KEJ/4KLDR+tiNkgSD4eQTO8Xvsjg2tU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4cb10837-9ed9-44fe-127d-08d65592ee6d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5286;
x-ms-traffictypediagnostic: BYAPR05MB5286:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB5286E4561AB4F166968B16B6D0D20@BYAPR05MB5286.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231449)(999002)(944501445)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5286;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5286;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(366004)(39860400002)(199004)(189003)(25786009)(53546011)(53936002)(6116002)(11346002)(6916009)(3846002)(6506007)(93886005)(476003)(4326008)(486006)(102836004)(446003)(305945005)(45080400002)(478600001)(36756003)(66066001)(2616005)(76176011)(105586002)(256004)(8676002)(106356001)(33656002)(2906002)(229853002)(186003)(86362001)(7736002)(81156014)(81166006)(6306002)(6512007)(6246003)(54906003)(82746002)(6436002)(97736004)(71190400001)(26005)(5660300001)(8936002)(316002)(966005)(7416002)(4001150100001)(14454004)(68736007)(6486002)(99286004)(83716004)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5286;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jVn82s7ZPLi4GbTLNxsqgr3F5WxZai24UWwXcxkYM2pO4uFL5FWZ0Cd1eX0YjoAMKn5R/jaleh4iKFDpslpB3HyD/VcPkTxqmuWjWXEhjqcfZVeMwgYHeMoPovo0iG10kfHETnpVT48qJOVtzjT0BBDLVAagTP1f7dLC8qGJxontzf9uS9m54t0OLWkNLBbpfaM4vMjyIZmspgGvOWBC6+sqWlN3GBHCQDzEywsu6UDDkk7ZMXv22j1YlVM+leDGTgOhi1ASDXvjwN8h5ubOUpaVk+f4OtV/SDBrYLk+B82QiVTWS6CSSQpr9gf45ebFCuANJAyxSd9hIhDK7K77ZNfkvaVZ/ajV4LiDb63NnDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <42B69C23C1F7F84D9B7DD0F4DC845762@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb10837-9ed9-44fe-127d-08d65592ee6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 00:38:07.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjgsIDIwMTgsIGF0IDM6MDkgUE0sIExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRl
bHRhdGVlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDIwMTgtMTEtMTQgNjo1NyBwLm0u
LCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gRXZlbnR1YWxseSwgaWYgeW91IGdldCBhIGZpeCBpbnRv
IGljZWNjLCB3ZSB3aWxsIG5lZWQgdG8gY2hhbmdlIHRoZQ0KPj4gTWFrZWZpbGUsIGNvbnNpZGVy
IHRoZSB2ZXJzaW9uIG51bWJlciBhbmQgYWN0IGFjY29yZGluZ2x5Lg0KPiANCj4gSSBnb3QgYSBm
aXggcHVsbGVkIGludG8gaWNlY2NbMV0gYW5kIGl0IHdvcmtzIHF1aXRlIHdlbGwuIEl0IG91Z2h0
IHRvIGJlDQo+IGluY2x1ZGVkIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgaWNlY2MuIEFuZCBkaXN0
Y2MgKHdpdGggcHVtcCBhdCBsZWFzdCkNCj4gaGFzIGEgcGF0Y2ggdG9vLiBJbiBteSBleHBlcmll
bmNlLCBpY2VjYyBkb2VzIGEgbXVjaCBiZXR0ZXIgam9iDQo+IGRpc3RyaWJ1dGluZyB0aGUga2Vy
bmVsIGJ1aWxkIHRob3VnaC4NCj4gDQo+IExvZ2FuDQo+IA0KPiBbMV0gaHR0cHM6Ly9uYTAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRodWIu
Y29tJTJGaWNlY2MlMkZpY2VjcmVhbSUyRnB1bGwlMkY0MzAmYW1wO2RhdGE9MDIlN0MwMSU3Q25h
bWl0JTQwdm13YXJlLmNvbSU3QzA0NGQ3OTViZTMwMTQzYWUyNmVmMDhkNjU1ODY5NTNiJTdDYjM5
MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjc5MDQzMzg4NDIyMjYz
NSZhbXA7c2RhdGE9NGg3MnlManZPRjI5a2NBQzVDTTdDQjl1a0gzSG9BTE5VZmdLQTYyRTRHcyUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KDQpUaGFua3MgZm9yIHRha2luZyBjYXJlIG9mIGl0LiBUaGlzIGNo
YW5nZSBpcyBjZXJ0YWlubHkgc2ltcGxlciBhbmQgY2xlYW5lcg0KdGhhbiB0aGUgb25lIEkgY2Ft
ZSB3aXRoLg0KDQpTbyB3aGF04oCZcyB5b3VyIHRha2U/IFdvdWxkIHlvdSB0aGluayB0aGlzIHBh
dGNoIGlzIHN0aWxsIG5lZWRlZD8gU2hvdWxkIGl0DQpvbmx5IGJlIGVuYWJsZWQgYXV0b21hdGlj
YWxseSBmb3IgZGlzdGNjIGFuZCBub3QgZm9yIGRpc3RjYy1wdW1wPw0KDQo=
