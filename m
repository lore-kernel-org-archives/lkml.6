Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770ABECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8642064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bTPr494u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8642064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbeGQUf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:35:57 -0400
Received: from mail-dm3nam03on0063.outbound.protection.outlook.com ([104.47.41.63]:19748
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729728AbeGQUf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTIu7+DscadY40BAQ+Xz4LOcxt4h2HZ9gsEuzZHtbxg=;
 b=bTPr494uQCBBpvvUQYsz0P08BR8afEi7L4itZaZuiwqFz04oCHeIh757o2n1fiSS7VzHKJAQu8tbZbbRkE8ostvbFjeuv+EAMHyGkOqID7AluVxmjTbvfOSNGemG92JqeiKPYq8+iuh2FUHf/aCVBD5XrQKAoo772Cc4j+4mM/c=
Received: from SN1PR02MB3758.namprd02.prod.outlook.com (52.132.200.144) by
 SN1PR02MB3789.namprd02.prod.outlook.com (52.132.200.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 20:01:42 +0000
Received: from SN1PR02MB3758.namprd02.prod.outlook.com
 ([fe80::65b3:44a4:cfbe:43d4]) by SN1PR02MB3758.namprd02.prod.outlook.com
 ([fe80::65b3:44a4:cfbe:43d4%2]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 20:01:40 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Michal Simek <michals@xilinx.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v9 07/10] firmware: xilinx: Add debugfs for IOCTL API
Thread-Topic: [PATCH v9 07/10] firmware: xilinx: Add debugfs for IOCTL API
Thread-Index: AQHUCL3uFXsLxrv5+EaJlNB0U3MY8aSGehQAgA2GJBA=
Date:   Tue, 17 Jul 2018 20:01:40 +0000
Message-ID: <SN1PR02MB3758432C38CC9580BC96182DB85C0@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-8-git-send-email-jollys@xilinx.com>
 <153111415833.143105.8701882244160397855@swboyd.mtv.corp.google.com>
In-Reply-To: <153111415833.143105.8701882244160397855@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3789;7:i6xfozcEBdhdtzcxQ0jyTcsuutnA0OwtZY9LeoTRBI9tVq+PO+2nnTwChGMpKMryRvO2JMrkShXK0+kgky5jUql8pH0Rk+yCIBmbLltsSWMu4neEhTc/HN+M2+6TSa9ss0CK9/w+mqyOKLTYLA2oVEEhX7G49f/twtsur6j8Ql9dccXZmgsLlXUHhBtkRuqMdwZ6vR3ioijF092uOnDRBNqZVPpOZiLX6QutXHG9svpxDzW4s/YDpmPIeYBiDpcn
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(13464003)(51914003)(189003)(199004)(97736004)(6116002)(3846002)(14454004)(105586002)(81156014)(81166006)(8676002)(25786009)(106356001)(4326008)(53936002)(6246003)(39060400002)(33656002)(8936002)(72206003)(74316002)(7736002)(2906002)(2201001)(86362001)(305945005)(476003)(2501003)(186003)(446003)(55016002)(9686003)(7416002)(26005)(478600001)(5250100002)(486006)(7696005)(11346002)(110136005)(316002)(54906003)(53546011)(76176011)(6436002)(229853002)(5660300001)(102836004)(2900100001)(6506007)(99286004)(256004)(68736007)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3789;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: e69971f5-e964-4dc0-0483-08d5ec201c6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3789;
x-ms-traffictypediagnostic: SN1PR02MB3789:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-microsoft-antispam-prvs: <SN1PR02MB3789C2FB36475FC2E98716C6B85C0@SN1PR02MB3789.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB3789;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3789;
x-forefront-prvs: 073631BD3D
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V//fxweYpKxBmRMv2YuEw1MtpkwUVDtXrgT3vkb/mdGo/0yG6vqqvJ/4ItEllwM8sonlt6Iic4Pv33xnMPZM4RjsvGpUk3WzV7tmpHaaoJIN691ObTmuBSUTWqUpfv9eJDGfBabTXBgrlwnV+72gXEofVAjPgeQxNcu04BR13J1Z9goiWSGmyDpq+1H57U8c2u+BIlPGnKo222oqFxuDFx0qxcJoBVYNKXPNdP1nodX06jxnOam2s+JSNH70m5M+iOIgG3ZwA95zA029PWipopfj7ajrxNiU3TD3xxr4sKzFjPDbFVelSoURXhA+KgpHJk2LWGkZjBsvspQXN49G1cn4XR/+6524HoDceIpjAIw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69971f5-e964-4dc0-0483-08d5ec201c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 20:01:40.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LA0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gQm95ZCBbbWFpbHRvOnNib3lkQGtlcm5lbC5v
cmddDQo+IFNlbnQ6IFN1bmRheSwgSnVseSAwOCwgMjAxOCAxMDoyOSBQTQ0KPiBUbzogSm9sbHkg
U2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+OyBhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnOw0KPiBk
bWl0cnkudG9yb2tob3ZAZ21haWwuY29tOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4g
aGthbGx3ZWl0MUBnbWFpbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsgbGludXgtY2xrQHZn
ZXIua2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IG1hdHRAY29kZWJsdWVwcmlu
dC5jby51azsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBtaW5nb0BrZXJu
ZWwub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBz
Ym95ZEBjb2RlYXVyb3JhLm9yZzsgc3VkZWVwLmhvbGxhQGFybS5jb20NCj4gQ2M6IFJhamFuIFZh
amEgPFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgSm9sbHkgU2hhaA0KPiA8Sk9MTFlTQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjkgMDcvMTBdIGZpcm13YXJlOiB4aWxpbng6IEFkZCBkZWJ1Z2ZzIGZvciBJT0NU
TCBBUEkNCj4gDQo+IFF1b3RpbmcgSm9sbHkgU2hhaCAoMjAxOC0wNi0yMCAxMDo0MDozMikNCj4g
PiBGcm9tOiBSYWphbiBWYWphIDxyYWphbnZAeGlsaW54LmNvbT4NCj4gPg0KPiA+IEFkZCBkZWJ1
Z2ZzIGZpbGUgdG8gc2V0L2dldCBJT0NUTCB1c2luZyBkZWJ1Z2ZzIGludGVyZmFjZS4NCj4gDQo+
IElPQ1RMcyBhbmQgZGVidWdmcyBhcmVuJ3QgdGhlIHNhbWUgdGhpbmcuIFdoeSBhcmUgdGhlIHR3
byBiZWluZyBtaXhlZA0KPiB0b2dldGhlcj8gSXMgc29tZSBzb3J0IG9mIHVzZXJzcGFjZSBBQkkg
YmVpbmcgY3JlYXRlZCBoZXJlIHRvIGNvbnRyb2wgY2xrcyB3aXRoDQo+IHVzZXJtb2RlIGRyaXZl
cnM/DQoNClRoaXMgaXMgbm90IHN0YW5kYXJkIGlvY3RsLiBUaGlzIGlzIHR5cGUgb2YgWnlucU1Q
IEFQSSBqdXN0IGxpa2Ugb3RoZXIgQVBJcy4gVGhpcyBkZWJ1Z2ZzIGlzIGNyZWF0ZWQgdG8gZGVi
dWcgWnlucU1QIElPQ1RMIEFQSS4NCg0KVGhhbmtzLA0KSm9sbHkgU2hhaA0K
