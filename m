Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782D22082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="gJh09dTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782D22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeLDOuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:50:52 -0500
Received: from mail-eopbgr130102.outbound.protection.outlook.com ([40.107.13.102]:11263
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbeLDOuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94tTJXd5eic+YLGSjGlmdq7eGcaEsSKFXX6ozZCRfUY=;
 b=gJh09dTFK+NJ/c8TwWQY3g0058tIRZgWybvy2Wv8cDdiFs/YyxFXnbXI5HnzGF7exEQJtLWUOXLclCiloz4xdITtgCgx/uk5vRPvOVtbgJf27p5XQDlnNfh5aaAqPreoXxoZRDhswd8BEn4HooOvgRYU6IKK7CO14Zbwg/V8NqE=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB3949.eurprd02.prod.outlook.com (20.177.58.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 14:50:44 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1361.022; Tue, 4 Dec 2018
 14:50:44 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Nicholas Mc Guire <der.herr@hofr.at>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Topic: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Thread-Index: AQHUiV04FT84eXxBo0+Q2gJyFszP86VutIoA///2FQCAAAQagA==
Date:   Tue, 4 Dec 2018 14:50:44 +0000
Message-ID: <a2f22968-3c3c-893e-873e-c7d85b32d212@axentia.se>
References: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
 <37b8709c-0b58-7bc9-22c5-e01953593d06@axentia.se>
 <20181204143600.GB16001@osadl.at>
In-Reply-To: <20181204143600.GB16001@osadl.at>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0246.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::22) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB3949;6:OD6ZrctEckyBaWnFr4DY77NgDvh17u9TpilddxUbQ9YD49FmnJ8oDbMuNhnIeSKX4Ra70DgAhYSbUWsQ4tOGldoYwLZgykcy9TlXD0w3Zy3H8dOvfDRsg1+P6xVMHVHBwB8aX1VTi8CMm4TJ7L5HkusawfLaQyAExPEg1+FTSazT1s70oUcMQDcFYk9zdViLH3UAIIHMu/44NspzI5SxC4oIM4M52j7BLnPMfjYo2JYPn6OYRRBTk0+Va55zZkOdXdkxR3pAy0eAL/RiDuhWJJwL8KGJuOQcEv5ti5a1LtWnnNTdk0O9lKKO91CGHXVy/5FMq+pS9r39TUuIu4b1jNyoch3LD1CsQ4mHrnOdZwQhdw4t4w/3EjCYBZuBERd0qfzgveC3XoO49PjplLLxJaewrgCvZzNKizispjHFFUpJc1vvb+lOaiuUqrZPAff7+VMY+3UUkj4kjlNbvSN9YQ==;5:TYjn+RQ3uT0qzjAWFcp/JAVkJkrsOCgrZqwcMYm/annkotOuyAOJNdPp6j4aSGuwEtZ3uf44cQUnjVtzGc03GPsAMuwxipRrSHaQiO6aVmM8LhRabp16kJ+bnG457Jix2DHavaImR6K/kL8cUXCgqeQAw8LuART57vzqgWLDl6M=;7:YPgZS2S6oegi1F9DD/gClCrWOqejxWfN7DATw8gu3E9wXH0EchwGZlCBJjL+56pwd6Al2Qf8zgGbrsNXvVDkkmgibS50VdxRyZzEpY9o5gbhnuHZVQWAY/2Aqc4Ob+xA1R9z2fC8Z0SXj8O54f5VmQ==
x-ms-office365-filtering-correlation-id: 84d0fca6-25ab-4371-ded7-08d659f7de25
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3949;
x-ms-traffictypediagnostic: VI1PR02MB3949:
x-microsoft-antispam-prvs: <VI1PR02MB394973EFD9102154FC076EEEBCAF0@VI1PR02MB3949.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB3949;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB3949;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(305945005)(229853002)(86362001)(31696002)(97736004)(102836004)(4326008)(6512007)(7736002)(6486002)(6246003)(476003)(508600001)(8676002)(25786009)(486006)(2616005)(386003)(14454004)(6506007)(53546011)(36756003)(81166006)(53936002)(31686004)(6916009)(2906002)(64126003)(8936002)(66066001)(68736007)(446003)(105586002)(65806001)(65956001)(11346002)(106356001)(58126008)(186003)(54906003)(65826007)(81156014)(52116002)(76176011)(74482002)(14444005)(71200400001)(71190400001)(316002)(6116002)(99286004)(256004)(5660300001)(3846002)(26005)(6436002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3949;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +OIrtB08PkmjS6VF9X7VHPABQvz2PAAb/M808kOyudRRen84pIfnuYxvV2jCPfeYc3vvx+lQd1di8/DgNKziv7JfRIwX3uPCe+uVDQ4XgfwLCvM6w8HENHcS4AP6OjBb3BWoVmOyip4Vkb2gvTAP5Lol0S57plzAIOjpyfB1iM7UJejLCyvbBlgeLEYcGPbOnrekwy/VOTOoGh15y0y5CDV8rJqLenZo9FR8eIGN3brjbxy7zg3UHQ0MN02Q0Y14fvcs408WBkMrEfxMAV9/CAlDn2b/DOEq9cORu6tJSGc78SyLaA2+bgOYYiraITQA/UozPq/nXUt+KbTspurFX76FoWafb3bRrbtpp52WdBY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <20F39D6B4A3AD54986C1E07271B1398F@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d0fca6-25ab-4371-ded7-08d659f7de25
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 14:50:44.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0wNCAxNTozNiwgTmljaG9sYXMgTWMgR3VpcmUgd3JvdGU6DQo+IE9uIFR1ZSwg
RGVjIDA0LCAyMDE4IGF0IDAyOjExOjMzUE0gKzAwMDAsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4g
SG8gaG1tLiBIYWQgYW5vdGhlciBsb29rIGF0IHRoaXMgcGF0Y2gsIG9yIHJhdGhlciwgdGhlIGNv
bnRleHQgb2YgdGhlDQo+PiBwYXRjaCBzbyBub3QgcmVhbGx5IHJlbGF0ZWQsIGJ1dC4uLg0KPj4N
Cj4+IE9uIDIwMTgtMTItMDEgMTE6MDEsIE5pY2hvbGFzIE1jIEd1aXJlIHdyb3RlOg0KPj4+IGRl
dm1fa3N0cmR1cCgpIG1heSByZXR1cm4gTlVMTCBpZiBpbnRlcm5hbCBhbGxvY2F0aW9uIGZhaWxl
ZC4NCj4+PiBUaHVzIHVzaW5nICBuYW1lLCB2YWx1ZSAgaXMgdW5zYWZlIHdpdGhvdXQgYmVpbmcg
Y2hlY2tlZC4gQXMNCj4+PiBpMmNfZGVtdXhfcGluY3RybF9wcm9iZSgpIGNhbiByZXR1cm4gLUVO
T01FTSBpbiBvdGhlciBjYXNlcw0KPj4+IGEgZGV2X2VycigpIG1lc3NhZ2UgaXMgaW5jbHVkZWQg
dG8gbWFrZSB0aGUgZmFpbHVyZSBsb2NhdGlvbg0KPj4+IGNsZWFyLg0KPj4+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogTmljaG9sYXMgTWMgR3VpcmUgPGhvZnJhdEBvc2FkbC5vcmc+DQo+Pj4gRml4ZXM6
IGUzNTQ3OGVhYzAzMCAoImkyYzogbXV4OiBkZW11eC1waW5jdHJsOiBydW4gcHJvcGVybHkgd2l0
aCBtdWx0aXBsZSBpbnN0YW5jZXMiKQ0KPj4+IC0tLQ0KPj4+DQo+Pj4gUHJvYmxlbSBsb2NhdGVk
IHdpdGggZXhwZXJpbWVudGFsIGNvY2NpbmVsbGUgc2NyaXB0DQo+Pj4NCj4+PiBROiBUaGUgdXNl
IG9mIGRldm1fa3N0cmR1cCgpIHNlZW1zIGEgYml0IG9kZCB3aGlsZSB0ZWNobmljYWxseSBub3Qg
d3JvbmcsDQo+Pj4gICAgcGVyc29uYWxseSBJIHRoaW5rIGRldm1fa2FzcHJpbnRmKCkgd291bGQg
YmUgbW9yZSBzdWl0YWJsZSBoZXJlLg0KPj4+DQo+Pj4gUGF0Y2ggd2FzIGNvbXBpbGUgdGVzdGVk
IHdpdGg6IG11bHRpX3Y3X2RlZmNvbmZpZyANCj4+PiAoaW1wbGllcyBJMkNfREVNVVhfUElOQ1RS
TD15KQ0KPj4+DQo+Pj4gUGF0Y2ggaXMgYWdhaW5zdCA0LjIwLXJjNCAobG9jYWx2ZXJzaW9uLW5l
eHQgaXMgbmV4dC0yMDE4MTEzMCkNCj4+Pg0KPj4+ICBkcml2ZXJzL2kyYy9tdXhlcy9pMmMtZGVt
dXgtcGluY3RybC5jIHwgNiArKysrKysNCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL211eGVzL2kyYy1kZW11eC1w
aW5jdHJsLmMgYi9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtZGVtdXgtcGluY3RybC5jDQo+Pj4gaW5k
ZXggMDM1MDMyZS4uYzQ2Njk5OSAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2kyYy9tdXhlcy9p
MmMtZGVtdXgtcGluY3RybC5jDQo+Pj4gKysrIGIvZHJpdmVycy9pMmMvbXV4ZXMvaTJjLWRlbXV4
LXBpbmN0cmwuYw0KPj4+IEBAIC0yNDQsNiArMjQ0LDEyIEBAIHN0YXRpYyBpbnQgaTJjX2RlbXV4
X3BpbmN0cmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+PiAgDQo+Pj4g
IAkJcHJvcHNbaV0ubmFtZSA9IGRldm1fa3N0cmR1cCgmcGRldi0+ZGV2LCAic3RhdHVzIiwgR0ZQ
X0tFUk5FTCk7DQo+Pj4gIAkJcHJvcHNbaV0udmFsdWUgPSBkZXZtX2tzdHJkdXAoJnBkZXYtPmRl
diwgIm9rIiwgR0ZQX0tFUk5FTCk7DQo+Pg0KPj4gSXQgc2VlbWVkIHZlcnkgZHViaW91cyB0byB1
c2UgZGV2bV9rc3RyZHVwIGhlcmUsIHNpbmNlDQo+Pg0KPiANCj4geXVwIC0gd2hpY2ggaXMgd2hl
cmUgdGhlIHF1ZXN0aW9uIGluIHRoZSBpbml0aWFsIHBhY2ggY2FtZQ0KPiBmcm9tIEkgZmVsdCB0
aGF0IHRoaXMgc2hvdWxkIGJldHRlciBiZSBhIGRldm1fa2FzcHJpbnQoKSAtIEkNCj4gZGlkIG5v
dCB1bmRlcnN0YW5kIHdoeSBpdCB3YXMga3N0cmR1cCBoZXJlIGluIHRoZSBmaXJzdA0KPiBwbGFj
ZSAtIHRlY2huaWNhbGx5IGl0IGlzIG5vdCB3cm9uZyB0aG91Z2ggYXMgdGhlIHNvdXJjZSBpcyBu
b3QgUk8NCj4gc28gaXQgd2lsbCBhbGxvY2F0ZSBhbmQgY29weSB0aGUgb3JpZ2luYWwgc3RyaW5n
IGFuZCB0aHVzDQo+IGVmZmVjdGl2ZWx5IGl0IGJlaGF2ZXMgbGlrZSBkZXZtX2thc3ByaW50Zg0K
DQpkZXZtX2thc3ByaW50ZiB3b3VsZCBiZSBhcyBiYWQgYXMgZGV2bV9rc3RyZHVwIGhlcmUgKGlm
IEkgcmVhZCB0aGUgY29kZQ0KcmlnaHQpLiBCb3RoIGFsbG9jYXRlcyBtZW1vcnkgdGhhdCBpcyBm
cmVlZCBib3RoIGJ5IHRoZSBkZXZtXy4uLiBtYWNoaW5lcnkNCmFuZCBieSB0aGUgY29uc3VtZXIu
IE1heWJlIEkgc2hvdWxkIGhhdmUgc2FpZCAicHJvcHMgY29uc3VtZXIiIGluc3RlYWQgb2YNCmp1
c3QgImNvbnN1bWVyIiB0byBtYWtlIGl0IGNsZWFyIHRoYXQgSSdtIHRhbGtpbmcgYWJvdXQgdGhl
IGR5bmFtaWMgb2YNCmNvZGUgYXMgY29uc3VtZXIuDQoNCj4gIA0KPj4gMS4gaWYgdGhlIGNvbnN1
bWVyIGlzIG5vdCBmcmVlaW5nIHRoZSBzdHJpbmdzIGl0IHdvdWxkIGJlIHN1ZmZpY2llbnQgd2l0
aCBqdXN0DQo+PiAgIAkJcHJvcHNbaV0ubmFtZSA9ICJzdGF0dXMiOw0KPj4gICAJCXByb3BzW2ld
LnZhbHVlID0gIm9rIjsNCj4+DQo+PiAyLiBpZiB0aGUgY29uc3VtZXIgaXMgZnJlZWluZyB0aGUg
c3RyaW5ncywgaXQgaXMgdmVyeSBiYWQgdG8gZnJlZSB0aGVtIHR3aWNlDQo+PiAgICB3aGljaCBp
cyB3aGF0IGhhcHBlbnMgd2l0aCB0aGUgZGV2bV8gcHJlZml4Lg0KPiANCj4gV2h5IHdvdWxkIGl0
IGJlIGZyZWVkIHR3aWNlID8gdGhlIHBvaW50ZXIgcmV0dXJuZWQgaXMgYSBzZXBlcmF0ZWx5IGFs
bG9jYXRlZCBvYmplY3RzID8NCj4gdGhhdCBuZWVkcyB0byBiZSBpbmRlcGRlbnRseSBmcmVlZCAo
dGhpcyBpcyBub3QgdGhlIGRldm1fa3N0cmR1cF9jb25zdCgpIGNhc2UpDQoNClRoZSBwcm9wc1tp
XSBzdHJ1Y3QgaXMgc2VudCBvZmYgdG8gdGhlICJjb25zdW1lciIgd2l0aCB0aGUgY2FsbCB0bw0K
b2ZfY2hhbmdlc2V0X3VwZGF0ZV9wcm9wZXJ0eS4gQWZ0ZXIgdGhhdCAoaWYgSSByZWFkIGl0IHJp
Z2h0KSB0aGUNCmNoYW5nZXNldCBvd25zIHRoZSBwcm9wIGFuZCB3aWxsIGZyZWUgaXQsIGFuZCBp
dHMgY29udGVudCwgYXMgaXQgaXMNCmNsZWFuZWQgdXAuIEl0IGlzIHRoZXJlZm9yZSB3cm9uZyBm
b3IgdGhpcyBkcml2ZXIgdG8gYWxzbyBjbGVhbiB1cA0KdGhhdCBtZW1vcnkgKGJ5IHVzaW5nIGRl
dm1fIHByZWZpeGVkIGZ1bmN0aW9ucyBmb3IgdGhlc2UgdHdvDQplbnRpdGllcykuDQoNCj4+DQo+
PiBTbywgdGhlcmUgaXMgbm8gY2FzZSwgQUZBSUNULCB3aGVyZSBpdCBpcyBzYW5lIHRvIHVzZSBk
ZXZtX2tzdHJkdXAuDQo+IA0KPiBJIHRoaW5rIHRoZSBvbmx5IHRlY2huaWNhbCBkaWZmZXJlbmNl
IGJldHdlZW4gZGV2bV9rc3RyZHVwIGFuZCBkZXZtX2thc3ByaW50Zg0KPiBpcyBlZmZlY3RpdmVs
eSBhIG1lbWNweSB2cyB2c25wcmludGYgLSBzbyBoZXJlIEkgdGhpbmsgZGV2bV9rYXNwcmludGYg
d291bGQNCj4gYWxzbyBiZSB0aGUgbW9yZSBzdWl0YWJsZSBjYWxsIHRvIHVzZS4NCg0KVGhhdCBk
aWZmZXJlbmNlIGlzIG5vdCB2ZXJ5IGltcG9ydGFudCwgYnV0IHN0cmR1cCBzaG91bGQgYWx3YXlz
IGJlIGZhc3Rlcg0KdGhhbiBhc3ByaW50Ziwgc28gSSBzZWUgbm8gcG9pbnQgaW4gbm90IHVzaW5n
IHN0cmR1cC4NCg0KPiB0aHghDQo+IGhvZnJhdA0KPiANCj4+DQo+PiBUaGVyZWZvcmUgSSBoYWQg
YSBsb29rIGF0IHRoZSBjb2RlLCBhbmQgdG8gbWUgaXQgc2VlbXMgYXMgaWYgdGhlIGNvbnN1bWVy
DQo+PiB2ZXJ5IG11Y2ggZnJlZXMgdGhlIHN0cmluZ3MsIHdoaWNoIG1lYW5zIHRoYXQgd2UgYXJl
IGluIGNhc2UgMiwgYW5kIHRoYXQNCj4+IHRoZSBhYm92ZSBzaG91bGQgYmUgb3JkaW5hcnkga3N0
cmR1cCBjYWxscy4NCj4+DQo+PiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPj4NCj4+IENoZWVy
cywNCj4+IFBldGVyDQo+Pg0KPj4+ICsJCWlmICghcHJvcHNbaV0ubmFtZSB8fCAhcHJvcHNbaV0u
dmFsdWUpIHsNCj4+PiArCQkJZGV2X2VycigmcGRldi0+ZGV2LA0KPj4+ICsJCQkJImNoYW4gJWQg
bmFtZSwgdmFsdWUgYWxsb2NhdGlvbiBmYWlsZWRcbiIsIGkpOw0KPj4+ICsJCQllcnIgPSAtRU5P
TUVNOw0KPj4+ICsJCQlnb3RvIGVycl9yb2xsYmFjazsNCj4+PiArCQl9DQo+Pj4gIAkJcHJvcHNb
aV0ubGVuZ3RoID0gMzsNCj4+PiAgDQo+Pj4gIAkJb2ZfY2hhbmdlc2V0X2luaXQoJnByaXYtPmNo
YW5baV0uY2hnc2V0KTsNCj4+Pg0KPj4NCg0K
