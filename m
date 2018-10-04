Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E92C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF28720877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S+xSnFQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF28720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeJEEVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:21:39 -0400
Received: from mail-eopbgr710053.outbound.protection.outlook.com ([40.107.71.53]:26969
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeJEEVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg2CejoI4Bhlx6LUk9vAd8DfjN1pNDqtGM/+fyU6mYU=;
 b=S+xSnFQZmTfpuyXA1qFMxj+7p+ksevwMd6v8M2MGlqyijXUEhTtaH7gXjOxZFzuRCDVOXV+471RTe+RlyJYFA2Pwr3gZ3W4Lvx7Me5S9ajEeYasu8t5erUoxIavHj7enWexcYemuixiV4+9hVk0VxZhRmJ6Vb/rJQi9bbymqIR4=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1690.namprd02.prod.outlook.com (10.162.161.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 21:26:03 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::c4f3:b29:b8f4:c335]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::c4f3:b29:b8f4:c335%3]) with mapi id 15.20.1207.021; Thu, 4 Oct 2018
 21:26:02 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
 bindings
Thread-Topic: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
 bindings
Thread-Index: AQHUNZZmk8R+8nI1IUOvMk0TistbVaTJEcsAgCWWaUCAEsJwAIAOe7nw
Date:   Thu, 4 Oct 2018 21:26:02 +0000
Message-ID: <CY1PR02MB21389329CFE7985FD31179ADB8EA0@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
 <1534447304-12919-2-git-send-email-jollys@xilinx.com>
 <20180820194628.GA26783@bogus>
 <CY1PR02MB2138C05E97C1EFAEA921CB5CB81A0@CY1PR02MB2138.namprd02.prod.outlook.com>
 <CAL_JsqJOz_z9dHcG5dfx=UTXQMaLTQKBPu+vTrTOt=sdAabqSw@mail.gmail.com>
In-Reply-To: <CAL_JsqJOz_z9dHcG5dfx=UTXQMaLTQKBPu+vTrTOt=sdAabqSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1690;6:zWAfBlZnxeM7nlFWKTnT4JDB9f6EpJX0D9ymbsxQ9sO+NI6V6kGUwmuF7flq11hg3IXUNOzwWSvwfoqhtPtdnLNLfPwuBNCIHe7Q4wvGsDbmt5fEH+dIbs6mwiG3amtZIAH6L+h0gtGDu+rfm9QLjzWwR5L9PqZ57iGY3s3pNHSplKEsNhyIgm7XaPEieJuThYza6UaESJ5qBi2/bE357LCyUc775QNTLPa1N+JkTXNoXSn3jEEOEksW+wUph7iScuGE7PZH398bUM85CCDo+LidQQRIkSPZNHN6/nUkNOO/2iwDZQWE2DYRMrX539/6E3O9COicEg4oJyOAdOfteicJxMFNYD6+k+QPMH1l8o28UgLV+1eHpeHkgeV0LqQdF8DZmvHuXrqb2XFEFfYmFMLeqxBp9G04nV3c9XmgR9WYDpE5f34l6FvzvPKKubYcoKqtiDQ8B/ai3/pZ5e8fxA==;5:mTg/QqtxEPk8b9h98YLJ3Y00J9jpH/T/lIod7fwuyYoT7qGIGRrn3UtofM2TkDrkJJd48fl0bQNprhviba0yhNM/+ohZJyuAP6Akkm5mYoi+dJqhhwYVrNoyTtd7bNuniO8vPs5aebVH1PKs9hmm2qVQwuX/sz+AMdm/MCq22OY=;7:rcTO90Ci+6SAZ8nCt+A+E9s70lUJTCfxSonOXpqNqP7sKIQgnPU34CcowIAdjMKjdSNzG1WTBGC64jEfwlKagU7DR9ljWKNfmijsdjovC4sPdWnTXFAjmBWGhRaBngweeGtJL+yuP51djJ7Nh4x+cQpzn/xCOP5VNKf83Fq7zH/XbxAOGEhM360Q9C8lUdifgiYVwLbKRtXKRmNVp8qzibIe3HY9ibyit8eFE/NbsDC34ItCrjoga6oDDtNn3EJe
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(13464003)(199004)(189003)(97736004)(186003)(305945005)(5660300001)(486006)(476003)(446003)(86362001)(11346002)(14454004)(229853002)(7696005)(68736007)(6506007)(81156014)(93886005)(99286004)(53546011)(81166006)(105586002)(8676002)(72206003)(106356001)(7736002)(54906003)(76176011)(71200400001)(2906002)(71190400001)(6436002)(55016002)(25786009)(7416002)(102836004)(6116002)(6916009)(2900100001)(4326008)(3846002)(74316002)(33656002)(498600001)(256004)(8936002)(5250100002)(6246003)(26005)(66066001)(9686003)(53936002)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1690;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: a7ad231e-51d2-4f7c-803f-08d62a3ffc59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1690;
x-ms-traffictypediagnostic: CY1PR02MB1690:
x-microsoft-antispam-prvs: <CY1PR02MB1690F982F5069AF84E8A3D7CB8EA0@CY1PR02MB1690.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(9452136761055)(258649278758335)(85827821059158)(7411616537696)(180628864354917)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201703061421075)(201703161042150)(20161123562045)(20161123560045)(6042181)(201708071742011)(7699051);SRVR:CY1PR02MB1690;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1690;
x-forefront-prvs: 0815F8251E
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 30gErutVi9GnWv9KpfeuArMd1gP05Es6NgehIXE3OO7SBwc39rqoLI1ydDijQWeSQBN1k2ILJSnMPpEhZ8bUT4PJ80rGU8XbrzESeDpLoG2B3PrBzAdaqF6PEw3/EO1iq5YYVK9OR/weHFRDH9G5EVy3hteR7UbRHDOhJOcbkijSNXK+0wPJREm/8D4grlk+ZaFNvo0Nj2EI4/JVnFBN9RViNffn71Tol9SvaLQJCz1QbGmSvV4rYLXoTj05rKkY+tLUCuwk/c1mnRNxrDHbsA8l927ATGuYqJZex6yJxbhQGGwpmXU3jE/0pl15qioKo6slSdfJDrRETix8PimHH6iuq4sTUjn481Y3gGPpIcI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ad231e-51d2-4f7c-803f-08d62a3ffc59
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 21:26:02.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIg
MjUsIDIwMTggOToxNSBBTQ0KPiBUbzogSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+DQo+
IENjOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPjsgQW5keSBHcm9z
cw0KPiA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgR2VlcnQNCj4gVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IEJq
b3JuIEFuZGVyc3Nvbg0KPiA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+OyBTZWFuIFdhbmcg
PHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+Ow0KPiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dz
a2lAc2Ftc3VuZy5jb20+OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT47IE1h
cmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBSYWphbiBWYWphDQo+IDxSQUpBTlZA
eGlsaW54LmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBtb2RlcmF0ZWQNCj4gbGlz
dDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0tDQo+
IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQg
WnlucU1QIHBvd2VyIGRvbWFpbg0KPiBiaW5kaW5ncw0KPiANCj4gT24gVGh1LCBTZXAgMTMsIDIw
MTggYXQgMTI6NTEgUE0gSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gSGkgUm9iLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+ID4gPiBTZW50
OiBNb25kYXksIEF1Z3VzdCAyMCwgMjAxOCAxMjo0NiBQTQ0KPiA+ID4gVG86IEpvbGx5IFNoYWgg
PEpPTExZU0B4aWxpbnguY29tPg0KPiA+ID4gQ2M6IG1hdHRoaWFzLmJnZ0BnbWFpbC5jb207IGFu
ZHkuZ3Jvc3NAbGluYXJvLm9yZzsNCj4gPiA+IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gPiBn
ZWVydCtyZW5lc2FzQGdsaWRlci5iZTsgYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7DQo+ID4g
PiBzZWFuLndhbmdAbWVkaWF0ZWsuY29tOyBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207IE1pY2hh
bCBTaW1law0KPiA+ID4gPG1pY2hhbHNAeGlsaW54LmNvbT47IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBSYWphbiBWYWphDQo+ID4gPiA8UkFKQU5WQHhpbGlueC5jb20+OyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiA+ID4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFJhamFuIFZhamENCj4gPiA+IDxSQUpBTlZA
eGlsaW54LmNvbT47IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29tPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAxLzNdIGR0LWJpbmRpbmdzOiBwb3dlcjogQWRkIFp5bnFNUCBwb3dl
cg0KPiA+ID4gZG9tYWluIGJpbmRpbmdzDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBBdWcgMTYsIDIw
MTggYXQgMTI6MjE6NDJQTSAtMDcwMCwgSm9sbHkgU2hhaCB3cm90ZToNCj4gPiA+ID4gRnJvbTog
UmFqYW4gVmFqYSA8cmFqYW4udmFqYUB4aWxpbnguY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQg
ZG9jdW1lbnRhdGlvbiB0byBkZXNjcmliZSBaeW5xTVAgcG93ZXIgZG9tYWluIGJpbmRpbmdzLg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSYWphbiBWYWphIDxyYWphbi52YWphQHhp
bGlueC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvbGx5IFNoYWggPGpvbGx5c0B4aWxp
bnguY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9maXJtd2FyZS94aWxpbngveGxueCx6
eW5xbXAtZmlybXdhcmUudHh0ICAgICAgIHwgNDcNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysr
KysNCj4gPiA+DQo+ID4gPiBUaGlzIHNob3VsZCBiZSB3aXRoIGFsbCB0aGUgb3RoZXIgcG93ZXIg
ZG9tYWluIGJpbmRpbmdzLg0KPiA+ID4NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNl
cnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUveGlsaW54L3hsbngsenlucW1wLWZp
DQo+ID4gPiA+IHJtd2ENCj4gPiA+ID4gcmUudHh0DQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC1maQ0KPiA+ID4g
PiBybXdhDQo+ID4gPiA+IHJlLnR4dA0KPiA+ID4gPiBpbmRleCBkMjE1ZDE1Li41ZmExMGEwIDEw
MDY0NA0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZmlybXdhcmUveGlsaW54L3hsbngsenlucW1wLWZpDQo+ID4gPiA+IHJtd2ENCj4gPiA+
ID4gcmUudHh0DQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9maXJtd2FyZS94aWxpbngveGxueCx6eW5xbQ0KPiA+ID4gPiArKysgcC1maQ0KPiA+ID4gPiAr
Kysgcm13YXJlLnR4dA0KPiA+ID4gPiBAQCAtNjQsNiArNjQsMjkgQEAgT3V0cHV0IGNsb2NrcyBh
cmUgcmVnaXN0ZXJlZCBiYXNlZCBvbiBjbG9jaw0KPiA+ID4gPiBpbmZvcm1hdGlvbiByZWNlaXZl
ZCAgZnJvbSBmaXJtd2FyZS4gT3V0cHV0IGNsb2NrcyBpbmRleGVzIGFyZQ0KPiA+ID4gPiBtZW50
aW9uZWQgaW4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sveGxueCx6eW5xbXAtY2xrLmguDQo+
ID4gPiA+DQo+ID4gPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiArRGV2aWNlIFRyZWUgQmluZGluZ3MgZm9yIHRo
ZSBYaWxpbnggWnlucSBNUFNvQyBQTSBkb21haW5zDQo+ID4gPiA+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiArVGhl
IGJpbmRpbmcgZm9yIHp5bnFtcC1wb3dlci1jb250cm9sbGVyIGZvbGxvdyB0aGUgY29tbW9uIGdl
bmVyaWMNCj4gPiA+ID4gK1BNIGRvbWFpbiBiaW5kaW5nWzFdLg0KPiA+ID4gPiArDQo+ID4gPiA+
ICtbMV0gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Bvd2VyX2RvbWFp
bi50eHQNCj4gPiA+ID4gKw0KPiA+ID4gPiArPT0gWnlucSBNUFNvQyBHZW5lcmljIFBNIERvbWFp
biBOb2RlID09DQo+ID4gPiA+ICsNCj4gPiA+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4g
PiA+ICsgLSBjb21wYXRpYmxlOiAgICAgTXVzdCBiZTogInhsbngsenlucW1wLXBvd2VyLWNvbnRy
b2xsZXIiDQo+ID4gPiA+ICsNCj4gPiA+ID4gK1RoaXMgbm9kZSBjb250YWlucyBhIG51bWJlciBv
ZiBzdWJub2RlcywgZWFjaCByZXByZXNlbnRpbmcgYQ0KPiA+ID4gPiArc2luZ2xlIFBNIGRvbWFp
biB0aGF0IFBNIGRvbWFpbiBjb25zdW1lciBkZXZpY2VzIHJlZmVyZW5jZS4NCj4gPiA+ID4gKw0K
PiA+ID4gPiArPT0gUE0gRG9tYWluIE5vZGVzID09DQo+ID4gPiA+ICsNCj4gPiA+ID4gK1JlcXVp
cmVkIHByb3BlcnRpZXM6DQo+ID4gPiA+ICsgLSAjcG93ZXItZG9tYWluLWNlbGxzOiAgICBOdW1i
ZXIgb2YgY2VsbHMgaW4gYSBQTSBkb21haW4gc3BlY2lmaWVyLiBNdXN0DQo+ID4gPiBiZSAwLg0K
PiA+ID4gPiArIC0gcGQtaWQ6ICAgICAgICAgIERvbWFpbiBpZGVudGlmaWVyIGFzIGRlZmluZWQg
YnkgcGxhdGZvcm0gZmlybXdhcmUuDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgVGhpcyBp
ZGVudGlmaWVyIGlzIHBhc3NlZCB0byB0aGUgUE0gZmlybXdhcmUuDQo+ID4gPg0KPiA+ID4gTWFr
ZSB0aGlzIGEgY2VsbCBmb3IgdGhlIHBvd2VyIGRvbWFpbiBjb25zdW1lci4NCj4gPiBbSm9sbHld
IFdlIGhhdmUgbW9yZSB0aGFuIG9uZSBJZHMgZm9yIEdQVSBkZXZpY2UuIEFsc28gdGhleSBkb24n
dCBoYXZlDQo+ID4gcGFyZW50IGNoaWxkIHJlbGF0aW9uc2hpcCBhbmQgaGVuY2UgYXJlIGRlZmlu
ZWQgYXMgZmxhdCBoaWVyYXJjaHkuDQo+ID4gKHNob3duIGluIGV4YW1wbGUgYmVsb3cpDQo+IA0K
PiBUaGVuIHRoZSBncHUgbm9kZSBzaG91bGQgaGF2ZToNCj4gDQo+IHBvd2VyLWRvbWFpbnMgPSA8
JnBkIDU4ICZwZCAyMCAmcGQgMjE+Ow0KPiANCj4gQWxzbywgZm9yIHRoaXMgYW5kIHRoZSBmaXJt
d2FyZSByZXNldCBiaW5kaW5nLCB0aGVyZSBpcyBubyByZWFzb24gdGhhdCBJIHNlZSB0bw0KPiBt
YWtlIHRoZXNlIGFsbCBzdWJub2Rlcy4gQSBzaW5nbGUgZmlybXdhcmUgbm9kZSBjYW4gYmUgYSBw
cm92aWRlciBvZiBtdWx0aXBsZQ0KPiBmdW5jdGlvbnMuIFlvdSBvbmx5IG5lZWQgY2hpbGQgbm9k
ZXMgaWYgdGhlIHN1Yi1mdW5jdGlvbnMgaGF2ZSB0aGVpciBvd24NCj4gcmVzb3VyY2VzIChjbGtz
LCBpcnFzLCBldGMuKS4gSU9XLCBkb24ndCBjcmVhdGUgbm9kZXMganVzdCBiZWNhdXNlIHlvdSB3
YW50IHRvDQo+IGluc3RhbnRpYXRlIGRyaXZlcnMgdGhhdCB3YXkuIERUIGlzIG5vdCB0aGUgb25s
eSB3YXkgdG8gaW5zdGFudGlhdGUgZGV2aWNlcyBmb3INCj4gZHJpdmVycy4NCj4gDQoNCkdvdCBp
dC4gUHVzaGVkIHYzIHdpdGggc3VnZ2VzdGVkIGNoYW5nZXMuIFBsZWFzZSByZXZpZXcuDQoNCj4g
Um9iDQo=
