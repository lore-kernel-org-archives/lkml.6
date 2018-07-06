Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEACBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD2B24019
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lefmLfoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD2B24019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeGFKyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:54:41 -0400
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:10757
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753575AbeGFKyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqE8eUvqYxv1pVQjlid5Zah+X1JaPCSxFDT823K26h4=;
 b=lefmLfoMyPF15ilsfQgTygAwpNda86j8iN3erAK8CEtWoP+HHjUYOzcao42DwaUxFJlDU8L8TbjeG4EndFadybM9HSK3LvV9OsoJpsBwwBCI+TwIWuAK+G44yXm65IJFGtTWEF8ZtDYCqwhP9COvEcHPZEpqo7vGaIT1Fln6G2w=
Received: from CY1PR02MB2091.namprd02.prod.outlook.com (10.166.190.27) by
 CY1PR02MB1335.namprd02.prod.outlook.com (10.161.170.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Fri, 6 Jul 2018 10:54:37 +0000
Received: from CY1PR02MB2091.namprd02.prod.outlook.com
 ([fe80::dc2d:c2b6:abc2:b60a]) by CY1PR02MB2091.namprd02.prod.outlook.com
 ([fe80::dc2d:c2b6:abc2:b60a%7]) with mapi id 15.20.0906.027; Fri, 6 Jul 2018
 10:54:34 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
 CLK_OF_DECLARE_DRIVER
Thread-Topic: [PATCH] clk: clk-fixed-factor: Use new macro
 CLK_OF_DECLARE_DRIVER
Thread-Index: AQHTtuf/CFgaaA2KSEWVdsmwI1dm/aPIOgOAgAAMc1CACWfIAIABDRAggEtTqACALvxzAIAC8YtwgDLEd7A=
Date:   Fri, 6 Jul 2018 10:54:34 +0000
Message-ID: <CY1PR02MB20919D7E8B2856904AD332D6B7470@CY1PR02MB2091.namprd02.prod.outlook.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
 <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
 <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <152113963269.111154.10395846178696174140@swboyd.mtv.corp.google.com>
 <SN4PR0201MB35029B265E608A24130BFEE2B7D70@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <CY1PR02MB20914DBB65A193DED2BEED92B7870@CY1PR02MB2091.namprd02.prod.outlook.com>
 <152792163637.225090.8916381060805852261@swboyd.mtv.corp.google.com>
 <CY1PR02MB2091426610FC0037BB9EF61BB7670@CY1PR02MB2091.namprd02.prod.outlook.com>
In-Reply-To: <CY1PR02MB2091426610FC0037BB9EF61BB7670@CY1PR02MB2091.namprd02.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1335;7:FL6iCeKNeXC8fj0qwDJEEpiAMOqWb/myJ5/U6yOaDz3SUK1YNxyGgEdLxo8s13vkArXODQXundTEu9t4nWvNRT1aMRYEFQfOCYA3nrgwIDChbdoShNR3/vCY0EKDHVSwPwnU7hz2PkVd55Pll1tMhdUTWayYe2UkflTcuUkfWJxIWHotJI8wTAS1NUoGN8UU8QaIVmf/9XdqmFhO0f2wBTVhw8fCjVu0lFLgAKm24EmzKHcLEF5oynOheTDBu+9b
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(51914003)(189003)(199004)(13464003)(53936002)(4326008)(54906003)(97736004)(25786009)(5250100002)(45080400002)(86362001)(11346002)(72206003)(7696005)(966005)(256004)(6436002)(33656002)(81156014)(81166006)(6116002)(93886005)(478600001)(2906002)(8936002)(6916009)(5660300001)(66066001)(3846002)(14454004)(68736007)(102836004)(8676002)(7736002)(305945005)(99286004)(6506007)(53546011)(106356001)(26005)(76176011)(105586002)(186003)(2900100001)(316002)(446003)(9686003)(6306002)(476003)(55016002)(6246003)(486006)(74316002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1335;H:CY1PR02MB2091.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 70c84c0e-cdd8-4732-dcf8-08d5e32edc71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1335;
x-ms-traffictypediagnostic: CY1PR02MB1335:
x-microsoft-antispam-prvs: <CY1PR02MB13359D7CFC9AEB645772E0ECB7470@CY1PR02MB1335.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1335;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1335;
x-forefront-prvs: 0725D9E8D0
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FkJ+EocJUxdsEvP0cxROoYNQ70zLf2NrtCGFDPA89fqwAaZ+BdB92AlKpmcnKKxrR9JkSFswsXT6zDfTo4fFv5ifzroLfB5vBI0dfd+Axnkhf8braou4mPn9pDThFIzNJdLzzf8f+bel0b0UtQ5Ifty0rFJ+675VGdCkiekVj7NEEpXHplpXYzTG+wnaZ2kalA+eQJxiUEp2L6VAiW22bSXkvPwZ+ghYGxNjtYI29AOR32tYrJDhO+3VD+dYeL44rFj6aIcY/LjTQ9FN6LnPoKUmtuKjcBFV0YDv7aHCgvynPA1CUovrgQggiLNyfVJwGCAhJRT/9EtjHmaPRZKMwtdpa2iheXqZqDYpETpAMEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c84c0e-cdd8-4732-dcf8-08d5e32edc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 10:54:34.8212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWph
biBWYWphDQo+IFNlbnQ6IDA0IEp1bmUgMjAxOCAwOToxMSBBTQ0KPiBUbzogJ1N0ZXBoZW4gQm95
ZCcgPHNib3lkQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKb2xseSBTaGFoDQo+IDxKT0xMWVNAeGlsaW54
LmNvbT47IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsNCj4gbXR1cnF1ZXR0ZUBi
YXlsaWJyZS5jb20NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gY2xrOiBjbGstZml4ZWQtZmFjdG9y
OiBVc2UgbmV3IG1hY3JvDQo+IENMS19PRl9ERUNMQVJFX0RSSVZFUg0KPiANCj4gSGkgU3RlcGhl
biwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcGx5Lg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IFN0ZXBoZW4gQm95ZCBbbWFpbHRvOnNib3lkQGtlcm5lbC5v
cmddDQo+ID4gU2VudDogMDIgSnVuZSAyMDE4IDEyOjExIFBNDQo+ID4gVG86IFJhamFuIFZhamEg
PFJBSkFOVkB4aWxpbnguY29tPg0KPiA+IENjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKb2xseSBTaGFoDQo+ID4gPEpPTExZU0B4aWxp
bnguY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiA+IG10dXJxdWV0
dGVAYmF5bGlicmUuY29tDQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSF0gY2xrOiBjbGstZml4ZWQt
ZmFjdG9yOiBVc2UgbmV3IG1hY3JvDQo+ID4gQ0xLX09GX0RFQ0xBUkVfRFJJVkVSDQo+ID4NCj4g
PiBRdW90aW5nIFJhamFuIFZhamEgKDIwMTgtMDUtMDMgMDI6MTg6MzApDQo+ID4gPiBIaSBTdGVw
aGVuLA0KPiA+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4g
RnJvbTogUmFqYW4gVmFqYQ0KPiA+ID4gPiBTZW50OiAxNiBNYXJjaCAyMDE4IDA1OjIwIFBNDQo+
ID4gPiA+IFRvOiAnU3RlcGhlbiBCb3lkJyA8c2JveWRAa2VybmVsLm9yZz4NCj4gPiA+ID4gQ2M6
IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEpvbGx5IFNoYWgNCj4gPiA+ID4gPEpPTExZU0B4aWxpbnguY29tPjsgTWljaGFsIFNpbWVrIDxt
aWNoYWxzQHhpbGlueC5jb20+Ow0KPiA+ID4gPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbQ0KPiA+
ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBjbGs6IGNsay1maXhlZC1mYWN0b3I6IFVzZSBuZXcg
bWFjcm8NCj4gPiA+ID4gQ0xLX09GX0RFQ0xBUkVfRFJJVkVSDQo+ID4gPiA+DQo+ID4gPiA+IEhp
IFN0ZXBoZW4sDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuDQo+ID4g
PiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9t
OiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiA+ID4gPiA+IFNlbnQ6
IDE2IE1hcmNoIDIwMTggMTI6MTcgQU0NCj4gPiA+ID4gPiBUbzogUmFqYW4gVmFqYSA8UkFKQU5W
QHhpbGlueC5jb20+DQo+ID4gPiA+ID4gQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEpvbGx5IFNoYWgNCj4gPiA+ID4gPiA8Sk9MTFlT
QHhpbGlueC5jb20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+ID4gPiA+
ID4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20NCj4gPiA+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENI
XSBjbGs6IGNsay1maXhlZC1mYWN0b3I6IFVzZSBuZXcgbWFjcm8NCj4gPiA+ID4gPiBDTEtfT0Zf
REVDTEFSRV9EUklWRVINCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFF1b3RpbmcgUmFqYW4gVmFqYSAo
MjAxOC0wMy0wOSAxMToyNzo0MCkNCj4gPiA+ID4gPiA+ID4gRnJvbTogU3RlcGhlbiBCb3lkIFtt
YWlsdG86c2JveWRAa2VybmVsLm9yZ10NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSXMg
dGhlIGludGVudCB0byByZWdpc3RlciB0aGUgY2xrIHR3aWNlPyBJIGJlbGlldmUgdGhpbmdzIGFy
ZSB3b3JraW5nIGFzDQo+ID4gPiA+ID4gPiA+IGludGVuZGVkIHdpdGhvdXQgdGhpcyBwYXRjaCwg
c28gbWF5YmUgeW91IGNhbiBleHBsYWluIGEgbGl0dGxlIG1vcmUNCj4gPiB3aGF0DQo+ID4gPiA+
ID4gPiA+IHlvdSdyZSB0cnlpbmcgdG8gZml4Lg0KPiA+ID4gPiA+ID4gW1JhamFuXSBZZXMuIER1
cmluZyBvZl9jbGtfaW5pdCgpIGlmIHNvbWUgRFQgZml4ZWQgZmFjdG9yIGNsb2NrIGhhcw0KPiA+
ID4gPiA+ID4gcGFyZW50IHdoaWNoIGlzIG5laXRoZXIgbWVudGlvbmVkIGluIG91dHB1dC1jbG9j
ay1uYW1lcyBvZiBjbG9jaw0KPiA+ID4gPiA+ID4gY29udHJvbGxlciBub3IgcmVnaXN0ZXJlZCBh
cyBjbG9jayBwcm92aWRlciwgb2ZfY2xrX2luaXQoKSB3aWxsIHRyeSB0bw0KPiA+ID4gPiA+ID4g
Zm9yY2VmdWxseSByZWdpc3RlciBpbiBzZWNvbmQgbG9vcC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZm9yY2UgfHwgcGFyZW50X3JlYWR5KGNs
a19wcm92aWRlci0+bnApKSB7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAvKiBEb24ndCBwb3B1bGF0ZSBwbGF0Zm9ybSBkZXZpY2VzICov
DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9mX25vZGVfc2V0
X2ZsYWcoY2xrX3Byb3ZpZGVyLT5ucCwNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPRl9QT1BVTEFURUQpOw0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IFNvIHJlZ2lzdHJhdGlvbiBvZiB0aGlzIERUIGZpeGVkLWZhY3RvciBjbG9j
ayB3b3VsZCBmYWlsIGFzIHBhcmVudA0KPiA+ID4gPiA+ID4gd291bGQgYmUgTlVMTCBhcyBiZWxv
dyAoY2FsbGVkIGZyb20gX29mX2ZpeGVkX2ZhY3Rvcl9jbGtfc2V0dXAoKSk6DQo+ID4gPiA+ID4g
PiBwYXJlbnRfbmFtZSA9IG9mX2Nsa19nZXRfcGFyZW50X25hbWUobm9kZSwgMCk7DQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gT24gdGhlIG90aGVyIGhhbmQsIGV2ZW4gaWYgcmVnaXN0cmF0aW9u
IGZhaWxlZCwgdGhhdCBub2RlIHdpbGwgYmUNCj4gPiA+ID4gPiA+IG1hcmtlZCBhcyBPRl9QT1BV
TEFURUQsIHNvIHByb2JlIG9mIGNsay1maXhlZC1mYWN0b3IuYyB3aWxsIGFsc28gbm90DQo+ID4g
PiA+ID4gPiBiZSBjYWxsZWQgYW5kIHRoYXQgRFQgZml4ZWQtZmFjdG9yIGNsb2NrIHdvdWxkIG5l
dmVyIGJlIHJlZ2lzdGVyZWQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2FtZSB0aGluZyBp
cyBkaXNjdXNzZWQgYXQgIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE3LzYvNS82ODEgLg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gT2suIEkgYmVsaWV2ZSB0aGUgYW5zd2VyIGlzIHRvIGZpeCB0aGUg
RFQgdG8gZGVzY3JpYmUgdGhlIHBhcmVudCBjaGFpbg0KPiA+ID4gPiA+IHByb3Blcmx5IHdpdGgg
Y2xvY2stb3V0cHV0LW5hbWVzLiBPdGhlcndpc2UsIHdlIGhhdmUgbm8gZ29vZCB3YXkgb2YNCj4g
PiA+ID4gPiBmaWd1cmluZyBvdXQgd2hhdCB0aGUgbmFtZSBzaG91bGQgYmUuDQo+ID4gPiA+IFtS
YWphbl0gY2xvY2sgRFQgYmluZGluZyBkb2Mgc2F5cyB0aGF0IGNsb2NrLW91dHB1dC1uYW1lcyBw
cm9wZXJ0eQ0KPiA+ID4gPiBpcyBvcHRpb25hbCBhbmQgc29tZXRpbWVzIG5vdCByZWNvbW1lbmRl
ZC4NCj4gPiA+ID4gSSB0aGluayB0aGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSB3ZSBoYXZlIHdo
aWNoIG1hbmRhdGVzIHRvIGFkZCBjbG9jay0NCj4gPiBvdXRwdXQtDQo+ID4gPiA+IG5hbWVzDQo+
ID4gPiA+IHByb3BlcnR5IChmb3IgdGhpcyBwYXJ0aWN1bGFyIGNhc2UpLiBBbHNvLCBJSVVDIHBs
YXRmb3JtIGRyaXZlciBwcm9iZSBpbiBjbGstDQo+ID4gZml4ZWQtDQo+ID4gPiA+IGZhY3Rvci5j
DQo+ID4gPiA+IHdpbGwgbmV2ZXIgYmUgY2FsbGVkIHVubGVzcyB3ZSB1c2UgQ0xLX09GX0RFQ0xB
UkVfRFJJVkVSLg0KPiA+ID4gPiBJIGNvbXBsZXRlbHkgYWdyZWUgdGhhdCBwcm9wZXIgc29sdXRp
b24gd291bGQgYmUgdG8gc3RvcCB1c2luZyBzdHJpbmdzIHRvDQo+ID4gPiA+IGRlc2NyaWJlIGNs
b2NrIHRvcG9sb2d5Lg0KPiA+ID4gW1JhamFuXSBBbnkgY29tbWVudHMgb24gdGhpcz8NCj4gPiA+
IFVubGVzcyB3ZSBoYXZlIHByb3BlciBzb2x1dGlvbiByZWFkeSwgd2UgbmVlZCB0byBoYXZlIHNv
bWUgbWVjaGFuaXNtIHRvDQo+ID4gaGFuZGxlIHRoaXMgc2NlbmFyaW8uDQo+ID4gPiBjbG9jay1v
dXRwdXQtbmFtZXMgaXMgb3B0aW9uYWwgYW5kIHdpdGhvdXQgdGhpcywgaXQgbWFuZGF0ZXMgdG8g
dXNlIGNsb2NrLQ0KPiA+IG91dHB1dC1uYW1lcy4NCj4gPiA+DQo+ID4NCj4gPiBJIGNvdWxkbid0
IHJlYWQgeW91ciBvdXRsb29rIHNlbnQgZW1haWwgYW5kIEkgd2FzIHRvbyBidXN5IHRvIGdvDQo+
ID4gdHJhbnNsYXRlIGl0LiBTb21lIGJ1ZyBpbiBteSBNVUEgaXQgc2VlbXMuDQo+ID4NCj4gPiBD
YW4geW91IGFkZCB0aGUgb3V0cHV0LW5hbWVzIHByb3BlcnR5PyBJbiB0aGlzIGNhc2UgaXQncyBw
cmFjdGljYWxseQ0KPiA+IG1hbmRhdG9yeSwgc28gaWYgeW91IGNhbid0IGRvIGl0IEknZCBsaWtl
IHRvIGhlYXIgd2h5IG5vdC4NCj4gW1JhamFuXSBJbiBvdXIgY2FzZSwgd2UgYXJlIGZpcm13YXJl
IG1haW50YWlucyBjbG9jayBkYXRhYmFzZSBhbmQgZHJpdmVyIHF1ZXJ5DQo+IGNsb2Nrcw0KPiBm
cm9tIGZpcm13YXJlIGFuZCByZWdpc3RlcnMgY2xvY2sgYmFzZWQgb24gaW5mb3JtYXRpb24gcmVj
ZWl2ZWQgZnJvbQ0KPiBmaXJtd2FyZS4gU28NCj4gb3V0cHV0IGNsb2NrIG5hbWVzIGFyZSBub3Qg
Zml4ZWQuDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA0Mzk4OTMvIC0g
ZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQNCj4gYmluZGluZ3MgZm9yIFp5bnFNUCBjbG9jayBkcml2
ZXINCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDQzOTg5MS8gLSBkcml2
ZXJzOiBjbGs6IEFkZCBaeW5xTVANCj4gY2xvY2sgZHJpdmVyDQpbUmFqYW5dIEFueSBjb21tZW50
cz8NCg0K
