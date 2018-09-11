Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFEEC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4751120865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4751120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeIKXmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:38 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:57660 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeIKXmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:37 -0400
Received: from G9W8454.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 16D8A83;
        Tue, 11 Sep 2018 18:42:00 +0000 (UTC)
Received: from G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) by
 G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 11 Sep 2018 18:41:28 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8455.americas.hpqcorp.net (16.216.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 11 Sep 2018 18:41:28 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0323.NAMPRD84.PROD.OUTLOOK.COM (10.169.2.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Tue, 11 Sep 2018 18:41:26 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1122.020; Tue, 11 Sep 2018
 18:41:26 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: [PATCH 2/2] ext4, dax: set ext4_dax_aops for dax files
Thread-Topic: [PATCH 2/2] ext4, dax: set ext4_dax_aops for dax files
Thread-Index: AQHUSej7Q67hDcpgxEKY4HwO3VbK/6TrYvcAgAABigA=
Date:   Tue, 11 Sep 2018 18:41:26 +0000
Message-ID: <b26a520cba402f129314eabef78d2c2a2da4a1b0.camel@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
         <20180911154246.6844-3-toshi.kani@hpe.com>
         <CAPcyv4iEZ7q0MV7n-_eovrJw_U9S3=pkY_nYwtw1jSBS7vPqCQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iEZ7q0MV7n-_eovrJw_U9S3=pkY_nYwtw1jSBS7vPqCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0323;6:zc2VcSOlid5rxB5kf4ucHvf1Kjsr4sIZfE/6oDubNZyWPFDh/8YD1zwMDZ64J0GEuLDew3506rYNpG420XkjMXK2j34dvnNc+Xmn+w53v8rabegSdf0fq+NqpKn8K3cw6ccAA0IJYPc7zqgAJlVzLLLLRWVZcp8j0WyJHZ4KssxWqICtdUnWfVy+9chxHe0nDtqZDRZv8cU2EEpTM3k0lE7RM9/OkshuS+zoRwgkfjYNKN4RRQwNCMRXTCLi9UUtsPB6Z5louhxPUdsLB7DhAihjLGV4MhH65pFsbJjhAMkGt/kBzrhGygERURHBpstiGRt7Tj6Mcsr5LicyBZVUk4x63L+5JHJpwlyAh2tIjDizMRVKqsQOH/SmWZnKaotqxljB9LalcFZllV851YJPsRQgYhgBWDWJOahPNjUOYNA//FP7KaNukpraL1O7VSt5ZeQIxH6MB1vF+2Eyug1sOQ==;5:bK/AC3Jc4F2QOqAR3kDDxnZXXwqBXVdQfwavAfhTQBDQDwYSTEiZqihjPcR5JvpIqNATNZDGAz3gDOYNrx2RHSMKsbKkYnt3gyuAVoYqIXL3xzoXxvWFVx08X3I4E9V7OAy40Wjv2GAM3EoLo3cm1mPcimmxfvnC+Up8Li/EUsk=;7:Mh/J+sb4pz8wc4KqVpgEuE2SSKyImEvNhbLeHSRcSLQMWyDq1NS8oEaCUP/JNaSE3CypMpFnjlRFDuDoa6D+x4BpmhyMEETBRcG7BIQ+HH4LIsiFoSDgAQF/yBnw9x98oyK2HpuJEe7sQHj4y1+aDFXCG3Xg/xlKi+nK7bKlI8/TlZzpioJrQDicpWXl6AZeUXc2bdJtpCpNii/PzbpLjG1NyVm5urjFmL3h9WxsJ81vqDLdqTQ5h98wM8wiRvhK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ef105cd9-a403-4dff-3165-08d618162e27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0323;
x-ms-traffictypediagnostic: AT5PR8401MB0323:
x-microsoft-antispam-prvs: <AT5PR8401MB03237E799ED0538359D2A3C882040@AT5PR8401MB0323.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(240460790083961)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AT5PR8401MB0323;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0323;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(376002)(366004)(396003)(189003)(199004)(53546011)(6506007)(478600001)(14454004)(5640700003)(53936002)(68736007)(81156014)(6512007)(81166006)(76176011)(8936002)(476003)(446003)(11346002)(8676002)(2616005)(14444005)(6916009)(2900100001)(486006)(102836004)(99286004)(256004)(86362001)(575784001)(26005)(186003)(106356001)(5660300001)(25786009)(2351001)(4326008)(118296001)(305945005)(7736002)(316002)(2501003)(105586002)(66066001)(6246003)(3846002)(54906003)(6116002)(5250100002)(229853002)(6486002)(97736004)(6436002)(2906002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0323;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ySy/jV2CuPaMbNj8w+8GzxgI0stSdaSEP/NKTjL7rGsrQIa7RRkhXsiN0QKVKUpYh3Kbd/F2O7XVGowyyFsfY3HNJqmZGsvrjmQ637xK78KjJP40YCzjDwOzgnk7Uokp3MGnaVW21EgBMe6nJpDa5DZGjB4XC+p2Tu687T5TLH9JVjcRDGmTTlLEwGDn+SCaeEn1S+C22q190VlCnO4DtQ4kfDvx0lNjjyyjl9b+kv3vGd6iog5Jm2YZjHAPLkNwvwBTzj+9gkrHPmHB/LJ6p9nPdbkZvAIGlkU01QBnizM99qGCS42lDzg+E8duA1z5LcWKndmMuxP2XV2lN4EW6Xs8mOU63BuQxcGer9XgphY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFF6AD399147714C9686656AC13320F4@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ef105cd9-a403-4dff-3165-08d618162e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 18:41:26.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0323
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTExIGF0IDExOjE1IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFR1ZSwgU2VwIDExLCAyMDE4IGF0IDg6NDIgQU0sIFRvc2hpIEthbmkgPHRvc2hpLmthbmlA
aHBlLmNvbT4gd3JvdGU6DQo+ID4gU3luYyBzeXNjYWxsIHRvIGFuIGV4aXN0aW5nIERBWCBmaWxl
IG5lZWRzIHRvIGZsdXNoIHByb2Nlc3NvciBjYWNoZSwNCj4gPiBidXQgaXQgZG9lcyBub3QgY3Vy
cmVudGx5LiAgVGhpcyBpcyBiZWNhdXNlICdleHQ0X2RhX2FvcHMnIGlzIHNldCB0bw0KPiA+IGFk
ZHJlc3Nfc3BhY2Vfb3BlcmF0aW9ucyBvZiBleGlzdGluZyBEQVggZmlsZXMsIGluc3RlYWQgb2Yg
J2V4dDRfZGF4X2FvcHMnLA0KPiA+IHNpbmNlIFNfREFYIGZsYWcgaXMgc2V0IGFmdGVyIGV4dDRf
c2V0X2FvcHMoKSBpbiB0aGUgb3BlbiBwYXRoLg0KPiA+IA0KPiA+ICAgTmV3IGZpbGUNCj4gPiAg
IC0tLS0tLS0tDQo+ID4gICBsb29rdXBfb3Blbg0KPiA+ICAgICBleHQ0X2NyZWF0ZQ0KPiA+ICAg
ICAgIF9fZXh0NF9uZXdfaW5vZGUNCj4gPiAgICAgICAgIGV4dDRfc2V0X2lub2RlX2ZsYWdzICAg
Ly8gU2V0IFNfREFYIGZsYWcNCj4gPiAgICAgICBleHQ0X3NldF9hb3BzICAgICAgICAgICAgLy8g
U2V0IGFvcHMgdG8gZXh0NF9kYXhfYW9wcw0KPiA+IA0KPiA+ICAgRXhpc3RpbmcgZmlsZQ0KPiA+
ICAgLS0tLS0tLS0tLS0tLQ0KPiA+ICAgbG9va3VwX29wZW4NCj4gPiAgICAgZXh0NF9sb29rdXAN
Cj4gPiAgICAgICBleHQ0X2lnZXQNCj4gPiAgICAgICAgIGV4dDRfc2V0X2FvcHMgICAgICAgICAg
Ly8gU2V0IGFvcHMgdG8gZXh0NF9kYV9hb3BzDQo+ID4gICAgICAgICBleHQ0X3NldF9pbm9kZV9m
bGFncyAgIC8vIFNldCBTX0RBWCBmbGFnDQo+ID4gDQo+ID4gQ2hhbmdlIGV4dDRfaWdldCgpIHRv
IGNhbGwgZXh0NF9zZXRfaW5vZGVfZmxhZ3MoKSBiZWZvcmUgZXh0NF9zZXRfYW9wcygpLg0KPiA+
IA0KPiA+IEZpeGVzOiA1ZjA2NjNiYjRhNjRmNTg4ZjBhMmRkNmQxYmU2OGQ0MGY5YWYwMDg2DQo+
IA0KPiBTYW1lIGZvcm1hdCBuaXQ6DQo+IA0KPiBGaXhlczogNWYwNjYzYmI0YTY0ICgiZXh0NCwg
ZGF4OiBpbnRyb2R1Y2UgZXh0NF9kYXhfYW9wcyIpDQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVs
Lm9yZz4NCg0KV2lsbCBkby4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRvc2hpIEthbmkgPHRvc2hp
LmthbmlAaHBlLmNvbT4NCj4gPiBDYzogSmFuIEthcmEgPGphY2tAc3VzZS5jej4NCj4gPiBDYzog
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4gQ2M6ICJUaGVvZG9y
ZSBUcydvIiA8dHl0c29AbWl0LmVkdT4NCj4gPiBDYzogQW5kcmVhcyBEaWxnZXIgPGFkaWxnZXIu
a2VybmVsQGRpbGdlci5jYT4NCj4gPiAtLS0NCj4gPiAgZnMvZXh0NC9pbm9kZS5jIHwgICAgMyAr
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9leHQ0L2lub2RlLmMgYi9mcy9leHQ0L2lub2RlLmMN
Cj4gPiBpbmRleCA3NzVjZDliNGFmNTUuLjkzY2JiYjg1OWM0MCAxMDA2NDQNCj4gPiAtLS0gYS9m
cy9leHQ0L2lub2RlLmMNCj4gPiArKysgYi9mcy9leHQ0L2lub2RlLmMNCj4gPiBAQCAtNDk5OCw2
ICs0OTk4LDggQEAgc3RydWN0IGlub2RlICpleHQ0X2lnZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpz
YiwgdW5zaWduZWQgbG9uZyBpbm8pDQo+ID4gICAgICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAg
ICAgICAgICBnb3RvIGJhZF9pbm9kZTsNCj4gPiANCj4gPiArICAgICAgIGV4dDRfc2V0X2lub2Rl
X2ZsYWdzKGlub2RlKTsNCj4gPiArDQo+IA0KPiBIbW0sIGRvZXMgdGhpcyBoYXZlIHVuaW50ZW5k
ZWQgYmVoYXZpb3IgY2hhbmdlcz8NCj4gDQo+IEkgbm90aWNlIHRoYXQgdGhlcmUgYXJlIHNvbWUg
Y2hlY2tzIGZvciBmbGFncyAiSVNfQVBQRU5EKGlub2RlKSB8fA0KPiBJU19JTU1VVEFCTEUoaW5v
ZGUpIiAqYmVmb3JlKiB0aGUgY2FsbCB0byBleHQ0X3NldF9pbm9kZV9mbGFncygpLiBJDQo+IGRp
ZG4ndCBsb29rIHRvbyBtdWNoIGRlZXBlciBhdCB3aGV0aGVyIHRob3NlIGNoZWNrcyBhcmUgYm9n
dXMsIGJ1dCBpdA0KPiB3b3VsZCBzZWVtIHNhZmVyIHRvIGRvIHNvbWV0aGluZyBsaWtlIHRoaXMg
Zm9yIGEgbG93ZXIgcmlzayBmaXguDQo+IA0KPiBUaG91Z2h0cz8NCg0KR29vZCBjYXRjaCEgIEFn
cmVlZC4NCg0KVGhhbmtzIQ0KLVRvc2hpDQoNCg==
