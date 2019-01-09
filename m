Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C37C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CC9206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="be5tC8OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfAIWTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:19:16 -0500
Received: from mail-eopbgr680137.outbound.protection.outlook.com ([40.107.68.137]:6237
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbfAIWTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myOWLZbXxOVLA3Dunx5uSriDayr6ijVhKB3IC3SqdNM=;
 b=be5tC8OKdJCD6beEFZZTq0brEVGikQPqN6xQLCLcEsQ1O0CZxmQDMK+shoUEF36f6uyCEPgAMqXOvkg+vYovVB8uYhrG6hnYCQj/21O91DlQOTAXfZuFPoml38dOfbD3aLE2BRtoa2ytHwk2ak9uqLk9XPUlJnZWy6AIdh1LBjE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1502.namprd22.prod.outlook.com (10.174.170.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 9 Jan 2019 22:19:11 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 22:19:10 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: jazz: fix 64bit build
Thread-Topic: [PATCH] MIPS: jazz: fix 64bit build
Thread-Index: AQHUqD5++LFBAOtTk0SZGPmR1Odhz6WngjGA
Date:   Wed, 9 Jan 2019 22:19:10 +0000
Message-ID: <MWHPR2201MB12778DE3A9F87659C04DEF91C18B0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190109171216.19992-1-tbogendoerfer@suse.de>
In-Reply-To: <20190109171216.19992-1-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1502;6:Rgs8rXrytjc/YVH+iKAJsDVh51X/qaS2rWp5wXrJXfoivFRiKbcW+zUyBOCkk92ewHLfDzILw/wybIO2a9MirpugAIXQpevWSS8pIvK1IiG9FMl1qPMPOUNyde556uJQ0cS7f/A/o6GojlfwZO9hGB0a4Nlg+ttnX2fL9L1cTV24KKVRGWC5mxXX3PZuIuskBXBUa5QBPk+6nKHI8GQNiZrwu5wEM4TaQUQmhFgo8O5M6TY1fqHH6bvuLjcZ7TTthrQaE0lSEUggdwFtwRXMyahz5JRNViDk/2PgKD9dLrIBNXK+jzs0qm8TwwOYVQsS4XmIjyCxTGsEG1wfAM+gPTOTI7HAXB3TnusuEiHRde1MdoPk33FwOnjX2uQBk3mQ6xYCiiwrBESAXdj5Tv/MGYxwN7ue+zFTvRMV8oSyViL8Cg3sVIwzOalv8BJHQP3S7Uy3ZC+1ZQeL8zClxZYw1g==;5:sBK3uEVQ0xCjVVvM84+w5xV9ASJtK5rmtTuU8lPFhGX9nXnV3gfIkvj+MSWDW570zZ7YVsBzMbqwLepHz2xFM3yRJthDeSNP+Lb8DZVlCyffvK9+8OrUGGI1b/Ii7eOAcYsqfLs3niT3HbpZOHdTFGmr1OO2e2LA0MKAa69gkrvoYaUXKSDLRbbvfI9SLiUOgyawPwWDMefL6z9+m74MTA==;7:wlRzZIPX7smz1WJrkstPZWYpj/QOwwQhZd9SrXCryuHlt3U2DqJr4h1moAHgJW1PsnaBn1vT33hLsfVC16S8uYU+0AWnlQ53ScWp6xtfkJypCjZoFFD1OjdXNAIYhKGyYz1vYMzva6xgX+LxFbdQtQ==
x-ms-office365-filtering-correlation-id: 19bae477-5967-40cb-4bc1-08d676807a98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1502;
x-ms-traffictypediagnostic: MWHPR2201MB1502:
x-microsoft-antispam-prvs: <MWHPR2201MB15023F00D7AEF9339A538F71C18B0@MWHPR2201MB1502.namprd22.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39840400004)(199004)(189003)(476003)(446003)(305945005)(74316002)(71190400001)(71200400001)(8936002)(102836004)(97736004)(7696005)(5660300001)(76176011)(6506007)(386003)(26005)(186003)(8676002)(53936002)(81156014)(6116002)(11346002)(33656002)(7736002)(9686003)(42882007)(52116002)(68736007)(25786009)(6436002)(6916009)(4326008)(6246003)(81166006)(3846002)(66066001)(256004)(316002)(229853002)(14454004)(54906003)(44832011)(105586002)(2906002)(478600001)(55016002)(486006)(99286004)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1502;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4aD6CtTcp5NulYEyRbZYoEq4BdJmlrXLkltn5bewaA28PJRZn1g1TbVuW43Z7wxwDqV0Aol6twYKDQtkD7i8zuMWQ+QKeVCITXupQyMWueJwb45zSNKx+Q1QxOAKlI0peaLwnY8kWf6K1CusNN+WZYvkgXm9p0OcLE/RvxMCShVgdoaGeTgLQq/xeXjkGTfFwr3ilHPIJGJg5CT0lWjdUHRwOcWHbnnSpB96ays6EUhEhNoFNJDblBBG50rkG6mNDRNUO6Hvn0onsEuaQIrBz4mvoJXj87OSpN9zkE/HNVs8sHvv+lKZZfXWyD8rkGxC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bae477-5967-40cb-4bc1-08d676807a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 22:19:10.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClRob21hcyBCb2dlbmRvZXJmZXIgd3JvdGU6DQo+IDY0Yml0IEpBWlogYnVpbGRz
IGZhaWxlZCB3aXRoDQo+IA0KPiBsaW51eC1uZXh0L2FyY2gvbWlwcy9qYXp6L2phenpkbWEuYzog
SW4gZnVuY3Rpb24gw6LCgMKYdmRtYV9pbml0w6LCgMKZOg0KPiAvbGludXgtbmV4dC9hcmNoL21p
cHMvamF6ei9qYXp6ZG1hLmM6Nzc6MzA6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBm
dW5jdGlvbiDDosKAwphLU0VHMUFERFLDosKAwpk7IGRpZCB5b3UgbWVhbiDDosKAwphDS1NFRzFB
RERSw6LCgMKZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gcGd0
YmwgPSAoVkRNQV9QR1RCTF9FTlRSWSAqKUtTRUcxQUREUihwZ3RibCk7DQo+IF5+fn5+fn5+fg0K
PiBDS1NFRzFBRERSDQo+IC9saW51eC1uZXh0L2FyY2gvbWlwcy9qYXp6L2phenpkbWEuYzo3Nzox
MDogZXJyb3I6IGNhc3QgdG8gcG9pbnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUg
Wy1XZXJyb3I9aW50LXRvLXBvaW50ZXItY2FzdF0NCj4gcGd0YmwgPSAoVkRNQV9QR1RCTF9FTlRS
WSAqKUtTRUcxQUREUihwZ3RibCk7DQo+IF4NCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC9saW51
eC1uZXh0L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9iYXJyaWVyLmg6MTE6MCwNCj4gZnJvbSAvbGlu
dXgtbmV4dC9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmg6MjQ4LA0KPiBmcm9tIC9saW51eC1uZXh0
L2luY2x1ZGUvbGludXgva2VybmVsLmg6MTAsDQo+IGZyb20gL2xpbnV4LW5leHQvYXJjaC9taXBz
L2phenovamF6emRtYS5jOjExOg0KPiAvbGludXgtbmV4dC9hcmNoL21pcHMvaW5jbHVkZS9hc20v
YWRkcnNwYWNlLmg6NDE6Mjk6IGVycm9yOiBjYXN0IGZyb20gcG9pbnRlciB0byBpbnRlZ2VyIG9m
IGRpZmZlcmVudCBzaXplIFstV2Vycm9yPXBvaW50ZXItdG8taW50LWNhc3RdDQo+ICNkZWZpbmUg
X0FDQVNUMzJfICAoX0FUWVBFXykoX0FUWVBFMzJfKSAvKiB3aWRlbiBpZiBuZWNlc3NhcnkgKi8N
Cj4gXg0KPiAvbGludXgtbmV4dC9hcmNoL21pcHMvaW5jbHVkZS9hc20vYWRkcnNwYWNlLmg6NTM6
MjU6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDDosKAwphfQUNBU1QzMl/DosKAwpkNCj4g
I2RlZmluZSBDUEhZU0FERFIoYSkgICgoX0FDQVNUMzJfKGEpKSAmIDB4MWZmZmZmZmYpDQo+IF5+
fn5+fn5+fg0KPiAvbGludXgtbmV4dC9hcmNoL21pcHMvamF6ei9qYXp6ZG1hLmM6ODQ6NDQ6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDDosKAwphDUEhZU0FERFLDosKAwpkNCj4gcjQwMzBf
d3JpdGVfcmVnMzIoSkFaWl9SNDAzMF9UUlNUQkxfQkFTRSwgQ1BIWVNBRERSKHBndGJsKSk7DQo+
IA0KPiBVc2luZyBjb3JyZWN0IGNhc3RzIGFuZCBDS1NFRzFBRERSIHdoZW4gZGVhbGluZyB3aXRo
IHRoZSBwZ3RibCBzZXR1cA0KPiBmaXhlcyB0aGlzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGhv
bWFzIEJvZ2VuZG9lcmZlciA8dGJvZ2VuZG9lcmZlckBzdXNlLmRlPg0KDQpBcHBsaWVkIHRvIG1p
cHMtZml4ZXMuDQoNClRoYW5rcywNCiAgICBQYXVsDQoNClsgVGhpcyBtZXNzYWdlIHdhcyBhdXRv
LWdlbmVyYXRlZDsgaWYgeW91IGJlbGlldmUgYW55dGhpbmcgaXMgaW5jb3JyZWN0DQogIHRoZW4g
cGxlYXNlIGVtYWlsIHBhdWwuYnVydG9uQG1pcHMuY29tIHRvIHJlcG9ydCBpdC4gXQ0K
