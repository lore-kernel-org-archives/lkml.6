Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE77BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62601206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p9sEOl2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62601206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeIEOCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:02:00 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:10992
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeIEOB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiVE+Xn5ao6rbHRD+5by2POXDvxE9MMQt8Ww4Ro/hG8=;
 b=p9sEOl2O/MQQPQmbBF/2hi38C7Z+fBAVOqhobwbJq/q4NMpP+9o+MJrJN6PkF2uTAaBvxpKsuSn8L0TRrxnMtUpsDAms96sAr4vUVtNc9mfliKllwR99z3eSpRkx4hoxkDvKC5e1Y3IKzZdSd2kj9nh/CTaDQ5CthdngoW3w3vk=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0900.namprd02.prod.outlook.com (10.160.154.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Wed, 5 Sep 2018 09:32:31 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 09:32:23 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        "kishon@ti.com" <kishon@ti.com>, Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Thread-Topic: [PATCH v2 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Thread-Index: AQHUQ3+hy27VgXpO6k27IQcF4RWjjKThZmqAgAAHxxA=
Date:   Wed, 5 Sep 2018 09:32:23 +0000
Message-ID: <BN3PR0201MB0993F5B9CAAFB3DF83A200B6A7020@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1535976844-12494-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1535976844-12494-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <2831a270-a4d1-ba51-e13f-85c029bbe8c0@codeaurora.org>
In-Reply-To: <2831a270-a4d1-ba51-e13f-85c029bbe8c0@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0900;6:EQBm7Em7vZJqIL5IpjzyK7QAOBlnCM+8j09PDz50TOImT3JTZi9lyuSVGEbEh1vH1XO/qQIZsypNgeloZmXO6u12D9rvhxEIj6uKWboP8lHpr9QVnjM6j3w/2IhjOyzTKG3ics+82CNRiF97X62dKfD5ggTlltWc8T5Ss1MD6sKuo3IMUs2+8yRjIl58SDCKcNwNFE5UW3KrEztXt750QDAsY+WiGoUNfTFV16raxNaHkU78NuLQvEYQ0YZK7ThfX8skwG2aMZMgyKsAA3sN3lRNLT6Oci9xqS2sDGEbq+tl88eLrTum58oW0oh2mZlob9w5RvNCZWXox9pGzpRcVukWatXWbQ1QksVhz0DuDyahSQxefdLes70yf9rn015m7KpMZSOijKO2tRG4guo+6V1mJ7VRaVUQttU5Nlc9EJa1mGLCh/SqEWqxYNm5xmtBubd8mgGYam2XmAE09o+N5Q==;5:KdJwaRbL8GbS5kZmN8qFeVk0MjZZ/mAbmQzvDdPAw2bP8jUi2YNLmu/FK8oIuXMIbEKMzGA4Hllr69DxbRTxB/WG4eUNcKI+NMKUALNeLUjOJdWkgLNnblM+j9JZtfAdQDSmokQum5Rjaca8L4it4RbxrqN+NIfA+XFi7051VmI=;7:HgWAX44ljEjH77a2iGnKDGBhHDn+VrUk7+249xpOmm+TCVH2KNHw1x6rsRSCsfIXY9jBgUBifUI3frCjbKurjg0cWg5nnQYEECCP+JjBue9z6Mq8/p1a9gL0pJKH2E6AATcx0uSgoKgMS1s2tBuo8yw6bt7HQSjqjYPQFRlJtK3/U3i5IMAQkSg+oe5gImucY1Igag8wv0S8k1BnuLZTdXeR62yV1Z9FbqXz8koFW79HFaS4h6P6whmhb1Z++JFY
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: da5e2597-c6e4-404d-aa36-08d613127c37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0900;
x-ms-traffictypediagnostic: BN3PR0201MB0900:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB09001B66373A400E7FCAD34DA7020@BN3PR0201MB0900.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231344)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0201MB0900;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0900;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(2900100001)(3846002)(7736002)(186003)(305945005)(6116002)(5250100002)(2501003)(54906003)(68736007)(74316002)(110136005)(8676002)(2906002)(102836004)(76176011)(6246003)(39060400002)(316002)(7696005)(99286004)(86362001)(105586002)(14454004)(33656002)(14444005)(256004)(25786009)(53936002)(478600001)(5660300001)(66066001)(8936002)(81166006)(81156014)(26005)(55016002)(486006)(4326008)(6506007)(106356001)(446003)(9686003)(476003)(97736004)(6436002)(11346002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0900;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EOQSlUqFH9rIpK3Xp7/Bk54L+Si0Fyd3BoArn9O7ommCvVxDpV9sZIPeHVwre0BBULvUKjNVzoO8VFbNuOVCqPwfq5XAcvS0XLLIe44Peo2gwvqVNpoTz2og5rGpp60qn0Pe+/C9mI+Z1dJritFc2Zhz7DOjSo1bJ+sXiSIzEOP3PeXwJEgw213LURT4rJIIET+DkHSZzVAauAPDr2gNOc2ccvIfVuYgj5kRBL4cX2CGKAfDWAzLOX6TVVROtixQOMdCnxcHmpqWEZDMS/vMNBwcvD/3KlEFcGfd16xYfWlAPcNqX0vbF8SWQhKQf4dQFPd7pclA2sz7txkv6L+GWA8R/zR506n8/mk8kBLuUXQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5e2597-c6e4-404d-aa36-08d613127c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 09:32:23.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml2ZWssDQoNCj4+ICtQaHkgcHJvdmlkZXIgbm9kZQ0KPj4gKz09PT09PT09PT09PT09PT09
DQo+PiArDQo+PiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4+ICstIGNvbXBhdGlibGUJOiBDYW4g
YmUgInhsbngsenlucW1wLXBzZ3RyLXYxLjEiIG9yICJ4bG54LHp5bnFtcC1wc2d0ciINCj4+ICsJ
CSAgInhsbngsenlucW1wLXBzZ3RyLXYxLjEiIGhhcyAieGxueCx0eF90ZXJtaW5hdGlvbl9maXgi
IHJlbW92ZWQNCj5UaGlzIGlzIG5vdCB2ZXJ5IGNsZWFyLiBZb3UgY2FuIHJhdGhlciBtZW50aW9u
IHRoaXMgc3RhdGVtZW50IGZvciB0aGUgcHJvcGVydHkuDQo+ZS5nLiBJbiAieGxueCx0eF90ZXJt
aW5hdGlvbl9maXgiIHlvdSBjYW4gd3JpdGUgLSB0aGlzIGlzIG5vdCByZXF1aXJlZCBmb3IgInhs
bngsenlucW1wLQ0KPnBzZ3RyLXYxLjEuDQo+DQoNClRoYW5rcyBmb3Igc3BlbmRpbmcgeW91ciB0
aW1lIGluIHJldmlld2luZyB0aGlzIHBhdGNoLCAgd2lsbCBjb3JyZWN0IHRoaXMgaW4gdGhlDQpu
ZXh0IHNlcmllcyBvZiBwYXRjaC4NCiANCj4+ICsNCj4+ICstIHJlZyAgICAgICAgICAgOiBBZGRy
ZXNzIGFuZCBsZW5ndGggb2YgcmVnaXN0ZXIgc2V0cyBmb3IgZWFjaCBkZXZpY2UgaW4NCj4+ICsg
ICAgICAgICAgICAgICAgICAicmVnLW5hbWVzIg0KPj4gKw0KPj4gKy0gcmVnLW5hbWVzICAgICA6
IFRoZSBuYW1lcyBvZiB0aGUgcmVnaXN0ZXIgYWRkcmVzc2VzIGNvcnJlc3BvbmRpbmcgdG8gdGhl
DQo+PiArDQo+PiArbGFuZTE6DQo+PiArLSAjcGh5LWNlbGxzCTogU2hvdWxkIGJlIDQNCj4+ICsN
Cj4+ICtsYW5lMjoNCj4+ICstICNwaHktY2VsbHMJOiBTaG91bGQgYmUgNA0KPj4gKw0KPj4gK2xh
bmUzOg0KPj4gKy0gI3BoeS1jZWxscwk6IFNob3VsZCBiZSA0DQo+PiArDQo+PiArRXhhbXBsZToN
Cj4+ICsJc2VyZGVzOiB6eW5xbXBfcGh5QGZkNDAwMDAwIHsNCj4NCj5waHkgaXMgbm90IGp1c3Qg
dGhlIHNlcmRlcy4gQWxzbyBzL3p5bnFtcF9waHkvcGh5DQo+DQo+VGhpcyBjb3VsZCBiZToNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgenlucW1wX3BoeTogcGh5QGZk
NDAwMDAwDQo+DQpUaGFua3MgZm9yIGNvcnJlY3RpbmcsIHdpbGwgZml4IHRoaXMgaW4gbmV4dCBz
ZXJpZXMgb2YgdGhpcyBwYXRjaA0KDQpCZXN0IFJlZ2FyZHMsDQpBbnVyYWcgS3VtYXIgVnVsaXNo
YQ0K
