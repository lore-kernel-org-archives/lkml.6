Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10157C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F9B20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y7twgWve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F9B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeKTVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:03:02 -0500
Received: from mail-eopbgr710086.outbound.protection.outlook.com ([40.107.71.86]:34976
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbeKTVDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTTQpnf2SAtHKTXnS92zsnfpXj9SJNSennUN1mNW3bU=;
 b=Y7twgWve16iBV4GL+w4kj4E+4CbzX5H9fU04wYDsW8Oxs0EBEhfEtZc0EtWoMBvlo5A4ju1ECzV9nfzpuFHLi5gbka+gwe8fmyHLUoJdpxXr3pqyuKQ/LUb83tvqWoMEMQh/4riyw8qDXbhTEI4sOcOXv1cWakRlnS+WqC+kaio=
Received: from BN6PR12MB1649.namprd12.prod.outlook.com (10.172.19.12) by
 BN6PR12MB1393.namprd12.prod.outlook.com (10.168.228.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 10:34:32 +0000
Received: from BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d0c7:6cbd:851b:d487]) by BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d0c7:6cbd:851b:d487%3]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 10:34:32 +0000
From:   Sandeep Singh <ssingh1@amd.com>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>
CC:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [PATCH] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC.
Thread-Topic: [PATCH] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC.
Thread-Index: AQHUfYVQ++sWkxf0UEmA/CV672PX9aVSE7OAgAZqV4A=
Date:   Tue, 20 Nov 2018 10:34:32 +0000
Message-ID: <6439a42b-446d-73c5-0e4f-a00ff588595f@amd.com>
References: <1542356426-10299-1-git-send-email-Sandeep.Singh@amd.com>
 <0B58593B-1CE2-49EB-9F13-A2BC449AB8E8@canonical.com>
In-Reply-To: <0B58593B-1CE2-49EB-9F13-A2BC449AB8E8@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0140.apcprd06.prod.outlook.com
 (2603:1096:1:1f::18) To BN6PR12MB1649.namprd12.prod.outlook.com
 (2603:10b6:405:6::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1393;20:ysG75h3dwRsIxUXzm6gH4WtVZnigXLIqS5cBki66iXiz++bvnOihVcygNRne37Y67ShfWwGIbYpf4Oq6Xx4mD/F2IBO6miLtdFcv2kEnhrOpxwJDyTOoXkNkkkyXErw51r5zec7VY3Ce0q9kDVYAkK7kNxEakiSMDt6ZGw4th/McRuN3Aai5jVWBd0Eva1GJTfvRT4Lg6aUD86G4spi92vohhI1KwLTIuC7ea7p+sV5kbn67PaqZAT6r09Y82sVM
x-ms-office365-filtering-correlation-id: cbcf336c-9fe4-4b95-d823-08d64ed3c1fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1393;
x-ms-traffictypediagnostic: BN6PR12MB1393:
x-microsoft-antispam-prvs: <BN6PR12MB139385A09A86E2155B9EF369E0D90@BN6PR12MB1393.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1393;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1393;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(189003)(199004)(6246003)(217873002)(71200400001)(71190400001)(7736002)(4326008)(305945005)(3846002)(2906002)(6436002)(6116002)(14444005)(14454004)(256004)(110136005)(476003)(446003)(2616005)(5660300001)(575784001)(316002)(486006)(11346002)(53936002)(6512007)(6486002)(229853002)(54906003)(6636002)(36756003)(31686004)(186003)(478600001)(66066001)(26005)(97736004)(102836004)(31696002)(72206003)(25786009)(68736007)(2900100001)(8936002)(99286004)(106356001)(53546011)(81166006)(6506007)(8676002)(81156014)(386003)(105586002)(52116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1393;H:BN6PR12MB1649.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /NfEr/OsN1Age969fxU84Lq7a6C+TuRDlJYqruzkqHsBGXxrWqOIrMTnKJqkwJXmI4/s7cr18eLtNDZ2TNo0IQwnZZmf7P5GgMsPQ54BAQsQcamiTgVHHANTGRVolfmCTFAzDINsvcOI7mniUWWuWSIYRt2VbCaO98XidwIRQA9wzeMRujP9ENJ4K9XEfblVUS0TxOi133D+R4WvKieA6LZeqi6IDdBIHvyP8EA/fyCb1kGdzWC+28VLXMpJmwHtL6R9SckzlEcZSJZQiJu3jvm/M7HRU1uzpnqPHU2beGvWejXSHreVkuSIjgnN2+rR6VM3xbEeTAoTAHfwFelRdS/zUr6Ld1VH/Vw8YWEXxXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6229C3C16F4A604F8B08737FDC5C0CD1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcf336c-9fe4-4b95-d823-08d64ed3c1fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:34:32.6353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2FpLWhlbmcsDQoNCk9uIDExLzE2LzIwMTggMjowNSBQTSwgS2FpIEhlbmcgRmVuZyB3cm90
ZToNCj4gSGkgU2FuZGVlcCwNCj4gDQo+PiBPbiBOb3YgMTYsIDIwMTgsIGF0IDE2OjIxLCBTaW5n
aCwgU2FuZGVlcCA8U2FuZGVlcC5TaW5naEBhbWQuY29tPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBT
YW5kZWVwIFNpbmdoIDxzYW5kZWVwLnNpbmdoQGFtZC5jb20+DQo+Pg0KPj4gT2NjYXNpb25hbGx5
IEFNRCBTTlBTIDMuMCB4SEMgZG9lcyBub3QgcmVzcG9uZCB0bw0KPj4gQ1NTIHdoZW4gc2V0LCBh
bHNvIGl0IGRvZXMgbm90IGZsYWcgYW55dGhpbmcgb24gU1JFIGFuZCBIQ0UNCj4+IHRvIHBvaW50
IHRoZSBpbnRlcm5hbCB4SEMgZXJyb3JzIG9uIFVTQlNUUyByZWdpc3Rlci4gVGhpcyBzdGFsbHMN
Cj4+IHRoZSBlbnRpcmUgc3lzdGVtIHdpZGUgc3VzcGVuZCBhbmQgdGhlcmUgaXMgbm8gcG9pbnQg
aW4gc3RhbGxpbmcNCj4+IGp1c3QgYmVjYXVzZSBvZiB4SEMgQ1NTIGlzIG5vdCByZXNwb25kaW5n
Lg0KPj4NCj4+IFRvIHdvcmsgYXJvdW5kIHRoaXMgcHJvYmxlbSwgaWYgdGhlIHhIQyBkb2VzIG5v
dCBmbGFnDQo+PiBhbnl0aGluZyBvbiBTUkUgYW5kIEhDRSwgd2UgY2FuIHNraXAgdGhlIENTUw0K
Pj4gdGltZW91dCBhbmQgYWxsb3cgdGhlIHN5c3RlbSB0byBjb250aW51ZSB0aGUgc3VzcGVuZC4g
T25jZSB0aGUNCj4+IHN5c3RlbSByZXN1bWUgaGFwcGVucyB3ZSBjYW4gaW50ZXJuYWxseSByZXNl
dCB0aGUgY29udHJvbGxlcg0KPj4gdXNpbmcgWEhDSV9SRVNFVF9PTl9SRVNVTUUgcXVpcmsuDQo+
IA0KPiBXaGF0IGhhcHBlbnMgdG8gdGhlIGNvbm5lY3RlZCBhbmQgc3VzcGVuZGVkIFVTQiBkZXZp
Y2VzPw0KPiBEbyBVU0IgZGV2aWNlcyBsb3NlIHJlbW90ZSB3YWtldXAgZnVuY3Rpb25hbGl0eSB3
aGVuIHRoaXMgaGFwcGVucz8NCj4NCk9uY2UgdGhlIGlzc3VlIGhhcHBlbnMgY29udHJvbGxlciBn
b2VzIGludG8gYmFkIHN0YXRlLg0KU28gaW4gdGhhdCBjYXNlIGNvbnRyb2xsZXIgbmVlZHMgdG8g
YmUgcmVzZXQgYW5kIGluIHRoaXMNCnByb2Nlc3MgYWxsIHBvcnRzIHdpbGwgYmUgcmVzZXQNCg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoeWFtIFN1bmRhciBTIEsgPFNoeWFtLXN1bmRhci5TLWtA
YW1kLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNhbmRlZXAgU2luZ2ggPFNhbmRlZXAuU2luZ2hA
YW1kLmNvbT4NCj4+IGNjOiBOZWhhbCBTaGFoIDxOZWhhbC1iYWt1bGNoYW5kcmEuU2hhaEBhbWQu
Y29tPg0KPj4gLS0tDQo+PiBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMgfCAgNCArKysrDQo+
PiBkcml2ZXJzL3VzYi9ob3N0L3hoY2kuYyAgICAgfCAyNSArKysrKysrKysrKysrKysrKysrKysr
KysrDQo+PiBkcml2ZXJzL3VzYi9ob3N0L3hoY2kuaCAgICAgfCAgMSArDQo+PiAzIGZpbGVzIGNo
YW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
aG9zdC94aGNpLXBjaS5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXBjaS5jDQo+PiBpbmRleCAw
MWM1NzA1Li43MjQ5M2M0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXBj
aS5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMNCj4+IEBAIC0xMzksNiAr
MTM5LDEwIEBAIHN0YXRpYyB2b2lkIHhoY2lfcGNpX3F1aXJrcyhzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCB4aGNpX2hjZCAqeGhjaSkNCj4+IAkJIHBkZXYtPmRldmljZSA9PSAweDQzYmIpKQ0K
Pj4gCQl4aGNpLT5xdWlya3MgfD0gWEhDSV9TVVNQRU5EX0RFTEFZOw0KPj4NCj4+ICsJaWYgKHBk
ZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0FNRCAmJg0KPj4gKwkgICAgKHBkZXYtPmRldmlj
ZSA9PSAweDE1ZTAgfHwgcGRldi0+ZGV2aWNlID09IDB4MTVlMSkpDQo+PiArCQl4aGNpLT5xdWly
a3MgfD0gWEhDSV9TTlBTX0JST0tFTl9TVVNQRU5EOw0KPj4gKw0KPj4gCWlmIChwZGV2LT52ZW5k
b3IgPT0gUENJX1ZFTkRPUl9JRF9BTUQpDQo+PiAJCXhoY2ktPnF1aXJrcyB8PSBYSENJX1RSVVNU
X1RYX0xFTkdUSDsNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMg
Yi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KPj4gaW5kZXggMDQyMGVlZi4uOTY1YjUwMyAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jDQo+PiArKysgYi9kcml2ZXJzL3Vz
Yi9ob3N0L3hoY2kuYw0KPj4gQEAgLTk3MCw2ICs5NzAsNyBAQCBpbnQgeGhjaV9zdXNwZW5kKHN0
cnVjdCB4aGNpX2hjZCAqeGhjaSwgYm9vbCBkb193YWtldXApDQo+PiAJdW5zaWduZWQgaW50CQlk
ZWxheSA9IFhIQ0lfTUFYX0hBTFRfVVNFQzsNCj4+IAlzdHJ1Y3QgdXNiX2hjZAkJKmhjZCA9IHho
Y2lfdG9faGNkKHhoY2kpOw0KPj4gCXUzMgkJCWNvbW1hbmQ7DQo+PiArCXUzMgkJCXJlczsNCj4+
DQo+PiAJaWYgKCFoY2QtPnN0YXRlKQ0KPj4gCQlyZXR1cm4gMDsNCj4+IEBAIC0xMDI1LDEwICsx
MDI2LDMyIEBAIGludCB4aGNpX3N1c3BlbmQoc3RydWN0IHhoY2lfaGNkICp4aGNpLCBib29sIGRv
X3dha2V1cCkNCj4+IAl3cml0ZWwoY29tbWFuZCwgJnhoY2ktPm9wX3JlZ3MtPmNvbW1hbmQpOw0K
Pj4gCWlmICh4aGNpX2hhbmRzaGFrZSgmeGhjaS0+b3BfcmVncy0+c3RhdHVzLA0KPj4gCQkJCVNU
U19TQVZFLCAwLCAxMCAqIDEwMDApKSB7DQo+PiArCQlpZiAoeGhjaS0+cXVpcmtzICYgWEhDSV9T
TlBTX0JST0tFTl9TVVNQRU5EKSB7DQo+PiArCQkgICAgICAgLyoNCj4+ICsJCQkqIEFNRCBTTlBT
IHhIQyAzLjAgb2NjYXNpb25hbGx5IGRvZXMgbm90IGNsZWFyIHRoZQ0KPj4gKwkJCSogU1NTIGJp
dCBvZiBVU0JTVFMgYW5kIHdoZW4gZHJpdmVyIHRyaWVzIHRvIHBvbGwNCj4+ICsJCQkqIHRvIHNl
ZSBpZiB0aGUgeEhDIGNsZWFycyBCSVQoOCkgd2hpY2ggbmV2ZXIgaGFwcGVucw0KPj4gKwkJCSog
YW5kIGRyaXZlciBhc3N1bWVzIHRoYXQgY29udHJvbGxlciBpcyBub3QgcmVzcG9uZGluZw0KPj4g
KwkJCSogYW5kIHRpbWVzIG91dC4gVG8gd29ya2Fyb3VuZCB0aGlzLCBpdHMgZ29vZCB0byBjaGVj
aw0KPj4gKwkJCSogaWYgU1JFIGFuZCBIQ0UgYml0cyBhcmUgbm90IHNldCAoYXMgcGVyIHhoY2kN
Cj4+ICsJCQkqIFNlY3Rpb24gNS40LjIpIGFuZCBieXBhc3MgdGhlIHRpbWVvdXQuDQo+PiArCQkJ
Ki8NCj4+ICsNCj4+ICsJCQlyZXMgPSByZWFkbCgmeGhjaS0+b3BfcmVncy0+c3RhdHVzKTsNCj4+
ICsJCQlpZiAocmVzICYgU1RTX1NBVkUpIHsNCj4+ICsJCQkJaWYgKCgocmVzICYgU1RTX1NSRSkg
PT0gMCkgJiYNCj4+ICsJCQkJICAgICgocmVzICYgU1RTX0hDRSkgPT0gMCkpIHsNCj4+ICsJCQkJ
CXhoY2ktPnF1aXJrcyB8PSBYSENJX1JFU0VUX09OX1JFU1VNRTsNCj4+ICsJCQkJCWdvdG8gY29t
cGxldGVfc3VzcGVuZDsNCj4+ICsJCQkJfQ0KPj4gKwkJCX0NCj4gDQo+IE1heWJlIG1lcmdlIHRo
ZSB0d28g4oCcaWZz4oCdPyBUaGVyZSBhcmUgbm8gb3RoZXIgY29uZGl0aW9ucyB0byBoYW5kbGUu
DQo+IA0KPiBLYWktSGVuZw0KPiANCj4+ICsJCX0NCj4+ICsNCj4+IAkJeGhjaV93YXJuKHhoY2ks
ICJXQVJOOiB4SEMgc2F2ZSBzdGF0ZSB0aW1lb3V0XG4iKTsNCj4+IAkJc3Bpbl91bmxvY2tfaXJx
KCZ4aGNpLT5sb2NrKTsNCj4+IAkJcmV0dXJuIC1FVElNRURPVVQ7DQo+PiAJfQ0KPj4gKyBjb21w
bGV0ZV9zdXNwZW5kOg0KPj4gCXNwaW5fdW5sb2NrX2lycSgmeGhjaS0+bG9jayk7DQo+Pg0KPj4g
CS8qDQo+PiBAQCAtMTIxMyw2ICsxMjM2LDggQEAgaW50IHhoY2lfcmVzdW1lKHN0cnVjdCB4aGNp
X2hjZCAqeGhjaSwgYm9vbCBoaWJlcm5hdGVkKQ0KPj4gCXVzYl9oY2RfcG9sbF9yaF9zdGF0dXMo
eGhjaS0+c2hhcmVkX2hjZCk7DQo+PiAJc2V0X2JpdChIQ0RfRkxBR19QT0xMX1JILCAmaGNkLT5m
bGFncyk7DQo+PiAJdXNiX2hjZF9wb2xsX3JoX3N0YXR1cyhoY2QpOw0KPj4gKwlpZiAoeGhjaS0+
cXVpcmtzICYgWEhDSV9TTlBTX0JST0tFTl9TVVNQRU5EKQ0KPj4gKwkJeGhjaS0+cXVpcmtzICY9
IH5YSENJX1JFU0VUX09OX1JFU1VNRTsNCj4+DQo+PiAJcmV0dXJuIHJldHZhbDsNCj4+IH0NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuaCBiL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS5oDQo+PiBpbmRleCBiZjBiMzY5Li5lYjk5NzgyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy91c2IvaG9zdC94aGNpLmgNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5oDQo+PiBA
QCAtMTg0OSw2ICsxODQ5LDcgQEAgc3RydWN0IHhoY2lfaGNkIHsNCj4+ICNkZWZpbmUgWEhDSV9J
TlRFTF9VU0JfUk9MRV9TVwlCSVRfVUxMKDMxKQ0KPj4gI2RlZmluZSBYSENJX1pFUk9fNjRCX1JF
R1MJQklUX1VMTCgzMikNCj4+ICNkZWZpbmUgWEhDSV9ERUZBVUxUX1BNX1JVTlRJTUVfQUxMT1cJ
QklUX1VMTCgzMykNCj4+ICsjZGVmaW5lIFhIQ0lfU05QU19CUk9LRU5fU1VTUEVORAlCSVRfVUxM
KDM0KQ0KPj4NCj4+IAl1bnNpZ25lZCBpbnQJCW51bV9hY3RpdmVfZXBzOw0KPj4gCXVuc2lnbmVk
IGludAkJbGltaXRfYWN0aXZlX2VwczsNCj4+IC0tIA0KPj4gMi43LjQNCj4+DQo+IA0K
