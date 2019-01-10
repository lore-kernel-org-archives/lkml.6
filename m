Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACCEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE5E21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="r3uYT6OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAJBVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:21:07 -0500
Received: from mail-eopbgr710072.outbound.protection.outlook.com ([40.107.71.72]:42015
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbfAJBVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mJyK8eBrJK03OBZWSoC6o52J7Ti4d2hjZi49MHv0CE=;
 b=r3uYT6OAKrBYezllEbj6c8lzzaGEUcfdzSOxGO/1eUAANY/eKasVinUBN+vilGqCPo5T+TfDD2l9qny7IM6J2a7l3KttywaX4s9ISCORvyiyFNyYFiXf/wlzoJDrjkRO3LHXhl5ierySCJu5CoNSVrb4lV6oMQXxZjU2/hdsk5E=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5175.namprd05.prod.outlook.com (20.177.231.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.7; Thu, 10 Jan 2019 01:21:00 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.010; Thu, 10 Jan 2019
 01:21:00 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWntJ6A
Date:   Thu, 10 Jan 2019 01:21:00 +0000
Message-ID: <A42784EF-3215-4ED9-8D35-1A2C38A0711F@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5175;20:u9cunR7L4MG+d788pKOAjkxnvlHM2TExOIOOvdg//Kd5S97+OLPg0v39k4sb1O+PN+ztFCZx7LIz6ByNzv8gj1p+RmfdNoBL2YDBDRnErUu+aZEEjOygL+AqdBkIPAdai+urMI4rBzWj7haQKlazPm794u+LmwkB3Oejzm5U+UA=
x-ms-office365-filtering-correlation-id: 11cb87d8-2732-4fbb-c638-08d67699e16a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5175;
x-ms-traffictypediagnostic: BYAPR05MB5175:
x-microsoft-antispam-prvs: <BYAPR05MB5175C4E77CBB905685F760FFD0840@BYAPR05MB5175.namprd05.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(136003)(189003)(199004)(106356001)(53936002)(33656002)(6246003)(105586002)(6506007)(25786009)(53546011)(186003)(66066001)(6486002)(5660300001)(6436002)(82746002)(8676002)(102836004)(7416002)(81166006)(81156014)(567974002)(3846002)(6116002)(26005)(229853002)(6306002)(8936002)(6512007)(6916009)(4326008)(76176011)(561944003)(97736004)(305945005)(966005)(7736002)(486006)(476003)(99286004)(316002)(446003)(11346002)(54906003)(2616005)(68736007)(2906002)(86362001)(256004)(14444005)(71200400001)(83716004)(36756003)(71190400001)(14454004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5175;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: axSookZeC5n6ALDmuUoE7zP/IwgH4Mp3Ok+82ESrA7HD9FKwbTHg8qmVWF1esmtSQaKnfGnBeRzZrJkub94ysz7Ksf2nxBRI1eqExzBmk5KvzQ6tvhkf1r/+VandQ/2bbNDWTWQCh1N6jOoCfhhchmPN6VYAVut03oRlYBG5uMjChFhBqvq+UWm0Y2ldjD+Wnd5yuIwMUKlQelcFPxYfdrV9SkFqPjj4wwnS6G0KCy5G3/COo4vJv0tWoVKVQdCF08uzwB8NR5imiAu69w8edwI47v/DCautS4SfdYuShS3BhcfVddIGSO3/YFckFcfo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <44E4563FC24FBB4DBA5547C6B8932D78@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cb87d8-2732-4fbb-c638-08d67699e16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 01:21:00.2198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gOSwgMjAxOSwgYXQgMjo1OSBQTSwgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJl
ZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gV2l0aCB0aGlzIHZlcnNpb24sIEkgc3RvcHBlZCB0cnlp
bmcgdG8gdXNlIHRleHRfcG9rZV9icCgpLCBhbmQgaW5zdGVhZA0KPiB3ZW50IHdpdGggYSBkaWZm
ZXJlbnQgYXBwcm9hY2g6IGlmIHRoZSBjYWxsIHNpdGUgZGVzdGluYXRpb24gZG9lc24ndA0KPiBj
cm9zcyBhIGNhY2hlbGluZSBib3VuZGFyeSwganVzdCBkbyBhbiBhdG9taWMgd3JpdGUuICBPdGhl
cndpc2UsIGtlZXANCj4gdXNpbmcgdGhlIHRyYW1wb2xpbmUgaW5kZWZpbml0ZWx5Lg0KPiANCj4g
Tk9URTogQXQgbGVhc3QgZXhwZXJpbWVudGFsbHksIHRoZSBjYWxsIGRlc3RpbmF0aW9uIHdyaXRl
cyBzZWVtIHRvIGJlDQo+IGF0b21pYyB3aXRoIHJlc3BlY3QgdG8gaW5zdHJ1Y3Rpb24gZmV0Y2hp
bmcuICBPbiBOZWhhbGVtIEkgY2FuIGVhc2lseQ0KPiB0cmlnZ2VyIGNyYXNoZXMgd2hlbiB3cml0
aW5nIGEgY2FsbCBkZXN0aW5hdGlvbiBhY3Jvc3MgY2FjaGVsaW5lcyB3aGlsZQ0KPiByZWFkaW5n
IHRoZSBpbnN0cnVjdGlvbiBvbiBvdGhlciBDUFU7IGJ1dCBJIGdldCBubyBzdWNoIGNyYXNoZXMg
d2hlbg0KPiByZXNwZWN0aW5nIGNhY2hlbGluZSBib3VuZGFyaWVzLg0KPiANCj4gQlVULCB0aGUg
U0RNIGRvZXNuJ3QgZG9jdW1lbnQgdGhpcyBhcHByb2FjaCwgc28gaXQgd291bGQgYmUgZ3JlYXQg
aWYgYW55DQo+IENQVSBwZW9wbGUgY2FuIGNvbmZpcm0gdGhhdCBpdCdzIHNhZmUhDQo+IA0KDQpJ
IChzdGlsbCkgdGhpbmsgdGhhdCBoYXZpbmcgYSBjb21waWxlciBwbHVnaW4gY2FuIG1ha2UgdGhp
bmdzIG11Y2ggY2xlYW5lcg0KKGFzIGRvbmUgaW4gWzFdKS4gVGhlIGNhbGxlcnMgd291bGQgbm90
IG5lZWQgdG8gYmUgY2hhbmdlZCwgYW5kIHRoZSBrZXkgY2FuDQpiZSBwcm92aWRlZCB0aHJvdWdo
IGFuIGF0dHJpYnV0ZS4NCg0KVXNpbmcgYSBwbHVnaW4gc2hvdWxkIGFsc28gYWxsb3cgdG8gdXNl
IFN0ZXZlbuKAmXMgcHJvcG9zYWwgZm9yIGRvaW5nDQp0ZXh0X3Bva2UoKSBzYWZlbHk6IGJ5IGNo
YW5naW5nICdmdW5jKCknIGludG8gJ2FzbSAo4oCcY2FsbCBmdW5j4oCdKScsIGFzIGRvbmUNCmJ5
IHRoZSBwbHVnaW4sIHlvdSBjYW4gYmUgZ3VhcmFudGVlZCB0aGF0IHJlZ2lzdGVycyBhcmUgY2xv
YmJlcmVkLiBUaGVuLCB5b3UNCmNhbiBzdG9yZSBpbiB0aGUgYXNzZW1ibHkgYmxvY2sgdGhlIHJl
dHVybiBhZGRyZXNzIGluIG9uZSBvZiB0aGVzZQ0KcmVnaXN0ZXJzLg0KDQpbMV0gaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMTgvMTIvMzEvMjUNCg0KDQoNCg0K
