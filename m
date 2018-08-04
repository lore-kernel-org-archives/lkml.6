Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A71FC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 06:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5A5217B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 06:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xCTLLEJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5A5217B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeHDIJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 04:09:23 -0400
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:65516
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbeHDIJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 04:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff2X5AoHGccSHV7dlxa8uEhIkc5AF6O/peGZERv43YU=;
 b=xCTLLEJ2mZV4RPeV6/otVauvJRBSnx6/xdpwhnjrjLIPXxycYRr3vYPr11Jq6J7+CuChukR1FWR8kmM8MBiiX1lPItloHumMJNxndvidixieL3Sr+Z3PmRCwTD3KkyLIZIhp6vFf7l0jlLiN2SGj9lBjpRNLOm8GScgkEHTxg8g=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB5200.namprd02.prod.outlook.com (52.135.103.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Sat, 4 Aug 2018 06:09:48 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7%5]) with mapi id 15.20.1017.010; Sat, 4 Aug 2018
 06:09:43 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        Edgar Iglesias <edgari@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "stefan.krsmanovic@aggios.com" <stefan.krsmanovic@aggios.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Topic: [PATCH v3 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Index: AQHUKl+flMR2sgxPqE25ti4IKgf2YKSvEIqAgAAI//A=
Date:   Sat, 4 Aug 2018 06:09:43 +0000
Message-ID: <SN6PR02MB4959EC485CE2A59827C56D45C1220@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
 <1533214282-9977-2-git-send-email-manish.narani@xilinx.com>
 <20180804051857.GA3843@nazgul.tnic>
In-Reply-To: <20180804051857.GA3843@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB5200;6:Qm1QMYXvrgFmPcYFpnLoMLyz1XX/qf2p79VbrTyCgjOSuKGDl+4+A5KS0qBUNVRelaFEfyOnUR6RexPgCDLYX3+O9A3cUaFbH8/g4EzAv+TwmUf5GOQUj6Ubn8KI/p0FXDA1u8LIoOxzc+KJXuybqxF+ohF14ezH61pfzwVIxp2eDcqeaArkzd1ej5iuQ+X1a3F7Boo5Yf21LYBe7VcMbZuZa4I4uIj1UUwrHCcF28egi0ZE7JG/RieApliRoQ1I4M2tLWkasGaj83LkNSTC96G3hzyGyH5RNJChqb1v+UoiLWxKgvZhvBwW8mX0cnYrtd6Hfr+uPTn5NRLiO0zBgwMfTfl91N7y0yfPD3JhyE/JBhrl1/mJDLMSGUJLtotnOW+osewlEGXEVqjSQALExELVQN9qeFoPZZ2gk4TXqsuvrdq7T25PEImkh0cN07gttZic3kHWvgx6wLJJdQMR4g==;5:ENjnmz3ScQkrAQE/uIXxoQ9Ge5M7xtJyHg7xItlgTEUwo3mPnVcbNrdioVPkkttH2rMoK60JkpB55lgUYlpQ5SPWlrCFrXwjb37IKLrfxv7jJxpf9CsCX0/5bo2zLJhgRqxwcgly+vp0KDr4EnAzKwxhTUiKfKXXMvJ6+u+1VR4=;7:sIclfdhvBqYWrVJxiqfiBsp3qMVhhg46s512SXzvXrZcxeiMYhLp+ORqR8iouq7S7PaZtNB4Y/tntmCwETYL639Y7e1UMkidXE2GmqyRilq3n7UI1FNIksrYtZzlahjsAm0SfzqI+/4sfuAVUhYrcOrkYlo5E35GwG4VWUr8e+iEuhciCg4MCP8ubfmxNaum5vpLc2MlZ/NyGi8f8n0nw55aE+beqOKaIaJDWmkjA2Wju6xK3Wl2A0HzN7EPm5dY
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: b1f4eedf-9d5d-448b-eb46-08d5f9d0df68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB5200;
x-ms-traffictypediagnostic: SN6PR02MB5200:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB52000F00DA547E6C91CF0BB4C1220@SN6PR02MB5200.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB5200;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5200;
x-forefront-prvs: 0754F7E325
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(13464003)(7416002)(8676002)(81156014)(256004)(229853002)(6116002)(14444005)(7696005)(81166006)(53936002)(76176011)(68736007)(66066001)(55016002)(305945005)(86362001)(8936002)(6916009)(97736004)(74316002)(7736002)(9686003)(6436002)(3846002)(5660300001)(486006)(14454004)(25786009)(2906002)(53546011)(6506007)(6246003)(478600001)(72206003)(4326008)(2900100001)(476003)(316002)(186003)(26005)(5250100002)(446003)(11346002)(54906003)(102836004)(106356001)(99286004)(105586002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5200;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rmaisIOxXP6EJl94b8bsDfnY4ZKUFMmHcxDJw0DLLjcSlFCDjqVuSw8rKNrTkzx1RXNt3Np29ZDYpk1pDt3FcGgfblJT4fBhpMp3drQrP29+qtpaz+byVICryUI99CaM3KIZ7Rm81Ztkoj5StRUjRYle4tzY2NDqiZNWWEbFJ1x9FwLNCXB23sRK5G2rJ5nLFSxBKOtfz41FOojlgrwINpiKlPyD2g3iQPZW/n2lgrImMCo7VRpGkK4020ErXQtbYi3uyIedZOzwnqTEKHmhOei9dYTD/TZdOCAInad0SiHS0lb6wgbMDYK809yE6xwptQ9CO7dC0CdZnnAGI4ta6PpvT1Yf4hqHsfWZLSq6qkI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f4eedf-9d5d-448b-eb46-08d5f9d0df68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2018 06:09:43.6960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jp
c2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1
c3QgNCwgMjAxOCAxMDo0OSBBTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNF0gZWRhYzog
c3lucHM6IEFkZCBwbGF0Zm9ybSBzcGVjaWZpYyBzdHJ1Y3R1cmVzIGZvcg0KPiBkZHJjIGNvbnRy
b2xsZXINCj4gDQo+IE9uIFRodSwgQXVnIDAyLCAyMDE4IGF0IDA2OjIxOjE5UE0gKzA1MzAsIE1h
bmlzaCBOYXJhbmkgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIHBsYXRmb3JtIHNwZWNpZmlj
IHN0cnVjdHVyZXMsIHNvIHRoYXQgd2UgY2FuIGFkZA0KPiANCj4gIlRoaXMgcGF0Y2giIGluIGEg
Y29tbWl0IG1lc3NhZ2UgaXMgdGF1dG9sb2dpY2FsbHkgcmVkdW5kYW50Lg0KT2theS4gSSB3aWxs
IHVwZGF0ZSB0aGlzIGluIHY0Lg0KDQo+IA0KPiA+IGRpZmZlcmVudCBJUCBzdXBwb3J0IGxhdGVy
IHVzaW5nIHF1aXJrcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmlzaCBOYXJhbmkgPG1h
bmlzaC5uYXJhbmlAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9lZGFjL3N5bm9w
c3lzX2VkYWMuYyB8IDY0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDExIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFj
LmMNCj4gPiBiL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMgaW5kZXggMGM5YzU5ZS4uZDQ3
OThlOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2VkYWMvc3lub3BzeXNfZWRhYy5jDQo+ID4g
KysrIGIvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYw0KPiA+IEBAIC0yMiw2ICsyMiw3IEBA
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9lZGFjLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvb2YuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAiZWRhY19tb2R1bGUuaCINCj4g
Pg0KPiA+IEBAIC0xMzAsNiArMTMxLDcgQEAgc3RydWN0IHN5bnBzX2VjY19zdGF0dXMgew0KPiA+
ICAgKiBAYmFzZWFkZHI6CUJhc2UgYWRkcmVzcyBvZiB0aGUgRERSIGNvbnRyb2xsZXINCj4gPiAg
ICogQG1lc3NhZ2U6CUJ1ZmZlciBmb3IgZnJhbWluZyB0aGUgZXZlbnQgc3BlY2lmaWMgaW5mbw0K
PiA+ICAgKiBAc3RhdDoJRUNDIHN0YXR1cyBpbmZvcm1hdGlvbg0KPiA+ICsgKiBAcF9kYXRhOglQ
b2ludGVyIHRvIHBsYXRmb3JtIGRhdGENCj4gPiAgICogQGNlX2NudDoJQ29ycmVjdGFibGUgRXJy
b3IgY291bnQNCj4gPiAgICogQHVlX2NudDoJVW5jb3JyZWN0YWJsZSBFcnJvciBjb3VudA0KPiA+
ICAgKi8NCj4gPiBAQCAtMTM3LDExICsxMzksMjkgQEAgc3RydWN0IHN5bnBzX2VkYWNfcHJpdiB7
DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2VhZGRyOw0KPiA+ICAJY2hhciBtZXNzYWdlW1NZTlBT
X0VEQUNfTVNHX1NJWkVdOw0KPiA+ICAJc3RydWN0IHN5bnBzX2VjY19zdGF0dXMgc3RhdDsNCj4g
PiArCWNvbnN0IHN0cnVjdCBzeW5wc19wbGF0Zm9ybV9kYXRhICpwX2RhdGE7DQo+ID4gIAl1MzIg
Y2VfY250Ow0KPiA+ICAJdTMyIHVlX2NudDsNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKioNCj4gPiAr
ICogc3RydWN0IHN5bnBzX3BsYXRmb3JtX2RhdGEgLSAgc3lucHMgcGxhdGZvcm0gZGF0YSBzdHJ1
Y3R1cmUNCj4gPiArICogQHN5bnBzX2VkYWNfZ2V0ZXJyb3JfaW5mbzoJZnVuY3Rpb24gcG9pbnRl
ciB0byBzeW5wcyBlZGFjIGVycm9yDQo+IGluZm8NCj4gPiArICogQHN5bnBzX2VkYWNfZ2V0X210
eXBlOglmdW5jdGlvbiBwb2ludGVyIHRvIHN5bnBzIGVkYWMgbXR5cGUNCj4gPiArICogQHN5bnBz
X2VkYWNfZ2V0X2R0eXBlOglmdW5jdGlvbiBwb2ludGVyIHRvIHN5bnBzIGVkYWMgZHR5cGUNCj4g
PiArICogQHN5bnBzX2VkYWNfZ2V0X2VjY3N0YXRlOglmdW5jdGlvbiBwb2ludGVyIHRvIHN5bnBz
IGVkYWMgZWNjc3RhdGUNCj4gPiArICogQHF1aXJrczoJCQl0byBkaWZmZXJlbnRpYXRlIElQcw0K
PiA+ICsgKi8NCj4gPiArc3RydWN0IHN5bnBzX3BsYXRmb3JtX2RhdGEgew0KPiA+ICsJaW50ICgq
c3lucHNfZWRhY19nZXRlcnJvcl9pbmZvKSh2b2lkIF9faW9tZW0gKmJhc2UsDQo+ID4gKwkJCQkJ
c3RydWN0IHN5bnBzX2VjY19zdGF0dXMgKnApOw0KPiA+ICsJZW51bSBtZW1fdHlwZSAoKnN5bnBz
X2VkYWNfZ2V0X210eXBlKShjb25zdCB2b2lkIF9faW9tZW0NCj4gKmJhc2UpOw0KPiA+ICsJZW51
bSBkZXZfdHlwZSAoKnN5bnBzX2VkYWNfZ2V0X2R0eXBlKShjb25zdCB2b2lkIF9faW9tZW0gKmJh
c2UpOw0KPiA+ICsJYm9vbCAoKnN5bnBzX2VkYWNfZ2V0X2VjY3N0YXRlKSh2b2lkIF9faW9tZW0g
KmJhc2UpOw0KPiA+ICsJaW50IHF1aXJrczsNCj4gPiArfTsNCj4gPiArDQo+ID4gKy8qKg0KPiA+
ICAgKiBzeW5wc19lZGFjX2dldGVycm9yX2luZm8gLSBHZXQgdGhlIGN1cnJlbnQgZWNjIGVycm9y
IGluZm8NCj4gPiAgICogQGJhc2U6CVBvaW50ZXIgdG8gdGhlIGJhc2UgYWRkcmVzcyBvZiB0aGUg
ZGRyIG1lbW9yeSBjb250cm9sbGVyDQo+ID4gICAqIEBwOgkJUG9pbnRlciB0byB0aGUgc3lub3Bz
eXMgZWNjIHN0YXR1cyBzdHJ1Y3R1cmUNCj4gPiBAQCAtMjQyLDcgKzI2Miw4IEBAIHN0YXRpYyB2
b2lkIHN5bnBzX2VkYWNfY2hlY2soc3RydWN0IG1lbV9jdGxfaW5mbw0KPiAqbWNpKQ0KPiA+ICAJ
c3RydWN0IHN5bnBzX2VkYWNfcHJpdiAqcHJpdiA9IG1jaS0+cHZ0X2luZm87DQo+ID4gIAlpbnQg
c3RhdHVzOw0KPiA+DQo+ID4gLQlzdGF0dXMgPSBzeW5wc19lZGFjX2dldGVycm9yX2luZm8ocHJp
di0+YmFzZWFkZHIsICZwcml2LT5zdGF0KTsNCj4gPiArCXN0YXR1cyA9IHByaXYtPnBfZGF0YS0+
c3lucHNfZWRhY19nZXRlcnJvcl9pbmZvKHByaXYtPmJhc2VhZGRyLA0KPiA+ICsJCQkJCQkJJnBy
aXYtPnN0YXQpOw0KPiANCj4gVW5uZWNlc3NhcmlseSBsb25nIGxpbmUgLSBzaG9ydGVuaW5nIGJ5
IHJlbmFtaW5nIG1pZ2h0IGhlbHAuDQpGYWlyIE9uZS4gSSB3aWxsIGxvb2sgdG8gY2hhbmdlIHRo
ZSBuYW1lLiBBbHNvLCBNYXkgYmUgSSBjb3VsZCB1c2Ugb25seSAncHJpdicgYXMgYXJndW1lbnQg
YW5kIGV4dHJhY3QvdXNlICdiYXNlYWRkcicgYW5kICdzdGF0JyBpbiB0aGUgZnVuY3Rpb24gZGVm
aW5pdGlvbiBpdHNlbGYuDQoNCj4gDQo+ID4gQEAgLTM3MiwxMCArMzkzLDEyIEBAIHN0YXRpYyBp
bnQgc3lucHNfZWRhY19pbml0X2Nzcm93cyhzdHJ1Y3QNCj4gbWVtX2N0bF9pbmZvICptY2kpDQo+
ID4gIAkJZm9yIChqID0gMDsgaiA8IGNzaS0+bnJfY2hhbm5lbHM7IGorKykgew0KPiA+ICAJCQlk
aW1tICAgICAgICAgICAgPSBjc2ktPmNoYW5uZWxzW2pdLT5kaW1tOw0KPiA+ICAJCQlkaW1tLT5l
ZGFjX21vZGUgPSBFREFDX0ZMQUdfU0VDREVEOw0KPiA+IC0JCQlkaW1tLT5tdHlwZSAgICAgPSBz
eW5wc19lZGFjX2dldF9tdHlwZShwcml2LQ0KPiA+YmFzZWFkZHIpOw0KPiA+ICsJCQlkaW1tLT5t
dHlwZSAgICAgPSBwcml2LT5wX2RhdGEtDQo+ID5zeW5wc19lZGFjX2dldF9tdHlwZSgNCj4gPiAr
CQkJCQkJcHJpdi0+YmFzZWFkZHIpOw0KPiANCj4gRGl0dG8gLSB0aGF0IHRyYWlsaW5nIG9wZW5p
bmcgYnJhY2UgYXQgdGhlIGVuZCBpcyBqdXN0IHl1Y2t5LiBTaG9ydGVuIGl0IGFuZCBsZXQgaXMN
Cj4gc3RpY2sgb3V0IGV2ZW4gaWYgaXQgbG9uZ2VyIHRoYW4gODAgY29scy4NCk9rYXkuIFdpbGwg
bW9kaWZ5IGl0Lg0KDQo+IA0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3lucHNfcGxh
dGZvcm1fZGF0YSB6eW5xX2VkYWNfZGVmID0gew0KPiA+ICsJLnN5bnBzX2VkYWNfZ2V0ZXJyb3Jf
aW5mbwk9IHN5bnBzX2VkYWNfZ2V0ZXJyb3JfaW5mbywNCj4gPiArCS5zeW5wc19lZGFjX2dldF9t
dHlwZQkJPSBzeW5wc19lZGFjX2dldF9tdHlwZSwNCj4gPiArCS5zeW5wc19lZGFjX2dldF9kdHlw
ZQkJPSBzeW5wc19lZGFjX2dldF9kdHlwZSwNCj4gPiArCS5zeW5wc19lZGFjX2dldF9lY2NzdGF0
ZQk9IHN5bnBzX2VkYWNfZ2V0X2VjY3N0YXRlLA0KPiA+ICsJLnF1aXJrcwkJCQk9IDAsDQo+IA0K
PiBEcm9wIHRoZSAic3lucHNfIiBwcmVmaXggZnJvbSB0aGUgZnVuY3Rpb24gcG9pbnRlciBuYW1l
cyBhbmQgbGVhdmUgdGhlbSBpbg0KPiB0aGUgYWN0dWFsIGZ1bmN0aW9uIG5hbWVzIHNvIHRoYXQg
d2hlbiBvbmUgbG9va3MgYXQgdGhlIGNvZGUsIGtub3dzIHdoYXQgaXMNCj4gd2hhdC4NCk9rYXku
IEkgd2lsbCBjb3JyZWN0IGl0IGluIHY0Lg0KDQpUaGFua3MsDQpNYW5pc2ggTmFyYW5pDQo=
