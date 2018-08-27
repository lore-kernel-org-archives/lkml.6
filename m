Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC79C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4897208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="k82uxHSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4897208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeH0RQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:16:41 -0400
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:45408
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbeH0RQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hopJbRwHIVMEsn/xNN/ZsbfFtAv0PAGtewU6LJdz2zk=;
 b=k82uxHSBh1TaT9UwbMSistmx/9mnUN5W8JCWdbGa/s98+nzQdt5ITO6L34G0PRGA98pxCkfvt3w5lu9K9Rt6ETilcmf7zWzUrLRlxvAUyOnmeZcPJXBjdySXEsRyE/2ovoSzu1bO2jUjwgsgaeXevw0n2chZ84prIQcvRqggKOg=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0140.namprd21.prod.outlook.com (10.173.173.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Mon, 27 Aug 2018 13:29:58 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.000; Mon, 27 Aug 2018
 13:29:57 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "osalvador@techadventures.net" <osalvador@techadventures.net>
Subject: Re: [PATCH 1/2] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
Thread-Topic: [PATCH 1/2] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
Thread-Index: AQHUO4SJyfREGSGwLUKbn3BaQRBC46TTjL+AgAAQIwA=
Date:   Mon, 27 Aug 2018 13:29:57 +0000
Message-ID: <CAGM2reb99d07tD43oZQa0dyW_5QJH8HJgqVaVQOxbzJtm1ixng@mail.gmail.com>
References: <20180823182513.8801-1-msys.mizuma@gmail.com>
 <20180824000325.GA20143@hori1.linux.bs1.fc.nec.co.jp>
 <20180824082908.GC29735@dhcp22.suse.cz>
 <ffce827a-c12e-591a-715e-ae3a152b1954@gmail.com>
In-Reply-To: <ffce827a-c12e-591a-715e-ae3a152b1954@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0140;6:89DszDpd5rSESHUJV8mnao2UKIrE59bE5tAa+FQyTsZUD59d7aaCchZmK+Zz5SJ398XzkPNV1vOZaVP7b13s2I+sEHNuJ9/PKpOtuZGRw61QQCXJdJp0PBeOcbJwhsdspUfOK4fRUzv3NvZFq03lwZRDUe4nyj2eQ5QS7pA3d2haddtZX/BrJ1afoWahL3tSEmPgkk1I73LcbZsNQA3cvAkLojAmppcMgjJOqEHsNEqwbnZb3N1rmO4UPg49754uXHyioDLBySnXexpzoF98OJYaeq9Bh9222UBCzE7IOYL3jwz/+5zYjYEVOz3POVLQY0hRzCNXfIbUbjrk+F8oEoJADM9nPscV6VaDTCc9MGAuH01hWgnTGreZAIVrNMj+0cm2G2GySEnyLvTkUgvAWygD2/envpOwI0Icq1hdhFr7d8+LxQzkYXfciGVJbDHRXEYk49B+bxGmCVv4/4FaDg==;5:OFNIwTw6trB1J5hXWP9SU4UQKtfCREL29X85NLPX4Gt+JIrrqMyHW+XWyqGKFUB9rg9QGQL1CdU/tj2np/ael0DBWiKF8pPyBk5nvfP7zK6L4g0UJB4Ca/xatKJEQdfUV5yzWjLujgRFbvFM+sU/0Q8/KXgyoO/42SnOZa0/mDw=;7:E4j+JpGIA45wbqcjDmvlrpLlgmn8+UaBJf1e3OE9ZmdoQbDcwgoCYy8fkYkPdW81gBVO23ukdM+pp4w6bMZbUlX6ZMv7NeFd0M50gU9fJxMpw0zRB1BX9CyPHw6a3Dq0+aj+2bf2KyrTAxCUo3KFnl0dH6mo+sSFoC7JRjM0QiQR42U06MVQtDIVfGnqKMbhFI8OeQP7YxkyA3haXyuUnJ4WXAV01f01tdJdIzJ5UV5i4xIaVKV1/gaJItbxd6RX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 31ba0ddd-66bc-4a26-5001-08d60c212ee8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0140;
x-ms-traffictypediagnostic: DM5PR21MB0140:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB01401FA661EA7F44505280D19D0B0@DM5PR21MB0140.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(170618885588394)(268935105599563)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231336)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0140;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0140;
x-forefront-prvs: 07778E4001
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(501624003)(68736007)(446003)(6506007)(2351001)(53546011)(6246003)(33896004)(256004)(5660300001)(105586002)(39060400002)(55446002)(76176011)(25786009)(2501003)(54906003)(22452003)(93886005)(8936002)(106356001)(86612001)(1361003)(316002)(86362001)(575784001)(229853002)(305945005)(7736002)(2906002)(97736004)(10290500003)(5640700003)(186003)(345774005)(102836004)(61266001)(81166006)(476003)(81156014)(10090500001)(478600001)(66066001)(498394004)(61726006)(6486002)(5250100002)(6436002)(11346002)(2900100001)(6306002)(6512007)(9686003)(14454004)(99286004)(6916009)(4326008)(486006)(3846002)(8676002)(8990500004)(6116002)(53936002)(72206003)(966005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0140;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HEOZUgKkfmb3I2dr5ZGq4TMj5DvQOvYLUtLlGWEyFKn5ZYo3yXJ3pX2SmUFGkyBzgdf3ss+ltLhkaLIXJ8E1P96PdDXPobP5XRNuSxVExjlhdcTyvP/V3aW3BMv4XbR9sS+ANujh/vmSLVwNo7VNkGI54TfMj43FhlYGCvKZeGX7bZJVxyLobDYyRewHLEOzi4rnTzzBVLfi2obgknXkqrzdDAgAWv/TIK61L0zcBJmFJHYgAmw7eIlGnE8aPEFenFYMeFC2DqYWAilT94X3G7Xxnf4CjQ95ZC2LI8lKwpu2yAbSotIh6ErEyjo0FITrfym6axMhFZ9aL6DWeoyXE0VMY8OGSMez/6yhiTNfWV4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D45063A81F6C841AD62C194E04E54D4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ba0ddd-66bc-4a26-5001-08d60c212ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 13:29:57.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMjcsIDIwMTggYXQgODozMSBBTSBNYXNheW9zaGkgTWl6dW1hIDxtc3lzLm1p
enVtYUBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBIaSBQYXZlbCwNCj4NCj4gSSB3b3VsZCBhcHBy
ZWNpYXRlIGlmIHlvdSBjb3VsZCBzZW5kIHRoZSBmZWVkYmFjayBmb3IgdGhlIHBhdGNoLg0KDQpJ
IHdpbGwgc3R1ZHkgaXQgdG9kYXkuDQoNClBhdmVsDQoNCj4NCj4gVGhhbmtzIQ0KPiBNYXNhDQo+
DQo+IE9uIDA4LzI0LzIwMTggMDQ6MjkgQU0sIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gPiBPbiBG
cmkgMjQtMDgtMTggMDA6MDM6MjUsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPj4gKENDZWQg
cmVsYXRlZCBwZW9wbGUpDQo+ID4NCj4gPiBGaXh1cCBQYXZlbCBlbWFpbC4NCj4gPg0KPiA+Pg0K
PiA+PiBIaSBNaXp1bWEtc2FuLA0KPiA+Pg0KPiA+PiBUaGFuayB5b3UgZm9yIHRoZSByZXBvcnQu
DQo+ID4+IFRoZSBtZW50aW9uZWQgcGF0Y2ggd2FzIGNyZWF0ZWQgYmFzZWQgb24gZmVlZGJhY2tz
IGZyb20gcmV2aWV3ZXJzL21haW50YWluZXJzLA0KPiA+PiBzbyBJJ2QgbGlrZSB0byBoZWFyIGZy
b20gdGhlbSBhYm91dCBob3cgd2Ugc2hvdWxkIGhhbmRsZSB0aGUgaXNzdWUuDQo+ID4+DQo+ID4+
IEFuZCBvbmUgbm90ZSBpcyB0aGF0IHRoZXJlIGlzIGEgZm9sbG93LXVwIHBhdGNoIGZvciAieDg2
L2U4MjA6IHB1dCAhRTgyMF9UWVBFX1JBTQ0KPiA+PiByZWdpb25zIGludG8gbWVtYmxvY2sucmVz
ZXJ2ZWQiIHdoaWNoIG1pZ2h0IGJlIGFmZmVjdGVkIGJ5IHlvdXIgY2hhbmdlcy4NCj4gPj4NCj4g
Pj4+IGNvbW1pdCBlMTgxYWUwYzVkYjk1NDRkZTljNTMyMzllYjIyYmMwMTJjZTc1MDMzDQo+ID4+
PiBBdXRob3I6IFBhdmVsIFRhdGFzaGluIDxwYXNoYS50YXRhc2hpbkBvcmFjbGUuY29tPg0KPiA+
Pj4gRGF0ZTogICBTYXQgSnVsIDE0IDA5OjE1OjA3IDIwMTggLTA0MDANCj4gPj4+DQo+ID4+PiAg
ICAgbW06IHplcm8gdW5hdmFpbGFibGUgcGFnZXMgYmVmb3JlIG1lbW1hcCBpbml0DQo+ID4+DQo+
ID4+IFRoYW5rcywNCj4gPj4gTmFveWEgSG9yaWd1Y2hpDQo+ID4+DQo+ID4+IE9uIFRodSwgQXVn
IDIzLCAyMDE4IGF0IDAyOjI1OjEyUE0gLTA0MDAsIE1hc2F5b3NoaSBNaXp1bWEgd3JvdGU6DQo+
ID4+PiBGcm9tOiBNYXNheW9zaGkgTWl6dW1hIDxtLm1penVtYUBqcC5mdWppdHN1LmNvbT4NCj4g
Pj4+DQo+ID4+PiBjb21taXQgMTI0MDQ5ZGVjYmIxICgieDg2L2U4MjA6IHB1dCAhRTgyMF9UWVBF
X1JBTSByZWdpb25zIGludG8NCj4gPj4+IG1lbWJsb2NrLnJlc2VydmVkIikgYnJlYWtzIG1vdmFi
bGVfbm9kZSBrZXJuZWwgb3B0aW9uIGJlY2F1c2UgaXQNCj4gPj4+IGNoYW5nZWQgdGhlIG1lbW9y
eSBnYXAgcmFuZ2UgdG8gcmVzZXJ2ZWQgbWVtYmxvY2suIFNvLCB0aGUgbm9kZQ0KPiA+Pj4gaXMg
bWFya2VkIGFzIE5vcm1hbCB6b25lIGV2ZW4gaWYgdGhlIFNSQVQgaGFzIEhvdCBwbGFnZ2FibGUg
YWZmaW5pdHkuDQo+ID4+Pg0KPiA+Pj4gICAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+Pj4gICAgIGtlcm5l
bDogQklPUy1lODIwOiBbbWVtIDB4MDAwMDE4MDAwMDAwMDAwMC0weDAwMDAxODBmZmZmZmZmZmZd
IHVzYWJsZQ0KPiA+Pj4gICAgIGtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4MDAwMDFjMDAwMDAw
MDAwMC0weDAwMDAxYzBmZmZmZmZmZmZdIHVzYWJsZQ0KPiA+Pj4gICAgIC4uLg0KPiA+Pj4gICAg
IGtlcm5lbDogcmVzZXJ2ZWRbMHgxMl0jMDExWzB4MDAwMDE4MTAwMDAwMDAwMC0weDAwMDAxYmZm
ZmZmZmZmZmZdLCAweDAwMDAwM2YwMDAwMDAwMDAgYnl0ZXMgZmxhZ3M6IDB4MA0KPiA+Pj4gICAg
IC4uLg0KPiA+Pj4gICAgIGtlcm5lbDogQUNQSTogU1JBVDogTm9kZSAyIFBYTSA2IFttZW0gMHgx
ODAwMDAwMDAwMDAtMHgxYmZmZmZmZmZmZmZdIGhvdHBsdWcNCj4gPj4+ICAgICBrZXJuZWw6IEFD
UEk6IFNSQVQ6IE5vZGUgMyBQWE0gNyBbbWVtIDB4MWMwMDAwMDAwMDAwLTB4MWZmZmZmZmZmZmZm
XSBob3RwbHVnDQo+ID4+PiAgICAgLi4uDQo+ID4+PiAgICAga2VybmVsOiBNb3ZhYmxlIHpvbmUg
c3RhcnQgZm9yIGVhY2ggbm9kZQ0KPiA+Pj4gICAgIGtlcm5lbDogIE5vZGUgMzogMHgwMDAwMWMw
MDAwMDAwMDAwDQo+ID4+PiAgICAga2VybmVsOiBFYXJseSBtZW1vcnkgbm9kZSByYW5nZXMNCj4g
Pj4+ICAgICAuLi4NCj4gPj4+ICAgICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPj4+DQo+ID4+PiBOYW95YSdz
IHYxIHBhdGNoIFsqXSBmaXhlcyB0aGUgb3JpZ2luYWwgaXNzdWUgYW5kIHRoaXMgbW92YWJsZV9u
b2RlDQo+ID4+PiBpc3N1ZSBkb2Vzbid0IG9jY3VyLg0KPiA+Pj4gTGV0J3MgcmV2ZXJ0IGNvbW1p
dCAxMjQwNDlkZWNiYjEgKCJ4ODYvZTgyMDogcHV0ICFFODIwX1RZUEVfUkFNDQo+ID4+PiByZWdp
b25zIGludG8gbWVtYmxvY2sucmVzZXJ2ZWQiKSBhbmQgYXBwbHkgdGhlIHYxIHBhdGNoLg0KPiA+
Pj4NCj4gPj4+IFsqXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC82LzEzLzI3DQo+ID4+Pg0K
PiA+Pj4gU2lnbmVkLW9mZi1ieTogTWFzYXlvc2hpIE1penVtYSA8bS5taXp1bWFAanAuZnVqaXRz
dS5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBhcmNoL3g4Ni9rZXJuZWwvZTgyMC5jIHwgMTUgKysr
LS0tLS0tLS0tLS0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTIg
ZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9l
ODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZTgyMC5jDQo+ID4+PiBpbmRleCBjODhjMjNjNjU4YzEu
LmQxZjI1YzgzMTQ0NyAxMDA2NDQNCj4gPj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9lODIwLmMN
Cj4gPj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9lODIwLmMNCj4gPj4+IEBAIC0xMjQ4LDcgKzEy
NDgsNiBAQCB2b2lkIF9faW5pdCBlODIwX19tZW1ibG9ja19zZXR1cCh2b2lkKQ0KPiA+Pj4gIHsN
Cj4gPj4+ICAgICBpbnQgaTsNCj4gPj4+ICAgICB1NjQgZW5kOw0KPiA+Pj4gLSAgIHU2NCBhZGRy
ID0gMDsNCj4gPj4+DQo+ID4+PiAgICAgLyoNCj4gPj4+ICAgICAgKiBUaGUgYm9vdHN0cmFwIG1l
bWJsb2NrIHJlZ2lvbiBjb3VudCBtYXhpbXVtIGlzIDEyOCBlbnRyaWVzDQo+ID4+PiBAQCAtMTI2
NSwyMSArMTI2NCwxMyBAQCB2b2lkIF9faW5pdCBlODIwX19tZW1ibG9ja19zZXR1cCh2b2lkKQ0K
PiA+Pj4gICAgICAgICAgICAgc3RydWN0IGU4MjBfZW50cnkgKmVudHJ5ID0gJmU4MjBfdGFibGUt
PmVudHJpZXNbaV07DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgZW5kID0gZW50cnktPmFkZHIg
KyBlbnRyeS0+c2l6ZTsNCj4gPj4+IC0gICAgICAgICAgIGlmIChhZGRyIDwgZW50cnktPmFkZHIp
DQo+ID4+PiAtICAgICAgICAgICAgICAgICAgIG1lbWJsb2NrX3Jlc2VydmUoYWRkciwgZW50cnkt
PmFkZHIgLSBhZGRyKTsNCj4gPj4+IC0gICAgICAgICAgIGFkZHIgPSBlbmQ7DQo+ID4+PiAgICAg
ICAgICAgICBpZiAoZW5kICE9IChyZXNvdXJjZV9zaXplX3QpZW5kKQ0KPiA+Pj4gICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsNCj4gPj4+DQo+ID4+PiAtICAgICAgICAgICAvKg0KPiA+Pj4g
LSAgICAgICAgICAgICogYWxsICFFODIwX1RZUEVfUkFNIHJhbmdlcyAoaW5jbHVkaW5nIGdhcCBy
YW5nZXMpIGFyZSBwdXQNCj4gPj4+IC0gICAgICAgICAgICAqIGludG8gbWVtYmxvY2sucmVzZXJ2
ZWQgdG8gbWFrZSBzdXJlIHRoYXQgc3RydWN0IHBhZ2VzIGluDQo+ID4+PiAtICAgICAgICAgICAg
KiBzdWNoIHJlZ2lvbnMgYXJlIG5vdCBsZWZ0IHVuaW5pdGlhbGl6ZWQgYWZ0ZXIgYm9vdHVwLg0K
PiA+Pj4gLSAgICAgICAgICAgICovDQo+ID4+PiAgICAgICAgICAgICBpZiAoZW50cnktPnR5cGUg
IT0gRTgyMF9UWVBFX1JBTSAmJiBlbnRyeS0+dHlwZSAhPSBFODIwX1RZUEVfUkVTRVJWRURfS0VS
TikNCj4gPj4+IC0gICAgICAgICAgICAgICAgICAgbWVtYmxvY2tfcmVzZXJ2ZShlbnRyeS0+YWRk
ciwgZW50cnktPnNpemUpOw0KPiA+Pj4gLSAgICAgICAgICAgZWxzZQ0KPiA+Pj4gLSAgICAgICAg
ICAgICAgICAgICBtZW1ibG9ja19hZGQoZW50cnktPmFkZHIsIGVudHJ5LT5zaXplKTsNCj4gPj4+
ICsgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4+PiArDQo+ID4+PiArICAgICAgICAg
ICBtZW1ibG9ja19hZGQoZW50cnktPmFkZHIsIGVudHJ5LT5zaXplKTsNCj4gPj4+ICAgICB9DQo+
ID4+Pg0KPiA+Pj4gICAgIC8qIFRocm93IGF3YXkgcGFydGlhbCBwYWdlczogKi8NCj4gPj4+IC0t
DQo+ID4+PiAyLjE4LjANCj4gPj4+DQo+ID4+Pg0KPiA+DQo+
