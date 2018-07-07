Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2976C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D4C217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D4C217FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbeGGOeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:34:09 -0400
Received: from mail-oln040092064066.outbound.protection.outlook.com ([40.92.64.66]:44590
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752825AbeGGOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:34:08 -0400
Received: from VE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
 (10.152.2.52) by VE1EUR01HT057.eop-EUR01.prod.protection.outlook.com
 (10.152.3.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.906.15; Sat, 7
 Jul 2018 14:34:05 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.2.58) by
 VE1EUR01FT051.mail.protection.outlook.com (10.152.3.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.930.16 via Frontend Transport; Sat, 7 Jul 2018 14:34:05 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::b1fe:1b4f:88c3:5243%7]) with mapi id 15.20.0952.008; Sat, 7 Jul 2018
 14:34:05 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] Fix range checks in kernfs_get_target_path
Thread-Topic: [PATCHv2] Fix range checks in kernfs_get_target_path
Thread-Index: AQHUFdaeLDbdtFgySEW5kU1JCySiEqSDymAAgAAJDYA=
Date:   Sat, 7 Jul 2018 14:34:05 +0000
Message-ID: <AM5PR0701MB26574A2BB2B9180684A91CD7E4460@AM5PR0701MB2657.eurprd07.prod.outlook.com>
References: <AM5PR0701MB265728DBCC26198F64EEC027E4460@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <20180707140140.GA4941@kroah.com>
In-Reply-To: <20180707140140.GA4941@kroah.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0034.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::47) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:76B6AE4E645056582D5BCFA3EF9C504EE99242EFE4DFCE15CF2667A5F8FBC4E5;UpperCasedChecksum:612D45B1000AACB5576FEBF75F4FC4884CB742C9759DA9AC680ABEDB2713D696;SizeAsReceived:7632;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+EwWp/CgGbqbZEjyqwPxQ9gs0oC2Wa0b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR01HT057;7:im6iOd1CUsN5UGnq8jIe8LpU9eQYaGVR8hIJCHwxxvurJTW568Fyw5iEHHCWdi01phCoLGwsca9ENaKi8vcx6ZOWdEssFgJHaqT0gWLNevYw9PBTvzFF6qY1hIhuCo4Mn0qGsqHOUdMFclKQgq5n3BFMxQOo8UHS2p81Eu2pwT7NNvaYVyzX6EFVoz0DZMrBKpcJ7cAvgQCDaAZ0XfRl7IgSw5DrdV2Yg66SZOsYDMaBH+tK2jE2plSgv/ur4wW5
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101448)(1701031045);SRVR:VE1EUR01HT057;
x-ms-traffictypediagnostic: VE1EUR01HT057:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(82015058);SRVR:VE1EUR01HT057;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR01HT057;
x-forefront-prvs: 0726B2D7A6
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(97736004)(55016002)(25786009)(14454004)(76176011)(7696005)(74482002)(4326008)(102836004)(14444005)(9686003)(5250100002)(386003)(2900100001)(256004)(6346003)(6506007)(53546011)(26005)(73972006)(82202002)(86362001)(75402003)(106356001)(105586002)(8936002)(6436002)(229853002)(476003)(446003)(486006)(68736007)(104016004)(81156014)(99286004)(8676002)(44832011)(6246003)(33656002)(74316002)(6916009)(54906003)(5660300001)(11346002)(305945005);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR01HT057;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: vRt+f6mQNnVJ9QULdDurYJe/dOM4wW6LWRiI5LlOENucwbyCGYvIxoFOnXFRUihZZjFeYlXA8p2DDWl9krkSj+NeEzWUn+eSIiChVbOA9oZtU+gDW0ZSX7kvOmqv3BFO7pFFbnJa1I55+DVtfoqxzM/zChP5I82ZjDjI7X5j0svT+DgT5vH1VeBW35Wq3Tj+MU2sPkPNNCLdqiyvvPP6DjeMV6voJWPYidUX6bdGLG8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CD4C1250914CC4CAF109BBC4B19D95D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: f326a944-f326-4303-c15b-08d5e416b0c0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2018 14:34:05.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDcvMTggMTY6MDEsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gU2F0LCBK
dWwgMDcsIDIwMTggYXQgMDk6NDE6MDNBTSArMDAwMCwgQmVybmQgRWRsaW5nZXIgd3JvdGU6DQo+
PiBUaGUgc3RybmNweSBjYXVzZXMgYSB3YXJuaW5nIFstV3N0cmluZ29wLXRydW5jYXRpb25dIGhl
cmUsDQo+PiB3aGljaCBpbmRpY2F0ZXMgdGhhdCBpdCBuZXZlciBhcHBlbmRzIGEgTlVMIGJ5dGUg
dG8gdGhlIHBhdGguDQo+PiBUaGUgTlVMIGJ5dGUgaXMgb25seSB0aGVyZSBiZWNhdXNlIHRoZSBi
dWZmZXIgaXMgYWxsb2NhdGVkDQo+PiB3aXRoIGt6YWxsb2MoUEFHRV9TSVpFLCBHRlBfS0VSTkVM
KSwgYnV0IHNpbmNlIHRoZSByYW5nZS1jaGVjaw0KPj4gaXMgYWxzbyBvZmYtYnktb25lLCBhbmQg
UEFHRV9TSVpFPT1QQVRIX01BWCB0aGUgcmV0dXJuZWQgc3RyaW5nDQo+PiB3aWxsIG5vdCBiZSB6
ZXJvLXRlcm1pbmF0ZWQgaWYgaXQgaXMgZXhhY3RseSBQQVRIX01BWCBjaGFyYWN0ZXJzLg0KPj4g
RnVydGhlcm1vcmUgYWxzbyB0aGUgaW5pdGlhbCBsb29wIG1heSB0aGVvcmV0aWNhbGx5IGV4Y2Vl
ZCBQQVRIX01BWA0KPj4gYW5kIGNhdXNlIGEgZmF1bHQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
QmVybmQgRWRsaW5nZXIgPGJlcm5kLmVkbGluZ2VyQGhvdG1haWwuZGU+DQo+PiAtLS0NCj4+ICAg
IGZzL2tlcm5mcy9zeW1saW5rLmMgfCAxMCArKysrKysrLS0tDQo+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9m
cy9rZXJuZnMvc3ltbGluay5jIGIvZnMva2VybmZzL3N5bWxpbmsuYw0KPj4gaW5kZXggMDhjY2Fi
ZC4uYzhiN2Q0NGEgMTAwNjQ0DQo+PiAtLS0gYS9mcy9rZXJuZnMvc3ltbGluay5jDQo+PiArKysg
Yi9mcy9rZXJuZnMvc3ltbGluay5jDQo+PiBAQCAtNjMsNyArNjMsMTAgQEAgc3RhdGljIGludCBr
ZXJuZnNfZ2V0X3RhcmdldF9wYXRoKHN0cnVjdCBrZXJuZnNfbm9kZQ0KPj4gICAgCQlpZiAoYmFz
ZSA9PSBrbikNCj4+ICAgIAkJCWJyZWFrOw0KPj4NCj4+IC0JCXN0cmNweShzLCAiLi4vIik7DQo+
PiArCQlpZiAoKHMgLSBwYXRoKSArIDMgPj0gUEFUSF9NQVgpDQo+PiArCQkJcmV0dXJuIC1FTkFN
RVRPT0xPTkc7DQo+PiArDQo+PiArCQltZW1jcHkocywgIi4uLyIsIDMpOw0KPj4gICAgCQlzICs9
IDM7DQo+PiAgICAJCWJhc2UgPSBiYXNlLT5wYXJlbnQ7DQo+PiAgICAJfQ0KPj4gQEAgLTc5LDE2
ICs4MiwxNyBAQCBzdGF0aWMgaW50IGtlcm5mc19nZXRfdGFyZ2V0X3BhdGgoc3RydWN0IGtlcm5m
c19ub2RlDQo+PiAgICAJaWYgKGxlbiA8IDIpDQo+PiAgICAJCXJldHVybiAtRUlOVkFMOw0KPj4g
ICAgCWxlbi0tOw0KPj4gLQlpZiAoKHMgLSBwYXRoKSArIGxlbiA+IFBBVEhfTUFYKQ0KPj4gKwlp
ZiAoKHMgLSBwYXRoKSArIGxlbiA+PSBQQVRIX01BWCkNCj4+ICAgIAkJcmV0dXJuIC1FTkFNRVRP
T0xPTkc7DQo+Pg0KPj4gICAgCS8qIHJldmVyc2UgZmlsbHVwIG9mIHRhcmdldCBzdHJpbmcgZnJv
bSB0YXJnZXQgdG8gYmFzZSAqLw0KPj4gICAgCWtuID0gdGFyZ2V0Ow0KPj4gKwlzW2xlbl0gPSAn
XDAnOw0KPj4gICAgCXdoaWxlIChrbi0+cGFyZW50ICYmIGtuICE9IGJhc2UpIHsNCj4+ICAgIAkJ
aW50IHNsZW4gPSBzdHJsZW4oa24tPm5hbWUpOw0KPj4NCj4+ICAgIAkJbGVuIC09IHNsZW47DQo+
PiAtCQlzdHJuY3B5KHMgKyBsZW4sIGtuLT5uYW1lLCBzbGVuKTsNCj4+ICsJCW1lbWNweShzICsg
bGVuLCBrbi0+bmFtZSwgc2xlbik7DQo+PiAgICAJCWlmIChsZW4pDQo+PiAgICAJCQlzWy0tbGVu
XSA9ICcvJzsNCj4+DQo+IA0KPiBUaGlzIGxhc3QgbWVtY3B5IHJlcGxhY2VtZW50IGhhcyBhbHJl
YWR5IGJlZW4gYXBwbGllZCB0byBteSB0cmVlLCBmcm9tIGENCj4gcGF0Y2ggZnJvbSBzb2VvbmUg
ZWxzZSwgc28gYXJlIHlvdSBzdXJlIGFsbCBvZiB0aGUgb3RoZXIgY2hhbmdlcyBhcmUNCj4gYWxz
byByZWFsbHkgbmVlZGVkPyAgV2h5IHRoZSBleHRyYSBcMCB0ZXJtaW5hdGlvbiBvZiBhIHN0cmlu
ZyB0aGF0IGlzDQo+IGFscmVhZHkgdGVybWluYXRlZD8NCj4gDQoNCkkgZGlkIG9ubHkgYSBjb2Rl
IHJldmlldywgYnV0IHRoZSByYW5nZSBjaGVja3MgbG9vayByZWFsbHkgZGFuZ2Vyb3VzbHkNCndy
b25nLg0KDQpUaGUgc3RyaW5nIGlzIG9ubHkgemVyby10ZXJtaW5hdGVkIGJlY2F1c2UgaXQgaXMg
YWxsb2NhdGVkIGluDQprZXJuZnNfaW9wX2dldF9saW5rIHdpdGggYm9keSA9IGt6YWxsb2MoUEFH
RV9TSVpFLCBHRlBfS0VSTkVMKTsNCg0KSSB3b3VsZCByZWNvbW1lbmQgdG8gZXhwbGljaXRseSBw
bGFjZSBhIHRlcm1pbmF0aW9uIGluIHRoZQ0KYnVmZmVyLCBhbmQgbm90IHJlbHkgb24gdGhlIHdh
eSBob3cgdGhlIGJ1ZmZlciBpcyBhbGxvY2F0ZWQuDQoNCj4gQW5kIHdoeSBpcyB0aGUgZmlyc3Qg
bWVtY3B5IHJlcGxhY2VtZW50IG5lZWRlZD8gIGdjYyBkb2Vzbid0IHNheQ0KPiBhbnl0aGluZyBh
Ym91dCB0aGF0LCBkb2VzIGl0Pw0KPiANCg0KTm8sIHRoYXQgaXMgbW9yZSBvciBsZXNzIGZvciBl
ZmZpY2llbmN5IHJlYXNvbnMsIHNpbmNlIGl0IGlzIHdyaXRpbmcNCnRoZSBOVUwgd2hpY2ggaXMg
YWx3YXlzIG92ZXJ3cml0dGVuIHdpdGggc29tZXRoaW5nIGRpZmZlcmVudCBpbiB0aGUNCm5leHQg
c3RlcC4gIElmIHRoZSBsb29wIGlzIGV4ZWN1dGVkIHplcm8gdGltZXMsIHRoZXJlIHJlc3VsdCBp
cyBub3QNCmV4cGxpY2l0bHkgemVyby10ZXJtaW5hdGVkIGVpdGhlciwgc28gdXNpbmcgc3RyY3B5
IGlzIHNvbWVob3cgbWlzbGVhZGluZy4NCg0KV2VsbCwgSSB3b3VsZCBzYXkgcGVyc29uYWwgdGFz
dGUsIGlmIHRoZSBsb29wIGJlbG93IGNvbnN0cnVjdHMNCnRoZSBzdHJpbmcgd2l0aCBtZW1jcHkg
dGhlIGxvb3AgYWJvdmUgY2FuIGRvIHRoZSBzYW1lLg0KDQpJZiB5b3UgcHJlZmVyIHRoZSBzdHJj
cHkgaW4gdGhlIGZpcnN0IGxvb3AsIEkgaGF2ZSBubyBzdHJvbmcNCnByZWZlcmVuY2UgaGVyZS4N
Cg0KDQpUaGFua3MNCkJlcm5kLg0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo+IA0K
