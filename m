Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lteGpbLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6615B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeH2VJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:09:49 -0400
Received: from mail-eopbgr690084.outbound.protection.outlook.com ([40.107.69.84]:26016
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728481AbeH2VJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58Waath/26/N/seQvsRSg2Y43milbvQzX1m5DAdPjEI=;
 b=lteGpbLcA0J5XN8vn5/Q/rlGbh0F+IHEJxVX4wV3rXHbdlAaGqN/SjvFsTRH2iQzKGglY+emer8dmBUJIFIiHG8F0nHgUgATdMjzrCKeh+UEqe6x9jhWAtff/rxdsUisuKSWgmDRplQ+v2MaP9WCHMvEV+xiPxtxyLHVLHvfGtg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4278.namprd05.prod.outlook.com (52.135.202.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.11; Wed, 29 Aug 2018 17:11:53 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 17:11:53 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Topic: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Index: AQHUP3AveUOJQxVhiEqJKH9IYmSgsaTWblgAgACJiIA=
Date:   Wed, 29 Aug 2018 17:11:53 +0000
Message-ID: <1F547CEE-B5D9-42A0-8093-2C5555BACE26@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-2-namit@vmware.com>
 <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
In-Reply-To: <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4278;20:MnntJe7aCefZf2SntgYW2zKkcgNhurBTb14OKhV1JSDf9LK94jRgBHHXG72qM3eloLWiO/1NNMNoK5lyiASpchZJ2vn1kzznXZcAzU4HDH+OJZ9vFhCzuh+98ShtkbITbDyVXlNozb9mkFNUB645ZGDpaHEe//Qyb0MDG36bSIk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6df721bc-0cc5-4d27-70c3-08d60dd2846b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4278;
x-ms-traffictypediagnostic: BYAPR05MB4278:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB42785816787376E9637D8AE9D0090@BYAPR05MB4278.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR05MB4278;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4278;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(99286004)(217873002)(14444005)(8936002)(81166006)(83716003)(305945005)(7736002)(81156014)(6506007)(82746002)(316002)(446003)(54906003)(6486002)(106356001)(6436002)(53936002)(256004)(2906002)(68736007)(36756003)(8676002)(102836004)(11346002)(476003)(486006)(2616005)(6246003)(2900100001)(97736004)(478600001)(105586002)(86362001)(5660300001)(14454004)(76176011)(33656002)(186003)(5250100002)(4326008)(26005)(6916009)(6116002)(3846002)(66066001)(25786009)(229853002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4278;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1rsdarG+iNy7DvTq2CKeZ6/7fF8zbA0z7B19sNYtLmpDxghmVlignxT2ZjG2XgXRY4BMiy7pH/rccybTQF/zCdkfd6tWciJe+7zU6TNbpJvWJAc07OabuOLH/Xbs/09x7GtkDYFeWuc4y/X/E8HYku0tZhrvBeO2uTGJR2990fiAiI077kWZ7+Q7hYUeupIcMTjpxZn4/xoIoQwFHOb0ahPdGYpi16jLzfbIa+j9VsafstdHECkuVHh3zrNvPGykvSu6FbzAONZ3Z6MR05I97P5JCH9AbhE2JqE+w2kmANA2vvJmquhbYxqJ1kp9NxHCEs1I8m6OMK/PpXkiP1RT5hn/4hL6E9bqzFShH6UrW/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B964218AB06114B91FD319FEB7F8020@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df721bc-0cc5-4d27-70c3-08d60dd2846b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 17:11:53.3087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTo1OSBBTSwgTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4gd3JvdGU6
DQoNCj4gT24gV2VkLCAyOSBBdWcgMjAxOCAwMToxMTo0MiAtMDcwMA0KPiBOYWRhdiBBbWl0IDxu
YW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+PiBVc2UgbG9ja2RlcCB0byBlbnN1cmUgdGhh
dCB0ZXh0X211dGV4IGlzIHRha2VuIHdoZW4gdGV4dF9wb2tlKCkgaXMNCj4+IGNhbGxlZC4NCj4+
IA0KPj4gQWN0dWFsbHkgaXQgaXMgbm90IGFsd2F5cyB0YWtlbiwgc3BlY2lmaWNhbGx5IHdoZW4g
aXQgaXMgY2FsbGVkIGJ5IGtnZGIsDQo+PiBzbyB0YWtlIHRoZSBsb2NrIGluIHRoZXNlIGNhc2Vz
Lg0KPiANCj4gQ2FuIHdlIHJlYWxseSB0YWtlIGEgbXV0ZXggaW4ga2dkYiBjb250ZXh0Pw0KPiAN
Cj4ga2dkYl9hcmNoX3JlbW92ZV9icmVha3BvaW50DQo+ICA8LSBkYmdfZGVhY3RpdmF0ZV9zd19i
cmVha3BvaW50cw0KPiAgICA8LSBrZ2RiX3JlZW50ZXJfY2hlY2sNCj4gICAgICAgPC0ga2dkYl9o
YW5kbGVfZXhjZXB0aW9uDQo+ICAgICAgICAgIDwtIF9fa2dkYl9ub3RpZnkNCj4gICAgICAgICAg
ICA8LSBrZ2RiX2xsX3RyYXANCj4gICAgICAgICAgICAgIDwtIGRvX2ludDMNCj4gICAgICAgICAg
ICA8LSBrZ2RiX25vdGlmeQ0KPiAgICAgICAgICAgICAgPC0gZGllIG5vdGlmaWVyDQo+IA0KPiBr
Z2RiX2FyY2hfc2V0X2JyZWFrcG9pbnQNCj4gIDwtIGRiZ19hY3RpdmF0ZV9zd19icmVha3BvaW50
cw0KPiAgICA8LSBrZ2RiX3JlZW50ZXJfY2hlY2sNCj4gICAgICAgPC0ga2dkYl9oYW5kbGVfZXhj
ZXB0aW9uDQo+ICAgICAgICAgICAuLi4NCj4gDQo+IEJvdGggc2VlbXMgY2FsbGVkIGluIGV4Y2Vw
dGlvbiBjb250ZXh0LCBzbyB3ZSBjYW4gbm90IHRha2UgYSBtdXRleCBsb2NrLg0KPiBJIHRoaW5r
IGtnZGIgbmVlZHMgYSBzcGVjaWFsIHBhdGguDQoNCllvdSBhcmUgY29ycmVjdCwgYnV0IEkgZG9u
4oCZdCB3YW50IGEgc3BlY2lhbCBwYXRoLiBQcmVzdW1hYmx5IHRleHRfbXV0ZXggaXMNCmd1YXJh
bnRlZWQgbm90IHRvIGJlIHRha2VuIGFjY29yZGluZyB0byB0aGUgY29kZS4NCg0KU28gSSBndWVz
cyB0aGUgb25seSBjb25jZXJuIGlzIGxvY2tkZXAuIERvIHlvdSBzZWUgYW55IHByb2JsZW0gaWYg
SSBjaGFuZ2UNCm11dGV4X2xvY2soKSBpbnRvIG11dGV4X3RyeWxvY2soKT8gSXQgc2hvdWxkIGFs
d2F5cyBzdWNjZWVkLCBhbmQgSSBjYW4gYWRkIGENCndhcm5pbmcgYW5kIGEgZmFpbHVyZSBwYXRo
IGlmIGl0IGZhaWxzIGZvciBzb21lIHJlYXNvbi4NCg0K
