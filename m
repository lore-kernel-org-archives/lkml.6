Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A3AC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF17F20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mHehVlE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF17F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLARlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:41:10 -0500
Received: from mail-eopbgr690068.outbound.protection.outlook.com ([40.107.69.68]:39546
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbeLARlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 12:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgn6QOVBiDyoqmhK8ySm+EUSqfml+mICk+zWzAanJVs=;
 b=mHehVlE5at6Wt73ezpueATOsRrxaZ6oso0+u076CZ+Y00+Zvs4S43XTAObuEiZmH27tZijTJoweoPCdROcdCy6xAIEb7HlEBNHKjfYjCpVarp9LLtst/llN2JtUVtEEDgJxOBkQgf3RBurOUaC86KmfWSWDB2olfCMSrM3dL6e0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4856.namprd05.prod.outlook.com (52.135.235.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.13; Sat, 1 Dec 2018 06:29:14 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1404.011; Sat, 1 Dec 2018
 06:29:14 +0000
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
Thread-Index: AQHUetXZ1x6cjbBfk0ugZnU2RuWk66VNksAAgABrugCAAArpgIAA2IoAgACsc4CAAH6KgIAACqQAgBXRgICAABjcAIAAAzkAgAALrgCAAP68AIACeR8A
Date:   Sat, 1 Dec 2018 06:29:14 +0000
Message-ID: <0707DBAD-9658-4F5F-894C-A16D66F11CA3@vmware.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
 <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
 <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
 <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
 <7072A2D8-30F8-45CB-AB0C-B1BE4A30259A@vmware.com>
 <db8293cf-9abc-e899-8f43-6e42039006d9@deltatee.com>
 <521458D7-A27C-4112-81ED-1974EFE96A76@vmware.com>
 <be24a6eb-ebf0-8d9f-0051-681f0da66109@deltatee.com>
 <5682CCB4-B7D3-4DDC-81BB-2D4DCE968A3D@vmware.com>
 <336cf7d8-6495-b112-8d3a-c146222fda78@deltatee.com>
 <1CAF7187-4732-4BC9-8F7F-93EB16ED14E9@vmware.com>
 <7602f831-72db-888b-4b99-14763a2a3ac5@deltatee.com>
In-Reply-To: <7602f831-72db-888b-4b99-14763a2a3ac5@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4580:b719:7176:5f0b:7fa8:674c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4856;20:WL17kIlIU98f5xm181TkyMN0xzmbp4ARFoY8SxBEVCuF9lDn30eL7JH9rGz01Pzh/EeKb91jCfE+m7Z/PyrFwsU9IMits06911PHs7u1dxA+dgFy/CnEwyqLL6omO7GHPKOK3m9GpkK6dQfXD7PBvwFgzvWswPSLccAhrE5OJVM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 95975642-9ca8-4c5b-178a-08d657565049
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4856;
x-ms-traffictypediagnostic: BYAPR05MB4856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB485686D03AD149A64707FD91D0AC0@BYAPR05MB4856.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231454)(999002)(944501473)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4856;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4856;
x-forefront-prvs: 087396016C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(4326008)(53936002)(229853002)(8936002)(6512007)(102836004)(6246003)(53546011)(6916009)(6506007)(81166006)(71200400001)(68736007)(54906003)(93886005)(476003)(7416002)(7736002)(6116002)(486006)(316002)(2616005)(83716004)(305945005)(71190400001)(76176011)(82746002)(478600001)(2906002)(5660300001)(11346002)(97736004)(256004)(14444005)(46003)(6436002)(105586002)(36756003)(6486002)(86362001)(81156014)(25786009)(4001150100001)(446003)(99286004)(14454004)(33656002)(106356001)(8676002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4856;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4JGhgwPz+bsx4iaGZasjNTNe56Ua+C5htaTLmKT0jgbq0lSplBKdSetJBuqxZyV0Sb6vIwOqCG+t1dilnWrczkH8qWI6tl6uCooRj/j6MTHzzIPfANrMHRZWntmjFzmX7GDnB17TGE1uZF051UkNJHGaTi9llL08g8O2AufRWLcCgLZ6TuLiUuEJLgphBXLQH8UiPrTM+K27XXVBioRUW5BqxOa62TXs0Gv3YWtt5pvuffAUeBNycc3dJiYtGVkDwed8s2fiqYApX+4WK5HuhuOI065uPL1Z+bDMvHrXvbYST22MtMP+/d0MD5Lz8E1UM5PgSk478kXiChQRJldQsst/dhKrPOEj6Sdl8xDMcV8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D27358B48B5D45A3CA0F016071430B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95975642-9ca8-4c5b-178a-08d657565049
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 06:29:14.2683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjksIDIwMTgsIGF0IDg6NDMgQU0sIExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRl
bHRhdGVlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDIwMTgtMTEtMjggNjozMSBwLm0u
LCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+IE9uIE5vdiAyOCwgMjAxOCwgYXQgNDo0OSBQTSwgTG9n
YW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPiB3cm90ZToNCj4+PiANCj4+PiANCj4+
PiANCj4+PiBPbiAyMDE4LTExLTI4IDU6MzggcC5tLiwgTmFkYXYgQW1pdCB3cm90ZToNCj4+Pj4g
U28gd2hhdOKAmXMgeW91ciB0YWtlPyBXb3VsZCB5b3UgdGhpbmsgdGhpcyBwYXRjaCBpcyBzdGls
bCBuZWVkZWQ/IFNob3VsZCBpdA0KPj4+PiBvbmx5IGJlIGVuYWJsZWQgYXV0b21hdGljYWxseSBm
b3IgZGlzdGNjIGFuZCBub3QgZm9yIGRpc3RjYy1wdW1wPw0KPj4+IA0KPj4+IE5vdCBzdXJlLiBU
aGUgcGF0Y2ggd2lsbCBwcm9iYWJseSBzbG93IHRoaW5ncyBkb3duIGEgbG90IChzZWVpbmcNCj4+
PiBhc3NlbWJseSBpcyBhbHdheXMgZG9uZSBsb2NhbGx5IGFuZCB0aGVyZSBhcmUgdHdpY2UgYXMg
bWFueSBjb21waWxlDQo+Pj4gc3RlcHMpIGFuZCB3aWxsIGNyZWF0ZSBzb21lIGNvbmZ1c2lvbiBv
bmNlIGl0J3MgcG9zc2libGUgdG8gZGlzYWJsZSBpdA0KPj4+IGZvciB0aGUgbmV3IHZlcnNpb25z
LiBNYXliZSBob2xkIG9mZiBhbmQgc2VlIGlmIGFueW9uZSBlbHNlIGNvbXBsYWlucz8NCj4+PiAN
Cj4+PiBJIGRvbid0IHJlYWxseSBrbm93IGhvdyB5b3UnZCBkZXRlY3Qgd2hldGhlciBwdW1wIGlz
IGluIHVzZSBvciBub3QgYW5kDQo+Pj4gSSdtIHVuY2VydGFpbiBhcyB0byB3aGV0aGVyIGFueSBv
ZiB0aGUgYXV0byBkZXRlY3Rpb24gY2FuIGFjdHVhbGx5IGJlDQo+Pj4gbWFkZSB0byBiZSByZWxp
YWJsZS4NCj4+IA0KPj4gQSBzaWxseSBgJChDQykg4oCUdmVyc2lvbiB8IGdyZXAgcHVtcCBgIHRl
c3QuDQo+IA0KPiBBY3R1YWxseSBJJ20gbm90IHN1cmUgdGhhdCdzIGdvaW5nIHRvIHdvcmsgaW4g
YWxsIGNhc2VzLiBJZiBDQz0iZGlzdGNjDQo+IGdjYyIsIHRoZW4gIiQoQ0MpIC0tdmVyc2lvbiIg
anVzdCBsb29rcyBsaWtlICJnY2MgLS12ZXJzaW9uIi4uLg0KDQpFcnIuLiBZb3XigJlyZSByaWdo
dC4gSSBqdXN0IHRyaWVkIGRpc3RjYyAtLXZlcnNpb24uDQoNCg==
