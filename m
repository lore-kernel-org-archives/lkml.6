Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D17ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446742086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="q2ge9051"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446742086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeIXQbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:31:10 -0400
Received: from mail-sn1nam02on0077.outbound.protection.outlook.com ([104.47.36.77]:47808
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbeIXQbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLdxZHEiGsrCoydYScVG97H0DAW26hP6ySeF+vfl+ow=;
 b=q2ge9051it6mBjPdgWc4miob7lEipKueEEEmAQIpag/6noi024MhC7ixETkLZ3N4FZ2w8dWQZcENjxtl2Oa2fp2Jm0lrVN/ihCjPI9+mabCfvUUrDvkWKodqs6WehFcrzeqDqU1egzTpDZMMjggRnaq+L0AoopZH+ZgFB6KE69k=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4522.namprd02.prod.outlook.com (20.176.107.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.20; Mon, 24 Sep 2018 10:29:44 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00%3]) with mapi id 15.20.1164.024; Mon, 24 Sep 2018
 10:29:44 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 4/7] edac: synopsys: Add macro defines for ZynqMP DDRC
Thread-Topic: [PATCH v7 4/7] edac: synopsys: Add macro defines for ZynqMP DDRC
Thread-Index: AQHUTpJVJhR35R778UuTfXoMQwrD4qT/MxIAgAARzwA=
Date:   Mon, 24 Sep 2018 10:29:44 +0000
Message-ID: <DM6PR02MB5227D961C992C3BB6A4421B7C1170@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-5-git-send-email-manish.narani@xilinx.com>
 <20180924092226.GA20187@zn.tnic>
In-Reply-To: <20180924092226.GA20187@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4522;6:jeSKw4xUzibA6JGq3H1oM7a4xH+1iH+g5als9AvQRJsqi0NS6EmCVQ2KaTEG22bSWu3F8b77pXs7yy4XEsaUk0i32tRnyBke8hpTLEwhrm248VMJwonVGd+y5p63j66iWTcK9fCAQYrNNIHarcCes6dPExXEixseSnuYaE0GFNej9zVB6k8IvA5HjQkjZ3vEf+aLByxhOT+k7+BIo4M7dpEUvD+n3Cc8eZaPmwn/XgrWBLhuhG6ye76rlNz6L+WJkLPcr9FE2go61ZsAS9z87bnZX5281l6sAhbMMdbNGIdbfsSqW2jSxkNRWwE3c+3gFf5ueCLJSF+lqKm0TS+Yu//9TvfFLZF2t30HjxFC1op82ZXerLDniEvl5/Ze7gY2zkPv/DOnJiJTu/efI+f8AmxuYEa6miVBcebxpjfp553VT6vw+rPBDmAHk0yjWNSRvUTyQR5eI3U7TsYgvAGpoA==;5:HZgEFAL2CP5N9ZI7evYZhSA61dYiul/zyplTkpvh5hPvOQCZL4t6Y2nyxdiWI4NEe49WGCH7Eo+zPRZPJqAQeg58DNvoM6njPluWFpHgqz0c07hEddumo6qngys4VW41sFuKM8kMo0wzBvSD9i478T0Nyyi5scvdtVtG+3fe4y8=;7:7SBKdIIiekA56mBVkflfzPVm68B4TDocmDFJ4gQoryneMpaFz1thrcZEiHylcOLX96ok2IZr+JQvlitAMh5qx1P/HUTXtV4GbC0l/pCNBv0njz0zxtZBGMl+DgMN/UWgFUEWZQRX1THYIofxrfha6D8SN5hCJQ5UPjAL1/qaox+6okooipH/puj0U86Kyd6Jiyt/Fh7k+ankISwaOeTSYbouJ7A7l4W8wxJYmvKL0bLvMNNkCASmGXbQXwJchsVM
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(51914003)(199004)(189003)(13464003)(14454004)(3846002)(5660300001)(305945005)(316002)(81156014)(81166006)(8676002)(105586002)(53546011)(2906002)(6506007)(8936002)(106356001)(7416002)(74316002)(7696005)(53936002)(66066001)(6116002)(478600001)(33656002)(55016002)(7736002)(9686003)(6436002)(25786009)(99286004)(71190400001)(5250100002)(71200400001)(68736007)(229853002)(72206003)(446003)(6246003)(86362001)(54906003)(476003)(11346002)(97736004)(4326008)(6916009)(186003)(2900100001)(26005)(486006)(76176011)(102836004)(575784001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4522;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 3dfe6fd2-edee-4b3f-8f9f-08d62208a51b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4522;
x-ms-traffictypediagnostic: DM6PR02MB4522:
x-microsoft-antispam-prvs: <DM6PR02MB4522EB02DCCEA4C064A5FF45C1170@DM6PR02MB4522.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(185117386973197)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:DM6PR02MB4522;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4522;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AtyKr6e97+ED36TB2Ks4qmsiaUKVXvyn6lRMSVfh8t6cYVU8Xl3Xy/RmZ7/sO92N2T5BWx8nQc7UVPGFHO7ZnxFnhxjQ9L6A5+S3UcZuyPOg/u0pH5oxIlk6ACGozrMLsJx4Zz+9Ah6DgTDLu+lxQHZ8RFEs0+YCecFJqRj9+6+XL/ziE45+b9OwD+IxyY+19iHiRyghUfnyDFHt+nDf4YNYulLcWatCe+0RAuGs7ibnL/LWci7QF+j6vBF2Y4QFAJ6RC+C1KTyVQK26jFJdGo44X7x1HxtNzDgk4zcPgJfgjs16HhBOJTlfGDXVtX7R0hXyWtE4YiwP3rl0YKnUS/kiUYb6F/oLPIi0jyAeExw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfe6fd2-edee-4b3f-8f9f-08d62208a51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 10:29:44.3212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4522
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVd
DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI0LCAyMDE4IDI6NTIgUE0NCj4gVG86IE1hbmlz
aCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsg
bWFyay5ydXRsYW5kQGFybS5jb207IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gTWljaGFsIFNpbWVr
IDxtaWNoYWxzQHhpbGlueC5jb20+OyBsZW95YW5nLmxpQG54cC5jb207DQo+IHN1ZGVlcC5ob2xs
YUBhcm0uY29tOyBhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZWRhY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY3IDQvN10gZWRhYzogc3lub3BzeXM6IEFkZCBtYWNybyBkZWZp
bmVzIGZvciBaeW5xTVANCj4gRERSQw0KPiANCj4gT24gTW9uLCBTZXAgMTcsIDIwMTggYXQgMDc6
NTU6MDJQTSArMDUzMCwgTWFuaXNoIE5hcmFuaSB3cm90ZToNCj4gPiBBZGQgbWFjcm8gZGVmaW5l
cyBmb3IgWnlucU1QIEREUiBjb250cm9sbGVyLiBUaGVzZSBtYWNyb3Mgd2lsbCBiZSB1c2VkDQo+
ID4gZm9yIFp5cW5NUCBFQ0Mgb3BlcmF0aW9ucy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1h
bmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYyB8IDE2OA0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2OCBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMu
Yw0KPiA+IGIvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYyBpbmRleCBlYjQ1OGU1Li42YmY3
OTU5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2VkYWMvc3lub3BzeXNfZWRhYy5jDQo+ID4gQEAgLTk3LDYgKzk3LDE3NCBA
QA0KPiA+ICAjZGVmaW5lIFNDUlVCX01PREVfTUFTSwkJMHg3DQo+ID4gICNkZWZpbmUgU0NSVUJf
TU9ERV9TRUNERUQJMHg0DQo+ID4NCj4gPiArLyogRERSIEVDQyBRdWlya3MgKi8NCj4gPiArI2Rl
ZmluZSBERFJfRUNDX0lOVFJfU1VQUE9SVAkJQklUKDApDQo+ID4gKyNkZWZpbmUgRERSX0VDQ19E
QVRBX1BPSVNPTl9TVVBQT1JUCUJJVCgxKQ0KPiANCj4gQWxsIHRob3NlIG5ldyBhZGRpdGlvbnMg
YXJlIG9uZSBjb2x1bW4gZnVydGhlciB0byB0aGUgbGVmdCB0aGFuIHRoZSBvbGQgb25lcy4NCj4g
V2h5Pw0KPiANCj4gSXMgdGhlcmUgc29tZSBzaWduaWZpY2FuY2UgaGVyZSBvciBjYW4gdGhleSBh
bGwgYmUgdmVydGljYWxseSBhbGlnbmVkPw0KU2hvdWxkIEkgaW5jcmVhc2UgdGhlIGFsaWdubWVu
dCBvZiB0aGUgZXhpc3RpbmcgbWFjcm9zIGluIHRoZSAnY29kZSBmb3JtYXR0aW5nJyBwYXRjaGVz
PyBOZXcgbWFjcm9zIHdpbGwgbmVlZCBhbiBpbmNyZWFzZWQgaW5kZW50YXRpb24uDQoNClRoYW5r
cywNCk1hbmlzaA0K
