Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4E2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FCF206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BcjLwmYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FCF206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbeIYAZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:25:27 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:23232
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728455AbeIYAZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1/IP9CqYoS9UJo0hCTFWvL1mTX5NzV06jwvG0MVDKs=;
 b=BcjLwmYBm3CwKXaiCEwQV3VMW3G03E3gpBT0KHuoqDgoOIOcq2ld6+h6PHW1SGmEcFyujVugHUBpnWQsRh/ABJ8SI2FHPbDtgkkpaKCKHjq75tfQsB59G0YkNeHBjjJKewv64mKYvwzHL484yWdDTDsOdulOylpXA5DH90XxyFU=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1118.namprd02.prod.outlook.com (10.163.15.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 18:21:57 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1143.019; Mon, 24 Sep 2018
 18:21:55 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Olof Johansson <olof@lixom.net>
CC:     Michal Simek <michals@xilinx.com>,
        "arm@kernel.org" <arm@kernel.org>, Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP
 core
Thread-Topic: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP
 core
Thread-Index: AQHUStBI6TetFFdXe0yJGHiWqofw86T5bOTggAR75ICAAeeqsA==
Date:   Mon, 24 Sep 2018 18:21:55 +0000
Message-ID: <CY1PR02MB21380A6ED51FD3C8C75EB309B8170@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
 <CY1PR02MB21385F71D8BC4498654CD0BFB8130@CY1PR02MB2138.namprd02.prod.outlook.com>
 <CAOesGMgUaQMcTQsbLR_qN95QPfOE1gCJuM9=6AiFLg+_t98qaw@mail.gmail.com>
In-Reply-To: <CAOesGMgUaQMcTQsbLR_qN95QPfOE1gCJuM9=6AiFLg+_t98qaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1118;6:k0tY1YZe0rnuGv8ib1Kz2exb/cX4IRZ6vz17H8SV65Its2/4kX2m183oW27t+dbrnv8tn5zw8qyMGGrfJcvQ2wCzgl6V+VnvcQ08WWH4oNxgKpPRYfGSOVn0UXsPvo8CdO3hbrbtj4vDAledqhtlc/AbsZHphZ9ovev+oNUA5LlieUZ+9v5oXONjfXSniM05FUJJcpRXSO/h8sWJv3I13q45lIk3F8AQo54QWqJf0gyWmgh38K2Iu9OtMz7wprImxa4Smu55RhirTMd4SAg8+6YTPwcaiOGhqx9G40JjCfutF6rOVY1e/QWkfnkorgu936Ttoix0HlA3CF7LzO+9GUBafKUNwTcjiydTTVU4vbjxtdrU08thqOKoCT58Gp5gbCGAYg3F708dLKzY9l5rOQYu96N5gXnoNHQMLmszJYE2qgr6fciK0mTnusDkPZ+whVeWkjgFY/6lazsiwjmY4g==;5:xwzNCiXWZ602t6frX/zGQVG3G9H8eKCXDRJA6u7BAHVtcVvI+rTzs0PwWL95X6dHkaUF/WReeyxObVS6FCrUhSlum2zaJQkzwLntluYEyNhyCaoAhCZpEH2gynPXG8ZOgdwB/3MOWZQ7kti3gxe3XkxXJ9GZNivdsaFl8OHlXps=;7:46hU26DKcmCcVDCOOu6nncygal0R9tlcNVjwI9YSR+YuL+yDz1I/DpWhgaqgyF6UvBdPCTqz3kZ5Zob3DaRkF5+omhfaW4xoQAc/gcus8r7SXgQ4pBKWg6ArtCrI3VFeuemq5DIAbDZv5lOdzqqXV/PvUIt7k/00fPg/kSSHHbSy13LtWdDKhCzvueSlRJduxqfR4vQcrxPXaFu/myjaJxsxtzEMie0P+CAnV06D7vgpdnpkhrmy6ZWcVKeVS+Cn
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(136003)(376002)(43544003)(51444003)(199004)(189003)(13464003)(5660300001)(9686003)(3846002)(6116002)(76176011)(8676002)(6246003)(446003)(66066001)(8936002)(81156014)(81166006)(4326008)(476003)(6506007)(486006)(53546011)(33656002)(11346002)(102836004)(26005)(68736007)(25786009)(7696005)(74316002)(7736002)(305945005)(478600001)(54906003)(186003)(229853002)(2900100001)(6436002)(5250100002)(316002)(99286004)(53936002)(6916009)(97736004)(72206003)(106356001)(105586002)(55016002)(14454004)(14444005)(71200400001)(86362001)(71190400001)(256004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1118;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: f4675d5a-040b-48ae-645e-08d6224a9bfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1118;
x-ms-traffictypediagnostic: CY1PR02MB1118:
x-microsoft-antispam-prvs: <CY1PR02MB1118753FD4C12C4500868F09B8170@CY1PR02MB1118.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:CY1PR02MB1118;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1118;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2MKBKRecRz6s65FXWuZdBqXwvLtvpkpOLUiMxY3dP+n0wRPAfLHerVxGsBt85ZUEsN0OSew50GLKberMSXo2etLp+VBMwDsUAn37/vqmfhaOunlbIgipXGLg/OO+VKI28HTFvInXuIol61r0n6Nkecju4pEl75d84Cgj4k8jS0R1gDMMXBmZqeebFPwZ8LIcIgVIoxZRkAJdYqNeC0InZNmYBDgE9gNPZEJyWqPtjPQlf9Bv3n9g8lOltgrG9mqO64liwZSsZfpvEGp2q18IJjBVOFY2jLDPVDUkqMrC/s/SolRwOqbckSlOPXv59+80XkGeziOFaG7M+bIM0y7xjljH0irMn9cWJshVQMBXPws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4675d5a-040b-48ae-645e-08d6224a9bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 18:21:55.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xvZiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbG9mIEpv
aGFuc3NvbiBbbWFpbHRvOm9sb2ZAbGl4b20ubmV0XQ0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJl
ciAyMywgMjAxOCA2OjEzIEFNDQo+IFRvOiBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4N
Cj4gQ2M6IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgYXJtQGtlcm5lbC5vcmc7
IFJhamFuIFZhamENCj4gPFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxMiAwLzZdIGRyaXZlcnM6IEludHJvZHVjZSBmaXJtd2FyZSBkcml2
ZXIgZm9yIFp5bnFNUCBjb3JlDQo+IA0KPiBPbiBUaHUsIFNlcCAyMCwgMjAxOCBhdCA1OjQ2IFBN
LCBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gSGkgT2xvZiwNCj4g
Pg0KPiA+IEFzIHN1Z2dlc3RlZCwgdGhpcyBwYXRjaHNldCBpcyBnZW5lcmF0ZWQgd2l0aG91dCBp
b2N0bCBpbnRlcmZhY2UuIFBsZWFzZSByZXZpZXcuDQo+IElmIHlvdSBhcmUgb2ssIE1pY2hhbCBj
YW4gY3JlYXRlIGEgcHVsbCByZXF1ZXN0IGZvciBtZXJnZS4NCj4gDQo+IEhpLA0KPiANCj4gSSBy
ZXBsaWVkIG9uIHRoZSBvdGhlciB0aHJlYWQgYXMgd2VsbDsgaXQgc291bmRzIGxpa2UgeW91IHdp
bGwgbmVlZCBzb21ldGhpbmcNCj4gX2xpa2VfIHRoZSBpb2N0bCBpbnRlcmZhY2UgZm9yIHNvbWUg
b2YgdGhlIGRlcGVuZGVudCBkcml2ZXJzLiBGb3IgdGhvc2UsIHdvdWxkIGl0DQo+IGJlIHBvc3Np
YmxlIHRvIG9ubHkgZXhwb3NlIHNvbWUgb2YgdGhlIGlvY3RscyB0aHJvdWdoIHRoZSBpbnRlcmZh
Y2UsIGFuZCBub3QganVzdA0KPiBwYXNzIHRocm91Z2ggYW55IGNhbGw/IEkgdGhpbmsgdGhhdCdk
IHByb2JhYmx5IHRha2UgY2FyZSBvZiBteSBjb25jZXJuLg0KPiANCg0KU291bmRzIGdvb2QuIEkg
d2lsbCBtYWtlIHJlcXVpcmVkIGNoYW5nZXMgYW5kIHN1Ym1pdCBhcyBpbmNyZW1lbnRhbCBwYXRj
aGVzIGFsb25nIHdpdGggY2xvY2sgZHJpdmVyLg0KDQo+IEJ1dCB5ZWFoLCBnbyBhaGVhZCBhbmQg
c3RhZ2UgdGhlc2UgaW4gYSBwdWxsIHJlcXVlc3QgZm9yIG5vdywgdGhhdCB3YXkgd2UgY2FuDQo+
IHRha2UgY2FyZSBvZiB0aGVzZSBhbmQgbWVyZ2UgdGhlbSBhcyB0aGUgcmVzdCBhcmUgZ2V0dGlu
ZyByZWFkeS4gSSBkb24ndCB3YW50IHRvDQo+IGhvbGQgeW91IHVwIG1vcmUgdGhhbiBuZWVkZWQ7
IHRoZSBwYXRjaCBzZXQgaXMgYWxyZWFkeSB1cCB0byBhIHZlcnkgaGlnaCB2ZXJzaW9uDQo+IG51
bWJlciBhbmQgaXQncyBub3QgZmFpciB0byBtYWtlIHlvdSByZXdvcmsgaXQgY29tcGxldGVseSB5
ZXQgYWdhaW4uDQo+IA0KPiANCg0KVGhhbmtzLiBNaWNoYWwgd2lsbCBjcmVhdGUgcHVsbCByZXF1
ZXN0IGZvciBzYW1lLg0KDQpUaGFua3MsDQpKb2xseSBTaGFoDQoNCj4gDQo+IC1PbG9mDQo=
