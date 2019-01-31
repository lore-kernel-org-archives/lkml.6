Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337BDC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3KTbYpOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfAaMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:40:09 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28668 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbfAaMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:40:09 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="24062509"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 05:40:08 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 05:40:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPP5EtC2RQCrxMPpZgCPgEsafF9RMaEPXCNV4k0Kgq0=;
 b=3KTbYpOJkrPkm+SYlr78peKlwZjFHPStQQzCLuTCMS6U50ZI0ALK5D2Om2frjpxky7utX2no7eNkVMlp7ZlqUysnjVwm9sZbVg/YzZqLm9qhoAhtLsf5IEVa1TGtrSCCRGdYbSGQPh7EMPuiwWdETLZSGU5QctBLwGGEvv3DUQY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1779.namprd11.prod.outlook.com (10.175.98.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 12:40:04 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 12:40:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Index: AQHUuK2zcy+YTju2sU2WL87l1ywXpaXJRlGAgAAMeQA=
Date:   Thu, 31 Jan 2019 12:40:04 +0000
Message-ID: <5a91b6b2-0fed-f411-6e96-568e610f15fa@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-10-tudor.ambarus@microchip.com>
 <20190131125504.3eff449d@bbrezillon>
In-Reply-To: <20190131125504.3eff449d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0100.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::26) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1779;6:tyZs/Pu+L6GaLzUI1EeQ2Tc/8Mea7WKW1fu5X4cYn9lK8KDCaNUtoWPr6nkTgnkyxgLXeiYyuXil46OBifhPU5hcIy6hWJ4DD2VdLrXtjxxdGEFOmqgsjv1zGs4zB0hn34sqiqAFpmA7j0Q4pF0vlOZ4bBO1V1kzrtseH8veeZchhQPfG0ZElBA+VwrazMItU3Dm4pBuaaSCClzR14DpaZBnhjqGgW+si/mpfH6LE2wyWYOKsVGUiyCj/yZ+wYkofDfwbHm9xw/Qmqb9mYb2PrgQsnAPRcA7vNQ9p0Lf43CbNV53am59iqqc/zZtcbTq86xyE83qnKpxH1duuEAA8Z0nW+m029Tr9We4gX+gYo0vvfck0jEx7Hm4CPAIh/LR9fHkcYwLZtC3mOF3l/GlZIXUWHxmoYpux7kxVTylMc12cn1FFYDnErAIjwnL6A+E1I7AnxNkhkmt0rmKVvUhPg==;5:VHyvM1gVCB5QGXE3PNtBsCiV9iSM/rz4JTNwcww8AIbWjxF8P0RaXbf5gcDpMFN9JkqO8sdHfaDjaCCDu2GmQ3HykaLE+3D51wVXG7S/iEYxlJFcVreT80lj8qrzF5KPN8DxmGp22K/n/dHxEBk0yjbGQYMxKak2g9lnEZhPqYXZPAPmGkjnmYEWE3IZwpKC1J9wOJlBouoZlKTvh7HxEA==;7:P+eMofd7E2zur1WXvHk8HdwU2q80RHpskM/Oyec2vvp+xkFZ69+YmUKm9baZcVvVTHrDa4eYk7383/ZAOJcGpg0y0jJddfPqVdI2i348XYuCW7wfStsKeWYykIabCH3Qaev1BW9vMVCTJoTdXZ+XrA==
x-ms-office365-filtering-correlation-id: ae864e42-49db-43d0-de75-08d687793964
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1779;
x-ms-traffictypediagnostic: BN6PR11MB1779:
x-microsoft-antispam-prvs: <BN6PR11MB17790526981C6026A0672447F0910@BN6PR11MB1779.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(52116002)(81166006)(6916009)(31696002)(3846002)(8936002)(478600001)(11346002)(54906003)(316002)(476003)(446003)(8676002)(72206003)(76176011)(81156014)(99286004)(6436002)(6116002)(6512007)(86362001)(2616005)(6306002)(53936002)(71190400001)(26005)(71200400001)(7736002)(305945005)(229853002)(31686004)(14454004)(386003)(53546011)(186003)(106356001)(97736004)(966005)(6246003)(66066001)(105586002)(486006)(68736007)(2906002)(36756003)(14444005)(4326008)(25786009)(256004)(6506007)(102836004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1779;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bYFlxlpeN70qVr/LbxfUR5cNfysSc6KXeqzIbOUi8n0N1L3ZgMSLPjbpgbnVzcRzhJdquotqpWnF4ytCaPgV0/3Lnsiet+frcFG2VKR4ZfJdNjXVxJTEUy2uYvt0BmL6q/tzx3MZmgD7qMD06+vGh25vCRlqwLTSkSGcHzp/KYeHzNfFdsE9xAZy4loHmJTz1RafyWzAE880rLOPctw9Q4NWkdjWUHfudacCNzYYZ6VxsJPeN/kK42ilHmzXs1nY3wbPlp+6ADxx/uVkv1pis3RPGZGee1vxl1w6ZoIioRAeByeU63TutFRkiM/z7PMkhbA0U8cgU2ZquGbNH3Cbz+vp7qRow3FJcS2V1C6BH8XAMHLhEBYEZqxaFlWaqDbaIEdJq7BDD6Xca8qQYyMv1/1loT5tJinseJ2UfnF4RDk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D3620EBDEE88C4B8700FAC63CE881D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae864e42-49db-43d0-de75-08d687793964
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:40:02.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1779
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzMxLzIwMTkgMDE6NTUgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
V2VkLCAzMCBKYW4gMjAxOSAxNTowODo0NyArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiArDQo+PiArc3RhdGljIGludCBhdG1lbF9zYW05eDYwX3Fz
cGlfc2V0X2NmZyhzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEsDQo+PiArCQkJCSAgICAgIGNvbnN0IHN0
cnVjdCBzcGlfbWVtX29wICpvcCwNCj4+ICsJCQkJICAgICAgc3RydWN0IGF0bWVsX3FzcGlfY2Zn
ICpjZmcpDQo+PiArew0KPj4gKwlpbnQgcmV0ID0gYXRtZWxfcXNwaV9zZXRfbW9kZShjZmcsIG9w
KTsNCj4+ICsNCj4+ICsJaWYgKHJldCkNCj4+ICsJCXJldHVybiByZXQ7DQo+PiArDQo+PiArCWNm
Zy0+aWNyID0gUVNQSV9JQ1JfSU5TVChvcC0+Y21kLm9wY29kZSk7DQo+PiArDQo+PiArCWlmICgh
b3AtPmFkZHIubmJ5dGVzKSB7DQo+PiArCQljZmctPmlmciB8PSBRU1BJX0lGUl9URlJUWVBfVFJT
RlJfUkVHOw0KPj4gKwkJaWYgKG9wLT5kYXRhLmRpciA9PSBTUElfTUVNX0RBVEFfT1VUKQ0KPj4g
KwkJCWNmZy0+aWZyIHw9IFFTUElfSUZSX0FQQlRGUlRZUF9XUklURTsNCj4+ICsJCWVsc2UNCj4+
ICsJCQljZmctPmlmciB8PSBRU1BJX0lGUl9BUEJURlJUWVBfUkVBRDsNCj4+ICsJfSBlbHNlIHsN
Cj4+ICsJCWNmZy0+aWZyIHw9IFFTUElfSUZSX1RGUlRZUF9UUlNGUl9NRU07DQo+IA0KPiBXaHkg
ZG8geW91IHVzZSBhIE1FTSB0cmFuc2ZlciBoZXJlPyBXaGF0J3MgdGhlIGRpZmZlcmVuY2Ugd2l0
aCBhDQo+IHJlZ3VsYXIgdHJhbnNmZXI/DQoNClFTUElfSUZSX1RGUlRZUF9UUlNGUl9NRU0gbXVz
dCBiZSBzZXQgd2hlbiBvbmUgd2FudHMgdG8gcmVhZC93cml0ZSBpbiB0aGUgc2VyaWFsDQptZW1v
cnksIGFuZCBwYXJ0aWN1bGFybHkgYSBtZW1vcnkgZGF0YS4NCg0KUVNQSV9JRlJfVEZSVFlQX1RS
U0ZSX1JFRyBtdXN0IGJlIHNldCB3aGVuIG9uZSB3YW50cyB0byByZWFkIG9yIHdyaXRlIHRvIHNl
cmlhbA0KbWVtb3J5LCBidXQgbm90IGEgbWVtb3J5IGRhdGEuDQpSZWFkIGV4YW1wbGVzOiBKRURF
Q19JRCBvciBRU1BJX1NSDQpXcml0ZSBleGFtcGxlczogd3JpdGluZyB0aGUgY29uZmlndXJhdGlv
biBvciB0aGUgUVNQSV9TUi4NCg0KRG9lcyB0aGlzIGFuc3dlcnMgeW91ciBxdWVzdGlvbj8NCg0K
PiANCj4+ICsJfQ0KPj4gKw0KPj4gKwkvKiBTZXQgZGF0YSBlbmFibGUgKi8NCj4+ICsJaWYgKG9w
LT5kYXRhLm5ieXRlcykNCj4+ICsJCWNmZy0+aWZyIHw9IFFTUElfSUZSX0RBVEFFTjsNCj4+ICsN
Cj4+ICsJcmV0ID0gYXRtZWxfcXNwaV9zZXRfYWRkcmVzc19tb2RlKGNmZywgb3ApOw0KPj4gKwlp
ZiAocmV0KQ0KPj4gKwkJcmV0dXJuIHJldDsNCj4+ICANCj4+ICAJLyogQ2xlYXIgcGVuZGluZyBp
bnRlcnJ1cHRzICovDQo+PiAgCSh2b2lkKWF0bWVsX3FzcGlfcmVhZGwoYXEsIFFTUElfU1IpOw0K
Pj4gIA0KPj4gIAkvKiBTZXQgUVNQSSBJbnN0cnVjdGlvbiBGcmFtZSByZWdpc3RlcnMgKi8NCj4+
IC0JYXRtZWxfcXNwaV93cml0ZWwoYXEsIFFTUElfSUFSLCBpYXIpOw0KPj4gLQlhdG1lbF9xc3Bp
X3dyaXRlbChhcSwgUVNQSV9JQ1IsIGljcik7DQo+PiAtCWF0bWVsX3FzcGlfd3JpdGVsKGFxLCBR
U1BJX0lGUiwgaWZyKTsNCj4+ICsJYXRtZWxfcXNwaV93cml0ZWwoYXEsIFFTUElfSUFSLCBjZmct
Pmlhcik7DQo+PiArCWlmIChvcC0+ZGF0YS5kaXIgPT0gU1BJX01FTV9EQVRBX09VVCkNCj4+ICsJ
CWF0bWVsX3FzcGlfd3JpdGVsKGFxLCBRU1BJX0lDUiwgY2ZnLT5pY3IpOw0KPj4gKwllbHNlDQo+
PiArCQlhdG1lbF9xc3BpX3dyaXRlbChhcSwgUVNQSV9SSUNSLCBjZmctPmljcik7DQo+PiArCWF0
bWVsX3FzcGlfd3JpdGVsKGFxLCBRU1BJX0lGUiwgY2ZnLT5pZnIpOw0KPj4gKw0KPj4gKwlyZXR1
cm4gMDsNCj4+ICt9DQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KPiANCg==
