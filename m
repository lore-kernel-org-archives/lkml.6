Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289A0C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D9D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4VLWZc//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D9D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJIBlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:41:03 -0400
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:52928
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJIBlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSTPQx7bP0JsUeyIdvkFC+xa9mc+N0PgNzZxRQubaDk=;
 b=4VLWZc//Z3y+ghfJb0COwTsaNyULPLRTmy7WDECHBTC3LSd84c3IsppbLs1oVInLiiRLWN3GivTPznEgxJQzZozTo2okwiWu7gxcql9jrag3FxufpR6pFjNF7hy/kpNfNBZ3a70zrhY1IzdJ2o6+CYHzvkzczdXvWErwE90WVHg=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1199.namprd02.prod.outlook.com (10.163.16.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Mon, 8 Oct 2018 18:27:58 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::c4f3:b29:b8f4:c335]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::c4f3:b29:b8f4:c335%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:27:56 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>, "arm@kernel.org" <arm@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Tejas Patel <TEJASP@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: RE: [PATCH v5 4/4] drivers: clk: Add ZynqMP clock driver
Thread-Topic: [PATCH v5 4/4] drivers: clk: Add ZynqMP clock driver
Thread-Index: AQHUV3k02bByHphRHk+wdCeQvRP7IqUUrhEAgAELMWA=
Date:   Mon, 8 Oct 2018 18:27:56 +0000
Message-ID: <CY1PR02MB21383F22BE80E2DB83E7EB98B8E60@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
 <1538173080-7597-5-git-send-email-jollys@xilinx.com>
 <153896567067.119890.7785076104115447392@swboyd.mtv.corp.google.com>
In-Reply-To: <153896567067.119890.7785076104115447392@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1199;6:Peahu1bVdCl2GPoIRWuLUSks5MEBK8K8BjmT65BG/AHBOGdgxHfr0CL5fOW7/b99zUKXvNlPj8TeK2Qc45ZbJzyCKO/7ZaDpK1cq9FSqWpsOSBYmSjgQWj7OvRwQMh71ZXHiFQCRgzIQ6/vCnEPd61vIIOChizjRIaPcWYAycIS2lNaBzZs+ZY1BChL6vhNpuLyPVHJsQcPUiVGsgufXGvKQapwgp0CzaxZwU1pexVEf2hAEaop0nMKsSpDyVWcj6R7AP+75x2E5keZZDzkB7PDoBrRpb7lyVLbjA57JCNvXvik/ZtLIwIifWUnqAOp54keMEy0IRO3kBRfRYMef4tlVLx0rYi2+qtKYOCP+DhrV1Xw5r3OkUeprtP9BjmLQLfld6MTa3UYXzEVzT1vBfI+rnKjIxm1s+JtvlAIOh7heybydNhvs0d08dloRKK9NoxXHeOAvtvguSyz8x8TjIg==;5:QwKKX+ZH5/FzptilQu08owR+KdnLylBLFQE/6jRMzeKuHy/5Bxh4kDgLoh0BHw+uIarz+UIOX5IfbfOxoVHdXZ9JuyXffTV2m21j0mZ2xSoPVK+QPyWWSFQc7viy9vWZtW2dCgk6ollvOgxy2U2TxrUe7fkUoPZ/yqpZxo9ikwQ=;7:nU/zVwp7TrnuQ7WFuKlK0DC31Xe+hR3o0wGXFDZsz0+TqkQjQ1vGGySsU51vB+odF2LwRuJf7WMHDGvZoHN8OcohH2D+NUSJn7a8WOsO8wDcEiRO8QLqhmBi8yC1yx3yp+Z/LWFAo6v/YMCB7p7Wn1cw3sDRmrXHnWe1VIzlPya5deo9PBOKoP84OvszfxesIEc1Q/Jl67Qq8rRn/oG4iNA3JE4z/W+Uc620n3NBhkFrs8luwSSxrgzjmYSFK3Ly
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(13464003)(53936002)(9686003)(6436002)(229853002)(11346002)(476003)(446003)(486006)(97736004)(55016002)(2900100001)(5250100002)(2501003)(478600001)(72206003)(6116002)(3846002)(110136005)(54906003)(14454004)(68736007)(2906002)(186003)(26005)(8676002)(71200400001)(71190400001)(33656002)(25786009)(107886003)(86362001)(74316002)(305945005)(7736002)(6246003)(2201001)(4326008)(6506007)(7696005)(53546011)(5660300001)(99286004)(316002)(76176011)(81156014)(81166006)(66066001)(256004)(106356001)(8936002)(102836004)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1199;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 555205c8-2646-4977-aac9-08d62d4bc4ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1199;
x-ms-traffictypediagnostic: CY1PR02MB1199:
x-microsoft-antispam-prvs: <CY1PR02MB1199A43CFB26C06D1DAF1137B8E60@CY1PR02MB1199.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:CY1PR02MB1199;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1199;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bJFqm5IbCH6XWNfdteV82s4GUg3eo2zSSeI1nIMSp3IAo1OybdQjbGh4afltUckOetQ96vLQ69f29LUX+EsPoqYMeLzqgWC6mzf61746C+5P1pOhYT/WujOVfjTcpCa3xf6YJODnKE9OoIJxzu0IeredsWHwhlpTGBdYpZQrwyApGysPRI4XmrYeKiGZ6hehQU5kenXVQexwOJPPTL2OFl7xnA3PYwYeAg2DN9V5bzWAVW6chhXJDskS7Ur2THiqMWKajGG4vL0SVAf3Yc6fa6A2S4E/TTxEa2sUQ+Rai789sSc1P9JsFkY+uEunX+8lljrzSbIA+L4SSDCuhw9Ihv7ErxGHvoIsTBd6HXDNzYM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555205c8-2646-4977-aac9-08d62d4bc4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:27:56.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBTdW5kYXksIE9jdG9i
ZXIgMDcsIDIwMTggNzoyOCBQTQ0KPiBUbzogSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+
OyBhcm1Aa2VybmVsLm9yZzsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IE1pY2hhbCBT
aW1layA8bWljaGFsc0B4aWxpbnguY29tPjsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IG9s
b2ZAbGl4b20ubmV0OyBzYm95ZEBjb2RlYXVyb3JhLm9yZw0KPiBDYzogUmFqYW4gVmFqYSA8UkFK
QU5WQHhpbGlueC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbngu
Y29tPjsgUmFqYW4gVmFqYQ0KPiA8UkFKQU5WQHhpbGlueC5jb20+OyBUZWphcyBQYXRlbCA8VEVK
QVNQQHhpbGlueC5jb20+OyBTaHViaHJhanlvdGkgRGF0dGENCj4gPHNodWJocmFqQHhpbGlueC5j
b20+OyBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NSA0LzRdIGRyaXZlcnM6IGNsazogQWRkIFp5bnFNUCBjbG9jayBkcml2ZXINCj4gDQo+IFF1
b3RpbmcgSm9sbHkgU2hhaCAoMjAxOC0wOS0yOCAxNToxODowMCkNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvenlucW1wL2Nsa2MuYyBiL2RyaXZlcnMvY2xrL3p5bnFtcC9jbGtjLmMgbmV3
DQo+ID4gZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwLi4xYjA3ZDc3DQo+ID4gLS0tIC9k
ZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL3p5bnFtcC9jbGtjLmMNCj4gPiBAQCAtMCww
ICsxLDcxNiBAQA0KPiBbLi4uXQ0KPiA+ICsgKiBAdHlwZTogICAgICBDbG9jayB0eXBlOiBDTEtf
VFlQRV9PVVRQVVQgb3IgQ0xLX1RZUEVfRVhURVJOQUwNCj4gPiArICoNCj4gPiArICogUmV0dXJu
OiAwIG9uIHN1Y2Nlc3MgZWxzZSBlcnJvciBjb2RlICAqLyBzdGF0aWMgaW50DQo+ID4gK3p5bnFt
cF9nZXRfY2xvY2tfdHlwZSh1MzIgY2xrX2lkLCB1MzIgKnR5cGUpIHsNCj4gPiArICAgICAgIGlu
dCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0genlucW1wX2lzX3ZhbGlkX2Nsb2NrKGNs
a19pZCk7DQo+ID4gKyAgICAgICBpZiAocmV0ID09IDEpIHsNCj4gPiArICAgICAgICAgICAgICAg
KnR5cGUgPSBjbG9ja1tjbGtfaWRdLnR5cGU7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXQgPT0gMCA/IC1F
SU5WQUwgOiByZXQ7IH0NCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiB6eW5xbXBfcG1fY2xvY2tf
Z2V0X251bV9jbG9ja3MoKSAtIEdldCBudW1iZXIgb2YgY2xvY2tzIGluIHN5c3RlbQ0KPiA+ICsg
KiBAbmNsb2NrczogICBOdW1iZXIgb2YgY2xvY2tzIGluIHN5c3RlbS9ib2FyZC4NCj4gPiArICoN
Cj4gPiArICogQ2FsbCBmaXJtd2FyZSBBUEkgdG8gZ2V0IG51bWJlciBvZiBjbG9ja3MuDQo+ID4g
KyAqDQo+ID4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzIGVsc2UgZXJyb3IgY29kZS4NCj4gPiAr
ICovDQo+ID4gK3N0YXRpYyBpbnQgenlucW1wX3BtX2Nsb2NrX2dldF9udW1fY2xvY2tzKHUzMiAq
bmNsb2Nrcykgew0KPiA+ICsgICAgICAgc3RydWN0IHp5bnFtcF9wbV9xdWVyeV9kYXRhIHFkYXRh
ID0gezB9Ow0KPiA+ICsgICAgICAgX19sZTMyIHJldF9wYXlsb2FkW1BBWUxPQURfQVJHX0NOVF07
DQo+IA0KPiBJIGFza2VkIGFib3V0IGVuZGlhbmVzcyBidXQgdGhpcyBpc24ndCB0aGUgcmlnaHQg
Zml4LiBKdXN0IG1hcmtpbmcgc29tZXRoaW5nIGFzDQo+IF9fbGUzMiBidXQgdGhlbiBub3QgdXNp
bmcgdGhhdCB0eXBlIGFuZCBqdXN0IHBhc3NpbmcgaXQgdG8gc29tZSBmdW5jdGlvbiB0aGF0DQo+
IHRha2VzIGEgdTMyIHBvaW50ZXIgZG9lc24ndCB3b3JrLiBTbyBpcyB0aGUgZmlybXdhcmUgc2lk
ZSBhbHdheXMgbGl0dGxlIGVuZGlhbj8gSWYNCj4gc28sIG1heWJlIHRoZSBpb2N0bHMgY2FuIGRv
IHRoZSBieXRlIHN3YXAgYW5kIHRoZW4gdGhlIGtlcm5lbCBBUEkgY2FuIGJlIG5hdGl2ZQ0KPiBD
UFUgZW5kaWFuIHdoaWxlIHRoZSBmaXJtd2FyZSBsYXllciBjYW4gYmUgYXdhcmUgdGhhdCB0aGlu
Z3MgbWF5IG5lZWQNCj4gc3dhcHBpbmcuIEknbSBzdWdnZXN0aW5nIHRoYXQgdGhpcyB0eXBlIGlz
IGp1c3QgdTMyIGFuZCB0aGVuIHRoZSBlZW1pX29wcw0KPiBmdW5jdGlvbnMgYWNjZXB0IHUzMiBh
bmQgZG8gdGhlIHN3YXBwaW5nIHRoZW1zZWx2ZXMuDQo+IA0KPiBJZiB5b3UgcHV0IGJhY2sgdTMy
IGhlcmUgYW5kIGVsc2V3aGVyZSBpbiB0aGlzIHBhdGNoIHlvdSBjYW4gaGF2ZSBteQ0KPiANCj4g
UmV2aWV3ZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBm
aXggdG8gdGhlIHVuZGVybHlpbmcgb3BzIGZvciBlbmRpYW4gY29ycmVjdG5lc3MgY2FuIGNvbWUg
bGF0ZXIsIHNvIGRvbid0IGZlZWwNCj4gbGlrZSBpdCBuZWVkcyB0byBiZSBmaXhlZCByaWdodCBu
b3cuDQoNClRoYW5rcyBmb3IgY2xhcmlmaWNhdGlvbi4gSXQgbWFrZXMgcGVyZmVjdCBzZW5zZS4g
SSBwdXNoZWQgdjYgd2l0aCBzdWdnZXN0ZWQgY2hhbmdlIGFuZCB5b3VyIHJldmlldyB0YWcuIA0K
SSB3aWxsIHNlbmQgYW4gaW5jcmVtZW50YWwgcGF0Y2ggZm9yIGVuZGlhbm5lc3MgY29ycmVjdGlv
bi4NCg0KVGhhbmtzLA0KSm9sbHkgU2hhaA0KDQo=
