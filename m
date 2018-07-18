Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBCFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A40C206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bNf6sJQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A40C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbeGRMaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:30:18 -0400
Received: from mail-eopbgr720046.outbound.protection.outlook.com ([40.107.72.46]:10912
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729233AbeGRMaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1UgZHDmG+VmowNlbONwxPOF8rr7K2+zqww8zZzK/RY=;
 b=bNf6sJQeZIs+BgniKaKtyN+jIQNWloNyiCC0GvVG9yQBYvsKeRHVbFBSCH0FsyC6V0EFeDCCZOJq0dYbK4dihi+tt73pY4HA9q0Gn119GzCDCIt4MI2LggNbyF4EqClpxZ8nZLV2pKWTtmt8VEkuVOW83doqYAn0eYwe+PForXA=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB5294.namprd02.prod.outlook.com (52.135.104.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 11:52:39 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::8d78:da03:ea70:9f9b]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::8d78:da03:ea70:9f9b%2]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 11:52:39 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>, Joe Perches <joe@perches.com>
Subject: RE: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name to
 'iio_xadc_channels'
Thread-Topic: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name to
 'iio_xadc_channels'
Thread-Index: AQHUHohD3AfxRdSqnEayP7mvTIGIbKSU1RAAgAAGkrA=
Date:   Wed, 18 Jul 2018 11:52:39 +0000
Message-ID: <SN6PR02MB4959267C97370CCE2052A9E4C1530@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
 <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
In-Reply-To: <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB5294;7:VjTY0kEvMTgOww+itAqvyWxUi/T4QeihEUV6fQ4udRj6ycY1ohP34JIeJ0RuXqe8OMAKjGfoGFpNYBSfjE6eSnWl8PZPfk6E7Pf1nEw9CDpg1wfbIiWK29YXdsgj+4vAIx2CW7gckbJ0Tg0ejCowpcw2w2xa0qf5UCAgcek1gaYcPJr9QyDRJo57KXHaypeFZgn52zP+BBR01Rk990cG1DT1fkmdkS5xJGQyJziZ68SaodYHsZo6Q7JP93XF80Lf
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: ae35916a-3e3e-460a-873a-08d5eca4f68d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB5294;
x-ms-traffictypediagnostic: SN6PR02MB5294:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB5294DAF10866CAE25BF1E811C1530@SN6PR02MB5294.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB5294;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5294;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(13464003)(66066001)(25786009)(7696005)(476003)(6506007)(11346002)(316002)(6436002)(53546011)(186003)(486006)(102836004)(446003)(14454004)(3846002)(229853002)(6116002)(26005)(5660300001)(2906002)(68736007)(33656002)(110136005)(86362001)(8936002)(81166006)(14444005)(106356001)(2501003)(53936002)(8676002)(81156014)(7736002)(2201001)(305945005)(97736004)(99286004)(2900100001)(105586002)(5250100002)(76176011)(4326008)(55016002)(9686003)(478600001)(72206003)(6246003)(54906003)(256004)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5294;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MDxxypvI8/ktBW1eAP0PxiDsAgqJ7pr/vbKf2q5Tb5dsN5cRcVpAmlFae7QiBrkhMmps8kdAWX3x2W74hlzT1aZn+Oj/eEcpC/zC5fVwYKAW5hjhCAoMafiD5gbI156rk2qqUHqyjZxu/IjIWAEIvCjWdiyiVgyuFy+enNTSmgN5KMzq+kfXxzKHXyWOgj0KSBDsc1/eBoQ0Mg4Qo9o+6At1DYNUunPw1jYYe0wpi1/QJPZDEyc1eR17o6069jswx9yGslqGzRwSJjDxCiWag65fWf0dKqmabc/irs/N9F02UDTtGgMOkrrpaD9NzLloKw8ToXNVXklPvEUVfeUHSGXvAw9WwCkDL9NpRzrdHG8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae35916a-3e3e-460a-873a-08d5eca4f68d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 11:52:39.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGFycywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXJzLVBl
dGVyIENsYXVzZW4gW21haWx0bzpsYXJzQG1ldGFmb28uZGVdDQo+IFNlbnQ6IFdlZG5lc2RheSwg
SnVseSAxOCwgMjAxOCA0OjQ5IFBNDQo+IFRvOiBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlu
eC5jb20+OyBqaWMyM0BrZXJuZWwub3JnOw0KPiBrbmFhY2suaEBnbXguZGU7IHBtZWVyd0BwbWVl
cncubmV0OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT47IGxpbnV4LWlpb0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFuaXJ1ZGhhIFNhcmFuZ2kgPGFu
aXJ1ZGhAeGlsaW54LmNvbT47IFNyaW5pdmFzIEdvdWQNCj4gPHNnb3VkQHhpbGlueC5jb20+OyBK
b2UgUGVyY2hlcyA8am9lQHBlcmNoZXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0g
aWlvOiBhZGM6IHhpbGlueDogUmVuYW1lICdjaGFubmVscycgdmFyaWFibGUgbmFtZSB0bw0KPiAn
aWlvX3hhZGNfY2hhbm5lbHMnDQo+IA0KPiBPbiAwNy8xOC8yMDE4IDAxOjEyIFBNLCBNYW5pc2gg
TmFyYW5pIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggZml4IHRoZSBmb2xsb3dpbmcgY2hlY2twYXRj
aCB3YXJuaW5nIGluIHhhZGMgZHJpdmVyLg0KPiA+IC0gUmV1c2luZyB0aGUga3JlYWxsb2MgYXJn
IGlzIGFsbW9zdCBhbHdheXMgYSBidWcuDQo+ID4NCj4gPiBSZW5hbWVkIHRoZSAnY2hhbm5lbHMn
IHZhcmlhYmxlIGFzICdpaW9feGFkY19jaGFubmVscycgdG8gZml4IHRoZQ0KPiA+IGFib3ZlIHdh
cm5pbmcuDQo+ID4NCj4gDQo+IFRoaXMgaXMgYSBidWcgaW4gY2hlY2twYXRjaCBhbmQgc2hvdWxk
IGJlIGZpeGVkIGluIGNoZWNrcGF0Y2guIFRoZSBjb2RlIGlzIG5vdA0KPiBhY3R1YWxseSByZS11
c2luZyB0aGUgcGFyYW1ldGVyLiBjaGFubmVscyBhbmQgeGFkY19jaGFubmVscyBhcmUgaW5kZXBl
bmRlbnQNCj4gdmFyaWFibGVzLCBqdXN0IGNoZWNrcGF0Y2ggc29tZWhvdyBkb2VzIG5vdCByZWFs
aXplIHRoaXMuDQpJIGFncmVlIHdpdGggeW91IG9uIHRoaXMuIEluaXRpYWxseSBJIHByZXN1bWVk
IHRoZSBjaGVja3BhdGNoIHRvIGJlIGdpdmluZyBnZW51aW5lDQp3YXJuaW5nIGJ1dCBub3cgSSBh
bSBzdXJlIHRoYXQgdGhpcyBpcyBjZXJ0YWlubHkgdGhlIGNoZWNrcGF0Y2ggc2NyaXB0IGlzc3Vl
Lg0KSW4gdGhhdCBjYXNlIHNob3VsZCB3ZSBrZWVwIHRoaXMgY29kZSBjaGFuZ2U/DQpQbGVhc2Ug
c3VnZ2VzdC4NCg0KVGhhbmtzLA0KTWFuaXNoDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFu
aXNoIE5hcmFuaSA8bWFuaXNoLm5hcmFuaUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL2lpby9hZGMveGlsaW54LXhhZGMtY29yZS5jIHwgMTYgKysrKysrKysrLS0tLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy94aWxpbngteGFkYy1jb3JlLmMNCj4gPiBi
L2RyaXZlcnMvaWlvL2FkYy94aWxpbngteGFkYy1jb3JlLmMNCj4gPiBpbmRleCBkNGYyMWQxLi4y
N2I0NWRmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy94aWxpbngteGFkYy1jb3Jl
LmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMveGlsaW54LXhhZGMtY29yZS5jDQo+ID4gQEAg
LTEwNDAsNyArMTA0MCw3IEBAIHN0YXRpYyBpbnQgeGFkY19wYXJzZV9kdChzdHJ1Y3QgaWlvX2Rl
diAqaW5kaW9fZGV2LA0KPiBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiA+ICAJdW5zaWduZWQg
aW50ICpjb25mKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgeGFkYyAqeGFkYyA9IGlpb19wcml2KGlu
ZGlvX2Rldik7DQo+ID4gLQlzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2hhbm5lbHMsICpjaGFuOw0K
PiA+ICsJc3RydWN0IGlpb19jaGFuX3NwZWMgKmlpb194YWRjX2NoYW5uZWxzLCAqY2hhbjsNCj4g
PiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqY2hhbl9ub2RlLCAqY2hpbGQ7DQo+ID4gIAl1bnNpZ25l
ZCBpbnQgbnVtX2NoYW5uZWxzOw0KPiA+ICAJY29uc3QgY2hhciAqZXh0ZXJuYWxfbXV4Ow0KPiA+
IEBAIC0xMDgzLDEyICsxMDgzLDEzIEBAIHN0YXRpYyBpbnQgeGFkY19wYXJzZV9kdChzdHJ1Y3Qg
aWlvX2Rldg0KPiAqaW5kaW9fZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiA+ICAJCSpj
b25mIHw9IFhBRENfQ09ORjBfTVVYIHwNCj4gWEFEQ19DT05GMF9DSEFOKGV4dF9tdXhfY2hhbik7
DQo+ID4gIAl9DQo+ID4NCj4gPiAtCWNoYW5uZWxzID0ga21lbWR1cCh4YWRjX2NoYW5uZWxzLCBz
aXplb2YoeGFkY19jaGFubmVscyksDQo+IEdGUF9LRVJORUwpOw0KPiA+IC0JaWYgKCFjaGFubmVs
cykNCj4gPiArCWlpb194YWRjX2NoYW5uZWxzID0ga21lbWR1cCh4YWRjX2NoYW5uZWxzLCBzaXpl
b2YoeGFkY19jaGFubmVscyksDQo+ID4gKwkJCQkgICAgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAo
IWlpb194YWRjX2NoYW5uZWxzKQ0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+DQo+ID4gIAlu
dW1fY2hhbm5lbHMgPSA5Ow0KPiA+IC0JY2hhbiA9ICZjaGFubmVsc1s5XTsNCj4gPiArCWNoYW4g
PSAmaWlvX3hhZGNfY2hhbm5lbHNbOV07DQo+ID4NCj4gPiAgCWNoYW5fbm9kZSA9IG9mX2dldF9j
aGlsZF9ieV9uYW1lKG5wLCAieGxueCxjaGFubmVscyIpOw0KPiA+ICAJaWYgKGNoYW5fbm9kZSkg
ew0KPiA+IEBAIC0xMTE5LDExICsxMTIwLDEyIEBAIHN0YXRpYyBpbnQgeGFkY19wYXJzZV9kdChz
dHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiA+
ICAJb2Zfbm9kZV9wdXQoY2hhbl9ub2RlKTsNCj4gPg0KPiA+ICAJaW5kaW9fZGV2LT5udW1fY2hh
bm5lbHMgPSBudW1fY2hhbm5lbHM7DQo+ID4gLQlpbmRpb19kZXYtPmNoYW5uZWxzID0ga3JlYWxs
b2MoY2hhbm5lbHMsIHNpemVvZigqY2hhbm5lbHMpICoNCj4gPiAtCQkJCQludW1fY2hhbm5lbHMs
IEdGUF9LRVJORUwpOw0KPiA+ICsJaW5kaW9fZGV2LT5jaGFubmVscyA9IGtyZWFsbG9jKGlpb194
YWRjX2NoYW5uZWxzLA0KPiA+ICsJCQkJICAgICAgIHNpemVvZigqaWlvX3hhZGNfY2hhbm5lbHMp
ICoNCj4gPiArCQkJCSAgICAgICBudW1fY2hhbm5lbHMsIEdGUF9LRVJORUwpOw0KPiA+ICAJLyog
SWYgd2UgY2FuJ3QgcmVzaXplIHRoZSBjaGFubmVscyBhcnJheSwganVzdCB1c2UgdGhlIG9yaWdp
bmFsICovDQo+ID4gIAlpZiAoIWluZGlvX2Rldi0+Y2hhbm5lbHMpDQo+ID4gLQkJaW5kaW9fZGV2
LT5jaGFubmVscyA9IGNoYW5uZWxzOw0KPiA+ICsJCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBpaW9f
eGFkY19jaGFubmVsczsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KDQo=
