Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D26C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0AA214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="dDhyGSLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0AA214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbeISPEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:04:51 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:14466 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727770AbeISPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:04:51 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 19 Sep 2018 18:27:47 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 336E47F4B1;
        Wed, 19 Sep 2018 18:27:47 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,393,1531753200"; 
   d="scan'208";a="292906835"
Received: from mail-os2jpn01lp0150.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.150])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2018 18:27:46 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2b6s8uRrSjSQAs+iuFMv7gjscBiJ+QWYi0ItBUyA+U=;
 b=dDhyGSLCKgyXIa73wn05oZ31IMmMklpNkGqZbtGnSQCsnOYJqA1r+lxO95NPha1uiJqqRmEQDi4y+ykPIisC7h8ZoeUnOHwblGcxLWv/ZmD9lCen/Jgg5H16kbC13IVSYDvoOJMjgba97IWVRR5Ww+gFFcfWfwjbkQNv3HD07ks=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1SPR00MB081.jpnprd01.prod.outlook.com (10.174.228.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Wed, 19 Sep 2018 09:27:43 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97%6]) with mapi id 15.20.1143.014; Wed, 19 Sep 2018
 09:27:43 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Simon Horman <horms@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] ARM: dts: r9a06g032: Add pinctrl node
Thread-Topic: [PATCH v3 3/3] ARM: dts: r9a06g032: Add pinctrl node
Thread-Index: AQHUTqSnOZqOAaKgpEegzg3eDeimu6T3VU4AgAAAh5CAAAHLAIAAAKTA
Date:   Wed, 19 Sep 2018 09:27:43 +0000
Message-ID: <TY1PR01MB1769B445E15C05F342ABCCACF51C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20180917163609.30457-1-phil.edworthy@renesas.com>
 <20180917163609.30457-4-phil.edworthy@renesas.com>
 <20180919091524.rgbk4m6ht34idkpd@verge.net.au>
 <TY1PR01MB17690D4C023EB9B4A5164A2AF51C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdXhDcfXe7ohuO2s4MKHFPc-Z4TRjaTJv-MG0MHga=2viQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXhDcfXe7ohuO2s4MKHFPc-Z4TRjaTJv-MG0MHga=2viQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1SPR00MB081;20:PBD5EGumQ3Ot27ejZkYE5M5kmMCcBEmKJymby3ybd5JFnw33Yzj5BfqehS6ZEpMdvYS6xoLOHMS3I3nfcg5FMfjfBQOhfnsNP+nPMckNbcuESfDmcOHhV57kcbmhwJbnjR4n5Cw/yOKVZOptMOlEVJXncF+BM23xYxPMxnxYhII=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 57ba3cf6-fdcf-4b94-bc10-08d61e122773
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1SPR00MB081;
x-ms-traffictypediagnostic: TY1SPR00MB081:
x-microsoft-antispam-prvs: <TY1SPR00MB08107C6364CB86D4523F9B7F51C0@TY1SPR00MB081.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:TY1SPR00MB081;BCL:0;PCL:0;RULEID:;SRVR:TY1SPR00MB081;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(6436002)(25786009)(97736004)(6116002)(3846002)(81156014)(14454004)(256004)(102836004)(186003)(81166006)(476003)(53546011)(4326008)(6506007)(8936002)(7736002)(9686003)(26005)(8676002)(86362001)(229853002)(2906002)(68736007)(6916009)(6246003)(93886005)(55016002)(305945005)(14444005)(11346002)(74316002)(66066001)(33656002)(7696005)(5250100002)(76176011)(2900100001)(106356001)(478600001)(105586002)(99286004)(54906003)(44832011)(53936002)(486006)(446003)(316002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1SPR00MB081;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MRciE0hk13YyrFDJ/ftMMUWOsFlpEPlkM30N9qSmhNXCDWbxWcCD4jgUnYou6kLVLNiIgnUW2ukQxOsIhMLXIgCulGlkLfRBueJ7GkA3Ln4yCqWJx9PbsQCkrkdxw9f9Uqt5MZnGy15WkhZxQTuCCwkJw1TjKUayDV9JOlVOYAUzANvabDceQBnVgaRwOb4nShqx1RNr/++AbduSNxrzFQOlmSOkeB/xHe8W6zJnJ+m5lOReml5QeZdhhLcaY/FpvEf8vl4hmaQyaxhmJ+dBuePuwt6qEES3eIaJZ1DctpALZc8r1jzQ+C6Sgi4xXONHIsmqx0FreDPSYqUui4er5jIa+7PsnXAdRocCPNVbU2A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ba3cf6-fdcf-4b94-bc10-08d61e122773
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 09:27:43.7963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1SPR00MB081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDE5IFNlcHRlbWJlciAyMDE4IDEwOjI0IEdlZXJ0IFV5dHRlcmhvZXZl
biB3cm90ZToNCj4gT24gV2VkLCBTZXAgMTksIDIwMTggYXQgMTE6MTggQU0gUGhpbCBFZHdvcnRo
eSAgd3JvdGU6DQo+ID4gT24gMTkgU2VwdGVtYmVyIDIwMTggMTA6MTUgU2ltb24gSG9ybWFuIHdy
b3RlOg0KPiA+ID4gT24gTW9uLCBTZXAgMTcsIDIwMTggYXQgMDU6MzY6MDlQTSArMDEwMCwgUGhp
bCBFZHdvcnRoeSB3cm90ZToNCj4gPiA+ID4gVGhpcyBwcm92aWRlcyBhIHBpbmN0cmwgZHJpdmVy
IGZvciB0aGUgUmVuZXNhcyBSOUEwNkcwMzIgU29DDQo+ID4gPiA+DQo+ID4gPiA+IEJhc2VkIG9u
IGEgcGF0Y2ggb3JpZ2luYWxseSB3cml0dGVuIGJ5IE1pY2hlbCBQb2xsZXQgYXQgUmVuZXNhcy4N
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGhpbCBFZHdvcnRoeSA8cGhpbC5lZHdv
cnRoeUByZW5lc2FzLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGFua3MgUGhpbCwgSSB3aWxsIGRlZmVy
IHRoaXMgcGF0Y2ggcGVuZGluZyBhY2NlcHRhbmNlIG9mIHRoZSBiaW5kaW5ncy4NCj4gPiA+IFBs
ZWFzZSBjb250aW51ZSB0byByZXBvc3QgdGhpcyBwYXRjaCB3aXRoIHVwZGF0ZXMgdG8gdGhlIGJp
bmRpbmdzIG9yDQo+ID4gPiBvdGhlcndpc2UgcGluZyBtZSBvbmNlIHRoZXkgaGF2ZSBiZWVuIGFj
Y2VwdGVkLg0KPiA+IFRoYW5rcywgaG93ZXZlciBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIG9m
IHRoaXMgcGF0Y2ggdG8gcmVtb3ZlIHRoZQ0KPiA+IGNsb2NrLW5hbWVzIHByb3AgYXMgaXQgaXMg
bm90IG5lZWRlZC4NCj4gDQo+IEkgaGF2ZW4ndCByZXZpZXdlZCB0aGUgYmluZGluZ3MgcGF0Y2gg
eWV0LCBidXQgaXQncyBhIGdvb2QgaWRlYSB0byBoYXZlDQo+IGNsb2NrLW5hbWVzLCBldmVuIGZv
ciBhIHNpbmdsZSBjbG9jay4NCj4gSXQgbWFrZXMgbGlmZSBlYXNpZXIgaWYgdGhlIHNhbWUgbW9k
dWxlIGlzIHJldXNlZCBvciBlbmhhbmNlZCBpbiBhIGxhdGVyIFNvQywNCj4gd2l0aCBtb3JlIGNs
b2NrIGlucHV0cy4NCk9rLCBJJ2xsIHB1dCBpdCBiYWNrIDopDQoNCkkgc2hvdWxkIGJlIGFibGUg
dG8gZ2V0IGEgbmV3IHZlcnNpb24gb3V0IHRvZGF5IHNvIHlvdSBtYXkgd2FudCB0byBkZWxheQ0K
eW91ciByZXZpZXcgdW50aWwgdGhlbi4NCg0KVGhhbmtzDQpQaGlsDQo=
