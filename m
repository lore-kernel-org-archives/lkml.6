Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E85ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDE420693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rD7PrhZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDE420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeIQIjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:39:41 -0400
Received: from mail-sn1nam02on0052.outbound.protection.outlook.com ([104.47.36.52]:50048
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731003AbeIQIjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqmrf7Pfjy7EMX0FYLQekEXlAvkoixajtkycr+LZcaY=;
 b=rD7PrhZrA2ksxN1sIVi4iN51NJ9HOyXx6x+MZuVeXlNrsmcLnVp0fXniajwSdtKAXTemT7rRgpooEyXEPmHfE+MbjjS6JmnKBy2Qv6R4nGIZZz16p1FS6ZqGfKQhmTteJoqDFMyXUpDKD1OqOltmT2k2V5srkvXHVIPrv54amI4=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4166.namprd02.prod.outlook.com (20.176.249.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.13; Mon, 17 Sep 2018 03:14:17 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::80dc:1608:389e:bdd8]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::80dc:1608:389e:bdd8%5]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 03:14:14 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware
 driver
Thread-Topic: [RFC PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware
 driver
Thread-Index: AQHURDUU/MUKhitwSUeoH6B2AiXmtqTzBaqAgADaJCA=
Date:   Mon, 17 Sep 2018 03:14:14 +0000
Message-ID: <BYAPR02MB471039817A37E2583A90FC21C21E0@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
 <1536054754-3119-4-git-send-email-nava.manne@xilinx.com>
 <d9cab203-9637-3233-4b44-96222ba3551c@linaro.org>
In-Reply-To: <d9cab203-9637-3233-4b44-96222ba3551c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [157.47.12.249]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4166;6:/hg4630mkvU05bLgX1/fmZaLVeYF6Gf1I4wHmK8MBRllshbYSeUSsy45jdnvYnMC7iNXV6C/UiqALW1si+D4sUT1o0vXsLLhszA7GNa6SNHeXbf0s4+Er5CKyF/1plQU/6mO75GZDWDQ7cprYiOtWW+xUaYmE4o7BoFFwrfrJsSGSgCKW1PmuOY7Sj+zkby44vJ9uRTnTjAsriMbtAxxS7PDOwvojJuRTWlK6IE8Vu3c4i/M9hGrYlO8DR43pgR5wIr+5IiBlyx3MqXEuHQrTvfYqdw+KXmhOpb8KfmTHDDj8r0gn7plTnJS/izn7x/3IHiuXu23la1wpKmnJZoslTzG6I283zQ8EDfM1v6nRJlCSFhzyWci5kAO63vIkbEnpUp8r4MMLpgK3R2sSVrLJwILGpxkFY90dDlGi4rWfYrs8SNyvVhTInwQIbP/UrU4BflmZepxRq0ODAIbnMJyYg==;5:JwwSVu/N313n6nYfQf/6rdRmgSA87SxfiOUvwlQAgNeBbnZKoC2RIP2MiwnBUfhvUWS8l+uyWks95nL/tGcYoTIQNvTt59u6v2hXds7T5zyTBo0MrCvAQEBTyMhdHVp3S6yxXFXwNePB4youDCpDNd86NYxDJSTM2AEUrJtd51w=;7:j3Nr3cCLhDh8V9dP/zWlZCRh/LujP9nUEc2SvaDCZP6jl6KIifhphSDz5AqMJbU/PlVoD0iipIBTfkGvTVzA/s0246eqXIWzYSSP+8hNlMkh90TcoEVUY1Kwgo23vch8dOBawPOagQg2cHyX6+w7zeVeQ+cqHe0cezio9ChmUhh4l1NAdbukYVpyFCQx+cB9q9UQyoUI0WGjNmB3HiSEvDRf9xo0LrsXaV58sheok2PmaauAt3t/4geqyuc0Oswr
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(13464003)(33656002)(305945005)(6246003)(3846002)(74316002)(5250100002)(105586002)(11346002)(229853002)(446003)(106356001)(7736002)(486006)(316002)(25786009)(6116002)(6436002)(66066001)(110136005)(99286004)(476003)(2501003)(478600001)(8676002)(186003)(68736007)(76176011)(14454004)(9686003)(53936002)(86362001)(2906002)(26005)(53546011)(6506007)(102836004)(8936002)(55016002)(14444005)(217873002)(256004)(81166006)(7696005)(5660300001)(2201001)(2900100001)(81156014)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4166;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 95624639-5dbb-400c-becf-08d61c4ba58c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4166;
x-ms-traffictypediagnostic: BYAPR02MB4166:
x-microsoft-antispam-prvs: <BYAPR02MB4166C3B4919A6E470F7125EFC21E0@BYAPR02MB4166.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR02MB4166;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4166;
x-forefront-prvs: 0798146F16
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IZRkAW1iQ0FLPofL50v5M+H/SytoVIvpEsKCWjaIwZumCeeB3F1gB9TyQIv+9adyiIPOKrxSYzKBbGDzH6lmNQc32tZ/NmTKzS11hUDvegCYEqKZeOjYiHSOWL18B7k7XGAP0LbHTYgEZDuSoOVyRk8n/a/jS9A9qhBO27WbkkgDr1N2DKVuqmXVc90Y1UulimvQRWiSlBJpDgSPXswNtsqaPgjwXssUrJjxvaVYTCuw1wCnhaObCSIDpSapAJ6kWzthr8YB+wQiG5Sv9gW1tshu9wKe5UrTye1997GaH/VyjDhojvcQGdmah/RkLZWNdh5ivVB5q75kWX86pu5+KOpjtVEAcrfkOZ689P0fllw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95624639-5dbb-400c-becf-08d61c4ba58c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:14:14.3530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3Jpbml2YXMsDQoNCglUaGFuc2tzIGZvciBwcm92aWRpbmcgdGhlIGNvbW1lbnRzLi4NClBs
ZWFzZSBmaW5kIG15IHJlcHNvbmNlIGlubGluZS4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFNyaW5pdmFzIEthbmRhZ2F0bGEgW21haWx0bzpzcmluaXZhcy5rYW5k
YWdhdGxhQGxpbmFyby5vcmddDQo+IFNlbnQ6IFN1bmRheSwgU2VwdGVtYmVyIDE2LCAyMDE4IDc6
NDEgUE0NCj4gVG86IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT47IHJvYmgr
ZHRAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IE1pY2hhbCBTaW1layA8bWlj
aGFsc0B4aWxpbnguY29tPjsgUmFqYW4gVmFqYQ0KPiA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xs
eSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYyIDMvM10gbnZtZW06
IHp5bnFtcDogQWRkZWQgenlucW1wIG52bWVtDQo+IGZpcm13YXJlIGRyaXZlcg0KPiANCj4gRmV3
IG1pbm9yIE5pdHMuLi4NCj4gDQo+IEkgcmVtZW1iZXIgYXNraW5nIGFib3V0IHRoaXMgaW4gdGhl
IGxhc3QgcmV2aWV3IQ0KPiANCj4gT24gMDQvMDkvMTggMTA6NTIsIE5hdmEga2lzaG9yZSBNYW5u
ZSB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgenlucW1wIG52bWVtIGZpcm13YXJlIGRyaXZl
ciB0byBhY2Nlc3MgdGhlIFNvQw0KPiA+IHJldmlzaW9uIGluZm9ybWF0aW9uIGZyb20gdGhlIGhh
cmR3YXJlIHJlZ2lzdGVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmF2YSBraXNob3JlIE1h
bm5lIDxuYXZhLm1hbm5lQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZW0venlucW1wX252bWVtLmMNCj4gPiBiL2RyaXZlcnMvbnZtZW0venlucW1wX252
bWVtLmMgbmV3IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXgNCj4gPiAwMDAwMDAwLi5lMzc3OTAwDQo+
ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbnZtZW0venlucW1wX252bWVtLmMN
Cj4gPiBAQCAtMCwwICsxLDg0IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wKw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggWGlsaW54LCBJbmMu
DQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvbnZtZW0tcHJvdmlkZXIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29m
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L2Zpcm13YXJlL3hsbngtenlucW1wLmg+DQo+ID4gKw0KPiA+ICsjZGVmaW5lIFNJ
TElDT05fUkVWSVNJT05fTUFTSyAweEYNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgenlucW1wX252
bWVtX3JlYWQodm9pZCAqY29udGV4dCwgdW5zaWduZWQgaW50IG9mZnNldCwNCj4gPiArCQkJICAg
ICB2b2lkICp2YWwsIHNpemVfdCBieXRlcykNCj4gPiArew0KPiA+ICsJaW50IHJldDsNCj4gPiAr
CWludCBpZGNvZGUsIHZlcnNpb247DQo+ID4gKwljb25zdCBzdHJ1Y3QgenlucW1wX2VlbWlfb3Bz
ICplZW1pX29wcyA9DQo+IHp5bnFtcF9wbV9nZXRfZWVtaV9vcHMoKTsNCj4gPiArDQo+ID4gKwlp
ZiAoIWVlbWlfb3BzIHx8ICFlZW1pX29wcy0+Z2V0X2NoaXBpZCkNCj4gPiArCQlyZXR1cm4gLUVO
WElPOw0KPiA+ICsNCj4gPiArCXJldCA9IGVlbWlfb3BzLT5nZXRfY2hpcGlkKCZpZGNvZGUsICZ2
ZXJzaW9uKTsNCj4gPiArCWlmIChyZXQgPCAwKQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICsJcHJfZGVidWcoIlJlYWQgY2hpcGlkIHZhbCAleCAleFxuIiwgaWRjb2RlLCB2ZXJzaW9u
KTsNCj4gPiArCSooaW50ICopdmFsID0gdmVyc2lvbiAmIFNJTElDT05fUkVWSVNJT05fTUFTSzsN
Cj4gDQo+IFVzZSBkZXZfZGJnIGhlcmUuDQoNCldpbGwgZml4IGluIHRoZSBuZXh0IHZlcnNpb24u
Lg0KDQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBz
dHJ1Y3QgbnZtZW1fY29uZmlnIGVjb25maWcgPSB7DQo+ID4gKwkubmFtZSA9ICJ6eW5xbXAtbnZt
ZW0iLA0KPiA+ICsJLm93bmVyID0gVEhJU19NT0RVTEUsDQo+ID4gKwkud29yZF9zaXplID0gMSwN
Cj4gPiArCS5zaXplID0gMSwNCj4gPiArCS5yZWFkX29ubHkgPSB0cnVlLA0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgenlucW1wX252bWVtX21h
dGNoW10gPSB7DQo+ID4gKwl7IC5jb21wYXRpYmxlID0gInhsbngsenlucW1wLW52bWVtLWZ3Iiwg
fSwNCj4gPiArCXsgLyogc2VudGluZWwgKi8gfSwNCj4gPiArfTsNCj4gPiArTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgenlucW1wX252bWVtX21hdGNoKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQg
enlucW1wX252bWVtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiAr
CXN0cnVjdCBudm1lbV9kZXZpY2UgKm52bWVtOw0KPiA+ICsNCj4gPiArCWVjb25maWcuZGV2ID0g
JnBkZXYtPmRldjsNCj4gPiArCWVjb25maWcucmVnX3JlYWQgPSB6eW5xbXBfbnZtZW1fcmVhZDsN
Cj4gPiArDQo+ID4gKwludm1lbSA9IG52bWVtX3JlZ2lzdGVyKCZlY29uZmlnKTsNCj4gWW91IGNh
biB1c2UgZGV2bV8gdmFyaWFudCBhbmQgcmVtb3ZlIHRoZSB6eW5xbXBfbnZtZW1fcmVtb3ZlKCkg
dG90YWxseQ0KPiANCldpbGwgZml4IGluIHRoZSBuZXh0IHZlcnNpb24uLi4NCg0KUmVnYXJkcywN
Ck5hdmFraXNob3JlLg0K
