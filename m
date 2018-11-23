Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F135EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9CC20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Pf3SuOQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9CC20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436960AbeKXBZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:25:34 -0500
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:42498
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388198AbeKXBZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cbLvU+HWVRurM2PBmfgMSXJ0BU1RwqkejenoaVXFaM=;
 b=Pf3SuOQZczsmXVFNvNtz6qO2MRNFWZd2RWHPKpvBXB+RB6f7IgQuDJtb/taI5NDauVahODyynl0bI5KZUbdAeKHe+0XEJTO15KpENUCYP171esj1JDrJCDiPWMooMTFGFlgp4vZ7sjGMR05r/I9ZX7ETmaOz2l9jqC6mhuXO7+I=
Received: from BN6PR12MB1649.namprd12.prod.outlook.com (10.172.19.12) by
 BN6PR12MB1267.namprd12.prod.outlook.com (10.168.227.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Fri, 23 Nov 2018 14:39:10 +0000
Received: from BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d9ac:970b:bfa4:198c]) by BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d9ac:970b:bfa4:198c%8]) with mapi id 15.20.1361.018; Fri, 23 Nov 2018
 14:39:10 +0000
From:   Sandeep Singh <ssingh1@amd.com>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>
CC:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [PATCH v2] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
Thread-Topic: [PATCH v2] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
Thread-Index: AQHUghsO3ddM6jhDFUGc6Lr8yr9U0aVdGdcAgABWeoA=
Date:   Fri, 23 Nov 2018 14:39:09 +0000
Message-ID: <4e54e701-223d-f202-9da7-0f2849a53555@amd.com>
References: <1542860548-3109-1-git-send-email-Sandeep.Singh@amd.com>
 <31DD822A-AB20-4CE2-A5C9-878299011F62@canonical.com>
In-Reply-To: <31DD822A-AB20-4CE2-A5C9-878299011F62@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::16) To BN6PR12MB1649.namprd12.prod.outlook.com
 (2603:10b6:405:6::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [125.21.194.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1267;20:1I0MtQfAI7Q18mH2aWW7qdVqLDGcKO+BjwQpR18qbzWupfXoC07EcxiiAjcAqrMgKgVHGMYk9QcHaQ/WxOvF+94gEzHTSs9t6dhmhTj4mj7MFGQj/F+C47pND2nopMw2gpQewdQJ+LWEyXLcRA5Ayj4tXRK3zMkBv7ZrPQKRgCv/cK9BwipS4l/i3puBdxKKXsl1OGZLs8wf1NliVgF8tXGkEp0EPipdIny4/gKhLJFk3kx/x5xh1Ux3FXZNq2gL
x-ms-office365-filtering-correlation-id: ce2799f9-7aeb-4357-029b-08d651516db1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1267;
x-ms-traffictypediagnostic: BN6PR12MB1267:
x-microsoft-antispam-prvs: <BN6PR12MB126768CD63D3C83AB02E1173E0D40@BN6PR12MB1267.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1267;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1267;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(71190400001)(71200400001)(217873002)(66066001)(8676002)(4326008)(97736004)(81166006)(81156014)(25786009)(6116002)(256004)(316002)(14444005)(446003)(3846002)(2900100001)(575784001)(478600001)(31696002)(2616005)(68736007)(72206003)(11346002)(305945005)(7736002)(476003)(6636002)(53546011)(6436002)(229853002)(31686004)(105586002)(14454004)(6506007)(486006)(36756003)(76176011)(6512007)(2906002)(386003)(186003)(5660300001)(26005)(53936002)(99286004)(106356001)(110136005)(6246003)(54906003)(8936002)(52116002)(102836004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1267;H:BN6PR12MB1649.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0tpnCIh4gp9HCSEpBobGRFcs55gPCD10LhyURgeLGiUM0T6DfmKVjt6unRX7ZVf8ef/W4rBVkjttP3YAfqQ8co6Zf8tjBuysYxLnxpkH+sYu9PWWkC2KtIEZkqVtHz3MWRBgDnFsm6OO4JJIabCxc0D1Ln+OkxNjKI2QyK9u/6WKZriJJGJCl4rThOpJz6QPVbqGjl5MJlpcnLP6PBnrxf9IbPGwJIvtRGwVfbWTkdBbFOPJ6v35HWtG0Dxm/GZgGiPfTiPOHrN7Aw5m5fyKSU+7r11PWh65Oow3Dsu6/K+SVIJkVnbl6ZQbMHYCXwCANP8yMjs0Ib1bYCCNHZg3Q+n4KtcB797qxKIHvtHrP70=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2389E5DC05CEFC41A88721A297317152@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2799f9-7aeb-4357-029b-08d651516db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 14:39:09.9803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2FpLWhlbmcsDQoNCk9uIDExLzIzLzIwMTggMjo1OSBQTSwgS2FpIEhlbmcgRmVuZyB3cm90
ZToNCj4gSGkgU2FuZGVlcCwNCj4gDQo+PiBPbiBOb3YgMjIsIDIwMTgsIGF0IDEyOjIzIFBNLCBT
aW5naCwgU2FuZGVlcCA8U2FuZGVlcC5TaW5naEBhbWQuY29tPiB3cm90ZToNCj4+DQo+PiBGcm9t
OiBTYW5kZWVwIFNpbmdoIDxzYW5kZWVwLnNpbmdoQGFtZC5jb20+DQo+Pg0KPj4gT2NjYXNpb25h
bGx5IEFNRCBTTlBTIDMuMCB4SEMgZG9lcyBub3QgcmVzcG9uZCB0bw0KPj4gQ1NTIHdoZW4gc2V0
LCBhbHNvIGl0IGRvZXMgbm90IGZsYWcgYW55dGhpbmcgb24gU1JFIGFuZCBIQ0UNCj4+IHRvIHBv
aW50IHRoZSBpbnRlcm5hbCB4SEMgZXJyb3JzIG9uIFVTQlNUUyByZWdpc3Rlci4gVGhpcyBzdGFs
bHMNCj4+IHRoZSBlbnRpcmUgc3lzdGVtIHdpZGUgc3VzcGVuZCBhbmQgdGhlcmUgaXMgbm8gcG9p
bnQgaW4gc3RhbGxpbmcNCj4+IGp1c3QgYmVjYXVzZSBvZiB4SEMgQ1NTIGlzIG5vdCByZXNwb25k
aW5nLg0KPj4NCj4+IFRvIHdvcmsgYXJvdW5kIHRoaXMgcHJvYmxlbSwgaWYgdGhlIHhIQyBkb2Vz
IG5vdCBmbGFnDQo+PiBhbnl0aGluZyBvbiBTUkUgYW5kIEhDRSwgd2UgY2FuIHNraXAgdGhlIENT
Uw0KPj4gdGltZW91dCBhbmQgYWxsb3cgdGhlIHN5c3RlbSB0byBjb250aW51ZSB0aGUgc3VzcGVu
ZC4gT25jZSB0aGUNCj4+IHN5c3RlbSByZXN1bWUgaGFwcGVucyB3ZSBjYW4gaW50ZXJuYWxseSBy
ZXNldCB0aGUgY29udHJvbGxlcg0KPj4gdXNpbmcgWEhDSV9SRVNFVF9PTl9SRVNVTUUgcXVpcmsN
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaHlhbSBTdW5kYXIgUyBLIDxTaHlhbS1zdW5kYXIuUy1r
QGFtZC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTYW5kZWVwIFNpbmdoIDxTYW5kZWVwLlNpbmdo
QGFtZC5jb20+DQo+PiBjYzogTmVoYWwgU2hhaCA8TmVoYWwtYmFrdWxjaGFuZHJhLlNoYWhAYW1k
LmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4+DQo+PiAtPiBOZXcgVmFyaWFi
bGUgYmFzZWQgZGVjaXNpb24gbWFraW5nIHdoZW4gU05QUyBpc3N1ZSBoYXBwZW5zIGhlbmNlIA0K
Pj4gICBxdWlyayBpbnRlcmRlcGVuZGVuY3kgcmVtb3ZlZC4NCj4+IC0+IFJlbW92ZWQgU1RTIGNv
bmRpdGlvbmFsIGNoZWNrIGluIHN1c3BlbmQgZnVuY3Rpb24uDQo+Pg0KPj4gZHJpdmVycy91c2Iv
aG9zdC94aGNpLXBjaS5jIHwgIDQgKysrKw0KPj4gZHJpdmVycy91c2IvaG9zdC94aGNpLmMgICAg
IHwgMjYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+IGRyaXZlcnMvdXNiL2hvc3QveGhj
aS5oICAgICB8ICAzICsrKw0KPj4gMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kt
cGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMNCj4+IGluZGV4IDAxYzU3MDUuLjcy
NDkzYzQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMNCj4+ICsr
KyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYw0KPj4gQEAgLTEzOSw2ICsxMzksMTAgQEAg
c3RhdGljIHZvaWQgeGhjaV9wY2lfcXVpcmtzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHho
Y2lfaGNkICp4aGNpKQ0KPj4gCQkgcGRldi0+ZGV2aWNlID09IDB4NDNiYikpDQo+PiAJCXhoY2kt
PnF1aXJrcyB8PSBYSENJX1NVU1BFTkRfREVMQVk7DQo+Pg0KPj4gKwlpZiAocGRldi0+dmVuZG9y
ID09IFBDSV9WRU5ET1JfSURfQU1EICYmDQo+PiArCSAgICAocGRldi0+ZGV2aWNlID09IDB4MTVl
MCB8fCBwZGV2LT5kZXZpY2UgPT0gMHgxNWUxKSkNCj4+ICsJCXhoY2ktPnF1aXJrcyB8PSBYSENJ
X1NOUFNfQlJPS0VOX1NVU1BFTkQ7DQo+PiArDQo+PiAJaWYgKHBkZXYtPnZlbmRvciA9PSBQQ0lf
VkVORE9SX0lEX0FNRCkNCj4+IAkJeGhjaS0+cXVpcmtzIHw9IFhIQ0lfVFJVU1RfVFhfTEVOR1RI
Ow0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYyBiL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS5jDQo+PiBpbmRleCAwNDIwZWVmLi44MDg2NzdkIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhj
aS5jDQo+PiBAQCAtOTcwLDYgKzk3MCw3IEBAIGludCB4aGNpX3N1c3BlbmQoc3RydWN0IHhoY2lf
aGNkICp4aGNpLCBib29sIGRvX3dha2V1cCkNCj4+IAl1bnNpZ25lZCBpbnQJCWRlbGF5ID0gWEhD
SV9NQVhfSEFMVF9VU0VDOw0KPj4gCXN0cnVjdCB1c2JfaGNkCQkqaGNkID0geGhjaV90b19oY2Qo
eGhjaSk7DQo+PiAJdTMyCQkJY29tbWFuZDsNCj4+ICsJdTMyCQkJcmVzOw0KPj4NCj4+IAlpZiAo
IWhjZC0+c3RhdGUpDQo+PiAJCXJldHVybiAwOw0KPj4gQEAgLTEwMjMsMTEgKzEwMjQsMjggQEAg
aW50IHhoY2lfc3VzcGVuZChzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksIGJvb2wgZG9fd2FrZXVwKQ0K
Pj4gCWNvbW1hbmQgPSByZWFkbCgmeGhjaS0+b3BfcmVncy0+Y29tbWFuZCk7DQo+PiAJY29tbWFu
ZCB8PSBDTURfQ1NTOw0KPj4gCXdyaXRlbChjb21tYW5kLCAmeGhjaS0+b3BfcmVncy0+Y29tbWFu
ZCk7DQo+PiArCXhoY2ktPmJyb2tlbl9zdXNwZW5kID0gMDsNCj4+IAlpZiAoeGhjaV9oYW5kc2hh
a2UoJnhoY2ktPm9wX3JlZ3MtPnN0YXR1cywNCj4+IAkJCQlTVFNfU0FWRSwgMCwgMTAgKiAxMDAw
KSkgew0KPj4gLQkJeGhjaV93YXJuKHhoY2ksICJXQVJOOiB4SEMgc2F2ZSBzdGF0ZSB0aW1lb3V0
XG4iKTsNCj4+IC0JCXNwaW5fdW5sb2NrX2lycSgmeGhjaS0+bG9jayk7DQo+PiAtCQlyZXR1cm4g
LUVUSU1FRE9VVDsNCj4+ICsJLyoNCj4+ICsJICogQU1EIFNOUFMgeEhDIDMuMCBvY2Nhc2lvbmFs
bHkgZG9lcyBub3QgY2xlYXIgdGhlDQo+PiArCSAqIFNTUyBiaXQgb2YgVVNCU1RTIGFuZCB3aGVu
IGRyaXZlciB0cmllcyB0byBwb2xsDQo+PiArCSAqIHRvIHNlZSBpZiB0aGUgeEhDIGNsZWFycyBC
SVQoOCkgd2hpY2ggbmV2ZXIgaGFwcGVucw0KPj4gKwkgKiBhbmQgZHJpdmVyIGFzc3VtZXMgdGhh
dCBjb250cm9sbGVyIGlzIG5vdCByZXNwb25kaW5nDQo+PiArCSAqIGFuZCB0aW1lcyBvdXQuIFRv
IHdvcmthcm91bmQgdGhpcywgaXRzIGdvb2QgdG8gY2hlY2sNCj4+ICsJICogaWYgU1JFIGFuZCBI
Q0UgYml0cyBhcmUgbm90IHNldCAoYXMgcGVyIHhoY2kNCj4+ICsJICogU2VjdGlvbiA1LjQuMikg
YW5kIGJ5cGFzcyB0aGUgdGltZW91dC4NCj4+ICsJICovDQo+PiArCQlyZXMgPSByZWFkbCgmeGhj
aS0+b3BfcmVncy0+c3RhdHVzKTsNCj4+ICsJCWlmICgoeGhjaS0+cXVpcmtzICYgWEhDSV9TTlBT
X0JST0tFTl9TVVNQRU5EKSAmJg0KPj4gKwkJICAgICgoKHJlcyAmIFNUU19TUkUpID09IDApICYm
DQo+PiArCQkJCSgocmVzICYgU1RTX0hDRSkgPT0gMCkpKSB7DQo+PiArCQkJeGhjaS0+YnJva2Vu
X3N1c3BlbmQgPSAxOw0KPj4gKwkJfSBlbHNlIHsNCj4+ICsJCQl4aGNpX3dhcm4oeGhjaSwgIldB
Uk46IHhIQyBzYXZlIHN0YXRlIHRpbWVvdXRcbiIpOw0KPj4gKwkJCXNwaW5fdW5sb2NrX2lycSgm
eGhjaS0+bG9jayk7DQo+PiArCQkJcmV0dXJuIC1FVElNRURPVVQ7DQo+PiArCQl9DQo+PiAJfQ0K
Pj4gCXNwaW5fdW5sb2NrX2lycSgmeGhjaS0+bG9jayk7DQo+Pg0KPj4gQEAgLTEwODAsNyArMTA5
OCw3IEBAIGludCB4aGNpX3Jlc3VtZShzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksIGJvb2wgaGliZXJu
YXRlZCkNCj4+IAlzZXRfYml0KEhDRF9GTEFHX0hXX0FDQ0VTU0lCTEUsICZ4aGNpLT5zaGFyZWRf
aGNkLT5mbGFncyk7DQo+Pg0KPj4gCXNwaW5fbG9ja19pcnEoJnhoY2ktPmxvY2spOw0KPj4gLQlp
ZiAoeGhjaS0+cXVpcmtzICYgWEhDSV9SRVNFVF9PTl9SRVNVTUUpDQo+PiArCWlmICgoeGhjaS0+
cXVpcmtzICYgWEhDSV9SRVNFVF9PTl9SRVNVTUUpIHx8IHhoY2ktPmJyb2tlbl9zdXNwZW5kKQ0K
Pj4gCQloaWJlcm5hdGVkID0gdHJ1ZTsNCj4+DQo+PiAJaWYgKCFoaWJlcm5hdGVkKSB7DQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmggYi9kcml2ZXJzL3VzYi9ob3N0L3ho
Y2kuaA0KPj4gaW5kZXggYmYwYjM2OS4uZDVkMTliMiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS5oDQo+PiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuaA0KPj4gQEAg
LTE4NDksNiArMTg0OSw3IEBAIHN0cnVjdCB4aGNpX2hjZCB7DQo+PiAjZGVmaW5lIFhIQ0lfSU5U
RUxfVVNCX1JPTEVfU1cJQklUX1VMTCgzMSkNCj4+ICNkZWZpbmUgWEhDSV9aRVJPXzY0Ql9SRUdT
CUJJVF9VTEwoMzIpDQo+PiAjZGVmaW5lIFhIQ0lfREVGQVVMVF9QTV9SVU5USU1FX0FMTE9XCUJJ
VF9VTEwoMzMpDQo+PiArI2RlZmluZSBYSENJX1NOUFNfQlJPS0VOX1NVU1BFTkQgICAgQklUX1VM
TCgzNCkNCj4gDQo+IFRoaXMgYml0IGlzIGFscmVhZHkgaW4gdXNlIGJ5IGEgYW5vdGhlciBwYXRj
aCwgc28gcGxlYXNlIHVwZGF0ZSBpdHMgdmFsdWUuDQpUaGFua3MgZm9yIGFkZHJlc3NpbmcgIHdl
IHdpbGwgYmUgc2VuZGluZyBwYXRjaCB2My4NCj4gDQo+IEthaS1IZW5nDQo+IA0KPj4NCj4+IAl1
bnNpZ25lZCBpbnQJCW51bV9hY3RpdmVfZXBzOw0KPj4gCXVuc2lnbmVkIGludAkJbGltaXRfYWN0
aXZlX2VwczsNCj4+IEBAIC0xODc4LDYgKzE4NzksOCBAQCBzdHJ1Y3QgeGhjaV9oY2Qgew0KPj4g
CXZvaWQJCQkqZGJjOw0KPj4gCS8qIHBsYXRmb3JtLXNwZWNpZmljIGRhdGEgLS0gbXVzdCBjb21l
IGxhc3QgKi8NCj4+IAl1bnNpZ25lZCBsb25nCQlwcml2WzBdIF9fYWxpZ25lZChzaXplb2YoczY0
KSk7DQo+PiArCS8qIEJyb2tlbiBTdXNwZW5kIGZsYWcgZm9yIFNOUFMgU3VzcGVuZCByZXN1bWUg
aXNzdWUgKi8NCj4+ICsJdTgJCQlicm9rZW5fc3VzcGVuZDsNCj4+IH07DQo+Pg0KPj4gLyogUGxh
dGZvcm0gc3BlY2lmaWMgb3ZlcnJpZGVzIHRvIGdlbmVyaWMgWEhDSSBoY19kcml2ZXIgb3BzICov
DQo+PiAtLSANCj4+IDIuNy40DQo+Pg0KPiANCg==
