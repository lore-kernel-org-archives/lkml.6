Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61024C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CC920685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="nabzhB5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfAIWOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:14:40 -0500
Received: from mail-eopbgr1410090.outbound.protection.outlook.com ([40.107.141.90]:62508
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfAIWOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MyvGLHluvwXNDnIwypYgGylyp5CHozduNRS9X0Wf0o=;
 b=nabzhB5hWzuKkpC5YPJ5lm+X34Ev5mVaar/Muzv9Kyz4ExcpMpcXgREmynq7SSfFy4G8rNpOPwuPz+XmRqbWsMkG2Cq+3D/ZVcc1VZ39a3113dIANzkh7xDvDeGJTuoYgCzSGa4waCc3Tm4QP1Xgzo+jJU6+YT+3UmYwc7Jf/1w=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) by
 TY1PR01MB1833.jpnprd01.prod.outlook.com (52.133.164.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 22:14:32 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::c8a8:4288:e40f:4b43]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::c8a8:4288:e40f:4b43%4]) with mapi id 15.20.1516.015; Wed, 9 Jan 2019
 22:14:32 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "juliensu@mxic.com.tw" <juliensu@mxic.com.tw>,
        Simon Horman <horms@verge.net.au>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>
Subject: RE: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Thread-Topic: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Thread-Index: AQHUpwkg7+dUfv33EUeO+vgiy0ZK06WnSY8AgAAAgoCAAAQHAIAAM27w
Date:   Wed, 9 Jan 2019 22:14:32 +0000
Message-ID: <TY1PR01MB1562410F21A3523037D9BCB88A8B0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
 <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
 <CAMuHMdUPsN-VMhbttVK19gL_nPdaCTHHC7Dn3ajPoVhMqDJf_w@mail.gmail.com>
 <a4373a7f-07c4-baff-30a3-d1f5a294e1bb@cogentembedded.com>
In-Reply-To: <a4373a7f-07c4-baff-30a3-d1f5a294e1bb@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1833;20:wVIO/zMgMF6Y4BRhti9cXo322fRaCj9AyFyE8mdsISYZRimTASCThWBIVqs6i3EqC76hODCE4l5hUVWj4F5TDHdMt+nWB63XHgWagpaoabntGAsaDsXztqvIM6MkEnlQcmdR+s6KNrTAaZlRLqE0XkISHVE0Npr4QLyG5/pxsgQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 25f0039f-1641-48df-61f9-08d6767fd4f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1833;
x-ms-traffictypediagnostic: TY1PR01MB1833:
x-microsoft-antispam-prvs: <TY1PR01MB18330CFD2CA270AE0D1339CD8A8B0@TY1PR01MB1833.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1833;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1833;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(6246003)(6116002)(7416002)(71200400001)(71190400001)(68736007)(25786009)(229853002)(2906002)(3846002)(256004)(486006)(66066001)(5660300001)(105586002)(106356001)(97736004)(53936002)(81156014)(76176011)(39060400002)(316002)(110136005)(54906003)(99286004)(74316002)(7696005)(81166006)(6506007)(86362001)(93886005)(26005)(476003)(72206003)(11346002)(33656002)(305945005)(446003)(478600001)(186003)(7736002)(8936002)(14454004)(9686003)(4326008)(8676002)(6436002)(102836004)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1833;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G8MK9YWzT9uPPf5+djh2TvFzvJbbCqAhEa9z7N4FjBdlX5Ja2M100t/AawL39qEEVZ2rooZYKjEsKvsmxaJ8NH55khNrhnpVQywtmpOJI1AOVnPKdPLrTrkWt6OhOh8OyoWaqZtS1puP03YfmSMVC/5CRjqF4qaOFPS4MSJzq3DAxi1FTawN3JCJmlHCK5wbxWsMVHQkJFAIWDmwZ6h0bSatRGl3wvmXq2GetdCwKG+EIhdSRbZ+V5MRyePakBu66e25gYqH9Jir9LltMRf9n9mQaF+0azdi6sFWbLzlFrtwgo9ZoYTWFpZiUuab8Wnd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f0039f-1641-48df-61f9-08d6767fd4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 22:14:32.4298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkbmVzZGF5LCBKYW51YXJ5IDA5LCAyMDE5LCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6DQo+
ID4gSUlSQywgdGhpcyBoYXJkd2FyZSBibG9jayBpcyBhbHNvIHVzZWQgb24gUlovQSwgd2hpY2gg
aXMgMzItYml0Lg0KPiANCj4gICBJJ20gbm90IHNlZWluZyBpdCBpbiB0aGUgIlJaL0ExSCBHcm91
cCwgUlovQTFNIEdyb3VwIFVzZXLigJlzIE1hbnVhbDoNCj4gSGFyZHdhcmUiDQo+IFJldiAzLjAw
LiBXaGF0IFNvQyBkaWQgeW91IGhhdmUgaW4gbWluZD8NCg0KRm9yIHRoZSBSWi9BIHNlcmllcyAo
YW5kIFJaL1Qgc2VyaWVzKSwgaXQgaXMgY2FsbGVkIHRoZQ0KIlNQSSBNdWx0aSBJL08gQnVzIENv
bnRyb2xsZXIiIChDaGFwdGVyIDE3KQ0KDQpJIGhhdmUgbm8gaWRlYSB3aHkgaXQgaGFzIGEgZGlm
ZmVyZW50IG5hbWUgZm9yIHRoZSBzYW1lIGhhcmR3YXJlIChhbmQNCnRoZSBzYW1lIHBhZ2VzIGlu
IHRoZSBtYW51YWwpLg0KDQpUaGUgSFcgdmVyc2lvbiBpbiBSWi9BMSBkb2VzIG5vdCBoYXZlIEh5
cGVyUkFNLg0KDQpCdXQgdGhlIEhXIHZlcnNpb24gaW4gUlovQTIgaXMgdGhlIHNhbWUgYXMgd2hh
dCBpcyBpbiBSLUNhciBHZW4zLg0KDQpDaHJpcw0KDQo=
