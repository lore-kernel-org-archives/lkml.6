Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A14AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15BC20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bcCpb6l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15BC20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbeHVPpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:45:34 -0400
Received: from mail-by2nam03on0051.outbound.protection.outlook.com ([104.47.42.51]:45515
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727835AbeHVPpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNXtzAmcnH1T3Umc8P3qSqWN8moZtRFoyiT2uzgKc9g=;
 b=bcCpb6l2rGlOd/wwiDH+HRcgDJ/zVTBh7O0EOMJdleNLrHwDlScU/T5kgi2uzlzHUcD6gGsv/UkYAchnilzgqjn39Dbpjs7peQ6g9GXff4vQTPKpI0sVLsFsqJXPXBsJfO5ah6+NjtzhC/3g0HaH3ATooi6rzXtutBHreKuP7M0=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4905.namprd02.prod.outlook.com (20.176.111.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Wed, 22 Aug 2018 12:20:46 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644%3]) with mapi id 15.20.1059.023; Wed, 22 Aug 2018
 12:20:42 +0000
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
Subject: RE: [PATCH v4 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Topic: [PATCH v4 1/4] edac: synps: Add platform specific structures for
 ddrc controller
Thread-Index: AQHUK9Uq/N7OkeV4PkSv3s73kY/ZqKTKR+wAgAGBjRA=
Date:   Wed, 22 Aug 2018 12:20:42 +0000
Message-ID: <DM6PR02MB5227404E171F81043D5E4D1FC1300@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-2-git-send-email-manish.narani@xilinx.com>
 <20180821130638.GC30528@nazgul.tnic>
In-Reply-To: <20180821130638.GC30528@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4905;6:eiDgz1qSKwCNs+UJaOpkEW62Zb0Ho7cNkTrcUKMLI2dfUGlp2cJeaOh5RR7DuwyMGN5e2xwDeB6Z5xHVl3Lhp7HwfVFkIqgOBBW3B6k2dcA8WqRsh7wZt8fSFdTo9JeNCviumxCH8u9cRGarM5SBt9lvl+eaZimPM1ETP8fkJK0mv7OeJHHdwQOFvXP0yx42ldl14xPLCnrgYIJGhpr72lzJbHZgE97cLVIbVC23KUK0paRWjJt1KJrIjNktT0p+RJnPFWZTrmY4Rq2VykouCgN0kv2uEH4gjYLwRPTfbH2DXIgDI8+xEb9AiLacB+Ylbnd0Vk+4NMHKJLPkH0HhcJhLPF1NL8jP9g1BJnUQ0HnyojnmWla0gkAfZpu/k5r1MkRXVJwsZ8XbY7te9aoXQdgqXS1HeeeG3I0TSiO4GMb3/F8a95RHvxTKjMG7FUaWXoIIimphjSEEV6waYsaB7Q==;5:+UDktbtfKHw+NiEEpMYjK6qpU0eFgMdZqKL79E26TWl/hqXkClwtilbmQPEHy/JIX/nJF/Sal6MfQBP4h8JetVpbrBj/rjoAkAKg/svM1jRHoIMsnvtHXfTwfdgNcFCBN266oBf8+/pRkNQNFEQ7aISE1sBxkv/9e29uD/zktQ8=;7:ayZdQsikFuX8Pm15D4hTtVAQw/8lFEu6Q9YJAVwH89VhX/Fd91NAjtNmRxBNpAEx3E+XzSP0xOJspkrPWwjsoBqzTGOkZX4aj7MiFTzYuUTcDAwum0WlvftCA8cYDlhXqddZxvAqOY5Bu36eMkCt/ZfbRpNihJgSNUqvNWpmfs8EE/CkDujTeewCoN35qJ+BL8po7lLxhP3qHJpIVEPNG5A0OP3LrcLjMZkhbULHXhC4C1pPFx1fOuYtS2uZNuja
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 4ab08454-d209-46fe-2aa8-08d60829ae05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4905;
x-ms-traffictypediagnostic: DM6PR02MB4905:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB4905F1F1B35B6478494A7B97C1300@DM6PR02MB4905.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR02MB4905;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4905;
x-forefront-prvs: 0772E5DAD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(396003)(346002)(13464003)(199004)(189003)(6506007)(33656002)(2906002)(8936002)(6916009)(256004)(53546011)(7736002)(316002)(2900100001)(229853002)(14444005)(305945005)(76176011)(186003)(6246003)(86362001)(4326008)(99286004)(7696005)(25786009)(102836004)(26005)(54906003)(5660300001)(81166006)(14454004)(66066001)(9686003)(106356001)(55016002)(74316002)(53936002)(105586002)(68736007)(486006)(11346002)(446003)(5250100002)(476003)(97736004)(478600001)(81156014)(72206003)(6436002)(8676002)(6116002)(7416002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4905;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5CkiY/8z7/kpE0UWeDNYbh+ucvHlWbwKLHoj033cm77JZPv/zPe310ReFeQPfg0xk1GnhKxliCH0mvwsz9VQR49spZSWjwf/Lz1CO8x8AH6uocVFP8oY1s9oK1DpOyQnXq37SOx72v85cwZ8HKuvDlCBcLjJXHgFWdSQk6sMdr8saTqhNI4y/1CT3OshjpaZ11pHlKX3u74PsaXbop0dVkmPcT/Y5RkJFIdRNG3GFMNpcZZB9fRMFOz2cu46yGeVhF104ibcw3Lj8kufKQmllbQU2/EHXdTfDUDh0Cu92Gd4x/PwtsdTJ7rY2jm/27uICBmojfsoKaVkS4kJ9yVZh2VydML/Td9F+G3q3Dm3sNs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab08454-d209-46fe-2aa8-08d60829ae05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 12:20:42.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rIHlvdSBzbyBtdWNoIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJvcmlzbGF2IFBldGtvdiBbbWFpbHRvOmJw
QGFsaWVuOC5kZV0NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDIxLCAyMDE4IDY6MzcgUE0NCj4g
VG86IE1hbmlzaCBOYXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0K
PiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47
DQo+IG1jaGVoYWJAa2VybmVsLm9yZzsgbWRmQGtlcm5lbC5vcmc7IEVkZ2FyIElnbGVzaWFzIDxl
ZGdhcmlAeGlsaW54LmNvbT47DQo+IFNodWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWpAeGlsaW54
LmNvbT47IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gPG5hZ2FzdXJlQHhpbGlueC5jb20+OyBC
aGFyYXQgS3VtYXIgR29nYWRhIDxiaGFyYXRrdUB4aWxpbnguY29tPjsNCj4gc3RlZmFuLmtyc21h
bm92aWNAYWdnaW9zLmNvbTsgU3Jpbml2YXMgR291ZCA8c2dvdWRAeGlsaW54LmNvbT47IEFuaXJ1
ZGhhDQo+IFNhcmFuZ2kgPGFuaXJ1ZGhAeGlsaW54LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBlZGFjQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDEvNF0gZWRhYzogc3lucHM6IEFkZCBwbGF0Zm9ybSBzcGVj
aWZpYyBzdHJ1Y3R1cmVzIGZvcg0KPiBkZHJjIGNvbnRyb2xsZXINCj4gDQo+IE9uIFNhdCwgQXVn
IDA0LCAyMDE4IGF0IDAyOjU1OjMyUE0gKzA1MzAsIE1hbmlzaCBOYXJhbmkgd3JvdGU6DQo+ID4g
QWRkIHBsYXRmb3JtIHNwZWNpZmljIHN0cnVjdHVyZXMsIHNvIHRoYXQgd2UgY2FuIGFkZCBkaWZm
ZXJlbnQgSVANCj4gPiBzdXBwb3J0IGxhdGVyIHVzaW5nIHF1aXJrcy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54LmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYyB8IDgzDQo+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDY1IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiBiL2RyaXZlcnMvZWRhYy9zeW5vcHN5
c19lZGFjLmMgaW5kZXggMGM5YzU5ZS4uYjNjNTRlNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2VkYWMvc3lub3BzeXNfZWRhYy5jDQo+ID4gKysrIGIvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2Vk
YWMuYw0KPiA+IEBAIC0yMiw2ICsyMiw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9lZGFjLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPg0KPiA+ICAj
aW5jbHVkZSAiZWRhY19tb2R1bGUuaCINCj4gPg0KPiA+IEBAIC0xMzAsNiArMTMxLDcgQEAgc3Ry
dWN0IHN5bnBzX2VjY19zdGF0dXMgew0KPiA+ICAgKiBAYmFzZWFkZHI6CUJhc2UgYWRkcmVzcyBv
ZiB0aGUgRERSIGNvbnRyb2xsZXINCj4gPiAgICogQG1lc3NhZ2U6CUJ1ZmZlciBmb3IgZnJhbWlu
ZyB0aGUgZXZlbnQgc3BlY2lmaWMgaW5mbw0KPiA+ICAgKiBAc3RhdDoJRUNDIHN0YXR1cyBpbmZv
cm1hdGlvbg0KPiA+ICsgKiBAcF9kYXRhOglQb2ludGVyIHRvIHBsYXRmb3JtIGRhdGENCj4gPiAg
ICogQGNlX2NudDoJQ29ycmVjdGFibGUgRXJyb3IgY291bnQNCj4gPiAgICogQHVlX2NudDoJVW5j
b3JyZWN0YWJsZSBFcnJvciBjb3VudA0KPiA+ICAgKi8NCj4gPiBAQCAtMTM3LDI0ICsxMzksNDcg
QEAgc3RydWN0IHN5bnBzX2VkYWNfcHJpdiB7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2VhZGRy
Ow0KPiA+ICAJY2hhciBtZXNzYWdlW1NZTlBTX0VEQUNfTVNHX1NJWkVdOw0KPiA+ICAJc3RydWN0
IHN5bnBzX2VjY19zdGF0dXMgc3RhdDsNCj4gPiArCWNvbnN0IHN0cnVjdCBzeW5wc19wbGF0Zm9y
bV9kYXRhICpwX2RhdGE7DQo+ID4gIAl1MzIgY2VfY250Ow0KPiA+ICAJdTMyIHVlX2NudDsNCj4g
PiAgfTsNCj4gPg0KPiA+ICAvKioNCj4gPiArICogc3RydWN0IHN5bnBzX3BsYXRmb3JtX2RhdGEg
LSAgc3lucHMgcGxhdGZvcm0gZGF0YSBzdHJ1Y3R1cmUNCj4gPiArICogQGVkYWNfZ2V0ZXJyb3Jf
aW5mbzoJZnVuY3Rpb24gcG9pbnRlciB0byBzeW5wcyBlZGFjIGVycm9yIGluZm8NCj4gPiArICog
QGVkYWNfZ2V0X210eXBlOglmdW5jdGlvbiBwb2ludGVyIHRvIHN5bnBzIGVkYWMgbXR5cGUNCj4g
PiArICogQGVkYWNfZ2V0X2R0eXBlOglmdW5jdGlvbiBwb2ludGVyIHRvIHN5bnBzIGVkYWMgZHR5
cGUNCj4gPiArICogQGVkYWNfZ2V0X2VjY3N0YXRlOglmdW5jdGlvbiBwb2ludGVyIHRvIHN5bnBz
IGVkYWMgZWNjc3RhdGUNCj4gPiArICogQHF1aXJrczoJCXRvIGRpZmZlcmVudGlhdGUgSVBzDQo+
ID4gKyAqLw0KPiA+ICtzdHJ1Y3Qgc3lucHNfcGxhdGZvcm1fZGF0YSB7DQo+ID4gKwlpbnQgKCpl
ZGFjX2dldGVycm9yX2luZm8pKHN0cnVjdCBzeW5wc19lZGFjX3ByaXYgKnByaXYpOw0KPiA+ICsJ
ZW51bSBtZW1fdHlwZSAoKmVkYWNfZ2V0X210eXBlKShjb25zdCB2b2lkIF9faW9tZW0gKmJhc2Up
Ow0KPiA+ICsJZW51bSBkZXZfdHlwZSAoKmVkYWNfZ2V0X2R0eXBlKShjb25zdCB2b2lkIF9faW9t
ZW0gKmJhc2UpOw0KPiA+ICsJYm9vbCAoKmVkYWNfZ2V0X2VjY3N0YXRlKSh2b2lkIF9faW9tZW0g
KmJhc2UpOw0KPiA+ICsJaW50IHF1aXJrczsNCj4gPiArfTsNCj4gPiArDQo+ID4gKy8qKg0KPiA+
ICAgKiBzeW5wc19lZGFjX2dldGVycm9yX2luZm8gLSBHZXQgdGhlIGN1cnJlbnQgZWNjIGVycm9y
IGluZm8NCj4gPiAtICogQGJhc2U6CVBvaW50ZXIgdG8gdGhlIGJhc2UgYWRkcmVzcyBvZiB0aGUg
ZGRyIG1lbW9yeSBjb250cm9sbGVyDQo+ID4gLSAqIEBwOgkJUG9pbnRlciB0byB0aGUgc3lub3Bz
eXMgZWNjIHN0YXR1cyBzdHJ1Y3R1cmUNCj4gPiArICogQHByaXY6CVBvaW50ZXIgdG8gRERSIG1l
bW9yeSBjb250cm9sbGVyIHByaXZhdGUgaW5zdGFuY2UgZGF0YQ0KPiA+ICAgKg0KPiA+ICAgKiBE
ZXRlcm1pbmVzIHRoZXJlIGlzIGFueSBlY2MgZXJyb3Igb3Igbm90DQo+ID4gICAqDQo+ID4gICAq
IFJldHVybjogb25lIGlmIHRoZXJlIGlzIG5vIGVycm9yIG90aGVyd2lzZSByZXR1cm5zIHplcm8N
Cj4gPiAgICovDQo+ID4gLXN0YXRpYyBpbnQgc3lucHNfZWRhY19nZXRlcnJvcl9pbmZvKHZvaWQg
X19pb21lbSAqYmFzZSwNCj4gPiAtCQkJCSAgICBzdHJ1Y3Qgc3lucHNfZWNjX3N0YXR1cyAqcCkN
Cj4gPiArc3RhdGljIGludCBzeW5wc19lZGFjX2dldGVycm9yX2luZm8oc3RydWN0IHN5bnBzX2Vk
YWNfcHJpdiAqcHJpdikNCj4gPiAgew0KPiA+ICsJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ICsJ
c3RydWN0IHN5bnBzX2VjY19zdGF0dXMgKnA7DQo+ID4gIAl1MzIgcmVndmFsLCBjbGVhcnZhbCA9
IDA7DQo+ID4NCj4gPiArCWlmICghcHJpdikNCj4gPiArCQlyZXR1cm4gMTsNCj4gPiArDQo+ID4g
KwliYXNlID0gcHJpdi0+YmFzZWFkZHI7DQo+ID4gKwlwID0gJnByaXYtPnN0YXQ7DQo+ID4gKw0K
PiA+ICAJcmVndmFsID0gcmVhZGwoYmFzZSArIFNUQVRfT0ZTVCk7DQo+ID4gIAlpZiAoIXJlZ3Zh
bCkNCj4gPiAgCQlyZXR1cm4gMTsNCj4gPiBAQCAtMjQwLDkgKzI2NSwxMCBAQCBzdGF0aWMgdm9p
ZCBzeW5wc19lZGFjX2hhbmRsZV9lcnJvcihzdHJ1Y3QNCj4gPiBtZW1fY3RsX2luZm8gKm1jaSwg
IHN0YXRpYyB2b2lkIHN5bnBzX2VkYWNfY2hlY2soc3RydWN0IG1lbV9jdGxfaW5mbw0KPiA+ICpt
Y2kpICB7DQo+ID4gIAlzdHJ1Y3Qgc3lucHNfZWRhY19wcml2ICpwcml2ID0gbWNpLT5wdnRfaW5m
bzsNCj4gPiArCWNvbnN0IHN0cnVjdCBzeW5wc19wbGF0Zm9ybV9kYXRhICpwX2RhdGEgPSBwcml2
LT5wX2RhdGE7DQo+ID4gIAlpbnQgc3RhdHVzOw0KPiA+DQo+ID4gLQlzdGF0dXMgPSBzeW5wc19l
ZGFjX2dldGVycm9yX2luZm8ocHJpdi0+YmFzZWFkZHIsICZwcml2LT5zdGF0KTsNCj4gPiArCXN0
YXR1cyA9IHBfZGF0YS0+ZWRhY19nZXRlcnJvcl9pbmZvKHByaXYpOw0KPiA+ICAJaWYgKHN0YXR1
cykNCj4gPiAgCQlyZXR1cm47DQo+ID4NCj4gPiBAQCAtMzYyLDYgKzM4OCw3IEBAIHN0YXRpYyBp
bnQgc3lucHNfZWRhY19pbml0X2Nzcm93cyhzdHJ1Y3QNCj4gbWVtX2N0bF9pbmZvICptY2kpDQo+
ID4gIAlzdHJ1Y3QgY3Nyb3dfaW5mbyAqY3NpOw0KPiA+ICAJc3RydWN0IGRpbW1faW5mbyAqZGlt
bTsNCj4gPiAgCXN0cnVjdCBzeW5wc19lZGFjX3ByaXYgKnByaXYgPSBtY2ktPnB2dF9pbmZvOw0K
PiA+ICsJY29uc3Qgc3RydWN0IHN5bnBzX3BsYXRmb3JtX2RhdGEgKnBfZGF0YSA9IHByaXYtPnBf
ZGF0YTsNCj4gPiAgCXUzMiBzaXplOw0KPiA+ICAJaW50IHJvdywgajsNCj4gPg0KPiA+IEBAIC0z
NzAsMTIgKzM5NywxMyBAQCBzdGF0aWMgaW50IHN5bnBzX2VkYWNfaW5pdF9jc3Jvd3Moc3RydWN0
DQo+IG1lbV9jdGxfaW5mbyAqbWNpKQ0KPiA+ICAJCXNpemUgPSBzeW5wc19lZGFjX2dldF9tZW1z
aXplKCk7DQo+ID4NCj4gPiAgCQlmb3IgKGogPSAwOyBqIDwgY3NpLT5ucl9jaGFubmVsczsgaisr
KSB7DQo+ID4gLQkJCWRpbW0gICAgICAgICAgICA9IGNzaS0+Y2hhbm5lbHNbal0tPmRpbW07DQo+
ID4gKwkJCWRpbW0gPSBjc2ktPmNoYW5uZWxzW2pdLT5kaW1tOw0KPiA+ICAJCQlkaW1tLT5lZGFj
X21vZGUgPSBFREFDX0ZMQUdfU0VDREVEOw0KPiA+IC0JCQlkaW1tLT5tdHlwZSAgICAgPSBzeW5w
c19lZGFjX2dldF9tdHlwZShwcml2LQ0KPiA+YmFzZWFkZHIpOw0KPiA+IC0JCQlkaW1tLT5ucl9w
YWdlcyAgPSAoc2l6ZSA+PiBQQUdFX1NISUZUKSAvIGNzaS0NCj4gPm5yX2NoYW5uZWxzOw0KPiA+
IC0JCQlkaW1tLT5ncmFpbiAgICAgPSBTWU5QU19FREFDX0VSUl9HUkFJTjsNCj4gPiAtCQkJZGlt
bS0+ZHR5cGUgICAgID0gc3lucHNfZWRhY19nZXRfZHR5cGUocHJpdi0NCj4gPmJhc2VhZGRyKTsN
Cj4gPiArCQkJZGltbS0+bXR5cGUgPSBwX2RhdGEtPmVkYWNfZ2V0X210eXBlKHByaXYtDQo+ID5i
YXNlYWRkcik7DQo+ID4gKwkJCWRpbW0tPm5yX3BhZ2VzID0gKHNpemUgPj4gUEFHRV9TSElGVCkg
Lw0KPiA+ICsJCQkJCQljc2ktPm5yX2NoYW5uZWxzOw0KPiANCj4gV2h5IGRvIHlvdSBoYXZlIHRv
IGJyZWFrIHRoYXQgbGluZT8gSnVzdCBsZXQgaXQgc3RpY2sgb3V0LltdIA0KT2theS4gSSB3aWxs
IHVwZGF0ZSB0aGlzIGluIHY1Lg0KDQo+IA0KPiBBbmQgd2h5IGNhbid0IHlvdSBrZWVwIHRoZSBu
aWNlIHZlcnRpY2FsIGFsaWdubWVudCBvbiB0aGUgJz0nIHNpZ25zIGZvciBiZXR0ZXINCj4gcmVh
ZGFiaWxpdHk/DQpPa2F5LiBUaGlzIHdpbGwgYnJpbmcgY2hlY2twYXRjaCB3YXJuaW5nIChhYm92
ZSA4MCBsaW5lcyksIGJ1dCBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5LCBJIHdpbGwgdXBkYXRlIHRo
aXMgaW4gdjUuDQoNCj4gDQo+ID4gKwkJCWRpbW0tPmdyYWluID0gU1lOUFNfRURBQ19FUlJfR1JB
SU47DQo+ID4gKwkJCWRpbW0tPmR0eXBlID0gcF9kYXRhLT5lZGFjX2dldF9kdHlwZShwcml2LQ0K
PiA+YmFzZWFkZHIpOw0KPiA+ICAJCX0NCj4gPiAgCX0NCj4gPg0KPiA+IEBAIC00MjMsNiArNDUx
LDIxIEBAIHN0YXRpYyBpbnQgc3lucHNfZWRhY19tY19pbml0KHN0cnVjdCBtZW1fY3RsX2luZm8N
Cj4gKm1jaSwNCj4gPiAgCXJldHVybiBzdGF0dXM7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IHN5bnBzX3BsYXRmb3JtX2RhdGEgenlucV9lZGFjX2RlZiA9IHsNCj4gPiAr
CS5lZGFjX2dldGVycm9yX2luZm8JPSBzeW5wc19lZGFjX2dldGVycm9yX2luZm8sDQo+ID4gKwku
ZWRhY19nZXRfbXR5cGUJCT0gc3lucHNfZWRhY19nZXRfbXR5cGUsDQo+ID4gKwkuZWRhY19nZXRf
ZHR5cGUJCT0gc3lucHNfZWRhY19nZXRfZHR5cGUsDQo+ID4gKwkuZWRhY19nZXRfZWNjc3RhdGUJ
PSBzeW5wc19lZGFjX2dldF9lY2NzdGF0ZSwNCj4gPiArCS5xdWlya3MJCQk9IDAsDQo+IA0KPiAu
Li4gbGlrZSB5b3UndmUgZG9uZSBoZXJlLCBmb3IgZXhhbXBsZS4NCj4gDQo+ID4gK307DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzeW5wc19lZGFjX21hdGNo
W10gPSB7DQo+ID4gKwl7IC5jb21wYXRpYmxlID0gInhsbngsenlucS1kZHJjLWEwNSIsIC5kYXRh
ID0gKHZvaWQgKikmenlucV9lZGFjX2RlZiB9LA0KPiA+ICsJeyAvKiBlbmQgb2YgdGFibGUgKi8g
fQ0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc3lucHNfZWRh
Y19tYXRjaCk7DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogc3lucHNfZWRhY19tY19wcm9iZSAt
IENoZWNrIGNvbnRyb2xsZXIgYW5kIGJpbmQgZHJpdmVyDQo+ID4gICAqIEBwZGV2OglQb2ludGVy
IHRvIHRoZSBwbGF0Zm9ybV9kZXZpY2Ugc3RydWN0DQo+ID4gQEAgLTQ0MCwxMyArNDgzLDIyIEBA
IHN0YXRpYyBpbnQgc3lucHNfZWRhY19tY19wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ICAJaW50IHJjOw0KPiA+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4g
IAl2b2lkIF9faW9tZW0gKmJhc2VhZGRyOw0KPiA+ICsJY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCAqbWF0Y2g7DQo+ID4gKwljb25zdCBzdHJ1Y3Qgc3lucHNfcGxhdGZvcm1fZGF0YSAqcF9kYXRh
Ow0KPiA+DQo+ID4gIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJD
RV9NRU0sIDApOw0KPiA+ICAJYmFzZWFkZHIgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYt
PmRldiwgcmVzKTsNCj4gPiAgCWlmIChJU19FUlIoYmFzZWFkZHIpKQ0KPiA+ICAJCXJldHVybiBQ
VFJfRVJSKGJhc2VhZGRyKTsNCj4gPg0KPiA+IC0JaWYgKCFzeW5wc19lZGFjX2dldF9lY2NzdGF0
ZShiYXNlYWRkcikpIHsNCj4gPiArCW1hdGNoID0gb2ZfbWF0Y2hfbm9kZShzeW5wc19lZGFjX21h
dGNoLCBwZGV2LT5kZXYub2Zfbm9kZSk7DQo+ID4gKwlpZiAoIW1hdGNoICYmICFtYXRjaC0+ZGF0
YSkgew0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIm9mX21hdGNoX25vZGUoKSBmYWlsZWRc
biIpOw0KPiANCj4gVGhhdCBlcnJvciBtZXNzYWdlIGlzIG5vdCByZWFsbHkgaGVscGZ1bC4NCk9r
YXkuIEkgd2lsbCB1cGRhdGUgdGhhdCBwYXJ0IG9mIGNvZGUuDQoNClRoYW5rcywNCk1hbmlzaCBO
YXJhbmkNCg0K
