Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9222C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 03:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F25F2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 03:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="FLhC/gNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbeLPD2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 22:28:36 -0500
Received: from mail-eopbgr740041.outbound.protection.outlook.com ([40.107.74.41]:46000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727395AbeLPD2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 22:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCZVRbgf2aN00eg7HBMkgJy+0a4Fy5DmHFyr8+qI6ug=;
 b=FLhC/gNnXWyMGotxJ58i/N+BblfVMRgIJz/AfxTbaFmCnm10oZN1A0uFjufk8k7ZJ0/mo4NMWRyisXJmvU6ovSSIJjuH2J+h7Tj+kmGwxOF4pL0EU6qbUx9TN1BaNbkIjxEDkNosOORWME5LwDnn0KslBKsrfs4zOBCcNI5e3W8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6518.namprd05.prod.outlook.com (20.178.233.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.8; Sun, 16 Dec 2018 03:28:24 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.015; Sun, 16 Dec 2018
 03:28:24 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v2] x86, kbuild: revert macrofying inline assembly code
Thread-Topic: [PATCH v2] x86, kbuild: revert macrofying inline assembly code
Thread-Index: AQHUlOp05k9eNePZgU2IHaI01WI0G6WAtPUA
Date:   Sun, 16 Dec 2018 03:28:23 +0000
Message-ID: <9691ECB6-D659-4E88-B8AF-4947B9431AF1@vmware.com>
References: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:f187:d2b3:613e:fe7c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6518;20:U7p0mtcYOOASdoylvvPEV9QLe8324YMvGbaySTwteVgP2PaFXec7yB+yvzowrzxg9R6+q+NVKHaOhpO9dO/VEuxhzwZzit+OtJlZVgT+FkqpPjmAclkubsGhys4e3gPUn9AYwW4TiMQKAxM5hST1AjRmgUllPKM4CQ+/pTMyQz8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 88351970-88b4-41da-7d5b-08d66306891a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6518;
x-ms-traffictypediagnostic: BYAPR05MB6518:
x-microsoft-antispam-prvs: <BYAPR05MB651851B1E7E1BBE478935E5DD0A30@BYAPR05MB6518.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB6518;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB6518;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(82746002)(8936002)(316002)(86362001)(575784001)(54906003)(7416002)(76176011)(8676002)(305945005)(7736002)(186003)(102836004)(6506007)(5660300001)(6916009)(99286004)(33656002)(81156014)(81166006)(53546011)(2906002)(105586002)(106356001)(966005)(14454004)(45080400002)(25786009)(478600001)(6306002)(6512007)(4326008)(36756003)(6116002)(39060400002)(6246003)(53936002)(97736004)(83716004)(71200400001)(2616005)(71190400001)(68736007)(476003)(46003)(446003)(229853002)(11346002)(6436002)(486006)(6486002)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6518;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WKd/+DXkxRYNV4hTSJ3CnNM5XNeTxHcdyPbu+t9VUX7NCwMrHGdfGRbpvCdPUI1YNyiF/7JzyJS0m+x1BIMIlRPwYdkbAoE+DvmDB7vKZKGlbkFQfnqWHemJvDOwIP3p0EJhEgqabXhVzC4N55LM7C2O9BACjkPxqGo0p4Ki8AX/77kAPKDsPgpjbOwzb19f50jHnvdkgVRfjmlp1RPPq+7rkvlszdylS01hpB/RtjUqAF/JFZoWWnzd0GTvvcC7KMJWnLkKrsuemYG71zefIlUnju9DgUBCLMi1HL6PmPNxXcfAYw/kNRJCmtSwF6C2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AA835CDA2BF8D448F7B19D2F3BC68B7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88351970-88b4-41da-7d5b-08d66306891a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 03:28:23.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTUsIDIwMTgsIGF0IDY6NTAgUE0sIE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1h
c2FoaXJvQHNvY2lvbmV4dC5jb20+IHdyb3RlOg0KPiANCj4gUmV2ZXJ0IHRoZSBmb2xsb3dpbmcg
OSBjb21taXRzOg0KPiANCj4gWzFdIDViZGNkNTEwYzJhYyAoIng4Ni9qdW1wLWxhYmVsczogTWFj
cm9meSBpbmxpbmUgYXNzZW1ibHkgY29kZSB0bw0KPiAgICB3b3JrIGFyb3VuZCBHQ0MgaW5saW5p
bmcgYnVncyIpDQo+IA0KPiAgICBUaGlzIHdhcyBwYXJ0aWFsbHkgcmV2ZXJ0ZWQgYmVjYXVzZSBp
dCBtYWRlIGdvb2QgY2xlYW51cHMNCj4gICAgaXJyZXNwZWN0aXZlIG9mIHRoZSBpbmxpbmluZyBp
c3N1ZTsgdGhlIGVycm9yIG1lc3NhZ2UgaXMgc3RpbGwNCj4gICAgdW5uZWVkZWQsIGFuZCB0aGUg
Y29udmVyc2lvbiB0byBTVEFUSUNfQlJBTkNIX3tOT1AsSlVNUH0gc2hvdWxkDQo+ICAgIGJlIGtl
cHQuDQo+IA0KPiBbMl0gZDVhNTgxZDg0YWU2ICgieDg2L2NwdWZlYXR1cmU6IE1hY3JvZnkgaW5s
aW5lIGFzc2VtYmx5IGNvZGUgdG8NCj4gICAgd29yayBhcm91bmQgR0NDIGlubGluaW5nIGJ1Z3Mi
KQ0KPiANCj4gWzNdIDA0NzRkNWQ5ZDJmNyAoIng4Ni9leHRhYmxlOiBNYWNyb2Z5IGlubGluZSBh
c3NlbWJseSBjb2RlIHRvIHdvcmsNCj4gICAgYXJvdW5kIEdDQyBpbmxpbmluZyBidWdzIikNCj4g
DQo+IFs0XSA0OTRiNTE2OGYyZGUgKCJ4ODYvcGFyYXZpcnQ6IFdvcmsgYXJvdW5kIEdDQyBpbmxp
bmluZyBidWdzIHdoZW4NCj4gICAgY29tcGlsaW5nIHBhcmF2aXJ0IG9wcyIpDQo+IA0KPiBbNV0g
ZjgxZjhhZDU2ZmQxICgieDg2L2J1ZzogTWFjcm9meSB0aGUgQlVHIHRhYmxlIHNlY3Rpb24gaGFu
ZGxpbmcsDQo+ICAgIHRvIHdvcmsgYXJvdW5kIEdDQyBpbmxpbmluZyBidWdzIikNCj4gDQo+IFs2
XSA3N2Y0OGVjMjhlNGMgKCJ4ODYvYWx0ZXJuYXRpdmVzOiBNYWNyb2Z5IGxvY2sgcHJlZml4ZXMg
dG8gd29yaw0KPiAgIGFyb3VuZCBHQ0MgaW5saW5pbmcgYnVncyIpDQo+IA0KPiBbN10gOWUxNzI1
YjQxMDU5ICgieDg2L3JlZmNvdW50OiBXb3JrIGFyb3VuZCBHQ0MgaW5saW5pbmcgYnVnIikNCj4g
DQo+ICAgIFJlc29sdmVkIGNvbmZsaWN0cyBpbiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9yZWZjb3Vu
dC5oIGNhdXNlZCBieQ0KPiAgICAyODhlNDUyMWYwZjYgKCJ4ODYvYXNtOiAnU2ltcGxpZnknIEdF
Tl8qX1JNV2NjKCkgbWFjcm9zIikuDQo+IA0KPiBbOF0gYzA2YzRkODA5MDUxICgieDg2L29ianRv
b2w6IFVzZSBhc20gbWFjcm9zIHRvIHdvcmsgYXJvdW5kIEdDQw0KPiAgICBpbmxpbmluZyBidWdz
IikNCj4gDQo+IFs5XSA3N2IwYmY1NWJjNjcgKCJrYnVpbGQvTWFrZWZpbGU6IFByZXBhcmUgZm9y
IHVzaW5nIG1hY3JvcyBpbiBpbmxpbmUNCj4gICAgYXNzZW1ibHkgY29kZSB0byB3b3JrIGFyb3Vu
ZCBhc20oKSByZWxhdGVkIEdDQyBpbmxpbmluZyBidWdzIikNCj4gDQo+IEEgZmV3IGRheXMgYWZ0
ZXIgdGhvc2UgY29tbWl0cyBhcHBsaWVkLCBkaXNjdXNzaW9uIHN0YXJ0ZWQgdG8gc29sdmUNCj4g
dGhlIGlzc3VlIG1vcmUgZWxlZ2FudGx5IHdpdGggdGhlIGhlbHAgb2YgY29tcGlsZXI6DQo+IA0K
PiAgaHR0cHM6Ly9uYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsa21sLm9yZyUyRmxrbWwlMkYyMDE4JTJGMTAlMkY3JTJGOTImYW1wO2RhdGE9
MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2U4OTNjZTg4MDY1ZTRjNTkyMzYzMDhkNjYz
MDE5NDI0JTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MwJTdDMCU3QzYzNjgw
NTI1NTc4NzYwNzE3OCZhbXA7c2RhdGE9bWlpVW5kbVBmR05LdnJ6RDVtdHRDMSUyQm42ck5hb0lG
ZWJqWk9Ba0JyMjRZJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBUaGUgbmV3IHN5bnRheCAiYXNt
IGlubGluZSIgd2FzIGltcGxlbWVudGVkIGJ5IFNlZ2hlciBCb2Vzc2Vua29vbCwgYW5kDQo+IG5v
dyBxdWV1ZWQgdXAgZm9yIEdDQyA5LiAoUGVvcGxlIHdlcmUgcG9zaXRpdmUgZXZlbiBmb3IgYmFj
ay1wb3J0aW5nIGl0DQo+IHRvIG9sZGVyIGNvbXBpbGVycykuDQo+IA0KPiBTaW5jZSB0aGUgaW4t
a2VybmVsIHdvcmthcm91bmRzIG1lcmdlZCwgc29tZSBpc3N1ZXMgaGF2ZSBiZWVuIHJlcG9ydGVk
Og0KPiBicmVha2FnZSBvZiBidWlsZGluZyB3aXRoIGRpc3RjYy9pY2VjYywgYnJlYWthZ2Ugb2Yg
ZGlzdHJvIHBhY2thZ2VzIGZvcg0KPiBtb2R1bGUgYnVpbGRpbmcuIChNb3JlIGZ1bmRhbWVudGFs
bHksIHdlIGNhbm5vdCBidWlsZCBleHRlcm5hbCBtb2R1bGVzDQo+IGFmdGVyICdtYWtlIGNsZWFu
Jy4pDQo+IA0KPiBJIGRvIG5vdCB3YW50IHRvIG1lc3MgdXAgdGhlIGJ1aWxkIHN5c3RlbSBhbnkg
bW9yZS4NCj4gDQo+IEdpdmVuIHRoYXQgdGhpcyBpc3N1ZSB3aWxsIGJlIHNvbHZlZCBpbiBhIGNs
ZWFuZXIgd2F5IHNvb25lciBvciBsYXRlciwNCj4gbGV0J3MgcmV2ZXJ0IHRoZSBpbi1rZXJuZWwg
d29ya2Fyb3VuZHMsIGFuZCB3YWl0IGZvciBHQ0MgOS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBMb2dh
biBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+ICMgZGlzdGNjDQo+IFJlcG9ydGVkLWJ5
OiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPiAjIGRlYi9ycG0gcGFja2FnZQ0K
DQpJdCBpcyBjdXN0b21hcnkgdG8gY2MgdGhvc2Ugd2hvIHJlcG9ydCBhbiBpc3N1ZS4NCg0KVGhl
IGRpc3RjYyBpc3N1ZSBoYXMgYWxyZWFkeSBiZWVuIHJlc29sdmVkIGJvdGggaW4gZGlzdGNjIGFu
ZCBpbiB0aGUgcGF0Y2hlcw0KSeKAmXZlIHNlbnQ6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4
LzExLzE1LzQ2NyAuIFNvIEkgY2Fubm90IHVuZGVyc3RhbmQgd2h5DQppdCBpcyBtZW50aW9uZWQg
YXMgYSBtb3RpdmF0aW9uLg0KDQpJdCBzb3VuZHMgdGhhdCB0aGUgZXh0ZXJuYWwgbW9kdWxlcyBj
YW4gZWFzaWx5IGJlIHJlc29sdmVkLiBDYW4geW91IHBsZWFzZQ0KcHJvdmlkZSBhIGxpbmsgZm9y
IHRoZSBidWcgcmVwb3J0Pw0KDQpQbGVhc2UgcmVnYXJkIG15IGNvbW1lbnRzIHJlZ2FyZGluZyB2
MS4gSSBtdXN0IGFkbWl0IHRoYXQgSeKAmW0gdmVyeSBzdXJwcmlzZWQNCnRoYXQgeW91IGRvbuKA
mXQgbGlrZSB0aGUgcGF0Y2hlcyBzaW5jZSB5b3UgYWNr4oCZZCB0aGUgb3JpZ2luYWwgcGF0Y2gt
c2V0IChhbmQNCmFjdHVhbGx5IGFzc2lzdGVkIG1lIGluIGNoYW5naW5nIHRoZSBNYWtlZmlsZSku
DQoNCg==
