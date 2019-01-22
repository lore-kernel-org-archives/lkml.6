Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B826EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D36B20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="okL/+tYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfAVJAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:00:50 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:4161 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfAVJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:00:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,505,1539673200"; 
   d="scan'208";a="25337044"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 22 Jan 2019 02:00:49 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 22 Jan 2019 02:00:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVvGztlstr3tnYFiLxD3n1Oncnpw+IpZWFUZbIkidF8=;
 b=okL/+tYWkTfbLII9oSq+U557ksLGucOKq/dvhFR71aNO5hyqpZKvLSodc54i9RKjGgiDoOlq4Epk5Dhn5mzhuDichmnz+ebDBrcgd4oXr8hOPOUxwwgpp2cq+SGROARtt77a5yQ6nI26iO8Wq4KEGBD2W9KnyRjdl6rRjcOaQ1c=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1438.namprd11.prod.outlook.com (10.172.53.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 09:00:45 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:00:45 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <robh@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <linux-usb@vger.kernel.org>,
        <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
Thread-Topic: [PATCH 2/8] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
Thread-Index: AQHUse7eJn6j2g4QIUa9ciTm4uKYD6W6/gSA
Date:   Tue, 22 Jan 2019 09:00:45 +0000
Message-ID: <24a53365-1a8c-51cd-dcd4-db4a69d5256a@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
 <20190122010733.GA21139@bogus>
In-Reply-To: <20190122010733.GA21139@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::24) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1438;6:6YiMk92JfPE4vv8x/6etDc/Coan7qaDxGK+vJupEp2LLqtVJ1Zr38gVjEbr6O8wARBCxUt1QXbJxVrhvBHCyfG31LrbSi1oePayqSop/EcZ26ozupvBS50OygueFqmdAGX3HmqtAGc/oIzdrUnUuvZSnz6lGI8BflAt4AaIN56Gl7RKmc5Cm/QQwrMm+gttehzCMNPP8SHa0XZZ+Hv5CC1GqUmcXM2OJ3/CS+du6/s85AC2ViGz6VRCFqpGbG2fiuAHC4vE46lsP5GhqfTdKOtuqBvzFtcuAXbKK3Uj34aA52XH7TtyoDDZ/SxXeY4w3fb6mMU8k6/l4se+Se2OUomIcOPZNdHASOEg8vhY0sE4sIpddLWjw68Kz5NNdocTOO91g0/4aAaFWwNbnmpgyLUYfXfAPDRoH7M5Vu2b1ZTBOFbVD1TmH7p7+cGhTFgjSLgu1WzkOFV4ZcZguMv1xWA==;5:HrGhwC24BpY+MXZtQl9hcFMuBw4P4d3CVunpXmTnC/rr5Uw3YpqhjmjpIrUt04RYQY6ARn1nZAXcHCqOiPkayqpHxrTY0vFlQZdFTGPDE/imCsIW5MRHhlODgyNGmfNwDc5iQ56oATjkzTzePopXMkt/8o3Fw+wp2NcVJvjuImbBbW1WuFB3m6uhvx71n1YQGDd9gCzyJo4Tv3QQU7YmEw==;7:/nWn1l5TR+PpMPjXwHW9d2tON8yEMiD/kcRUTnqgzGk1g4dz3DDdI+eDmL6AtkZqITT3maZU/RCy1swIOAaXYj5v0PZ8wrDKLkEFetb2XC9DEnHBpZkyJi7o3K5UzlWvnJfdtRdxQYqEf3m27k4x+g==
x-ms-office365-filtering-correlation-id: 0fe6ebe8-7b0c-4e52-598d-08d680481825
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1438;
x-ms-traffictypediagnostic: MWHPR11MB1438:
x-microsoft-antispam-prvs: <MWHPR11MB14383E7B809B6B14E984B752E0980@MWHPR11MB1438.namprd11.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(199004)(189003)(6512007)(86362001)(105586002)(106356001)(68736007)(8936002)(25786009)(102836004)(478600001)(31696002)(99286004)(31686004)(3846002)(81156014)(6436002)(76176011)(6246003)(52116002)(6116002)(11346002)(6506007)(386003)(229853002)(81166006)(486006)(72206003)(305945005)(53546011)(97736004)(8676002)(2616005)(7736002)(476003)(446003)(53936002)(4326008)(54906003)(14454004)(36756003)(14444005)(66066001)(26005)(6916009)(256004)(71200400001)(6486002)(7416002)(2906002)(316002)(71190400001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1438;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0ALmE8rm+td8l0RzCroxUfPcYyeklSAoYfa0Kl5cI5CLN01iJxx7qku/cfq1YAe6uGFL0GibiA2LUT8SpKtppYm417oDFgObFZNOG+QNnVlCMDYsGE4TH2WtYAuBh0e5zAmYdzoVy19gyUzfE/P8RDhMJP9DcGFPfEC9zm1GTZKETCnQ99+IsiZlzIZqMKS/5JfTw6Fp7Yz5pCy/YNyjopmO1huj/kr4dGp7N2S82V5hnMqjEaRCfYKsYzFh9+/V7Cd+XY9V246hvqAbuF2AU7RJrxguy1SR9ETuhi5H/hijA5RQSuTkvX3If7nQOLF9cEdQB+wdMoQKm7tqGhFn9L3lDsJxbkbNDDj9uBCgM/R7R07SwnPN90lmf4ObQa1ev5lWVWw7s+a5+7HVMCWxaOa1UoyqJOG1+J77q8vrgYA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E409B25D09D6B49A95FB5B0B3251B4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe6ebe8-7b0c-4e52-598d-08d680481825
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:00:42.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1438
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMi8wMS8yMDE5IGF0IDAyOjA3LCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gV2VkLCBKYW4gMTYsIDIwMTkgYXQgMTA6NTc6MzhBTSArMDEwMCwgTmljb2xhcyBGZXJyZSB3
cm90ZToNCj4+IFVwZGF0ZSB0aGUgUmVzZXQgQ29udHJvbGxlcidzIGJpbmRpbmcgdG8gYWRkIG5l
dyBTb0MgY29tcGF0aWJpbGl0eSBzdHJpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTmljb2xh
cyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQgfCAxICsN
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0
DQo+PiBpbmRleCAzNjk1MmNjMzk5OTMuLmJhZGNlNmVmM2FiMyAxMDA2NDQNCj4+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVn
cy50eHQNCj4+IEBAIC0yMiw2ICsyMiw3IEBAIEl0cyBzdWJub2RlcyBjYW4gYmU6DQo+PiAgIFJT
VEMgUmVzZXQgQ29udHJvbGxlciByZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4gICAtIGNvbXBhdGli
bGU6IFNob3VsZCBiZSAiYXRtZWwsPGNoaXA+LXJzdGMiLg0KPj4gICAgIDxjaGlwPiBjYW4gYmUg
ImF0OTFzYW05MjYwIiwgImF0OTFzYW05ZzQ1IiwgInNhbWE1ZDMiIG9yICJzYW14NyINCj4+ICsg
IGl0IGFsc28gY2FuIGJlICJtaWNyb2NoaXAsc2FtOXg2MC1yc3RjIg0KPiANCj4gSG93IGlzIHRo
aXMgcmVsYXRlZCB0byBhdDkxc2FtOTI2MC1yc3RjPw0KDQphdDkxc2FtOTI2MCBhbmQgc2FtOXg2
MCBhcmUgY29tcGxldGVseSBkaWZmZXJlbnQgcHJvZHVjdHMgKHRoZXkgc2hhcmUgDQp0aGUgc2Ft
ZSBjb3JlIHRob3VnaC4uLikuIEkga25vdyB0aGUgbmFtaW5nIGNvdWxkIGJlIG1pc2xlYWRpbmcg
YnV0IGl0IA0KaXMgbGlrZSBpdCBpcy4uLg0KDQo+IFRoZSAneCcgaXMgYSB3aWxkY2FyZD8gV2Ug
Z2VuZXJhbGx5IGF2b2lkIHdpbGRjYXJkcy4NCg0KSGVyZSwgdGhlICd4JyBpcyBkZWZpbml0aXZl
bHkgbm90IGEgd2lsZGNhcmQgbm9yIGEga2luZCBvZiAiZmFtaWx5IiANCm5hbWUsIGl0J3MgaW5j
bHVkZWQgaW4gdGhlICh1cGNvbWluZykgc2luZ2xlIHByb2R1Y3QncyBuYW1lLg0KDQpJIGhvcGUg
aXQgY2xhcmlmaWVzLg0KDQpCZXN0IHJlZ2FyZHMsDQogICBOaWNvbGFzDQoNCj4+ICAgLSByZWc6
IFNob3VsZCBjb250YWluIHJlZ2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQo+PiAgIC0gY2xv
Y2tzOiBwaGFuZGxlIHRvIGlucHV0IGNsb2NrLg0KPj4gICANCj4+IC0tIA0KPj4gMi4xNy4xDQo+
Pg0KPiANCg0KDQotLSANCk5pY29sYXMgRmVycmUNCg==
