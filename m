Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC04FC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F71A21797
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="GNH8n9F2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F71A21797
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeHHVSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:18:06 -0400
Received: from mail-eopbgr690108.outbound.protection.outlook.com ([40.107.69.108]:20448
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728134AbeHHVSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejk2Dd7TFR+/pb9UD3IG7KK0ZLJg0GFSBfL6Dyilueg=;
 b=GNH8n9F2XvwBbKEPDJVAVUS1+nF/06inxdHJw/JJotqCdOa2wsQFyeBfLBO0UJSg2npX7TFfEPOtGUp+S/VkiDedcsfzIdUItrWRjVOP7wm7rx8QCZxfI6WA4yXyGseL6uWA0iJ4VzuP1f/yGoLwagjWD7kr+VLYNWoOvBcYTv8=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3611.namprd06.prod.outlook.com (10.167.236.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Wed, 8 Aug 2018 18:57:01 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::7826:5dcc:1625:5e96]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::7826:5dcc:1625:5e96%5]) with mapi id 15.20.1017.019; Wed, 8 Aug 2018
 18:57:01 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Thread-Topic: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Thread-Index: AQHULjuNi8xilneMl06LqiCzbEap/qS0TC+AgADV1gCAAHv5gIAADJYAgAAFa4CAAIa3gA==
Date:   Wed, 8 Aug 2018 18:57:01 +0000
Message-ID: <1533754621.2283.270.camel@impinj.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
         <20180807134121.GA7958@sirena.org.uk>
         <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
         <20180808095025.GB9346@sirena.org.uk>
         <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
         <20180808105451.GE9346@sirena.org.uk>
In-Reply-To: <20180808105451.GE9346@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3611;6:zcyGcoSj4o9x8RO1tqn+HPkfc9LhG5sw2iDCVGi53Wl1zjSIhT1UOMRxyiY1ntk4vFl9Fl0RepJqn10EfcmXDXeOOR+GA2VBPkP6bNpJtj49W415XPuALyhyTYy2NWPg5j0ywYZ17rgfL+V/puKsTgVt9g+1m2MjcZQ+kN2msexkhz6gXXQzSapsLb4GiOZlZVIUeQ9KF16kSNz8nLD8BxxjMHpWMGnt6GBO8XdhGcq/bHUrt99C9hdTFuFY1jwsH3Ic0UkWMmOVbF2+5NYs+Pp01FGLkq6bmlX6LB4mByCUd8KZJUQ06k4rctlNk68Y8dn1BM0rUGcKHoNhGz58RYwO5a6H8+ccXge/0cylk+0vAgadNybcBS3sd4SCJslI4DmKy5QgahoBxPPM7kPLbAhfm7L/2qpFdp8CWXlVAnZ2w27J9nN0XpU6fXdleaC6Sq96XQADkZuAfAO/THQvmg==;5:pwL2jAvIPYoQGG9b6x5yytsOYfem5z63DwpUu4n+oo8LcHdNwoxC7uGop59tP6V/8e+8hx8Cq96jkV0nzogNwigx/gB3IgYduxodJcLuUKo775aXHmXyruOESbzGSUpZcAhUtDyetxxlZ8OUOzFtVYAZTOzXom7zWmRYeUw8jXI=;7:tP5zLa+4aXS9pdob2bVOBO3LcrJriZ75Gt8VYdqJvoeFOClxd68TYgwB8stTorX4B+7TtdeWFTQ61fupYVGiLjRPTjMpi7q1ZAiqnobLuHRcfcy4eS3JD5LTBw9OlWh5fIRgP+qpQHhO35x3rLaXir/igppnuVAOf6sJkVRiYK7/77N3xKZfwL2KwjzdQ7x5+4C9iyC81oXfzgsWUK8ddB9DJSJbHQuxhSuy/wHDSD/Gbg1otnhe9ehMqB+hij7q
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d9635778-b94d-455a-ea1e-08d5fd60b9b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3611;
x-ms-traffictypediagnostic: MWHPR0601MB3611:
x-microsoft-antispam-prvs: <MWHPR0601MB36110FDEBAE644322FA0BD03D3260@MWHPR0601MB3611.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3611;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3611;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(39850400004)(396003)(136003)(376002)(199004)(189003)(6246003)(2906002)(86362001)(76176011)(99286004)(14454004)(105586002)(25786009)(106356001)(2900100001)(316002)(110136005)(39060400002)(4326008)(54906003)(478600001)(5250100002)(93886005)(53936002)(6436002)(103116003)(6512007)(486006)(476003)(2616005)(11346002)(81156014)(305945005)(7736002)(68736007)(7416002)(2501003)(6486002)(3846002)(36756003)(446003)(6116002)(229853002)(8676002)(81166006)(186003)(26005)(97736004)(53546011)(8936002)(6506007)(256004)(5660300001)(66066001)(102836004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3611;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: taYmlcLLv2trqHm1fQNuuPzVonhurSBrHUU5IUShgnDu0nge8f/tkTEOaYIjS7orzlgjZr+lRVgAPULOF3pQjs4Jt404ICRfnwQM59MdqSRK1BePU08D1YKqcCA0xfk5eQo5Z0IUsaOvGM+juMRaBIS3mUKLqlHrKLdacQfr5iNVHFvdkznA+qHpn9lE4XDHXL5/97si0s5DyhcR0PYP/Z8KAEDM7aZ4ZTin/w700ny8Sg6etzezfyNuAY4tYhi0qqX9WPMLI5pZ4JXDmfORYDIIpXK6DPQfVsf/xhSCGkjznafU0uXisbKqt8Fqskg3jKW9cNhm7Rr/PXkIqyfr+6s69nSC8a85LJdybJb4Vk4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D39B6F4479A8E649BD321CD3C0B740B1@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9635778-b94d-455a-ea1e-08d5fd60b9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 18:57:01.6142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTA4IGF0IDExOjU0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIEF1ZyAwOCwgMjAxOCBhdCAwNjozNToyOFBNICswODAwLCBCYW9saW4gV2FuZyB3cm90
ZToNCj4gPiBPbiA4IEF1Z3VzdCAyMDE4IGF0IDE3OjUwLCBNYXJrIEJyb3duIDxicm9vbmllQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gUmlnaHQsIEkgZG9uJ3QgdGhpbmsgd2UgYWRkZWQgdGhp
cyB5ZXQgKGlmIHdlIGRpZCBJIGNhbid0IHNlZQ0KPiA+ID4gaXQpLiAgSSdkDQo+ID4gPiBhZGQg
YSBuZXcgZmllbGQgdG8gc3BpX3RyYW5zZmVyIGZvciB0aGlzLCB0aGVuIG90aGVyIGNvbnRyb2xs
ZXJzDQo+ID4gPiB3aXRoDQo+ID4gPiB0aGUgc2FtZSBzdXBwb3J0IGNhbiBpbXBsZW1lbnQgaXQg
YXMgd2VsbCBhbmQgZHJpdmVycyBjYW4gc3RhcnQNCj4gPiA+IHVzaW5nDQo+ID4gPiBpdCB0b28u
DQo+ID4gT0suIFNvIEkgd2lsbCBuYW1lIHRoZSBuZXcgZmlsZWQgYXMgJ3dvcmRfZGVsYXknLCBp
cyBpdCBPSyBmb3IgeW91Pw0KPiANCj4gU291bmRzIGdvb2QsIHllcy4NCg0KU2hvdWxkIGl0IGJl
IGluIMK1cyBsaWtlIHRoZSBleGlzdGluZyBpdGVyLXRyYW5zZmVyIGRlbGF5PyAgSSB0aGluaw0K
cGVyaGFwcyB1bml0cyBvZiBjeWNsZXMgb2YgdGhlIFNQSSBjbG9jayBtYWtlIG1vcmUgc2Vuc2U/
