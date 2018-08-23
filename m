Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7894C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3612098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BsOlQJpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3612098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbeHWSiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:38:17 -0400
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:34536
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbeHWSiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5NMmwkMFXkSfcJIKUyMyGWwfTBbkpTP4n05t2Q9joE=;
 b=BsOlQJpfZL5tecbtlWVQL79IrZRvAZPlR7qwERPChuY8fNU+jx01pL+G+QkQnTRIalS/RbzpGDusRMJLPjoSL9Z//SrpsWtGnVOS4Z/XwnzIRTvIxqgukw47dFDwKNr6yYbKNWFvHv8kw2LAGauN0yWaqNOKhHxdG/RHHiHFzs4=
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com (20.177.32.218) by
 AM6PR04MB4197.eurprd04.prod.outlook.com (52.135.168.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 23 Aug 2018 15:08:07 +0000
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::d35:5e30:4789:7bb3]) by AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::d35:5e30:4789:7bb3%2]) with mapi id 15.20.1059.023; Thu, 23 Aug 2018
 15:08:08 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>
Subject: RE: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
Thread-Topic: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
Thread-Index: AQHUOLbsmQj+0Sja20qqJLqo/jXK+qTKrlEAgALFQXA=
Date:   Thu, 23 Aug 2018 15:08:07 +0000
Message-ID: <AM6PR04MB478980C90EE825D024D8B977F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
 <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
In-Reply-To: <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [139.167.224.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4197;6:jzg11Q7kBypsxWXfxkmJagzNC7iq6lxwMemSQCKJVn5cCCMcsQkDay/MIiTio6B5uUsMzLbx+yY3wU2YcKU+di/+3w8pfHM6myJCJhgKmTnAsos/bwPbTgODeiqxIZZAn6H63aS2AzQzGESAu7EIS2rlNhZwjGBULBpmGnYpmo/R++EQzafR3heNPSokHDFLXKNjb5in19ro/7EzgwMOqxoODVqFB3xXaCjI/xPbwFafGJLWWZuqyzdBrozOcCWYS3DmlTdJyYYoZXD8UWg3uU14yKEdmxkGY2bCCpsKQj3H+tyqTLNTaJTNALqCIk8uCXTfWEeszMUsi0C+YP/UsNSSHfxDMv2gTvq3IFx53wT9oNyom3gGJYPPyGGYYTONRwJ633t4Sen2tAANMjl3G/SrJSO1/z/jOBSkRlM6zgM4u0EEihUJDiScfcb0DQR5t6lcnpU7M1v/MOb/T3rt8Q==;5:kNHtrDh0OhPyd5EuAOakekQyn2GKn3Fj+rcplGlbkscF5E5dbStHUnSaWmz38kqau0Q3yyMbzqjbAaPMDPePxJiBRf43PQhvYmVwNN8n8ux49hTp5LGz+NrMEgDry+U8IvKR4yzGvDy8LG6OSS9wXmcKJQv20J9vVIxW/krCs5U=;7:hByqhsBQFLY/ZqTtj01UJ/QmPQRQg0iirrbjUk5DYCO6aR2Ozasa/WxG4I08H9q2+70KnqCi0GJ15lEKkTu+k0U0tq5Yh23qxA7P0nrSJJFVZhbj/1rMDiGosZuWdu8gDKPURRE7zM5CCYRLzt2g5OOwvd5RsLeT7ImLtlq99UzgelZoFwnbUDRLLEcG6W+cWsT/r2hen7YmIWMHFAkP3JftBCWMmaQRs2TJulXWHL3faQO6Qt3pQaFMZV+T3+rW
x-ms-office365-filtering-correlation-id: c494de13-a4c3-49db-29a0-08d6090a3bf9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4197;
x-ms-traffictypediagnostic: AM6PR04MB4197:
x-microsoft-antispam-prvs: <AM6PR04MB4197146C219E4F9F4AB054ACF3370@AM6PR04MB4197.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:AM6PR04MB4197;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4197;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(13464003)(2900100001)(66066001)(99286004)(86362001)(7696005)(8676002)(33656002)(446003)(11346002)(478600001)(8936002)(229853002)(25786009)(106356001)(476003)(4326008)(486006)(44832011)(105586002)(97736004)(76176011)(305945005)(316002)(53546011)(54906003)(53936002)(7736002)(6506007)(9686003)(256004)(55016002)(7416002)(74316002)(26005)(102836004)(2906002)(6116002)(81156014)(81166006)(186003)(3846002)(5250100002)(14454004)(6436002)(68736007)(5660300001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4197;H:AM6PR04MB4789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C7ZSnPjizNHsTN4/69XhgdCk30sbXzSXaLkvFtz2YOLvSW+c6//72X68+4JNGBDQubTngSCcCllhRlhIak6dC3FoJtceXFIqldXYDOnW+XHU5NCMKhhgiSRaY17jlTh5WYbaRcikUbK/PZGaBR9q7vw73cLEljKq09AK31HeVjRQy3uD62jq0eLR3eULsjp4sB5R+2EelqQwnF0e5MXH1fhSVWAXoH9fl7E3D1wqyJSP+RMdcyiwopV5dNhVxXTyUVWe6rMlkVZ+rioBWQAUi2QR8vVXOyjtD/3nkftiIoL6v2CoGDYt4FfibU3W0pncf7M1TmdeOttem8COQOo6iHTmFkLZ3jEFjVdevkN69TU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c494de13-a4c3-49db-29a0-08d6090a3bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 15:08:07.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjIsIDIwMTggMjox
NSBBTQ0KPiBUbzogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBsaW51eHBwYy1kZXYgPGxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPjsNCj4gbW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVT
Q0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZz47IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJl
LmNvbT47DQo+IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz47IFJhZmFlbCBKLiBXeXNv
Y2tpIDxyandAcmp3eXNvY2tpLm5ldD47DQo+IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxp
bmFyby5vcmc+OyBsaW51eC1jbGsgPGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwub3JnPjsgb3Bl
biBsaXN0OlRIRVJNQUwgPGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LQ0KPiBrZXJu
ZWwtb3duZXJAdmdlci5rZXJuZWwub3JnOyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5h
c0Bhcm0uY29tPjsNCj4gV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+OyBHcmVnIEty
b2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT47IEthdGUNCj4gU3Rld2FydCA8a3N0ZXdhcnRAbGludXhmb3VuZGF0
aW9uLm9yZz47IE1hc2FoaXJvIFlhbWFkYQ0KPiA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5j
b20+OyBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az47DQo+IFZhcnVuIFNldGhp
IDxWLlNldGhpQG54cC5jb20+OyBVZGl0IEt1bWFyIDx1ZGl0Lmt1bWFyQG54cC5jb20+Ow0KPiBQ
cml5YW5rYSBKYWluIDxwcml5YW5rYS5qYWluQG54cC5jb20+OyBTcmlyYW0gRGFzaA0KPiA8c3Jp
cmFtLmRhc2hAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzVdIGFybTY0OiBkdHM6
IGFkZCBMWDIxNjBBUkRCIGJvYXJkIHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgQXVnIDIwLCAyMDE4
IGF0IDE6NTIgUE0gVmFiaGF2IFNoYXJtYQ0KPiA8dmFiaGF2LnNoYXJtYUBueHAuY29tPiB3cm90
ZToNCj4gPg0KPiA+IExYMjE2MEEgcmVmZXJlbmNlIGRlc2lnbiBib2FyZCAoUkRCKSBpcyBhIGhp
Z2gtcGVyZm9ybWFuY2UgY29tcHV0aW5nLA0KPiA+IGV2YWx1YXRpb24sIGFuZCBkZXZlbG9wbWVu
dCBwbGF0Zm9ybSB3aXRoIExYMjE2MEEgU29DLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJp
eWFua2EgSmFpbiA8cHJpeWFua2EuamFpbkBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNy
aXJhbSBEYXNoIDxzcmlyYW0uZGFzaEBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZhYmhh
diBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGUgICAgICAgICAgICB8ICAxICsNCj4gPiAgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cyB8IDk1DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRp
b25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGUNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL01ha2VmaWxlDQo+ID4gaW5kZXggODZlMThhZC4uNDQ1YjcyYiAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQ0KPiA+ICsrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+ID4gQEAgLTEzLDMgKzEz
LDQgQEAgZHRiLSQoQ09ORklHX0FSQ0hfTEFZRVJTQ0FQRSkgKz0gZnNsLWxzMjA4MGEtDQo+IHJk
Yi5kdGINCj4gPiAgZHRiLSQoQ09ORklHX0FSQ0hfTEFZRVJTQ0FQRSkgKz0gZnNsLWxzMjA4MGEt
c2ltdS5kdGINCj4gPiAgZHRiLSQoQ09ORklHX0FSQ0hfTEFZRVJTQ0FQRSkgKz0gZnNsLWxzMjA4
OGEtcWRzLmR0Yg0KPiA+ICBkdGItJChDT05GSUdfQVJDSF9MQVlFUlNDQVBFKSArPSBmc2wtbHMy
MDg4YS1yZGIuZHRiDQo+ID4gK2R0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9IGZzbC1s
eDIxNjBhLXJkYi5kdGINCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4g
aW5kZXggMDAwMDAwMC4uNzBmYWQyMA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQo+ID4gQEAgLTAs
MCArMSw5NSBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1Ig
TUlUKSAvLyAvLyBEZXZpY2UgVHJlZSBmaWxlDQo+ID4gK2ZvciBMWDIxNjBBUkRCIC8vIC8vIENv
cHlyaWdodCAyMDE4IE5YUA0KPiA+ICsNCj4gPiArL2R0cy12MS87DQo+ID4gKw0KPiA+ICsjaW5j
bHVkZSAiZnNsLWx4MjE2MGEuZHRzaSINCj4gPiArDQo+ID4gKy8gew0KPiA+ICsgICAgICAgbW9k
ZWwgPSAiTlhQIExheWVyc2NhcGUgTFgyMTYwQVJEQiI7DQo+ID4gKyAgICAgICBjb21wYXRpYmxl
ID0gImZzbCxseDIxNjBhLXJkYiIsICJmc2wsbHgyMTYwYSI7DQo+ID4gKw0KPiA+ICsgICAgICAg
YWxpYXNlcyB7DQo+ID4gKyAgICAgICAgICAgICAgIGNyeXB0byA9ICZjcnlwdG87DQo+IA0KPiBE
cm9wIHRoaXMuIEFsaWFzZXMgc2hvdWxkIGJlIG51bWJlcmVkLCBhbmQgdGhpcyBpcyBub3QgYSBz
dGFuZGFyZCBhbGlhcyBuYW1lDQo+IGVpdGhlci4NCk9rDQo+IA0KPiA+ICsgICAgICAgICAgICAg
ICBzZXJpYWwwID0gJnVhcnQwOw0KPiA+ICsgICAgICAgICAgICAgICBzZXJpYWwxID0gJnVhcnQx
Ow0KPiA+ICsgICAgICAgICAgICAgICBzZXJpYWwyID0gJnVhcnQyOw0KPiA+ICsgICAgICAgICAg
ICAgICBzZXJpYWwzID0gJnVhcnQzOw0KPiA+ICsgICAgICAgfTsNCj4gPiArICAgICAgIGNob3Nl
biB7DQo+ID4gKyAgICAgICAgICAgICAgIHN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgi
Ow0KPiA+ICsgICAgICAgfTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZ1YXJ0MCB7DQo+ID4gKyAg
ICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmdWFydDEgew0KPiA+
ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmkyYzAgew0K
PiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICsgICAgICAgcGNhOTU0N0A3NyB7DQo+
IA0KPiBpMmMtbXV4QDc3DQpTdXJlDQo+IA0KPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxl
ID0gIm54cCxwY2E5NTQ3IjsNCj4gPiArICAgICAgICAgICAgICAgcmVnID0gPDB4Nzc+Ow0KPiA+
ICsgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAg
ICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBpMmNAMiB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmVnID0gPDB4Mj47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGluYTIyMEA0MCB7DQpwb3dlci1zZW5zb3JANDANCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAidGksaW5hMjIwIjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDQwPjsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNodW50LXJlc2lzdG9yID0gPDEwMDA+Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICAgICBpMmNAMyB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8
MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4Mz47DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHNhNTYwMDRANGMgew0KPiANCj4gdGVtcGVyYXR1cmUt
c2Vuc29yQDRjDQpPaywgdGVtcGVyYXR1cmUtc2Vuc29yLTFANGMNCj4gDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxzYTU2MDA0IjsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDRjPjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBz
YTU2MDA0QDRkIHsNCk9rLHRlbXBlcmF0dXJlLXNlbnNvci0yQDRkDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxzYTU2MDA0IjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDRkPjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgfTsN
Cj4gPiArfTsNCj4gPiArDQo+ID4gKyZpMmM0IHsNCj4gPiArICAgICAgIHN0YXR1cyA9ICJva2F5
IjsNCj4gPiArDQo+ID4gKyAgICAgICBydGNANTEgew0KPiA+ICsgICAgICAgICAgICAgICBjb21w
YXRpYmxlID0gIm54cCxwY2YyMTI5IjsNCj4gPiArICAgICAgICAgICAgICAgcmVnID0gPDB4NTE+
Ow0KPiA+ICsgICAgICAgICAgICAgICAvLyBJUlExMF9CDQo+ID4gKyAgICAgICAgICAgICAgIGlu
dGVycnVwdHMgPSA8MCAxNTAgMHg0PjsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+
ID4gK307DQo+ID4gKw0KPiA+ICsmdXNiMCB7DQo+ID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7
DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmdXNiMSB7DQo+ID4gKyAgICAgICBzdGF0dXMgPSAib2th
eSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmY3J5cHRvIHsNCj4gPiArICAgICAgIHN0YXR1cyA9
ICJva2F5IjsNCj4gPiArfTsNCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4NCg==
