Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904F1ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C794C206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c9d1kc1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C794C206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbeIYA35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:29:57 -0400
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:28464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728455AbeIYA34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB/7EUd6sgzKjixsIzidMp6eNLg4R+wAlQbVwFKwG6M=;
 b=c9d1kc1IQDaFCmoh9UuO7mGwb/RvMYEpJX5H/oE6vWR/U9WvPF7dBObAetbTlM1OGRFBY4dbGNJ41HA0hI87eBPNwpMRf184+oY1A1dVkgYmxFPAMNO1jPT37EU63KTAc5Kf4EGBFcYIorrWH9Zl4X9ufcC3C/ivM5Nl6ubWxNM=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1215.namprd02.prod.outlook.com (10.163.16.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 18:26:24 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1143.019; Mon, 24 Sep 2018
 18:26:24 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Olof Johansson <olof@lixom.net>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: RE: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Topic: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Index: AQHUK1L7QuzmZ44/ikWDKXlbsDGCKaTnX36AgAK/pTCAAUtNAIAARu/ggBJ1uICAAelG4A==
Date:   Mon, 24 Sep 2018 18:26:23 +0000
Message-ID: <CY1PR02MB213831731FA01F46D2713875B8170@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
 <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
 <CAOesGMhViv_D6GKYf3x02LGqthwEsfkUFWBdG7pCQqD2MGsEew@mail.gmail.com>
 <CY1PR02MB2138254CC5B1C2B2D41AB725B8040@CY1PR02MB2138.namprd02.prod.outlook.com>
 <CAOesGMgqjGEXzRPXFxUcSyTof_wgjErPhZ7wokdGEDY9SnCvdw@mail.gmail.com>
In-Reply-To: <CAOesGMgqjGEXzRPXFxUcSyTof_wgjErPhZ7wokdGEDY9SnCvdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1215;6:gbmmwWHglVFO+t7Cgo5h0njuVvDw8twz/dzcFaPGPLely1CDz0r2XOrwdADhSCpVL0Fvazn8Mt5AdDdhygnio/V4tCOKjbIqLJVK9a2R+p2zw1W1DeqXQzLCEQMHixsMVh0Qy7h3VmuktZSB1x2FhFygHHNMZQ9FXutnbyOSsfwgJQelpWW2U22l1zriCc3VbLtnv2Q2oG2RN3O0ckVCwnuzkXPIZGLyeN4CsMyAkvEBXBDZUT93ZHuwMNK6teVJhpYXyzFRnRNxpQ0fLyTJ0HJHJ2G/SNDJZiJhgPDfUtGiYfuZERQ1W64wZdYTTbHxrshZYdC/PqJuO99/7GCugJ2woLG7fv5ka083uQbQgrrPNl+GJuyUq7+K0n7ebgrZ5iSuiZnxEouCuo1sIShY0/TZRhTGv4yIyFLRC9tGvTrMWsUDx+AqIPLRoog2rJsV9sC+4c0heer5q6oLjpCgcQ==;5:DOdGuZuWMc2INspD/02CaatXRZghsUtGanJOz5lS31udhsUFacFCQ3K7VJNIHnUTb9SaXDVQZhbXn6lDB/pW1cYFBUtgTpP9L5JWxfISUzsdD3/dLCDEA3tuX9Vjfc3m0qkEdcMsjztonAWHR0n35C5Sn82MlnOexPAX3gQV62Y=;7:r4M72OG+5rmTGO+aWTpf6QD58eDVjEpGQDeCNx5StHASMKWFW8r2hKHcuzSD+e3sDZcVtz/+jiBmZ6VGds02hVuandKsautU/jUe7xiszpvVSJyTMcU6tL1RHYnw12edI3r4CTB2sjt+Zv+0KNXGuCoG64iuv0xYGLtZI1jgpNYqK44FWNF7Hj0XSQesxGBlL5msrk6AJvKnBdThKTthaexF1jbtHXk24Cghxb8PDK+TJ9X2BGYKm6TJ3MfkTCNI
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(13464003)(189003)(199004)(14454004)(6116002)(3846002)(305945005)(229853002)(66066001)(74316002)(7736002)(7696005)(106356001)(9686003)(5660300001)(99286004)(6506007)(105586002)(6246003)(33656002)(55016002)(2906002)(76176011)(93886005)(39060400002)(25786009)(53936002)(53546011)(4326008)(6436002)(316002)(54906003)(86362001)(478600001)(446003)(11346002)(476003)(8936002)(26005)(97736004)(81156014)(186003)(81166006)(102836004)(8676002)(72206003)(2900100001)(6916009)(7416002)(5250100002)(14444005)(71190400001)(71200400001)(256004)(486006)(217873002)(68736007)(60540400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1215;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: fc2ad4f6-0f7f-4d89-f472-08d6224b3bd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1215;
x-ms-traffictypediagnostic: CY1PR02MB1215:
x-microsoft-antispam-prvs: <CY1PR02MB12155E8CFB1CC3F505024052B8170@CY1PR02MB1215.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(192813158149592)(180628864354917)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(2280196)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:CY1PR02MB1215;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1215;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zg6mCsA8Ya6Dr5S3lctTtYNcM7kt5OhRC7MUhOzweCsSOtC7r4KiAv0beQSy2HW3+yg159L82cEUBi0ShzjCMeE5VyWshIU4wIfF1dqGnWhLkXfIHOKtDUZ1ZleVu/79ID6R2c1QBpPl355V6Hm2HKwCfxQX00n7uU/Cu9EY5NCsDug65ruJJNmYLKlXVvVnPVdZvPSbpJzT49mIuLfRYaTmoxy3uAXyIMZF/+h6uHTc6ZDdsf5f2gT2yzfAxSO97Tfn/OOlTdLP7fJbDevazJp5OXWldFzr4cwJfmMOlVUy56/a3GcLSXAFs7rEvqVyOGGqWznmoCkdzF3gqR+UeXd1yDdXStCIp1HjHzZDt2IKk7eB45XFa04BJJPqKnqDbahaje4q9hcusCG1+386kOAC2al5lQyWPXeWFlV90IqIR4rFJe62eFAb6XiQVoCBy+86QbPJVvMQWJZV8Di9i8nAdyC4TCUWDpfwpOVIwEhK9aS9SFk7+KZg1PQj1wIJhzf6pttd22fqALBONig7X8lQ6d1g1Yihaso2Hhd5N58xJJ9JKT1X3SYWg0kIqtbz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2ad4f6-0f7f-4d89-f472-08d6224b3bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 18:26:23.9913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xvZiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbG9mIEpv
aGFuc3NvbiBbbWFpbHRvOm9sb2ZAbGl4b20ubmV0XQ0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJl
ciAyMywgMjAxOCA2OjExIEFNDQo+IFRvOiBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4N
Cj4gQ2M6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+OyBhcmQuYmllc2hldXZl
bEBsaW5hcm8ub3JnOyBJbmdvDQo+IE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz47IEdyZWcgS3Jv
YWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBtYXR0QGNvZGVibHVl
cHJpbnQuY28udWs7DQo+IGhrYWxsd2VpdDFAZ21haWwuY29tOyBLZWVzIENvb2sgPGtlZXNjb29r
QGNocm9taXVtLm9yZz47IERtaXRyeQ0KPiBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWls
LmNvbT47IE1pY2hhZWwgVHVycXVldHRlDQo+IDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT47IFN0
ZXBoZW4gQm95ZCA8c2JveWRAY29kZWF1cm9yYS5vcmc+OyBNaWNoYWwNCj4gU2ltZWsgPG1pY2hh
bHNAeGlsaW54LmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1
dGxhbmQNCj4gPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgbGludXgtY2xrIDxsaW51eC1jbGtAdmdl
ci5rZXJuZWwub3JnPjsgUmFqYW4gVmFqYQ0KPiA8UkFKQU5WQHhpbGlueC5jb20+OyBMaW51eCBB
Uk0gTWFpbGluZyBMaXN0IDxsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
PjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBEVE1MIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MTEgMDMvMTFdIGZpcm13YXJlOiB4aWxpbng6IEFkZCB6eW5xbXAgSU9DVEwgQVBJ
IGZvcg0KPiBkZXZpY2UgY29udHJvbA0KPiANCj4gSGksDQo+IA0KPiBBcG9sb2dpZXMgZm9yIHRo
ZSBzbG93IHJlc3BvbnNlcyBoZXJlLCBJIG1lYW50IHRvIGZvbGxvdyB1cCBvbiB0aGlzIHNvb25l
ci4NCj4gDQo+IE9uIFR1ZSwgU2VwIDExLCAyMDE4IGF0IDg6MjAgUE0sIEpvbGx5IFNoYWggPEpP
TExZU0B4aWxpbnguY29tPiB3cm90ZToNCj4gPiBIaSBTdWRlZXAgYW5kIE9sb2YsDQo+ID4NCj4g
PiBDbG9jayBkcml2ZXIgZnJvbSBzYW1lIHBhdGNoIHNldCB1c2VzIGlvY3RsIEFQSSBhbG9uZyB3
aXRoIG90aGVyIGNsb2NrIGVlbWkNCj4gQVBJcy4gQXMgY2xvY2sgcGF0Y2hlcycgZmluYWwgcmV2
aWV3IGlzIHBlbmRpbmcgYnkgU3RlcGhlbiwgTWljaGFsIG9ubHkgY3JlYXRlZA0KPiBwdWxsIHJl
cXVlc3QgZm9yIHJlc3Qgb2YgdGhlIHBhdGNoZXMgYW5kIHRoYXQgZG9lc24ndCByZXF1aXJlIGlv
Y3RsIGFwaS4gSSB3aWxsDQo+IHJlbW92ZSBpdCBhbmQgc3VibWl0IG5ldyBwYXRjaCBzZXQuDQo+
ID4NCj4gPiBGb3IgZnV0dXJlIHBhdGNoZXMgd2hpY2ggcmVxdWlyZXMgaW9jdGwgYXBpLCB3b3Vs
ZCBsaWtlIHRvIHVuZGVyc3RhbmQgeW91cg0KPiBzdWdnZXN0aW9uIHNvIEkgY2FuIG1ha2UgcmVx
dWlyZWQgY2hhbmdlcy4gRm9yIHp5bnFtcCwgRUVNSSBpbnRlcmZhY2UgYWxsb3dzDQo+IGNsb2Nr
LCByZXNldCwgcG93ZXIgZXRjIG1hbmFnZW1lbnQgdGhyb3VnaCBmaXJtd2FyZSBidXQgYXBhcnQg
ZnJvbSB0aG9zZQ0KPiB0aGVyZSBhcmUgc29tZSBvcGVyYXRpb25zIHdoaWNoIG5lZWRzIHNlY3Vy
ZSBhY2Nlc3MgdGhyb3VnaCBmaXJtd2FyZS4NCj4gRXhhbXBsZXMgYXJlIGFjY2Vzc2luZyBzb21l
IHN0b3JhZ2UgcmVnaXN0ZXJzIGZvciBpbnRlciBhZ2VudCBjb21tdW5pY2F0aW9uLA0KPiBjb25m
aWd1cmluZyBhbm90aGVyIGFnZW50KFJQVSkgbW9kZSwgc2V0dGluZyBQTEwgcGFyYW1ldGVycywg
Ym9vdCBkZXZpY2UNCj4gY29uZmlndXJhdGlvbiBldGMuIFRob3NlIG9wZXJhdGlvbnMgYXJlIGNv
dmVyZWQgYXMgaW9jdGxzIGFzIHRoZXkgYXJlIHZlcnkNCj4gcGxhdGZvcm0gc3BlY2lmaWMuIERv
IHlvdSBzdWdnZXN0IHRvIGhhbmRsZSB0aGVtIHdpdGggaW5kaXZpZHVhbCBFRU1JIEFQSXMNCj4g
aW5zdGVhZCBvZiBpb2N0bCBBUEk/DQo+IA0KPiBJJ20gcGVyc29uYWxseSBsZXNzIHdvcnJpZWQg
YWJvdXQgd2hldGhlciB0aGUgY2FsbHMgYXJlIHRocm91Z2ggYW4gaW9jdGwgQVBJIG9yIGFuDQo+
IEVFTUkgb25lLCBidXQgaWYgaXQgaXMgdGhyb3VnaCBpb2N0bCwgSSdkIHByZWZlciBpZiBpdCB3
YXNuJ3Qgd2lkZS1vcGVuIHBhc3MtdGhyb3VnaC4NCj4gSS5lLiB0aGF0IHRoZSBpb2N0bHMgeW91
IGFjdHVhbGx5IHVzZSBhcmUgZG9jdW1lbnRlZCwgYW5kIG9ubHkgdGhvc2Ugd2hvIGFyZQ0KPiB3
aGl0ZWxpc3RlZCBhcmUgcGFzc2VkIHRocm91Z2ggKGFuZCBub3QgaW4gZ2VuZXJhbCBleHBvcnRl
ZCB0byB1c2Vyc3BhY2UpLg0KPiANCj4gRG9lcyB0aGF0IG1ha2Ugc2Vuc2U/DQo+IA0KDQpTb3Vu
ZHMgcGVyZmVjdC4gSSB3aWxsIG1ha2UgcmVxdWlyZWQgY2hhbmdlcyBpbiBuZXh0IGluY3JlbWVu
dGFsIHBhdGNoc2V0Lg0KDQpUaGFua3MsDQpKb2xseSBTaGFoDQoNCg0KPiANCj4gLU9sb2YNCg==
