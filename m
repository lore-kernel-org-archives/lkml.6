Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA18EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1E2208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ndiW9VlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1E2208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966324AbeFOQp4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:45:56 -0400
Received: from mail-by2nam03on0067.outbound.protection.outlook.com ([104.47.42.67]:32160
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966255AbeFOQpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/VTsqVOH4E3xkhHVdUVHgRulcDLVJO+fNt84Qqm9rs=;
 b=ndiW9VlXl3NywZjSpMVhczReuGWKkgtJrBvjgJf/bzEw73utspZ42dziNTDIWN+9sj1kUAcbjK8ayc7zGTuMy0E/z/o6m6ml20Gi7NOUx3RS8wUcG2Kl8i2fJijVwkylM0Hb95u1jGAGhuEf9n/Odltnvuf5KFbCHymyrMZ5jFo=
Received: from BL0PR02MB3747.namprd02.prod.outlook.com (52.132.8.144) by
 BL0PR02MB3841.namprd02.prod.outlook.com (52.132.9.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 15 Jun 2018 16:45:47 +0000
Received: from BL0PR02MB3747.namprd02.prod.outlook.com
 ([fe80::99bb:7300:4f1d:59b3]) by BL0PR02MB3747.namprd02.prod.outlook.com
 ([fe80::99bb:7300:4f1d:59b3%4]) with mapi id 15.20.0841.019; Fri, 15 Jun 2018
 16:45:44 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v8 03/10] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Topic: [PATCH v8 03/10] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Index: AQHUBA10iPG+BA2KQ0mKnzRAp2FpJ6RgORwAgAFPSRA=
Date:   Fri, 15 Jun 2018 16:45:43 +0000
Message-ID: <BL0PR02MB374784B711D2D2AF9773CA6DB87C0@BL0PR02MB3747.namprd02.prod.outlook.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
 <1529000862-11510-4-git-send-email-jollys@xilinx.com>
 <3044c2b9-2268-dfcb-2d45-0117c6f91a8d@infradead.org>
In-Reply-To: <3044c2b9-2268-dfcb-2d45-0117c6f91a8d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB3841;7:2JgSKvTX4gMhQUfqFYyYz3k9P0rqI9nBzC1oFHjOh1B02ZA3r03LNWFhhlQTLWAexJQ/h/znGc3ZlctH61ta545C6LVR68tzmW4nTMcVa7f2IsHhTrsCqIar8RyvsZpMKyGfu+OMAPQDifWrkWp0A0eZYsFcIv3Wdtgd6PfiKuRdJES8ygtaVKnz8HOY98X4QMUHbk487JVPDlyits9oUe5ZcKSfamMKEsGEASgIfc7QGlxAQOQRTMhkjr+qmv5L
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(189003)(13464003)(199004)(2201001)(316002)(486006)(68736007)(6116002)(5660300001)(4326008)(3846002)(7736002)(106356001)(105586002)(25786009)(6436002)(86362001)(55016002)(3660700001)(3280700002)(97736004)(26005)(2906002)(53546011)(8936002)(53936002)(76176011)(72206003)(14454004)(305945005)(9686003)(186003)(99286004)(66066001)(6506007)(8676002)(2900100001)(5250100002)(102836004)(81166006)(33656002)(476003)(81156014)(6246003)(7696005)(446003)(478600001)(229853002)(54906003)(11346002)(7416002)(39060400002)(110136005)(74316002)(2501003)(921003)(217873001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3841;H:BL0PR02MB3747.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dd82aa3-513b-49f1-d049-08d5d2df6ff0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB3841;
x-ms-traffictypediagnostic: BL0PR02MB3841:
x-microsoft-antispam-prvs: <BL0PR02MB38411C07F99A82E203DFDD37B87C0@BL0PR02MB3841.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB3841;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB3841;
x-forefront-prvs: 0704670F76
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TZ5VPULYf4mQFfel90Z30VUvNyDWgSk8gb6wrW+WA3sMIGDMJg4jhOwSNRXooY0NafGeqPztJpXYJZfW/NWP5jKf4vflZnuMo7BSWu0DotFo127Hywjn4KKQOkJyjm0HzXIweeipS/zIRb1SrUiZN/fgvlq9SRH0rxzG3ou8Pf3YSJwKSyufa6QOhzGTrGvV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd82aa3-513b-49f1-d049-08d5d2df6ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 16:45:43.8667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkg
RHVubGFwIFttYWlsdG86cmR1bmxhcEBpbmZyYWRlYWQub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwg
SnVuZSAxNCwgMjAxOCAxOjQ1IFBNDQo+IFRvOiBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNv
bT47IGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc7DQo+IG1pbmdvQGtlcm5lbC5vcmc7IGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnOyBtYXR0QGNvZGVibHVlcHJpbnQuY28udWs7DQo+IHN1ZGVl
cC5ob2xsYUBhcm0uY29tOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsga2Vlc2Nvb2tAY2hyb21pdW0u
b3JnOw0KPiBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tOyBtdHVycXVldHRlQGJheWxpYnJlLmNv
bTsNCj4gc2JveWRAY29kZWF1cm9yYS5vcmc7IG1pY2hhbC5zaW1la0B4aWxpbnguY29tOyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eC1jbGtAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEpvbGx5IFNoYWgNCj4gPEpPTExZU0B4
aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDAzLzEwXSBmaXJtd2FyZTogeGls
aW54OiBBZGQgenlucW1wIElPQ1RMIEFQSSBmb3IgZGV2aWNlDQo+IGNvbnRyb2wNCj4gDQo+IE9u
IDA2LzE0LzIwMTggMTE6MjcgQU0sIEpvbGx5IFNoYWggd3JvdGU6DQo+ID4gRnJvbTogUmFqYW4g
VmFqYSA8cmFqYW52QHhpbGlueC5jb20+DQo+ID4NCj4gPiBBZGQgWnlucU1QIGZpcm13YXJlIElP
Q1RMIEFQSSB0byBjb250cm9sIGFuZCBjb25maWd1cmUgZGV2aWNlcyBsaWtlDQo+ID4gUExMcywg
U0QsIEdlbSwgZXRjLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFqYW4gVmFqYSA8cmFqYW52
QHhpbGlueC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9sbHkgU2hhaCA8am9sbHlzQHhpbGlu
eC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jICAg
ICB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvZmlybXdhcmUv
eGxueC16eW5xbXAuaCB8ICAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gSGksDQo+IA0KPiBEb2VzIHRoaXMgZHJpdmVyIGNsYWltIChpbXBsZW1lbnQp
IHNvbWUgc3BlY2lmaWMgaW9jdGwgY29kZSBvciBJRD8NCj4gDQo+IElmIHNvLCBpdHMgaW9jdGwg
bnVtYmVycyBzaG91bGQgYmUgZG9jdW1lbnRlZCBpbiBEb2N1bWVudGF0aW9uL2lvY3RsL2lvY3Rs
LQ0KPiBudW1iZXIudHh0Lg0KPiANCg0KVGhpcyBpcyBub3Qgc3lzdGVtIElPQ1RMLiBUaGlzIGlz
IHBhcmFtZXRlciB0byBaeW5xTVAgc3BlY2lmaWMgQVBJLg0KDQpUaGFua3MsDQpKb2xseSBTaGFo
DQoNCj4gdGhhbmtzLA0KPiAtLQ0KPiB+UmFuZHkNCg==
