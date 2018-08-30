Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4917AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68DA2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LmOldfhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68DA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeH3Lhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:37:43 -0400
Received: from mail-he1eur01on0050.outbound.protection.outlook.com ([104.47.0.50]:32611
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727344AbeH3Lhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n69RsuCyZy2duNJBUcjqFSLM2tKgomHWR5WC8CcS2Z8=;
 b=LmOldfhnwZ/WlkTJ0ZIyIrOxs4+pCh/0xADhwW1OKQ88DnFW4yRXChhaJnpxxryYwJHSYafu08THlwfK8421YmRjACrh7EJsMyt0IwG00m8O/AuE0xRGvLalxekaoHlbSWnT5/ViVUsoTOS5LbDamwHOVI3GFC4p6O8Av4eRT/Q=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4864.eurprd04.prod.outlook.com (20.177.49.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Thu, 30 Aug 2018 07:36:49 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::f423:2448:a3d4:44ce]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::f423:2448:a3d4:44ce%5]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 07:36:49 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
CC:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Andy Tang <andy.tang@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUOLbmqZNgrYzKRUCQPUKjb5dGKKTV6koAgAIK3+A=
Date:   Thu, 30 Aug 2018 07:36:48 +0000
Message-ID: <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
         <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
 <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
In-Reply-To: <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4864;6:6wF/gD2Y5rl7XyYk6c2UJ2uVgpj0I7fTBGPWfsW+EBy8AeCJ3bg4iRIK/j/B1U4BRtufP8FVN9xs1FMhCp1S4op09pfakwyMcoGnTyNGj1vcqxrjGofx+Yq7nVkIqrewgBg6b85Ob02UnvSUHssVbMXsUfoLUPNNvaG64o4hUo2GOWfdLYb+DjZAg0rWQE3aL2KPuQhkgXEZQDwtQ+pQl6rTKTBdR/FAJ3elGHKlG+jbh1qUrsCPDll/U04mnUf/bPXACwyqG53mVHfXGj9Z5Ngssalu4TFhi3UlSDMG+0T6UPXk0Zs9CFs5bOvUgCWH9bdWjQWpUwvIeXctwfpwYWs5KzmwvwmTF14bvAZ2XkLRGDa0U2I4DPNX4rJ6tvsA82Brn+qmQLRCtKLAyf4ks6cu+3U7vVG/TNf3VM9m7VonVYTdeAQpLZdZ1t54jPkcHYs0/UQHlnExkd/qWpoJYg==;5:qsmbGIV48eFU2WJ9NeVFqGpvQ19op1rCYhm37ABXBpH8uPpx41sP1LyzDLkdhGEWmaMKiELnESPOR65Liiq61ziJVQEufH6ZLzLXnzssKernpawCwZBt6taWuBr9iKWcVgxK+1zJfRI3lSgwGZ+OWbvgNLEfksZTZGQflbNZ3SI=;7:0DkMaKKc68YpgS4iyBprktX0t6hWDYmjRQhM+gceZ6fuYO0tBHgCx7CrHJfBY8O/koO0G7nfsG2OwLFPvgkgTPN8xjrivjCMm2PNH069xUsiC7kSM93KZbObFt/Q9HbwPJLaV2ap8RG6LGufNDcrycrXCn4om7uGEGBOiJeBt5GrMtx4bX9Nv8MhLzUbo9RPIa+Wz7UiZwZ2OohQ/4dEDsme5E6Ioyt2u5qcXVIH4VxgeFmfaCtNi9c/UeH6rtvg
x-ms-office365-filtering-correlation-id: 36f09237-ee56-4478-a387-08d60e4b58a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4864;
x-ms-traffictypediagnostic: VI1PR04MB4864:
x-microsoft-antispam-prvs: <VI1PR04MB48647646E5441CAB6670F921F3080@VI1PR04MB4864.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:VI1PR04MB4864;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4864;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(13464003)(229853002)(8676002)(66066001)(53546011)(6506007)(2201001)(14444005)(316002)(186003)(4326008)(26005)(2906002)(256004)(478600001)(7416002)(102836004)(486006)(53936002)(476003)(7736002)(44832011)(305945005)(110136005)(6436002)(55016002)(74316002)(25786009)(446003)(86362001)(6246003)(11346002)(54906003)(14454004)(9686003)(8936002)(5660300001)(81156014)(99286004)(81166006)(7696005)(76176011)(97736004)(5250100002)(2501003)(68736007)(106356001)(3846002)(6116002)(105586002)(2900100001)(33656002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4864;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1wkBD2h8Dvc+upspp2MeQ9vlgzgTnAnTS/BCJDwSsEkvTwlgGCX0CSfPLjE6fyAuyZ4pq9/P2MXnXrNj4Yv7+YsGaDs3U0jvYcoOx1F7NpYYakrQ09F3Mm/p/eZ0UnJJJ4izcS3Hq0by3KWuAuuSwLaOfnE/jE3Q3RzVAEDJdWt8v5AOzSVWfaOq7Y5X9W+tVqRswORjTojCPHIETdGoa+eCl+66pgkPSkEHeAVA2Q42ckwd285m51oVuwpfm1+D+FH1yRdW/veV1lVZhSUmaqJHd4JNC9Wms1Qy6HdLPnyQd4vVjBEfTiTAdqTFJ2q6UbbI5SW/NE8jnq6XDfSbkyVl5AaO115qHn2d1TS/XHk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f09237-ee56-4478-a387-08d60e4b58a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 07:36:48.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBTY290dCBXb29kDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI5
LCAyMDE4IDU6NDkgQU0NCj4gVG86IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNv
bT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGlu
dXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOw0K
PiByandAcmp3eXNvY2tpLm5ldDsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IGxpbnV4LWNsa0B2
Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
LW93bmVyQHZnZXIua2VybmVsLm9yZzsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwu
ZGVhY29uQGFybS5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBhcm5kQGFybmRi
LmRlOw0KPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyB5YW1hZGEubWFzYWhpcm9Ac29j
aW9uZXh0LmNvbQ0KPiBDYzogWW9nZXNoIE5hcmF5YW4gR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVy
QG54cC5jb20+OyBBbmR5IFRhbmcNCj4gPGFuZHkudGFuZ0BueHAuY29tPjsgVWRpdCBLdW1hciA8
dWRpdC5rdW1hckBueHAuY29tPjsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBWYXJ1biBTZXRo
aSA8Vi5TZXRoaUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNV0gZHJpdmVyczog
Y2xrLXFvcmlxOiBBZGQgY2xvY2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYQ0KPiANCj4gT24gTW9u
LCAyMDE4LTA4LTIwIGF0IDEyOjE3ICswNTMwLCBWYWJoYXYgU2hhcm1hIHdyb3RlOg0KPiA+IEZy
b206IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPg0KPiA+IEFk
ZCBjbG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBhLg0KPiA+IEFkZGVkIGVudHJ5IGZvciBjb21w
YXQgJ2ZzbCxseDIxNjBhLWNsb2NrZ2VuJy4NCj4gPiBBcyBMWDIxNjBBIGlzIDE2IGNvcmUsIHNv
IG1vZGlmaWVkIHZhbHVlIGZvciBOVU1fQ01VWA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFu
ZyBZdWFudGlhbiA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9nZXNo
IEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZh
YmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9jbGsvY2xrLXFvcmlxLmMgICAgICAgICB8IDE0ICsrKysrKysrKysrKystDQo+ID4gIGRyaXZl
cnMvY3B1ZnJlcS9xb3JpcS1jcHVmcmVxLmMgfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2xrL2Nsay1xb3JpcS5jIGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgaW5kZXgNCj4g
PiAzYTE4MTJmLi5mYzZlMzA4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1xb3Jp
cS5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMNCj4gPiBAQCAtNjAsNyArNjAs
NyBAQCBzdHJ1Y3QgY2xvY2tnZW5fbXV4aW5mbyB7ICB9Ow0KPiA+DQo+ID4gICNkZWZpbmUgTlVN
X0hXQUNDRUwJNQ0KPiA+IC0jZGVmaW5lIE5VTV9DTVVYCTgNCj4gPiArI2RlZmluZSBOVU1fQ01V
WAkxNg0KPiA+DQo+ID4gIHN0cnVjdCBjbG9ja2dlbjsNCj4gPg0KPiA+IEBAIC01NzAsNiArNTcw
LDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xvY2tnZW5fY2hpcGluZm8gY2hpcGluZm9bXSA9
IHsNCj4gPiAgCQkuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExFX0VORElBTiwNCj4gPiAgCX0s
DQo+ID4gIAl7DQo+ID4gKwkJLmNvbXBhdCA9ICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIsDQo+ID4g
KwkJLmNtdXhfZ3JvdXBzID0gew0KPiA+ICsJCQkmY2xvY2tnZW4yX2NtdXhfY2dhMTIsICZjbG9j
a2dlbjJfY211eF9jZ2INCj4gPiArCQl9LA0KPiA+ICsJCS5jbXV4X3RvX2dyb3VwID0gew0KPiA+
ICsJCQkwLCAwLCAwLCAwLCAxLCAxLCAxLCAxLCAtMQ0KPiA+ICsJCX0sDQo+ID4gKwkJLnBsbF9t
YXNrID0gMHgzNywNCj4gPiArCQkuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExFX0VORElBTiwN
Cj4gPiArCX0sDQo+IA0KPiBXaHkgYXJlIHlvdSBpbmNyZWFzaW5nIE5VTV9DTVVYIGJleW9uZCA4
IGZvciBhIGNoaXAgdGhhdCBvbmx5IGhhcyA4DQo+IGVudHJpZXMgaW4gY211eF90b19ncm91cD8N
CkNvbmZpZ3VyYXRpb24gaXMgMTYgY29yZXMsOCBjbHVzdGVyIHdpdGggMiBjb3JlcyBpbiBlYWNo
IGNsdXN0ZXINCj4gDQo+IC1TY290dA0KDQo=
