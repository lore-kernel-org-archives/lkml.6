Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="jhYDQUY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6184F60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932248AbeFFGgd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:36:33 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:9917 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932103AbeFFGga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:36:30 -0400
X-IronPort-AV: E=Sophos;i="5.49,482,1520866800";
   d="scan'208";a="281698661"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Frank Rowand <frowand.list@gmail.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
CC: Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>,
        "Chen-Yu Tsai" <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Topic: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Index: AQHT/MEwPjoauwcadUW/vfsUGOHwuqRR7WMAgADZHRA=
Date: Wed, 6 Jun 2018 06:36:24 +0000
Message-ID: <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
In-Reply-To: <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1878;7:92fxQXvdSjwc1Pg8gi94YXHt82D9my+VwMyEJWopXUmzgoFjopMD69eNHSloPBbNrzUKlMcihOy6xblBx2EFCvBWJBd+Ygyl4C9MQHf75s2N1MZhHnpCZZqnEVvAGRoTCxxGpToIA4360LZ6TZYh+nIGpnxqohFut45QDTGV5LYTNd9pwBFdj6Zx2/1cRm5v4vhIg5OPVG4U+RVtnMRcGlO+/XSVcP1HVnEopxypIrvzcKvSa+A0VYFVE4mNV/w9;20:VD0HMUYqE6sf4cNCl08AMVsBduJIL7C0G5klWgSPTG+v7oaFaXNqkuULTsXf4+DHWqCBrLNuf8ftIA1GJRC4P32Qy2ZLJyvuB2gg5dHVDF27443EWxri87vk6rQxXO6y3YhQQbjaSPcPUFTrWv46pjk0UvO7j7vLeLIvYeD7uWE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1878;
x-ms-traffictypediagnostic: OSBPR01MB1878:
x-microsoft-antispam-prvs: <OSBPR01MB1878D97E1BB4F9BEEE6058EED2650@OSBPR01MB1878.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB1878;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1878;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(8936002)(5250100002)(110136005)(44832011)(54906003)(316002)(99286004)(8656006)(2501003)(8676002)(106356001)(105586002)(81156014)(81166006)(9686003)(53936002)(229853002)(55016002)(7696005)(478600001)(6116002)(6436002)(26005)(3846002)(486006)(476003)(186003)(2900100001)(76176011)(86362001)(6246003)(6506007)(53546011)(446003)(66066001)(102836004)(11346002)(59450400001)(25786009)(7736002)(7416002)(68736007)(5660300001)(305945005)(3280700002)(97736004)(74316002)(2906002)(14454004)(3660700001)(4326008)(39060400002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1878;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam-message-info: aEyhuLkOCtJH1+xGwM9pUpKV8bmLHakDiYtMCQ6S1e/p2a75IBp4KXgOZLCKuVxhDs8ZIh9eCDUB+NeZog3PpGX0NPNJHnYpxltB8N1KCVsItFX2ZWjFS5teABSeeYkNkYr0eYksNq416gZDK8fWaimzh2Uy6UVBlyBnX6OcyphUVS4KLRTa3VVIsGt+imgp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 43403403-69fc-4f65-259c-08d5cb77d33e
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43403403-69fc-4f65-259c-08d5cb77d33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 06:36:24.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1878
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJhbmssDQoNCk9uIDA1IEp1bmUgMjAxOCAxODozNCwgRnJhbmsgd3JvdGU6DQo+IE9uIDA2
LzA1LzE4IDA0OjI4LCBNaWNoZWwgUG9sbGV0IHdyb3RlOg0KPiA+IFRoZSBSZW5lc2FzIFI5QTA2
RzAzMiBzZWNvbmQgQ0E3IGlzIHBhcmtlZCBpbiBhIFJPTSBwZW4gYXQgYm9vdCB0aW1lLA0KPiA+
IGl0IHJlcXVpcmVzIGEgc3BlY2lhbCBlbmFibGUgbWV0aG9kIHRvIGdldCBpdCBzdGFydGVkLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWljaGVsIFBvbGxldCA8bWljaGVsLnBvbGxldEBicC5y
ZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9NYWtlZmls
ZSAgICAgICAgfCAgMSArDQo+ID4gIGFyY2gvYXJtL21hY2gtc2htb2JpbGUvc21wLXI5YTA2ZzAz
Mi5jIHwgNzkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9zbXAtcjlhMDZnMDMyLmMNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLXNobW9iaWxlL01ha2VmaWxlDQo+ID4gYi9hcmNoL2FybS9tYWNo
LXNobW9iaWxlL01ha2VmaWxlIGluZGV4IDE5MzlmNTIuLmQ3ZmM5OGYgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9NYWtlZmlsZQ0KPiA+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtc2htb2JpbGUvTWFrZWZpbGUNCj4gPiBAQCAtMzQsNiArMzQsNyBAQCBzbXAtJChDT05GSUdf
QVJDSF9TSDczQTApKz0gc21wLXNoNzNhMC5vDQo+IGhlYWRzbXAtc2N1Lm8gcGxhdHNtcC1zY3Uu
bw0KPiA+ICBzbXAtJChDT05GSUdfQVJDSF9SOEE3Nzc5KSs9IHNtcC1yOGE3Nzc5Lm8gaGVhZHNt
cC1zY3Uubw0KPiBwbGF0c21wLXNjdS5vDQo+ID4gIHNtcC0kKENPTkZJR19BUkNIX1I4QTc3OTAp
Kz0gc21wLXI4YTc3OTAubw0KPiA+ICBzbXAtJChDT05GSUdfQVJDSF9SOEE3NzkxKSs9IHNtcC1y
OGE3NzkxLm8NCj4gPiArc21wLSQoQ09ORklHX0FSQ0hfUjlBMDZHMDMyKSs9IHNtcC1yOWEwNmcw
MzIubw0KPiA+ICBzbXAtJChDT05GSUdfQVJDSF9FTUVWMikrPSBzbXAtZW1ldjIubyBoZWFkc21w
LXNjdS5vDQo+IHBsYXRzbXAtc2N1Lm8NCj4gPg0KPiA+ICAjIFBNIG9iamVjdHMNCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9zbXAtcjlhMDZnMDMyLmMNCj4gPiBiL2Fy
Y2gvYXJtL21hY2gtc2htb2JpbGUvc21wLXI5YTA2ZzAzMi5jDQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5jZDQwZTZlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL2FyY2gvYXJtL21hY2gtc2htb2JpbGUvc21wLXI5YTA2ZzAzMi5jDQo+ID4gQEAgLTAs
MCArMSw3OSBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+
ICsvKg0KPiA+ICsgKiBSOUEwNkcwMzIgU2Vjb25kIENBNyBlbmFibGVyLg0KPiA+ICsgKg0KPiA+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTGltaXRl
ZA0KPiA+ICsgKg0KPiA+ICsgKiBNaWNoZWwgUG9sbGV0IDxtaWNoZWwucG9sbGV0QGJwLnJlbmVz
YXMuY29tPiwNCj4gPGJ1c2Vycm9yQGdtYWlsLmNvbT4NCj4gPiArICogRGVyaXZlZCBmcm9tIGFj
dGlvbixzNTAwLXNtcA0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pby5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2Fk
ZHJlc3MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NtcC5oPg0KPiA+ICsNCj4gPiArLyoNCj4g
PiArICogVGhlIHNlY29uZCBDUFUgaXMgcGFya2VkIGluIFJPTSBhdCBib290IHRpbWUuIEl0IHJl
cXVpcmVzIHdha2luZw0KPiA+ICtpdCBhZnRlcg0KPiA+ICsgKiB3cml0aW5nIGFuIGFkZHJlc3Mg
aW50byB0aGUgQk9PVEFERFIgcmVnaXN0ZXIgb2Ygc3lzY3RybC4NCj4gPiArICoNCj4gPiArICog
U28gdGhlIGRlZmF1bHQgdmFsdWUgb2YgdGhlICJjcHUtcmVsZWFzZS1hZGRyIiBjb3JyZXNwb25k
cyB0bw0KPiBCT09UQUREUi4uLg0KPiA+ICsgKg0KPiA+ICsgKiAqSG93ZXZlciogdGhlIEJPT1RB
RERSIHJlZ2lzdGVyIGlzIG5vdCBhdmFpbGFibGUgd2hlbiB0aGUga2VybmVsDQo+ID4gKyAqIHN0
YXJ0cyBpbiBOT05TRUMgbW9kZS4NCj4gPiArICoNCj4gPiArICogU28gZm9yIE5PTlNFQyBtb2Rl
LCB0aGUgYm9vdGxvYWRlciByZS1wYXJrcyB0aGUgc2Vjb25kIENQVSBpbnRvIGENCj4gPiArcGVu
DQo+ID4gKyAqIGluIFNSQU0sIGFuZCBjaGFuZ2VzIHRoZSAiY3B1LXJlbGVhc2UtYWRkciIgb2Yg
bGludXgncyBEVCB0byBhDQo+ID4gK1NSQU0gYWRkcmVzcywNCj4gPiArICogd2hpY2ggaXMgbm90
IHJlc3RyaWN0ZWQuDQo+DQo+IFRoZSBiaW5kaW5nIGRvY3VtZW50IGZvciBjcHUtcmVsZWFzZS1h
ZGRyIGRvZXMgbm90IGhhdmUgYSBkZWZpbml0aW9uIGZvciAzMg0KPiBiaXQgYXJtLiAgVGhlIGV4
aXN0aW5nIGRlZmluaXRpb24gaXMgb25seSA2NCBiaXQgYXJtLiAgUGxlYXNlIGFkZCB0aGUgZGVm
aW5pdGlvbg0KPiBmb3IgMzIgYml0IGFybSB0byBwYXRjaCAxLg0KDQpIbW1tIEkgZG8gZmluZCBh
IGRlZmluaXRpb24gaW4NCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1
cy50eHQgLS0ganVzdCB1bmRlciB3aGVyZSBJDQphZGRlZCBteSAnZW5hYmxlLW1ldGhvZCcgLS0g
QW5kIGl0IGlzIGFscmVhZHkgdXNlZCBhcyAzMiBiaXRzIGluIGF0IGxlYXN0DQphcmNoL2FybS9i
b290L2R0cy9zdGloNDA3LWZhbWlseS5kdHNpLg0KDQpXaGF0IGRvIHlvdSB3YW50IG1lIHRvIGFk
ZCB0byB0aGlzIGV4YWN0bHk/IERvIHlvdSB3YW50IG1lIHRvIGp1c3QNCmNoYW5nZSAicmVxdWly
ZWQgZm9yIHN5c3RlbXMgdGhhdCBoYXZlIGFuICJlbmFibGUtbWV0aG9kIiBwcm9wZXJ0eQ0KdmFs
dWUgb2YgInNwaW4tdGFibGUiIHRvIGFsc28gc3BlY2lmeSByZW5lc2FzLHI5YTA2ZzAzMiA/DQoN
ClRoYW5rcyENCk1pY2hlbA0KDQo+DQo+IC1GcmFuaw0KPg0KPg0KPiA+ICsgKi8NCj4gPiArDQo+
ID4gK3N0YXRpYyB2b2lkIF9faW9tZW0gKmNwdV9ib290YWRkcjsNCj4gPiArDQo+ID4gK3N0YXRp
YyBERUZJTkVfU1BJTkxPQ0soY3B1X2xvY2spOw0KPiA+ICsNCj4gPiArc3RhdGljIGludCByOWEw
NmcwMzJfc21wX2Jvb3Rfc2Vjb25kYXJ5KHVuc2lnbmVkIGludCBjcHUsIHN0cnVjdA0KPiA+ICt0
YXNrX3N0cnVjdCAqaWRsZSkgew0KPiA+ICtpZiAoIWNwdV9ib290YWRkcikNCj4gPiArcmV0dXJu
IC1FTk9ERVY7DQo+ID4gKw0KPiA+ICtzcGluX2xvY2soJmNwdV9sb2NrKTsNCj4gPiArDQo+ID4g
K3dyaXRlbChfX3BhX3N5bWJvbChzZWNvbmRhcnlfc3RhcnR1cCksIGNwdV9ib290YWRkcik7DQo+
ID4gK2FyY2hfc2VuZF93YWtldXBfaXBpX21hc2soY3B1bWFza19vZihjcHUpKTsNCj4gPiArDQo+
ID4gK3NwaW5fdW5sb2NrKCZjcHVfbG9jayk7DQo+ID4gKw0KPiA+ICtyZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgX19pbml0IHI5YTA2ZzAzMl9zbXBfcHJlcGFyZV9j
cHVzKHVuc2lnbmVkIGludCBtYXhfY3B1cykNCj4gPiArew0KPiA+ICtzdHJ1Y3QgZGV2aWNlX25v
ZGUgKmRuOw0KPiA+ICtpbnQgcmV0Ow0KPiA+ICt1MzIgYm9vdGFkZHI7DQo+ID4gKw0KPiA+ICtk
biA9IG9mX2dldF9jcHVfbm9kZSgxLCBOVUxMKTsNCj4gPiAraWYgKCFkbikgew0KPiA+ICtwcl9l
cnIoIkNQVSMxOiBtaXNzaW5nIGRldmljZSB0cmVlIG5vZGVcbiIpOw0KPiA+ICtyZXR1cm47DQo+
ID4gK30NCj4gPiArLyoNCj4gPiArICogRGV0ZXJtaW5lIHRoZSBhZGRyZXNzIGZyb20gd2hpY2gg
dGhlIENQVSBpcyBwb2xsaW5nLg0KPiA+ICsgKiBUaGUgYm9vdGxvYWRlciAqZG9lcyogY2hhbmdl
IHRoaXMgcHJvcGVydHkNCj4gPiArICovDQo+ID4gK3JldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMy
KGRuLCAiY3B1LXJlbGVhc2UtYWRkciIsICZib290YWRkcik7DQo+ID4gK29mX25vZGVfcHV0KGRu
KTsNCj4gPiAraWYgKHJldCkgew0KPiA+ICtwcl9lcnIoIkNQVSMxOiBpbnZhbGlkIGNwdS1yZWxl
YXNlLWFkZHIgcHJvcGVydHlcbiIpOw0KPiA+ICtyZXR1cm47DQo+ID4gK30NCj4gPiArcHJfaW5m
bygiQ1BVIzE6IGNwdS1yZWxlYXNlLWFkZHIgJTA4eFxuIiwgYm9vdGFkZHIpOw0KPiA+ICsNCj4g
PiArY3B1X2Jvb3RhZGRyID0gaW9yZW1hcChib290YWRkciwgc2l6ZW9mKGJvb3RhZGRyKSk7IH0N
Cj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc21wX29wZXJhdGlvbnMgcjlhMDZnMDMy
X3NtcF9vcHMgX19pbml0Y29uc3QgPSB7DQo+ID4gKy5zbXBfcHJlcGFyZV9jcHVzID0gcjlhMDZn
MDMyX3NtcF9wcmVwYXJlX2NwdXMsDQo+ID4gKy5zbXBfYm9vdF9zZWNvbmRhcnkgPSByOWEwNmcw
MzJfc21wX2Jvb3Rfc2Vjb25kYXJ5LCB9Ow0KPiA+ICtDUFVfTUVUSE9EX09GX0RFQ0xBUkUocjlh
MDZnMDMyX3NtcCwgInJlbmVzYXMscjlhMDZnMDMyLXNtcCIsDQo+ID4gKyZyOWEwNmcwMzJfc21w
X29wcyk7DQo+ID4NCg0KDQoNCg0KUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTHRkLCBEdWtl
cyBNZWFkb3csIE1pbGxib2FyZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNraW5naGFtc2hpcmUsIFNM
OCA1RkgsIFVLLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1bmRlciBSZWdpc3RlcmVk
IE5vLiAwNDU4NjcwOS4NCg==
